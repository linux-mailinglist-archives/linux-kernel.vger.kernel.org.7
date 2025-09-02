Return-Path: <linux-kernel+bounces-795929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D098B3F999
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F464E1BF6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA30F2EA720;
	Tue,  2 Sep 2025 09:04:01 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30572EA485
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803841; cv=none; b=nJkNUsaGSFYN3/rlamrigSoLloyTwZMhoZts6Fth6CkQLgtTF+ah65zYwvAXMoia8y4qabKdmQTi3cN6wK56t52TVRm/nJFvW53xuDqK9RJMDPORuVuJiMfpk8n1uHFFG+KEOJ55dQI/cPama2TrrQW2KeIOyCj7wJt47DnCNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803841; c=relaxed/simple;
	bh=9yMpve0Z6ct/B2gZBrcye5AYR4wkk7JQk3O1aWFIiQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ruv4XF89eHoB5DUzb1j9/4zUA0DtZUThPPLLf3i83ChRxStmbXagYnoUOCRgBreSPka2DAW9GWK7ZPFuqB/2A4OUxGvMykP33B6DYVrVEJt/vkJDvB12AkN/S1ozxd5esEfRQgjKBEp9XsFFpKxwzPc7yuYYZinZuzg7NFt0WeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cGKY83GGZzKHNMq
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:03:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 510331A1340
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:03:56 +0800 (CST)
Received: from [10.174.178.209] (unknown [10.174.178.209])
	by APP4 (Coremail) with SMTP id gCh0CgAncIz6srZoOM2BBA--.6100S3;
	Tue, 02 Sep 2025 17:03:56 +0800 (CST)
Message-ID: <732d629c-d1b9-4483-95c3-9a80bd7b2511@huaweicloud.com>
Date: Tue, 2 Sep 2025 17:03:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: core: only increment ecc_stats.badblocks on
 confirmed good->bad transition
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, chengzhihao1@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20250902080117.3658372-1-wangzhaolong@huaweicloud.com>
 <87ms7dntlb.fsf@bootlin.com>
From: Wang Zhaolong <wangzhaolong@huaweicloud.com>
In-Reply-To: <87ms7dntlb.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIz6srZoOM2BBA--.6100S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4rJw1fGFy3Jw13Cw1kAFb_yoW5Gw4fpa
	n8t3WrCa1DWw1Fq3W7Zr1xXasag3s3KrsxGF48Jr1UCF98uw1ftrn8KFyF9rnFgrsFyr4q
	vr45K39xua4UJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: pzdqw6xkdrz0tqj6x35dzhxuhorxvhhfrp/


Hi Miquèl,


> Hello Wang,
> 
>> @@ -2349,17 +2351,35 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs)
>>   		return -EROFS;
>>   
>>   	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
>>   		ofs = (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
>>   
>> -	ret = master->_block_markbad(master, mtd_get_master_ofs(mtd, ofs));
>> +	moffs = mtd_get_master_ofs(mtd, ofs);
>> +
>> +	/* Pre-check: remember current state if available. */
>> +	if (master->_block_isbad)
>> +		oldbad = master->_block_isbad(master, moffs);
>> +
>> +	ret = master->_block_markbad(master, moffs);
>>   	if (ret)
>>   		return ret;
>>   
>> -	while (mtd->parent) {
>> -		mtd->ecc_stats.badblocks++;
>> -		mtd = mtd->parent;
>> +	/*
>> +	 * Post-check and bump stats only on a confirmed good->bad transition.
>> +	 * If _block_isbad is not implemented, be conservative and do not bump.
>> +	 */
>> +	if (master->_block_isbad) {
>> +		/* If it was already bad, nothing to do. */
>> +		if (oldbad > 0)
>> +			return 0;
>> +
>> +		if (master->_block_isbad(master, moffs) > 0) {
>> +			while (mtd->parent) {
>> +				mtd->ecc_stats.badblocks++;
>> +				mtd = mtd->parent;
>> +			}
>> +		}
> 
> I don't think you can assume the block was already bad and must not be
> accounted as a new bad block if you cannot verify that. In this case we
> must remain conservative and tell userspace a new block was marked bad,
> I believe.

Thanks for the review and the clear guidance.

My intent was to avoid inflating badblocks by only bumping the counter on a
confirmed good->bad transition. I tried to ground the decision on observable
state (pre/post isbad) rather than return codes, and to avoid assuming success
implies immediate visibility across drivers. That’s why the increment was
tied to verification and skipped when _block_isbad was unavailable.

Your point about being conservative towards userspace is well taken: if we
cannot verify, we should still account the bad block. Skipping the increment
only when we can prove the block was already bad makes the contract clearer
and avoids under-reporting. Keeping the increment outside the if (_block_isbad)
block also results in simpler, more readable code.


> Said otherwise, the { while () badblocks++ } block shall remain outside
> of the if (_block_isbad) condition and remain untouched. Just bail out
> early if you are sure this is not needed.
> 

I’ll send a V2 shortly that:

- Checks old state when _block_isbad exists and bails out early if already bad
- Otherwise calls ->_block_markbad() and increments the counter on success, with
   the increment left outside of the conditional as you suggested

Thanks again for the direction.

Best regards,
Wang Zhaolong


