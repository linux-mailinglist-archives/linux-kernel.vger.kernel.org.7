Return-Path: <linux-kernel+bounces-838560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F893BAF8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F006A3AD0FE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E726656F;
	Wed,  1 Oct 2025 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crg4Ppmw"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AA0239581
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759305943; cv=none; b=cXRckSja4gFaaOaEXrmkf1rnB8HdMEah86ir4VLGyheF/rV9v7rAriH4c0NPomGY3cU5eMo6Vu8JEKeVf8CXFXGE3Fg9rOvV9238QqZ6qqm7Fh/bZVcTf5CWi3jdRsaSN+3dN/JE/rNbHIp2Cks1oh3hmH1s7XR3roO9CK3eCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759305943; c=relaxed/simple;
	bh=GGaxUspw/mheggAV9HDIuwLZXsaJnAk8+jG9mB+sbNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=do782k5pIR56Nzpl2sxoI1JYcW9+IuoR1i9bbnKiYBUrF4C7n239WhIWPJB7TDByRfeH3ffXQkswU3uB8hrAoUZ4E1jZAmeQGU8ivn7Ggxp44eCxbcUhAoCu9G/NW2MzhXFr3YcadyL0PCdADKK+GWZVa/y/5VQAttSEObv/ALg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=crg4Ppmw; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3799fc8ada6so1799798fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759305941; x=1759910741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U31HGlpwBoWnZHhQQnAISdXA2vo/iclZv4+sjsk6T9w=;
        b=crg4PpmwSRzB+z0bi+b1SOFE3ULk+roD3rbelq+KOWL+vlj5fpF5+FVU2vnhx6wsSF
         CrrqQKpAhUsXoHEHRDUw4mPaD4OFYMR7dR0pkJ0XH/hM2J2MAaV/0Ye4K08PkoRIFOzC
         B8Owfd5Vh2QMSyZIqN1OfEEHoVyI0HsWVGFu62TVZL6b+b0MeHZEKILuj7bnGQjKJys3
         WhKqhc7DXFfxLFA/3vV4fLQFyL4mCB57WNaXf7fQLjT+osEZTE65BZbfxACuRG3Sg8tL
         6l3vfQKwCrjX5zJxpBsknBOCAetIl/rCl/442IZppcJddrLcZJu5+wbet5Mr6U6tC823
         z3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759305941; x=1759910741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U31HGlpwBoWnZHhQQnAISdXA2vo/iclZv4+sjsk6T9w=;
        b=YZ8l1YGnsiVRrdLAe73/xUmWoa2UmvDZ9h7TGsg0DAzfm+O1NbsQW3kvDkx7vMr0UU
         cOdsFGp+wvRKL4XLV1gwm8mn/XYmjDhM51+JksqMpJC2iYkfJjEFOmMBz0PQQV3u5fsv
         unTmWWc52TuxUfe+eqqqB6q6ZFy0pdqPTM6YizjzYgsfLpzakhKaIQL3XUjhJ/2XWMxh
         E6jAaY5TArUZNDOgKRByfDTS1SoppxNbvhAOECt0DuhAoS43SAXiRCJ+XCtvVGA5uPwB
         FSTKdVdBP3kFl5Exgzdl+aGBRueTDLfw4xDNOfuCzW8xsLcEOKdqyEe+LgKYbbnIXcSR
         x7GA==
X-Forwarded-Encrypted: i=1; AJvYcCUfd0ZcY0lzFKs3ecdIbGxRo2kb1kIUy5fAZ8FdheOmNz0ZwdHLvYcYeae2fmGcrfyv6sld/S2WTOqelyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhzP4ZVZxEBJKktIRbuTnybUp1uye7dWRSx7IZA9PIW0yzN9T
	g/jH/tdGimLjJ8Ui257iH3G69KQi0pVUEjNJMOyQot1XyAYMZwha0LO9IdvN0NTJgUsEYiS5ky0
	Rd/e0S5nOjzKvJZVcTaju5OxOHVq1swfO43q32MUnmA==
X-Gm-Gg: ASbGncvuN2w6P8WT3le/vVRc8rr8Sgoi9XV52kZTUB+5gUT+jZ46O+XHgyusi10JEtx
	dWlL6mpJBNbw0yQdf5zVpvH/yBjeGO0dNxkD/JLDnwe2T5PXrk9RmuRPUnK1Z953Nw6MGM59Nqe
	4PU9VNHm3qAzEuhr94j1pSYHMUpvnYS5j47VBeIqyIHMDgL3F5+dhr/2eunlMPwqXutPUwdsFdQ
	Dct1GGGsUUtrhzlyTzqa2DrJfVJ0Rpx
X-Google-Smtp-Source: AGHT+IEnvNyeLgqgVpt3I3Dj4/Br/sYFCjuE4NNApKeQiVhbUXzgxGO8IoaTn4yl4sB198Mov8VILc/VsJoL/DAQbKo=
X-Received: by 2002:a05:6870:918b:b0:346:865e:d044 with SMTP id
 586e51a60fabf-39b9017c114mr1383746fac.11.1759305940736; Wed, 01 Oct 2025
 01:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc9862625abc5b923c5e7c5de20c6f7c797771d6.1759243993.git.geert+renesas@glider.be>
In-Reply-To: <cc9862625abc5b923c5e7c5de20c6f7c797771d6.1759243993.git.geert+renesas@glider.be>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 1 Oct 2025 10:05:29 +0200
X-Gm-Features: AS18NWDrhGkuTq0B-a7sVS3VPWWlOlrt2LtpHlRBB9y80O6Ny_378_esQq5odTg
Message-ID: <CAHUa44EVMO1nR18HqY+PyOJhAcGjgemU9TJdZ16vHbcNERsaUg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Mark the OP-TEE mailing list moderated
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 4:55=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> After sending a patch to op-tee@lists.trustedfirmware.org, I got the
> typical response for a moderated list:
>
>     Your mail to 'op-tee@lists.trustedfirmware.org' with the subject
>
>         [...]
>
>     Is being held until the list moderator can review it for approval.
>
>     The message is being held because:
>
>         The message is not from a list member
>
>     Either the message will get posted to the list, or you will receive
>     notification of the moderator's decision.
>
> Mark this mailing list moderated in MAINTAINERS.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fc755a50fb150498..5aa2e501231f2aa6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19115,14 +19115,14 @@ F:    drivers/net/phy/ncn*
>
>  OP-TEE DRIVER
>  M:     Jens Wiklander <jens.wiklander@linaro.org>
> -L:     op-tee@lists.trustedfirmware.org
> +L:     op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     Documentation/ABI/testing/sysfs-bus-optee-devices
>  F:     drivers/tee/optee/
>
>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
>  M:     Sumit Garg <sumit.garg@kernel.org>
> -L:     op-tee@lists.trustedfirmware.org
> +L:     op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     drivers/char/hw_random/optee-rng.c
>
> @@ -25116,7 +25116,7 @@ F:      include/media/i2c/tw9910.h
>  TEE SUBSYSTEM
>  M:     Jens Wiklander <jens.wiklander@linaro.org>
>  R:     Sumit Garg <sumit.garg@kernel.org>
> -L:     op-tee@lists.trustedfirmware.org
> +L:     op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     Documentation/ABI/testing/sysfs-class-tee
>  F:     Documentation/driver-api/tee.rst
> --
> 2.43.0
>

