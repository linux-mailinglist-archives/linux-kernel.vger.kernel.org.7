Return-Path: <linux-kernel+bounces-735547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65919B090D4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F541893D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A4E2F9483;
	Thu, 17 Jul 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v/jYsFgQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j4K6IyR1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v/jYsFgQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j4K6IyR1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B831E1A3B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767094; cv=none; b=LFFtAna5b3QIzsUFs9itBM8LfJRFlgN6mRJmWBjZdJhHKLKRnyR9bDFSj7NT8l17KoMtold6m/9La92tZzqI9YG6LryjeRd3qD6zY97uv2Kb1V/tLEEJzDEfDkPNlgB2IIBuQBuYz62Fllqq8B6MvUnaLUcrje/B3E+z33eX1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767094; c=relaxed/simple;
	bh=Hrri/2b/MJW3Yvdoc9H2+KctuclKt3RQOU2LD2Uyrw0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eG1qmQdvWofYsmmf5xfKHTy4zdouDFYHwIa9Gp/PzTGBq75v3QMLq6kHizjopLrzrLjVtfzcZu7+FvVygRlzuz+DxgPB9l/WG7qu19zabyDpT1VNsHD2i8+jHTw0UwSBuoIuy+hLde1m43OvPLJrcwtQj1x0b3JmEiI83F1cH3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v/jYsFgQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j4K6IyR1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v/jYsFgQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j4K6IyR1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8CC271FDD5;
	Thu, 17 Jul 2025 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752767090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2/skqfvUTJS/6e/UAdh4U9uDGmUYqRg+/enA+mJS588=;
	b=v/jYsFgQfS0VFjemg6X48ercmvbXrXCKmfsalc23NSV2uu8ZICurkv0PmagsXY+hP74zon
	lrGNHQoITTo/xXBLGnljX4Zw/luHut+5fCKnCtVFaCYjbOci6oXFk2Yd6tFVLt1sAl3dug
	8vIU/pHDyegv1UKByWHPPus53hraWLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752767090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2/skqfvUTJS/6e/UAdh4U9uDGmUYqRg+/enA+mJS588=;
	b=j4K6IyR1LRa+l/tl3FqeMuV/XfeXu4/Sr1vDKwcb6+GYfdTQY4NdIj2U13SkDAQUNgMF7Z
	PI4U9pVywvtLomBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="v/jYsFgQ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j4K6IyR1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752767090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2/skqfvUTJS/6e/UAdh4U9uDGmUYqRg+/enA+mJS588=;
	b=v/jYsFgQfS0VFjemg6X48ercmvbXrXCKmfsalc23NSV2uu8ZICurkv0PmagsXY+hP74zon
	lrGNHQoITTo/xXBLGnljX4Zw/luHut+5fCKnCtVFaCYjbOci6oXFk2Yd6tFVLt1sAl3dug
	8vIU/pHDyegv1UKByWHPPus53hraWLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752767090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2/skqfvUTJS/6e/UAdh4U9uDGmUYqRg+/enA+mJS588=;
	b=j4K6IyR1LRa+l/tl3FqeMuV/XfeXu4/Sr1vDKwcb6+GYfdTQY4NdIj2U13SkDAQUNgMF7Z
	PI4U9pVywvtLomBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CE8C13A6C;
	Thu, 17 Jul 2025 15:44:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JikmHnIaeWh6SQAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Thu, 17 Jul 2025 15:44:50 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id E7910D4223; Thu, 17 Jul 2025 17:44:45 +0200 (CEST)
Date: Thu, 17 Jul 2025 17:44:45 +0200
From: Jiri Wiesner <jwiesner@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Steve Wahl <steve.wahl@hpe.com>,
	Justin Ernst <justin.ernst@hpe.com>,
	Kyle Meyer <kyle.meyer@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Russ Anderson <russ.anderson@hpe.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86: UV RTC: Add parameter to disable RTC clocksource
Message-ID: <aHkabelw1sZqu9JR@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8CC271FDD5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01

Booting up an 8 NUMA node machine that has an UV RTC clocksource may
result in the TSC being marked unstable by the clocksource watchdog due to
time skew. The failures to verify the TSC happen soon after the current
clocksource is switched to the TSC (usually the watchdog runs twice).
Delaying the checks carried out by the clocksource watchdog after the
system boots up does not make a difference.

The clocksource watchdog compares two clocksources and it is assumed that
it is always the clocksource being verified what has caused the time skew
measured by the clocksource watchdog. To check the validity of this
assumption, a debugging kernel was used. A third clocksource that was set
to the HPET was added. The messages reported by the debugging kernel
indicate that the time skew between the TSC and the HPET was only 22
nanoseconds while the time skew between the TSC and sgi_rtc was 591659
nanoseconds:

clocksource: timekeeping watchdog on CPU176: Marking clocksource 'tsc' as unstable because the skew is too large:
clocksource: 'sgi_rtc' wd_nsec: 479339803 wd_now: 1fab695e5a wd_last: 1f9e44dca0 mask: ffffffffffffff
clocksource: 'hpet' wd2_nsec: 479931440 wd2_now: 90a1af85 wd2_last: 8fea9b37 mask: ffffffff
clocksource: 'tsc' cs_nsec: 479931462 cs_now: 944e1c227d cs_last: 9412097879 mask: ffffffffffffffff
clocksource: Clocksource 'tsc' skewed 591659 ns (0 ms) over watchdog 'sgi_rtc' interval of 479339803 ns (479 ms)
clocksource: 'tsc' is current clocksource.
tsc: Marking TSC unstable due to clocksource watchdog
TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
sched_clock: Marking unstable (90731283360, -1108605523)<-(95136368481, -5513690634)
clocksource: Checking clocksource tsc synchronization from CPU 501 to CPUs 0-500,502-767.
clocksource: CPU 501 check durations 1446ns - 32908ns for clocksource tsc.

This happened on CPU 176, which resides on NUMA node 3. The interval was
computed from timestamps from CPU 176 and from CPU 175, which also resides
on NUMA node 3. Since the time skew was reported between CPUs residing on
the same NUMA node, it is unlikely that the TSC would experience time skew.

The debugging kernel printed out the last message in
clocksource_verify_percpu() unconditionally, and all CPUs were checked.
None of the CPUs was reported as being behind or ahead of CPU 501. The
last message provides a worst case estimate. The value of 2 * cs_nsec_max
(2 * 32908 ns) is the maximum possible time skew between the TSCs of any
two CPUs on the system, as measured by the TSC sync check. The cs_nsec_max
value itself is an estimate because it includes delays incurred by
executing and servicing an inter-processor interrupt synchronously, which
has a non-negligible cost. The maximum possible time skew (of the TSC) of
66 microseconds does not even approach the size of the time skew measured
by the clocksource watchdog.

Testing has shown that the HPET is stabler than sgi_rtc so the HPET is a
better choice for veryfying the TSC. Disabling the sgi_rtc clocksource was
implemented as a workaround. The name of the parameter was inspired by
581f202bcd60 ("x86: UV RTC: Always enable RTC clocksource") and the fact
that there also is a nohpet parameter and a notsc parameter. The uvrtcevt
parameter has been documented.

Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 arch/x86/platform/uv/uv_time.c                  | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 07e22ba5bfe3..9839257181e3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4302,6 +4302,8 @@
 			This is required for the Braillex ib80-piezo Braille
 			reader made by F.H. Papenmeier (Germany).
 
+	nouvrtc		[X86] Disable the UV RTC clocksource (SGI RTC clock).
+
 	nosgx		[X86-64,SGX,EARLY] Disables Intel SGX kernel support.
 
 	nosmap		[PPC,EARLY]
@@ -7839,6 +7841,8 @@
 				16 - SIGBUS faults
 			Example: user_debug=31
 
+	uvrtcevt	[X86] Use UV RTC clock events (SGI RTC clock) for timers.
+
 	vdso=		[X86,SH,SPARC]
 			On X86_32, this is an alias for vdso32=.  Otherwise:
 
diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index 3712afc3534d..03d59b87c371 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -61,6 +61,7 @@ struct uv_rtc_timer_head {
  */
 static struct uv_rtc_timer_head		**blade_info __read_mostly;
 
+static int				uv_rtc_enable = 1;
 static int				uv_rtc_evt_enable;
 
 /*
@@ -321,6 +322,14 @@ static void uv_rtc_interrupt(void)
 	ced->event_handler(ced);
 }
 
+static int __init uv_disable_rtc(char *str)
+{
+	uv_rtc_enable = 0;
+
+	return 1;
+}
+__setup("nouvrtc", uv_disable_rtc);
+
 static int __init uv_enable_evt_rtc(char *str)
 {
 	uv_rtc_evt_enable = 1;
@@ -342,7 +351,7 @@ static __init int uv_rtc_setup_clock(void)
 {
 	int rc;
 
-	if (!is_uv_system())
+	if (!uv_rtc_enable || !is_uv_system())
 		return -ENODEV;
 
 	rc = clocksource_register_hz(&clocksource_uv, sn_rtc_cycles_per_second);
-- 
2.43.0


-- 
Jiri Wiesner
SUSE Labs

