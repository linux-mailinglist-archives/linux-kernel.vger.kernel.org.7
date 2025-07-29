Return-Path: <linux-kernel+bounces-749229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30778B14BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507791AA46AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777262877DA;
	Tue, 29 Jul 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z9fLNJRv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0fzRu7x5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z9fLNJRv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0fzRu7x5"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A7C285C86
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782760; cv=none; b=L4snyPMoWUE5c68CYobPu2IZkbMbQv5m8D8ajdGSZ8BWms/X2Cf5Ikift/O6i/8xeXOFEKcX955YrWVwFbSGswOfDL29UMMd6EdKF9z0iaVH7YGaFcOn+EyPUGmKrxdbc4AS9Sf9UwKhcA+YuHkM6SQAjABCzgLLrs4NvWgRHMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782760; c=relaxed/simple;
	bh=2km5l0BMRtE8e4Qeg0ckb0b3qpU7W9JxgCrxRFPYSL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su0lGrt92klIVyIJZCrkedIqccJnI9B1r3Dw8emf4hQDPR5l8ZH5lrEBdQc7CIgagRWQG1lPQchudtzpC30nXx1vEBYWoV4w6UFUDPxaHLVPQmLS55AKIxnPii+T8HIbo2ws0kUG/LTaU/F7XIRhbSTm3Fr9fFwl4aCHdz8zU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z9fLNJRv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0fzRu7x5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z9fLNJRv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0fzRu7x5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7ADD1F789;
	Tue, 29 Jul 2025 09:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753782755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EL0RgrIBRZMATV/9ogw8oaIJFhDTZ9lv0Ja2sYBu89Y=;
	b=z9fLNJRv8hgr4y/cARFGC42O+bZrvqCecPZE43c3D7HhUIpD8ojtQt2nhyMfzEVXwe0OCs
	6A1fVrJDybxefsLFcWGfzGOSwkshvwRWSuQxy+JKVcqCWTlhwaUD4eYVBJyNAw5nRrNtAS
	3GKGZAMxm77wrG9lLZPVRjsZuu4xa08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753782755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EL0RgrIBRZMATV/9ogw8oaIJFhDTZ9lv0Ja2sYBu89Y=;
	b=0fzRu7x5pjSDiCiG3e88j8HcxIdggRHTd2sRbpVT0XknBRytd3bquJtNMoxNOgN7KQR60g
	mmRw53aYbOz8vpCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753782755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EL0RgrIBRZMATV/9ogw8oaIJFhDTZ9lv0Ja2sYBu89Y=;
	b=z9fLNJRv8hgr4y/cARFGC42O+bZrvqCecPZE43c3D7HhUIpD8ojtQt2nhyMfzEVXwe0OCs
	6A1fVrJDybxefsLFcWGfzGOSwkshvwRWSuQxy+JKVcqCWTlhwaUD4eYVBJyNAw5nRrNtAS
	3GKGZAMxm77wrG9lLZPVRjsZuu4xa08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753782755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EL0RgrIBRZMATV/9ogw8oaIJFhDTZ9lv0Ja2sYBu89Y=;
	b=0fzRu7x5pjSDiCiG3e88j8HcxIdggRHTd2sRbpVT0XknBRytd3bquJtNMoxNOgN7KQR60g
	mmRw53aYbOz8vpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B017E13A73;
	Tue, 29 Jul 2025 09:52:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gtb3KuOZiGi6VwAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Tue, 29 Jul 2025 09:52:35 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 5EF8BD4374; Tue, 29 Jul 2025 11:52:27 +0200 (CEST)
Date: Tue, 29 Jul 2025 11:52:27 +0200
From: Jiri Wiesner <jwiesner@suse.de>
To: Dimitri Sivanich <sivanich@hpe.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Steve Wahl <steve.wahl@hpe.com>,
	Justin Ernst <justin.ernst@hpe.com>,
	Kyle Meyer <kyle.meyer@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Russ Anderson <russ.anderson@hpe.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: UV RTC: Add parameter to disable RTC clocksource
Message-ID: <aIiZ2_DnJ3u6IINZ@incl>
References: <aHkabelw1sZqu9JR@incl>
 <aHliA1T5yyuMVDNk@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHliA1T5yyuMVDNk@hpe.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

I apologize for the lateness of my reply. I need to fix my mail filtering.

On Thu, Jul 17, 2025 at 03:50:11PM -0500, Dimitri Sivanich wrote:
> However, while the HPET may seem like a viable backup clocksource for purposes
> of watchdog checking, it won't scale when assigned as an actual clocksource.

Agreed.

> The UV RTC when used as an actual clocksource is more scalable than the HPET,
> but it does have higher access latency than the TSC. TSC provides the low
> access latency clocksource needed by many applications.

Agreed.

> HPE UV hardware is designed to have a reliable and synchronized TSC mechanism.  
> Comparing the TSC against these secondary clocksources can result in false
> positives due to variable access latency caused by system traffic.  The best
> course of action against these false positives has been found to simply disable
> watchdog checking of the TSC.  Currently we recommend that customers apply
> 'tsc=nowatchdog' to the kernel command line.

This is what we (SUSE) have instructed our customer to do in this case. But I thought we could do slightly better by disabling the UV RTC and allowing the checks to continue. The HPET is certainly not without flaws and we have reports of cases where the TSC was incorrectly marked unstable when the HPET was being used for verification. Recently, changes were merged that relaxed the thresholds substantially (our reports predate these changes):
> v6.8-rc5-23-g2ed08e4bc532 clocksource: Scale the watchdog read retries automatically
> v6.11-rc1-5-g4ac1dd3245b9 clocksource: Set cs_watchdog_read() checks based on .uncertainty_margin
The thresholds used to be 125,000 ns and 62,500 ns for the hpet-tsc-hpet read-back delay and the hpet-hpet read-back delay, respectively. Now, it is 750,000 ns and 500,000 ns for the hpet-tsc-hpet read-back delay and the hpet-hpet read-back delay, respectively. The relaxed threholds will make most of the false positives (TSC marked unstable) disappear. But I think fixed thresholds are not optimal. I would rather see the thresholds be derived from previous measuments, e.g. the threshold value could be derived form the maximum hpet-hpet read-back delay that has been measured by the clocksource watchdog.

> commit b50db7095fe002fa3e16605546cba66bf1b68a3e
> Author: Feng Tang <feng.79.tang@gmail.com>
> Date:   Wed Nov 17 10:37:51 2021 +0800
> 
>     x86/tsc: Disable clocksource watchdog for TSC on qualified platorms
> 
> commit 233756a640be811efae33763db718fe29753b1e9
> Author: Feng Tang <feng.79.tang@gmail.com>
> Date:   Wed Jun 7 15:54:33 2023 +0800
> 
>     x86/tsc: Extend watchdog check exemption to 4-Sockets platform

These two patches have been backported to all SLES releases that include the tightened thresholds for clocksources watchdog checks:
> v5.13-rc4-23-gdb3a34e17433 clocksource: Retry clock read if long delays detected
> v5.13-rc4-26-g2e27e793e280 clocksource: Reduce clocksource-skew threshold
> v5.17-rc1-2-gfc153c1c58cb clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW
> v6.2-rc1-2-gc37e85c135ce clocksource: Loosen clocksource watchdog constraints

> commit b4bac279319d3082eb42f074799c7b18ba528c71
> Author: Feng Tang <feng.79.tang@gmail.com>
> Date:   Mon Jul 29 10:12:02 2024 +0800
> 
>     x86/tsc: Use topology_max_packages() to get package number

We could not backport this patch because the older SLES releases do not contain T. Gleixner's patchset that made topology_max_packages() provide correct package count during early boot.

> Going forward, we will likely submit a patch that disables clocksource watchdog
> checking for newer UV systems in the kernel as well.

My impression is that the clocksource watchdog has mostly outlived its usefulness. I am aware of three occasions where the switch to the HPET caused by the clocksource watchdog notified customers of a serious issue on their system. The first occasion was a hardware issue involving the CPU not executing instructions for hundreds of microseconds but the counters reflecting the passage of time were still incrementing (as if the CPU "stuttered"). The other two occasions are still under investigation.

If I understand correctly the point is that it would be more valuable to have the UV RTC available was a clocksource and avoid it being used by the clocksource watchdog for verifying the TSC. If the UV RTC was used as a clocksource its time skew might become problematic. The largest time skew observed on the 8 socket UV machine was around 700 microseconds per 0.5 second, which is beyond what NTP can correct:
> clocksource: timekeeping watchdog on CPU118: Marking clocksource 'tsc' as unstable because the skew is too large:
> clocksource: 'sgi_rtc' wd_nsec: 511302794 wd_now: 1cb50e4c4b wd_last: 1ca7097111 mask: ffffffffffffff
> clocksource: 'hpet' wd2_nsec: 512005960 wd2_now: 65892719 wd2_last: 64c5d684 mask: ffffffff
> clocksource: 'tsc' cs_nsec: 512006458 cs_now: 86b5982cb1 cs_last: 867581bbab mask: ffffffffffffffff
> clocksource: Clocksource 'tsc' skewed 703664 ns (0 ms) over watchdog 'sgi_rtc' interval of 511302794 ns (511 ms)

> clocksource: timekeeping watchdog on CPU118: Marking clocksource 'tsc' as unstable because the skew is too large:
> clocksource: 'sgi_rtc' wd_nsec: 511302198 wd_now: 1b1cdebaa0 wd_last: 1b0ed9e078 mask: ffffffffffffff
> clocksource: 'tsc' cs_nsec: 512005312 cs_now: 7f746eabdd cs_last: 7f34584009 mask: ffffffffffffffff
> clocksource: Clocksource 'tsc' skewed 703114 ns (0 ms) over watchdog 'sgi_rtc' interval of 511302198 ns (511 ms)

If the clocksource watchdog was disabled by default on newer UV systems it would resolve the issue for us.
-- 
Jiri Wiesner
SUSE Labs

