Return-Path: <linux-kernel+bounces-796461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A31B400FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953C72C2D49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F5299AAF;
	Tue,  2 Sep 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="MVSLdo3g"
Received: from outbound.pv.icloud.com (p-west1-cluster1-host3-snip4-3.eps.apple.com [57.103.64.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480031891AB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816953; cv=none; b=trfuW3RAGGIhkOuunBOJ3IRwAKcdPN0PPC85+Y2rNzNpZ29A6P9MGE3TFkE05ROPE2ZMV9fp7R0YiaADwqtWY8a1rp2+CR+eWrf7cnKqf5gzZV4NLOJ7TArwgoFN28Zo7Bjyq7s7ys5xVqrMLRH69G3J94eu0oI/N1bJ2YDR+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816953; c=relaxed/simple;
	bh=ILe9iWDBFuHj1sbadvPfAY3NTilq84Cyh/HcQW9chLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K//7Mo4/vM4Uv5MOaOVLY5aKD+5oyqHwRoz7N+sK0/0lnRZxebU7dFuG/uyCwNPh7p3ULcNaxIBxFInXet1Rf+eYwYiz1TbTt0iQpEOISHXdGEthcwfj6t4/C4juz2nqB5S8Y1tJD0wAYWLXtG+c7gwNKPAV87D0v84JwsTvNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=MVSLdo3g; arc=none smtp.client-ip=57.103.64.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id 6D60E18001E2;
	Tue,  2 Sep 2025 12:42:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=Das5IgdkvRTZFfE7LQPzGUERgZCifvmunbRtbYDrPp4=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=MVSLdo3gcBEZaNZFnBswWmlXnjluphYvW7SwH+9tzfq+fghc4PsB00WWiQj1G5Y34N4iF5ymSd3D9ENQCIOl36QFwNQUoXCRhqTIwqLNtwNWBAa5QWYhRYJSf/M99XQN/dlpntfyIKjbbUH4JdRZIJon5f1DZGLA1Rtt71Gmuye0Jzj4MbwPv4JpBkYN1RBq3Qw62eqlu+8SGM21Qu42vKBpL8lMUEs0E4COaLk84S00KgqUXMlthiwix17WGS6Sg8O5V6lLhnZ9twZMTW7iTRyNrOE5Y1gjQ5GY9EMLZtUgeOagsZkoZSGElRACWuugQC8cyRxMQ3iaGeGaY53bTQ==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id 1B2F618001D0;
	Tue,  2 Sep 2025 12:42:27 +0000 (UTC)
Message-ID: <f01e5ce0-6e23-4d1e-bd3a-b4e18bb3286b@icloud.com>
Date: Tue, 2 Sep 2025 20:42:24 +0800
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
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2025090222-darn-tweet-739c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDEyNSBTYWx0ZWRfX7hdI1x2rkGYS
 M82TGV0jFSuCJ1QbYWSa5fDe+hPy0wCWZXtKLXXgVaTGrjBRL6YxTkymbBkGnjoa1XaITfJ2sCA
 kLqXlF0ObhQnd5eMjWurrxtwhE0wUrBGmKpb9bA3dGbBcBRnSXMmomm8xLH7Qh30meZw0WWNFcC
 OGy3lhyjqISYhnWgkAqEVimyaya5m9L44A0CRlH7hmDcSjrLEZL3PQHPLkOgflWwXeNnWX9BYR/
 85Z9IaMvcsPHkLKWfjoj2jBSirMLw/NUNhCBxdaV1BclxHGdzTI6csfobCqqMWDTh4LCT5pXg=
X-Proofpoint-ORIG-GUID: xRpurUwKO-PrIVrHbuqS4vDxpf9Smjyw
X-Proofpoint-GUID: xRpurUwKO-PrIVrHbuqS4vDxpf9Smjyw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=753 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509020125
X-JNJ: AAAAAAABDHrZ+4j5gEYLim2+FHnPWaUY0m4hn7LfUGk+Rt8jvQjW/rIEP9vaxzL9KhQjL2Mb/GeLqxydFTe2pn2vK01v3BntoQOf+Ov7Nu3jfw6hJPzjrbSxx4naq1Jjqsam9E2G62lRPGn016li1/pbLlcYFVieed26x3wMiy5h98TsazpvosQe8AjV1tVabgViOs82zF7uL1d+33bJjH9BCxaK1ksr7dWoowSKaak3fYdtWRz+1wIRyD5+7xkH6MBGb9IlnRIvQj2Gf+U3cLwnUR+SDwsIDWgKTDL/pIr1W7/MLaskQUQe1eTIQKancWPHHucAQh0nE8yAjEfHERdAXc2tDA9MP2Hljfd2kk/WJaAHwtP54xxGTBNWcYoue2dLWQtBF5QQfyJDr1mSL9UnZwoSkMf3xaMnAhxWA7+xwxm/TijnlqeQWT8Or3sm9hcDsCo5EIUP4SNqQLHoYt4F4mQ43d5Kj9OSqzkAUqV9/OJU5owus6EkSRYVfqczrCm0R8YmifrTYbH1RUWsDwF5I2nbJU/I83M3rkpzBm7ADOjmI0yaxAiwa/Wr/XvLuDoImuchT+CiBWZkNMgG3WLVtoEnnWIP/vg63MjfGPLQOBPjHkpIN/vUkkNNTWdcD69f6GwVR5yvdRcoQyNPQg5lZKw/x412SXClSx0evSSFLnijQWt6hW8VlZ1jNHf4qlQucekf0IEpu/9Scgcz4lLvHOZQs9GY5E6TUR9Y4rc=

On 2025/9/2 20:20, Greg Kroah-Hartman wrote:
> On Tue, Sep 02, 2025 at 08:05:32PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <zijun.hu@oss.qualcomm.com>
>>
>> Variable @match_size is fixed in auxiliary_match_id().
>>
>> Optimize the function by moving the logic calculating the variable
>> out of the for loop.
> Optimize it how?  Does this actually result in a difference somehow, if
> so, what?
> 

auxiliary_match_id() repeatedly calculates variable @match_size in the
for loop. however, the variable is fixed actually. so it is enough to
calculate the variable once.

Optimize it by moving the logic calculating the variable out of the for
loop, and it result in:

1) calculate the variable once instead of repeatedly.
2) it will return as early as possible if device name is unexpected,
namely, (@p == NULL).

so this fix will improve performance.

> Please be specific.

will give more commit message in v2.

thanks

