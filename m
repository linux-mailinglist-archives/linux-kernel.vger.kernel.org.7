Return-Path: <linux-kernel+bounces-842177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959B0BB9282
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 00:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453D33AD27B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8B3243954;
	Sat,  4 Oct 2025 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCMH1+A3"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D8F9C1
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759617626; cv=none; b=Du/DN2POKM23SlO1dBqyhx0FaK1xWQ4B7oLY+fXagzjjqn3t6sryRUDbB1B2+CkrRVJe3vlb0yLUhzDks9973Vp9v6pfY4gE5g/KmzP1nNOpBnm1Zrpp4ZxDEIZFOAwnGLyKANdKsJy7GSSN3tcH13MlKv/JzMxG1gfA31Qy5Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759617626; c=relaxed/simple;
	bh=Zdzv8LqE1xV8irEczQnr5M3hEcuJkYOP2kFHEQM1ImE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjwk3gg89hPapHANfWmFUvXdvXShuB/pTD8YLvQuQMcgF1e8AbWXW4c+X53DVBGLvGFE9B2X1PDWNVrdO9TIFeujK2yy39PX75zR8DikQhDx6KKWVZg0jOdvZhmY2dOsz+yLsHjUHIf2TmqzDtRUqJJ7BUuRgqjgA+wNWlyEMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCMH1+A3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-269af38418aso43029005ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 15:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759617624; x=1760222424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bOAdntz+KeAlO/SvuA1JcD8OWmt9u//UdVphsQBdXps=;
        b=JCMH1+A3t9UG68byFsy17Mm1obo032RbrbLzfft/T5wac5hSIkjuTQITjzMdT4T3gC
         B80e8aLAD9v1RWfM6Ga/QKLR5iPSBEaZB6pSoBgxXljEUD+t6/M9Rr8OSiFG3m189zRr
         LF956tqU8OXbra4hnI/w0/OWkikj5sTi5lLmIjgs6xYn0dnT2/LDJkYmb6omtgGT/l6w
         eRfU82NNCaDDpOnNE5V6la0DUHrRe9D4Fjv4pCrdD09dKNZAyUvmNVqht8HkwJlbTYEq
         w/iuYCmBTjINdtq6Xl9vV3z8pdWBE161BivdI9xzY6/4ZI1Ws/IeQF0bdei3JuUaAEX9
         INAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759617624; x=1760222424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOAdntz+KeAlO/SvuA1JcD8OWmt9u//UdVphsQBdXps=;
        b=qdI4F42ubkxzV8sHg9UypYcd7RKisQj+3PWk9+DA8kxqmTiUGQMAbtOhmRas/aFuF/
         VKHqqgbbnm90YdWeNsGQWVYW9KpNuQ5NZZlSZy+x+O+KaHuDWCuA39+TkebqRqQkIbrF
         YmBPQm47qMkoZssBG9sY2gtt6cY8kglvk1hyzuiuPJOIIDro3qMnxPCRjkRyC6Di+tB+
         8nWnWrt3Vun6rhRiQJBFwSnz17mB52AwP2Lh9ogZmrvRoC2SBh7YncmiXmEG3LSjoWWd
         Zxsfe7mq5Hsxzb3gHkI0wO0NElwuymaCMsvFJj7UKnYtfRSl9qqSV9uzN11lyvx/VJZd
         GIJw==
X-Gm-Message-State: AOJu0YxVJ/OZ/jvFs9jhvbCFYpTg59Wkoxrv+II5pHAwP0th55s3mro6
	+YjpaWQbPVCskm3f4wU1/CwMHdhOkHmkrd+Pz3GphZkxc+22b7RHgF8Y
X-Gm-Gg: ASbGncuH4mSacAIHHMYm68aYVzXmwbpnxIfOFPx5fA6Af6NGWYxthEZlXjea8OSjC7K
	QsnEPO/9ueOw3RnB4iCvH7Etc01ERN4zQ1uW21ueN5U2lnBRBpdQtK1zbXjh7idXaOImrQsnrUh
	eQ3CJVHtnQul8iq8JwKZGpf7YgZMx+Sa1o+87A5s/uYB9vK+FRGch8cYnR4hyJn0mR+uTvB4jKV
	pAJPco8vHtvXP5Zczj0L9OGoBZ55PHszxVQ7EI16r4gmDs6bNydFBvnoD+RdQfpJm9HsqaC+fkD
	anOQF4/7HKRg/XcxKPNErZXVSXTDCChsFO1c37tjfQFP2dnK4tkxlBvNB15eKCRZDeIkbdo+gsG
	5i8tenErg6xTuA+ZMURGftwZrK1qZ4cBCTYIDG58rFq5rBB6sMM1LMgACjKRG
X-Google-Smtp-Source: AGHT+IEEuDpKzQXtVuShc4pJf9BgCPzJ18iq05PWmkh13oJnHgXyYPdarqa0eRgaRYG+SwX7DVV9HQ==
X-Received: by 2002:a17:903:28e:b0:270:ba81:14d9 with SMTP id d9443c01a7336-28e9a693fd4mr103604355ad.36.1759617623667;
        Sat, 04 Oct 2025 15:40:23 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d111910sm88078525ad.18.2025.10.04.15.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 15:40:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 835BE4233433; Sun, 05 Oct 2025 05:40:19 +0700 (WIB)
Date: Sun, 5 Oct 2025 05:40:19 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: =?utf-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Melissa Wen <mwen@igalia.com>,
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?utf-8?Q?Miko=C5=82aj?= Wasiak <mikolaj.wasiak@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Christopher Healy <healych@amazon.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
	kernel@collabora.com
Subject: Re: [PATCH v3 10/10] Documentation/gpu/drm-mm: Add THP paragraph to
 GEM mapping section
Message-ID: <aOGiU77k1XPb9W9M@archie.me>
References: <20251004093054.21388-1-loic.molinari@collabora.com>
 <20251004093054.21388-11-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cgdVn3+TYG3JLZOy"
Content-Disposition: inline
In-Reply-To: <20251004093054.21388-11-loic.molinari@collabora.com>


--cgdVn3+TYG3JLZOy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 04, 2025 at 11:30:53AM +0200, Lo=C3=AFc Molinari wrote:
> @@ -290,7 +292,7 @@ The open and close operations must update the GEM obj=
ect reference
>  count. Drivers can use the drm_gem_vm_open() and drm_gem_vm_close() help=
er
>  functions directly as open and close handlers.
> =20
> -The fault operation handler is responsible for mapping individual pages
> +The fault operation handlers are responsible for mapping individual pages
>  to userspace when a page fault occurs. Depending on the memory
>  allocation scheme, drivers can allocate pages at fault time, or can
>  decide to allocate memory for the GEM object at the time the object is
> @@ -299,6 +301,19 @@ created.
>  Drivers that want to map the GEM object upfront instead of handling page
>  faults can implement their own mmap file operation handler.
> =20
> +In order to reduce page table overhead, if the internal shmem mountpoint
> +"shm_mnt" is configured to use transparent huge pages (for builds with
> +CONFIG_TRANSPARENT_HUGEPAGE enabled) and if the shmem backing store
> +manages to allocate huge pages, faulty addresses within huge pages will
> +be mapped into the tables using the huge page fault handler. In such
> +cases, mmap() user address alignment for GEM objects is handled by
> +providing a custom get_unmapped_area properly forwarding to the shmem
> +backing store. For most drivers, which don't create a huge mountpoint by
> +default or through a module parameter, transparent huge pages can be
> +enabled by either setting the "transparent_hugepage_shmem" kernel
> +parameter or the "/sys/kernel/mm/transparent_hugepage/shmem_enabled"
> +sysfs knob.
> +
>  For platforms without MMU the GEM core provides a helper method
>  drm_gem_dma_get_unmapped_area(). The mmap() routines will call this to g=
et a
>  proposed address for the mapping.
=20
LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--cgdVn3+TYG3JLZOy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOGiTwAKCRD2uYlJVVFO
owsBAP926UwrcUZLpaNBVlMMMAJn+GCE/YTh2qS92wDMr5wDhAD8D6FJXmT5X1j7
e7eeG3goT2uCJaiZG5r1107jYRzKSAs=
=vdd1
-----END PGP SIGNATURE-----

--cgdVn3+TYG3JLZOy--

