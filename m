Return-Path: <linux-kernel+bounces-782603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A23B32298
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1B4623B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B052C159F;
	Fri, 22 Aug 2025 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="drPvkBCv"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FC629B79A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889609; cv=none; b=ObCHNVBW0wlaMY6AUHGwWIlg6vqc5EKFu1ZVMf17qbXBuCeeO9/chABRFiH8OGU0JU6xjqH8s8krI3vwDmv2RG87K4W8WlBlB3deSPNmD4zs/ovlYl14AolOgv8na536s2EPV/oZqFbP0X1HUrY0m+AudE6YFwnhH59ndcwDOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889609; c=relaxed/simple;
	bh=7+KOLtWdxDUtZ1CQ3x6lfxC535BlvxEty6tcBLQTe1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OS+FgXVu/CLBUcFiJ2Q761uWPBw4UqiosQbfgKKyBJoFu7vBS9SVVw1cNHZBm2p+Gmn7+h5U0ZehJWxh6MIxeDZINKv5wRd7iRIyavucXbOTMe6dLJcDD/32LpzTd6OCknoB96+xm9ySMNz06oIN+ngg2bTmyO9m1WHicO6jpv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=drPvkBCv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 43FC940E016D;
	Fri, 22 Aug 2025 19:06:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iOk5s6cXLZ_y; Fri, 22 Aug 2025 19:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755889601; bh=hfRjNlk0u68Wr3edOyKkn9ygQuK8wGHlaLziaDVLW5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drPvkBCv5Mhawj2dKyZB9NiXitQtBK2/Tm+CDXVl5FZWHBW567FWPhCJQOvGGC/Hx
	 Z8zJbDtVeaV2m6WUDZsShEaHOvRzJIr+QmTa8DXpGI75QVbHvGdH7fUD3BJ1IaIE2m
	 zI/I7mRlnwLowiqKbVxFmPpHiJcnydzwvjP0MYUut199RyxmNNfliPuX0KNbiySmj2
	 ehM31AWlVOfilZ7UsYlUpIXfsbUyAVckWfnfLdYYwr42xSofDMbh/ymmPtU+R9S7gu
	 EysT7xv7ovwEK5JB8Dl/W3dSKcmpPMVGiAytVIji/WYDbg0/CRAi1InI34p4OsG8oF
	 5HzM7ef2IH0cbSTZ/umyBsxtYfxwY7Yl0Si7Km3mmwfvqp/Nln31RP/8M2h9nKB19R
	 TPC9wy8qfzxUOOquVfpRz66B2SNhJoRzpU/Tl06VFmPHzyqaEZk9SzYHYo71Q3Miqs
	 tynxzSt1jloyxe/Ij4e6LS2T7bfSGaep+bsa7uTnO9QIODJsQ4BfGfYSdm6elo0SgG
	 XnYGU5azeaVltTV+sa6/Bc7cR5yQqbThk0G196ZjJXZkTzqN9iwW6BoWlGf/bKJp1c
	 kg5P9hHhhZAlSZLl3iCrndAJhaRzXf2XYba4zUKf5evBMunmcWZ2m8iAsx5SeqALS7
	 rTFDqaIyycSwzReUaWnUfUFg=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7487A40E0163;
	Fri, 22 Aug 2025 19:06:28 +0000 (UTC)
Date: Fri, 22 Aug 2025 21:06:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/x86/intel: Add a script to update the minimum
 ucode revisions
Message-ID: <20250822190622.GIaKi_rpJxdNGsbDlf@fat_crate.local>
References: <20250822004422.2908427-1-sohil.mehta@intel.com>
 <20250822100949.GAaKhB7ZlYxjpfcIit@fat_crate.local>
 <aaed72a9-8dc8-4744-96ae-ac3db9fb4d01@intel.com>
 <20250822182447.GHaKi176wVuSsNMmi4@fat_crate.local>
 <4d5a17d5-f26a-4682-ab7b-5a3b05b5af3a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d5a17d5-f26a-4682-ab7b-5a3b05b5af3a@intel.com>

On Fri, Aug 22, 2025 at 11:31:40AM -0700, Dave Hansen wrote:
> We could definitely put it there. But it's generating a 100%
> Linux-specific header that nobody else can use. So it's really a purely
> Linux thing. Not really a great fit for what is otherwise just a
> microcode repository.

Just to clarify again: I don't care if it is in the kernel as long as there's
a clear policy when those files are updated and also specified that any update
is sanctioned by you guys since doing a public microcode release kinda says
that what you're releasing is verified and tested and the stuff you're
deprecating can be deprecated.

What I don't want to have is some random people running this because they saw
some microcode on github which someone carved out from BIOS and claims now
that this is valid microcode. Or some other funky thing...

And I don't think you want to be in such a situation either.

So as long as it unmistakenly specifies who updates the header, the script can
be anywhere.

I hope I'm making more sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

