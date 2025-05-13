Return-Path: <linux-kernel+bounces-645916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5D1AB5572
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 15:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B8117ED29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 12:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B680E28E5E5;
	Tue, 13 May 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NaxZ9zaG"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD128E56C
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141156; cv=none; b=XgxdwFOHgGkCOf1l2ktYSYNRekVcu2j4IpMdwrfH+kCXvoizlIHE7VfglX4OmwZ76a83PxebhiXtlYc2RTFechr50v1lDXR3YMWKfxoxA8fRf+h13I0J7gKaIjRDezYqHwsJnA6N3V9v4h32KFVnENt104JYIvvMKZe5wuETycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141156; c=relaxed/simple;
	bh=8S3Yph41W8zJG6kDyye8/3nlQvoaGabwx2YL+oI7wA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9owooMuF7sjXZnShZOqs5kVLHI3Xxyy1nrOkrrT6Roitgkb/7DisJ9e6uYTM+mghKwv2LD6UqGonYCUSUZ+jopsH54ok+7zg+ohUUdIFH348IXYxYIpsjkTr2XE4nxPpWbRi8fcTcB0d6sLqG9mumVnRZwSegPhhuz1D3hSXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NaxZ9zaG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54fc35a390eso6707376e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747141152; x=1747745952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8S3Yph41W8zJG6kDyye8/3nlQvoaGabwx2YL+oI7wA0=;
        b=NaxZ9zaG63W4bd4VUkxGiFjRk5qHllCf2EsWG3Q8Wlxxh0ovnGDMS17DSPvSegcGHk
         CKTrpclXS/25nQlxrZUmog+3U5GRuZ079Laxxr5mnCOoJza0uc1C4GtJUWUoy8pp6fmH
         +tY9diaQMwSTIrRNgOJbOuOMHhYroALAXFCEKmVFPm4IldVff4gfq9aKS5zmxHRymClk
         8sMpZCtAthCl+MD6g1YulmLYy4acwLOvqqTlgNLVCRUwTkxNSoAd0oDgKvR5SNGWIWbt
         gilcE/aP7IPVRU+nqXfnziFEx1N08mwebXX3pnhfyhhb+JtlyVOwaSzoZyuf9+NQDPXy
         XFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747141152; x=1747745952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8S3Yph41W8zJG6kDyye8/3nlQvoaGabwx2YL+oI7wA0=;
        b=s0KsiXJSb0dxRDYZsY30hGagGJ77D05Vz7fwQSVZTSXSGYsXyVVusXo1vnVlEQsxBH
         Nl/19mF9miSODQ1fcOreEm78U+dfXW9E5BGp4PC36ZWlNPY6AIDRtofCmF5iAbvqsMND
         R+qoYWb/pfnpypdjtcmsW8KfyTz+w/ND/W2IJc9g/vP7dIdhMq8mFGi4dDe8Q4XhGGF3
         aiqAJX7Wxh8p2k50wLxkG5h2QxCumiGrtDep9McCq6PRTDcDTIgYp96aiIygvXoy+pr1
         71CUnHhXeLN/+5PFKqz54TQ7yv0Efa5LLnrwBBI8ZP5EZjbw/ISs64jVxOMtCdHSK3Cq
         rI+g==
X-Forwarded-Encrypted: i=1; AJvYcCXAdpvctMc8XoZmEhv9wjgXFNxsOO6pqx0vCjZP3PxDUwjLR4UB92fprUQT8hcG2arvXQ3FKDEv7dELbZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHg4jS1SZv3624YNq0GHzYHbe2d6bX4B7gHW0tV3+WwX1HvDon
	HCetLu7TwPj2SFvQkSex/8H/dnOU0vb7Hrq1fVFAdfP/EiN9Vq1AySPhmaRFaMFXuOtPEfhJMHz
	plbDpd7/eNhfxT+1Sb7MTn2Zffv9xALN0hO2XFA==
X-Gm-Gg: ASbGncv/sbxlyIAmBDuSI/ZkqZUDN1lB1mqKCamcLYPPOfxGKr3PSdkAQCCdls8jgnT
	DfSjzuh6CZ1+bwlhFV6O5rY+78IhdPwi0DSpQdxw6H1F1IT/JTioQ+3a1XOMLZAaYyzZVP07qtz
	tj8AhZMMUANF2Vz+J25isfU2z0N6fE4hx1
X-Google-Smtp-Source: AGHT+IH8XHefqNP0R9UQJCUOm8QNLo2Ezd+mWaxac97cDIiKEKJXNuZgmWyG8hS99tlcf+2TC0nBCMeUjZpkYFyc7oA=
X-Received: by 2002:a05:6512:608b:b0:545:2cb6:af31 with SMTP id
 2adb3069b0e04-54fc67b8e2emr6534510e87.15.1747141152348; Tue, 13 May 2025
 05:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-aaeon-up-board-pinctrl-support-v5-0-3906529757d2@bootlin.com>
 <20250506-aaeon-up-board-pinctrl-support-v5-2-3906529757d2@bootlin.com>
In-Reply-To: <20250506-aaeon-up-board-pinctrl-support-v5-2-3906529757d2@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 May 2025 14:59:00 +0200
X-Gm-Features: AX0GCFtmi1qs_gSfGas8GoZGoCMX4N_wHeVY3_msDsE4LWjvnIpjpsZUBZz2o4E
Message-ID: <CACRpkdZs+Hb=XGMvKxTTgNVBKDO1cjOCjfY2yQj_bxWtjwbSag@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] pinctrl: remove extern specifier for functions
 in machine.h
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:21=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:

> Extern is the default specifier for a function, no need to define it.
>
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

