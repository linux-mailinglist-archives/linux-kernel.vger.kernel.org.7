Return-Path: <linux-kernel+bounces-820322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7392BB7E98A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19B64E64E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AA3331AEC;
	Wed, 17 Sep 2025 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PsyqLuxK"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164DB303C83
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100266; cv=none; b=IlAI8yQ2i9xgBdPeZHU3ADcfcIXdJ9pGSo2F7tAV5xTTahF4IAgMGL3wz1LTTz9jBKGb6Iloy+ro13XJMhsk7ijamK9A6wETVZWLH2ADvUUyUek/TzH7aQ50+RD9JNL1wbi5uEGRM7kkN7mhePRTtXnG+NL3Hg1vukqTObvy+Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100266; c=relaxed/simple;
	bh=gjt22Tjx9sJMfQxmRf/EWaBQbQAM2ueXWWCMYYzcjc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=GmsdnwFTSfA781+I3i8WSJGYq7vmxp9AA1oYrE4SBi3aMeYA2qci2VT3wbcbfOiZurnZcBpg4IYf3SSBCtckfULwK1WdcE43p2BTiLbODv+kHoxkGaDDufSAjrFzaFZ8h7Obm5tieS4V8hqX1oZXYhGFMpPAGuGkAclgt8Goiy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PsyqLuxK; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250917091101epoutp025758b653b42315e9ae639d604f077e09~mBt9mo3gA0479404794epoutp02B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:11:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250917091101epoutp025758b653b42315e9ae639d604f077e09~mBt9mo3gA0479404794epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758100261;
	bh=3Edb4pvx2/Ts1B/oiD+9hX0und9WdB0TpJO96OnueLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PsyqLuxKeNXB5pR8KoBjt3SZgUlH+kEytqwqUwjJtLHm1KFr61YNtK/c+x64y/32l
	 CwH9TqTrS8qagHNr/TuIHvHu3TmY0ijYAiuLabXdNJfp/pj5YWplL/tFV3Uy0O9b0o
	 OaSl6LMZoxMy6d2rEJECGCOCXjwmYmjnUJtXMCew=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250917091100epcas5p3a3d293955384844b04e66b77be2743df~mBt9UaTdP2562625626epcas5p3s;
	Wed, 17 Sep 2025 09:11:00 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cRY0M5Rb1z3hhT7; Wed, 17 Sep
	2025 09:10:59 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250917091039epcas5p1855bfdd913923953d69be9d736685f42~mBtpkbidM0086000860epcas5p1E;
	Wed, 17 Sep 2025 09:10:39 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250917091038epsmtip15b14f85e2937d59d5d8c4f82afed2a64~mBto4FyA31233512335epsmtip1R;
	Wed, 17 Sep 2025 09:10:38 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: yukuai1@huaweicloud.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xue01.he@samsung.com, yukuai3@huawei.com
Subject: Re: [PATCH] block: plug attempts to batch allocate tags multiple
 times
Date: Wed, 17 Sep 2025 09:06:07 +0000
Message-Id: <20250917090607.3366-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <51ad6831-31c9-945b-dc7a-136013f79c14@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250917091039epcas5p1855bfdd913923953d69be9d736685f42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917091039epcas5p1855bfdd913923953d69be9d736685f42
References: <51ad6831-31c9-945b-dc7a-136013f79c14@huaweicloud.com>
	<CGME20250917091039epcas5p1855bfdd913923953d69be9d736685f42@epcas5p1.samsung.com>

On 2025/09/15 10:22 AM, Yu Kuai wrote:
>On 2025/09/12 11:06, Xue He wrote:
>> On 2025/09/03 18:35 PM, Yu Kuai wrote:
>>> On 2025/09/03 16:41 PM, Xue He wrote:
>>>> On 2025/09/02 08:47 AM, Yu Kuai wrote:
>>>>> On 2025/09/01 16:22, Xue He wrote:
>>>> ......
>> 
>> I added a loop structure, it also achieve a good results like before,
>> but I have a question: although the loop will retry tag allocation
>> when the required number of tags is not met, there is a risk of an
>> infinite loop, right? However, I couldn't think of a safer condition
>> to terminate the loop. Do you have any suggestions?
>
>Yes, this is what I have in mind. Why do you think there can be infinite
>loop? We should allcocate at least one tag by blk_mq_get_tags() in each
>loop, or return directly.

Understand your point now. I will send v2 patch.
Thanks,
Xue

