Return-Path: <linux-kernel+bounces-853090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA7EBDA9CD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E02719A5140
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7090E30170B;
	Tue, 14 Oct 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA9XHRSU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6E2D876F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459368; cv=none; b=tzf5ohAjLwLdeR5+aZqknpPpun5EC63a0CiVc4XM+gyrCLAAgTyiXb0fLD0phdBCiS760a/+rPyHgv49CP3FAKvznn/QgCAcd/izqLgDalAXQen4cjOmCoZAqTteftplPrvFsDvkt3j1tT2Ko2pPPKq7BtBSDRww2PXmuB5UOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459368; c=relaxed/simple;
	bh=DcwVZ9Y30OVqHvzjglvQ8qpXSreYZR6McFtNUSOOpnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSpG9pQasNgSht9leksq1NsST/pn0FxpTHHqijdbqbJI5kwYF+JVn0dtUhKamNAShQ6PIodXHz/RwO8Q8zUXsOe+UtD5qHBmYA5Q7Cn8AnHRwqLT3XBvd6CLHRmluq+OZUm8F7SurrA3zUWU5SSE8v662q6U2pIYCoJTC4BRYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA9XHRSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7EEC4CEE7;
	Tue, 14 Oct 2025 16:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760459368;
	bh=DcwVZ9Y30OVqHvzjglvQ8qpXSreYZR6McFtNUSOOpnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RA9XHRSUcnZPOm9BRd1kEay+sD9PYexWFMzXGPWj74YO3uvMvr0hQcF/PaKM0L694
	 O6JNKlD0XUjvtYZI/kPNSdTPGNqeTT1g/+udehSRBcuLz+S6jjmmzQpKL7CMrJ8DoQ
	 rhf569WLTUZtK8cKPxy+qH6xSaecifH+dBcx4/NjA4DU7VJG3kMt/8BDdPhRwLk3Bb
	 AFK6KGyvCee7ZWQmqYKOuWwT5Wd/aeXesUZhWe/bZNZDwDGzE+dbPlz3LpZzGRpY69
	 YzSu4x03XOKKow0bMbJWRLWePjMcsfeePeghNBnUfNJx9YS2dzMw6GLZSlvmVzyIkF
	 GLXTRcyzePZVw==
Date: Tue, 14 Oct 2025 09:29:25 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
Message-ID: <bjgjmijirueqwwmuen5dr6v7yqdcivk6kwa6gbukn3rodfcwko@fb5yxyqycena>
References: <20251013143444.3999-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013143444.3999-1-david.kaplan@amd.com>

On Mon, Oct 13, 2025 at 09:33:48AM -0500, David Kaplan wrote:
> Dynamic mitigations enables changing the kernel CPU security mitigations at
> runtime without a reboot/kexec.
> 
> Previously, mitigation choices had to be made on the kernel cmdline.  With
> this feature an administrator can select new mitigation choices by writing
> a sysfs file, after which the kernel will re-patch itself based on the new
> mitigations.
> 
> As the performance cost of CPU mitigations can be significant, selecting
> the right set of mitigations is important to achieve the correct balance of
> performance/security.
> 
> Use
> ---
> As described in the supplied documentation file, new mitigations are
> selected by writing cmdline options to a new sysfs file.  Only cmdline
> options related to mitigations are recognized via this interface.  All
> previous mitigation-related cmdline options are ignored and selections are
> done based on the new options.
> 
> Examples:
>    echo "mitigations=off" > /sys/devices/system/cpu/mitigations
>    echo "spectre_v2=retpoline tsa=off" > /sys/devices/system/cpu/mitigations
> 
> 
> There are several use cases that will benefit from dynamic mitigations:
> 
> Use Cases
> ---------
> 1. Runtime Policy
> 
> Some workflows rely on booting a generic kernel before customizing the system.
> cloud-init is a popular example of this where a VM is started typically with
> default settings and then is customized based on a customer-provided
> configuration file.

I'm not really a fan of this.  It adds complexity to some areas that are
already struggling with too much complexity.

IMO this would need some REALLY strong justification, more than just
"hey, this makes things more convenient."

The mitigations should be a "set it and forget it" thing.  I don't see
anything here which justifies the considerable maintenance burden this
would add for all existing and future mitigations.

-- 
Josh

