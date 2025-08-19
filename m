Return-Path: <linux-kernel+bounces-775038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26C2B2BA93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFFC58123B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6433426FA6F;
	Tue, 19 Aug 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="aDbVtt+R"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FA247DE1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587991; cv=none; b=f2jOmEbwEIQZTpxQivcretbQZarYhKPUTEv2iSpc0LOFVmZwa4n7oK8zpZppoKBm3dqyEYbzixLigpJVFfZ10XpbVP64FOh1WPdfnG1vmN3zBwUTpJDbWGuS4uG3vndWvMsjDMvjGbNg9eF11Q7Qm1oY/NM5UN86plTCubXTLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587991; c=relaxed/simple;
	bh=SfUaWnxlwKakO9AKd3NADRLC/a2xMElBMGE7Emd0IXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Utb7jYtfwdeibC8wqsaLGxMOKcfi+32kXKdPTFMEX6FpB4rb/M9Z1gJFsqSZEHv6kESY71bhGRwqHLmWFgSGVvxIt8E296agf5hQKJRXF5z5tdKDr0klyD1U79OjwFpbRPzV0utf1TxDeCnjDDQilRSJK2pJYAeWJTf91BWOLv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=aDbVtt+R; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755587964;
	bh=6GXKO/OSeIUD3NFhD4xkJWy9owCpecXpN1wJWziXETk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=aDbVtt+R05QfPp4chfWsrkfnM98iGCQ2fKKuKN9KduAjG5M9A72u44smA5AIQ+/WS
	 lmzhZjQLcvSg6UB8vGBiTOT8ibD2e9vk4/m5dSNILofMm0XNW468+YB/BSKKRDiKV0
	 ilQ4Cs0MgRvjFZOQD/tGvj+x3fsBAHsKBHCDz/jE=
X-QQ-mid: zesmtpgz5t1755587959tb7026c59
X-QQ-Originating-IP: bVF3pNTnsEAaLtygWLNeH55OqNdWT2+5WcRDKPuwz/o=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 Aug 2025 15:19:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8562983801700431660
EX-QQ-RecipientCnt: 15
Date: Tue, 19 Aug 2025 15:19:17 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Jimmy Ho <jimmy.ho@sifive.com>, linux-riscv@lists.infradead.org
Cc: troy.mitchell@linux.spacemit.com, ziyao@disroot.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, cyrilbur@tenstorrent.com, cleger@rivosinc.com,
	charlie@rivosinc.com, kees@kernel.org, ben.dooks@codethink.co.uk,
	jszhang@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: fix using wrong load type
Message-ID: <B1669DA80470EE6A+aKQldVbfZ9rnlD9o@LT-Guozexi>
References: <20250819071318.21103-1-jimmy.ho@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819071318.21103-1-jimmy.ho@sifive.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NGty2jX6n+5/Xktf74bQ9Le56YLeMhwu0lvjxdjFJgI3IvOsxXe7upIC
	7GWjPMiQkwPwet7onHvgt4UdQwDEHZDqy40Qm4nhnfKDFW7+w2irZBZzEpHfkFKYCki0L12
	wBQjpUE8V0UUVCIEcohHuq2SvZJef43vz0TZiVu7tgiu90/yARnrTBOU/XBPmbQ60DL1SdE
	3pfv6m4Sc4GyhhELgDu85NgNiUVm2ZE7bGC/NGQ0Ypmi9EnhGyKfF9X6QfhloTUuhBoNX4v
	dNcMd5JtYgzGV3C/NDnS4ymCrib4UgnY9AaBYJkWx2PF/EtWFCjDFDnahPvHgdviCoV2s8t
	tAtus9a9sdONTiKq1KChpHGQHg/tHavZ19q1jhcpoLm/zeMMvyPofCkhJGv/16CPwF6d2p8
	fIZtVSglq6Z2LyiogjAOG8y0gCA39DUn/vntKMKBfL+hnauYDYAk3zx7mtl7lwtK9wj8VIS
	8uUk5m+KpiUPsBZ1Rt3hJcb26WSljTTmiR0rIAVW46co5AM2KQOstOzfu9xaqwYx+UDDoig
	C7UJ+2s1P3EkaJryPpev6Oa0U9kAi5dJqQ7SXjby+0iFbu6kHJzxilSzrDSavHjH6gVYAMh
	YToNVKBI/lj4zyQGokqLxPTY3icYTOW4kqCiG4AO3WYW6W85ZMjtEi2xT52ORtTmAKhbxQT
	FE6TjgeBvrXJlCt8Eyb9dW0ska9/hTmr/A40uzo7wfAJp8pKgM8yf0Kt/0RY6s8wAFemwTM
	Iztv3e0/UezFI/g2Rknsb7zMyqHABWWvPjGb0uak5z/V7zDweK47KgUk4/cFus/5G5fE5Rj
	8mdhbisXA8vM/VaRX3ijldO241nL/IseHiIjTEA4wcaQAYn73QsYtqyyymacZ92veNV/wga
	vDBkBdWdSzoKuS3K+DIK7ZhsSECd/mRWixrdfGxlV2hPRpEYGDuoiqTAHChhx36vWxqmMWH
	1Nj2d1KWb3CLLtFmMjaLYXbhlVPgS09L6sh5iHcZszF8m3xRqTPJmBXpNWkF07id4Eqsmfl
	S6Ah+zltkSctV3uAI1nw/m0rI8pqoeKcPfVtFsA1X6IXvq6IvD8DqRR+i0JdpYzN4q3zTTE
	w==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Tue, Aug 19, 2025 at 03:13:18PM +0800, Jimmy Ho wrote:
> thread_info.cpu field is 32 bits wide,
> but is accessed using an XLEN-bit load, which might be 64bit load, fix it
> 
> Changes in v3:
> - replace space with tab to keep it aligned with code block
> - Add "Fixes" tag
Please add previous version link.

> 
> Changes in v2:
> - add a comment to explain why use lw instead of REG_L.
> - correct commit message
ditto.

Additionally, I see a patch here that serves the same purpose as yours,
but it's more comprehensive and was submitted earlier.

In any case, if you'd like to proceed, here is the:
Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> 
> Fixes: 503638e0babf3 ("riscv: Stop emitting preventive sfence.vma for new vmalloc mappings")
> Signed-off-by: Jimmy Ho <jimmy.ho@sifive.com>
> ---
>  arch/riscv/kernel/entry.S | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 3a0ec6fd5956..492ae936dccd 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -45,8 +45,10 @@
>  	 * Computes:
>  	 * a0 = &new_vmalloc[BIT_WORD(cpu)]
>  	 * a1 = BIT_MASK(cpu)
> +	 * 
> +	 * using lw instead of REG_L is because the thread_info.cpu field is 32 bits wide
>  	 */
> -	REG_L 	a2, TASK_TI_CPU(tp)
> +	lw	a2, TASK_TI_CPU(tp)
>  	/*
>  	 * Compute the new_vmalloc element position:
>  	 * (cpu / 64) * 8 = (cpu >> 6) << 3
> -- 
> 2.39.3
> 
> 

