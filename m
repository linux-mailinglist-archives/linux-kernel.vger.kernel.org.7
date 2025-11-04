Return-Path: <linux-kernel+bounces-885492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1E7C331EF
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EE6F4E7C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE17C346799;
	Tue,  4 Nov 2025 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="XzZ5d6wM"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE52F8BC8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293597; cv=none; b=iilEUkNVEVC/AhqMfzuOQo5rsjJVNsTT5Nr8qnihdF5lRBLMHzIrqrcLpPRoNgZ5V7WUA3bhvpfBH18XqpB2bejOT0wLfAZnneUJMejmtLyaA2pWiJapuaiS1pfSPGeRzsqskxv2K66dIwV1Umj2x8bFZV1kIomGFJMNXNU6EKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293597; c=relaxed/simple;
	bh=R2jitSrtsk70J7YPzlLrf8PC83kaHTdXHSEQPmN5wCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Peuk7fTOQj3m5aTltdR+ARqEhR1H+uIEwTeOGoqMGVFFPTfuKhVtd+2/xbLtc6avKxuaFf4zaKfO/vtt0W3jeJxRIqirdWbGjLfaaKeQKvP6Ys7veRgJiFzRK9fz4s3JrkkqNjTRht4BYOCKeBWGsjAuts1zh8kTR+Nc3/9i05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=XzZ5d6wM; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Xhuttl3JoK8PGtwmxhWuCvI90qbtuGFHePA73jfrIoQ=; b=XzZ5d6wME4fHE4N1
	s/pW6SKOj9eRqEUvjKVJ2iuRtW8iok2Yptn/cydPOsokbGbjyhRg4nV9+fSWj0nPNNcKQ4Ioyu+Km
	/qAldJlT6hGBQ0D7KuCm48pFAPfPVREWNbSqrYxVSn3/eveIfaqXJd49W5zgxmYC8HXL04ngWuBYk
	QC1hRMcL78CqHW45LW6RCVKpleu2FG4iY7lP5JXIDe7n98hVoYCdabS6Utq5noAdNo/WEupyMX8Fo
	p1oUYPae3/fv68Pkw5ENVRl7ikUtzt1AIpXkXjyuno4Z1t3S/5rgt+sNxues/oeTQYd+fXB1KFFbq
	bjrw/cX1tXTj2BrpCw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1vGP49-000000022Ps-15vT;
	Tue, 04 Nov 2025 21:59:49 +0000
Date: Tue, 4 Nov 2025 21:59:49 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Stan Johnson <userm57@yahoo.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	sam@ravnborg.org, benh@kernel.crashing.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	rdunlap@infradead.org, Cedar Maxwell <cedarmaxwell@mac.com>,
	Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v4] powerpc: Use shared font data
Message-ID: <aQp3Ve1C-aZ8BhXa@gallifrey>
References: <20230825142754.1487900-1-linux@treblig.org>
 <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com>
 <aQeQYNANzlTqJZdR@gallifrey>
 <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org>
 <aQgJ95Y3pA-8GdbP@gallifrey>
 <797f0a13-350f-e26d-f1ef-876419e1c013@linux-m68k.org>
 <aQo-5T8z2nwtNe2p@gallifrey>
 <3017c67c-87e9-c06f-3146-ee461cd6603f@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3017c67c-87e9-c06f-3146-ee461cd6603f@yahoo.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 21:59:24 up 8 days, 21:35,  2 users,  load average: 0.01, 0.03, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

* Stan Johnson (userm57@yahoo.com) wrote:
> Please see the attached config file that Finn sent to me along with his
> patch. The relevant line is "CONFIG_BOOTX_TEXT=y"; without that, the kernel
> boots on the Wallstreet.

Thanks - I'll have a play.

Dave

> On 11/4/25 10:59 AM, Dr. David Alan Gilbert wrote:
> > * Finn Thain (fthain@linux-m68k.org) wrote:
> > > 
> > > On Mon, 3 Nov 2025, Dr. David Alan Gilbert wrote:
> > > 
> > > > 
> > > > > Anyway, I imagine that the problem with your patch was that it relies
> > > > > on font data from a different (read only) section, which is
> > > > > unavailable for some reason (MMU not fully configured yet?)
> > > > > 
> > > > > So I've asked Stan to test a patch that simply removes the relevant
> > > > > 'const' keywords. It's not a solution, but might narrow-down the
> > > > > search.
> > > > 
> > > 
> > > Stan tested my patch to remove 'const' from the font_desc and font_data
> > > structs but it did not help. (There goes that theory.)
> > > 
> > > > I wonder if this is a compiler-flag-ism;  I see
> > > > arch/powerpc/kernel/Makefile has a pile of special flags, and for
> > > > btext.o it has a -fPIC (as well as turning off some other flags). I
> > > > wonder if bodging those in lib/fonts/Makefile for
> > > > lib/fonts/font_sun8x16.c fixes it? But... this is data - there's no code
> > > > is there - are any of those flags relevant for data only?
> > > > 
> > > 
> > > I don't know. But I'm sure Stan would be willing to test a patch for you.
> > 
> > Can one of you point me at the config you're testing with so I can
> > try some builds with it.
> > 
> > Dave
> > 
> > > > > 
> > > > > The BootX bootloader doesn't work on New World systems, which is
> > > > > probably why we don't see this regression on anything newer than a
> > > > > Wallstreet.
> > > > > 
> > > > > It's likely that other Old World systems are also affected, if they
> > > > > are using BootX. We don't yet know whether the regression also affects
> > > > > Old World systems using the iQUIK bootloader instead of BootX.
> > > > 
> > > > OK, remember I don't think I've ever tried PPC via MacOS booting, so not
> > > > familiar with it.
> > > > 
> > > 
> > > I will try to set up a MacOS guest in QEMU, to see if the hang can be
> > > reproduced that way.
> > > 


-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

