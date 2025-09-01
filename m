Return-Path: <linux-kernel+bounces-794003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF67B3DB5A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226707A5A86
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6592D8367;
	Mon,  1 Sep 2025 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="jhFaYZ/B"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82E2D7DC9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712686; cv=none; b=PXhTHoZZJu65se20wGkhE8oC2F3GH7Xao4aHcxDx05lHR/1sf5W7MZBYkvrpf4/Kj2ALP7bCHhYplUXvmBFUHsK/pHRED7Ksu8nO4N9csp0xbfOkRvr8BdzVxJCZuT3P9/6lgPCh3UZQuFD1koDFF5joOWg6rLL7MQLvUOlGD7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712686; c=relaxed/simple;
	bh=h5ASbpq7GzquVrjE5v2oPRk1/yndZJRiGIfLCAbjbYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1eRDjKuy3LJFpQfY1CLqKjsR0iUr0SpqL3l7GcGfp3lOQb8wqQhOlAzgn1UA8Ez963vTs2hjGsmwoackqnrsxRQBC8wUaT5P+TAhzZIj7xItIdS/017heQ3cQQqo4J2R5KRPDRirr+JkpNnSqoz+vordpweLoww4qFKfghRFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=jhFaYZ/B; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id saAeuSDHbLIlMszDSuH7yM; Mon, 01 Sep 2025 07:44:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id szDQulHR5rnsYszDRuZbNz; Mon, 01 Sep 2025 07:44:37 +0000
X-Authority-Analysis: v=2.4 cv=OLkn3TaB c=1 sm=1 tr=0 ts=68b54ee5
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=XW3vq5T86JFyMsJaYQInbg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10
 a=H2_X3B96ix6R1hjB0M0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VyVL0CUniS3Y2QcF3TIAZDEVTr4tMopQSoLyF8TxjVA=; b=jhFaYZ/B3nqWPBto84JnjMHrrD
	RSxjYE09m9V3eG3ONgJKzM4xaeMcD43WOFMsiyOxwurcfjal+ewG/4ys/VQAy4u5jWCuTH3jJgGLv
	7Yk0PSa2sVFGDpmP8vDc3E3I9MFETMkZILOBTsNtLWtiEYDhc2/RJzCU246gsbwxPf3R0Fn7J4jpw
	5910CxHkM8ndH8TJGeIusrQJ+TuW3YjrmKXUalWybgkykEFnnMlsnbp5qzIXPUyJhRzZZql3TVNVK
	EIeN7yMj1EdLL4GZ0Ng108GvnLfHainljVWIDjGpDOuv+7Tv9oVhfG40QLh7jD7I/GSup2V/hXcrO
	NKJfen6w==;
Received: from d4b26982.static.ziggozakelijk.nl ([212.178.105.130]:58286 helo=[10.233.40.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uszDQ-000000043fh-0wKn;
	Mon, 01 Sep 2025 02:44:36 -0500
Message-ID: <65a443d1-be01-4e5b-9086-b4ce2746ab63@embeddedor.com>
Date: Mon, 1 Sep 2025 09:44:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
 <9da518ad-9b44-4dbb-98e5-66cf8a3fe7c2@huaweicloud.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <9da518ad-9b44-4dbb-98e5-66cf8a3fe7c2@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 212.178.105.130
X-Source-L: No
X-Exim-ID: 1uszDQ-000000043fh-0wKn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: d4b26982.static.ziggozakelijk.nl ([10.233.40.44]) [212.178.105.130]:58286
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMkt+ilUtmZ8XdJD/0Qyoy7P2BcGIIEEggQIF5dQkMshOJvGZ605ZD8DdGEftqGEDktyro5bRISOpYHGdAviQ3mqr3a783k/y/6H96jzNHoWqSr6C7Fe
 cUClLGl6IRRK1vVbl7mZSou21wy5R/ZnGm9Fc44GrIHhvjvUWHiFSSaWcjlw8uf+iT5LHCg4U3Wxwi0pug/aw4ENmavpnJ5rWq6vyySBswcOipiXN2hYt05s



On 9/1/25 03:29, Chen Ridong wrote:
> 
> 
> On 2025/8/30 21:30, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> I'm working on enabling -Wflex-array-member-not-at-end in mainline, and
>> I ran into thousands (yes, 14722 to be precise) of these warnings caused
>> by an instance of `struct cgroup` in the middle of `struct cgroup_root`.
>> See below:
>>
>> 620 struct cgroup_root {
>>      ...
>> 633         /*
>> 634          * The root cgroup. The containing cgroup_root will be destroyed on its
>> 635          * release. cgrp->ancestors[0] will be used overflowing into the
>> 636          * following field. cgrp_ancestor_storage must immediately follow.
>> 637          */
>> 638         struct cgroup cgrp;
>> 639
>> 640         /* must follow cgrp for cgrp->ancestors[0], see above */
>> 641         struct cgroup *cgrp_ancestor_storage;
>>      ...
>> };
>>
>> Based on the comments above, it seems that the original code was expecting
>> cgrp->ancestors[0] and cgrp_ancestor_storage to share the same addres in
>> memory.
>>
>> However when I take a look at the pahole output, I see that these two members
>> are actually misaligned by 56 bytes. See below:
>>
>> struct cgroup_root {
>>      ...
>>
>>      /* --- cacheline 1 boundary (64 bytes) --- */
>>      struct cgroup              cgrp __attribute__((__aligned__(64))); /*    64  2112 */
>>
>>      /* XXX last struct has 56 bytes of padding */
>>
>>      /* --- cacheline 34 boundary (2176 bytes) --- */
>>      struct cgroup *            cgrp_ancestor_storage; /*  2176     8 */
>>
>>      ...
>>
>>      /* size: 6400, cachelines: 100, members: 11 */
>>      /* sum members: 6336, holes: 1, sum holes: 16 */
>>      /* padding: 48 */
>>      /* paddings: 1, sum paddings: 56 */
>>      /* forced alignments: 1, forced holes: 1, sum forced holes: 16 */
>> } __attribute__((__aligned__(64)));
>>
>> This is due to the fact that struct cgroup have some tailing padding after
>> flexible-array member `ancestors` due to alignment to 64 bytes, see below:
>>
>> struct cgroup {
>>      ...
>>
>>      struct cgroup *            ancestors[];          /*  2056     0 */
>>
> 
> Instead of using a flexible array member, could we convert this to a pointer and handle the memory
> allocation explicitly?
> 

Yep, that's always an option. However, I also wanted to see what people
think about the current misalignment between cgrp->ancestors[0] and
cgrp_ancestor_storage I describe above.

And if the heap allocation is an acceptable solution in this case, I'm
happy to go that route.

Thanks
-Gustavo


