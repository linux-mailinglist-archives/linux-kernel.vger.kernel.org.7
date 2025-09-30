Return-Path: <linux-kernel+bounces-837915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F2BAE0B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FABD3ADD54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6123AB9F;
	Tue, 30 Sep 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g4tLbS+Y"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD2C23816D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249875; cv=none; b=oQCv0+2G7HmQ80qPVFMR6rx4GeENDs4zc4dQrAWS4d/P+y6CYs8sNlfk+y3eX2oQuU8kKLwcKF5xT53SXwEpFfsIHamMd9i7/2VTxgmGbHWHp0mEJbuM9gaQWP0PVnsyQpmOSbMswi/HxvyIzaukzjhspzivhZwRJIu+U00TeOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249875; c=relaxed/simple;
	bh=KrP72lI1FFAU2CtrhllKwhHy148gk9UN/Wkcz+o+ngg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgl27rtsOYAivoZq4+rfNK/0TId+1yXCW6RG44IizVabrXRJVp9HObER7eG91sktpXVnS7me2MA/IrNS4wl+61dzmmzQiE2Gx+7omwhRt2FiQqcPa+gWGKXZAU2j7ArmDy3YFbWfvcrNhXNTS0nhkfu/poMZ1tNciV+ldvlbevA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g4tLbS+Y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759249872;
	bh=KrP72lI1FFAU2CtrhllKwhHy148gk9UN/Wkcz+o+ngg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g4tLbS+YDrZR5+xReW7WBOtYQiZFTrR36tzXP/piGDwK85kdUgalxR2uM5HSxQb+N
	 5976la+hwmd6cqqWFJEocRw1uesEkO9vuDgBU8XOKZQ4ed9iC73uVKYj2Lo7mDtdeJ
	 sOjURRuVZewAjo+vk88vMvrnC8H4OC1nDdyMMG87h/F8/OEHKVxE/lPiryPCfloYnw
	 RFW36AmuyIRWvrSiqblWxrkAsXf2D/4FTK3PTlWJ7Ms0cs218c8dYtxyOkSpzlnQJ/
	 hWMI2O2+ecGS0YsHbbCc4vizwY7B+MymOeEvpVLKnHHsSC8e0GRGl/Q+EK+F8igYJ3
	 iunHfmMC2LUQg==
Received: from [IPV6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa] (unknown [IPv6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 604E117E0AC3;
	Tue, 30 Sep 2025 18:31:11 +0200 (CEST)
Message-ID: <d3b927b9-ddcb-492a-a72c-d42abbb11cff@collabora.com>
Date: Tue, 30 Sep 2025 18:31:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] drm/panthor: Introduce huge tmpfs mount point option
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Melissa Wen <mwen@igalia.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Al Viro
 <viro@zeniv.linux.org.uk>, =?UTF-8?Q?Miko=C5=82aj_Wasiak?=
 <mikolaj.wasiak@intel.com>, Christian Brauner <brauner@kernel.org>,
 Nitin Gote <nitin.r.gote@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, kernel@collabora.com
References: <20250929200316.18417-1-loic.molinari@collabora.com>
 <20250929200316.18417-7-loic.molinari@collabora.com>
 <20250930123416.4ff59b11@fedora>
Content-Language: fr
From: =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>
Organization: Collabora Ltd
In-Reply-To: <20250930123416.4ff59b11@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/09/2025 12:34, Boris Brezillon wrote:
> On Mon, 29 Sep 2025 22:03:14 +0200
> Loïc Molinari <loic.molinari@collabora.com> wrote:
> 
>> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
>> index 4fc7cf2aeed5..54ca61567426 100644
>> --- a/drivers/gpu/drm/panthor/panthor_device.h
>> +++ b/drivers/gpu/drm/panthor/panthor_device.h
>> @@ -135,6 +135,9 @@ struct panthor_device {
>>   	/** @devfreq: Device frequency scaling management data. */
>>   	struct panthor_devfreq *devfreq;
>>   
>> +	/** @huge_mnt: tmpfs mount point with Transparent Hugepage enabled. */
>> +	struct vfsmount *huge_mnt;
> 
> Now that we have a helper to create a huge mountpoint, wouldn't it
> make sense to have this field in drm_device instead of having each
> driver add a huge_mnt field to their <driver>_device object.

Not sure this should be enforced for all DRM drivers since most of them 
don't create separate huge mountpoints (only 4 for now including this 
patchset) and I guess some maintainers might prefer to depend on the 
sysfs interace to enable huge pages.

>> +
>>   	/** @unplug: Device unplug related fields. */
>>   	struct {
>>   		/** @lock: Lock used to serialize unplug operations. */
> 

Loïc

