Return-Path: <linux-kernel+bounces-752276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA55B17370
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D4554186A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E89A1A314B;
	Thu, 31 Jul 2025 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kowalczyk-ws.20230601.gappssmtp.com header.i=@kowalczyk-ws.20230601.gappssmtp.com header.b="nKKMUzTL"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB691C32
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973475; cv=none; b=Hygj0CQePb7Lz2vYoQQWOpDWOWyBFleuBxAwllDT+3I96+V4pSj6ud9Jy0wNHRB6CWo18TZzOgoIHwpOWPPQQELlYhbn1bJk357+CGq7Ru6bULdCRKQu7LPe6eMTNDExmXAAULJ6uGB1zstE8c+a5zti2wQFBuiHbqkyhOstZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973475; c=relaxed/simple;
	bh=iqM4xhhbwOHkl4UJj47LypM7HrB9ssmVwC795x+ckgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF6h9OWFHYrHVyGRAHpq+7ReLKXmpye/sX1dBD3MVlqTbxceoQyyaEVLIOSW+NnDuCqXVepV8Zy0CZbzRcZedkMxiHURWM9rH1Lb3FkD6F6Qtbt+1VxffVjcGlSuF0V+7/q4kpl3s5r4cpf2cokr3/lcxoL1q6077hvCEX3YT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kowalczyk.ws; spf=pass smtp.mailfrom=kowalczyk.ws; dkim=pass (2048-bit key) header.d=kowalczyk-ws.20230601.gappssmtp.com header.i=@kowalczyk-ws.20230601.gappssmtp.com header.b=nKKMUzTL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kowalczyk.ws
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kowalczyk.ws
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so1470991a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kowalczyk-ws.20230601.gappssmtp.com; s=20230601; t=1753973471; x=1754578271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRJbAub8KuCgRqOk042KmktSaTt0LegPLtY8Icpmfw4=;
        b=nKKMUzTLFSv+mVcvv2NhRartSYE1c1IQihLiCqeQc3rJdAWG5BZPmnhX5kXj3DxnDs
         Ht6VywfhwoA0xUNuWGFSroz07BbxE5oSYnFevq/Fq9tQ+yW8c3unpUzcHwaZJeGU1cf7
         5iiZRACgft6/JRR26iF1iyKcEmM5nix3fJc7hkz3cE2YS0hewuPHlgy3VrwSlefdmlZZ
         Tjrep1/Et5B6VNdoWFYKaSCttgpqoJ3FH6u+0+XWK7cNQPlwMIHYQfGTJT5nrsveGEiS
         jBnnEljHCfEv+a2yo1YlJnM7hPUyuxYO7p/A0WgCs7d1OoFezmuVGDCUgmmHGuLGoJSA
         U1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753973471; x=1754578271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRJbAub8KuCgRqOk042KmktSaTt0LegPLtY8Icpmfw4=;
        b=hp8YFaaBGrJ8PgZzCykP0H/o99oQXOwusDUBDmPxh70KoxHvk5DAXkNfE7lDbuio9y
         8udutZ9JjIB79HuLjsAR7MGrFcpcIPY5zMHkwocSSQisC0PDGzQUIs92X8r7KaD7WVS6
         M45dzTw+/ykpZvCO5TIUds4693ttJZE9C1/2IkOV0rTPMOOqTo0mJQHVCsNlcfaAgssW
         P13WRqYUHhzdZ0rSZ8bB+7uwnhIBy2oiZk86+3Pcopg5jd84a7YYjYMqMHGf+SJwk5hM
         v734605z9EBnJDbt3oHclcDtcyBNyNMdzEV+uz5ICmHWxc1SfpnEoYlEWopxkwm9oa7i
         QuuA==
X-Forwarded-Encrypted: i=1; AJvYcCW3Us9OSbGm2bIiqbFo4VodQCvf9RLMSgWFdI9go1sRVvzmSIh2eGM/q5n/IvZiM1MV/TiI0UZSCWnpSw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvsIjNmbSVaftTK6/zOkrNWY/PiM8hyglUoEUZtAdeLaFaYFtV
	sipJ6Fh4NbOcJZGVRwG461Bq7efV+1QcVXVqAVvtzjYqW3JMV0fbvf28Qq2qe8uX2xSIoZ1H7K5
	uGa62bRGeUvxzw2OZmSAx2QuIyfpKmxxgLHMZ8srDguV+tbDw6t+5lJCD
X-Gm-Gg: ASbGncvUu+ejuI6vGTYYS0RJhfA66RP8qkos0U73BV4RpeDdzV6f20y+YDpF2Mtsunj
	vXgCGGgkaaBatn/y60JP3f4PIuXhxbT6NR2SnNWI4qopwyya9RYAv1HMuTjyOQ+HWxixyRKwU8L
	atuvgV6Jxi8/gfABbDKObYQ8TURCa2qD2PEo6LFW8WB14moYHD4c6UAUhHygfeQnpmnsrp7kzTH
	i3U
X-Google-Smtp-Source: AGHT+IGZY7UseRYSFQBaSqdhffcEIF7jCfDrD9+0HtI82aHPApXaJSNDz5JLaBTvoWHQDv4aQl7vq9zDoYUPbWSh3NE=
X-Received: by 2002:a05:6402:210a:b0:615:b6b9:d859 with SMTP id
 4fb4d7f45d1cf-615b6b9db0dmr2004485a12.3.1753973470621; Thu, 31 Jul 2025
 07:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f7e64e99a3a87a8144cc6b2f1dddf7a89c12ce44.1753926601.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <f7e64e99a3a87a8144cc6b2f1dddf7a89c12ce44.1753926601.git.baolin.wang@linux.alibaba.com>
From: Patryk Kowalczyk <patryk@kowalczyk.ws>
Date: Thu, 31 Jul 2025 16:50:59 +0200
X-Gm-Features: Ac12FXz136963mYuJ5YCEu4SeKKHx8OQYOh5muD6VLWBOteHGPZjvJkpeAM4OC0
Message-ID: <CAJCW39+3whWNZ7PV606cewqvdGrE18BTbnDLZ_Py=6nvV+vseQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: shmem: fix the shmem large folio allocation for
 the i915 driver
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, ville.syrjala@linux.intel.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That patch solved problem with the i915 performance regression, so the
previous patch for the i915 driver shoudn't be merged.
best regards,
Patryk Kowalczyk

czw., 31 lip 2025 o 03:54 Baolin Wang <baolin.wang@linux.alibaba.com>
napisa=C5=82(a):
>
> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"=
),
> we extend the 'huge=3D' option to allow any sized large folios for tmpfs,
> which means tmpfs will allow getting a highest order hint based on the si=
ze
> of write() and fallocate() paths, and then will try each allowable large =
order.
>
> However, when the i915 driver allocates shmem memory, it doesn't provide =
hint
> information about the size of the large folio to be allocated, resulting =
in
> the inability to allocate PMD-sized shmem, which in turn affects GPU perf=
ormance.
>
> Patryk added:
>
> : In my tests, the performance drop ranges from a few percent up to 13%
> : in Unigine Superposition under heavy memory usage on the CPU Core Ultra
> : 155H with the Xe 128 EU GPU.  Other users have reported performance
> : impact up to 30% on certain workloads.  Please find more in the
> : regressions reports:
> : https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14645
> : https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13845
> :
> : I believe the change should be backported to all active kernel branches
> : after version 6.12.
>
> To fix this issue, we can use the inode's size as a write size hint in
> shmem_read_folio_gfp() to help allocate PMD-sized large folios.
>
> Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
> Reported-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
> Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Tested-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Changes from v1:
>  - Use inode size as the write size hint, per Hugh.
> ---
>  mm/shmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 41eb4aa60be5..e1e5d5f7f58d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -5989,8 +5989,8 @@ struct folio *shmem_read_folio_gfp(struct address_s=
pace *mapping,
>         struct folio *folio;
>         int error;
>
> -       error =3D shmem_get_folio_gfp(inode, index, 0, &folio, SGP_CACHE,
> -                                   gfp, NULL, NULL);
> +       error =3D shmem_get_folio_gfp(inode, index, i_size_read(inode),
> +                                   &folio, SGP_CACHE, gfp, NULL, NULL);
>         if (error)
>                 return ERR_PTR(error);
>
> --
> 2.43.5
>

