Return-Path: <linux-kernel+bounces-872475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE67CC114B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CA2C4FEE9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2A8304BDD;
	Mon, 27 Oct 2025 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YCWrZn+X"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92024175BF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595035; cv=none; b=K8tAwNbBPa8ODgDfWb5aLI57YaaRv76h86SeQWyzkLVuJfwRrSxfATDbljsvEOJ7uciJ7P0rg1kb+NWZTpPs29LeHvbHkMGtLeFVBsOseHvTupdO53KJffOAO9DOQLHkVK86HPTTavh87q2slgB4vfJHjJwOi7WBLVyQ1WJ7zNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595035; c=relaxed/simple;
	bh=qAPZZex0lVUhqdgvO2+gS+2GyG7nqZeqDTQDdU5S9vo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Fr3Xtk/feu4i97T8DrBLYqOo9U0+2/hgqd0gLCBcrvqG2URPnRGpIxIOwyf2j5s3NbubsrZt4BIUnxtf5stFgkMqVm75XKFIQsO8YsnO2N0xlPv/61gVxf8kiIp5bWwTYN38JR1qoXIfrZLKJYwEvLatYhL0AnorZ+H/b4LvWxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YCWrZn+X; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761595028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3Azl3a9SNX0GoOWOneAU2iKMSfUOpvleOE0L4lf+CU=;
	b=YCWrZn+X5Jo3XCCmcY/VjxSa2nEnbNv831sE8IWd23Aao0H4O9vaHhBUcbhaaF6xvhOB6j
	0XNOSL7SbImfCucK00i3RR9jYegS8K8pcwRwwsZXmVHpzl9YIBq8QE1MvhiazltPKpz2sh
	Pgr/pf7cSk5S9ejJxt1179vzFKb5/uw=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] x86/smpboot: Mark native_play_dead() as __noreturn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <i4o6cr4x364xsk7ftas5guggjt4xdvawurrohveahi75iba5aj@dl6plusoxtin>
Date: Mon, 27 Oct 2025 20:56:18 +0100
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>,
 Kai Huang <kai.huang@intel.com>,
 Brian Gerst <brgerst@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 Zheyun Shen <szy0127@sjtu.edu.cn>,
 Kevin Loughlin <kevinloughlin@google.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Li Chen <chenl311@chinatelecom.cn>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EA25BB49-DCF0-4868-878D-8BC5217380A1@linux.dev>
References: <20251027155107.183136-1-thorsten.blum@linux.dev>
 <i4o6cr4x364xsk7ftas5guggjt4xdvawurrohveahi75iba5aj@dl6plusoxtin>
To: Josh Poimboeuf <jpoimboe@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 27. Oct 2025, at 20:28, Josh Poimboeuf wrote:
> On Mon, Oct 27, 2025 at 04:51:02PM +0100, Thorsten Blum wrote:
>> native_play_dead() ends by calling the non-returning function
>> hlt_play_dead() and therefore also never returns.
>> 
>> The !CONFIG_HOTPLUG_CPU stub version of native_play_dead()
>> unconditionally calls BUG() and does not return either.
>> 
>> Add the __noreturn attribute to both function definitions and their
>> declaration to document this behavior and to potentially improve
>> compiler optimizations.
>> 
>> Remove the obsolete comment, and add native_play_dead() to the objtool's
>> list of __noreturn functions.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Is there an objtool warning that this fixes?  If so, it would be helpful
> to put it in the description above.

Not that I'm aware of.


