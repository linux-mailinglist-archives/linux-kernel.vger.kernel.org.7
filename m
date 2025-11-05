Return-Path: <linux-kernel+bounces-886587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 913A5C36055
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50E0D4E92E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B34313E2F;
	Wed,  5 Nov 2025 14:20:08 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7163E1DC997
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352407; cv=none; b=g4ulwvLNopJR8FKoaSambdT0aNfhG4IHA7FQkuKgp660GVa9y7Am84mV3YkhWM5SkjtqllJZlzjhd+QnAxjr0oqTRxLPYM/a0Uiay8lsn6hVHkxUmH5BJF9GYW9ucsKydL1W33nXFwU73bGTydFUiIZZNqCtB1K7Y9DaafKFdHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352407; c=relaxed/simple;
	bh=4XfEkLJsjVtuGxghOdJ23OsMRT4RAKbyJUUVZqSXMpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jdeO4viurDBw1o6jx9zjvxfrXJPWfbInHxgQnPc/1Owgbuq2o5eAWvdnk5lmKv/VI4mgxkeBoXq3VPHoxUzeTr+LCQWGE6zOppB7t215C/nCsTubE7uYaTjKsIEzI4cCQdj768CamxaTsomRWGsPuqC4Ywqb3Z/IQlpkggCUWuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d1mmj0Ysfz9sRy;
	Wed,  5 Nov 2025 14:45:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lCEyzqt3JgUV; Wed,  5 Nov 2025 14:45:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d1mmh6Whcz9sRh;
	Wed,  5 Nov 2025 14:45:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CE11D8B76E;
	Wed,  5 Nov 2025 14:45:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id uCc9lE3z-fx3; Wed,  5 Nov 2025 14:45:40 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 86D2A8B76D;
	Wed,  5 Nov 2025 14:45:40 +0100 (CET)
Message-ID: <18dd8200-6a8c-449e-9fb8-56874342defb@csgroup.eu>
Date: Wed, 5 Nov 2025 14:45:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mainline] Kernel OOPs while running powerpc/mce/ selftest
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, Nathan Lynch <nathanl@linux.ibm.com>
References: <4b107285-57d7-482d-9fdf-8499e5fdbebb@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <4b107285-57d7-482d-9fdf-8499e5fdbebb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/10/2025 à 06:54, Venkat Rao Bagalkote a écrit :
> Greetings!!!
> 
> 
> IBM CI has reported a kernel crash while running mce selftests on 
> mainline kernel, from tools/testing/selftests/powerpc/mce/.
> 
> 
> This issue is hit when CONFIG_KASAN is enabled. If its disabled, test 
> passes.
> 
> 
> Traces:
> 
> 
> [ 8041.225432] BUG: Unable to handle kernel data access on read at 
> 0xc00e0001a1ad6103
> [ 8041.225453] Faulting instruction address: 0xc0000000008c54d8
> [ 8041.225461] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 8041.225467] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> [ 8041.225475] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 
> nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
> nft_chain_nat nf_nat nf_conntrack bonding tls nf_defrag_ipv6 
> nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink pseries_rng vmx_crypto 
> dax_pmem fuse ext4 crc16 mbcache jbd2 nd_pmem papr_scm sd_mod libnvdimm 
> sg ibmvscsi ibmveth scsi_transport_srp pseries_wdt
> [ 8041.225558] CPU: 17 UID: 0 PID: 877869 Comm: inject-ra-err Kdump: 
> loaded Not tainted 6.18.0-rc2+ #1 VOLUNTARY
> [ 8041.225569] Hardware name: IBM,9080-HEX Power11 (architected) 
> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [ 8041.225576] NIP:  c0000000008c54d8 LR: c00000000004e464 CTR: 
> 0000000000000000
> [ 8041.225583] REGS: c0000000fff778d0 TRAP: 0300   Not tainted (6.18.0- 
> rc2+)
> [ 8041.225590] MSR:  8000000000001003 <SF,ME,RI,LE>  CR: 48002828  XER: 
> 00000000
> [ 8041.225607] CFAR: c00000000004e460 DAR: c00e0001a1ad6103 DSISR: 
> 40000000 IRQMASK: 3
> [ 8041.225607] GPR00: c0000000019d0598 c0000000fff77b70 c00000000244a400 
> c000000d0d6b0818
> [ 8041.225607] GPR04: 0000000000004d43 0000000000000008 c00000000004e464 
> 004d424900000000
> [ 8041.225607] GPR08: 0000000000000001 18000001a1ad6103 a80e000000000000 
> 0000000003000048
> [ 8041.225607] GPR12: 0000000000000000 c000000d0ddf3300 0000000000000000 
> 0000000000000000
> [ 8041.225607] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 8041.225607] GPR20: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 8041.225607] GPR24: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 8041.225607] GPR28: c000000d0d6b0888 c000000d0d6b0800 0000000000004d43 
> c000000d0d6b0818
> [ 8041.225701] NIP [c0000000008c54d8] __asan_load2+0x54/0xd8
> [ 8041.225712] LR [c00000000004e464] pseries_errorlog_id+0x20/0x3c
> [ 8041.225722] Call Trace:
> [ 8041.225726] [c0000000fff77b90] [c0000000001f8748] 
> fwnmi_get_errinfo+0xd4/0x104
> [ 8041.225738] [c0000000fff77bc0] [c0000000019d0598] 
> get_pseries_errorlog+0xa8/0x110
> [ 8041.225750] [c0000000fff77c00] [c0000000001f8f68] 
> pseries_machine_check_realmode+0x11c/0x214
> [ 8041.225762] [c0000000fff77ce0] [c000000000049ca4] 
> machine_check_early+0x74/0xc0
> [ 8041.225771] [c0000000fff77d30] [c0000000000084a4] 
> machine_check_early_common+0x1b4/0x2c0

Is it a new problem or has it always been there ?

The problem is because KASAN is not compatible with realmode (MMU 
translation is OFF).

pseries_machine_check_realmode() is located in 
arch/powerpc/platforms/pseries/ras.c built with KASAN_SANITIZE_ras.o := n

But pseries_machine_check_realmode() calls mce_handle_error() which 
calls get_pseries_errorlog().

get_pseries_errorlog() is in arch/powerpc/kernel/rtas.c which is _not_ 
built with KASAN_SANITIZE disabled hence the Oops.

Unrelated, but it looks like there is also a problem with commit 
cc15ff327569 ("powerpc/mce: Avoid using irq_work_queue() in realmode"), 
which removed the re-enabling of translation but left the call to 
mce_handle_err_virtmode().

Christophe

