Return-Path: <linux-kernel+bounces-808149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B31B4FAD6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACAF4E1532
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CC5335BB0;
	Tue,  9 Sep 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5ql/Nzr"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE62322C66
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420973; cv=none; b=rIXjwxvv/G1ilGNuuzjMSeA/LkveWmzxcypysHueYOdpz28jZ1HdPtxYqUafpfeIltOquDAQnauVcjiVdk+ua9glG4O6tTMJUTcOzAWRhvxejyJK6TjCB6iSltp72BV7WFP7ZP3vuxdd4HpGZal5BTW8oCIh0lmTeWDe/Dnb5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420973; c=relaxed/simple;
	bh=a46tfuTHiQ5PODxeSEShGGb74MLduiQahZTs6n4y9P4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TS+8UrcvL82mHINneLSR3uVb7JZTHqLXHqJgwfuwmm6ppE5EBWjeqeyGKyrjR915SxWokdwf1dwXFKPBOlnLLNmt339MdRLgG+W81e/yqXTJXKUwo4bEJEow/O0dXKOworjV9kkWT4py1BiFB6YsSnN1CnwlghPdK1R5Y9F7sy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5ql/Nzr; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so3687877a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757420971; x=1758025771; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sP14GaO9hh/AViIMu35gYGXTB37uSd6BGzGkZYr487c=;
        b=f5ql/NzrxW1oua17Gz2LOQ5Ecz7roE2nEk/UTpIbQMAOZ+8gMLHRmtAvsz29Q4vrJy
         7nQ4ThiDES7pL/nmaXmp3tW1klys6I1P0Caj3OGV52TCnmu0Qn/K4RpEmk6yRceGOhn1
         eUDoYVk2xD50eQ/qBiSiYZiMz7bUPYgbxC9D9Kwe4ZJd7zFYtH8xwnZPa+pfKEGGZ1zq
         1CMgunaKWuBGRP3297FWLCR78Ii2lAiu54ChCjhf3oiheiFdMSzxSJnpUELrazvpvxXU
         4HAfqEGunupRGrPuIWeveXptIU7NOrZJlXBaZUlv808E2aoMORsZMZKAh3fKEVSImQUP
         NqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757420971; x=1758025771;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP14GaO9hh/AViIMu35gYGXTB37uSd6BGzGkZYr487c=;
        b=NGOZwL9idzDUNtlDkUxZpnY8Vyvr1H1WfLDy3/Z5qfZuZDSvQJIZJnzVNNGQm+Yl1Q
         O2yTFnXoKusQv6rNfnCoqrrT3H31879TvFvA59P5ck90FI//qhzeMZPyUM7VGl95cULO
         A7U33whmrk3xEIVqJslZ+hAhk7grlpsBmi5cUyw8lls8E6da9kdYXTT0gbYsWBe1Z/ij
         7MaHjgru/5jwTCE5dpbXlTmg5tfC/U08m84keMIYS4XFAS/0eNYZNGjgoSTrwpt1bFkQ
         /KCQ3k1lU1UjRI9/MCMUY0ZZaRRMV7Ef4uv4yLR3kbLKIWe/+zjvE9X/ej3kCWNyD3w4
         +eVw==
X-Forwarded-Encrypted: i=1; AJvYcCXxwjYLwfZFwAURtfyuLJR2l3r2Q8st7fMQWCaOeZEsTPrTWW9SKl1RTbp9WHaFmgAmE0BIESAwGKge3iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO8Z1OwmC+AmhInYqw2E/UG6CY593FfdpFf79f79oTnP68JH7t
	hn9VbTXuWwhea2BAf7T7RT3JPi2Suz0LynnuVMl+PT9GYqp98LlJX0fa
X-Gm-Gg: ASbGncvgcCRE0zXbS0uImHb8IVFF/owiBvRARNPvujNZZ3SorKS7Pu6wb/3nzxIHcBN
	6To3WQV15r7oOE8/eiQFhNSiUcTLZycytVvj+aIr5jQiD790quadWd91zPgcyiur+SO7dOkhBo9
	Ta0jAYJ4P6Eb2WmlVUrxFRa/GABEd3RglD8BX9y4yYQkwWlkmrLvTrp6GysbB9g8Ca6Dxdzd2J5
	z5Yfm9LBFxmVJePp2XquTJGF4XPBNrHjgsk+1wXH+LIQtYlJV4+JntazLEJ89XYvsefT8Xl8/wR
	tQC9/+//ZRLaEbBRC9/7JPIDFUkkgXDW63eSIpDnX2OrKtdt4wE+2/6HUjMQ/0V2HQUt6beSC5p
	94+PgYV38yUp/SZW76JPWuyjQ/GV8mJrw+oNo1iu6
X-Google-Smtp-Source: AGHT+IFW338xaoGXmgeJuL5dLdv0vvtEaqjETaGyLvB3JHkac4awC+VJGJGYIiRnKQBTZkkp6c8LVA==
X-Received: by 2002:a17:90a:c10e:b0:32b:9595:ea58 with SMTP id 98e67ed59e1d1-32d43f8e9e4mr12819259a91.34.1757420971319;
        Tue, 09 Sep 2025 05:29:31 -0700 (PDT)
Received: from smtpclient.apple ([185.220.238.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32d7d4074b4sm6703233a91.4.2025.09.09.05.29.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2025 05:29:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] mm: shmem: fix too little space for tmpfs only fallback
 4KB
From: Vernon Yang <vernon2gm@gmail.com>
In-Reply-To: <c245dbb5-2e2b-4308-a296-f711b74002eb@linux.alibaba.com>
Date: Tue, 9 Sep 2025 20:29:14 +0800
Cc: Vernon Yang <vernon2gm@gmail.com>,
 hughd@google.com,
 akpm@linux-foundation.org,
 da.gomez@samsung.com,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Vernon Yang <yanglincheng@kylinos.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3349E5A6-BCDC-47B9-956B-CB0D0BC02D84@gmail.com>
References: <20250908123128.900254-1-vernon2gm@gmail.com>
 <c245dbb5-2e2b-4308-a296-f711b74002eb@linux.alibaba.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
X-Mailer: Apple Mail (2.3826.700.81)



> On Sep 9, 2025, at 13:58, Baolin Wang <baolin.wang@linux.alibaba.com> =
wrote:
>=20
>=20
>=20
> On 2025/9/8 20:31, Vernon Yang wrote:
>> From: Vernon Yang <yanglincheng@kylinos.cn>
>> When the system memory is sufficient, allocating memory is always
>> successful, but when tmpfs size is low (e.g. 1MB), it falls back
>> directly from 2MB to 4KB, and other small granularity (8KB ~ 1024KB)
>> will not be tried.
>> Therefore add check whether the remaining space of tmpfs is =
sufficient
>> for allocation. If there is too little space left, try smaller large
>> folio.
>=20
> I don't think so.
>=20
> For a tmpfs mount with 'huge=3Dwithin_size' and 'size=3D1M', if you =
try to write 1M data, it will allocate an order 8 large folio and will =
not fallback to order 0.
>=20
> For a tmpfs mount with 'huge=3Dalways' and 'size=3D1M', if you try to =
write 1M data, it will not completely fallback to order 0 either, =
instead, it will still allocate some order 1 to order 7 large folios.
>=20
> I'm not sure if this is your actual user scenario. If your files are =
small and you are concerned about not getting large folio allocations, I =
recommend using the 'huge=3Dwithin_size' mount option.
>=20

No, this is not my user scenario.

Based on your previous patch [1], this scenario can be easily reproduced =
as=20
follows.

$ mount -t tmpfs -o size=3D1024K,huge=3Dalways tmpfs /xxx/test
$ echo hello > /xxx/test/README
$ df -h
tmpfs            1.0M  4.0K 1020K   1% /xxx/test

The code logic is as follows:

shmem_get_folio_gfp()
    orders =3D shmem_allowable_huge_orders()
    shmem_alloc_and_add_folio(orders) return -ENOSPC;
        shmem_alloc_folio() alloc 2MB
        shmem_inode_acct_blocks()
            percpu_counter_limited_add() goto unacct;
        filemap_remove_folio()
    shmem_alloc_and_add_folio(order =3D 0)


As long as the tmpfs remaining space is too little and the system can =
allocate=20
memory 2MB, the above path will be triggered.=20

[1] =
https://lore.kernel.org/linux-mm/10e7ac6cebe6535c137c064d5c5a235643eebb4a.=
1756888965.git.baolin.wang@linux.alibaba.com/

>> Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
>=20
> No, this doesn't fix anything.
>=20
>> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
>> ---
>>  mm/shmem.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 8c592c6db2a0..b20affd57b23 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1820,6 +1820,7 @@ static unsigned long =
shmem_suitable_orders(struct inode *inode, struct vm_fault
>>     unsigned long orders)
>>  {
>>   struct vm_area_struct *vma =3D vmf ? vmf->vma : NULL;
>> + struct shmem_sb_info *sbinfo =3D SHMEM_SB(inode->i_sb);
>>   pgoff_t aligned_index;
>>   unsigned long pages;
>>   int order;
>> @@ -1835,6 +1836,18 @@ static unsigned long =
shmem_suitable_orders(struct inode *inode, struct vm_fault
>>   while (orders) {
>>   pages =3D 1UL << order;
>>   aligned_index =3D round_down(index, pages);
>> +
>> + /*
>> + * Check whether the remaining space of tmpfs is sufficient for
>> + * allocation. If there is too little space left, try smaller
>> + * large folio.
>> + */
>> + if (sbinfo->max_blocks && percpu_counter_read(&sbinfo->used_blocks)
>> + + pages > sbinfo->max_blocks) {
>> + order =3D next_order(&orders, order);
>> + continue;
>> + }
>> +
>>   /*
>>   * Check for conflict before waiting on a huge allocation.
>>   * Conflict might be that a huge page has just been allocated
>=20


