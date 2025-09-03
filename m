Return-Path: <linux-kernel+bounces-798040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA63FB418B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029DE3B6125
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFCC2E7BBD;
	Wed,  3 Sep 2025 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XDiO88T6"
Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA734EEC0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888600; cv=none; b=DX5nZuA15yYPuUP5JA47Lu9idhPzEiqzUIa+AKWW74ODSTMXarR0GwBdmKkwmn4tgxHMKxMZL0knk1TB8ir49zC5qN5GDwBmomXcT3rheP4tq9nNEH+iauzf7E/DXg/MFWgWvqCMP5Mt4Vuj2gbPQUZH8153IVAPVaP/+YU3ks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888600; c=relaxed/simple;
	bh=pfIOD2wihPkmDIOdlvguOBiN3hgM5Ymq26fkf8+/mLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8Jvxi+rk55Els7cZZ9o0wzqj0ygSeHLwn56si21B9Y9+blDZbEEbBSyORQ4inY+/SMTxjE7SoiESoLsOOsFGpb63he2OPdAGXkQbkX+8QxpJEs5nXDnXWR9fs0D931bFRV2IO3HtoKGIRt8pJrX6vlFZLAZRVyVxT/H0ryDVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=XDiO88T6; arc=none smtp.client-ip=44.202.169.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id tcjtu2MqFU1JTtiykuz5H8; Wed, 03 Sep 2025 08:36:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id tiyjuaYRMIWYdtiyjuLWKv; Wed, 03 Sep 2025 08:36:29 +0000
X-Authority-Analysis: v=2.4 cv=SYb3duRu c=1 sm=1 tr=0 ts=68b7fe0d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=XW3vq5T86JFyMsJaYQInbg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=uY_jprAYB3ThRRmUuAoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xPOvRU10uK9ZVSCWCMReoRW7p5xBpgAQIHli3Z6J08M=; b=XDiO88T6B7hHpfDmMmWr7MKhOE
	/MJnEp8lWWDtzo9SXZ3rnysLZEAvqJkBXJZtB1hwpQ482HK9zxz7EqrtC0nmW9gv62piAsCrMDHHI
	dcLIlcnCfDC0pkD2S0tLKLaD3/hht+1pFoNbNnFCnOLPoy09zm3kvDBdMRZji4saGMLCthitVTTyf
	+JJtmLWQOzMixD8flw6YCp50vzNcKssfm7KfY1iBqTEM2Hy/NyQhk47km2cy5H7i8iNN19Zic3ylR
	zyOSEFfkdIFLEbloKZDFcaGk7Loz/f7N15PkOFByYOup990A/WKRCADmU0cOErAAnzLL1FHc1x7MQ
	jZ+uJtKg==;
Received: from d4b26982.static.ziggozakelijk.nl ([212.178.105.130]:50240 helo=[172.17.143.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1utiyi-000000047SS-2QJT;
	Wed, 03 Sep 2025 03:36:28 -0500
Message-ID: <3f7338c4-1737-4cf7-a789-252abe30bdc6@embeddedor.com>
Date: Wed, 3 Sep 2025 10:36:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/amdgpu/amdkfd: Avoid a couple hundred
 -Wflex-array-member-not-at-end warnings
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aLF5vQv9P_vp0R6_@kspp>
 <7a25b5ae-b995-431b-bd46-6d2d58d18e36@amd.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <7a25b5ae-b995-431b-bd46-6d2d58d18e36@amd.com>
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
X-Exim-ID: 1utiyi-000000047SS-2QJT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: d4b26982.static.ziggozakelijk.nl ([172.17.143.44]) [212.178.105.130]:50240
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGVjLQDReYQDnCav97kBtbb6Q9VltOBy6Dl1qoJ5jRi7eh9L5oQY09QXv8ZvZRUgMspUvIoEbgokuvpxzzmF53XvruVgpJMgfGERzWPI7hisC/8ahZzc
 2EqFKb4qPyNGI5QHG3U4r2TUyY78+h0HcuoQvxfqRmHydunbxd+ZM7NyVGfoG9kQKCOYrO44d2PFHydz0FkV4eQu2bp53PRU3EkQVSlALQe7he4TWus/4s5/



On 9/2/25 17:11, Kuehling, Felix wrote:
> On 2025-08-29 5:58 a.m., Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declarations to the end of the corresponding
>> structures. Notice that `struct dev_pagemap` is a flexible structure,
>> this is a structure that contains a flexible-array member.
>>
>> Fix 283 of the following type of warnings:
>>      283 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h:111:28: warning: structure containing a flexible array member is not at the end of another structure [- 
>> Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thank you. I'll apply this to amd-staging-drm-next. I'll also add a note to the commit description that struct dev_pagemap always has space for at least one 
> range, and that amdgpu only uses a single range. Therefore no changes are needed in the way struct amdgpu_device is allocated.

Yep, that's correct. Thank you! :)

-Gustavo

