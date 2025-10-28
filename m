Return-Path: <linux-kernel+bounces-872906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA4FC1293D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873F81A6706D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015102494FF;
	Tue, 28 Oct 2025 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xz7steLJ"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614A5137932
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615843; cv=none; b=H+xU57TA+J/JTbGaMdp0uoCF7Y9393BdfbPpE/uyMLuUGI5KcgPTlOeng4t+VStVyIrrFU0M+PEaPY92cynj/3jVLxeR7o6WXkQt7kqAov7x9egAFlsSXOP7iq8e86SITujpjSwHmAxoHzNHr4B5UBYU+2pVjDqIV9d2pa78b/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615843; c=relaxed/simple;
	bh=7b9hhX2wygnHY1DU+ZIJvG+1QY0tzvSCOhpHenuBUss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxEtLCgoRXdaPaK1RjG7fs764lPQHxPmSBcY/330Sfms2dHx6bnkIpFBl/zt3cwqRQfKeyXEgo9hwoA9TtIz5ypp2HMhxW0WlikQac4KFc3JWzX/cac+6ShL6r6VNXLQlXZo6g6Wj9bbCntLpOnHBcSfLgdPRQtx2sisii0kdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xz7steLJ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761615837; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CEgJxN5Rhxo1+7HlEDbm982MBRwfUvhs/rpk+av18Cw=;
	b=xz7steLJFpisXr/y4HDRzVj9FYHdCVm4Rp0rlfAypA2oZecq25Yr8d1Iax/ryvU1GVVUeaeZlBnZ81mqksQuJV74Y3fgrNva2sPJ/l8IJrs8V917B2vjM3dNMfeKSz+yKTvu4bEWDY9P9YXD1Vcmlo2Bg9QaJN17lBL0ZZAvuzU=
Received: from 30.221.128.145(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Wr9w.kN_1761615836 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Oct 2025 09:43:57 +0800
Message-ID: <ba3241ff-d2ef-478a-ae75-c670cd40015e@linux.alibaba.com>
Date: Tue, 28 Oct 2025 09:43:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: validate cl_bpc in allocator inodes to prevent
 divide-by-zero
To: Deepanshu Kartikey <kartikey406@gmail.com>, mark@fasheh.com,
 jlbec@evilplan.org, heming.zhao@suse.com
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
References: <20251027124131.10002-1-kartikey406@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20251027124131.10002-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/10/27 20:41, Deepanshu Kartikey wrote:
> The chain allocator field cl_bpc (blocks per cluster) is read from disk
> and used in division operations without validation. A corrupted filesystem
> image with cl_bpc=0 causes a divide-by-zero crash in the kernel:
> 
>   divide error: 0000 [#1] PREEMPT SMP KASAN
>   RIP: 0010:ocfs2_bg_discontig_add_extent fs/ocfs2/suballoc.c:335 [inline]
>   RIP: 0010:ocfs2_block_group_fill+0x5bd/0xa70 fs/ocfs2/suballoc.c:386
>   Call Trace:
>    ocfs2_block_group_alloc+0x7e9/0x1330 fs/ocfs2/suballoc.c:703
>    ocfs2_reserve_suballoc_bits+0x20a6/0x4640 fs/ocfs2/suballoc.c:834
>    ocfs2_reserve_new_inode+0x4f4/0xcc0 fs/ocfs2/suballoc.c:1074
>    ocfs2_mknod+0x83c/0x2050 fs/ocfs2/namei.c:306
> 
> This patch adds validation in ocfs2_validate_inode_block() to ensure cl_bpc
> matches the expected value calculated from the superblock's cluster size
> and block size for chain allocator inodes (identified by OCFS2_CHAIN_FL).
> 
> Moving the validation to inode validation time (rather than allocation time)
> has several benefits:
> - Validates once when the inode is read, rather than on every allocation
> - Protects all code paths that use cl_bpc (allocation, resize, etc.)
> - Follows the existing pattern of inode validation in OCFS2
> - Centralizes validation logic
> 
> The validation catches both:
> - Zero values that cause divide-by-zero crashes
> - Non-zero but incorrect values indicating filesystem corruption or
>   mismatched filesystem geometry
> 
> With this fix, mounting a corrupted filesystem produces:
>   OCFS2: ERROR (device loop0): ocfs2_validate_inode_block: Inode 74
>          has corrupted cl_bpc: ondisk=0 expected=16
> 
> Instead of a kernel crash.
> 
> Link: https://lore.kernel.org/ocfs2-devel/20251026132625.12348-1-kartikey406@gmail.com/T/#u [v1]
> Reported-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fd8af97c7227fe605d95
> Tested-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
> Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> Changes in v2:
> - Moved validation from ocfs2_block_group_alloc() to ocfs2_validate_inode_block()
>   as suggested by Joseph Qi to benefit all code paths
> - Added OCFS2_CHAIN_FL check to only validate chain allocator inodes
> - Updated commit message to reflect the new location
> ---
>  fs/ocfs2/inode.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index fcc89856ab95..1b30bf336961 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1502,7 +1502,22 @@ int ocfs2_validate_inode_block(struct super_block *sb,
>  				 le16_to_cpu(di->i_suballoc_slot));
>  		goto bail;
>  	}
> -
> +	/* Validate cl_bpc for chain allocator inodes */
> +	if (le32_to_cpu(di->i_flags) & OCFS2_CHAIN_FL) {
> +		struct ocfs2_super *osb = OCFS2_SB(sb);
> +		struct ocfs2_chain_list *cl = &di->id2.i_chain;
> +		u16 cl_bpc = le16_to_cpu(cl->cl_bpc);
> +		u16 expected_bpc = 1 << (osb->s_clustersize_bits -

Seems "1 << "OCFS2_SB(sb)->s_clustersize_bits - sb->s_blocksize_bits" is enough.
This can save us from defining local 'osb'.

> +					 sb->s_blocksize_bits);
> +
> +		if (cl_bpc != expected_bpc) {
> +			rc = ocfs2_error(sb,
> +				"Inode %llu has corrupted cl_bpc: ondisk=%u expected=%u\n",
> +				(unsigned long long)bh->b_blocknr,
> +				cl_bpc, expected_bpc);
> +			goto bail;
> +		}
> +	}

Better to leave a blank line here.

Thanks,
Joseph

>  	rc = 0;
>  
>  bail:


