Return-Path: <linux-kernel+bounces-889915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE91C3ED34
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2C9334BCBA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBE230E84E;
	Fri,  7 Nov 2025 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqmsZeXn"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396E2D063C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502056; cv=none; b=c0aqLFUmnazslj2le8iuq4U960Nn6OZGpuFnFHiXje4gDwmKbpKDvmT/g0Bm9nXpzlgp0I8WPEkJ4h/smhMPqNVd/s1KBInTieEAIdOlb7FVf33Dz1jFSjmnPKXwqYro8VNq1KpxC3BIpf1MoMF25GsHyhENuVghc+D7iErw+OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502056; c=relaxed/simple;
	bh=hht2khT+M/paWxzoLF4glbCzxzDG6WfHD/Jh8JDmVm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWKVbCDOLphrnnPOTaN+bZEQOsJy/PR2+vNOP8jv1j620hj2vMNwOlWJZB6IH5DcYqeCyvOmlyJd2NDzIIVA5X9i7jPH2C+knZ/wB6vo7KJ+wLSU41f4zta9mUu6X7NvXhrn+84OZX8tLdM3orfJDsX5Rmd5VlNltPY347F30bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqmsZeXn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso442750b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502054; x=1763106854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hht2khT+M/paWxzoLF4glbCzxzDG6WfHD/Jh8JDmVm8=;
        b=dqmsZeXnah3owgv9LU0TB/AZDmVzNCwm1AATRL8aG2Rur5PLhtJZ3sQkQl0W2DfAWy
         71EPUf/DQ9ddYGflNciTusRdjd03tZ7fRBfVIvnyhQyiGsR2cnUMqp2RGzbbzKlKSXjq
         Sm4CKgtEdn0iDEiW7E5oTc1i5PMgPvJzSewDHDRggUgpaymPyYz7695a/VzZrA7r719M
         KghSiL10cU++5uhit8q2wd2pEQCOqGNI0JgCiHScV9+OntAuJU+/DZpLgNPzpHKmDtJE
         uaVLMAEl9BQeiVi9wc+R9/PkymLZpCiz4auNfP64Q26UaovpfmX3Y4iFvK2Lm9x43r2m
         xgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502054; x=1763106854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hht2khT+M/paWxzoLF4glbCzxzDG6WfHD/Jh8JDmVm8=;
        b=esFOl8pfKLU3Gp7hPP2mmjG75lzEaJ6H0EBirxFsoJvtwSQi7AiKMqZ/9+ypCEfSjj
         Z2qEubHGw5AOk9AiVXhIPW76CYPew5HhQpITL925mjoFQBDRIJSEyEl7kftnlOsVMsxL
         w0/mU/n3KLRz/zPsWZhK1kL/8F++nrSpxt5Sk2x7hMf/Cv9cKaiS6KViojKqy4up03bE
         RD1iQpvrnIao1u2KpmTgK0EsOc0PCsfaUCYvMg4WHvHC7YpBSBzBIt6FDhQDxQ6s6Vuy
         Pmi8vkbrSleXrcEj3uiRP0nzQpI+B2tqA+4bmaYCqcbzfvUGkQP7qp/+D3IytbfLu6mz
         15Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXFj3OyKmKvToWhvDAteFAlrLPQSOvY5nR1AzlERSfddBsvCIbEUNhzh9IIcziyYdAxaDbhttQS2579u3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzljorv0bcf0x7X8Ubvjta1q/QLbQw8qtiKrNWgK1ivMM+tRMv2
	bMAK7rG0lTOSAo1ejiG233LAM4lXW2sMhOLcwqiztvKrLbSe4qH8iQz6MrbmHRI4lx3vXL5YO7N
	2+fnNbmcaEV41wJoZpSkgsswf5ghhCEc=
X-Gm-Gg: ASbGncvhJYaT9Wm4mjuXA3w3aBuprDo/o5LGyVaJdptFf3LvzEzerbHhHX8Heum+H6z
	n4N48VPE3UGUIEYQ9nQllWMcqZl9xaB+dbyoTz5p0dA53HXPS45nmFgeXwBA7s8T6D7eTrAQdrV
	00VJU1FIgIo0p0gcqFWCTSobflLxXh0Bpi57Y3MJJvQ5AQK+y32stdQiUcyDAZNNBYxcxhi4Tun
	0ASlX60YlLWp+Fe0looXFN1ArxywwA6aYd1DEKnEyMCrQ8l9gVHjd/zdw==
X-Google-Smtp-Source: AGHT+IHL0mKF9QQYctg7K2SDNNvhbCsy5jQOa37KMcgcdBvRiNDOg88v8nsypzK+cTSQzbs7MXiMalVatyoMujxAM6A=
X-Received: by 2002:a05:6a20:914f:b0:334:8e2e:2c55 with SMTP id
 adf61e73a8af0-35228572ba4mr3084918637.18.1762502054278; Thu, 06 Nov 2025
 23:54:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031-imx95-rproc-2025-10-31-v2-0-758b2e547a55@nxp.com> <20251031-imx95-rproc-2025-10-31-v2-3-758b2e547a55@nxp.com>
In-Reply-To: <20251031-imx95-rproc-2025-10-31-v2-3-758b2e547a55@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 7 Nov 2025 09:56:40 +0200
X-Gm-Features: AWmQ_bldmBxOD-3eNLQss-begsdemT3T5zDmdImzkOkUALSL6znnWYvoGByIzsQ
Message-ID: <CAEnQRZB4szsOxtP2QmRdpwR+ZJ+8ydGg8hGAo5DqHC=tw23M8A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] remoteproc: imx_rproc: Introduce prepare ops for imx_rproc_dcfg
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Frank Li <frank.li@nxp.com>, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 4:28=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> Allow each platform to provide its own prepare operations, preparing
> for i.MX95 LMM and CPU ops support.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

