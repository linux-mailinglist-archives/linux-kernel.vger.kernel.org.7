Return-Path: <linux-kernel+bounces-720871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4FFAFC186
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6216173C7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C6623ABA1;
	Tue,  8 Jul 2025 03:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="L2L3k/yJ"
Received: from sg-3-20.ptr.tlmpb.com (sg-3-20.ptr.tlmpb.com [101.45.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765B1548C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751945911; cv=none; b=YzbHqDaew1UVwsRG9ifqu2TyB+1wS+cXxEsS4YfO3h1AF++RCRW0bMx3phCHLbPnaSv0AU+aU7pZWBl37dGtOBDedhmbiI45ODF4P/K/iyfiCt3HNYlWzINdusAY3S48MWxy1OAw2xnzCc7g7pVdrOGQDhlLg1mBP0hcO4V/PRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751945911; c=relaxed/simple;
	bh=Oyv/6RE8Tv17fW0lRkeCemw8jnfli50xwPpKcAbb9Ik=;
	h=From:Date:Content-Type:To:Cc:Subject:Message-Id:Mime-Version:
	 References:In-Reply-To; b=hgU2t9tdvfctrTEpbuxogBlVxcSqmB4TNoVEScJsVT6OLBO36dzZPhp6QaYBuO/ntX1n4y+ogIS9f0RzDa0RFb9S5d7r5uYydplBvhQnNPrC3xjk1GkLcF3Anzx5eSRMMyx19yNOFD5WBiKMOabKyTkbqcPXhsCDQJOqSI2HknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=L2L3k/yJ; arc=none smtp.client-ip=101.45.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1751945902;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=JPtZMecHGbjHuuvbPojNTgsTRGbNnLkGsdh+C3TLsdQ=;
 b=L2L3k/yJNkvFUl6D33uz0TzHHsBs16ZB8VD4V54hwB0v9eX7yqQL7hnsDA1ptgiKfjMby8
 5vzBfTaFv+BIp0y7YGO1LS+AKKAmwdhtzwbpVYwmjmedZ59OMstcwmISHxhINADu4IFp60
 Re3aDpahZQ9Cm/OHqtHOsh7JNZsFJ3XhGnQJC9da4iCABqds418ZBql5qFrrrlcdq+yIxC
 5jr/3GTyjb44plydwUMSKM34goLSce/Kdgip0nHrQf0CPSsNGhwsjFdAGJMAua88RJuOPP
 Mks8LiL0U4YOlcKNW5Aw4pK7HGqZGT7Mo8NMRpN21QwGm/PDqx9Pij7kKiIPpQ==
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Date: Tue, 8 Jul 2025 11:38:17 +0800
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+2686c92ac+31060f+vger.kernel.org+liujingqi@lanxincomputing.com>
To: <liu.xuemei1@zte.com.cn>, <paul.walmsley@sifive.com>
Cc: <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: mmap(): use unsigned offset type in riscv_sys_mmap
Message-Id: <3c4a03b3-21e4-47d3-8f69-767c2594d1bb@lanxincomputing.com>
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Tue, 08 Jul 2025 11:38:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707193411886Kc-TWknP0PER2_sEg-byb@zte.com.cn>
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Content-Transfer-Encoding: 7bit
In-Reply-To: <20250707193411886Kc-TWknP0PER2_sEg-byb@zte.com.cn>

On 7/7/2025 7:34 PM, liu.xuemei1@zte.com.cn wrote:
> From: Jessica Liu <liu.xuemei1@zte.com.cn>
>
> The variable type of offset should be consistent with the relevant
> interfaces of mmap which described in commit 295f10061af0 ("syscalls:
> mmap(): use unsigned offset type consistently). Otherwise, a user input
> with the top bit set would result in a negative page offset rather than a
> large one.
>
> Signed-off-by: Jessica Liu <liu.xuemei1@zte.com.cn>

Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>

Thanks,
Nutty

> ---
>   arch/riscv/kernel/sys_riscv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index d77afe05578f..795b2e815ac9 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -10,7 +10,7 @@
>
>   static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>   			   unsigned long prot, unsigned long flags,
> -			   unsigned long fd, off_t offset,
> +			   unsigned long fd, unsigned long offset,
>   			   unsigned long page_shift_offset)
>   {
>   	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))

