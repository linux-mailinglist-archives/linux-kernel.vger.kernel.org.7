Return-Path: <linux-kernel+bounces-796536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B584CB40228
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735C63AE56F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93372D9EF8;
	Tue,  2 Sep 2025 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="LmzNVuAf"
Received: from outbound.pv.icloud.com (p-west1-cluster5-host7-snip4-10.eps.apple.com [57.103.66.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE34291C13
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818515; cv=none; b=RWS0F/VLRpZYr4dK62Iuf8dHXJ8JjxgO2Zo2qY9c8rqlfhsKZPTbgHtyqlriAhCTLAqKxjnbdjqyQJ73uNVFvWlnVcqvE6PiHovW+teSL5FCMu9SydrqOYJc+YUwonUXhjcW3Vr6lFDnfaDeIkUdcWyHbKbdQb/i/RQMzM2XOVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818515; c=relaxed/simple;
	bh=Nm8cTOXCxO+K0WFESeA4FKh5oH8ZRp9TKdqXdy6v5JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=feQ1uf+k4taU0vOoXKYgqhwxQwZ8p4U0tG16a/cmYinVNA44iPo0dN+SReCUtVc8Ni6b/FawM5enF9vVq3mTcZqIwWzjo/jUWRUEd/n+XQRC4Xj/pfs0TEBHQvGHtLRsavFyQwrOwUZLvGyn3F7OCEzMW+yymYdToAKKGGdn4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=LmzNVuAf; arc=none smtp.client-ip=57.103.66.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPS id 200A11804A6E;
	Tue,  2 Sep 2025 13:08:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=qmuf5k+YBE01wSib01zFO4dVkuTHGNuc2Z27BiU31ek=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=LmzNVuAfzy9F/an+DTnd06e0iiWCMWzMW2/K1TWSJbq9OuPx3DX5ql4FEN3Q5qwc6jvQtwIaLGgh9+6uFF198qZtdOl5GL6Rn+FZxdrLw3EZLSqUWApdvyi6c+zbv8O/Ks/gLJBrK2Pbt7UYGluvrCjIQd8Wweon+oY0Ai7vLS+pGoIJti9C749cy7cTKlbnnRdVC4TJhLvuTSBVHQePonlqO7/plOD4R3mlDPdB3qQiNoH2WLTbb9lI3jHPyRXShiHGBVUBTswt8zhZWKYH8NxJ3vdmsZellIEcskrqi9dujkZYvBQGb/bUu2nTb2C5lRe2CbSdEob/4a42C6NOCQ==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPSA id 1F2B61804854;
	Tue,  2 Sep 2025 13:06:31 +0000 (UTC)
Message-ID: <e9059345-a41e-451e-adac-53fa7519fc5b@icloud.com>
Date: Tue, 2 Sep 2025 21:06:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: auxiliary bus: Optimize auxiliary_match_id()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <zijun.hu@oss.qualcomm.com>
References: <20250902-fix_auxbus-v1-1-9ba6d8aff027@oss.qualcomm.com>
 <2025090222-darn-tweet-739c@gregkh>
 <f01e5ce0-6e23-4d1e-bd3a-b4e18bb3286b@icloud.com>
 <2025090209-unlinked-remedial-555e@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2025090209-unlinked-remedial-555e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EF8gy63yI2rkga_k_mxaYuo6BG_1E2bp
X-Proofpoint-GUID: EF8gy63yI2rkga_k_mxaYuo6BG_1E2bp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDEzMCBTYWx0ZWRfX4r/XpPmaSXmN
 /mTI47XS2WBGREcRMq6H5sitDtM+QV/fBWPoGnWlAtIYjE0btUaStZwtbSCdc5DjWxXRxr2ar8N
 4BqCVMsUERji2dMFZZDDdWGBkdc53s+iZ+BEiG/rmuiu5DVeq4s6XRBBKdQtsX7fwJUXgd/YZMC
 1pCrvUxGlRhxeF1msqbJ4wEMbN20KlL+KXnp0zIjjlqnohfWQPfMWQS/X5vI7VNQnqjA2WcjUwz
 EtI5bP7ZdUXIPjlu42TISdqgK3Qgp+yD2eLpyXTGlCD72tiNYu52IhH4d5DWmrj3InCbqWBXk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=553
 suspectscore=0 mlxscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509020130
X-JNJ: AAAAAAABmp5B7Ydp54WsA5NZVnI/wE38sLbGsh4/khkgb2p2pE9V0G/vlZhB9us8H3LguQFpbVYYuygUOLeskEN4MdXApLCGCaD0QieyJ7yIbYrzTnQ5QW4Dr2W++QEpH82nA0ceQm+6juBrPPdBqi7dYvvjKE1PZX5af6tEzBcw1EXwCLLN5eUb/sJGR9+hMHcc3XIEmwIWw7aEy3xiesyv0ELihdb/QcjslCPnRnAjB3s1YqsRJDZSoB9/F8IZ43fcrHk/mG6/eGFfXcG1ZoOlyJC6CaikZtxdHz1Dxjwo7cD67ZbebzhiVOlQS3FgNkQGNmH3GGjl5FJdlkh7TwPq+HQnAtFDp4L2r9RU5hWpTS1nNJ5b4P6dlUEe8mseGp+88lKVjyOiNxVyibPX0Mu3Db2r2OoWaU9vLQ/RZCqtOGOdqRpUOEWPCwGKiqDT4hZOko9tjN2IONfQ2zMd7TjgU8ndf32yvUc7VIIDFRHAnBUdUHTAu5puBHCpyGQE5ANKo2Qlk9eTdEceE6NtCO6B5JCNn2ANg5vUgie5kGf177Q2DeJ/wquoui6ds9/XZqxDLC0TWrxB2Z3MPzgmrj1omVuzppdF0JnfCdfixwxmybNcrbsPTdAluOak0vvYonHpfX8hzpTdtdtTjmsh1amf9vxAwPfU9PsEBSV6GzhDDhI0JpPJRdE6DhE=

On 2025/9/2 20:51, Greg Kroah-Hartman wrote:
>> auxiliary_match_id() repeatedly calculates variable @match_size in the
>> for loop. however, the variable is fixed actually. so it is enough to
>> calculate the variable once.
>>
>> Optimize it by moving the logic calculating the variable out of the for
>> loop, and it result in:
>>
>> 1) calculate the variable once instead of repeatedly.
>> 2) it will return as early as possible if device name is unexpected,
>> namely, (@p == NULL).
>>
>> so this fix will improve performance.
> This isn't a "performant" path at all, is it?
> 

agree.

the patch is to improve the function's logic a bit.

> I'm not disagreeing that calculating this all the time is a bad idea,
> but please be reasonable.  If it can't be measured, you can't really say
> it will "improve performance" 🙂



