Return-Path: <linux-kernel+bounces-720263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE486AFB93B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690B7421D8A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C34B274B32;
	Mon,  7 Jul 2025 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IPgQ3LnP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6f4y0mkQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14705257AF8
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907335; cv=none; b=QTn94w+kLJqXrzijRwn92GGeC0lVZ5hGhB0wb8oWS7LkuxBGa1RUM02O5Y6ZpwUb38NvCog+Fica25APLBxbfb0BRdLwfkRzMhJzW69YpKFP6a+0IqxBe6E2otSAIUUJBkDioYtMCMJi1BlcP8cSMirHVXqZWo3mvH4RIFYk724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907335; c=relaxed/simple;
	bh=5YYQ2di3hMXS5QJHCQax3da8RkBqlCRDcTuJ8Z7oVw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvSUQAkpvmRTLK6MN+bmdV3G8jJyz2NJ2cVt7jUnCIlPCMvFwMn+eriEfcqRjwym48UkvT5W0K5haamRRJzcXpxi9WqYu+LvcyUtI3c8PpGJ8tVGpjX1Wh5h8UGzFWUEXxRk64QfIxL8Vu7FepFYWRT5TFLy7D+x/buUYJZukoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IPgQ3LnP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6f4y0mkQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 7 Jul 2025 18:55:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751907332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5YYQ2di3hMXS5QJHCQax3da8RkBqlCRDcTuJ8Z7oVw4=;
	b=IPgQ3LnPgT+hySskS7j6hx3eyIPgrlQs9RJtNGVFSndbM+eSv/fpoCjS7K5ADHoYHtCn2Y
	JtWUReAAW+SCh4bhCpfX6zaN9yXfn1JUU9BpfRMDV6u4ZmkTVMOX5cIPyHT5eL8Da7BEli
	u/diBrPM2U+OBz7WiiGvlblVfxIUz6de7kHit3Wbx1rNn6yaHA/jtBWTD80QI701XeVFXy
	HjE8dnHzkLcOjeZExUty3lGHzRr6MDVuw3qUqTNBSBx/OYjdpFyVJQVFsDxdKKzEeSI8EC
	poMZMP64EMi+EPAgYKpr+dGtKkmd0WGnTRJOkD94Bw3FSvoDGzjffLgRXqSfpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751907332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5YYQ2di3hMXS5QJHCQax3da8RkBqlCRDcTuJ8Z7oVw4=;
	b=6f4y0mkQ/qzH5pwAeiV98bQID7wNhnMZJm2lnjlkRtaueHfrY2DEL5HrZAa5nCqc69W0Xy
	C8PKVxzQRQ0TTfCg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/44] ASoC: Intel: avs: Include CPUID header at file
 scope
Message-ID: <aGv8AWwHbi5seDxi@lx-t490>
References: <20250612234010.572636-1-darwi@linutronix.de>
 <20250612234010.572636-3-darwi@linutronix.de>
 <20250704113201.GMaGe7sZritvfQT0uz@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704113201.GMaGe7sZritvfQT0uz@fat_crate.local>

On Fri, 04 Jul 2025, Borislav Petkov wrote:
>
> I'm guessing this will get eventually converted to the parsed struct in
> the end?
>
> I guess I'll have to continue reading and see... :)
>

Yup, next iteration of this PQ shall also convert all the CPUID(0x15)
call sites, as they're quite simple :)

