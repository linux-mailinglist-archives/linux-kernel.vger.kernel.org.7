Return-Path: <linux-kernel+bounces-799527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB6DB42D27
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9FD547A39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191122F067C;
	Wed,  3 Sep 2025 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="SGpjuu96"
Received: from outbound.pv.icloud.com (p-west1-cluster5-host4-snip4-2.eps.apple.com [57.103.66.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452FB2DECBF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940458; cv=none; b=IM11czNDfkLNlwSIshfruKNW9b0bCm3FQEpz8k08Nrb5dnz4ZbgeiEU9YNBTMKLFAqsV9ogSTd1e3Haon1wZlglZ22/quGls82Rv6F1Nx3JOwKOu0MFBV7DvGzRmbJdotF3DBoCkvK+1s92gvTuuErvj0vmW230LtvOHxJ4wHTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940458; c=relaxed/simple;
	bh=wKjgaGIahm8Nu3Q0j5IcCHgZVe322ITNmY22KqK/aKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3Lt2y6pjwNurK5AjOnGXutSUKqlfhBxW4y6s+REvzWyvzq7TnKuRdLjvqddByj0mJd7wlpsGOONM2aThkQLN6sfpFw4o8S6fyfkQG7XmLc6oyVzaBi77qehpU9JveNYBrQ6a9VfiAExvwrSTr467F5hhW07O3Un4Li+2BFZMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=SGpjuu96; arc=none smtp.client-ip=57.103.66.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-4 (Postfix) with ESMTPS id BC0381800854;
	Wed,  3 Sep 2025 23:00:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=RIEMBGFqAJTSJFCscSidZV8AXdVdousdMXyceLoHi4I=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=SGpjuu96QN2DbAZcaVW7g1asSKzeOIGSB9LdrGZX0NeESWQyVL2JZsO+m+jOvkxCRyLpDdKeFYkogIERGnBRXIaGbyMJRiDRkUL1xgtQRAFiKQ9bbabMk/X4G25ginv0r+H4SjUfzk9i+UerK8IzUuXVXf16IqcXWLEQ6MxEJ2wyvZMIEbbS2uCn6o5XF+Z3uw2ASs0/sRkxG3uEC9Y4wsYZrfcUMQxmaMmG3ehwcmkwOC8MwJvt9RLOwYRHwexexzzyzQUg69iZfSK60sI/uyEeZOuKKhMsDe7EtA0VnKBqMeY8Pq+G2TJFQ7NaGyY5wh5Pn7/UcNVlgiccZRUUIg==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-4 (Postfix) with ESMTPSA id 0D9BA18006CE;
	Wed,  3 Sep 2025 23:00:40 +0000 (UTC)
Message-ID: <2159c5bf-1ce3-4fd7-81e3-f458efca8548@icloud.com>
Date: Thu, 4 Sep 2025 07:00:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver core: auxiliary bus: Optimize logic of
 auxiliary_match_id()
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
References: <20250903-fix_auxbus-v2-1-3eae8374fd65@oss.qualcomm.com>
 <DCJ52UB7OIXR.3MS54RJKMI4OK@kernel.org>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <DCJ52UB7OIXR.3MS54RJKMI4OK@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDIzMSBTYWx0ZWRfX4WnGxWooHHe7
 WzAqdzW8OTnlW3tlfdHOTZtei+g7ifrGN0qim+k5rvMBbLiOoBW7PNZI9tYaFcqyDDZ7mGF3j2r
 Ys5OqxzfChZVJ/02jI4/cnaU1oD4eYbGoNRP9hqgfFi6ZwDhkNwKxc8IMSNYeFOhtLU7F+PsSor
 FcsWLSmmeViE8znTHNIE0C9PQGPvB9Yg30QeNpE84VxB0iD9/5RHJYRga4FQL4WAjyKbC4LPe4Y
 aMJT8Jsymv6SNzDYmSC1INgEi9sIC1Uruc52l5oU1/KnbQOOcCTC9Wy2S8N0qEzFuP78oYIWA=
X-Proofpoint-GUID: XN-z23dYez6JWc5IrAEIdBE-FozgIovA
X-Proofpoint-ORIG-GUID: XN-z23dYez6JWc5IrAEIdBE-FozgIovA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_11,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=712
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509030231
X-JNJ: AAAAAAABdEZX7bLmszf3PjqXrtMqjigviGfgMi25Uwv2r3oW0Uj3S2qGrfXIxJmJXNnWgsR7OnhK91LTNKkL1wlndj2ZS+tNSc4CQ6LkrRWQ0pPEk+wpLNoZiXl0qpeHo6pdI0VzYBaysnROTkuEwoRM/sXnFjayo3ux+YSq6EuTksh1R5VPQSrEbRFC7tHJFNi2yiOUwu+abtEh4ZZq9rNfdc8tUUiIHVrpe9g+srMOodlYZHRATR3txn3W82j4Qpq6Wd9D+OjWeaGq/xdCQQBKfmFIyafB+uL6RGuy/Aqm4eQYocRL8+7a/2Hszr4WpLLP+D052h2GQOVO9SjOYmtfNQW3nJ6raKum/WTmn+XJj/MHKEHNm3kjTb1cWlS7n6tVDJPknfIxMC0ay9ScuslfhzgHXW0mXPeNCKtru5/jd7MipNpI99YHr4UIbDwXkHM3YPGitor4r9Mgtp2ZyG+loXUdk+NcgcmgAtba4EQOG1iFqhQjmMqjF5rS026/ED5MNBDkyGYTDKDpBMhBw0LmasjqM9l+QhxliK9EYuamB7VlftfJQNOArXWN7hI5nbRC5OI2QgQgS8cpjOFd7hcCJ6DNAXro7Nwt3OT5tTHLcI2bLd4hB2NIisZam6Vn+AZq6uUBaGG8FpXW2WKa6JS2ghUy9oXW0ibfkB7vvkTZTLeK40JwOlXDxqWE6DOywz4JgRvPYXBRuCU7

On 2025/9/3 19:46, Danilo Krummrich wrote:
>>  static const struct auxiliary_device_id *auxiliary_match_id(const struct auxiliary_device_id *id,
>>  							    const struct auxiliary_device *auxdev)
>>  {
>> -	for (; id->name[0]; id++) {
>> -		const char *p = strrchr(dev_name(&auxdev->dev), '.');
>> -		int match_size;
>> +	const char *auxdev_name = dev_name(&auxdev->dev);
> I feel like this is a bit too ambitious. Using dev_name() directly for the calls
> below seems more obvious to me.
> 

dev_name(&auxdev->dev) which is a inline function appears 3 times in the
for loop. may be worthy of a new variable


> Yes, dev_name() contains a branch, but I'm pretty sure the compiler optimizes
> them away for subsequent calls anyways.

From debugging perspective:
more difficult to debug if more the compiler optimizes.




