Return-Path: <linux-kernel+bounces-843767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F4ABC0327
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DB0B34C478
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F55202976;
	Tue,  7 Oct 2025 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a1jsX9x5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gYIKhcuP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B571FF1AD
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 05:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759814680; cv=none; b=uRmX2aLFRTkqcq62uerzr5+0AD8q2p1PtuT5B1L1nqW5NV4kQN7bT27drKEdRLyVduX+VzZdT29KlZeg+hUPsAsqwq/QZJ2VH/NjIdMe5mF/vtgRcE56+TPQq8/gflJ2GP0JnysrKhSlaBkEEzJhEFxNL52KSR5oa4yidDmO9XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759814680; c=relaxed/simple;
	bh=Tqz1K5QybrNkjVyimQMCMRdwnF/ONmuAyBC7bWR3/Rc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PYn+nypTR9KC+SCi2J5U6PhtcuwCTauhn07dtj7UsWCDYb05i5kK72wHPBKZxC7zHe3B1ElOKTsOg2mP83GU7z1cbOxTqXpaQsmKwnOyy4NldABL7MYA7nghLOzsjCiu3gtq8RppC9hmMk11/1MiqVqiQaqBD+wGz6nizpbAeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a1jsX9x5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gYIKhcuP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759814672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTFzF4P3cvWjOGepCmPTm6ttevU3TMHOVgykIyMXzBY=;
	b=a1jsX9x522XVeyNA/YFM+SOeSUBzwXbAYbGJV5shTkl3aUoWDRwjBkjxP+V/hJ7MNPOqhm
	cDhDiCgTyyEkcrC7rvP8H6i9uv4uEoUEnhCSWy88zO1SrnRyPCDWASu91tZ7KcnbRDHa3L
	vVhni4JU2Dtcl+Gwwe0p85S5FVys2umLXihQiL8QHGAr7kXEI8DFKpvU6o4k1pA7ZVQzJH
	dB7he6Yg/uwUpBvwMx0Q18ezLBtKZEb+LOJ53/iIMTpmzsOfZYiS5BUjhEalkl1Dvj3VfJ
	4CilgYoEsQQQ1AriV+0H1tGCljul56zQ3AH2f3Yq8hap/g5uFPn8BSCyMl6JoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759814672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTFzF4P3cvWjOGepCmPTm6ttevU3TMHOVgykIyMXzBY=;
	b=gYIKhcuPhN7ALMlVQ9D0AGcxzA34FtUR1OKpbDlFdjbgpGKGrcOoWoR+D+Pv4960K0wncV
	eGcX1WARLQVQw/DQ==
To: Ritesh Harjani <ritesh.list@gmail.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Thomas Gleixner <tglx@linutronix.de>, Marc
 Zyngier <maz@kernel.org>, Gautam Menghani <gautam@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] powerpc/xive: Untangle xive from child interrupt
 controller drivers
In-Reply-To: <68e48df8.170a0220.4b4b0.217d@mx.google.com>
References: <cover.1754903590.git.namcao@linutronix.de>
 <83968073022a4cc211dcbd0faccd20ec05e58c3e.1754903590.git.namcao@linutronix.de>
 <68e48df8.170a0220.4b4b0.217d@mx.google.com>
Date: Tue, 07 Oct 2025 07:24:27 +0200
Message-ID: <875xcrxp10.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Ritesh,

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
> I am facing kernel crash on host when trying to run kvm pseries guest on
> powernv host. Looking it a bit more closely, I see that we are missing
> conversion of xxx_irq_handler_data()) to xxx_irq_chip_data() at few other
> places, including in powerpc KVM code. 
[snip]
> Here is the diff which fixed this.. 
[snip]
> ... However grepping for "handler_data" in arch/powerpc I see there is
> atleast one more place where we may still need the fix.. There are few
> more places which grep returned - but I am not sure if they all really need
> the fix. But I guess VAS should be fixed i.e :
>
> arch/powerpc/platforms/powernv/vas.c:   xd = irq_get_handler_data(vinst->virq);
>
> Would you like to submit an official patch for converting these other places too?

Thanks for the report. I didn't expect struct xive_irq_data to be used
in multiple files while making that patch, sorry about that!

Something like your patch should do the job. However, my gut feeling is
that multiple files shouldn't share a single irq struct this way. Let me
stare at it...

Nam

