Return-Path: <linux-kernel+bounces-856798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6312BE51C9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4CFD4EC6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0508823958C;
	Thu, 16 Oct 2025 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RO5o/lOd"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC2290F
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640776; cv=none; b=nGiVoJvqU7rORLcpy6HwiaBGvsrpWuBBree5BVDt8fjLvhCI2QwixESWH6cb50exJNpK9hhRw8tumFv/dYCLCiYl55AaZGuVxx4/uS8L9rJmHyPosW216/PGY2iO/fe87QB14Cjmm3n0CY5iyPWEP4XzxEpuieAR7LHIPsKpJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640776; c=relaxed/simple;
	bh=WueHvcKr5EsUw/kTPGTDIhGZhyMzxa3z14GoKAIVh0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdsOXhP78pMMLEWG4+fVhkF56w74KswIR1CaZIQPvpqAd6gzygIbYLtpU/ZyTwffk1ifJGDVoXyTw8c+nX5tNCNrGcf57gUoWCKWpt4QFlRy5O85ssQxBCFTluQDB4xRRbwkQ5UafZ0LVaAGHXH4Ooce+Sz1dTiuqj9Nc1hO6og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RO5o/lOd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KPO4OMUOafFZ2/AA6OLS6t9Dy0t7EiEKxJlM5HXbLk4=; b=RO5o/lOdn1P1loSyGKNkI0TeHX
	VwK9O/wZKYoAZoFTs7+31wLT5tUFdecbSCfPiIesbcLcL2DXQFzN6LETONrgXRp1OnHilP+1iBVd+
	WvZpzcPcwsZky3YiP+Z9Y2hoDcW0B9RgpUK6sdP6SdjPZQ40DHaZq+Qi9/7DpLN/FmGp2c/MCJ/Iv
	H6PmO6TqbwlLCkTNj+MlZxtU+Y5OPDnme9WzugbOgp56axjUFbmgUiwaXdKkrCLCeOcypgCSYSzOe
	wS5bV3GGn+4fOeoHAYQ/b0rXmFPzeqX3p46zeKGCnhQUKT2veMSuQwysDQy9bSTOiL4m4S3GLJ+UU
	nrqA681w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9T5e-00000006xkD-2rj2;
	Thu, 16 Oct 2025 18:52:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 91864300220; Thu, 16 Oct 2025 20:52:41 +0200 (CEST)
Date: Thu, 16 Oct 2025 20:52:41 +0200
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
Message-ID: <20251016185241.GG3289052@noisy.programming.kicks-ass.net>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-41-david.kaplan@amd.com>
 <20251016103549.GD3289052@noisy.programming.kicks-ass.net>
 <DS0PR12MB9273D987B842D9E80081261A94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <20251016144730.GC3245006@noisy.programming.kicks-ass.net>
 <DS0PR12MB92731E9877D21E36EC3EE4ED94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR12MB92731E9877D21E36EC3EE4ED94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>

On Thu, Oct 16, 2025 at 03:34:14PM +0000, Kaplan, David wrote:

> I will note that on AMD, MFENCE has the required serializing
> properties (like SERIALIZE).  On AMD, we could use MFENCE in
> sync_core() which is probably faster that iret_to_self().  But
> again...do we really care.

About faster, no. But MFENCE has the benefit of not causing VMEXITs and
also not being IRET, so I'm not opposed to you using that as an AMD
version of SERIALIZE for the time being.

