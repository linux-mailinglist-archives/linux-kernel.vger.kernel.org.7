Return-Path: <linux-kernel+bounces-830050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21747B98912
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82B177A87DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBF327CB38;
	Wed, 24 Sep 2025 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YPXdS56D"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B67256C8D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699418; cv=none; b=LhADOHEvmqdBGq8iTAgySJUEbEE6G4n+hA0Hnbyjcb+WUdzv2CXXWk+GOyfCN2uR48nCZPL6uFt5E9bFtJjrs035BUvGrFPdhPBM8wxmup/M8SV4gV/Vn+WAkf/2iWxQrGCFYNc7wSALfQE8s+5yUXv7y7+M5v8oYVMaxVLV7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699418; c=relaxed/simple;
	bh=1yZuDktiq3PORPFF8wxGnRMPck18LfxrymTTZ9lp7Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pr92rtQad9jPhTYAWcCFr45NqgYSFi9bMG7Pi1r1A8HwfjLmfAgiSpxd6SB+57AbBlTV52+o9lKEy9EngrR/x7FC2V96p7owpKu2QjlSt9yDtZTvOA1s21jw6Aqt2o7wjKXzSKNI2sPEdSZ7hDPehILE/IPvm+sgm+QGTq7GwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YPXdS56D; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TnP3T6szWB+U7ET+m0LkHWxUQj4BWLDxua56VpCz2Os=; b=YPXdS56DqtPQEoXFG12HCmvS8N
	S5waBWcYHtiPb1mvPJZdypGrUJCNyqSKhoEC2iowMtmp+OCgkJ90vJ0oC0RDECK7CB8yijyLAHUZi
	d1FcYLv6thr49uQgeSDa1IOusu4F5yQGmH88Wj2IMyVkVCgRkCA3XHsKVZZYY+4Pxxyhfe1DWLQ99
	zWLlKhJdzlOHb4GFpoxWOp42htXjDRIUUyQlZmhpepwlL+1aKXAhAunmvtO43+QUUzGhpsxmXNCjj
	NfiQirBMZrFhHYNPJS1bcxYHt7k3cgzVIeWbMs4jbUEeogcRUl61NnUMGDW74Q5lQ3YpRdnQ4n+8K
	cdt79l6g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1K3X-00000008i5w-1zrU;
	Wed, 24 Sep 2025 07:36:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9E26830033D; Wed, 24 Sep 2025 09:36:49 +0200 (CEST)
Date: Wed, 24 Sep 2025 09:36:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
Message-ID: <20250924073649.GT4067720@noisy.programming.kicks-ass.net>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619145659.1377970-1-alexandre.chartre@oracle.com>


Sorry, but I hadn't seen these patches until Josh replied to them just
now :/

In general I really like the direction this is taking; I agree with Josh
on the +0 thing, in general foo and foo+0 are not the same. Where foo
can be the entire function, foo+0 is always the first instruction.

Furthermore I have some nits about the output, but I don't think we
should hold up merging these patches for that; it could just be me
needing to rewire my brain or something ;-)

> Example 1 (--trace option): Trace the validation of the os_save() function
> --------------------------------------------------------------------------
> 
> $ ./tools/objtool/objtool --hacks=jump_label --hacks=noinstr --hacks=skylake --ibt --orc --retpoline --rethunk --sls --static-call --uaccess --prefix=16 --link --trace os_xsave -v vmlinux.o
> os_xsave: validation begin
>  65c20: os_xsave+0x0  push %r12				- state: cfa=rsp+16 r12=(cfa-16) stack_size=16 
>  65c22: os_xsave+0x2  mov 0x0(%rip),%eax # alternatives_patched 
>  65c28: os_xsave+0x8  push %rbp 			- state: cfa=rsp+24 rbp=(cfa-24) stack_size=24 
>  65c29: os_xsave+0x9  mov %rdi,%rbp 
>  65c2c: os_xsave+0xc  push %rbx 			- state: cfa=rsp+32 rbx=(cfa-32) stack_size=32 
>  65c2d: os_xsave+0xd  mov 0x8(%rdi),%rbx 
>  65c31: os_xsave+0x11 mov %rbx,%r12 
>  65c34: os_xsave+0x14 shr $0x20,%r12 
>  65c38: os_xsave+0x18 test %eax,%eax 
>  65c3a: os_xsave+0x1a je 65c6a <os_xsave+0x4a> 		- jump taken
>  65c6a: os_xsave+0x4a | ud2 
>  65c6c: os_xsave+0x4c | jmp 65c3c <os_xsave+0x1c> 	- unconditional jump
>  65c3c: os_xsave+0x1c | xor %edx,%edx 
>  65c3e: os_xsave+0x1e | mov %rbx,%rsi 
>  65c41: os_xsave+0x21 | mov %rbp,%rdi 
>  65c44: os_xsave+0x24 | callq xfd_validate_state 	- call
>  65c49: os_xsave+0x29 | mov %ebx,%eax 
>  65c4b: os_xsave+0x2b | mov %r12d,%edx 
>  65c4e: os_xsave+0x2e | <alternative.65c4e> alt 1/4 begin
>  65c55: os_xsave+0x35 | | test %ebx,%ebx 
>  65c57: os_xsave+0x37 | | jne 65c6e <os_xsave+0x4e> 	- jump taken
>  65c6e: os_xsave+0x4e | | | ud2 
>  65c70: os_xsave+0x50 | | | pop %rbx 			- state: cfa=rsp+24 rbx=<undef> stack_size=24 
>  65c71: os_xsave+0x51 | | | pop %rbp 			- state: cfa=rsp+16 rbp=<undef> stack_size=16 
>  65c72: os_xsave+0x52 | | | pop %r12 			- state: cfa=rsp+8 r12=<undef> stack_size=8 
>  65c74: os_xsave+0x54 | | | xor %eax,%eax 
>  65c76: os_xsave+0x56 | | | xor %edx,%edx 
>  65c78: os_xsave+0x58 | | | xor %esi,%esi 
>  65c7a: os_xsave+0x5a | | | xor %edi,%edi 
>  65c7c: os_xsave+0x5c | | | jmpq __x86_return_thunk 	- return
>  65c57: os_xsave+0x37 | | jne 65c6e <os_xsave+0x4e> 	- jump not taken
>  65c59: os_xsave+0x39 | | pop %rbx 			- state: cfa=rsp+24 rbx=<undef> stack_size=24 
>  65c5a: os_xsave+0x3a | | pop %rbp 			- state: cfa=rsp+16 rbp=<undef> stack_size=16 
>  65c5b: os_xsave+0x3b | | pop %r12 			- state: cfa=rsp+8 r12=<undef> stack_size=8 
>  65c5d: os_xsave+0x3d | | xor %eax,%eax 
>  65c5f: os_xsave+0x3f | | xor %edx,%edx 
>  65c61: os_xsave+0x41 | | xor %esi,%esi 
>  65c63: os_xsave+0x43 | | xor %edi,%edi 
>  65c65: os_xsave+0x45 | | jmpq __x86_return_thunk - return

>                       | <alternative.65c4e> alt 1/4 end
>  65c4e: os_xsave+0x2e | <alternative.65c4e> alt 2/4 begin
>  1c3d: .altinstr_replacement+0x1c3d | | xsaves64 0x40(%rbp) 
>  65c53: os_xsave+0x33 | | xor %ebx,%ebx 
>  65c55: os_xsave+0x35 | | test %ebx,%ebx - already visited
>                       | <alternative.65c4e> alt 2/4 end
>  65c4e: os_xsave+0x2e | <alternative.65c4e> alt 3/4 begin
>  1c38: .altinstr_replacement+0x1c38 | | xsavec64 0x40(%rbp) 
>  65c53: os_xsave+0x33 | | xor %ebx,%ebx - already visited
>                       | <alternative.65c4e> alt 3/4 end
>  65c4e: os_xsave+0x2e | <alternative.65c4e> alt 4/4 begin
>  1c33: .altinstr_replacement+0x1c33 | | xsaveopt64 0x40(%rbp) 
>  65c53: os_xsave+0x33 | | xor %ebx,%ebx - already visited
>                       | <alternative.65c4e> alt 4/4 end
>  65c4e: os_xsave+0x2e | <alternative.65c4e> alt default
>  65c4e: os_xsave+0x2e | xsave64 0x40(%rbp) 
>  65c53: os_xsave+0x33 | xor %ebx,%ebx - already visited

I find it *very* hard to read these alternatives. If at all possible, I
think something like:

   65c4e: os_xsave+0x2e | xsave64	| xsaveopt64	| xsavec64	| xsaves64
   65c53: os_xsave+0x33 | xor %ebx,%ebx

Would be *much* easier to follow

>  65c3a: os_xsave+0x1a je 65c6a <os_xsave+0x4a> - jump not taken
>  65c3c: os_xsave+0x1c xor %edx,%edx - already visited
> os_xsave: validation end
> 
> 
> Example 2 (--disas option): Disassemble perf_get_x86_pmu_capability()
> ---------------------------------------------------------------------
> 
> $ ./tools/objtool/objtool --disas=perf_get_x86_pmu_capability --link vmlinux.o
> perf_get_x86_pmu_capability:
>   d000:  perf_get_x86_pmu_capability         endbr64                                                   
>   d004:  perf_get_x86_pmu_capability+0x4     callq  __fentry__                                         
>   d009:  perf_get_x86_pmu_capability+0x9     mov    %rdi,%rdx                                          
>                                              <alternative.d00c> default - begin
>   d00c:  perf_get_x86_pmu_capability+0xc     | jmpq   .altinstr_aux+0x90                               

(you probably need to relocate the target -- we never jump into alinstr)

>                                              <alternative.d00c> default - end
>                                              <alternative.d00c> 1/2 - begin
>                                              | <fake nop> (5 bytes)                                    
>                                              <alternative.d00c> 1/2 end
>                                              <alternative.d00c> 2/2 - begin
>    5e5:  .altinstr_replacement+0x5e5         | jmpq   perf_get_x86_pmu_capability+0x3f                 
>                                              <alternative.d00c> 2/2 end

Idem; the above is *really* hard to decipher.

  d00c:  perf_get_x86_pmu_capability+0xc | jmpq   .altinstr_aux+0x90 | nop5 | jmpq   perf_get_x86_pmu_capability+0x3f

>   d011:  perf_get_x86_pmu_capability+0x11    ud2                                                       
>   d013:  perf_get_x86_pmu_capability+0x13    movq   $0x0,(%rdx)                                        
>   d01a:  perf_get_x86_pmu_capability+0x1a    movq   $0x0,0x8(%rdx)                                     
>   d022:  perf_get_x86_pmu_capability+0x22    movq   $0x0,0x10(%rdx)                                    
>   d02a:  perf_get_x86_pmu_capability+0x2a    movq   $0x0,0x18(%rdx)                                    
>   d032:  perf_get_x86_pmu_capability+0x32    xor    %eax,%eax                                          
>   d034:  perf_get_x86_pmu_capability+0x34    xor    %edx,%edx                                          
>   d036:  perf_get_x86_pmu_capability+0x36    xor    %ecx,%ecx                                          
>   d038:  perf_get_x86_pmu_capability+0x38    xor    %edi,%edi                                          
>   d03a:  perf_get_x86_pmu_capability+0x3a    jmpq   __x86_return_thunk                                 
>   d03f:  perf_get_x86_pmu_capability+0x3f    cmpq   $0x0,0x0(%rip)        # x86_pmu+0x10               
>   d047:  perf_get_x86_pmu_capability+0x47    je     d013 <perf_get_x86_pmu_capability+0x13>            
>   d049:  perf_get_x86_pmu_capability+0x49    mov    0x0(%rip),%eax        # x86_pmu+0x8                
>   d04f:  perf_get_x86_pmu_capability+0x4f    mov    %eax,(%rdi)                                        
>                                              <jump alternative.d051> default
>   d051:  perf_get_x86_pmu_capability+0x51    | xchg   %ax,%ax                                          
>                                              <jump alternative.d051> else
>   d051:  perf_get_x86_pmu_capability+0x51    | jmp    d053 <perf_get_x86_pmu_capability+0x53>
>                                              <jump alternative.d051> end

this is a jump_label; if we would retain the whole 'key' reloc, and
not only the key_addend, you could make it something like:

  d051:  perf_get_x86_pmu_capability+0x51      [ jmp.d8 d053 <perf_get_x86_pmu_capability+0x53> ] * perf_is_hybrid

(also, this here reads like it is either nop2 or jmp.d8 +0, which is
'weird')


>   d053:  perf_get_x86_pmu_capability+0x53    mov    0x0(%rip),%rdi        # x86_pmu+0xd8               
>                                              <alternative.d05a> default - begin
>   d05a:  perf_get_x86_pmu_capability+0x5a    | callq  __sw_hweight64                                   
>                                              <alternative.d05a> default - end
>                                              <alternative.d05a> 1/1 - begin
>    5ea:  .altinstr_replacement+0x5ea         | popcnt %rdi,%rax                                        
>                                              <alternative.d05a> 1/1 end

  d05a:  perf_get_x86_pmu_capability+0x5a      | callq  __sw_hweight64 | popcnt %rdi,%rax


>   d05f:  perf_get_x86_pmu_capability+0x5f    mov    %eax,0x4(%rdx)                                     

>                                              <jump alternative.d062> default
>   d062:  perf_get_x86_pmu_capability+0x62    | xchg   %ax,%ax                                          
>                                              <jump alternative.d062> else
>   d062:  perf_get_x86_pmu_capability+0x62    | jmp    d064 <perf_get_x86_pmu_capability+0x64>
>                                              <jump alternative.d062> end

Same jump_label again, with the same problem, the target seems 'wrong'

>   d064:  perf_get_x86_pmu_capability+0x64    mov    0x0(%rip),%rdi        # x86_pmu+0xe0               
>                                              <alternative.d06b> default - begin
>   d06b:  perf_get_x86_pmu_capability+0x6b    | callq  __sw_hweight64                                   
>                                              <alternative.d06b> default - end
>                                              <alternative.d06b> 1/1 - begin
>    5ef:  .altinstr_replacement+0x5ef         | popcnt %rdi,%rax                                        
>                                              <alternative.d06b> 1/1 end
>   d070:  perf_get_x86_pmu_capability+0x70    mov    %eax,0x8(%rdx)                                     
>   d073:  perf_get_x86_pmu_capability+0x73    mov    0x0(%rip),%eax        # x86_pmu+0xf8               
>   d079:  perf_get_x86_pmu_capability+0x79    mov    %eax,0xc(%rdx)                                     
>   d07c:  perf_get_x86_pmu_capability+0x7c    mov    %eax,0x10(%rdx)                                    
>   d07f:  perf_get_x86_pmu_capability+0x7f    mov    0x0(%rip),%rax        # x86_pmu+0x108              
>   d086:  perf_get_x86_pmu_capability+0x86    mov    %eax,0x14(%rdx)                                    
>   d089:  perf_get_x86_pmu_capability+0x89    mov    0x0(%rip),%eax        # x86_pmu+0x110              
>   d08f:  perf_get_x86_pmu_capability+0x8f    mov    %eax,0x18(%rdx)                                    
>   d092:  perf_get_x86_pmu_capability+0x92    movzbl 0x0(%rip),%ecx        # x86_pmu+0x1d1              
>   d099:  perf_get_x86_pmu_capability+0x99    movzbl 0x1c(%rdx),%eax                                    
>   d09d:  perf_get_x86_pmu_capability+0x9d    shr    %cl                                                
>   d09f:  perf_get_x86_pmu_capability+0x9f    and    $0x1,%ecx                                          
>   d0a2:  perf_get_x86_pmu_capability+0xa2    and    $0xfffffffe,%eax                                   
>   d0a5:  perf_get_x86_pmu_capability+0xa5    or     %ecx,%eax                                          
>   d0a7:  perf_get_x86_pmu_capability+0xa7    mov    %al,0x1c(%rdx)                                     
>   d0aa:  perf_get_x86_pmu_capability+0xaa    xor    %eax,%eax                                          
>   d0ac:  perf_get_x86_pmu_capability+0xac    xor    %edx,%edx                                          
>   d0ae:  perf_get_x86_pmu_capability+0xae    xor    %ecx,%ecx                                          
>   d0b0:  perf_get_x86_pmu_capability+0xb0    xor    %edi,%edi                                          
>   d0b2:  perf_get_x86_pmu_capability+0xb2    jmpq   __x86_return_thunk                                 

