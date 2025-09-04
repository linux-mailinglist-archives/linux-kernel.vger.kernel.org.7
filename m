Return-Path: <linux-kernel+bounces-801549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FA6B4467A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A57A01738
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21C22701C4;
	Thu,  4 Sep 2025 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFVx0wqg"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4CE267733
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014543; cv=none; b=JMLEq4/vRuAk0U3vPHTkwWEmnuqP4MDlgZmJ1zTl5JqMVhPD36plAT3zGPLp/j1NtV+H6UbxHnc+aFbUw7aGZAwCDuU/rCB8kLggM5SMdFLLk8f5lufR9ZX6JanbXsintkACZl3/Tr1BQmUZexo7ivsDDIcneTzmW7KXU2k5064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014543; c=relaxed/simple;
	bh=32nYEhO3U0uVRAxCwAscIZa3xyyyN4IzR3cTBfcZ/4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aywn75A0q+RB8fL3/JhPagw1vQqGUF5fn/d8r9+E6mKyM68ftRpqC77eZUOi4FE2c2YyDx/QSweHG6hdcYhqigfi2poC4i2zA90GOBBAithFwhtA4+8sVdfADCblPv0Ty797BJ7x0ViindgtWxZq06mdkQsLu+Lic6tw+MFT0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xFVx0wqg; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f6f434c96so1252172e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757014539; x=1757619339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32nYEhO3U0uVRAxCwAscIZa3xyyyN4IzR3cTBfcZ/4s=;
        b=xFVx0wqgOn7c2ZpHLjaVzxtGc4XHsgiAAS4p9qJLptr7Si1mgY+XmAKEpqRuYm/cdb
         7gVnfC9pGrukbXoiDPPavzOZlAmm0/9c+O9oHYeCUNkjYNXIC4XSXA3KyqDtQMM9CEcA
         dnvpTCRCQhKFaSlUw141azOpaLG26XAA25rM8ayG8IPDHMYs+4ycpmC8Fw8wM5F9aPjF
         cIiJWPxJqwiWszERMOUIaWOmGE2F3zptKsc/vaLgrO6EBD3f56lvBq7HD+xrH9Tl5o6D
         xT7YvowSW4Db+7wxPtJ1aXiJYQYhG4p1yp/Ov8ZHyIpHDSC9lt1D4LAMI7TQuRGB3x6i
         1N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757014539; x=1757619339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32nYEhO3U0uVRAxCwAscIZa3xyyyN4IzR3cTBfcZ/4s=;
        b=szBUEgYJ7QjYuoivcgFx+cN/FIPjmXYVRCF/oZ7vfJY3jwIi6rM2Rq2hSxLGJrL4L8
         hmpWka8U+CywLrmzQZVhhOmWUaEUtHULDvBOPt1ZpPlx8ulBSEVHQLuNbwRomJEojlwY
         GuQEs2kwEqRzUsy+nICfbSQQfcN4HSynoX4W6KXwr0wMA7SDWZZctk73fZNDO0fvMQXO
         hMffhfV77n2PEHa8Y6CIj9zGNaPLVk4gV4O1qy/+3RQ+lNlB6QoySzJJ1CduZn4Q/2fL
         yey+jgji0UcIcnIGf96RshNLBR4R8Qmq87fMbEblAe1mzm1N9hgK5ZHs8oYnwh7pIm6l
         W/uw==
X-Forwarded-Encrypted: i=1; AJvYcCVzSMxzDLrvABjPNVNqz0cC4JXMcSzSZCt7u/bCUMNHgFbXOKHY/o39B1GpfimE3PAX0YmDh81YVA0WOO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtMSk6yQWyNeAtdaHYKfCSlqDFSb+zePD8nhjM8qWtk3Ia69Ap
	fPDV3NUgll72iykNqg3mA1Zwz3Mv1/gCFt+dgqTeBxka6aVN38S4BBoU+NHu0oitvAtTxXdKLlK
	oj/tpRMjfsGCDYww3i4RaZCDWmughZM1IiCWrGtkI+w==
X-Gm-Gg: ASbGnctm2Ld0Nxl1NgMBYDSRAJigAdbk7DRsbqBoW2jqOcZ9kFFXXay1bLrBwGLTZAA
	lfqVqyhQdHJ+ro2TCM3Mmq02WQObyGqlj3d+ljLQG94qc52IA/sl6uxTSdGUWeiamSrJCWzIPrV
	FxTNSonu1nawhvPd8gvCpg5T0I7DJVSmcpY2D0ahkwH68uvw/DgF68PfCneRja3yLfdLY9GcpXo
	+ICpKFw/t0TFhmAEg==
X-Google-Smtp-Source: AGHT+IFk6qWrCgBCMUMmRXmwNfVdMojmRglmfhyiJ5psNymemT9FqXab1r+PbaMVvluse9Mju6Gt2tnrWCGHPJdZfDY=
X-Received: by 2002:a05:651c:1079:b0:332:3fd0:15fb with SMTP id
 38308e7fff4ca-336ca5c1a70mr38397421fa.0.1757014539436; Thu, 04 Sep 2025
 12:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903100104.360637-1-hendrik.hamerlinck@hammernet.be>
In-Reply-To: <20250903100104.360637-1-hendrik.hamerlinck@hammernet.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Sep 2025 21:35:28 +0200
X-Gm-Features: Ac12FXwi4fLng12UMi28VuiL73WI6CiLUWCY-CJjaRNMNpJieZixpye9Zb1GrH8
Message-ID: <CACRpkdYMHMvFCzcA0G9sj+xSrjXROU4OmnV=x0EPfRBpVycQtg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: spacemit: fix typo in PRI_TDI pin name
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: dlan@gentoo.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, linux-gpio@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 12:01=E2=80=AFPM Hendrik Hamerlinck
<hendrik.hamerlinck@hammernet.be> wrote:

> The datasheet lists this signal as PRI_TDI, not PRI_DTI.
> Fix the pin name to match the documentation and JTAG naming
> convention (TDI =3D Test Data In).
>
> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>

Patch applied!

Yours,
Linus Walleij

