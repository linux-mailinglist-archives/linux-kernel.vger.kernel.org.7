Return-Path: <linux-kernel+bounces-772575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35862B2945D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 19:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94361B26A28
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FE029A303;
	Sun, 17 Aug 2025 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OzRiKYc+"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA86533D6
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755450454; cv=none; b=F6I+OmPmLvHfyZgE96ojMITeuSbc83QNnhHvUNtsec7syvA2PozIV5uFwfTy8xuJRbycaKSRkzZ7dmN25MQtHd+LCj0BGFTiytuOHr/9I5kXZ1802SZmjHCYoBk1De3+6edv2ufzYhKMnv12cRf7sTL0GGM5gBBpNX0JpFp2L9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755450454; c=relaxed/simple;
	bh=TjmdM7VZUJ9ChZjVmrXtQHHjV82KuR9eXiFAuFfZCpI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VjioK4+ki3aEYsohGKLT/NB8gKgjRRGORlx4IkAnR2AldOrByDIFXnQfNd6aZTMVyoUQj+1UAfGrXzdRmHnWjx2uKjmSZxfDrF+KOPBQu6Hc7YYHTX/U+kNV3n3WQpApeFMGEdTLLdUwH227vu/hQ0DSt0pVfIpBWdNFa0KQNx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=OzRiKYc+; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57HH6cwl1326504
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 17 Aug 2025 10:06:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57HH6cwl1326504
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1755450400;
	bh=o4v7X/3ppp2A7Bxl/JAZk096aHONti82Pol+6ge5JrU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=OzRiKYc+BZB3d/SuL+TRMgJfRuY1Fa8xNNhWwOWVdInDt2/Ciu9XjBqQlOWvMvxeb
	 ogGzMym+AFRwWAWORQan4XRifCdmUG/+rNXf8UpJZEgY5zs5rKN3lnz1SkGjhZDEFe
	 GqLf9m9xyHGq54iYvhVyd3Tz0NNHEteVQ7aNiepaePuHthYQ50FfgpxFabafOPddt/
	 fdfq9QyCorCIDImitZuvGXaVWNiFk5C0WzoD5ek/9dCa/fP9NFIoxshCD1L9yKXHmj
	 DU7BW/kHpVVaTyviRWnlYwY69h57r7WstdENe48kwrQ9he2pfLTU/gSi7BOBvrhZ1R
	 UvwEy9mRUAp+w==
Date: Sun, 17 Aug 2025 10:06:38 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <david.laight.linux@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
CC: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Li RongQing <lirongqing@baidu.com>, Yu Kuai <yukuai3@huawei.com>,
        Khazhismel Kumykov <khazhy@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_2/2=5D_blk-throttle=3A_kill_the_no_longer?=
 =?US-ASCII?Q?_needed_overflow_check_in_calculate=5Fbytes=5Fallowed=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250817135013.7567dd13@pumpkin>
References: <20250815164009.GA11676@redhat.com> <20250815164102.GA13658@redhat.com> <20250817135013.7567dd13@pumpkin>
Message-ID: <FD649A73-0E0B-4518-9A27-B65DD583C99F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 17, 2025 5:50:13 AM PDT, David Laight <david=2Elaight=2Elinux@gma=
il=2Ecom> wrote:
>On Fri, 15 Aug 2025 18:41:02 +0200
>Oleg Nesterov <oleg@redhat=2Ecom> wrote:
>
>> Now that mul_u64_u64_div_u64() can't crash there is no need to check fo=
r
>> possible overflow in calculate_bytes_allowed()=2E
>>=20
>> Signed-off-by: Oleg Nesterov <oleg@redhat=2Ecom>
>> ---
>>  block/blk-throttle=2Ec | 6 ------
>>  1 file changed, 6 deletions(-)
>>=20
>> diff --git a/block/blk-throttle=2Ec b/block/blk-throttle=2Ec
>> index 397b6a410f9e=2E=2E66339e22cc85 100644
>> --- a/block/blk-throttle=2Ec
>> +++ b/block/blk-throttle=2Ec
>> @@ -601,12 +601,6 @@ static unsigned int calculate_io_allowed(u32 iops_=
limit,
>> =20
>>  static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_=
elapsed)
>>  {
>> -	/*
>> -	 * Can result be wider than 64 bits?
>> -	 * We check against 62, not 64, due to ilog2 truncation=2E
>> -	 */
>> -	if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
>> -		return U64_MAX;
>>  	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
>
>Not directly related, but the two (u64) casts are pointless and can be re=
moved=2E
>
>	David
>
>>  }
>> =20
>

It's also rather broken, because a division with a constant can be impleme=
nted as a multiply, and both gcc and clang knows how to do that=2E

