Return-Path: <linux-kernel+bounces-861662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6901BF349D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D8318A1D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DB32DF71B;
	Mon, 20 Oct 2025 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDelcynU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9E828C866;
	Mon, 20 Oct 2025 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990022; cv=none; b=PatoS+QBQq0PPbgF9mxZCVgPAem0lJc1bgpskPfQse+DsH7k9i2/4WzcHMXNw3lXgOmWW6UicghnmcLyDjzwC+Br2aCaxD6dmZ+0H8u11kIf2izC14ZiZQgHhv6kiMk9dS3o6wZQSYZDdvmHmI0+Ts9ns8AE3hD4+KnzMM3X5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990022; c=relaxed/simple;
	bh=GiPuwX2n1KW8u9LdDxhHUa5N4wFAVUmFRo0TNTy5gHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9ZveB8wEwtYqUxxLoS9/sUX6RGrTYnD82VcLqJYpOKTz1JSMGdeXGAsFkenFFvC8KPiqJTYUB7LDqMzONNZvJir7WwgfimtXoCcS0NZw8mASwfOeg+hQeUM3F3ymNPFUIZF6pcPRkSK21rQ/5de3S/FVgVGseUUaV3XItt6rE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDelcynU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760990020; x=1792526020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GiPuwX2n1KW8u9LdDxhHUa5N4wFAVUmFRo0TNTy5gHA=;
  b=PDelcynUOT3S0NeO1CP8nPmavthcLcFEtfAk7ez1YBckNR43yBwVo5bA
   Ose/lw3NPZjaAzoewWmukJuBLSSiR+llFZf4J4Q+CV4Sn+P3h8jylD0ZK
   Z+9hvDH7DreDu+Gi2/ylaEacBfsEHdE4MtLwnqwn/F7Lv7/bZ5Xn1acs+
   xZXdBXeGUBnGp0w2tfmo+aRQIQTDfzGxA1bGeBviFj6JsGfQC/vEtBcyJ
   JFj5eEYAEIagWP+uP0har3zz755dC1xcvM+Kr/by92MyzlhfxvTRjt+oK
   y4ZVjgI+N/M6ea71XR5mGKQ12/Rj4vPgyo+Oq0WUilJjg3L1xb8RoOxdU
   Q==;
X-CSE-ConnectionGUID: KQgYuS0GRoSyXkWF18Wurw==
X-CSE-MsgGUID: 5JaqGGKBQpGJQXLS1gNuBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62814584"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="62814584"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 12:53:40 -0700
X-CSE-ConnectionGUID: Bs3YZDwuQYGj7XxrwXh3ow==
X-CSE-MsgGUID: +grhdyUqSyWg3oYXKSzTMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="214029021"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO desk) ([10.124.220.167])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 12:53:39 -0700
Date: Mon, 20 Oct 2025 12:53:31 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Brian Gerst <brgerst@gmail.com>,
	Brendan Jackman <jackmanb@google.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Message-ID: <20251020195331.nnnp4y4o3fyzgwvx@desk>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <aPZZwoqWV8cJG2HH@google.com>
 <413D20D7-AB18-4D46-8128-6179F2565765@nutanix.com>
 <c1b2162f-5a1e-4072-8695-6c663a1ba0c5@intel.com>
 <20251020192605.yqg5mmvah2fzyjvu@desk>
 <7985318A-3669-4A1C-9282-D940F142252F@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7985318A-3669-4A1C-9282-D940F142252F@nutanix.com>

On Mon, Oct 20, 2025 at 07:38:40PM +0000, Jon Kohler wrote:
> 
> 
> > On Oct 20, 2025, at 3:26 PM, Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Mon, Oct 20, 2025 at 09:21:41AM -0700, Dave Hansen wrote:
> >> On 10/20/25 09:05, Jon Kohler wrote:
> >>> Was running into some testing issues with my qemu change internally,
> >>> but I’ll get that out this week once I clear them.
> >> 
> >> BTW, if there are folks out there that are working on things like QEMU
> >> and want more formal or regular notification from vendors that a FOO_NO
> >> bit has been added, that can probably be arranged.
> >> 
> >> The real issue here is that nobody cared enough to get QEMU to
> >> comprehend ITS_NO right after the embargo was lifted, right?
> > 
> > ITS_NO support was added to QEMU right after the embargo was lifted:
> > 
> > https://lore.kernel.org/all/8c1797e488b42650f62d816f25c58726eb522fad.1745946029.git.pawan.kumar.gupta@linux.intel.com/
> 
> Pawan - I saw that, but I wasn’t able to get that to work, as the supported
> feature checker will fail, and the VM will fail to start.
> 
> Specifically, kvm_arch_get_supported_msr_feature() will not show it as a
> “supported” bit, and kick it back, and you’ll get an error like so when setting
> -cpu … “,its-no=yes"
> 
> qemu-kvm: warning: host doesn't support requested feature: MSR(10AH).its-no [bit 62]
> 
> That’s because qemu queries KVM side, which is checking against supported
> hardware bits. Since this doesn’t come from hardware, it goes boom.

So this check isn't working?

kvm_get_arch_capabilities()
{
...
         if (!boot_cpu_has_bug(X86_BUG_ITS))
                 data |= ARCH_CAP_ITS_NO;


