Return-Path: <linux-kernel+bounces-837873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32177BADEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AA91C747B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EC3307AD3;
	Tue, 30 Sep 2025 15:40:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25801246795;
	Tue, 30 Sep 2025 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246830; cv=none; b=CPrk08kmPUjEiShdACtV2Vv1M0qSVyS7U34Pc/HIFFK3av+WdjmCY61i2M/zbKBIkvwimPq8uwBxsVemaZ9viDRwMhHa4gjngJxsFgxRdoLx4a8coGoREWtobTPJ948Yyub8mirLyrDz657fCT5UY7Naar/EnYldRDL8oj60dzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246830; c=relaxed/simple;
	bh=lyYDO7S+1l76oR2jHp0+B0UFePSL9untOGzCJpR9C0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZb23F38cxFBRr9ElmAg1/LvpEH+XDt8dX02xZcQ1P3N20KPQjd9r2sJzmWEQLcDZFIVXkNuHZDBmdr+VuMs59RV+q/vIpUo3gA9sXrWyyU6D3l+uqC/eaSRGwnphAo//eQkpM6HgN82+1QtChd2B6JcYi9ClK/2baiZP+n2LbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 188F31424;
	Tue, 30 Sep 2025 08:40:19 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F4493F59E;
	Tue, 30 Sep 2025 08:40:24 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:40:13 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aNv53UmFGDBL0z3O@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com>
 <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
 <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>

Hi,

On Mon, Sep 29, 2025 at 09:09:35AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 9/29/25 6:56 AM, Dave Martin wrote:
> > On Thu, Sep 25, 2025 at 03:58:35PM -0700, Luck, Tony wrote:
> >> On Mon, Sep 22, 2025 at 04:04:40PM +0100, Dave Martin wrote:
> 
> ...
> 
> >> The region aware h/w supports separate bandwidth controls for each
> >> region. We could hope (or perhaps update the spec to define) that
> >> region0 is always node-local DDR memory and keep the "MB" tag for
> >> that.
> > 
> > Do you have concerns about existing software choking on the #-prefixed
> > lines?
> 
> I am trying to understand the purpose of the #-prefix. I see two motivations
> for the #-prefix with the primary point that multiple schema apply to the same
> resource. 
> 
> 1) Commented schema are "inactive"
> This is unclear to me. In the MB example the commented lines show the 
> finer grained controls. Since the original MB resource is an approximation
> and the hardware must already be configured to support it, would the #-prefixed
> lines not show the actual "active" configuration?

They would show the active configuration (possibly more precisely than
"MB" does).

If not, it's not clear how userspace that is trying to use MB_HW (say)
could read out the current configuration.

The # is intended to make resctrl ignore the lines when the file
is written by userspace.  This is done so that userspace has to
actually change those lines in order for them to take effect when
writing.  Old userspace can just pass them through without modification,
without anything unexpected happening.

The reason why I think that this convention may be needed is that we
never told (old) userspace what it was supposed to do with schemata
entries that it does not recognise.


> 2) Commented schema are "conflicting"
> The original proposal mentioned "write them back instead of (or in addition to)
> the conflicting entries". I do not know how resctrl will be able to
> handle a user requesting a change to both "MB" and "MB_HW". This seems like
> something that should fail?

If userspace is asking for two incompatible things at the same time, we
can either pick one of them and ignore the rest, or do nothing, or fail
explicitly.

If we think that it doesn't really matter what happens, then resctrl
could just dumbly process the entries in the order given.  If the
result is not what userspace wanted, that's not our problem.

(Today, nothing prevents userspace writing multiple "MB" lines at the
same time: resctrl will process them all, but only the final one will
have a lasting effect.  So, the fact that a resctrl write can contain
mutually incompatible requests does not seem to be new.)


> On a high level it is not clear to me why the # prefix is needed. As I understand the
> schemata names will always be unique and the new features made backward
> compatible to existing schemata names. That is, existing MB, L3, etc.
> will also have the new info files that describe their values/ranges.

Regarding backwards compatibility for the existing controls:

This proposal is only about numeric controls.  L3 wouldn't change, but
we could still add info/ metadata for bitmap control at the same time
as adding it for numeric controls.

MB may be hard to describe in a useful way, though -- at least in the
MPAM case, where the number of steps does not divide into 100, and the
AMD cases where the meaning of the MB control values is different.

MB and MB_HW are not interchangeable.  To obtain predictable results
from MB, userspace would need to know precisely how the kernel is going
to round the value.  This feels like an implementation detail that
doesn't belong in the ABI.


I suppose we could also add a "granularity" entry in info/, but we have
the existing "bandwidth_gran" file for MB.  For any new schema, I don't
think we need to state the granularity: the other parameters can always
be adjusted so that the granularity is exactly 1.


Regarding the "#" (see below):

> I expect that user space will ignore schema that it is not familiar
> with so the # prefix seems unnecessary? 
> 
> I believe the motivation is to express a relationship between different
> schema (you mentioned "shadow" initially). I think this relationship can
> be expressed clearly by using a namespace prefix (like "MB_" in the examples).
> This may help more when there are multiple schemata with this format where a #-prefix
> does not make obvious which resource is shadowed. 

An illustration would probably help, here.

Say resctrl knows has schemata MB, MB_HW, MB_MIN and MB_MAX, all of
which control (aspects of) the same underlying hardware resource.

Reading the schemata file might yield:

	MB: 0=29
	MB_HW: 0=2
	MB_MIN: 0=1
	MB_MAX: 0=2

(I assume for this toy example that MB_{HW,MIN,MAX} ranges from
0 to 7.)

Now, suppose (current) userspace wants to change the allocated
bandwidth.  It only understands the "MB" line, but it is reasonable to
expect that writing the other lines back without modification will do
nothing.  (A human user might read the file, and tweak it through an
editor to modify just the entry of interest, run it through awk, etc.)

So, the user writes back:

	MB: 0=43
	MB_HW: 0=2
	MB_MIN: 0=1
	MB_MAX: 0=2

If resctrl just processes the entries in order, it will temporarily
change the bandwidth allocation due to the "MB" row, but will then
immediately change it back again due to the other rows.

Reading schemata again now gives:

	MB: 0=29
	MB_HW: 0=2
	MB_MIN: 0=1
	MB_MAX: 0=2

We might be able to solve some problems of this sort be reordering the
entries, but I suspect that some software may give up as soon as it
sees an unfamiliar entry -- so it may be better to keep the classic
entries (like "MB") at the start.


Anyway, going back to the "#" convention:

If the initial read of schemata has the new entries "pre-commented",
then userspace wouldn't need to know about the new entries.  It could
just tweak the MB entry (which it knows about), and write the file back:

	MB: 0=43
	# MB_HW: 0=2
	# MB_MIN: 0=1
	# MB_MAX: 0=2

then resctrl knows to ignore the hashed lines, and so reading the file
back gives:

	MB: 0=43
	# MB_HW: 0=3
	# MB_MIN: 0=2
	# MB_MAX: 0=3

(For hardware-specific reasons, the MPAM driver currently internally
programs the MIN bound to be a bit less than the MAX bound, when
userspace writes an "MB" entry into schemata.  The key thing is that
writing MB may cause the MB_MIN/MB_MAX entries to change -- at the
resctrl level, I don't that that we necessarily need to make promises
about what they can change _to_.  The exact effect of MIN and MAX
bounds is likely to be hardware-dependent anyway.)


Regarding new userspce:

Going forward, we can explicitly document that there should be no
conflicting or "passenger" entries in a schemata write: don't include
an entry for somehing that you don't explicitly want to set, and if
multiple entries affect the same resource, we don't promise what
happens.

(But sadly, we can't impose that rule on existing software after the
fact.)


One final note: I have not provided any way to indicate that all those
entries control the same hardware resource.  The common "MB" prefix is
intended as a clue, but ultimately, userspace needs to know what an
entry controls before tweaking it.

We could try to describe the relationships explicitly, but I'm not sure
that it is useful...


> >> Then use some other tag naming for other regions. Remote DDR,
> >> local CXL, remote CXL are the ones we think are next in the h/w
> >> memory sequence. But the "region" concept would allow for other
> >> options as other memory technologies come into use.
> > 
> > Would it be reasnable just to have a set of these schema instances, per
> > region, so:
> > 
> > MB_HW: ... // implicitly region 0
> > MB_HW_1: ...
> > MB_HW_2: ...
> > 
> > etc.
> > 
> > Or, did you have something else in mind?
> > 
> > My thinking is that we avoid adding complexity in the schemata file if
> > we treat mapping these schema instances onto the hardware topology as
> > an orthogonal problem.  So long as we have unique names in the schemata
> > file, we can describe elsewhere what they relate to in the hardware.
> 
> Agreed ... and "elsewhere" is expected to be unique depending on the resource.
> 
> Reinette

Yes

Cheers
---Dave

