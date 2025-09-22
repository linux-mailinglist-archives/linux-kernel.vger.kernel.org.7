Return-Path: <linux-kernel+bounces-827161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FAEB90BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D8A189FB0C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2D3305066;
	Mon, 22 Sep 2025 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iemcd2Tm"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A693303A12
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758542074; cv=none; b=hTLvrIzuxkf+Ix6Bto0ic/cN0Z204sEvO5YVg0dsCE5rRlIrjLlYrcG8ZxRcc3vuzsGbpGnCw5pL3X1QvXR7M+9Uh5fFn+V4ioqlejTRiNtQ8kDugdWksuuUiquyNXblIjFQ72+imY5yRsGdlC8rPsmRV92z85A4ONByTnRRdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758542074; c=relaxed/simple;
	bh=H82PriZ9rjpzbtA4cB7LLdyiPEBtTfyUNElybLELZfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r73h3svwVesetWw8uJ9XQytTvEjD/7CtHLmXyeGODjCFiWam3JJ5lgHiobwAgJNMONwhd/dCgazYQEWGbqFB+FUd7IX73PI9e+FObUOvFW7YP+ulWL2rGwej1eU6icRT6KLKzGgQlzsXutNdf61v474PW4B92JThLEKHJJoLRrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iemcd2Tm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so3975198a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758542073; x=1759146873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H82PriZ9rjpzbtA4cB7LLdyiPEBtTfyUNElybLELZfU=;
        b=iemcd2Tma11KFA/ZZkXJVF5wTFRWIyUV6Ywk7qDtrdxLZZ0SSOeJJoa2ZovVj/+X77
         pTY5Q/S3TlMKmjenbqbdAzjx1ygEL2TSK0j14zeIzqtEcdRJpQKq9Cms69YfstSZlRRv
         fIxu/dm+NjouiPGmtg5+Gp5sqACT1PFEKsFYjJ2x6OJZ0opyuC1JLD14TflxiSkHNTcV
         PcSjZCp6eETNv7jBU0qjcu2BjcVwODRWN3+bn76tdq2drAdfZrKFmjC1fApBpGt3E/pE
         kOgwkdWSlJg8ApxGxbFSW+nRMX1Nigo8MmYHDNF5hrzoX3xYjQgxWMW7+X/TGUeldiSc
         FgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758542073; x=1759146873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H82PriZ9rjpzbtA4cB7LLdyiPEBtTfyUNElybLELZfU=;
        b=jk/3NFYfHQrGJ3ko7BzA0982p13oeGwjBT73gLpbchu1Rux31CVAvd9a8yIJPoJmZs
         1w1lHQ1zHQK2kTdFwfVgmL75Wjxjy308ujS56DlZht84c7pCW8ucNKnpGlI870WbkicH
         U3L2BwDeoOXxst2Eo4wGCsYBjxHXb/6GJFmKVxP72kFQaKPfUvW6lajJDXL16FMMDvhq
         qPKWhmHFAc0tIHdr0eVHAy+gMYXYa3PD7doKkL6w/XBrw68ajWVK16lUPtflRRz7eINV
         /oytNz9CBQJ1qNl3JiOxwQgW5qbdjNN4dnjQ/DQQHu5HriAY3fhx4pXKB2U8MR4KwYQP
         C/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWcR97vbZEXH+vfdF0zZ9BqSnVzWOMIMagThQw1jhrnxsQI/tVARLhsf8KNkrE2GkPdEiBaOD1pJsYkc+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+k4d49xNLuAWFW585NEXKQxBFwkSKF5CDYQvo4NA8WKCEVRn
	UJfCGuI1C7NamtVA5SF5377tmHtjmzvIBPZwPzKLHtvlGFJUM4wrBJuXBcuoFUCPayfNQDHGftG
	1mpKuAM95s2nJtVugFEtL0XsVXfGGHQ4=
X-Gm-Gg: ASbGncur7LT+kvYHjM1can2DCdCNq5msm+eZzK7hxB1cDzkFsk5Daj8w3QD/NrwZutW
	Ft5veghRwERn/ZgpWQ8l3yy17yxY/maw1r7gKkpF6LE5Ijf+w9cjryjmXPV+qDQj959HoL8L2vT
	PdvlJ1Cy/K11Ftg+KFR+fTz2ro+qdlnUef01n4b3/227wgFgUvS4Q6Ct1/aaF9pRktaejaDPh3p
	D4NBA0QH+HADFYgKuM9N0PmojNiRtFocGkg8FbhnC5/BP0=
X-Google-Smtp-Source: AGHT+IHzxM4yiWZAL6zxD7pQbX0TaeY/bJwW0LY0llQOlSdS3iORCuACnssvnMbvtQZrqfxj7+ITUfMjGupBB0hJduI=
X-Received: by 2002:a17:90b:3d44:b0:32e:a6b6:6d00 with SMTP id
 98e67ed59e1d1-3309836d4a0mr14833310a91.25.1758542072686; Mon, 22 Sep 2025
 04:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920-imx_rproc_c2-v2-0-3351c4c96df5@nxp.com> <20250920-imx_rproc_c2-v2-5-3351c4c96df5@nxp.com>
In-Reply-To: <20250920-imx_rproc_c2-v2-5-3351c4c96df5@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 22 Sep 2025 14:56:48 +0300
X-Gm-Features: AS18NWCo7SM87IX5gqcum6VQNj3ji3-ObJeD7tPNQaPVNEbSqpL0MuoR10HuEnI
Message-ID: <CAEnQRZAtNCzoPdY0B=NXxKZte46XuVSNm-cSkEj9mUr7TF5BNw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add an entry for i.MX remoteproc driver
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 4:16=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> Add an entry for the i.MX remoteproc driver
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Daniel Baluta <daniel.baluta@nxp.com>

