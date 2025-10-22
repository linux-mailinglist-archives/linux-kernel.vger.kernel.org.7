Return-Path: <linux-kernel+bounces-865369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5669BFCE62
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633D9188A829
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF742749D6;
	Wed, 22 Oct 2025 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ic47SE17"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51027281D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147155; cv=none; b=h4lBkx+1VYJKfnXiTMgPSOrWIQhtkwivQoL+sCvPIr9Op8lzlyXHfT4487cZFri8mZ9gdMxhgCL/B5xYb5WtxICrVcY884gWhpkj0t34bJ62In3wNeCGJy3Y7cmSfJi3Ciq1EjZDA1Ky55PPXyA6xjE3D1DPKX0kV2HNDaGEOMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147155; c=relaxed/simple;
	bh=sRJ2zN8CzVS0ERCYNV0u8WnWDqWCm0f9GOMSgUGtgxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2ubJosZughDXTmGq9cz6KcFziVt0O9/pV3zmHOsvHUN78gTI9ziMCyRhvdSHvV3YZT8Qfxw7Qh65CMFcvzQpXuDA5SdxuL0dSVfle8eEV2BqRBMR35fDx+mfuuHBNfncAgEfLk34VCrw/97Dg4+7kZJ447KoIPfmGZOkcqBhsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ic47SE17; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761147147;
	bh=sRJ2zN8CzVS0ERCYNV0u8WnWDqWCm0f9GOMSgUGtgxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ic47SE17M7C+5zUcCC+toHvCqYVlILZeaqz/njb6EoGbwzpkWYPyboDPdohHw4EDt
	 VMmmijauyoJUOkwLdkdvxvypPUQHXSpxQV6G15QMEGeUhlGgwmu6uSjmxWaW/TmNt0
	 qzOzZIKIpYHoWF5vBIdPdHBShAOarDkXiGluhhw2m8fU5Z9gvxL9hHqv5vb+ur3X+b
	 Hoo1PPE75+fDASFIFMR5T+/dCbfrgmnvOw29WdM9pJR+k0IfCPizNPfuMCswe4yUw6
	 1WJcdumSDSchPKfoVVJCgAfbq6t8u0T1WlEbXz3vw5sbbv7CF87+qR3FufrNw06kYy
	 tcLCL0VylZT1g==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 229BA17E013C;
	Wed, 22 Oct 2025 17:32:27 +0200 (CEST)
Date: Wed, 22 Oct 2025 17:32:17 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Ketil Johnsen <ketil.johnsen@arm.com>, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: Fix UAF race between device unplug and
 FW event processing
Message-ID: <20251022173217.1105681b@fedora>
In-Reply-To: <1cffaf6a-7e99-416f-af50-5659b1738af2@arm.com>
References: <20251022103014.1082629-1-ketil.johnsen@arm.com>
	<20251022143751.769c1f23@fedora>
	<e257f8fe-fe9e-40bf-bd5a-6dad0c3d72e0@arm.com>
	<20251022160033.2f645528@fedora>
	<1cffaf6a-7e99-416f-af50-5659b1738af2@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 15:28:51 +0100
Steven Price <steven.price@arm.com> wrote:

> On 22/10/2025 15:00, Boris Brezillon wrote:
> > On Wed, 22 Oct 2025 14:36:23 +0100
> > Steven Price <steven.price@arm.com> wrote:
> >   
> >> On 22/10/2025 13:37, Boris Brezillon wrote:  
> >>> On Wed, 22 Oct 2025 12:30:13 +0200
> >>> Ketil Johnsen <ketil.johnsen@arm.com> wrote:
> >>>     
> >>>> The function panthor_fw_unplug() will free the FW memory sections.
> >>>> The problem is that there could still be pending FW events which are yet
> >>>> not handled at this point. process_fw_events_work() can in this case try
> >>>> to access said freed memory.
> >>>>
> >>>> This fix introduces a destroyed state for the panthor_scheduler object,
> >>>> and we check for this before processing FW events.
> >>>>
> >>>> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> >>>> Fixes: de85488138247 ("drm/panthor: Add the scheduler logical block")
> >>>> ---
> >>>> v2:
> >>>> - Followed Boris's advice and handle the race purely within the
> >>>>   scheduler block (by adding a destroyed state)
> >>>> ---
> >>>>  drivers/gpu/drm/panthor/panthor_sched.c | 15 ++++++++++++---
> >>>>  1 file changed, 12 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> >>>> index 0cc9055f4ee52..4996f987b8183 100644
> >>>> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> >>>> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> >>>> @@ -315,6 +315,13 @@ struct panthor_scheduler {
> >>>>  		 */
> >>>>  		struct list_head stopped_groups;
> >>>>  	} reset;
> >>>> +
> >>>> +	/**
> >>>> +	 * @destroyed: Scheduler object is (being) destroyed
> >>>> +	 *
> >>>> +	 * Normal scheduler operations should no longer take place.
> >>>> +	 */
> >>>> +	bool destroyed;    
> >>>
> >>> Do we really need a new field for that? Can't we just reset
> >>> panthor_device::scheduler to NULL early enough in the unplug path?
> >>> I guess it's not that simple if we have works going back to ptdev
> >>> and then dereferencing ptdev->scheduler, but I think it's also
> >>> fundamentally broken to have scheduler works active after the
> >>> scheduler teardown has started, so we might want to add some more
> >>> checks in the work callbacks too.
> >>>     
> >>>>  };
> >>>>  
> >>>>  /**
> >>>> @@ -1765,7 +1772,10 @@ static void process_fw_events_work(struct work_struct *work)
> >>>>  	u32 events = atomic_xchg(&sched->fw_events, 0);
> >>>>  	struct panthor_device *ptdev = sched->ptdev;
> >>>>  
> >>>> -	mutex_lock(&sched->lock);
> >>>> +	guard(mutex)(&sched->lock);
> >>>> +
> >>>> +	if (sched->destroyed)
> >>>> +		return;
> >>>>  
> >>>>  	if (events & JOB_INT_GLOBAL_IF) {
> >>>>  		sched_process_global_irq_locked(ptdev);
> >>>> @@ -1778,8 +1788,6 @@ static void process_fw_events_work(struct work_struct *work)
> >>>>  		sched_process_csg_irq_locked(ptdev, csg_id);
> >>>>  		events &= ~BIT(csg_id);
> >>>>  	}
> >>>> -
> >>>> -	mutex_unlock(&sched->lock);
> >>>>  }
> >>>>  
> >>>>  /**
> >>>> @@ -3882,6 +3890,7 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
> >>>>  	cancel_delayed_work_sync(&sched->tick_work);
> >>>>  
> >>>>  	mutex_lock(&sched->lock);
> >>>> +	sched->destroyed = true;
> >>>>  	if (sched->pm.has_ref) {
> >>>>  		pm_runtime_put(ptdev->base.dev);
> >>>>  		sched->pm.has_ref = false;    
> >>>
> >>> Hm, I'd really like to see a cancel_work_sync(&sched->fw_events_work)
> >>> rather than letting the work execute after we've started tearing down
> >>> the scheduler object.
> >>>
> >>> If you follow my suggestion to reset the ptdev->scheduler field, I
> >>> guess something like that would do:
> >>>
> >>> void panthor_sched_unplug(struct panthor_device *ptdev)
> >>> {
> >>>         struct panthor_scheduler *sched = ptdev->scheduler;
> >>>
> >>> 	/* We want the schedu */
> >>> 	WRITE_ONCE(*ptdev->scheduler, NULL);
> >>>
> >>> 	cancel_work_sync(&sched->fw_events_work);
> >>>         cancel_delayed_work_sync(&sched->tick_work);
> >>>
> >>>         mutex_lock(&sched->lock);
> >>>         if (sched->pm.has_ref) {
> >>>                 pm_runtime_put(ptdev->base.dev);
> >>>                 sched->pm.has_ref = false;
> >>>         }
> >>>         mutex_unlock(&sched->lock);
> >>> }
> >>>
> >>> and
> >>>
> >>> void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events) {
> >>> 	struct panthor_scheduler *sched = READ_ONCE(*ptdev->scheduler);
> >>>
> >>> 	/* Scheduler is not initialized, or it's gone. */
> >>>         if (!sched)
> >>>                 return;
> >>>
> >>>         atomic_or(events, &sched->fw_events);
> >>>         sched_queue_work(sched, fw_events);
> >>> }    
> >>
> >> Note there's also the path of panthor_mmu_irq_handler() calling
> >> panthor_sched_report_mmu_fault() which will need to READ_ONCE() as well
> >> to be safe.  
> > 
> > This could be hidden behind a panthor_device_get_sched() helper, I
> > guess. Anyway, it's not so much that I'm against the addition of an
> > extra bool, but AFAICT, the problem is not entirely solved, as there
> > could be a pending work that gets executed after sched_unplug()
> > returns, and I adding this bool check just papers over the real bug
> > (which is that we never cancel the fw_event work).
> >   
> >>
> >> I agree having an extra bool is ugly, but it easier to reason about than
> >> the lock-free WRITE_ONCE/READ_ONCE dance. It worries me that this will
> >> be regressed in the future. I can't immediately see how to wrap this in
> >> a helper to ensure this is kept correct.  
> > 
> > Sure, but you're not really catching cases where the work runs after
> > the scheduler component has been unplugged in case someone forgot to
> > cancel some works. I think I'd rather identify those cases with a
> > kernel panic, than a random UAF when the work is being executed.
> > Ultimately, we should probably audit all works used in the driver, to
> > make sure they are properly cancelled at unplug() time by the relevant
> > <component>_unplug() functions.  
> 
> Yes I agree, we should have a cancel_work_sync(&sched->fw_events_work)
> call somewhere on the unplug path. That needs to be after the job irq
> has been disabled which is currently done in panthor_fw_unplug().

Not necessarily. If we prevent any further FW events to queue the
fw_events work, we can just cancel it in the sched_unplug() path, after
we've transition to this "sched-is-gone" state.

