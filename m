Return-Path: <linux-kernel+bounces-856804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BABBE521A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19E519A7D22
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E548423A9B0;
	Thu, 16 Oct 2025 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ky9w1pjw"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998A238150
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641116; cv=none; b=H2HO3iIv8TgqGIUfnOZ5IQKI6g2YYhT8HHpv3NqC8z+oHNmAUvxnFW7QirDRZUTuO9EM2oE39ezN3aVaW9gIiToRAbBb6Tjncq/pUZW54Cb5rn7qoCy4S0xnrFghZ3Ypp2nYUnFbT/cpsth7JRA+fXcvg24dTtucIZ7f9BglFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641116; c=relaxed/simple;
	bh=hieNmDL6CV0CQ0g9fQ0necdkOryA2H37vHfL0f5TuuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mD4QtOw7hwiKn+9sFmKjMG2qXQhcgMUYRzYLkKUPEovSrWlvGNQ84FFhCkmE/QvCDJKHFXtXvHIg29I66A3mxtPG0UbvMzfNZvSsqoCpYDfWe/JFNvx17DTkWYO2yRF21POuibRLGanje+jYzP6nQL7VVd6UofBpfkL9W2n2gpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ky9w1pjw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Qhs2qcqoum6RbatEKAz3kJjY1uzLIb/Q3dLtcnVQnk=; b=ky9w1pjw7OZ9Y/mmJti+/SSD8N
	x1zCwwWwkgAQAF2vCZ1NoEIFGsc/edxLGaXrRbS0FhMUyVM2/HUO+luD93Cqzon1U+n9lktUxvlft
	uaFzIPE65C8rdh0fWuHkOUr1UnwV7hteT9EvCNfZGXxACdl1eCwozU/ApST9piMtPMQHa6C7hTFnk
	MnSayJmtHodl2vZaFGLpqNJfvcsnj+aFcwlKW418SfSBTnrLFtw/O0W+1eR3CiI642MucKdkkPmYH
	PActZUFGiOYTLKwc2dnfL6RSTgg+aSF0txYUP7riX7AXpWauGeflsSxBXkKt5AqboRgn1KcCFzjlU
	OAOdcb7A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9TAy-00000006xuL-1oMQ;
	Thu, 16 Oct 2025 18:58:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B521B300220; Thu, 16 Oct 2025 20:58:11 +0200 (CEST)
Date: Thu, 16 Oct 2025 20:58:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe()
Message-ID: <20251016185811.GH3289052@noisy.programming.kicks-ass.net>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-41-david.kaplan@amd.com>
 <20251016103549.GD3289052@noisy.programming.kicks-ass.net>
 <DS0PR12MB9273D987B842D9E80081261A94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <20251016144730.GC3245006@noisy.programming.kicks-ass.net>
 <DS0PR12MB92731E9877D21E36EC3EE4ED94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <20251016185241.GG3289052@noisy.programming.kicks-ass.net>
 <DS0PR12MB92733EEEF2FDF39045008EEC94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR12MB92733EEEF2FDF39045008EEC94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>

On Thu, Oct 16, 2025 at 06:56:41PM +0000, Kaplan, David wrote:

> > About faster, no. But MFENCE has the benefit of not causing VMEXITs and
> > also not being IRET, so I'm not opposed to you using that as an AMD
> > version of SERIALIZE for the time being.
> 
> Ok.  Btw, how long has Intel supported SERIALIZE?

I'm not sure.. its fairly new, so

> Do we even need a 'mov-cr2' version of sync_core or could we say that
> dynamic mitigations requires a CPU capable of either a serializing
> MFENCE or SERIALIZE.

don't think we can get away with that, alas.

