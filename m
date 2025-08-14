Return-Path: <linux-kernel+bounces-769710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7423B272B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9A25C3461
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579B12836BE;
	Thu, 14 Aug 2025 22:58:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14610319855
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212331; cv=none; b=sxSsMOVJRIzZPHJZ2GovhyO5I4eOkcc+KNSH/TLaX2y/+MLh2NKk7Gr1ymR9NMInV5xmcwVYJ6ThmYxcYTJzAW9AlvQNURtYOoaM9mXO/QOvycnoxbbOuyThAAtq21c4mCCgoz8IJj/c7L+c0tE37mcq2icvj/Yr0gq7GD134po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212331; c=relaxed/simple;
	bh=KMwbMj2fu71fTlAfGAPw8QeNm+0I3qLJI3W3ryIe4Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt30akERz/nbo5epQmtqLamA9S2dJvGYD1nliPT8kgPIZOI6cdCcjmv/HGF8VIa1TELWhxgniQMuut/IGEgJy5CTEQfzr2XXeVs3sQKjtyNL7ABMh2ZvdKYlQHlivwEy8VUpiEa+2y8zvB0FBCcjsyFnrGhw9yXKU3/ueec9oG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21F391691
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:58:40 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E7473F5A1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:58:47 -0700 (PDT)
Date: Thu, 14 Aug 2025 23:58:33 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org,
	nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH v9 6/7] drm/panthor: Make MMU cache maintenance use
 FLUSH_CACHES command
Message-ID: <aJ5qGWlbxihLTHkB@e110455-lin.cambridge.arm.com>
References: <20250807162633.3666310-1-karunika.choo@arm.com>
 <20250807162633.3666310-7-karunika.choo@arm.com>
 <CAPj87rP9pETnxr_mVJ4OAwj_Vhh2yS75iQ5LDT7ddC5=a-kXkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPj87rP9pETnxr_mVJ4OAwj_Vhh2yS75iQ5LDT7ddC5=a-kXkA@mail.gmail.com>

On Fri, Aug 08, 2025 at 11:50:27AM +0100, Daniel Stone wrote:
> Hi Karunika,
> 
> 
> On Thu, 7 Aug 2025 at 17:27, Karunika Choo <karunika.choo@arm.com> wrote:
> > @@ -585,6 +615,9 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
> >         if (op != AS_COMMAND_UNLOCK)
> >                 lock_region(ptdev, as_nr, iova, size);
> >
> > +       if (op == AS_COMMAND_FLUSH_MEM || op == AS_COMMAND_FLUSH_PT)
> > +               return mmu_hw_do_flush_on_gpu_ctrl(ptdev, as_nr, op);
> 
> Given that FLUSH_MEM and FLUSH_PT are the only ops which are ever
> used, the below becomes dead code. Could you please just inline these,
> so it's more clear what's actually going on? The (op !=
> AS_COMMAND_UNLOCK) branch can also become unconditional, perhaps with
> a WARN_ON() around unknown ops.

Hmm, the commit message says that FLUSH_MEM and FLUSH_PT are going to be
deprecated and replaced with FLUSH_CACHES so the first are clearly not the
only ones ever used (at least not in the future). I'm not sure why you
think this code is not correct.

Best regards,
Liviu

> 
> Cheers,
> Daniel

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

