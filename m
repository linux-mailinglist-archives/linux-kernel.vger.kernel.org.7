Return-Path: <linux-kernel+bounces-777053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23B7B2D486
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9709D6245DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2892D24AA;
	Wed, 20 Aug 2025 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BIULt8eX"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9A2BE7A0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673860; cv=none; b=PA0q9DpyzCiolCMx7k2TBjj3kusRqr8YWrEckdgseobiOwyuSj301jGx1F0Czg2iTBwOrLmETScmPkknXpUKFnRN1CL7cvJluqH4OQTUdyX9H+kdTEPWUXbTSRkSiFpeW7PW0fTYb6forM9j5dg31lkcBHmsEN66+wkCV/p6Fck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673860; c=relaxed/simple;
	bh=prgVg9HiEJ4uV/6zMq1ntYT+mrJSc9pU9ueTTctA7Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slt/13BJrZI1J/U0cFcgFpUwilpRyEKGD/m7ApXFl6emXQ1HjB+QLYWvO6m41sgHi3mPyHbHAPdbu6j1l66p08G8HvvQWPWe1s2+afYiWbvGmIupdb7bAUHvStePyFvwqSqsC3HormiDa7BP14Rqzt2buZHSb0BOb9LceQX5Y5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BIULt8eX; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e94e6c6150eso1604233276.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755673857; x=1756278657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gN4MlxyW6r3qWYrx46kUgQuaQDW5GOfX7NwZdxQNvEM=;
        b=BIULt8eXSUyVECLBo1T+q7DPtFoo8V3op7kiyPWrKBxtl/sDp940qG7jNUt3fhANxM
         vhKHpm9dr7QA1v3udI/OgMMtWis9KjEQIXfHLpWcI7C2N6y4Dv5HM+7TzmXD5saeE90X
         hkbFg9xVjg2af1oSjL5PTq23ykl5q9tY/u0lppYs/AOJhNNgUXr24DtcWBjy7ltiNQ7i
         kBRrtoWAYk3QtERLucnr/+XnQbdmNz+TtDy1Sr3R+A2zk3SZw7M5DxowzdmeTxG5BmN2
         zgLbwWViiueyOm++KTT/P7hW01IZTKG02krq8wke3A3Il+tjGm5+OyYndr1yEVFJYtj1
         qKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755673857; x=1756278657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gN4MlxyW6r3qWYrx46kUgQuaQDW5GOfX7NwZdxQNvEM=;
        b=COC8vPSzU/e8H4VXjvv72xYxpPTAOKBftlcWHGtO1DLq4C/G4ioydDywrMxp+BZTjP
         IPQKNMmoHJOX3k9bwdviPOdy8FkkD2zMRfh7aSNoXz4c2av6QzZKZ0koYuN3a4LgpAcq
         5aTci6xskYj8il1+p0EH09jAgIzkIlhrMEoYVN084saiKMS8KNRhi4OwxWV52UIxmUkX
         XXDJ3liJc89zuQSwX0b705THUX69wqTC7nS6ZSIikTT9zOBvvHWxEABKnK7HWGqdeEPy
         YzJweiDmodNQ84RiSmLZ7utGetyGINu3AE3HXCrpRzrl+3ybVHSN+TbGU6hDed0hoLiD
         Ipyw==
X-Forwarded-Encrypted: i=1; AJvYcCWBMcD6Wr9Ob4TGtftiUEbIdWt+d4WjobBw9Pu5pn5fhwI/X8lMOxYO65zr/VzIncnhEHgj/1dMW1qN4dY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxcbm6SXtvl0cnYeyNOksFPwzjz+6zb5Kp3oUw91jVq4vTgxJI
	VgI5R/if7AdtdzBcADGhTXYok34oZYzfYpL3qsngk1vv03Sjfef1MsMIahrgd0ASl3nEY+YA2l9
	QvnUVZ/aekelxenxocJz2SHDPwZ292wumt4wLBcJUGToTx4XPTMlyjeHouw==
X-Gm-Gg: ASbGncvLYyThXYXQ0BTf63FWI9etOB4xdIAXSeXUbyGpWzol37V9DuGBFINhX/+qS+b
	hiYhU1RBcwwWkinNo2uaZJ0hQPVkY5m9YM4U9vRUJBOtOGwHk9oa9RDvE2g/jH2kH8ebvnuc9bb
	/EQ7abQ/0ksm8yorfqYpt9ZCrUsTZEbj6Em/miSCfewOKi3TjrY6aWKZWDuPeGVXo1SNniLkKI4
	zN1RkHzHueT2KMboCTtAWz6pAQ3PvR83mW6Ybos
X-Google-Smtp-Source: AGHT+IHT0m1so+m2DnVNQMxzC59omwxRiB0xv+lEru6KW8Qz0ZRm2ca6i/Xd/a4hCrOi+ZEgA4u3fe6sRq342P6YZ98=
X-Received: by 2002:a05:6902:6316:b0:e93:3d4b:40d2 with SMTP id
 3f1490d57ef6-e94f659be41mr2605537276.15.1755673857649; Wed, 20 Aug 2025
 00:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755285161.git.jan.kiszka@siemens.com> <c53346c183ce0c3d02322726ef5808f468441a42.1755285161.git.jan.kiszka@siemens.com>
In-Reply-To: <c53346c183ce0c3d02322726ef5808f468441a42.1755285161.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Aug 2025 10:10:21 +0300
X-Gm-Features: Ac12FXwAEwrbRnqKeCUup8XV1JWb-Q0hv7z2-rczEYxbT-5qBQyf2uoeL5WDaqY
Message-ID: <CAC_iWjLMFGp3wg=59PruJQb7heds6CUcy8FMZ_cdT0b2vC5a3g@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi: stmm: Use EFI return code of setup_mm_hdr
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahisa Kojima <masahisa.kojima@linaro.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jan

On Fri, 15 Aug 2025 at 22:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> If a too large payload_size is passed to setup_mm_hdr, callers will
> returned EFI_OUT_OF_RESOURCES rather than EFI_INVALID_PARAMETER that is
> passed down via ret. No need to fold errors here.

Apart from not folding the error here, the current code kind of
violates the EFI spec.
If you look at GetVariable, GetNextVariable, SetVariable, and
QueryVariableInfo only SetVariable is supposed to return
EFI_OUT_OF_RESOURCES, if there's no storage space left.

Should we also change setup_mm_hdr() and return EFI_INVALID_PARAMETER
always? It's still not ideal, but much closer to the spec.

Cheers
/Ilias
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> index 706ba095a4ba..bf992b42be70 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -220,7 +220,7 @@ static efi_status_t get_max_payload(size_t *size)
>                                    SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE,
>                                    &ret);
>         if (!var_payload)
> -               return EFI_OUT_OF_RESOURCES;
> +               return ret;
>
>         ret = mm_communicate(comm_buf, payload_size);
>         if (ret != EFI_SUCCESS)
> @@ -267,7 +267,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
>                 &comm_buf, &nr_pages, payload_size,
>                 SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, &ret);
>         if (!smm_property)
> -               return EFI_OUT_OF_RESOURCES;
> +               return ret;
>
>         memcpy(&smm_property->guid, vendor, sizeof(smm_property->guid));
>         smm_property->name_size = name_size;
> @@ -324,7 +324,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
>         var_acc = setup_mm_hdr(&comm_buf, &nr_pages, payload_size,
>                                SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
>         if (!var_acc)
> -               return EFI_OUT_OF_RESOURCES;
> +               return ret;
>
>         /* Fill in contents */
>         memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
> @@ -391,7 +391,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
>                                    SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
>                                    &ret);
>         if (!var_getnext)
> -               return EFI_OUT_OF_RESOURCES;
> +               return ret;
>
>         /* Fill in contents */
>         memcpy(&var_getnext->guid, guid, sizeof(var_getnext->guid));
> @@ -448,7 +448,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
>         var_acc = setup_mm_hdr(&comm_buf, &nr_pages, payload_size,
>                                SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
>         if (!var_acc)
> -               return EFI_OUT_OF_RESOURCES;
> +               return ret;
>
>         /*
>          * The API has the ability to override RO flags. If no RO check was
> @@ -505,7 +505,7 @@ static efi_status_t tee_query_variable_info(u32 attributes,
>                                 SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
>                                 &ret);
>         if (!mm_query_info)
> -               return EFI_OUT_OF_RESOURCES;
> +               return ret;
>
>         mm_query_info->attr = attributes;
>         ret = mm_communicate(comm_buf, payload_size);
> --
> 2.43.0
>

