Return-Path: <linux-kernel+bounces-796086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D753B3FBB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9253AAB17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CC82F360F;
	Tue,  2 Sep 2025 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKPL8Nvr"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249B82F1FF1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807411; cv=none; b=SskCSXs0sxIZNFDjrVC9y/KSOe4AdxR9RUnS6+RXoBsFxxsbIkUtVWd69F+2pKW7mu8xNxON8QzTRPgYjApRLNeD9tJyHIguvPet2VvW5+w4U5qESAdL+Swga5JsaiXYPimZ6+CS9eaqtSRiYtTkJFCTqm2vDIJ1K2v1Ifmxx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807411; c=relaxed/simple;
	bh=lMt8f1svkhZE33FXRLY0yAkh9fTWrIdcWz2YobDS3hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHhCQbKfNAGs2PiBXqb0eRXnu8KtM+4PmAQ1TAc291OtUu5bdC7gdgTjdKeHqj8RgW9Ee1lcy3foxflK6vndFDWru21mn7v9Q7Zml7ZYLWMOI7v3VLGGRb8S76hbri87ZUA/UI+cI8QWdp0CgMN8huks/w88Bl52AbRNaEi2OdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JKPL8Nvr; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-337cc414358so11511581fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756807407; x=1757412207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMt8f1svkhZE33FXRLY0yAkh9fTWrIdcWz2YobDS3hs=;
        b=JKPL8Nvr1t8aJ1PNt/35It7dkYt5pQZa023xPSAvyWqItoR3lwVnz4nF5tna3rs+Ou
         1k5JQ8bqK9W/rMsW0zhEBjQW67g5JAeSne/NDhiYZY6UOxYVI+nYg5deydTeU++UHbE6
         yzHEzRlieXIMiONQv2ovW1LrVMp3Q4+MZTxTwGrclhqNQ/Hj6HEq3OWbBlAzqzwGkSzQ
         VQ0PdczWInkY/ZYRF0gVtPXmBUsPeataa3qrcs9cGzcU1m5TN3OrCHGI9ey5SR2FUhJh
         LyZ4GaYecdcd4imEENmNQwoz12omr598xDlC13d7zaLotnjyE0ZcFC0RmmdlLVgUK3Tp
         t6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807407; x=1757412207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMt8f1svkhZE33FXRLY0yAkh9fTWrIdcWz2YobDS3hs=;
        b=jts61f6uqQoGlBScrGKl25jsTlVSSfPZrCmLdDe0rhL7hMzb09axgriGwCce1XfEvG
         nDH4DExLdxGXJVTF4q2qUwY6d8gn5NcMvGUsEmZqG7OVhOum36dfLaiP/rgp5tecbtj1
         olI8wfF2qLoaZXw9YJXUSqNRrIp/yyzAkSwnurOYi0nG0ur1KMgjSaM3a4D8OwFmzQES
         bf/OXHI1+ghoVvnVXP/2QdVn0bJG4kV9W6+eipUmSZ+irIkTMCshBU/itPtgY8OxURQT
         KTC9aPzQWT0kSsm/tty8sxL0ZXcb0inI0ZOFoL/uu01/UwQTnulXojJ4ZUm3AIQ4h12t
         FnhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwZe7EFXx2bLDMKhi53eE+20sbciFKi0KOeYQI6MflxFI8bX0d3OAnJfmgEt4Lrml5JqJRxwpx5N+J0dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVfMM6hoigTuU5ya4aS65l2OW68aQ+RupymxpGw4b5C5sgjJNG
	y94U2iCQLuSncvTyi9OS8lYnmWrHOkEJwQMsovNbJVOAQwJNJOBeUwoN2+2t9S31xyYilByyg6f
	tgdywH33wt1PyfRWQQLblDUgUVe3HhwbQTkjAgAzjKw==
X-Gm-Gg: ASbGncswMPDyp4yWtmc1G0DBTk5d7Ej/XWwsGfLQE4YAWQ6KDZFYNFTU99rPffx3xOG
	fb5pCsRIeONmxzBjPHshJM4Fbl/kaXaZfapBcYhewlmkWDeh5wG03aOlVXWo1PwpuQugZJ9749C
	tixGtwI+iU4j6E+HbEe3L2wUt6bvP6IJgv6RT7G+H6+mIdTZ7TG/c8o//ih/uLavsZv+i+xIXVo
	Za85NnLwFNduddmAQ==
X-Google-Smtp-Source: AGHT+IFdHvcUVxSylVwD2vnKLU9FQTJFLwj42u6Z7wlm3bxT33e3D2bu+wc3U3jlI6g8xaBcDAr/McPTMKQVI/EszFU=
X-Received: by 2002:a2e:b8d4:0:b0:336:7121:525a with SMTP id
 38308e7fff4ca-336cab0981bmr32752001fa.25.1756807407065; Tue, 02 Sep 2025
 03:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org> <20250811-gpio-mmio-mfd-conv-v1-1-68c5c958cf80@linaro.org>
In-Reply-To: <20250811-gpio-mmio-mfd-conv-v1-1-68c5c958cf80@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Sep 2025 12:03:15 +0200
X-Gm-Features: Ac12FXx83c_FhzzXPFUThYNZRpQMbuI8Pyqd_lvAWb4e0eyemL5lMdz-E0s3cCM
Message-ID: <CACRpkdbLoa518Nu6UqFcqgx5fvqv9Uj5o_etybO+sxZpDQ3_Mw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: vexpress-sysreg: check the return value of devm_gpiochip_add_data()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lee Jones <lee@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Pawel Moll <pawel.moll@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:36=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Commit 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
> removed the return value check from the call to gpiochip_add_data() (or
> rather gpiochip_add() back then and later converted to devres) with no
> explanation. This function however can still fail, so check the return
> value and bail-out if it does.
>
> Cc: stable@vger.kernel.org
> Fixes: 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

