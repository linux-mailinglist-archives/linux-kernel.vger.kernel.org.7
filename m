Return-Path: <linux-kernel+bounces-778218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC65B2E2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C802B166105
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C725322C9C;
	Wed, 20 Aug 2025 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab3y7CGv"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F872634
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708667; cv=none; b=lB+yTRiuGtV+XjjvdgUxDmzuRccBj+BuFOmZV82+2CmE2leU8aKVBPgmMab7ff0WfEtLWo9K4BYOyD9h8rYMOXUXoPuxazalpdmrYbgPRydTWZrltf2vAE0w4nZc6xtJEglHvTd7ylpfnB0C9QS2XqquivGOPhT49fU3I2JGqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708667; c=relaxed/simple;
	bh=ov9NNcH3lK4jHG94Q9fLyQzwt8vjlm7dLd0hHCJM4w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3vrtz0imIJPsAyooJsTL/ZuyTZcDRJnT2zfAyF/zWw7V4mfZ2Qhqd8zNxB3JwyEi0gr6lhpbb1A0vEsWzLuaJ0Brx9OEUrff2kBTCmUrMeROjGzA0fkarRKcr3sVU6OfSrWXYPGwmjF5sgUw8wU5e7esFR1onC6y3FLDxm8Bws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab3y7CGv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326789e06so128279a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755708666; x=1756313466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hJZ5yF6MT93cQ2eY07VpZtdRSNWFWGaCLBXg7mgNuIg=;
        b=ab3y7CGvbUqJ6AztP8/Gyv52DrXIcgb38SRBU4CaTmGbHN6v3DcscmYSub8lgfZece
         BqCmWZq8EN5CCRhkF8iGqMCl2d0bl9JV1H3dhOw88yGTFNQxfoNx5KuNPwtdiXA+Bv6R
         TYMYBRnpIbbIRgl9+4GmYKRxBWTzIG4MhC0JOXzxb47cTNTjcTzzxVr5JLf0Rxq7FjUV
         zmYWb8/MF3R0JsxxIzGtkGFiiL2HBvqHi/vQetBaVMfoFIumZ6sFMvHBW9hilLM73cjH
         mmCylCydQ3PxBVCUGbDNSSMBOqoCpL1hvJ6kg357PGw3tJrRNHlQv1ByvZWyzCibkB/5
         pm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755708666; x=1756313466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJZ5yF6MT93cQ2eY07VpZtdRSNWFWGaCLBXg7mgNuIg=;
        b=B9oVDDMaJIQFHTIM1iI9NBsa/dzs/wR8lp5MUXWSPMdo0UVgYCB8LBx+uqVcXL7Gs2
         kUETtCezHKjjjNlx3iPuq3F8lfBeskli5ElrcsQfdH87jsHKJ4Eh4ZsrtzjM3Kj/9l5m
         L0Sb5p3nlgEKIs7vDkiQwbhVdknPnErPTTkGuceeAmCO6Tnk0fLug5jNkEXVPTovYd1R
         OB8VaXRtmWrszc+Itq7bDs9NdUQhFKDnhliS+U+VKSHLj2E3dUEU8ePmDT33uhODMBHc
         f8s2R5uGSuV0czbm4rddGS/2CUF35E3gWq3p3qiQLM+rlgP5ImgFqhf9OjNngVpp0Z/m
         FIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7ojgNxVjU34mEC8LWMVjwTNWWwZI0KjjpGWRryik9q1lERjCsodRacCtSACuH4X6fd4zJkSOYGQ9iM1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPij/hXrvkWAk1Bx5Im8eGJYY+5AJA4wV4P4OFtEg8+fHAD8Rq
	iVA1ZbwFwI969+ETqduz+ABDK1IDSONwlyRxdL6jdMndNMVqvm26r/w/iKvixpWt
X-Gm-Gg: ASbGnct+fWuavjtOLQTvpiafxzQFEwayS8uORay/qRynIRNpCCQKqJ6XPk9QOdb8loy
	oKJMXETYfon3UkLOMKvS4BMdc3eddO6bFvBQtX7b+W1PPanCc2ca2gKBs+Sb9gUAtZLuRn+B0z1
	XYU9tggiqHuDNSqQ6xOLEevt5t48Uqskr8UOBYhc1IKODsQ+FV1IGQIoeYXl0Ej2jBeLrs0WI75
	XfgghyYtzSVvk15DPg4sIrm/Sll+f1IbbWfsy7uqkPWii0zVmPsbr4MNy6hsZx1PNX0sPmrS6mH
	5XKIcn4YDlWquCnM8M5S+Mo2EkSbP/KrPQsYtPJHbOVJb9UjwKy2EynsXzlDq7sBVjf4pIn7cRW
	kldHL3FfTS2SmrFckEQ==
X-Google-Smtp-Source: AGHT+IGoxAmu4xxfpyv6iOKZvfO5x7LR/lkwmDmB5TsfrMBGncsh2UHwKp/rA7M4iaeIKiv0reOGwg==
X-Received: by 2002:a17:90a:e7cf:b0:321:c81b:29cd with SMTP id 98e67ed59e1d1-324e12e819dmr4255157a91.1.1755708665593;
        Wed, 20 Aug 2025 09:51:05 -0700 (PDT)
Received: from Terra ([2001:df0:b240:b5e:abe3:8cfd:3fd8:5d8e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324d335c4f1sm2602720a91.11.2025.08.20.09.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 09:51:05 -0700 (PDT)
Date: Wed, 20 Aug 2025 22:20:59 +0530
From: Athul Raj Kollareth <krathul3152@gmail.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org,
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: clean up minor codestyle issues
Message-ID: <aKX8835xMtatEHcy@Terra>
References: <20250813062109.5326-1-krathul3152@gmail.com>
 <39b17698-a1ce-452d-ada5-5c3741e888b2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b17698-a1ce-452d-ada5-5c3741e888b2@collabora.com>

Thank you for applying the changes.

Best regards,
Athul

On Wed, Aug 20, 2025 at 01:41:01PM +0300, Dmitry Osipenko wrote:
> On 8/13/25 09:21, Athul Raj Kollareth wrote:
> > Fix codestyle warnings and errors generated by CHECKPATCH in virtio
> > source files.
> > 
> > Signed-off-by: Athul Raj Kollareth <krathul3152@gmail.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_display.c |  3 +--
> >  drivers/gpu/drm/virtio/virtgpu_kms.c     | 20 ++++++++++----------
> >  drivers/gpu/drm/virtio/virtgpu_object.c  |  4 ++--
> >  drivers/gpu/drm/virtio/virtgpu_plane.c   |  2 +-
> >  drivers/gpu/drm/virtio/virtgpu_vq.c      |  2 ++
> >  5 files changed, 16 insertions(+), 15 deletions(-)
> 
> Applied to misc-next, thanks.
> 
> -- 
> Best regards,
> Dmitry

