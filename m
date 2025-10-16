Return-Path: <linux-kernel+bounces-856003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B76BE2D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C7E4802BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5E724E4D4;
	Thu, 16 Oct 2025 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hCHcsbUT"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C787F32860C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610769; cv=none; b=lMNYUEcrcWLKTclZiRNCZKINi8KD0VR0M6w0FDMokVLAQE5fFMwhGASL68W9cHvyRJ6pgti39hT+HglIzkGtP1vsCt/MEVL9HWETqixAGnER9ZB/R2B7CIAeRsmQryHEBu35bPbkna6PJTdRUL+ROaCTuj/qJWFXGelhqDRSTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610769; c=relaxed/simple;
	bh=oV1uiFAG+Yh+0WULrefR5adZbWBIzSXC/3x1HPcVXSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daseDFbw/HsB+tbc9LWEUCMe/viGuAoAJRI+4gHPUD4bpe535HuwtmsrXy6soc9pGhqnxr1n0Qxe45KWErsBztOq6h44Gt1dy34oCgItOAHC38yGR/44djoYCtppaT5XSM42sfUQCQ4uaxWeGvyrBge0Gw3KEhGw6jFsRCwGxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hCHcsbUT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ylc53yLiqPO+MNJ0Cxf/0OyA1giIJ41XghRaxbqH3y8=; b=hCHcsbUT2h2iHhkvs6svwmIcGo
	163shKxM9P636542aj6ZllOOeYQ9cTPuwqJAujvs7WxHFjGzQezmSgN7+QPfV4a6xkCpNY9elID5Q
	RXfkaNfUlyRVdzhIZ/johjaD+b5EC4Pl4EPefH0iDBom1rLjtPjfpt+x2D1rJscQ3bo+XueGQaUET
	GXj1wkfm/7LQLjxaXP6k3sXP5qLZqQgXNb/WzqwudJE3xkAM43StNJO0Ve4/lzeuSC+YAoh1BXmim
	M0UIfz7xEzWUtQK2LDuvPSRrub8sFx3Jp5dFzlG+l+8ouE82msvYidSp6XgSoic5yV8WPqPKqUHXo
	R6m9cwWg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9LHd-00000001H3C-2HLo;
	Thu, 16 Oct 2025 10:32:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5655F30023C; Thu, 16 Oct 2025 12:32:33 +0200 (CEST)
Date: Thu, 16 Oct 2025 12:32:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpolines
Message-ID: <20251016103233.GC3289052@noisy.programming.kicks-ass.net>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-32-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013143444.3999-32-david.kaplan@amd.com>

On Mon, Oct 13, 2025 at 09:34:19AM -0500, David Kaplan wrote:
> When patching retpolines, nops may be required for padding such as when
> turning a 5-byte direct call into a 2-byte indirect call.  Previously,
> these were appended at the end so the code becomes "call *reg;nop;nop;nop"
> for example.  This was fine because it's always going from a larger
> instruction to a smaller one.
> 
> But this is a problem if the sequence is transformed from a 2-byte indirect
> to the 5-byte direct call version at runtime because when the called
> function returns, it will be in the middle of the 5-byte call instruction.
> 
> To fix this, prepend the nops instead of appending them.  Consequently, the
> return site of the called function is always the same.
> 
> For indirect jmps this is potentially slightly less efficient compared to
> appending nops, but indirect jmps are so rare this hardly seems worth
> optimizing.

Durr.. 

So Retpoline sites can be 5 or 6 bytes, depending on the register. 

Also, I suppose at this point I would prefer prefix stuffing
over multiple instructions. The prefix stuffing ensures it stays a
single instruction.

Alas, some micro-archs have significant decode penalties for >3
prefixes, and filling 6 bytes will need 4 prefixes :-(

