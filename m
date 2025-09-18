Return-Path: <linux-kernel+bounces-784245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 692FFB3388E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816AB3AEEA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A274429B793;
	Mon, 25 Aug 2025 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+dJnLbk"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FD1F0E55
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109691; cv=none; b=eK1ncR1bxSGoLiEApAwMApIWZxc9fRHLhoOWLR7gzjC0v3f6S1dLkY8MUUK/NXv0I7eFuOEJaLo1ZM46qFTo0F58gLs+5+J3XsJgZ6xZrY0WMMD7jdt8X+B4NX6/uaMFmUxOz7SVKk8Wk3jkwuSuYlNPcQDh/1/Xp5kvjE4gTyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109691; c=relaxed/simple;
	bh=N5DMMmJ5lVitZCWlLJnlB+ZjU9uShksE7d/gHrj7X5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oczk3JKQOdEnqL3wJtdaUuuSpOB9+myz6bY/ANR97CtLUqkTpPngsCkKsJVNgtmothfUwWAxzf9gEnxyh11Z8WJPCSMk0qWQCS/Kip+EAsNskJtGhwqgcg3WV2AHf+5rVlAi7z8kIJquMwjpm0F0z2txvgr4LEUUDgIDQ90jXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E+dJnLbk; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e95346fa32aso1142959276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756109688; x=1756714488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DWcYU6uY9KTc1S160H4P3qDdzH2WP9qP0P5gGV0wL5c=;
        b=E+dJnLbk4eBxqLmsQZvB4qWMK0qSW7Ce4X8/XMw5onlmSkF+YwoLjuBcq6C6BbWHBi
         /Au8Pg6SbZoXreVBn37kQ5GRUQPmUy2/Q5LGbXKyQSIVr2JNLQUfSMcC1mW+0O2uSxVM
         TvZKoZxZ15OiflZhuhXFaIJUD6nv9QXRcnOaDqWF7x4FHw584fLL7TcWIQRfBjGgDIo3
         4Wx/ZISLGFQKZ8aEW0y5GgK9WOTPGmOnPFGsw1kzDAgJo+m7qhkPmO2GUgBns2QH7sna
         asVYSuF53LIv2aP1uyDnwJHeXwlzMtDboNktkB+oonsRLC9bS8iypWtmvVQXJUnbftsY
         kkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756109688; x=1756714488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWcYU6uY9KTc1S160H4P3qDdzH2WP9qP0P5gGV0wL5c=;
        b=lgkHWRS+bljEDqF768OBD8LlvjG8yWD5Z0q5zOfeieF9ws8hXcUKmy9ZwzxR7swXjL
         gp+j3eHaop4rsr3hhHXmrvAMr25LYjVWG0gMSKih1CYb7iO3Z5hNHLE39jnzHtof7d4m
         tL79NrF5QSUuhOlT6AwZW41sGxAe2WOsgHZMPhprjHHPT3HE8upqsnNW3iQQHeJp2Zgt
         vlsfUsg2POslbX5eQRIhfG0+mFjwRzAhI7lM8rEOno5nZZ/b+11kay+Xol9HpZHzHQlA
         P51FibQwKA9StqeKctvt3UR8Un2wbQ/vcWH8bB4mVr3iIEhwkEiMUj8Vwr05seRpuE5p
         VRTA==
X-Forwarded-Encrypted: i=1; AJvYcCUNPYphWklZShVouchlNGXmYH70EAUrunH9HeooU3xnhJ9uWldbVvubgA7kVsw2/7rxOsdXOTCMGIvjarU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEllwDnbYUE7/GjkNmxH4r5kbmWxehf3Bh6D71J5lpGq7USrtW
	HQ/ug0gtci+GEeCLcs9aVwtFG8xnEo9m9p4IsL8WrXZdFAAqTNYM+6FTXZvJMsSvPXwXLkfBwb7
	ZiELWcWtQUZ13QXlZPw6fFRkYLXJG0gXDQht485/lSg==
X-Gm-Gg: ASbGncsIdaPkX1WTlY9XIpS6eJdcMvvLfpqNxcWEponSY0uPMvyWZOgPqTFDbZi1/+P
	EEdzCxcxjOquN2rRvyRnFtLkky3iBG3w/YIIZAVAu38zyq+pxbzXUKELfXBtKy1F8PqdKFQvzCC
	0dtuP+1D9nzGGsHmPRcv8Yxa7Eb7UA/yZNqPgXiyr+D1jQUyEXeS4jruWI29NWQt0C5ejpw0HDx
	m6MYHjz8D6zQUXOTZq8kvlPd4EL3lE5VXYs8GS5DlB7xv34PFj1daCCYrz0oEQD02T4O6lI3s5W
	PVqQOxS8xuiZsiqb7JS+2whr/40voxDQ3M+zleuk1Iuq0bAwdcajFr+kMMHnbeU97uP9bHIVKJP
	sAxmS0jUu1YDv9W22JWk=
X-Google-Smtp-Source: AGHT+IFWVvOdiwbaW+PgOu91YQeRhbmYRJspNugm4twgh9eTZ4FBQF/Nt9r+Q5ljCpPo3ammbd5nMdZQIwqQDhKBO4U=
X-Received: by 2002:a05:6902:1144:b0:e95:3788:4d1a with SMTP id
 3f1490d57ef6-e9537884fc3mr7991770276.12.1756109688344; Mon, 25 Aug 2025
 01:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755969734.git.jan.kiszka@siemens.com> <9c9a688c91140b3a62c753f14b8d1eb1c87c51d7.1755969734.git.jan.kiszka@siemens.com>
In-Reply-To: <9c9a688c91140b3a62c753f14b8d1eb1c87c51d7.1755969734.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 Aug 2025 11:14:11 +0300
X-Gm-Features: Ac12FXxsCgtaaA9_yOclBjOk4hFo95aZBfORuw5aXXfV_NwfyspRIBAYs3IxwPw
Message-ID: <CAC_iWjL2HcHaz7CzvMTuHDH5TxoV+pVypLk+B0bWe7GJGvwP6A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] efi: stmm: Do not return EFI_OUT_OF_RESOURCES on
 internal errors
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Hua Qian Li <huaqian.li@siemens.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Aug 2025 at 20:22, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> When we are low on memory or when the internal API is violated, we
> cannot return EFI_OUT_OF_RESOURCES. According to the UEFI standard, that
> error code is either related to persistent storage used for the variable
> or even not foreseen as possible error (GetVariable e.g.). Use the not
> fully accurate but compliant error code EFI_DEVICE_ERROR in those cases.

Yea it's not ideal, but we are still limited by the EFI spec
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> index e15d11ed165e..8501056ade8a 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -218,7 +218,7 @@ static efi_status_t get_max_payload(size_t *size)
>                                    SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE,
>                                    &ret);
>         if (!var_payload)
> -               return EFI_OUT_OF_RESOURCES;
> +               return EFI_DEVICE_ERROR;
>
>         ret = mm_communicate(comm_buf, payload_size);
>         if (ret != EFI_SUCCESS)
> @@ -264,7 +264,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
>                 &comm_buf, payload_size,
>                 SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, &ret);
>         if (!smm_property)
> -               return EFI_OUT_OF_RESOURCES;
> +               return EFI_DEVICE_ERROR;
>
>         memcpy(&smm_property->guid, vendor, sizeof(smm_property->guid));
>         smm_property->name_size = name_size;
> @@ -320,7 +320,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
>         var_acc = setup_mm_hdr(&comm_buf, payload_size,
>                                SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
>         if (!var_acc)
> -               return EFI_OUT_OF_RESOURCES;
> +               return EFI_DEVICE_ERROR;
>
>         /* Fill in contents */
>         memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
> @@ -386,7 +386,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
>                                    SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
>                                    &ret);
>         if (!var_getnext)
> -               return EFI_OUT_OF_RESOURCES;
> +               return EFI_DEVICE_ERROR;
>
>         /* Fill in contents */
>         memcpy(&var_getnext->guid, guid, sizeof(var_getnext->guid));
> @@ -442,7 +442,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
>         var_acc = setup_mm_hdr(&comm_buf, payload_size,
>                                SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
>         if (!var_acc)
> -               return EFI_OUT_OF_RESOURCES;
> +               return EFI_DEVICE_ERROR;
>
>         /*
>          * The API has the ability to override RO flags. If no RO check was
> @@ -498,7 +498,7 @@ static efi_status_t tee_query_variable_info(u32 attributes,
>                                 SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
>                                 &ret);
>         if (!mm_query_info)
> -               return EFI_OUT_OF_RESOURCES;
> +               return EFI_DEVICE_ERROR;
>
>         mm_query_info->attr = attributes;
>         ret = mm_communicate(comm_buf, payload_size);
> --
> 2.43.0
>

