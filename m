Return-Path: <linux-kernel+bounces-796445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5585FB400D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC093BC52E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5523F2877C3;
	Tue,  2 Sep 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="O2alQQC5"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CF28642C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816689; cv=none; b=Lofd1Ie222K79Yz9xxNAPD4IH3ZP+Yz0WIJJ2bzFq6JuF7i9YAG7jbcDTPZUS6aln+/YKbCbfQF9+SFavPulJsltKmRfwrUKzwiwi3jT8pDSdeD27YFt4UmUKhFpWPqSUK8pbch/jJ3aJ96cmTJHUHe4kj7UQcJOk8KyJsVSCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816689; c=relaxed/simple;
	bh=m9kwu89J1pc0NpjS5g2L6XMPeIhbKDj/KyiBWWWGE4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKa1nM0Auq8Za4ZRRVdDKGLw+EjuNo+j3AVApb8k8yY3Qh/JiRWI69tP67LJeoncK9+pW8gOC4ZRU/whDyZiLna77m+SXBYZ30Q+12X6BWXnQHU6sN2t1+y1HKeCXH6CM6kAcpeu8Bdkdg2RWoOl3q8cJpLCVJ6pjQeC88K+qTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=O2alQQC5; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id tP2fuU6Q8SkcftQGvunlLQ; Tue, 02 Sep 2025 12:38:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id tQGsuZ6a9gtDgtQGtuyJ25; Tue, 02 Sep 2025 12:37:59 +0000
X-Authority-Analysis: v=2.4 cv=NrbRc9dJ c=1 sm=1 tr=0 ts=68b6e528
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=XW3vq5T86JFyMsJaYQInbg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=_Wotqz80AAAA:8
 a=vvXS69cEl2kim63T5K4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mwylP/u0Yew4KVxFiy2Py7Is98fs5mA8roFxIyZP6YA=; b=O2alQQC567m+m1+/zLEFFKezsq
	2g/SS+AmPnRruS+NKa1bokWKR2IoQZVAqquN4Q/2RESiQBN14SwGlHBWbjHPxAAiBs72bext2agIp
	GA86zHfeX+adsDmbPXTWoHIsxePAHO38Lqe8G4Wr//huDmdi9sn13YuANEOxweE6maPuPEy36NREN
	TgRcIz4c3nogGpikRQwbtZcRNzAHKDyKW6gl/cGV6g00cKBvP4/puan4VL9wGJQQby4Wa/sZ27VTC
	h8zVEeBEjB9ru74pkFjdBxXX6b2yVXAab47Pb5mTkj5ig7W4WY1yjHCl1UZymSjD6cmbYiabLZNAr
	XpU4TgHw==;
Received: from d4b26982.static.ziggozakelijk.nl ([212.178.105.130]:36200 helo=[172.17.143.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1utQGr-000000034Dg-2bNH;
	Tue, 02 Sep 2025 07:37:58 -0500
Message-ID: <5fb74444-2fbb-476e-b1bf-3f3e279d0ced@embeddedor.com>
Date: Tue, 2 Sep 2025 14:37:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
 <wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
 <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>
 <y7nqc4bwovxmef3r6kd62t45w3xwi2ikxfmjmi2zxhkweezjbi@ytenccffmgql>
 <92912540-23d2-4b18-9002-bac962682caf@embeddedor.com>
 <tl6b6chfawtykzrxlmysn6ev7mq7gm764rnlsag7pfme7vhpof@lbwqooaybqmr>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <tl6b6chfawtykzrxlmysn6ev7mq7gm764rnlsag7pfme7vhpof@lbwqooaybqmr>
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
X-Exim-ID: 1utQGr-000000034Dg-2bNH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: d4b26982.static.ziggozakelijk.nl ([172.17.143.44]) [212.178.105.130]:36200
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLZI/i2AfyBNdixUo1weZzxKaaFOibYeRjjeBcFyFDo45MLSiqy3plRVsmlOfN6ySSWOehHIMxikqg2ZKbmD7/N565joJpdOAcEcGSa+kaCamTb1uahv
 4xAlrRV8ztlSaRxc+GFIZS2u3zzV4P9Yjdw8rSGUVaaJN+9O+QWiqj8hN5iR4Uin19ErGI/5kbRCcl/78UuZzi4Y4UclCsSnJ7HnVtySXAC2K2mA8jRNfe2Q



On 9/2/25 13:17, Michal Koutný wrote:
> On Tue, Sep 02, 2025 at 09:56:34AM +0200, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>> If the increase in size is not a problem, then something like this
>> works fine (unless there is a problem with moving those two members
>> at the end of cgroup_root?):
> 
> Please don't forget to tackle cgroup_root allocators. IIUC, this move
> towards the end shifts the burden to them.

I don't see how placing the TRAILING_OVERLAP() change at the end
of cgroup_root would cause problems in cgroup_create(). I see
this allocation for `struct cgroup *cgrp`:

cgrp = kzalloc(struct_size(cgrp, ancestors, (level + 1)), GFP_KERNEL);

but I don't see why struct cgroup cgrp; and struct cgroup *cgrp_ancestor_storage;
cannot be placed at the end (as long as they're enclosed in TRAILING_OVERLAP()
of course) of cgroup_root. In the end, it seems you're only interested in
having cgrp->ancestors[0] overlap `cgrp_ancestor_storage` so that the latter
points to the start of the FAM in struct cgroup.

> 
> There's only the rcu_head we care about.

Based on this commit a7fb0423c201 ("cgroup: Move rcu_head up near the
top of cgroup_root"), as long as rcu_head is not after struct cgroup,
all's fine.

However, this tells me that people were aware of the possibility of
`cgrp.ancestors[]` growing even beyond `cgrp_ancestor_storage`, which
is yet another reason not to have that flex array in the middle of
cgroup_root.

> 
> (You seem to be well versed with flex arrays, I was wondering if
> something like this could be rearranged to make it work (assuming the
> union is at the end of its containers):
> 
> 	union {
> 		struct cgroup *ancestors[];
> 		struct {
> 			struct cgroup *_root_ancestor;
> 			struct cgroup *_low_ancestors[];
> 		};
> 	};
> )

Yep, that works (as long as it's always at the very end of any container
or ends last in any nested structs, for instance in struct cgroup_root,
it must also be at the end) for GCC-15+, but for older versions of GCC we
have to use the DECLARE_FLEX_ARRAY() helper as below:

         union {
                 /* All ancestors including self */
                 DECLARE_FLEX_ARRAY(struct cgroup *, ancestors);
                 struct {
                         struct cgroup *_root_ancestor;
                         struct cgroup *_low_ancestors[];
                 };
         };

Thanks
-Gustavo

