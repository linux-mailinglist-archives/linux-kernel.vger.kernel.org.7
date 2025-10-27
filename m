Return-Path: <linux-kernel+bounces-871313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C367CC0CE19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F8818830B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0417E2F1FD5;
	Mon, 27 Oct 2025 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fiy4qYUo"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251112E0406
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559593; cv=none; b=LuAS/fcqjqAPWlvLWLLhLAVgF6sf/n1eI792WXiZNPHMQN2OZfmUt1dxohLcMp61C+JL4g2q6QGPaACeQ2kRNZne2cDjJKKgqXtv5AescnRp9mqdUadPcWFahmvJx7IeeNSppUNVquz2nuMFP2LW3Y5zD44CEm33Q+FcbO3YxS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559593; c=relaxed/simple;
	bh=l5doOeAnSYSQI+MnlDBwnrzy87dYaAS/wZNmV4aDiaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WY2Ts/R4PcIZrr8vLcgZB/WMi4uixEfrd/S4+Y/p8H0JjNVdrY+LSsUMDtbFfinwlmCLYAzCYGZ3r/j4PnH84VqM3jftNK71MmLpFOLpVnVNPfqjYpCed2/s5/eAOn6vibfKNJiQW222Kq2Z/RFPe/5oxKCkadAM64Yb00Z7ClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fiy4qYUo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-78af743c232so3971477b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761559591; x=1762164391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5doOeAnSYSQI+MnlDBwnrzy87dYaAS/wZNmV4aDiaM=;
        b=Fiy4qYUoqhss1pi1BHikADkw0/OpvYvCrQutHG51Z0wIRRtAaZ1frbYR1pweve48vx
         0kA+jJX/cVWYcaFb/tEcHIJNGA55MH281XkHq+Kutgau1YkngkwdHnFOD2FuLFB/vAUU
         efXMXVWssGu7ZwRx0oTapHCA84iME1JhQZZ+KFM8GKFJ451lQD/chOO3+7P1+BosiBuk
         N+cRZgFsRQPcGsgBAtQUE5QfbDrPGZmy4enX8fE30NGL+i+Jql1Ny5nzZ491vIWvQfVk
         cDCLPOcJ3zk2AEufkmNe1Z4Y8/rth1Wri54ndffn61xfR+oV6GEP3VjN7GPUaHYrsNTN
         fmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761559591; x=1762164391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5doOeAnSYSQI+MnlDBwnrzy87dYaAS/wZNmV4aDiaM=;
        b=Fyvm301aHEbFjI56dAIIpclvMO2kfZ/+jXO4Cz7B4WhPdgb76jWs2/RlAfGmOx+qBS
         3UIgfCsYSoUtuWodDkwWlZ+ddX6TASkHxc/HOIam4pfn1GCH1p9q7wcx8cx++hZk3wl6
         FLHMXQmkWrf7UMIkzUi8xrJuHia8MYARM5FicgRxj+lpQuoIsJMOzETtvzcJ9ctJrv92
         GwzZkHLCOw1BhFhgWq9sYz4f67bo4u9hWXh1M7SxrB5AymKz2r2UjDH8oVjk3FUJe54S
         LaVzjSdtrAEjJW8Fpkt+73/69NI7y2C0LMVi+PuGR3hb7AOIrbB/ZAJ+KQdCaVs3WcZJ
         lrAg==
X-Forwarded-Encrypted: i=1; AJvYcCVSmhZVCtYpxLHcIXozDLFgkEuevE0rkJqdFxfK5WpkpRpMxlLAEteWAKD+RahRuMhqKAskxMG1JODV+hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwH/arSCX6YMoP+s5vQbBKeCuQgyvLja84Ohp7uCiX2HpNm1M
	hpllFgTznHG43arQsuiXMA6uJ97TD4NQ1vL83QAosfzRGJ6NKO6cFMUVy3Ol75AC0qLVGpYFdK4
	mAtXK4+priZvaqNtU34ztDkD0iOmuRvzBgcNV
X-Gm-Gg: ASbGncudY/KqvfekEyIKDf9IEQPAoaxPVO3PMFsCZrYKEQrY3p9eYOQIliKOA75mJxx
	/6djLIybrY4dpM2f4tzGJqQxEEw9F+v16Xk94GhwzME0PrL2h41GrRrBUywTklEo5Rtg1Bvv07A
	70UZRRMY4OLqB9h9ku99avVZDoffB/mFDxVBVB+es26GbKm1bgefzBlsouqDzENK9X8VAt8oA/1
	2RbzB5GueMAZW+GvH0gGO3W+hhBkox25q5tDiHuF9nTZXyC6mtOU3CvyZA5hu+ggz7BAPKHlJq+
	ltlUpFvRBp9vYw==
X-Google-Smtp-Source: AGHT+IHRpB86RXroRDzzRdYSB7oYFAv4dqfXwWvXOZ++yIISCsXtN6hFohYhh9Tmy4ZRUzQ+j+Lng2VlTrE5kMPFzuc=
X-Received: by 2002:a17:902:e5cc:b0:270:4964:ad82 with SMTP id
 d9443c01a7336-2948ba0d9a1mr120199225ad.38.1761559591357; Mon, 27 Oct 2025
 03:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027093133.2344267-1-max.oss.09@gmail.com> <20251027093133.2344267-2-max.oss.09@gmail.com>
In-Reply-To: <20251027093133.2344267-2-max.oss.09@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 27 Oct 2025 12:08:57 +0200
X-Gm-Features: AWmQ_bmTfGXGF5x3XTOBQj8jm2eoTyHs4EQJMNTtCvVM7Dk1SHwZVtKvKWhTgLA
Message-ID: <CAEnQRZDrqKFmenTiNi4U==X-xE0pv0Qt=qpXJAVi4sGvnBL4cg@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] arm64: dts: imx8-apalis: cleanup todo
To: max.oss.09@gmail.com
Cc: Max Krummenacher <max.krummenacher@toradex.com>, 
	Stefan Eichenberger <stefan.eichenberger@toradex.com>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 11:32=E2=80=AFAM <max.oss.09@gmail.com> wrote:
>
> From: Max Krummenacher <max.krummenacher@toradex.com>
>
> Functionality has been added without removing the associated TODO
> comments.
> Clean that up by removing TODOs no longer applicable.
>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

