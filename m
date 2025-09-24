Return-Path: <linux-kernel+bounces-830059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FA8B9895D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59C41B20CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708A227BF80;
	Wed, 24 Sep 2025 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jD0lJKK+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99B27FB31
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699731; cv=none; b=H3HdwRoW8haNAwt64JuS0agL8KKJYB4g+PJePtqS/iekdkpAy+AksQCqCGZMjJmoQ5UsGzcglx+xbWD2Dgzo2ravnIyRAEcLMitZmwfEYHMPnXds2PWiSnr72cj7HxOIjXr7tYv8TNJ/jlxt9aV0s071lGHIexTHpaIhKx+CGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699731; c=relaxed/simple;
	bh=W4c1hIWAXEsutebUPXVLyK3x1jxvdJ0k+FyBEcIkX8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/6lCjUsj5A+TXrbnocRbJiMWF2A0QBO2hvz0xnNX8069Hnl+PQ/rU8p/itLQswHfKxIJbNydLsIkboT18Zjb71HByqf7uOgTbzZRMrK4Vx6FBrZ5KKPV+g4WUwif/n6zf0hZk/BP8g2BQ2RkysAoEacIqV/6t3NPnlocYMK97k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jD0lJKK+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oytDn5rsVbbUrvxkkq7U7WmaGRSvw7EafQQ0AHTHvJ4=; b=jD0lJKK+ENt1ozlXGOMLQsTx7W
	pyjo7FJd0lRujIEwT+MIzG7+ZufPNzgCe9238ZvcmqIIl8k4coUqzdLWkcxRsNzbDt9Nh5v/IIseM
	ZEaKr06JgtEcTf2itiazYNZarncpy7nYutWJHbpLc0cLDH8cefs6f1mg/cMUd/8/W6Vm6lY1xSzYn
	eKlIzPUlPQKQqkHNMQ+EaD6qQ3JJYdL7PukTWGixExtO59SVUrK94o6kkhJGwwSZvv4ZNYMuBekkV
	QbJnOPBpi550Xy3iq32CZyaU+LybLags/SdpQ6oExqp2zpf3sNon0u0roF4hw+u5qArXIfhqURhom
	pqHe2ncQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1K8d-00000008i7A-0iu0;
	Wed, 24 Sep 2025 07:42:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BA8F030033D; Wed, 24 Sep 2025 09:42:06 +0200 (CEST)
Date: Wed, 24 Sep 2025 09:42:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
Message-ID: <20250924074206.GW4068168@noisy.programming.kicks-ass.net>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250924073649.GT4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924073649.GT4067720@noisy.programming.kicks-ass.net>

On Wed, Sep 24, 2025 at 09:36:49AM +0200, Peter Zijlstra wrote:
> > Example 2 (--disas option): Disassemble perf_get_x86_pmu_capability()
> > ---------------------------------------------------------------------
> > 
> > $ ./tools/objtool/objtool --disas=perf_get_x86_pmu_capability --link vmlinux.o
> > perf_get_x86_pmu_capability:
> >   d000:  perf_get_x86_pmu_capability         endbr64                                                   
> >   d004:  perf_get_x86_pmu_capability+0x4     callq  __fentry__                                         
> >   d009:  perf_get_x86_pmu_capability+0x9     mov    %rdi,%rdx                                          
> >                                              <alternative.d00c> default - begin
> >   d00c:  perf_get_x86_pmu_capability+0xc     | jmpq   .altinstr_aux+0x90                               
> 
> (you probably need to relocate the target -- we never jump into alinstr)
> 
> >                                              <alternative.d00c> default - end
> >                                              <alternative.d00c> 1/2 - begin
> >                                              | <fake nop> (5 bytes)                                    
> >                                              <alternative.d00c> 1/2 end
> >                                              <alternative.d00c> 2/2 - begin
> >    5e5:  .altinstr_replacement+0x5e5         | jmpq   perf_get_x86_pmu_capability+0x3f                 
> >                                              <alternative.d00c> 2/2 end
> 
> Idem; the above is *really* hard to decipher.
> 
>   d00c:  perf_get_x86_pmu_capability+0xc | jmpq   .altinstr_aux+0x90 | nop5 | jmpq   perf_get_x86_pmu_capability+0x3f
> 
> >   d011:  perf_get_x86_pmu_capability+0x11    ud2                                                       
> >   d013:  perf_get_x86_pmu_capability+0x13    movq   $0x0,(%rdx)                                        
> >   d01a:  perf_get_x86_pmu_capability+0x1a    movq   $0x0,0x8(%rdx)                                     
> >   d022:  perf_get_x86_pmu_capability+0x22    movq   $0x0,0x10(%rdx)                                    
> >   d02a:  perf_get_x86_pmu_capability+0x2a    movq   $0x0,0x18(%rdx)                                    
> >   d032:  perf_get_x86_pmu_capability+0x32    xor    %eax,%eax                                          
> >   d034:  perf_get_x86_pmu_capability+0x34    xor    %edx,%edx                                          
> >   d036:  perf_get_x86_pmu_capability+0x36    xor    %ecx,%ecx                                          
> >   d038:  perf_get_x86_pmu_capability+0x38    xor    %edi,%edi                                          
> >   d03a:  perf_get_x86_pmu_capability+0x3a    jmpq   __x86_return_thunk                                 
> >   d03f:  perf_get_x86_pmu_capability+0x3f    cmpq   $0x0,0x0(%rip)        # x86_pmu+0x10               
> >   d047:  perf_get_x86_pmu_capability+0x47    je     d013 <perf_get_x86_pmu_capability+0x13>            
> >   d049:  perf_get_x86_pmu_capability+0x49    mov    0x0(%rip),%eax        # x86_pmu+0x8                
> >   d04f:  perf_get_x86_pmu_capability+0x4f    mov    %eax,(%rdi)                                        
> >                                              <jump alternative.d051> default
> >   d051:  perf_get_x86_pmu_capability+0x51    | xchg   %ax,%ax                                          
> >                                              <jump alternative.d051> else
> >   d051:  perf_get_x86_pmu_capability+0x51    | jmp    d053 <perf_get_x86_pmu_capability+0x53>
> >                                              <jump alternative.d051> end
> 
> this is a jump_label; if we would retain the whole 'key' reloc, and
> not only the key_addend, you could make it something like:
> 
>   d051:  perf_get_x86_pmu_capability+0x51      [ jmp.d8 d053 <perf_get_x86_pmu_capability+0x53> ] * perf_is_hybrid
> 
> (also, this here reads like it is either nop2 or jmp.d8 +0, which is
> 'weird')

Also, particularly in alternatives I think it makes sense to make
explicit distinction between jmp.d8 and jmp.d32 (and similar for Jcc.d8
/ Jcc.d32).



