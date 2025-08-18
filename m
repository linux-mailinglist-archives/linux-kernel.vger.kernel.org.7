Return-Path: <linux-kernel+bounces-773022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC1B29A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBD32041AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56CC277CB1;
	Mon, 18 Aug 2025 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="l9qdOH6S"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109B1E008B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501047; cv=none; b=LtTq1LPh5jCsPz6rOB9TC6dtWubqIOcRDhndrQKwS4T8BnoO6Vv8BrEIZ85auGY6go8b+eBUGFXArsza/XOL5Oz/C2Z2hG/xv4s7caToiBfPih2q0KXVDuyN1qNhVLusQt7kKds+enaw+F3zrsvZU/4KV40tluExjw9/f8GTqds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501047; c=relaxed/simple;
	bh=16BbQFcv29+6Uk4By1bC4nzIcQZgln+mYt1XP6RjV/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrhykNDAQs+zKDIqB5blMyOUxKpCGJrWr7pFfA000UQiR17lol0eKI7d+vJUVgxpCKXaRQSF1kJqVsNPf1NEupsOk1XOc7x/70x7jT5lyofYtgTJkYGbPRC7cxNiZYgp+tF9kLPPO7xFfqhQGwklhLfEpjvqIch0rCJqwZPXNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=l9qdOH6S; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755501033;
	bh=DIyLi8TReoN+5AF3jvUXWckVHC2MAP2cCVjZaPo6GQw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=l9qdOH6SuVBnYSZj+wjxhn+mvv9XN/PmDpQhQAMuNdM5hmG0h5t3vvtwMW+1zoWG5
	 Yib/VO077FBPGrtxgZQPyc0aPqSc9Hg7cqAR8s/6fqWF1dNsmW1FIM10jju4bLs3pB
	 rQiiOdhiP/WuA3gsrbZXNFkjpoI5MoedclxU+OkU=
X-QQ-mid: esmtpsz16t1755501030t18f06d0f
X-QQ-Originating-IP: Yz02jh1oqjelU7qc2kAra1/3BSe5M9Cdk8a1P5ZaNVc=
Received: from = ( [14.123.254.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 15:10:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5468809535196601441
EX-QQ-RecipientCnt: 14
Date: Mon, 18 Aug 2025 15:10:28 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: fangyu.yu@linux.alibaba.com, anup@brainfault.org, atish.patra@linux.dev,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: guoren@linux.alibaba.com, guoren@kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH V2] RISC-V: KVM: Write hgatp register with valid mode bits
Message-ID: <BA652752F35145B4+aKLR5OHaYZ99CvHb@LT-Guozexi>
References: <20250818054207.21532-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818054207.21532-1-fangyu.yu@linux.alibaba.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Nw75Pb9ZsEyGbGU/2uZNGJ4RZ6ryd1WtxxExHkav3qUwsG1PE/VrAI9V
	VmW09g42524DoIl2yystSHVSpnX0Qjm7SgnAsbFFYM8zAiDzv6e75exzHVZeyYd5JNg6Mme
	rri4YI3By5RNWFOPdPOdxYCRTAAblyAWkyym0lVQ0cB4XEpZ/oF6FoHBCdfFtSDidePz2nu
	oAE4NgvCTGsSJbCfZzpB5sYg5M4rFoVqD1fAZCZEGGoeaPxQb6YJYQO89lf49/2UsvWiN6Q
	BqlX4/FS0xUptyfoNs8zKd4ekUs7Nb/wsD2NApScUw5Ij4oHfApEw0s73OPRhMEyXCC3OSK
	5ITF9KmCb7jBHweSF2Na6yLYc//zAhcbI81bMMdCYIh8+NbaR9Vpc/0VQokmob6BmueWXwE
	A1gFa1xa46HYJz8WkpVkPkvOGk9YgEQJUpIFwTuvMcE7RY0PbZT7vOBgLH9gjmIyx4fus1Y
	X0n2geTVKozqTbjMaXQ0yHAQRGUj/pGHOrvxpi8c8VB8CflltQvVvztCSmEroKsh6tqfYlt
	tGcPPU+fTBSYZYmgk82ysUZHd72sD/4i5OtghmtpkkpYKTSZY/EE4LCapCDS2Du5t7vmvG0
	JADzBA05vZDXEPHs4Ikf5sQPKFqEyr1YFzG/PoHVt/NLZuSatd1isW2Scet/S3Z1f677WoX
	IXk+WnlQp9lgWRNkXsOsOXk6iPlcpmX+rtUV1o+DB6+kWzTH3pk4PDZdNpFsoB0EbdhESXC
	uo6NtkSoZKCsnY3CBAL+ZDUGe57v8NPMhM248E371jDc2Vi+lSlIQXsp6Em9DpNrPeOuBYk
	PcW5nr8d4xZxjsEWWom43sb5SFbWll2ipivQHsE7cVqzda3Cwm++fJnB42hnDXxWFVda+ao
	BUThJTQDyUr7hX50PEHHeHu/E/W30xiTenhFGSZqocHSqpuA0zJ7YlQDyRArfYYiQrE5Rx+
	youg6TWbKqoHI+Wce0uLJ7MQW2CNI6rP8srBEkCNsNPdBlWxOjQOCTxQUil5lOWL6jz56Kd
	n7aaLWImzmo5IQLXQpCFZ5wH1xyNxyWEEhWtoBQ3f+MCETF7MbB6WErbHhQGgG78U5cwKus
	H8JAkgaTCbw+x1s12pXO8AgLvr4PAiPRQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Mon, Aug 18, 2025 at 01:42:07PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> According to the RISC-V Privileged Architecture Spec, when MODE=Bare
> is selected,software must write zero to the remaining fields of hgatp.
> 
> We have detected the valid mode supported by the HW before, So using a
> valid mode to detect how many vmid bits are supported.
> 
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
With Fixed tag, feel free to add:

Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> 
> ---
> Changes in v2:
> - Fixed build error since kvm_riscv_gstage_mode() has been modified.
> ---
>  arch/riscv/kvm/vmid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
> index 3b426c800480..5f33625f4070 100644
> --- a/arch/riscv/kvm/vmid.c
> +++ b/arch/riscv/kvm/vmid.c
> @@ -14,6 +14,7 @@
>  #include <linux/smp.h>
>  #include <linux/kvm_host.h>
>  #include <asm/csr.h>
> +#include <asm/kvm_mmu.h>
>  #include <asm/kvm_tlb.h>
>  #include <asm/kvm_vmid.h>
>  
> @@ -28,7 +29,7 @@ void __init kvm_riscv_gstage_vmid_detect(void)
>  
>  	/* Figure-out number of VMID bits in HW */
>  	old = csr_read(CSR_HGATP);
> -	csr_write(CSR_HGATP, old | HGATP_VMID);
> +	csr_write(CSR_HGATP, (kvm_riscv_gstage_mode << HGATP_MODE_SHIFT) | HGATP_VMID);
>  	vmid_bits = csr_read(CSR_HGATP);
>  	vmid_bits = (vmid_bits & HGATP_VMID) >> HGATP_VMID_SHIFT;
>  	vmid_bits = fls_long(vmid_bits);
> -- 
> 2.49.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

