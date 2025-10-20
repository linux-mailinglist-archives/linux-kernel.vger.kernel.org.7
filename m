Return-Path: <linux-kernel+bounces-861901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B1ABF3F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A3A04F04F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088AB2F3C1E;
	Mon, 20 Oct 2025 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDBzXZ3v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2DB6BFCE;
	Mon, 20 Oct 2025 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761000130; cv=none; b=I85dTUlGD/KDrjiiSMPtOuFfUFG6GIolRZlGnfN83LVZXdEfG8kxQr/C6BHEH+J83aYXrKMjbnJbhsRKHNaXhA6Xn9y0TZlCdJlVrb1Dl+0Q7muh50PXpZ71zz/k1T45AQKRlQj7kBqIjn0ghBGIelBrDN4HJ0gMD9fSzGv/ndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761000130; c=relaxed/simple;
	bh=iu6pGzNNNImU64aQiHqIp2NRkU5k6hrYuzTFzZvTvHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh9S3ucxLTVUwS4Dpm4jdF0fFZUdaLDO+FcXPIxBRUogPhh/WKwgJhgHPHSl4x2TqCrArcZhc3pbuRJKEkbFzuDo2gq8kq+hj4mZrLHo7b6aPZSVI24HXVCgUEjCQ2kiIurzf7s9tPMjc/Rs6wVxOnVVbhx54YbfrrQ+TbMjkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDBzXZ3v; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761000129; x=1792536129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iu6pGzNNNImU64aQiHqIp2NRkU5k6hrYuzTFzZvTvHc=;
  b=EDBzXZ3v6Hm2BBUmzMg7nqubSH2QDeFWWhZ5FtFSBB6o1RT5pzPszEjA
   qOTIUAKiuEFQjbDInMmALDru20SZZDXM7IaCSv8KGWx0p/YDnzJ6er+nF
   lM0gpHycxLVA+SvkxqNf9uaecYCrlJCvCkxHRoMtCumtoqKpBw4euBKzE
   XsZxhFL9FNfEhKnVH4YG5VcUMOuU7hTX2xZ/UlkMEdM5zWTePeX2uLmWJ
   KnqV2OjABv/laDIGl9nZGzx85yoaRq7Pt8ehNih/bN3L9LWT499nEkIQ8
   PnmHnDgld+A3isKS71jrGbxltrV2ltqT+n+shWihRuI70iGH+PEQDxu4N
   A==;
X-CSE-ConnectionGUID: JiTtiNm/R4SnyXIaGxm9Pg==
X-CSE-MsgGUID: 9YB7spdAQrqdaJLyEJiASw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50695875"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="50695875"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 15:42:07 -0700
X-CSE-ConnectionGUID: 8yVOQ2eMStyEt5w1siwO3w==
X-CSE-MsgGUID: F26zH07TTyOo32AlUsmt7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="182630847"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO desk) ([10.124.220.167])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 15:42:06 -0700
Date: Mon, 20 Oct 2025 15:41:59 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jon Kohler <jon@nutanix.com>, Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20251020224159.xkhfs3phai5o6rzb@desk>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <20251020194446.w2s5f6nr7i7vw4ve@desk>
 <EA2E1D80-07A3-459D-B330-A667821E7C05@nutanix.com>
 <20251020204026.a7xuhnagsqo4otpx@desk>
 <225134fd-033f-4d63-b88c-772179054694@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <225134fd-033f-4d63-b88c-772179054694@intel.com>

On Mon, Oct 20, 2025 at 03:09:41PM -0700, Dave Hansen wrote:
> On 10/20/25 13:40, Pawan Gupta wrote:
> >> I can’t speak to other VMMs (e.g. vmw, hyperv, hyperscalers) and how they do
> >> it, but I suspect there are similar challenges around post-launch feature/bit
> >> additions that require the VM to be completely cold-booted.
> > Ok, that makes BUS_LOCK_DETECT a better choice than BHI_CTRL. I think it
> > be better to replace BHI_CTRL with BUS_LOCK_DETECT.
> 
> Folks, I just think this kind of random feature spaghetti voodoo is a
> bad idea. Suppose X86_FEATURE_BUS_LOCK_DETECT is in silicon on an
> affected part but normally fused off. But a big customer shows up with a
> big checkbook and Intel releases microcode to enumerate
> X86_FEATURE_BUS_LOCK_DETECT on an affected part.

Hmm, right.

> What then?
> 
> Your only choice is to convince Intel to make architectural the idea
> that X86_FEATURE_BUS_LOCK_DETECT is never enumerated on an affected part.
> 
> Because even if we go forward with that patch we've *DONE* that in
> Linux: we've made it de facto architecture and Intel can never change it.

Using BHI_CTRL here was in agreement with CPU architects. Even though its a
heuristic, it is very unlikely to be broken by a microcode update.

I can't say for sure about BUS_LOCK_DETECT.

> Can someone try to boil down the problem statement for me again, please?
> 
> 	VMs are slow because of mitigations for issues to which they are
> 	not vulnerable when running old kernels on old hypervisors.

From what I understand:

  Unless a VM is cold-booted, it cannot see the new features/immunity bits
  exposed by the hypervisor. In this particular case, a guest gets the
  updated kernel with ITS mitigation, but can't see the immunity bit unless
  it is cold-booted.

  The other part of the problem is when host kernel/hypervisor is not
  updated. In this case immunity bit is not exposed to the guest at all.

My 2 cents: All of this makes me feel the instead of exposing the immunity
bit, a guest should be told about the bug presence. That way security
minded users who update regularly get the bug enumerations, and hence the
mitigations. OTOH, performance focused users who don't update/cold-boot
often don't get unnecessarily slowed down.

