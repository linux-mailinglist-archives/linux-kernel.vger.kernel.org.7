Return-Path: <linux-kernel+bounces-723537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2A3AFE82F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA4E169AD1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0BC2D97AA;
	Wed,  9 Jul 2025 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+qeOHKx"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680132DA74C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061621; cv=none; b=ftrcgk9ef2wOrgQEGHui+xji+Yf7+OFm5uXFQzoFsxGzW6cvZ8XDZLRZ2z92zx3D4/7LsnvGuV6pSCrzSlAVdjpq1X0s7UdTlQlQ6MnMZGTj3AEdrEgYascALcmA9PWCYoqekI+iph1UhaqQq8wZmnz17S4QTDpZ0ZLX9WNGN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061621; c=relaxed/simple;
	bh=jyvsJyczQaLf282vmFZnv+xAwrXzu341mqa655zSiTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXoHt+U2rxtWutd3v+yfdXfjKtp+4+TdGesXnJV/vE58W+zXMpPTP78JCyXTtg5jMypUfJV6quNaj/53ajOOK91tsKh5Z/On67cMLmR+ojJtE7hi4Dx4lWA7Z8rRGnCdlhV/VAMsHY7WkoeUyqa+CyvegdNZ0zuW/w9CFVydh6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I+qeOHKx; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e82314f9a51so4280068276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752061617; x=1752666417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s8WkrJdPByInIrgC1CCzpZsAnkTo8xBFpZM0PRv7l78=;
        b=I+qeOHKxwp0YiGbsp3UG7Rtk/KebW075KTQjyQ+N2/uL6Wyy3GGCL0f40WpITW2+Jz
         nnaLWvvytyxfQhKrcK0qvHnc3S/WGoubiduSLKulst7oNZxhCI0rJakZsvj0CQL/cF9d
         Aqrkgv6x9Wjesj4lWMiiM6SXdQtcxNx2laXfV613vIYeM3ZP7v5hpuOfdIr+BoBqTHbi
         VTCviLawpyi3vtEQ8tQyBTLGwqKouijnDbbJW+mE7OSmEQ6My1ZwLDoad5L5891WQ5be
         Tptby5hnN6I6FToG6PbaM7UzElgBICV90++FVC+oQjMDFm4F1eBUZl5/Me8Pqp/DY3r4
         chjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752061617; x=1752666417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8WkrJdPByInIrgC1CCzpZsAnkTo8xBFpZM0PRv7l78=;
        b=hdZBRY79mVyv81bpRO4nbUzukBPHpV0rqmpj8gdjbbu24fyYF+FIpsNv5WFIwj5gYx
         SWQlmZ46NXZSL5/K2AmRt4I2lD1D/a6i6PetDdDRDW+c6b0h/wsi/+cvVxDtUEPM7oG/
         LQAm6pRxMS3OgLb4FozN34vK8QGz3BAXi+oBFw0u8vD/ATNx3U4mXUVqFwjrqE6X97CD
         Osc1otyqS5zPgTs3QXHCeOjXhTlXUd5W0TZask9ghg79hhjPcaHtz1IWG3E7jf84qxBd
         HopTSc//97iM4ImNA7a9jl+uSkV9YPWLJze8Z/MaT84addUfkxmZIMIi9VHu7QTZUrs3
         +m8A==
X-Forwarded-Encrypted: i=1; AJvYcCWoQCjy9tcwbmszF65QhWWWCnQNpnbaVbV2cWuSLccIIqpdBsqYK6oUFEguAIIQzSP0lPJf/PPfWTVzM4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP42CXZwPIia+PgoGNYQG70xqL8KcMBPKpzkqcfEJWXTBKAtkt
	R8etNXQRIm+0D8+Ne8cpOA+tOriB6DlVPa79t36TuoKJ6QBMksRtAsQMhqBU1Jmj6QbGrYenZ3y
	walSPQs8D82k3YVE0q+WieOX2Sto1Srq9d05V69bZoRx3OBkn+cp7xH0=
X-Gm-Gg: ASbGncte+5nrYUrwMVwxuHCR5YqqV45Nq1nvHCj2uXxivvh/m5/2xQmaLXib7VshNPE
	/vpcG7MOp85bV0yNC+/GmpXDkrcAsPxGELTxXYebjmybbk8ZlJrINVlDy2pv0ZBtYPOmGwGHHy2
	cKE5As/UJqn3A4DN1GGM2QXUeJNqgSZUT3ESSF7xuYdi06
X-Google-Smtp-Source: AGHT+IEjd4Bsp9vhFXwIMeKPCfl0HudeXbCUsQN6dTCUhLN2w08+3I15itDDB7bes0yfdKQ/F5CuA9N1Z410+NhlvkY=
X-Received: by 2002:a05:690c:6811:b0:70f:84c8:3134 with SMTP id
 00721157ae682-717b166ef67mr32767347b3.3.1752061617229; Wed, 09 Jul 2025
 04:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12700973.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12700973.O9o76ZdvQC@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 13:46:19 +0200
X-Gm-Features: Ac12FXyHlvbzSF2Gox8nn_8TvDnuzqQLjD-xcSn9yoGLBWebg6XVrtiLyNg_rpQ
Message-ID: <CAPDyKFpGH=ZUyQ0wbkEKVLxknm59hDX6DNm9hXpuqzHCpoe-KQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Take active children into account in pm_runtime_get_if_in_use()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Alex Elder <elder@linaro.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 12:41, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> For all practical purposes, there is no difference between the situation
> in which a given device is not ignoring children and its active child
> count is nonzero and the situation in which its runtime PM usage counter
> is nonzero.  However, pm_runtime_get_if_in_use() will only increment the
> device's usage counter and return 1 in the latter case.
>
> For consistency, make it do so in the former case either by adjusting
> pm_runtime_get_conditional() and update the related kerneldoc comments
> accordingly.
>
> Fixes: c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usage")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |   27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1203,10 +1203,12 @@
>   *
>   * Return -EINVAL if runtime PM is disabled for @dev.
>   *
> - * Otherwise, if the runtime PM status of @dev is %RPM_ACTIVE and either
> - * @ign_usage_count is %true or the runtime PM usage counter of @dev is not
> - * zero, increment the usage counter of @dev and return 1. Otherwise, return 0
> - * without changing the usage counter.
> + * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign_usage_count
> + * is set, or (2) @dev is not ignoring children and its active child count is
> + * nonero, or (3) the runtime PM usage counter of @dev is not zero, increment
> + * the usage counter of @dev and return 1.
> + *
> + * Otherwise, return 0 without changing the usage counter.
>   *
>   * If @ign_usage_count is %true, this function can be used to prevent suspending
>   * the device when its runtime PM status is %RPM_ACTIVE.
> @@ -1228,7 +1230,8 @@
>                 retval = -EINVAL;
>         } else if (dev->power.runtime_status != RPM_ACTIVE) {
>                 retval = 0;
> -       } else if (ign_usage_count) {
> +       } else if (ign_usage_count || (!dev->power.ignore_children &&
> +                  atomic_read(&dev->power.child_count) > 0)) {

I am not sure I understand why this is needed, sorry.

If someone and somehow we have "dev->power.runtime_status ==
RPM_ACTIVE", then the dev's parents/childrens and suppliers/consumers
should have been reference counted correctly already. Otherwise it
should not have been possible to set the runtime_status to RPM_ACTIVE
in the first place, right?

>                 retval = 1;
>                 atomic_inc(&dev->power.usage_count);
>         } else {
> @@ -1261,10 +1264,16 @@
>   * @dev: Target device.
>   *
>   * Increment the runtime PM usage counter of @dev if its runtime PM status is
> - * %RPM_ACTIVE and its runtime PM usage counter is greater than 0, in which case
> - * it returns 1. If the device is in a different state or its usage_count is 0,
> - * 0 is returned. -EINVAL is returned if runtime PM is disabled for the device,
> - * in which case also the usage_count will remain unmodified.
> + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0 or it is not
> + * ignoring children and its active child count is nonzero.  1 is returned in
> + * this case.
> + *
> + * If @dev is in a different state or it is not in use (that is, its usage
> + * counter is 0, or it is ignoring children, or its active child count is 0),
> + * 0 is returned.
> + *
> + * -EINVAL is returned if runtime PM is disabled for the device, in which case
> + * also the usage counter of @dev is not updated.
>   */
>  int pm_runtime_get_if_in_use(struct device *dev)
>  {
>
>
>

Kind regards
Uffe

