Return-Path: <linux-kernel+bounces-760572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8FFB1ED17
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC995A1C9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8C287264;
	Fri,  8 Aug 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="rh5hslLB"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC62820A3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671086; cv=none; b=BOYy7EoHAPklAyaRO6/UKGBcTQjETPFF35ifEmukB8UtdtzDJcv7EH7iViyBqX+hifH0287hd0E4WP53i7GoX8ZWT54/XAW4y8lrMU56EY7Kq5ZUyCbNe4yqw4FF55DVtb4SSLWE4ljPcpH1q06r9Ho6ffh7w2tabTjimvozUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671086; c=relaxed/simple;
	bh=7yu5D6KJB4QnMunRl9f1JZagGsxX9bEJA9psu8nvIV8=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=MtZekLIL74WBqysw7ka3aQpXEdmlY20Q+jM/QiuFZ1PSBXyfU7zSCwqM4Rau84YOmjns75cuA/Z/dk1I+Jxx7NHD2qXvI+3asb1+dXNU4phFnsdDsZBNQIfK7sXg65/YfPyzV3lJPT49E5Ii8626sJ95SEnCHRtfFRe9qk5KF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=rh5hslLB; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:References:In-Reply-To:Cc:To:
	Subject:From:Message-ID:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JD9KjCcE4XbCbb14mwcuQquA0BcKzZKf6C9X/RVPmwk=; b=rh5hslLBZXkWKA7D/4yOPLQxoX
	Azp2ONJOPyrGWRlsG6lDtohXj5GK09G7UIBvpkLuiQtaOfDhVkTPZveyT/1JchkwuN4X+FO/ep/oq
	3NJ5TS6YvQIYNIfqBVfZRTFp3g7uCjVjASbJc40B7jeeTMFwv7VopIsDVqRGAzaPcWgvothPFa42G
	KBF0ojvST/4ippWGisGJdlDA7i32Lji2RqsngqaENVqEigJE2iOGvK0TFZdKuDw3HyEzGD1I8d00E
	fWDiImTS6tOR6RVp6XiFQjpUm6Ak/FuNwg7ZLu6wPqYkaXRK/RSY3t5vStwZGCj71/SQRbsBvLIqH
	iW57fYKQ==;
Received: from host-87-10-56-203.retail.telecomitalia.it ([87.10.56.203] helo=localhost)
	by imap4.hz.codethink.co.uk with utf8esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1ukQ64-00AH8h-KS; Fri, 08 Aug 2025 17:37:36 +0100
Date: Fri, 08 Aug 2025 18:37:35 +0200
Message-ID: <d37fcac575ee94c3fe605e08e6297986@codethink.co.uk>
From: Matteo Martelli <matteo.martelli@codethink.co.uk>
Subject: Re: [PATCH v3 0/5] Defer throttle when task exits to user
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Chengming Zhou <chengming.zhou@linux.dev>, Josh Don
	<joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Xi Wang <xii@google.com>,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Matteo Martelli <matteo.martelli@codethink.co.uk>
In-Reply-To: <20250804075204.GA496@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
	<a3b3eefb208f06b0c55f889495376248@codethink.co.uk>
	<20250804075204.GA496@bytedance>
Sender: matteo.martelli@codethink.co.uk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Aaron,

On Mon, 4 Aug 2025 15:52:04 +0800, Aaron Lu <ziqianlu@bytedance.com> wrote:
> Hi Matteo,
> 
> On Fri, Aug 01, 2025 at 04:31:25PM +0200, Matteo Martelli wrote:
> ... ... 
> > I encountered this issue on a test image with both PREEMPT_RT and
> > CFS_BANDWIDTH kernel options enabled. The test image is based on
> > freedesktop-sdk (v24.08.10) [1] with custom system configurations on
> > top, and it was being run on qemu x86_64 with 4 virtual CPU cores. One
> > notable system configuration is having most of system services running
> > on a systemd slice, restricted on a single CPU core (with AllowedCPUs
> > systemd option) and using CFS throttling (with CPUQuota systemd option).
> > With this configuration I encountered RCU stalls during boots, I think
> > because of the increased probability given by multiple processes being
> > spawned simultaneously on the same core. After the first RCU stall, the
> > system becomes unresponsive and successive RCU stalls are detected
> > periodically. This seems to match with the deadlock situation described
> > in your cover letter. I could only reproduce RCU stalls with the
> > combination of both PREEMPT_RT and CFS_BANDWIDTH enabled.
> > 
> > I previously already tested this patch set at v2 (RFC) [2] on top of
> > kernel v6.14 and v6.15. I've now retested it at v3 on top of kernel
> > v6.16-rc7. I could no longer reproduce RCU stalls in all cases with the
> > patch set applied. More specifically, in the last test I ran, without
> > patch set applied, I could reproduce 32 RCU stalls in 24 hours, about 1
> > or 2 every hour. In this test the system was rebooting just after the
> > first RCU stall occurrence (through panic_on_rcu_stall=1 and panic=5
> > kernel cmdline arguments) or after 100 seconds if no RCU stall occurred.
> > This means the system rebooted 854 times in 24 hours (about 3.7%
> > reproducibility). You can see below two RCU stall instances. I could not
> > reproduce any RCU stall with the same test after applying the patch set.
> > I obtained similar results while testing the patch set at v2 (RFC)[1].
> > Another possibly interesting note is that the original custom
> > configuration was with the slice CPUQuota=150%, then I retested it with
> > CPUQuota=80%. The issue was reproducible in both configurations, notably
> > even with CPUQuota=150% that to my understanding should correspond to no
> > CFS throttling due to the CPU affinity set to 1 core only.
> 
> Agree. With cpu affinity set to 1 core, 150% quota should never hit. But
> from the test results, it seems quota is hit somehow because if quota is
> not hit, this series should make no difference.
> 
> Maybe fire a bpftrace script and see if quota is actually hit? A
> reference script is here:
> https://lore.kernel.org/lkml/20250521115115.GB24746@bytedance/
> 

I better looked into this and actually there was another slice
(user.slice) configured with CPUQuota=25%. Disabling the CPUQuota limit
on the first mentioned slice (system.slice) I could still reproduce the
RCU stalls. It looks like the throttling was happening during the first
login after boot as also shown by the following ftrace logs.

[   12.019263]  podman-user-gen-992     [000] dN.2.    12.023684: throttle_cfs_rq <-pick_task_fair
[   12.051074]          systemd-981     [000] dN.2.    12.055502: throttle_cfs_rq <-pick_task_fair
[   12.150067]          systemd-981     [000] dN.2.    12.154500: throttle_cfs_rq <-put_prev_entity
[   12.251448]          systemd-981     [000] dN.2.    12.255839: throttle_cfs_rq <-put_prev_entity
[   12.369867]     sshd-session-976     [000] dN.2.    12.374293: throttle_cfs_rq <-pick_task_fair
[   12.453080]             bash-1002    [000] dN.2.    12.457502: throttle_cfs_rq <-pick_task_fair
[   12.551279]             bash-1012    [000] dN.2.    12.555701: throttle_cfs_rq <-pick_task_fair
[   12.651085]           podman-998     [000] dN.2.    12.655505: throttle_cfs_rq <-pick_task_fair
[   12.750509]           podman-1001    [000] dN.2.    12.754931: throttle_cfs_rq <-put_prev_entity
[   12.868351]           podman-1030    [000] dN.2.    12.872780: throttle_cfs_rq <-put_prev_entity
[   12.961076]           podman-1033    [000] dN.2.    12.965504: throttle_cfs_rq <-put_prev_entity


By increasing the CPUQuota to 50% limit of the user.slice, the same test
mentioned in my previous email produced less RCU stalls and less
throttling events in the ftrace logs. Then by setting the user.slice to
100% I could no longer reproduce either RCU stalls or traced throttling
events.

> > I also ran some quick tests with stress-ng and systemd CPUQuota parameter to
> > verify that CFS throttling was behaving as expected. See details below after
> > RCU stall logs.
> 
> Thanks for all these tests. If I read them correctly, in all these
> tests, CFS throttling worked as expected. Right?
> 

Yes, correct.

> Best regards,
> Aaron
> 

Best regards,
Matteo Martelli


