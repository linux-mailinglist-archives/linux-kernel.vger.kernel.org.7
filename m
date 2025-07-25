Return-Path: <linux-kernel+bounces-745340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD1EB118A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A055A2554
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7EB2882DD;
	Fri, 25 Jul 2025 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EPDJGlE6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50031DED4A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426112; cv=none; b=H22xd8BE68mxe4MDNITCKya8964jlKrU5mBZpHibfurU4CXDHrS95cd736x9zcy07UcIoxBEDip6fzGO/wFJFdETkgvKomlnOTYiIG+rfDX1q0RAMxy7XoFzhUC/QjWz5RtWmiztX6fNNXtYJmikxb2L7x1x3acGJYdlkCEOrTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426112; c=relaxed/simple;
	bh=gOWsQwtUIOAeo2hv0/Zu/AML+5so3HiXSwhErIXWrjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcK5McsY7S7W/B8wimgP/OkIyJOAxNV3N/kkXX5poI8qqpdkaDEQHa3RHsAo3AqS8duBa8Zsv+EDurxiis32PDoVLobt0B6Zivv696yHa069QXUFFcmWkz8Lf4ZXln4okoa/DDxQgCWE5/emxYI1mZ9rtDb6ZIqP6pkuOCKBUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EPDJGlE6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CD68940E01FD;
	Fri, 25 Jul 2025 06:48:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8SyFssLLXW6E; Fri, 25 Jul 2025 06:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753426095; bh=Lv0U0rCLx73jF5ldM8hNqeOnIEhjOB/QBj4YEAU9vw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPDJGlE6MxXdUhEMoSlE7hsyJdLiDt0uUl5MyNaeoYud7Byc01ju5QQMbYwAV7qdW
	 FmE5zrS5GRvWq6/tODTWVsd+TRNZX2hJLvfyPlWh7FfjA2nYDAb7Srx7jcRNFGAIcO
	 u9u9jilQznggHr/9bffirSRNWXswvGVyCFidXzY9HFNcilaofp7FNDAFSVgAITb9w9
	 Ywlc6JGIJpR4DoMb4Py2BaTSNOz9EyMVbxmbZmBFvsbCufv6tqocZRm0YE9JJYPWI9
	 o48cGL7Qas9vZQXpTeJue5bNvhHI/JQ4sAGdGqty4ASRNj6uvzSMsky1cif5Gfi77j
	 X8GT+hWNHDfo8jPLwfwMHam3aFvpx0GlZhVhb3WA8eRnP1nZgTBF7aePEXfgQrj+IP
	 y5sjeo+CwCElJB94AG/s0F7ajMtDh1yWWqHhe7B6IZjC7AZSdQxHRgW4fGYWBJ8vEo
	 SwHcXFj+o43/zv+xjULX0i4af2CLSwSAhtHWE99MOHPrb+dqtpZyokPrJ/NF4LiVrH
	 +vabhRPSfyCDnN9d6ERXMaLkcLCazbgOxY5S+pTPnCN4hKr2KhmiKTmDYOuSUFTRLH
	 t8Pr9DFaNfe7/rdvAt0BNMymYEdS9ZE00a2O0TKxuEE5LJ51MHUTg3WA8RPnCcxbkV
	 l/nB6TeyhXZTO2337bLMMcFg=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 44EAF40E025A;
	Fri, 25 Jul 2025 06:48:08 +0000 (UTC)
Date: Fri, 25 Jul 2025 08:50:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>,
	David Arcari <darcari@redhat.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
Message-ID: <20250725065009.GAaIMpIVgAKi0kMBVv@renoirsky.local>
References: <20250721181155.3536023-1-yazen.ghannam@amd.com>
 <20250722165615.GCaH_CryG7kNrAS4O6@renoirsky.local>
 <20250723183426.GA1158000@yaz-khff2.amd.com>
 <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de>
 <aIKehTDgP-Nu36ol@google.com>
 <3cc16f7d-c650-43f2-b0ca-d99c427cd69b@amd.com>
 <aIKmeclza-9TDe4U@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIKmeclza-9TDe4U@google.com>

On Thu, Jul 24, 2025 at 02:32:41PM -0700, Sean Christopherson wrote:
> Not necessarily.  There are a variety of use cases for doing nearly-full passthrough
> of bare metal state into a VM, e.g. to deprivilege the "main" OS, interpose and/or
> isolate select resources, etc.  I don't think it's too far fetched to imagine one
> or more such use cases exposing this range of MMIO to the guest _and_ also setting
> the HYPERVISOR bit in CPUID.

What would be that use case?

To tell the guest why the hypervisor rebooted?

Sounds weird to me but virt does weird things sometimes. :-P

> But whether or not there's a legitimate use case is beside the point.  I'm not
> arguing this is at all useful for VMs.  I'm arguing _against_ splattering
> X86_FEATURE_HYPERVISOR checks all over the place just because an error was first
> (or only) observed while running in a VM.

We use X86_FEATURE_HYPERVISOR to gate purely-hw-only features behind it.
Because they don't make any sense for guests. Just like this one.

And even if this one makes sense for some virt scenario, we want those
folks to *actually* explain why removing the HV check for that feature
makes sense. And why the kernel needs to support it.

Just like loading microcode in a guest, for example. There's a reason we
don't do that. And when some day, someone appears and wants to do that,
I would like there to be an explicit patch removing that HV check in the
loader and explaining *why* it is doing so.

And until that day, that feature is hw-only. Just like this one.

And yeah, I know you don't like X86_FEATURE_HYPERVISOR but I would like
to save some of my sanity when looking at a bug report which says that
the reboot reason reporting is talking crap, only to find out that a HV
underneath is doing something silly, muddying up the waters.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

