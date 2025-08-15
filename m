Return-Path: <linux-kernel+bounces-771505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962ACB28826
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1255E0674
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1892233733;
	Fri, 15 Aug 2025 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FWxQIV/B"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1228399
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295496; cv=none; b=fxUcHlFyDJDiYB+IcAuCYkEd1IgqOUPU3m7OrofMPTa7S3DqKzUCqbf9EtiRe2aP9Cy85R25WV/viF3tnNC0XNNT+kftAZFKGzQLedZGCDmIaxK6KJJ89Bo8eC+/4tbKSc8Sd3OEWiX8w2ehAzwa0GUsKE9s89FC120mNt5LhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295496; c=relaxed/simple;
	bh=TZurvUUFSPgNH6z5/czyUnwttfzqM+6JAE14E6s/fKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiSbF0R+06TYyHqIGH8MXkbRHRRBSnWhi46j6A6j6UuB/RUapMcjvZgPbuvkPRPFSQSOaUk3dv3j4cdaDL0MHAqyLQtVngcFWi3MVPGxfuC/8DNny8aSvD9xG8dOJXL+zxef4CnFQjMFxAzLXJvsYdkVKv5st6zY69nWRDn0vrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FWxQIV/B; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4E16840E0176;
	Fri, 15 Aug 2025 22:04:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JhQ0q_gkX7Vp; Fri, 15 Aug 2025 22:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755295489; bh=MG+WMSSjDbak1gqRkbJAj+pCePOB4PVWM1wVQaAZYZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWxQIV/B6xObUI61b2gxzV2VNT8eGYHSzPklG0/OQXJdc46LY/EvcDbwQLrMWaPxR
	 sRDibXQIrsSpTaF+eJyhZ5em8UKNQWJpLTFEyWRfXiVL6snNjEjBHYVO1Pq1Oj96C+
	 Aoac1VqoELnvHyLaFg0ECZxr5V2QrkGYgp1quNbZL8BLe89Fs7yPQcBzx09dPNS02X
	 AbHGSBgFbTorJybcacAvozsGd0BoxQTfGn1itQohs+3KV+yBe7fH3vhbU63U0gRcag
	 Atei6tQtU2aTUK1yC9OEcp6ZOcIJ8/6rU8iZw+eeV0Y6vrzr69q6tLHa7V3M76NdXl
	 HPsspBhTGM2LAcJ//kQ4+RYee9CY0cXnFo6xj5Y+U2GnfuKnKzcryW4miUTR+eYpfk
	 40yMuL6uNDMVnuYcWST4SBwvJPVDNyzNajAww1V8pWCtZha5ruhEx3Q1sR3iiqnZY+
	 dA7du1lbC+XG4X3+9qoxcL6dmW0nJYj6rJcgNm8fr3xTESWtkx7vXlrERyWnZ2j9Tu
	 rjiyYVmcFgMmV2BhKmdxvWv5n6nmIwLtIa6TejBilSWT8ilUpMTUu6t3bEs0fueTyp
	 /E0BU0ktGAq5sSkuUjE9B/h5PhLcXKjQiGhIutZ1jJUg4gauHuaHbm0gp8DIjYifxR
	 Gp8ao37Tg6nDNXCN3G7JCqKE=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CEC6740E00DA;
	Fri, 15 Aug 2025 22:04:41 +0000 (UTC)
Date: Sat, 16 Aug 2025 00:04:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>,
	David Arcari <darcari@redhat.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
Message-ID: <20250815220436.GJaJ-u9FUVTmjyaaua@fat_crate.local>
References: <20250721181155.3536023-1-yazen.ghannam@amd.com>
 <20250722165615.GCaH_CryG7kNrAS4O6@renoirsky.local>
 <20250723183426.GA1158000@yaz-khff2.amd.com>
 <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de>
 <aIKehTDgP-Nu36ol@google.com>
 <3cc16f7d-c650-43f2-b0ca-d99c427cd69b@amd.com>
 <aIKmeclza-9TDe4U@google.com>
 <20250725065009.GAaIMpIVgAKi0kMBVv@renoirsky.local>
 <aJ-pJvrPyHyPI0qS@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJ-pJvrPyHyPI0qS@google.com>

On Fri, Aug 15, 2025 at 02:39:50PM -0700, Sean Christopherson wrote:
> You're conflating running under (on?) a hypervisor with being a guest in the
> traditional model of virtualization.  Running a privileged, host-owned software
> stack in a virtual machine is beneficial/desirable for a variety of use cases,
> and I expect the number of such use cases to grow in the near future.
> 
> E.g. as mentioned earlier, pKVM uses virtualization to de-privilege the kernel,
> and Hyper-V's VBS uses virtualization to monitor accesses to sensitive state.
> 
> Future use cases could use virtualization:
> 
>  - to improve system stability/uptime, e.g. restart the VM if the kernel crashes
>    as opposed to rebooting the entire host
>  - to isolate different software components, e.g. to run post-boot functionality
>    in a separate VM to limit the impact of an escape/flaw/bug
>  - to limit the amount of code that has direct access to system physical resources
>  - to partion a system into multiple machines (each running their own kernel)
>    for performance reason; e.g. AIUI, kernel-wide locks are becomming more and
>    more problematic as the number of cores continues to go up
> 
> Not all of those use cases will want to access "bare metal" features, but my
> point is that inferring anything about the system setup based solely on the
> HYPERVISOR flag is all but guaranteed to break sooner or later.

No, that's *exactly* why I will want to check HYPERVISOR. Because I don't know
what any of that virt zoo of paravisors, smaller layers, this and that layers
are hiding from me.

That's exactly why I cannot trust that register anymore.

Or do you have a better suggestion how am I to know in the kernel whether the
values I read from that register actually come from the hardware the feature
support was added for? Or not some funky layer in-between.

Hell, I can't even trust HYPERVISOR. Because some sneaky layer might not even
set it.

Which makes this even worse.

> That seems like a gigantic waste of time/effort.  E.g. imagine the pain/churn if
> MONITOR/MWAIT had been limited to !HYPERVISOR simply because early VM setups
> didn't support executing MONITOR/MWAIT natively.

No, that's called enablement. You test the kernel on your new hw or HV env and
then you send patches and claim support. And we support it.

> Patch loading is exceptional because, AFAIK, neither Intel nor AMD officially
> support ucode updates while running as a guest.  Though FWIW, I do expect that
> sooner or later someone will indeed want to do patch loads in a VM.

Oh, ofc. If you give the non-rebooting clouders a finger, they'll bite off the
whole hand if they can.

> I don't mind HYPERVISOR per se, what I don't like is disabling code (or going
> down different paths) based solely on historical use cases, i.e. based on the
> assumption that "no one will ever do xyz!".  I have no objection to pivoting
> on HYPERVISOR if there is an explicitly documented limitation, or for cases where
> there's a very high probability of making a bad decision, e.g. using FMS to
> enumerate features.

I don't think you're reading me here: it is not "no one will ever do". It is
"off until someone really says she will do it. And do it according to the hw
spec."

Because if she does it differently, then also crap.

So until she does it right, it is off.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

