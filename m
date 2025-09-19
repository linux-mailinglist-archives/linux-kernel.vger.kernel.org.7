Return-Path: <linux-kernel+bounces-824448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CA7B8940A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78EB176A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958E230CB48;
	Fri, 19 Sep 2025 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bih4EQiz"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62AF246795
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281045; cv=none; b=ddd3PX9DLZFHe8ptL1CngDCNQGi0TqkcOUj1wOXBjC/1H5H6C4w+DJmD0DbQ6pYh9vvNX/4hrFku23HiTQPvTlZNDdBljNv9lqC1pHRqnLS581kL85AzfUoQkqh9Fx8KLxcBIE2uR3Q7J3/hnQnrnPe8MpUCVrLai5/Y6qXawfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281045; c=relaxed/simple;
	bh=He+6sdn61LRVIxrBafIW06DcfRvltNAdv31TV0CKGnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srcD6pdh6zv//m74w6sjhSpu4zyTz0Z+j4620DG5wNoMztOwTcov9hBxa1uwzmGmTIfxe/bdFTddRR5Me1spcYp0aEFc2kDlWc7YTR6WhUNKhKs17ZzVyU/Kv/JCBwCMHdX8xaOwHg8z091mgNrnTA067wwQvU7UghNy9coVB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bih4EQiz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3304a57d842so1391241a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 04:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758281043; x=1758885843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He+6sdn61LRVIxrBafIW06DcfRvltNAdv31TV0CKGnQ=;
        b=bih4EQiztO9Bx7dPpi0b/+bttlK/cYJMr60EjRy4o9oqmfyWpXw2W65hYKyVh5oI6E
         nDAev63pT/tY8qfgwe06to3Y0yBm/KnFVEiPxJDNZQjU8zscE8yNamoEftuLhAnvyaNo
         JG4VNYKygdfn54iv6B33C/xEHGmZ97XQWTKjiRcJgofolEQoGaoGLNhe3kFsQCtyF1kS
         7dG5m+EGiTHm3YjgXXfN3i83rXIkxCt/Q8ZP4IFwdY4V4BHWJKnYbWqklAmearmws29K
         /ewzVUXa1Y/r8H5JHIa+QW6AYYTYF6LYeqry5y7UrhovRxm5L2CzYrt3Zk5jizIYorwu
         06Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758281043; x=1758885843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=He+6sdn61LRVIxrBafIW06DcfRvltNAdv31TV0CKGnQ=;
        b=YbXTXCErucqV+I08M38eR2N/ssz7nlX+OFVecVEDsIGZLiMetPjoEYvHUIx8I8g9yl
         UpPJgkZlk2RNO4bW6JMEvI9nY7IhB48Fp1Nvhiz17L2vceKMZZ3eqockqiWH8sRe/WPa
         61UYixKHfK4LCPhE0x1tCyC66+5ohjJyYoNq6K9Sa8rYchaqp9awNeSmHVBsrVrt82rq
         PdEp7QZO61Sqtw+JhgryFNOVULVqXRB8hVCEIhE63AO/36p5AMsOQOMUY+OaGqUhGIVo
         GfRJEpcinOcm9YtuBbVgmD0PJG5D8CFxGI+RBr9z7wfqixqgzDzC9FpMGWu8l2i+uF9p
         6ZXA==
X-Forwarded-Encrypted: i=1; AJvYcCXPZuIBBRCwd/r9EtrmdPseIu70C/qylURyQ0Do1vOrBuUqBFGyKMYUuNVpAUv1q6hwOOagJDRQMrOoJMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyImOzW8nHAWMwXfbeNO1mPEYQTRVap2vfSpbM3ESorh6O0JD+U
	mm9q/Ex5j8oDTjeap0QZtfoyw2kZAPwChdtldlZQxQhsKWcaUNmKUzDA128K5LNgd1F8UAWXujQ
	UzUwIGan0CGoF6e/S/+LRgj5kZ1G9jL4=
X-Gm-Gg: ASbGncvtQd2uxWthM7jaotYriVYPpYC0MKs0Sqo5ghnTeRgmIx1D2G6vEAmhdiPUaWT
	uzVncOUwBCC0j/jq/U19LOb+S0ZIZ2hkIpe+4DGJPDDX886U1yRFolnNlEDFCpkwPU20rsw78IC
	gsWrl3G1HJnpVBrqDL69p2YYXSJCG5+c2w+3lnzZMBTojPp59Lumc7CsuKL4yCUuyv60lN2j4cJ
	saLnzZFmrqRHNACPvXK33mubF8ina/ZD7zs
X-Google-Smtp-Source: AGHT+IGR+j53MtR7Ycbzac1nvh8/Xsimed1/N5Ir4au4nEDEE6nsTs+zulbhVQrxaMtQaq9Cc1ET2UPKXkixOlwNUv4=
X-Received: by 2002:a17:90b:3a4f:b0:32b:d089:5c12 with SMTP id
 98e67ed59e1d1-3309838e042mr3853941a91.33.1758281042999; Fri, 19 Sep 2025
 04:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-imx_rproc_c2-v1-0-deec8183185f@nxp.com> <20250918-imx_rproc_c2-v1-4-deec8183185f@nxp.com>
In-Reply-To: <20250918-imx_rproc_c2-v1-4-deec8183185f@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 19 Sep 2025 14:26:19 +0300
X-Gm-Features: AS18NWCk1Oc5eecL3-ZExUWvIBIypCHeXmF72jHYDkEXM6phwnZTdZT1871xqCc
Message-ID: <CAEnQRZCByoFeuH0KyPbrt8T4pPyPwG1DBvrFQq82mD3KGPTuZQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] remoteproc: imx_rproc: Remove the assignement to method
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, linux-remoteproc@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:53=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> There is no referring to the field method, it could be removed now.
>
> No functional changes.

Please mention that you are no longer require to provide .method with
imx_rproc. We are still not
removing the filed in imx_rproc_dcfg struct because is used with imx_dsp_rp=
roc.

With that,

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

