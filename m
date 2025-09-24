Return-Path: <linux-kernel+bounces-830429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0543B99A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14293230CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1AF2FE574;
	Wed, 24 Sep 2025 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jr6HV3wd"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F26275B05
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714380; cv=none; b=pLZHgE55zN21tkq+RdWf6dB+gWNeNZUtLtgWF4hNNPXncyI2akF3rPVX0a3vr8wPEEK7DM/irCULL95PabNwMK3MrqS47KwmhQ3EeV+HOwXQLs8nkH0d3/jBq7hJlLmKoY+wiwMx6XTIirsUgEgwLgdDHTmS0vlrY9CVURiuj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714380; c=relaxed/simple;
	bh=k+rntJ45THdy4+Hm2PhTOYe6rdufjRsUeUq2ZhXNTZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdHWCc4fnb8s1QEaDAQYoMssK6LZR1WZx3fGHjCPNzhQe7Ao9VkSkZJQyQo6wUJ/2pJpaZ6TaWfgdlaj9856/C7qaWTGdkIXHyoheOYX5PGpH4a/t76xpRKu1KgTfLluMbWUmE0aPs8VBhBV8Uuvq8figJonrVOWgjIqhY2d3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jr6HV3wd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=afT9zG0tjew1yBiop88VK3D4fEabRMn/OKiuwP/ihzY=; b=Jr6HV3wda7HTyJWhrIm/8OiPK1
	9YLKf46YmjTtbDtun17SM6oJpPVHKcWgxHl5/sYBViJXCx++W3zrtJOzJTlpoCtUtkudCopZ2JLIN
	M6XnmiI1/vKakf95jfriQpefco+cFhJKmaxHL7j2bmHobXNFSTkuvSDZaIjHC1BbiP1My3RE3Wvny
	xz7U4hN+CHvRFK8G0UP9L0Xtr1PT163RTU/nwHnPnwpXtuuV8tyLBZXtX48B0Fjh1V+nePXQ13jnl
	OBdmktK1c4G077XXopxgxygyapFe+xSS+WDhhwfeXDVM5tc/K8mBhYJli1dMQRBZwihiI4SwunI2t
	QtGr7WvA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1NwQ-00000008jBa-0CPV;
	Wed, 24 Sep 2025 11:45:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2302D30043D; Wed, 24 Sep 2025 13:45:45 +0200 (CEST)
Date: Wed, 24 Sep 2025 13:45:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
Message-ID: <20250924114545.GI1386988@noisy.programming.kicks-ass.net>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250924073649.GT4067720@noisy.programming.kicks-ass.net>
 <20250924074206.GW4068168@noisy.programming.kicks-ass.net>
 <20250924100847.GY4068168@noisy.programming.kicks-ass.net>
 <20250924101038.GZ4068168@noisy.programming.kicks-ass.net>
 <90abf24a-326a-4215-8e13-2e1a2e3194ea@oracle.com>
 <20250924105813.GI3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924105813.GI3419281@noisy.programming.kicks-ass.net>

On Wed, Sep 24, 2025 at 12:58:13PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 24, 2025 at 12:52:35PM +0200, Alexandre Chartre wrote:
> > 
> > On 9/24/25 12:10, Peter Zijlstra wrote:
> > > On Wed, Sep 24, 2025 at 12:08:47PM +0200, Peter Zijlstra wrote:
> > > > On Wed, Sep 24, 2025 at 09:42:06AM +0200, Peter Zijlstra wrote:
> > > > 
> > > > > > >    d051:  perf_get_x86_pmu_capability+0x51    | xchg   %ax,%ax
> > > > 
> > > > That libopcode is 'funny', isn't that typically spelled "nop" ?
> > > 
> > > Ooh, I see, it is "osp nop" and yeah binutils also seems to do that as
> > > "xchg %ax,%ax".
> > 
> > Yes, "xchg %ax,%ax" is NOP2 (opcodes: 0x66 0x90), "nop" is NOP1 (0x90).
> > 
> > That's one more improvement we can do: identify NOP instructions and
> > display them as NOP<n>
> 
> Right, I have just the function for that. Let me do a patch for you.

Bah, I'm having trouble with the makefiles, but we sorta already detect
nops, and the below should sorta work. I'll improve decode.c a bit.

--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -273,6 +273,9 @@ static size_t disas_insn(struct disas_co
 	dctx->insn = insn;
 	dctx->result[0] = '\0';
 
+	if (insn->type == INSN_NOP)
+		return snprintf(dctx->result, DISAS_RESULT_SIZE, "NOP%d", insn->len);
+
 	/*
 	 * Set the disassembler buffer to read data from the section
 	 * containing the instruction to disassemble.

