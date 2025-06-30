Return-Path: <linux-kernel+bounces-708788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A53FAED50F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 08:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CA51665DC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 06:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA212036EC;
	Mon, 30 Jun 2025 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NE8PdBGG"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2B41A257D
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751266691; cv=none; b=pqP/A/A5miOB9LUUQteif2tNxn10nqJJ7Cqivm3DgHGAOdOIMph5YFKNeFPl8If9wcklo2lXygYaFbwVyNy7K77h8cQ2hNPblRCEfpX355fM2vk+aU/EYwuE2kTuAcEWlVEmHyDuvZ4VME4A6/JjlePAIP17XJPUcSzwotZ4R9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751266691; c=relaxed/simple;
	bh=22muhudrKAP9SyPktRxaDI0DWxOAHRAa/eScSXEoNkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=temgGMnCwrvWVsD5+MipsOS5D+qHTcsg+Nl9B1OZKdoJtof0ljZQPky7lmjIxTB4/ZUPXSqgmxpqW85aZcKS0JsAa+8NlvHMXzlWK9+ofzimmtcYgU7i33Tb1SeRwZZ0UuGM52eEYC4Jo+O9/AeVpFMi/I/sdxFz3GURefu4eSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NE8PdBGG; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751266683; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Cd0yPD5GQTE25xLtG5ldmJA2ScotRmfC39N8dTBHOgk=;
	b=NE8PdBGGd33B1z8+WQVu+S0EbMgTpWukoCv1g+2OR7tx8v7AwIUOku8gIJFVraOgkHOmPqVqgRZvNOTs+lmOGtzfRFOwKeOvdcxvtzqtf60TI+nrHjP/9OR4+6BY95Syx+p875qBM4C9Wbd3/zCBYhOPrvoHqT6ENemg1+Gcsac=
Received: from 30.221.128.206(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Wg5ZvMJ_1751266681 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Jun 2025 14:58:02 +0800
Message-ID: <a259f224-a471-45e3-84de-7071ec6595e9@linux.alibaba.com>
Date: Mon, 30 Jun 2025 14:58:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Avoid NULL pointer dereference in
 dx_dir_lookup_rec()
To: Heming Zhao <heming.zhao@suse.com>,
 Ivan Pravdin <ipravdin.official@gmail.com>, mark@fasheh.com,
 jlbec@evilplan.org, ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: syzbot+20282c1b2184a857ac4c@syzkaller.appspotmail.com
References: <20250627023830.150291-1-ipravdin.official@gmail.com>
 <d6c72ab8-d600-4cc2-9609-8b749b61703d@linux.alibaba.com>
 <d6a11613-9763-4d9a-b4ad-5f451f770b70@suse.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <d6a11613-9763-4d9a-b4ad-5f451f770b70@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/6/30 10:32, Heming Zhao wrote:
> On 6/30/25 09:26, Joseph Qi wrote:
>> Hi,
>>
>>
>> On 2025/6/27 10:38, Ivan Pravdin wrote:
>>> When a directory entry is not found, ocfs2_dx_dir_lookup_rec() prints an
>>> error message that unconditionally dereferences the 'rec' pointer.
>>> However, if 'rec' is NULL, this leads to a NULL pointer dereference and
>>> a kernel panic.
>>>
>>
>> This looks possible, but syzbot reports slab-out-of-bounds Read in
>> ocfs2_dx_dir_lookup_rec(), not NULL pointer dereference.
>>
>> So I think it is because it construct a malicious image and set a wrong
>> l_recs, then access this damaged l_recs.
>>
>> Thanks,
>> Joseph
> 
> I think this proposed fix (at least the fix method) is acceptable.

But this seems different from the issue syzbot reports, right?
https://lore.kernel.org/all/67483b75.050a0220.253251.007c.GAE@google.com/T/

Thanks,
Joseph

> the crash occurs at ocfs2_error(), where the pointer 'rec' must be incorrect.
> look back at the previous code lines:
>         for (i = le16_to_cpu(el->l_next_free_rec) - 1; i >= 0; i--) {
>                 rec = &el->l_recs[i];
> 
>                 if (le32_to_cpu(rec->e_cpos) <= major_hash) {
>                         found = 1;
>                         break;
>                 }
>         }
> 
> either 'el->l_next_free_rec' or 'el->l_recs[i]' has an incorrect value.
> we can do nothing about this kind of error, simply returning errno to caller is sufficient.
> 
> btw, ocfs2-tools has a similar function "static errcode_t ocfs2_dx_dir_lookup_rec()"@libocfs2/dir_indexed.c, which sets ret with OCFS2_ET_CORRUPT_EXTENT_BLOCK and return.
> 




