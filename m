Return-Path: <linux-kernel+bounces-817881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3796DB58807
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6B954E183F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9E42D594D;
	Mon, 15 Sep 2025 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4YwMAfz"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087ED2C0F64
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977640; cv=none; b=SuZGWPNmWbQnctmhWDeIgznXlaaEab31BSdJ7bqvvjSGJsQdvq/MLFZwoInCU2vMX5ztnZk6liGNqG0dEYdDvhBAU6XRkc2+0dLB4OzbRGm19eJmwuSks2iLkfdlQoMNTKpdvnM6pR+9Hw5CcjJHMVZDfJjZe28qDFmHxeqJjWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977640; c=relaxed/simple;
	bh=LN2djmX+oWBpW9P0SQsUvr3K6xqKGvT+SBfNb5FBCfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RroR36kkWB6WBnfTnYxeDBylOsCFDJjMZXW2k9gHruHg8z3hXxpQetms6aMACMRrHpxU+mret/p/bPko5zNcJGvLL7R7shpM8Tfmbr4741NdHZXTpeSe477W26cNDBzUlQtECIO+eb/IEWwR2wHvg5N7T0kD/a9WJ/dd0DrfMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n4YwMAfz; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-827906ef3aeso226082485a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757977638; x=1758582438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntdt+Fw1ooyH2+q0/xC8jx4AecQq6NmyBnAlPcFGaz8=;
        b=n4YwMAfzy2Zh3g4Hv6xSWn/QT6VpQ8TEvyNIZ9CFJd+xyAUolKdhH+INOrsieljURg
         zTgkBHR562u8RTcgIPXZO/jN1Ra6d8jNEzUJfi++1Ht7LxoyEXdsFBzQNtfMMkgLIiS4
         bDxcumYxmwjiLb/Rn/c2U3Q1VkLepNEvJBQbe5sK1rf4m2N29I1+S6VitW7hSOKESWfY
         C+/4D7EyGiqkLMqQt0Io7JfRFLFEfq8WWxiJN2RPv4lJAS3NrUGV/PY5wc17rkA/fZMP
         +qdt5yAWt9xTOaxPFOAiskqHfMSVXm6FevMUhzk9pr6Y5LhsvX5Is4xh5+HfiS15wcbw
         CqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977638; x=1758582438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntdt+Fw1ooyH2+q0/xC8jx4AecQq6NmyBnAlPcFGaz8=;
        b=RygUjTNDMuZ+mWxOXjk+YDA+gum6dsZyO/4jHI7+IBvRPPu13fJ5OOZH9MhrjPjVca
         MWEb/0CRtFMawHLYLxIUHWx3jk/l2+pKhU5D8cB2H1q+aHjWDrkmd2exQi0ueNuPLUcV
         8MygEikPQ20Eoy9aPz3UlMNOmLPHrB/EzlS6cZV1sR/pEa3+LSr3nU6eyGH/gNY5xQAn
         /pTLdZvDm7RRpIit8B3flu1G9jra0k6RoWpgpIW7Lh03BLsPP+vg0brrFajtuROlE5bQ
         QOpWUcNMWXxymHZzwOniwJQsmUGfFP5Ie6L7XWcls/AFosO3+iiSWnGHCAtm35CJM2N2
         XDnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHB70/yIwef8ok3BoGEJZK5xx/mIYFF1g0Us3Y1jJJXpRIVCBfYUwedCl2tWiEBQzM+k7kI4Z9q/pCvEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXLsua7Viq2T3wZfq/nzzbdUIs6zdMZMmXGj87SCXKfR9QWopW
	lIm4KGwdQaMb64XnoWf/vgAZHO9skXjq8dDcMk0tOBwxRaOWCBX9M8yzVx/vZ2CuZUazl3KbTtH
	LWdMCqg==
X-Gm-Gg: ASbGncv7aqNAq91f7huLz3mzOVHlct8e5nUjKpAyDL8xbUUqCyGtdVPxnhV7ZoLF4Q+
	UxDmM+q6Eed2VsPXc0wUVmp9SrKVCzUsbZemu4YLdO8DcS+U966O596EfcUIruJlDDMJVk0KQN5
	aTsFUjvyuIo2A+/qZTetaVj20FPDSMVvfR0QDTayjSbVHsI+tIX1FOAel8CpBek6tDfgemb6yEX
	eM0jx1fe3Tjj7G2f9IRB/D2EukNz9FKA66ImKqwvj4IH5xK86fQwm2Cz6a5X4JRMbGezfXnkYlL
	15QkzTZSFvIWUFZL90CeGyHmcmTAiVhjju+nw92daR2ScoTzs5DTcBiERpAofl1OzVWR/ai9wCm
	oNEvhKePLKdZXa1SHPGI+QRmF6ZQOL8MSFaIV26FjOxVkFwb+Kbol0vQD0hZ22qUAd+QAPp8=
X-Google-Smtp-Source: AGHT+IEoi1lVcF4aPi9zcBQfqqjlIJGn2T6EJO2nM/jlo5+f9d6XecVONNJlc1ldgD3Xd7nmpRVVIA==
X-Received: by 2002:a05:6e02:12c7:b0:418:4323:921f with SMTP id e9e14a558f8ab-420a568c3a9mr147338935ab.32.1757977624725;
        Mon, 15 Sep 2025 16:07:04 -0700 (PDT)
Received: from google.com (138.243.29.34.bc.googleusercontent.com. [34.29.243.138])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-423f9383029sm37354345ab.32.2025.09.15.16.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 16:07:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 16:06:59 -0700
From: Justin Stitt <justinstitt@google.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] drm/nouveau: fifo: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <fksv7eprcqnb55n5zllfyhk7ynx6zgbeuqtuoimbpgamguyodh@niwjdhicah2j>
References: <aJ17oxJYcqqr3946@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ17oxJYcqqr3946@kspp>

Hi,

On Thu, Aug 14, 2025 at 03:01:07PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix the following warning:
> 
> drivers/gpu/drm/nouveau/nvif/fifo.c:29:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it. This overlays
> the trailing members onto the FAM while preserving the original
> memory layout.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I took a look at the modified structure layout with the union from the
macro using pahole and found the layouts and sizes to be equivalent --
all the while fixing the warning you demonstrated.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
> Changes in v3:
>  - Use the new TRAILING_OVERLAP() helper.

There's really starting to be a lot of these helper macros!

> 
> Changes in v2:
>  - Adjust heap allocation.
> 
>  drivers/gpu/drm/nouveau/nvif/fifo.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvif/fifo.c b/drivers/gpu/drm/nouveau/nvif/fifo.c
> index a463289962b2..b0ab80995d98 100644
> --- a/drivers/gpu/drm/nouveau/nvif/fifo.c
> +++ b/drivers/gpu/drm/nouveau/nvif/fifo.c
> @@ -25,13 +25,12 @@ static int
>  nvif_fifo_runlists(struct nvif_device *device)
>  {
>  	struct nvif_object *object = &device->object;
> -	struct {
> -		struct nv_device_info_v1 m;
> +	TRAILING_OVERLAP(struct nv_device_info_v1, m, data,
>  		struct {
>  			struct nv_device_info_v1_data runlists;
>  			struct nv_device_info_v1_data runlist[64];
>  		} v;
> -	} *a;
> +	) *a;
>  	int ret, i;
>  
>  	if (device->runlist)
> -- 
> 2.43.0
> 
>

Thanks
Justin

