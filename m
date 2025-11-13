Return-Path: <linux-kernel+bounces-899893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95789C59212
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 807E54F7C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9488736A01E;
	Thu, 13 Nov 2025 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FynncWvI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E87364E8B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052600; cv=none; b=GDI2DkQ84SPddaypiZzVcC0V1HpJnLaOb5txFXK9+peXsf428Ryn6qnoUfZn12zfXvroG9Ri7fx2gErvP2PLkblknRCrYAtsHTZdbufitf5uxgmLT0QW+zpxbPJ4GsecK0ClDm7MDNm70IDLkuab83VSDHWbPfjUelOhbdL/++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052600; c=relaxed/simple;
	bh=Qbh/LEkaIRO1M0YT3Fuz978l9W3huznQ02vvop8OjnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWGRyQTonI+SzRIwC68qKuJhHX2iPQ378/yZAUnCpaM8s4gOdMjKZi0zRIG2c4TcfWvbdlXce52sj9H4I1CB7ZGevxk8UvzeGnAyTiHdI69i1YrBKodGYB5jHsOmH9HzWBab6xK00h/8s0wOA14p+XFs8c0np3yNyGInFhdCK+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FynncWvI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9wJJ012337;
	Thu, 13 Nov 2025 16:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Mx46ygQebWI05Q/CsBz+ozBk369p/
	8G4nKm9IBzXV0Q=; b=FynncWvIH7zxa/Uw+JrqDzvA6HYHOOgCRfC55Z57/qDA/
	MxSrq6TYah7leTDWFziJKQApLD8xxQ9ZoJbdE8NDJ9ZaM4PUKUZnyqAwex2XgrFg
	YcQpOgyRcWtlvglBOJndcOU3HJNXSTCKOpPWzv8+vW0DErGt+QoMaTVMWoBNuxrD
	Kj/QbjYwLqsHoYy1u6F2tUrVWNW6ZtmzgYHDePOFptl5Z8Yu2Jk+Ohk4nBhuNqKP
	PSf2Ob+8/YFIRJV20q/03Gw8kzj2JGIAcIweFR3Q3w0URw82KusMw02AJycv4VND
	8wHzLBMSqXQgG2gBnoWgD5zD+9RqVmxYAzyvjvrjg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acybqt8jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGGeLb039056;
	Thu, 13 Nov 2025 16:49:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc39b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:20 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnK9j008288;
	Thu, 13 Nov 2025 16:49:20 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-1;
	Thu, 13 Nov 2025 16:49:19 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 00/28] objtool: Function validation tracing
Date: Thu, 13 Nov 2025 17:48:49 +0100
Message-ID: <20251113164917.2563486-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130130
X-Proofpoint-GUID: XkRFXUhw8vq8Y_HCtUYLZjZP_z_C9Yi7
X-Proofpoint-ORIG-GUID: XkRFXUhw8vq8Y_HCtUYLZjZP_z_C9Yi7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0NyBTYWx0ZWRfX38BpSG/khoKk
 unWOQxSHgC8XympF320n8lnh4lB0nA8SRQBnvlTnRn0AlxZ17WwvEOBY1orv0KnY26WVfRD4Gj1
 y0IDmG2/hgeg3EyEQxS1/XuGYaIIygKkQ+0SiDh/ABaufYg6XN14BBem34+E7Rx/xN0Ec7ap1gH
 K9+1GzASbUwozboHyZAM2KAjxYfKotrKvBL6yapU5gd/EADn6g1C7A4dXSwWoYgZT/A1FNgXSEK
 +mfX2vO0XmsKY7baRFY2TthzIlstK12J1mCz2nucBIDJsrsvRERAyObk0pe0ULqGp5HHgNMhITA
 fx29DQ9gywD2XarOESLNUUNWD5FjKiWhe9IKU19rGts7PZB3qG1puopZiN3Gg5/zcwL7r6uo2Or
 DbVzSpm3pASKnb9nFqVwit6zViV6jQ==
X-Authority-Analysis: v=2.4 cv=X7hf6WTe c=1 sm=1 tr=0 ts=69160c11 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=ggy87TB_Exx-uAISIAsA:9
 a=HhbK4dLum7pmb74im6QT:22

Hi,

These patches change objtool to disassemble code with libopcodes instead
of running objdump. You will find below:

- Changes: list of changes made in this version
- Overview: overview of the changes
- Notes: description of some particular behavior
- Examples: output examples

Thanks,

alex.

-----

Changes:
========

V4:
---
This version fixes a build issue when disassembly is not available. Compared
with V3, this is addresses by changes in patch 14 (objtool: Improve tracing
of alternative instructions). Other patches are similar to V3.

V3:
---
This version addresses comments from Josh and Peter, in particular:

- Josh: replace ERROR in disas_context_create with WARN
- Josh: do not change offstr() outside the disassembler
- Josh: duplicated "falls through to next function" warning
- Josh: validate_symbol() has extra newline before return
- Josh: "make -s" should be completely silent
- Josh: instructions with unwinding state changes are printing twice
- Josh: explain TRACE_INSN(insn, NULL): this prints an instruction with no
  	additional message.

- Peter: display alternative on a single line
- Peter: display nop-like instruction as NOP<n>
- Peter: in alternative show differences between jmp.d8 and jmp.d32 (jmp/jmpq is used now)
- Peter: show alternative feature name and flags
- Peter: alternative jumps to altinstr_aux - see NOTE below:
         Disassembly can show default alternative jumping to .altinstr_aux
- Peter: some jump label target seems wrong (jmp +0) - NOTE below:
         Disassembly can show alternative jumping to the next instruction

Other improvements:

- An alternatives is displayed on single line if each alternative has a
  single instruction. Otherwise alternatives are dispayed side-by-side,
  with one column for each lternative.

- Each alternative of a group alternative is displayed with its feature
  name and flags: <flags><feature-name>

  <flags> is made of the following characters:

    '!' : ALT_FLAG_NOT
    '+' : ALT_FLAG_DIRECT_CALL
    '?' : unknown flag (i.e. any other flags)

- If an alternative is a jump table then "JUMP" is used as the feature
  name.

- If an alternative is an exception table then "EXCEPTION" is used as the
  feature name.

- Print the destination name of pv_ops calls  when we can figure out if
  XENPV mode is used or not. If the PV mode can't be predicted then print
  the default pv_ops destination as a destination example.

- If a group alternative is a direct call then print the corresponding
  pv_ops call.

Examples are shown below.


Overview:
=========

This provides the following changes to objtool.

- Disassemble code with libopcodes instead of running objdump

  objtool executes the objdump command to disassemble code. In particular,
  if objtool fails to validate a function then it will use objdump to
  disassemble the entire file which is not very helpful when processing
  a large file (like vmlinux.o).

  Using libopcodes provides more control about the disassembly scope and
  output, and it is possible to disassemble a single instruction or
  a single function. Now when objtool fails to validate a function it
  will disassemble that single function instead of disassembling the
  entire file.

- Add the --trace <function> option to trace function validation

  Figuring out why a function validation has failed can be difficult because
  objtool checks all code flows (including alternatives) and maintains
  instructions states (in particular call frame information).

  The trace option allows to follow the function validation done by objtool
  instruction per instruction, see what objtool is doing and get function
  validation information. An output example is shown below.

- Add the --disas <function> option to disassemble functions

  Disassembly is done using libopcodes and it will show the different code
  alternatives.

Note: some changes are architecture specific (x86, powerpc, loongarch). Any
feedback about the behavior on powerpc and loongarch is welcome.


Notes:
======

Disassembly can show default alternative jumping to .altinstr_aux
-----------------------------------------------------------------
Disassembly can show a default alternative jumping to .altinstr_aux. This
happens when the _static_cpu_has() function is used. Its default code
jumps to .altinstr_aux where a test sequence is executed (test; jnz; jmp).

At runtime, this sequence is not used because the _static_cpu_has() 
an alternative with the X86_FEATURE_ALWAYS feature. 


  debc:  perf_get_x86_pmu_capability+0xc      jmpq   0xdec1 <.altinstr_aux+0xfc> | NOP5  (X86_FEATURE_HYBRID_CPU) | jmpq   0x61a <perf_get_x86_pmu_capability+0x37>  (X86_FEATURE_ALWAYS)   # <alternative.debc>
  dec1:  perf_get_x86_pmu_capability+0x11     ud2                                                       


Disassembly can show alternative jumping to the next instruction
----------------------------------------------------------------

The disassembly can show jump tables with an alternative which jumps
to the next instruction.

For example:

def9:  perf_get_x86_pmu_capability+0x49    NOP2 | jmp    defb <perf_get_x86_pmu_capability+0x4b>  (JUMP)   # <alternative.def9>
defb:  perf_get_x86_pmu_capability+0x4b	   mov    0x0(%rip),%rdi        # 0xdf02 <x86_pmu+0xd8>      

This disassembly is correct. These instructions come from:

        cap->num_counters_gp = x86_pmu_num_counters(NULL)):

which will end up executing this statement:

        if (static_branch_unlikely(&perf_is_hybrid) && NULL)
	        <do something>;

This statement is optimized to do nothing because the condition is
always false. But static_branch_unlikely() is implemented with a jump
table inside an "asm goto" statement, and "asm goto" statements are
not optimized.

So basically the code is optimized like this:

        if (static_branch_unlikely(&perf_is_hybrid))
	        ;

And this translates to the assembly code above.


Examples:
=========

Example 1 (--trace option): Trace the validation of the os_save() function
--------------------------------------------------------------------------

$ ./tools/objtool/objtool --hacks=jump_label --hacks=noinstr --hacks=skylake --ibt --orc --retpoline --rethunk --sls --static-call --uaccess --prefix=16 --link --trace os_xsave -v vmlinux.o
os_xsave: validation begin
 59b20:  os_xsave+0x0                    push   %r12                                       - state: cfa=rsp+16 r12=(cfa-16) stack_size=16 
 59b22:  os_xsave+0x2	     		 mov    0x0(%rip),%eax        # 0x59b28 <alternatives_patched>
 59b28:  os_xsave+0x8	     		 push   %rbp                                       - state: cfa=rsp+24 rbp=(cfa-24) stack_size=24 
 59b29:  os_xsave+0x9	     		 mov    %rdi,%rbp                                          
 59b2c:  os_xsave+0xc	     		 push   %rbx                                       - state: cfa=rsp+32 rbx=(cfa-32) stack_size=32 
 59b2d:  os_xsave+0xd	     		 mov    0x8(%rdi),%rbx                                     
 59b31:  os_xsave+0x11	     		 mov    %rbx,%r12                                          
 59b34:  os_xsave+0x14	     		 shr    $0x20,%r12                                         
 59b38:  os_xsave+0x18	    		 test   %eax,%eax                                          
 59b3a:  os_xsave+0x1a	     		 je     0x59b62 <os_xsave+0x42>                    - jump taken
 59b62:  os_xsave+0x42	   	       | ud2                                                     
 59b64:  os_xsave+0x44	   	       | jmp    0x59b3c <os_xsave+0x1c>                    - unconditional jump
 59b3c:  os_xsave+0x1c	   	       | | xor    %edx,%edx                                      
 59b3e:  os_xsave+0x1e	   	       | | mov    %rbx,%rsi                                      
 59b41:  os_xsave+0x21	   	       | | mov    %rbp,%rdi                                      
 59b44:  os_xsave+0x24	   	       | | callq  0x59b49 <xfd_validate_state>             - call
 59b49:  os_xsave+0x29	   	       | | mov    %ebx,%eax                                      
 59b4b:  os_xsave+0x2b	   	       | | mov    %r12d,%edx                                     
 	 		   	       | | / <alternative.59b4e> EXCEPTION for instruction at 0x59b4e <os_xsave+0x2e>
 59b55:  os_xsave+0x35	   	       | | | test   %ebx,%ebx                                    
 59b57:  os_xsave+0x37	   	       | | | jne    0x59b66 <os_xsave+0x46>                - jump taken
 59b66:  os_xsave+0x46	   	       | | | | ud2                                               
 59b68:  os_xsave+0x48	   	       | | | | pop    %rbx                                 - state: cfa=rsp+24 rbx=<undef> stack_size=24 
 59b69:  os_xsave+0x49	   	       | | | | pop    %rbp                                 - state: cfa=rsp+16 rbp=<undef> stack_size=16 
 59b6a:  os_xsave+0x4a	   	       | | | | pop    %r12                                 - state: cfa=rsp+8 r12=<undef> stack_size=8 
 59b6c:  os_xsave+0x4c	   	       | | | | jmpq   0x59b71 <__x86_return_thunk>         - return
 59b57:  os_xsave+0x37	   	       | | | jne    0x59b66 <os_xsave+0x46>                - jump not taken
 59b59:  os_xsave+0x39	   	       | | | pop    %rbx                                   - state: cfa=rsp+24 rbx=<undef> stack_size=24 
 59b5a:  os_xsave+0x3a	   	       | | | pop    %rbp                                   - state: cfa=rsp+16 rbp=<undef> stack_size=16 
 59b5b:  os_xsave+0x3b	   	       | | | pop    %r12                                   - state: cfa=rsp+8 r12=<undef> stack_size=8 
 59b5d:  os_xsave+0x3d	   	       | | | jmpq   0x59b62 <__x86_return_thunk>           - return
 	 		   	       | | \ <alternative.59b4e> EXCEPTION end
				       | | / <alternative.59b4e> X86_FEATURE_XSAVES
  1b2b:  .altinstr_replacement+0x1b2b  | | | xsaves64 0x40(%rbp)                                 
 59b53:  os_xsave+0x33		       | | | xor    %ebx,%ebx                                    
 59b55:  os_xsave+0x35		       | | | test   %ebx,%ebx                              - already visited
 	 			       | | \ <alternative.59b4e> X86_FEATURE_XSAVES end
				       | | / <alternative.59b4e> X86_FEATURE_XSAVEC
  1b26:  .altinstr_replacement+0x1b26  | | | xsavec64 0x40(%rbp)                                 
 59b53:  os_xsave+0x33		       | | | xor    %ebx,%ebx                              - already visited
 	 			       | | \ <alternative.59b4e> X86_FEATURE_XSAVEC end
				       | | / <alternative.59b4e> X86_FEATURE_XSAVEOPT
  1b21:  .altinstr_replacement+0x1b21  | | | xsaveopt64 0x40(%rbp)                               
 59b53:  os_xsave+0x33		       | | | xor    %ebx,%ebx                              - already visited
 	 			       | | \ <alternative.59b4e> X86_FEATURE_XSAVEOPT end
				       | | / <alternative.59b4e> DEFAULT
 59b4e:  os_xsave+0x2e		       | | xsave64 0x40(%rbp)                                    
 59b53:  os_xsave+0x33		       | | xor    %ebx,%ebx                                - already visited
 59b3a:  os_xsave+0x1a		       je     0x59b62 <os_xsave+0x42>                      - jump not taken
 59b3c:  os_xsave+0x1c		       xor    %edx,%edx                                    - already visited
os_xsave: validation end


Example 2 (--disas option): Single Instruction Alternatives
-----------------------------------------------------------
Alternatives with single instructions are displayed on a single line.
Instructions of the different alternatives are separated with a vertical
bar (|).


$ ./tools/objtool/objtool --disas=perf_get_x86_pmu_capability --link vmlinux.o
perf_get_x86_pmu_capability:
  deb0:  perf_get_x86_pmu_capability+0x0      endbr64                                                   
  deb4:  perf_get_x86_pmu_capability+0x4      callq  0xdeb9 <__fentry__>                                
  deb9:  perf_get_x86_pmu_capability+0x9      mov    %rdi,%rdx                                          
  debc:  perf_get_x86_pmu_capability+0xc      jmpq   0xdec1 <.altinstr_aux+0xfc> | NOP5  (X86_FEATURE_HYBRID_CPU) | jmpq   0x61a <perf_get_x86_pmu_capability+0x37>  (X86_FEATURE_ALWAYS)   # <alternative.debc>
  dec1:  perf_get_x86_pmu_capability+0x11     ud2                                                       
  dec3:  perf_get_x86_pmu_capability+0x13     movq   $0x0,(%rdx)                                        
  deca:  perf_get_x86_pmu_capability+0x1a     movq   $0x0,0x8(%rdx)                                     
  ded2:  perf_get_x86_pmu_capability+0x22     movq   $0x0,0x10(%rdx)                                    
  deda:  perf_get_x86_pmu_capability+0x2a     movq   $0x0,0x18(%rdx)                                    
  dee2:  perf_get_x86_pmu_capability+0x32     jmpq   0xdee7 <__x86_return_thunk>                        
  dee7:  perf_get_x86_pmu_capability+0x37     cmpq   $0x0,0x0(%rip)        # 0xdeef <x86_pmu+0x10>      
  deef:  perf_get_x86_pmu_capability+0x3f     je     0xdec3 <perf_get_x86_pmu_capability+0x13>          
  def1:  perf_get_x86_pmu_capability+0x41     mov    0x0(%rip),%eax        # 0xdef7 <x86_pmu+0x8>       
  def7:  perf_get_x86_pmu_capability+0x47     mov    %eax,(%rdi)                                        
  def9:  perf_get_x86_pmu_capability+0x49     NOP2 | jmp    defb <perf_get_x86_pmu_capability+0x4b>  (JUMP)   # <alternative.def9>
  defb:  perf_get_x86_pmu_capability+0x4b     mov    0x0(%rip),%rdi        # 0xdf02 <x86_pmu+0xd8>      
  df02:  perf_get_x86_pmu_capability+0x52     callq  0xdf07 <__sw_hweight64> | popcnt %rdi,%rax  (X86_FEATURE_POPCNT)   # <alternative.df02>
  df07:  perf_get_x86_pmu_capability+0x57     mov    %eax,0x4(%rdx)                                     
  df0a:  perf_get_x86_pmu_capability+0x5a     NOP2 | jmp    df0c <perf_get_x86_pmu_capability+0x5c>  (JUMP)   # <alternative.df0a>
  df0c:  perf_get_x86_pmu_capability+0x5c     mov    0x0(%rip),%rdi        # 0xdf13 <x86_pmu+0xe0>      
  df13:  perf_get_x86_pmu_capability+0x63     callq  0xdf18 <__sw_hweight64> | popcnt %rdi,%rax  (X86_FEATURE_POPCNT)   # <alternative.df13>
  df18:  perf_get_x86_pmu_capability+0x68     mov    %eax,0x8(%rdx)                                     
  df1b:  perf_get_x86_pmu_capability+0x6b     mov    0x0(%rip),%eax        # 0xdf21 <x86_pmu+0xf8>      
  df21:  perf_get_x86_pmu_capability+0x71     mov    %eax,0xc(%rdx)                                     
  df24:  perf_get_x86_pmu_capability+0x74     mov    %eax,0x10(%rdx)                                    
  df27:  perf_get_x86_pmu_capability+0x77     mov    0x0(%rip),%rax        # 0xdf2e <x86_pmu+0x108>     
  df2e:  perf_get_x86_pmu_capability+0x7e     mov    %eax,0x14(%rdx)                                    
  df31:  perf_get_x86_pmu_capability+0x81     mov    0x0(%rip),%eax        # 0xdf37 <x86_pmu+0x110>     
  df37:  perf_get_x86_pmu_capability+0x87     mov    %eax,0x18(%rdx)                                    
  df3a:  perf_get_x86_pmu_capability+0x8a     movzbl 0x0(%rip),%ecx        # 0xdf41 <x86_pmu+0x1d1>     
  df41:  perf_get_x86_pmu_capability+0x91     movzbl 0x1c(%rdx),%eax                                    
  df45:  perf_get_x86_pmu_capability+0x95     shr    %cl                                                
  df47:  perf_get_x86_pmu_capability+0x97     and    $0x1,%ecx                                          
  df4a:  perf_get_x86_pmu_capability+0x9a     and    $0xfffffffe,%eax                                   
  df4d:  perf_get_x86_pmu_capability+0x9d     or     %ecx,%eax                                          
  df4f:  perf_get_x86_pmu_capability+0x9f     mov    %al,0x1c(%rdx)                                     
  df52:  perf_get_x86_pmu_capability+0xa2     jmpq   0xdf57 <__x86_return_thunk>


Example 3 (--disas option): Alternatives with multiple instructions
-------------------------------------------------------------------
Alternatives with multiple instructions are displayed side-by-side, with
an header describing the alternative. The code in the first column is the
default code of the alternative.


$ ./tools/objtool/objtool --disas=__switch_to_asm --link vmlinux.o
__switch_to_asm:
  82c0:  __switch_to_asm+0x0      push   %rbp                                               
  82c1:  __switch_to_asm+0x1	  push   %rbx                                               
  82c2:  __switch_to_asm+0x2	  push   %r12                                               
  82c4:  __switch_to_asm+0x4	  push   %r13                                               
  82c6:  __switch_to_asm+0x6	  push   %r14                                               
  82c8:  __switch_to_asm+0x8	  push   %r15                                               
  82ca:  __switch_to_asm+0xa	  mov    %rsp,0x1670(%rdi)                                  
  82d1:  __switch_to_asm+0x11	  mov    0x1670(%rsi),%rsp                                  
  82d8:  __switch_to_asm+0x18	  mov    0xad8(%rsi),%rbx                                   
  82df:  __switch_to_asm+0x1f	  mov    %rbx,%gs:0x0(%rip)        # 0x82e7 <__stack_chk_guard>
  82e7:  __switch_to_asm+0x27	  | <alternative.82e7>                   | !X86_FEATURE_ALWAYS                  | X86_FEATURE_RSB_CTXSW
  82e7:  __switch_to_asm+0x27	  | jmp    0x8312 <__switch_to_asm+0x52> | NOP1                                 | mov    $0x10,%r12
  82e8:  __switch_to_asm+0x28	  |                                      | NOP1                                 |
  82e9:  __switch_to_asm+0x29	  | NOP1                                 | callq  0x82ef <__switch_to_asm+0x2f> |
  82ea:  __switch_to_asm+0x2a	  | NOP1                                 |                                      |
  82eb:  __switch_to_asm+0x2b	  | NOP1                                 |                                      |
  82ec:  __switch_to_asm+0x2c	  | NOP1                                 |                                      |
  82ed:  __switch_to_asm+0x2d	  | NOP1                                 |                                      |
  82ee:  __switch_to_asm+0x2e	  | NOP1                                 | int3                                 | callq  0x82f4 <__switch_to_asm+0x34>
  82ef:  __switch_to_asm+0x2f	  | NOP1                                 | add    $0x8,%rsp                     |
  82f0:  __switch_to_asm+0x30	  | NOP1                                 |                                      |
  82f1:  __switch_to_asm+0x31	  | NOP1                                 |                                      |
  82f2:  __switch_to_asm+0x32	  | NOP1                                 |                                      |
  82f3:  __switch_to_asm+0x33	  | NOP1                                 | lfence                               | int3
  82f4:  __switch_to_asm+0x34	  | NOP1                                 |                                      | callq  0x82fa <__switch_to_asm+0x3a>
  82f5:  __switch_to_asm+0x35	  | NOP1                                 |                                      |
  82f6:  __switch_to_asm+0x36	  | NOP1                                 |                                      |
  82f7:  __switch_to_asm+0x37	  | NOP1                                 |                                      |
  82f8:  __switch_to_asm+0x38	  | NOP1                                 |                                      |
  82f9:  __switch_to_asm+0x39	  | NOP1                                 |                                      | int3
  82fa:  __switch_to_asm+0x3a	  | NOP1                                 |                                      | add    $0x10,%rsp
  82fb:  __switch_to_asm+0x3b	  | NOP1                                 |                                      |
  82fc:  __switch_to_asm+0x3c	  | NOP1                                 |                                      |
  82fd:  __switch_to_asm+0x3d	  | NOP1                                 |                                      |
  82fe:  __switch_to_asm+0x3e	  | NOP1                                 |                                      | dec    %r12
  82ff:  __switch_to_asm+0x3f	  | NOP1                                 |                                      |
  8300:  __switch_to_asm+0x40	  | NOP1                                 |                                      |
  8301:  __switch_to_asm+0x41	  | NOP1                                 |                                      | jne    0x82ee <__switch_to_asm+0x2e>
  8302:  __switch_to_asm+0x42	  | NOP1                                 |                                      |
  8303:  __switch_to_asm+0x43	  | NOP1                                 |                                      | lfence
  8304:  __switch_to_asm+0x44	  | NOP1                                 |                                      |
  8305:  __switch_to_asm+0x45	  | NOP1                                 |                                      |
  8306:  __switch_to_asm+0x46	  | NOP1                                 |                                      | movq   $0xffffffffffffffff,%gs:0x0(%rip)        # 0x20b <__x86_call_depth>
  8307:  __switch_to_asm+0x47	  | NOP1                                 |                                      |
  8308:  __switch_to_asm+0x48	  | NOP1                                 |                                      |
  8309:  __switch_to_asm+0x49	  | NOP1                                 |                                      |
  830a:  __switch_to_asm+0x4a	  | NOP1                                 |                                      |
  830b:  __switch_to_asm+0x4b	  | NOP1                                 |                                      |
  830c:  __switch_to_asm+0x4c	  | NOP1                                 |                                      |
  830d:  __switch_to_asm+0x4d	  | NOP1                                 |                                      |
  830e:  __switch_to_asm+0x4e	  | NOP1                                 |                                      |
  830f:  __switch_to_asm+0x4f	  | NOP1                                 |                                      |
  8310:  __switch_to_asm+0x50	  | NOP1                                 |                                      |
  8311:  __switch_to_asm+0x51	  | NOP1                                 |                                      |
  8312:  __switch_to_asm+0x52	    pop    %r15                                               
  8314:  __switch_to_asm+0x54	    pop    %r14                                               
  8316:  __switch_to_asm+0x56	    pop    %r13                                               
  8318:  __switch_to_asm+0x58	    pop    %r12                                               
  831a:  __switch_to_asm+0x5a	    pop    %rbx                                               
  831b:  __switch_to_asm+0x5b	    pop    %rbp                                               
  831c:  __switch_to_asm+0x5c	    jmpq   0x8321 <__switch_to>                               


Example 4 (--disas option): Alternative with direct call
--------------------------------------------------------
An alternative with a direct call show the pv_ops call and 
the default pv_ops function for this call.

$ ./tools/objtool/objtool --disas=paravirt_read_msr --link vmlinux.o
paravirt_read_msr:
  c3d0:  paravirt_read_msr+0x0      mov    %edi,%edi                                          
  c3d2:  paravirt_read_msr+0x2	    callq  *0x0(%rip)  # 0xc3d8 <pv_ops+0xb0> | callq  pv_ops[22] ~ native_read_msr  (+X86_FEATURE_ALWAYS)   # <alternative.c3d2>
  c3d8:  paravirt_read_msr+0x8	    jmpq   0xc3dd <__x86_return_thunk>                        


Example 5 (--disas option): Alternative with direct call for XENPV
------------------------------------------------------------------
An alternative with a direct call in the XENPV case show the pv_ops
function for XEN.

early_ioremap_pmd:
 332d0:  early_ioremap_pmd+0x0      push   %rbx                                               
 332d1:  early_ioremap_pmd+0x1	    mov    %rdi,%rbx                                          
 332d4:  early_ioremap_pmd+0x4	    callq  *0x0(%rip)        # 0x332da <pv_ops+0x150> | mov    %cr3,%rax  (!X86_FEATURE_XENPV) | callq  xen_read_cr3  (+X86_FEATURE_ALWAYS)   # <alternative.332d4>
 332da:  early_ioremap_pmd+0xa	    mov    0x0(%rip),%rdx        # 0x332e1 <sme_me_mask>      
 332e1:  early_ioremap_pmd+0x11	    mov    0x0(%rip),%ecx        # 0x332e7 <pgdir_shift>      
 332e7:  early_ioremap_pmd+0x17	    mov    %rbx,%rsi                                          
 332ea:  early_ioremap_pmd+0x1a	    and    0x0(%rip),%rax        # 0x332f1 <physical_mask>    
 332f1:  early_ioremap_pmd+0x21	    not    %rdx                                               
 332f4:  early_ioremap_pmd+0x24	    and    %rdx,%rax                                          
 332f7:  early_ioremap_pmd+0x27	    mov    %rbx,%rdx                                          
 332fa:  early_ioremap_pmd+0x2a	    shr    %cl,%rdx                                           
 332fd:  early_ioremap_pmd+0x2d	    and    $0xfffffffffffff000,%rax                           
 33303:  early_ioremap_pmd+0x33	    add    0x0(%rip),%rax        # 0x3330a <page_offset_base> 
 3330a:  early_ioremap_pmd+0x3a	    and    $0x1ff,%edx                                        
 33310:  early_ioremap_pmd+0x40	    lea    (%rax,%rdx,8),%rdi                                 
 33314:  early_ioremap_pmd+0x44	    callq  0x33319 <p4d_offset+0x0>                           
 33319:  early_ioremap_pmd+0x49	    mov    (%rax),%rdi                                        
 3331c:  early_ioremap_pmd+0x4c	    callq  *0x0(%rip)        # 0x33322 <pv_ops+0x228> | mov    %rdi,%rax  (!X86_FEATURE_XENPV) | callq  __raw_callee_save_xen_p4d_val  (+X86_FEATURE_ALWAYS)   # <alternative.3331c>
 33322:  early_ioremap_pmd+0x52	    mov    0x0(%rip),%rdx        # 0x33329 <page_offset_base> 
 33329:  early_ioremap_pmd+0x59	    and    0x0(%rip),%rax        # 0x33330 <physical_mask>    
 33330:  early_ioremap_pmd+0x60	    and    $0xfffffffffffff000,%rax                           
 33336:  early_ioremap_pmd+0x66	    mov    0xff8(%rax,%rdx,1),%rdi                            
 3333e:  early_ioremap_pmd+0x6e	    callq  *0x0(%rip)        # 0x33344 <pv_ops+0x210> | mov    %rdi,%rax  (!X86_FEATURE_XENPV) | callq  __raw_callee_save_xen_pud_val  (+X86_FEATURE_ALWAYS)   # <alternative.3333e>
 33344:  early_ioremap_pmd+0x74	    mov    0x0(%rip),%rcx        # 0x3334b <physical_mask>    
 3334b:  early_ioremap_pmd+0x7b	    mov    %rcx,%rdx                                          
 3334e:  early_ioremap_pmd+0x7e	    and    $0xfffffffffffff000,%rdx                           
 33355:  early_ioremap_pmd+0x85	    and    $0x80,%dil                                         
 33359:  early_ioremap_pmd+0x89	    je     0x33365 <early_ioremap_pmd+0x95>                   
 3335b:  early_ioremap_pmd+0x8b	    and    $0xffffffffc0000000,%rcx                           
 33362:  early_ioremap_pmd+0x92	    mov    %rcx,%rdx                                          
 33365:  early_ioremap_pmd+0x95	    and    %rax,%rdx                                          
 33368:  early_ioremap_pmd+0x98	    add    0x0(%rip),%rdx        # 0x3336f <page_offset_base> 
 3336f:  early_ioremap_pmd+0x9f	    pop    %rbx                                               
 33370:  early_ioremap_pmd+0xa0	    lea    0xfc8(%rdx),%rax                                   
 33377:  early_ioremap_pmd+0xa7	    jmpq   0x3337c <__x86_return_thunk>                       

-----

Alexandre Chartre (28):
  objtool: Move disassembly functions to a separated file
  objtool: Create disassembly context
  objtool: Disassemble code with libopcodes instead of running objdump
  tool build: Remove annoying newline in build output
  objtool: Print symbol during disassembly
  objtool: Store instruction disassembly result
  objtool: Disassemble instruction on warning or backtrace
  objtool: Extract code to validate instruction from the validate branch
    loop
  objtool: Record symbol name max length
  objtool: Add option to trace function validation
  objtool: Trace instruction state changes during function validation
  objtool: Improve register reporting during function validation
  objtool: Identify the different types of alternatives
  objtool: Improve tracing of alternative instructions
  objtool: Do not validate IBT for .return_sites and .call_sites
  objtool: Add the --disas=<function-pattern> action
  objtool: Print headers for alternatives
  objtool: Disassemble group alternatives
  objtool: Print addresses with alternative instructions
  objtool: Disassemble exception table alternatives
  objtool: Disassemble jump table alternatives
  objtool: Fix address references in alternatives
  objtool: Provide access to feature and flags of group alternatives
  objtool: Function to get the name of a CPU feature
  objtool: Improve naming of group alternatives
  objtool: Get the destination name of a PV call
  objtool: Improve the disassembly of the pv_ops call
  objtool: Print single line for alternatives with one instruction

 .../x86/tools/gen-cpu-feature-names-x86.awk   |   33 +
 tools/build/Makefile.feature                  |    4 +-
 tools/objtool/Build                           |    3 +
 tools/objtool/Makefile                        |   23 +
 tools/objtool/arch/loongarch/decode.c         |   30 +
 tools/objtool/arch/loongarch/special.c        |    5 +
 tools/objtool/arch/powerpc/decode.c           |   31 +
 tools/objtool/arch/powerpc/special.c          |    5 +
 tools/objtool/arch/x86/Build                  |    8 +
 tools/objtool/arch/x86/decode.c               |   36 +-
 tools/objtool/arch/x86/special.c              |   10 +
 tools/objtool/builtin-check.c                 |    5 +-
 tools/objtool/check.c                         |  739 ++++++-----
 tools/objtool/disas.c                         | 1137 +++++++++++++++++
 tools/objtool/include/objtool/arch.h          |   14 +-
 tools/objtool/include/objtool/builtin.h       |    2 +
 tools/objtool/include/objtool/check.h         |   41 +-
 tools/objtool/include/objtool/disas.h         |   75 ++
 tools/objtool/include/objtool/elf.h           |    7 +
 tools/objtool/include/objtool/objtool.h       |    6 +-
 tools/objtool/include/objtool/special.h       |    4 +-
 tools/objtool/include/objtool/trace.h         |  139 ++
 tools/objtool/include/objtool/warn.h          |   17 +-
 tools/objtool/objtool.c                       |   27 +-
 tools/objtool/special.c                       |    2 +
 tools/objtool/trace.c                         |  204 +++
 26 files changed, 2287 insertions(+), 320 deletions(-)
 create mode 100644 tools/arch/x86/tools/gen-cpu-feature-names-x86.awk
 create mode 100644 tools/objtool/disas.c
 create mode 100644 tools/objtool/include/objtool/disas.h
 create mode 100644 tools/objtool/include/objtool/trace.h
 create mode 100644 tools/objtool/trace.c

-- 
2.43.5


