Return-Path: <linux-kernel+bounces-868549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D91C05777
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BF23B2870
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774598F40;
	Fri, 24 Oct 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGclg/3c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D0B30CD9B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299622; cv=none; b=JChwhnAWQ8lMxELnHsa2mmw2TuZmCmVe8EpUGkmo91McB+MPMsyvTIZuzU3CwKpNbCHqxRnaQtmwzlHBT86lnYrSysz0su4ZxX9/0eKK7pDAgp2ltSU5jBPLZCuirc5ol1aiMb8uDsvO95etzlZXHf0oxoDz9mONL3obvJS2/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299622; c=relaxed/simple;
	bh=2svO9jFdsPmFpDev1N+tmZRzalxhNtErGE/4c5iY+j4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nccPqJ4tUWQ4rEQ+MD9YLUToXMS43cRdia3gyz5MtXo/uMHI4Zz/I+7uifZQ7sjc0MH0yYs/BN+xwxgLBTDnx+nYBNKgONEdwzaRU4iqKzHWHAxDHS4hQhH+W3Vu0QiHDmHjvh4gzU2q/VquOukkAPPG5FoNBr1bUcTeWYi+orA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGclg/3c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761299619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfM4FRUtlcJmtbsNTeaFiHY2x28gTtqtBZeKbwh4hhU=;
	b=OGclg/3cjueSnVEjQr7FGcCB3ntEbBt6DICo9/0nH1jq+eds2eY29J0ULY36y/IQm/sMOk
	7CegAtH9hvFkpkPIRKhiUbQUH94uz1ABd1AiKDBSlVEl6AVY/qVzeVOwk6Z4EZ+nyyzZWj
	NUbsAP46TkyMkQknlU3FXt+dTH49YBc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-TKYtFmcrPYOXej30ddpWAg-1; Fri, 24 Oct 2025 05:53:37 -0400
X-MC-Unique: TKYtFmcrPYOXej30ddpWAg-1
X-Mimecast-MFC-AGG-ID: TKYtFmcrPYOXej30ddpWAg_1761299616
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47111dc7c35so14675265e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761299616; x=1761904416;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfM4FRUtlcJmtbsNTeaFiHY2x28gTtqtBZeKbwh4hhU=;
        b=MqL/4imYI6jI0W1CxeYidicL7J2t1eVHKBDMg9zJ+93m6I3Hln6hg4QqtpsHfyi3Za
         ivbFcOjSKjRBh5NYnwrYq8AKus8qhgKE2uCOyuyK6byjcF9VVIdIzoAOB0Uj5UyInBrs
         aGaoe9HkeYolHGvVOEHL7xJjjkygZU0sOVUWG9wfaHZVIuxbN1wWhoo1d/28RrhJ+aup
         nQZSc25MB16zrwPEayfTpM8o9q/P7Mt3F8RCXjQv4lLRiSKz4CTzQ3GKbG1miQmtLHJj
         07MKc9zt8S7QFle+/ZeAWjcKlFa4g1pEpYyZtM82yBZGHiLfaAxK/2kQSXLFiwNbwrE+
         92Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUHDt70J7WnKz/YnW+JYo45p4A3nPoWK4cOfW24Y5TmFuduDiDqOcpVFivYRR6pfsyDxZpdVB89rg1Fn40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4RGwbaiqSi5glRcJIcsEPZenvYetd3/yhHFMAUhBxLpBdKRh/
	u0eciYMee38F8WOZrIbdH6ZkXhB3qv28DssA3tGqnlM1nhldylo5SJ+jvCI36/LMTBapm8Y7ZG1
	901uRjxefH3q59n+f4JGmPjX1xDiYGocKVJ02ZZBFubDbcqr8UGH2OLeG0nzZiiadSw==
X-Gm-Gg: ASbGncsw8HY41nSo+va8GP+wL6Blh6Y8da8n4Ck12Dxe7RQiqWXezqwdLF55wHD4jkN
	JxHJtVh1Ck4DrVtUboYhXiqGUQ7FN/gdqj2ZWRBELofCdpztnhMm5m5t/DKJFckSWn2ANrqjmPl
	a02EO8OIoRyBeDtlnzniTY11jQ6iArc/iXQk/7TPPOlR6whiKPG8gan70pCe69Torh29c7l0M5O
	/q3OiRiKdl520pK4vOitl+jhQED5CmdplFnptQ17f7bl9+CDL5J36lKaBZc+6YnnrfG6LprB5Yn
	v5dZkcG2+htqr4fiji+7EMmdBxBOK28yCKsYgvzlXLPKQQ0Q1VbGVv7yi8b4b2bIzEsKxh1L7Nm
	0dGh2749HK5iLglK69ijjtOdXZ0S5QwpgC3d6jeKTqckCydZ+YiQdur/AbQ==
X-Received: by 2002:a05:600c:1ca0:b0:471:168f:717a with SMTP id 5b1f17b1804b1-475d2e84559mr14828405e9.16.1761299615852;
        Fri, 24 Oct 2025 02:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrWpIk5fPtJQaBUOqbuLg6LOKynRISy3ybOJ2Vo42hxf7aA0YpLztkvhOtyOyFfq+o4GK3XQ==
X-Received: by 2002:a05:600c:1ca0:b0:471:168f:717a with SMTP id 5b1f17b1804b1-475d2e84559mr14828155e9.16.1761299615418;
        Fri, 24 Oct 2025 02:53:35 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494b22536sm80851935e9.5.2025.10.24.02.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:53:34 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org, jonathan@marek.ca
Cc: linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 3/5] efi/libstub: gop: Initialize screen_info in helper
 function
In-Reply-To: <20251015160816.525825-4-tzimmermann@suse.de>
References: <20251015160816.525825-1-tzimmermann@suse.de>
 <20251015160816.525825-4-tzimmermann@suse.de>
Date: Fri, 24 Oct 2025 11:53:33 +0200
Message-ID: <87tszo8w2q.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Move initialization of screen_info into a single helper function.
> Frees up space in the main setup helper for adding EDID support.
> No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/firmware/efi/libstub/gop.c | 76 +++++++++++++-----------------
>  1 file changed, 33 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
> index fd32be8dd146..02459ef0f18c 100644
> --- a/drivers/firmware/efi/libstub/gop.c
> +++ b/drivers/firmware/efi/libstub/gop.c
> @@ -367,24 +367,31 @@ static void find_bits(u32 mask, u8 *pos, u8 *size)
>  	*size = __fls(mask) - *pos + 1;
>  }
>  
> -static void
> -setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
> -		 efi_pixel_bitmask_t pixel_info, int pixel_format)
> +static void setup_screen_info(struct screen_info *si, const efi_graphics_output_protocol_t *gop)
>  {
> -	if (pixel_format == PIXEL_BIT_MASK) {
> -		find_bits(pixel_info.red_mask,
> -			  &si->red_pos, &si->red_size);
> -		find_bits(pixel_info.green_mask,
> -			  &si->green_pos, &si->green_size);
> -		find_bits(pixel_info.blue_mask,
> -			  &si->blue_pos, &si->blue_size);
> -		find_bits(pixel_info.reserved_mask,
> -			  &si->rsvd_pos, &si->rsvd_size);
> -		si->lfb_depth = si->red_size + si->green_size +
> -			si->blue_size + si->rsvd_size;
> -		si->lfb_linelength = (pixels_per_scan_line * si->lfb_depth) / 8;
> +	const efi_graphics_output_protocol_mode_t *mode = efi_table_attr(gop, mode);
> +	const efi_graphics_output_mode_info_t *info = efi_table_attr(mode, info);
> +
> +	si->orig_video_isVGA = VIDEO_TYPE_EFI;
> +

Not related with your patch but I dislike so much the name of this field,
since it started as a "is VGA?" bool and ended being an enum afterwards.

But I beleve we discussed this already and decided that it would be too
much churn to change it at this point.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


