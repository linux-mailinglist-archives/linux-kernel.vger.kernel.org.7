Return-Path: <linux-kernel+bounces-784243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D99EB3388B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049753BFE3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253CE288502;
	Mon, 25 Aug 2025 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8xQuAoZ"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB01F19A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109601; cv=none; b=bWO9OjS4LNw7irwrhzzOWwEg019TmEBHUfXr1bBqosquiUuNHFK0wK4rKKhfChFoyySmINEKdrBU3rYcaMBS4NM+frFUONGsNXdMib6mhz5qFdP6Sen2LdHKDBczNyq6G/RecaAZVG3EbCSEZaXfWFBt77HyzuNAUVrmR6FOwFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109601; c=relaxed/simple;
	bh=9As1XHTb5L/s8zV4wIlufdlScsqyXCW0K3L7vWYqUx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1yfb/qn++gfiu1O1er8hZzvNLwWJhM4jd5qSQMpuq8fb1ikcRQuDeR53ee750U0gHrf9mznzakC2QaAp+dpgquP0PTA2tURbN3EBQRrwAARjLPV81rSR4YhKdjLfkXVEcP3z1JSMqQ00+lfJg1s0/tyo82jZ1FaIW/KfAPNIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l8xQuAoZ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e953b7b2eb2so845778276.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756109599; x=1756714399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kE9tDslr525GT8TE4UCW+F+vzeL9DZdGpkYioOEdI70=;
        b=l8xQuAoZT8334kJSVZhhqg6n5OB8nCGPmGrnL3nqtqkR6qTHx0pVinHLI+xroSxP/h
         7+OEJ5sVEyIr4ZwOzNB7LCfiy6yqWbayC9ysw2vKfqbIbdxjOy9uIHTTzoxWoYcN06L2
         wgF8WmcIC8UrOAWWVP3bq3/mNwS9cvMUleEiMuqGonqeb+n0+N7/dK3CHySfRix86Kzs
         Z5oqhOoEHptN5V+IUjOmeWkO/LkdBgGxh+0w8OZHOUA7KwECn6ooYy0y2+OJl1TwF29C
         jWpHmOgveHZi9Jl3TGQrhHb9xmiEzBS8WGXaNBoZGx7LhMuuuYFLGfMkVW4Ez6ywp0R6
         bOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756109599; x=1756714399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kE9tDslr525GT8TE4UCW+F+vzeL9DZdGpkYioOEdI70=;
        b=Mtk7/ym4H3OlX/eMukBjDNsz6MX84XGe4WYMcXr0PVc3CrGd250stmLwyAjBmvJ73o
         Cx57ESAnUM87nKCRlYYLlm00mmpaF4TdB1XMjcAB/8jcU7lhbpZhPYDNLtOnQkWbQQ+Y
         yxBQXg2ExB6kLbbJIqkzrhcFzopybusY8ypXP6NsJ5+QfeRG/XSOgbjoVhMuHeZ4bUsQ
         FzieAm90YUvwaV7uBgUakH9BkpXboLzTMDJ6MfRhfMprhg3GhXcgw4vjAxVKw8d8zrwl
         n66C+tZ1aWqKZb6ZIJnRwQpxs6ns4MWEa+DvSOVTCNbA+wxkS+TzLLZt5O2kOmsaBCXm
         AkHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/zddjkwu5SbqoFYdoD0ScMOOR0XeP6rQwwXJr6GISQnIBsHdEdEHJ3FF+LvuLLPV5/ra/PJijPYhOBz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0cK+Bn/hzoxJjMvafl0EotA6oV3C+dTD53gPOnEoOO0R9hEY
	YFmt5qEGYiAjZzvNKPCSsKPttw5utm+jTEiam+xiUeBJq1eY9lQ6gEz8RT81Z7rEtzu/B5Py+C8
	v08NufyIP+Gfu6OwB/QEnmAkXv1CAL/XoM9K4aYhLeQ==
X-Gm-Gg: ASbGncu/kyNH9hximKWdJt3rziHLXnkH/LgFx7czNlo/GuShrJxQ6PfQO992CUo97bS
	oBuLuMcerrk9RttZw0tnCKgyixLGNlS4rEWzeWW5egBgIiikYIMDEoAQVLLHBnwUwu7dz80fVPF
	QHAssEyohGdouFcxSUCcE3rqYM65DGyyw0C0pyACH98oWLHjDxWztGK8j9j/iIBlu0hGTczpI/6
	iaimeTFbdI+0+g1RmQ4u11FoWEkAAMricpIkmvYo1R7sJ8MwzkGkiMy77yWVBWYd89T+YrSBIF3
	H6pQrPqrmPhGKcwDa0igAGxoYAncKu/nVnPtIAC+IQUYBrWtz3MoKUW+8CL8oC6bFh4ybkshfq9
	cTf+VEda9qtA6fBtzHgw=
X-Google-Smtp-Source: AGHT+IEGNWSUEvN/jf0M25ODwIrROeMZfVy293XX2mVeTcNGmAD1yuvXYEBrlXOIQ6thEQQq9wAvtRmuUDz4vuDxyNY=
X-Received: by 2002:a05:6902:340e:b0:e96:c82a:4dd4 with SMTP id
 3f1490d57ef6-e96c82a5286mr1608514276.52.1756109598685; Mon, 25 Aug 2025
 01:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755969734.git.jan.kiszka@siemens.com> <c7ddb74b514c36ed4f612bc2125245c1f68c0a4d.1755969734.git.jan.kiszka@siemens.com>
In-Reply-To: <c7ddb74b514c36ed4f612bc2125245c1f68c0a4d.1755969734.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 Aug 2025 11:12:42 +0300
X-Gm-Features: Ac12FXxODqQo_cZ_zh8wOuDiRtnme5nRKJCVpcKOBUAcJqk49gmwpJXSRGl-WpM
Message-ID: <CAC_iWj+C+HmC=8BN+ZvGt2QV1p=+8mP8rTjT1VsUUGoCioHHPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] efi: stmm: Fix incorrect buffer allocation method
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Hua Qian Li <huaqian.li@siemens.com>
Content-Type: text/plain; charset="UTF-8"

Thanks Jan

On Sat, 23 Aug 2025 at 20:22, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The communication buffer allocated by setup_mm_hdr is later on passed to
> tee_shm_register_kernel_buf. The latter expects those buffers to be
> contiguous pages, but setup_mm_hdr just uses kmalloc. That can cause
> various corruptions or BUGs, specifically since 9aec2fb0fd5e, though it
> was broken before as well.
>
> Fix this by using alloc_pages_exact instead of kmalloc.
>
> Fixes: c44b6be62e8d ("efi: Add tee-based EFI variable driver")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> index f741ca279052..e15d11ed165e 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -143,6 +143,10 @@ static efi_status_t mm_communicate(u8 *comm_buf, size_t payload_size)
>         return var_hdr->ret_status;
>  }
>
> +#define COMM_BUF_SIZE(__payload_size)  (MM_COMMUNICATE_HEADER_SIZE + \
> +                                        MM_VARIABLE_COMMUNICATE_SIZE + \
> +                                        (__payload_size))
> +
>  /**
>   * setup_mm_hdr() -    Allocate a buffer for StandAloneMM and initialize the
>   *                     header data.
> @@ -173,9 +177,8 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
>                 return NULL;
>         }
>
> -       comm_buf = kzalloc(MM_COMMUNICATE_HEADER_SIZE +
> -                                  MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
> -                          GFP_KERNEL);
> +       comm_buf = alloc_pages_exact(COMM_BUF_SIZE(payload_size),
> +                                    GFP_KERNEL | __GFP_ZERO);
>         if (!comm_buf) {
>                 *ret = EFI_OUT_OF_RESOURCES;
>                 return NULL;
> @@ -239,7 +242,7 @@ static efi_status_t get_max_payload(size_t *size)
>          */
>         *size -= 2;
>  out:
> -       kfree(comm_buf);
> +       free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
>         return ret;
>  }
>
> @@ -282,7 +285,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
>         memcpy(var_property, &smm_property->property, sizeof(*var_property));
>
>  out:
> -       kfree(comm_buf);
> +       free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
>         return ret;
>  }
>
> @@ -347,7 +350,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
>         memcpy(data, (u8 *)var_acc->name + var_acc->name_size,
>                var_acc->data_size);
>  out:
> -       kfree(comm_buf);
> +       free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
>         return ret;
>  }
>
> @@ -404,7 +407,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
>         memcpy(name, var_getnext->name, var_getnext->name_size);
>
>  out:
> -       kfree(comm_buf);
> +       free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
>         return ret;
>  }
>
> @@ -467,7 +470,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
>         ret = mm_communicate(comm_buf, payload_size);
>         dev_dbg(pvt_data.dev, "Set Variable %s %d %lx\n", __FILE__, __LINE__, ret);
>  out:
> -       kfree(comm_buf);
> +       free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
>         return ret;
>  }
>
> @@ -507,7 +510,7 @@ static efi_status_t tee_query_variable_info(u32 attributes,
>         *max_variable_size = mm_query_info->max_variable_size;
>
>  out:
> -       kfree(comm_buf);
> +       free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
>         return ret;
>  }
>
> --
> 2.43.0
>

