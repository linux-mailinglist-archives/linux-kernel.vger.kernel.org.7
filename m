Return-Path: <linux-kernel+bounces-735964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F13FB095FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059511C2480A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20054225419;
	Thu, 17 Jul 2025 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="QyWJJOj/"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6BAEEBB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785470; cv=none; b=ILJV9f6PsngFAotaZZT/1Hg/ae1VPxlCwpunO7ZzuXb7XaNfXUhGGfI6jrwNpV2raD/0KCc/M9gKWvO1tXmqgKBRmm+HTjsWkMkJzvgj0+O+U9vjQPBT346rHFK12v339aqrkZJlE7AfapkFrwqOHqUqFz7Mr1GVTPY3B8h7VWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785470; c=relaxed/simple;
	bh=rlHWZSwzBsSSvdDUOWOIYNDt1Rnad1jmWPv8JvlzSao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8vC/HBcR99Dd+sMWBX0zaOxa1ez53uw11dSvMuDUa5Us+sx/3mnuM0jg1uzdVxstdlISD0xTe5/Z+Q4Ii4OGVanJGwrswiStnMGnV/azC34DpwFBl70/p20W/BPjLc71qv8c9oWfjsGEzlLf33RvoHBYNowgarJD2JsFr6jzB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=QyWJJOj/; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HIWGJo028401;
	Thu, 17 Jul 2025 20:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=iWydkmkwQe1amwK5saIsRQTwgo
	92mNgHcD7rw9leDP4=; b=QyWJJOj/49ts1EcLZZde64rU1Owelykk/yWfMPJke3
	WtlNKnahrp2odqXV88M478Cq4xV37f58wGOocKBfNxonfb8pC+4Oxw5u3qn+OJWO
	FRA7hICaYuRS0LjANWOGyf9MgJXZK91oprDyLFH5zL3p/g83p7Ihb9pIV4UVSwAb
	agGfkcWbH1WTacQuevyYPiGlOAMu2OjkaYTwRxfpyCIrD5/xya77B+0rpZGvjlby
	kNWS+GAbDyO3nC8f2xxrN73gaiUM9OMLROO38ymSzS2KSOieRTb5GbRqBg+yuQlI
	R/Nq5cFN2B6r77QbsOg8z46FwjBOrJsG5JoX4map/mJw==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 47y3a13ekf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 20:50:16 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 311FF132C5;
	Thu, 17 Jul 2025 20:50:16 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id D0D548104B8;
	Thu, 17 Jul 2025 20:50:13 +0000 (UTC)
Date: Thu, 17 Jul 2025 15:50:11 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: Jiri Wiesner <jwiesner@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: UV RTC: Add parameter to disable RTC clocksource
Message-ID: <aHliA1T5yyuMVDNk@hpe.com>
References: <aHkabelw1sZqu9JR@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHkabelw1sZqu9JR@incl>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4NCBTYWx0ZWRfX68v+SSA75D6a OSOUFIoKGG0eiZ7CinbY20EGpcYfYw6v5BYSpthqIhiWSANueeua7Yy9T9+6NmoucrHsjijWh1g 1q+wCZ9KiNa1FSUYsRonlkb+uzZJ5SmUpMFBuizHMu8c7ws1rx9zj6o0PPATuEQBvrbQ/Li0u59
 GW1d1IzpReOQ2kh+kb4+I+BK/v6uby+UZOzQuNCbglm3gSpzVlnQzfSCMkcRkRRoNLiG96jkxTu dBwOuzR9uTIQCswzQklnjo0BiiZfTJt+n84Ew3v7lhW3bj+iuyAB0TsRummoxep8FF7u+GqYOPm 3GxABVFd916cNf0QUmTVYWxMemp8FFMLXwhRo3znmNk62A/AFoqJ6QwZw4Q5p0psVhcXakLLxkZ
 hX8l3ofTOY8/lialA7wzhGHcHORKkD0vMsMsojku56f+q9w3+xjT3JbaJu0vlXrGOn6cqhjn
X-Authority-Analysis: v=2.4 cv=LMFmQIW9 c=1 sm=1 tr=0 ts=68796209 cx=c_pps a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=42lKM6jOY4FrGS-VzuoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: rSzMTGqoQpWA0E9RndNSayGhZYd40lP3
X-Proofpoint-ORIG-GUID: rSzMTGqoQpWA0E9RndNSayGhZYd40lP3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170184

On Thu, Jul 17, 2025 at 05:44:45PM +0200, Jiri Wiesner wrote:
> Booting up an 8 NUMA node machine that has an UV RTC clocksource may
> result in the TSC being marked unstable by the clocksource watchdog due to
> time skew. The failures to verify the TSC happen soon after the current
> clocksource is switched to the TSC (usually the watchdog runs twice).
> Delaying the checks carried out by the clocksource watchdog after the
> system boots up does not make a difference.
> 
> The clocksource watchdog compares two clocksources and it is assumed that
> it is always the clocksource being verified what has caused the time skew
> measured by the clocksource watchdog. To check the validity of this
> assumption, a debugging kernel was used. A third clocksource that was set
> to the HPET was added. The messages reported by the debugging kernel
> indicate that the time skew between the TSC and the HPET was only 22
> nanoseconds while the time skew between the TSC and sgi_rtc was 591659
> nanoseconds:
> 
> clocksource: timekeeping watchdog on CPU176: Marking clocksource 'tsc' as unstable because the skew is too large:
> clocksource: 'sgi_rtc' wd_nsec: 479339803 wd_now: 1fab695e5a wd_last: 1f9e44dca0 mask: ffffffffffffff
> clocksource: 'hpet' wd2_nsec: 479931440 wd2_now: 90a1af85 wd2_last: 8fea9b37 mask: ffffffff
> clocksource: 'tsc' cs_nsec: 479931462 cs_now: 944e1c227d cs_last: 9412097879 mask: ffffffffffffffff
> clocksource: Clocksource 'tsc' skewed 591659 ns (0 ms) over watchdog 'sgi_rtc' interval of 479339803 ns (479 ms)
> clocksource: 'tsc' is current clocksource.
> tsc: Marking TSC unstable due to clocksource watchdog
> TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> sched_clock: Marking unstable (90731283360, -1108605523)<-(95136368481, -5513690634)
> clocksource: Checking clocksource tsc synchronization from CPU 501 to CPUs 0-500,502-767.
> clocksource: CPU 501 check durations 1446ns - 32908ns for clocksource tsc.
> 
> This happened on CPU 176, which resides on NUMA node 3. The interval was
> computed from timestamps from CPU 176 and from CPU 175, which also resides
> on NUMA node 3. Since the time skew was reported between CPUs residing on
> the same NUMA node, it is unlikely that the TSC would experience time skew.
> 
> The debugging kernel printed out the last message in
> clocksource_verify_percpu() unconditionally, and all CPUs were checked.
> None of the CPUs was reported as being behind or ahead of CPU 501. The
> last message provides a worst case estimate. The value of 2 * cs_nsec_max
> (2 * 32908 ns) is the maximum possible time skew between the TSCs of any
> two CPUs on the system, as measured by the TSC sync check. The cs_nsec_max
> value itself is an estimate because it includes delays incurred by
> executing and servicing an inter-processor interrupt synchronously, which
> has a non-negligible cost. The maximum possible time skew (of the TSC) of
> 66 microseconds does not even approach the size of the time skew measured
> by the clocksource watchdog.
> 
> Testing has shown that the HPET is stabler than sgi_rtc so the HPET is a
> better choice for veryfying the TSC. Disabling the sgi_rtc clocksource was
> implemented as a workaround. The name of the parameter was inspired by
> 581f202bcd60 ("x86: UV RTC: Always enable RTC clocksource") and the fact
> that there also is a nohpet parameter and a notsc parameter. The uvrtcevt
> parameter has been documented.
> 

On the face of it, the patch you're proposing looks OK to me, and continues the
precedent shown in other clocksources.

However, while the HPET may seem like a viable backup clocksource for purposes
of watchdog checking, it won't scale when assigned as an actual clocksource.
The UV RTC when used as an actual clocksource is more scalable than the HPET,
but it does have higher access latency than the TSC.  TSC provides the low
access latency clocksource needed by many applications.

HPE UV hardware is designed to have a reliable and synchronized TSC mechanism.  
Comparing the TSC against these secondary clocksources can result in false
positives due to variable access latency caused by system traffic.  The best
course of action against these false positives has been found to simply disable
watchdog checking of the TSC.  Currently we recommend that customers apply
'tsc=nowatchdog' to the kernel command line.  Note that this has been enforced
in the kernel for other platforms with the following commits:

commit b50db7095fe002fa3e16605546cba66bf1b68a3e
Author: Feng Tang <feng.79.tang@gmail.com>
Date:   Wed Nov 17 10:37:51 2021 +0800

    x86/tsc: Disable clocksource watchdog for TSC on qualified platorms

commit 233756a640be811efae33763db718fe29753b1e9
Author: Feng Tang <feng.79.tang@gmail.com>
Date:   Wed Jun 7 15:54:33 2023 +0800

    x86/tsc: Extend watchdog check exemption to 4-Sockets platform

commit b4bac279319d3082eb42f074799c7b18ba528c71
Author: Feng Tang <feng.79.tang@gmail.com>
Date:   Mon Jul 29 10:12:02 2024 +0800

    x86/tsc: Use topology_max_packages() to get package number


Going forward, we will likely submit a patch that disables clocksource watchdog
checking for newer UV systems in the kernel as well.

> Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  arch/x86/platform/uv/uv_time.c                  | 11 ++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 07e22ba5bfe3..9839257181e3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4302,6 +4302,8 @@
>  			This is required for the Braillex ib80-piezo Braille
>  			reader made by F.H. Papenmeier (Germany).
>  
> +	nouvrtc		[X86] Disable the UV RTC clocksource (SGI RTC clock).
> +
>  	nosgx		[X86-64,SGX,EARLY] Disables Intel SGX kernel support.
>  
>  	nosmap		[PPC,EARLY]
> @@ -7839,6 +7841,8 @@
>  				16 - SIGBUS faults
>  			Example: user_debug=31
>  
> +	uvrtcevt	[X86] Use UV RTC clock events (SGI RTC clock) for timers.
> +
>  	vdso=		[X86,SH,SPARC]
>  			On X86_32, this is an alias for vdso32=.  Otherwise:
>  
> diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
> index 3712afc3534d..03d59b87c371 100644
> --- a/arch/x86/platform/uv/uv_time.c
> +++ b/arch/x86/platform/uv/uv_time.c
> @@ -61,6 +61,7 @@ struct uv_rtc_timer_head {
>   */
>  static struct uv_rtc_timer_head		**blade_info __read_mostly;
>  
> +static int				uv_rtc_enable = 1;
>  static int				uv_rtc_evt_enable;
>  
>  /*
> @@ -321,6 +322,14 @@ static void uv_rtc_interrupt(void)
>  	ced->event_handler(ced);
>  }
>  
> +static int __init uv_disable_rtc(char *str)
> +{
> +	uv_rtc_enable = 0;
> +
> +	return 1;
> +}
> +__setup("nouvrtc", uv_disable_rtc);
> +
>  static int __init uv_enable_evt_rtc(char *str)
>  {
>  	uv_rtc_evt_enable = 1;
> @@ -342,7 +351,7 @@ static __init int uv_rtc_setup_clock(void)
>  {
>  	int rc;
>  
> -	if (!is_uv_system())
> +	if (!uv_rtc_enable || !is_uv_system())
>  		return -ENODEV;
>  
>  	rc = clocksource_register_hz(&clocksource_uv, sn_rtc_cycles_per_second);
> -- 
> 2.43.0
> 
> 
> -- 
> Jiri Wiesner
> SUSE Labs

