Return-Path: <linux-kernel+bounces-896414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D486C504EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E78AD4E6033
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2B298CD7;
	Wed, 12 Nov 2025 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K7RVjU+L"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049A35CBA1;
	Wed, 12 Nov 2025 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762913424; cv=none; b=DQSjdDE50KPsawPVxGTYXjE7SzL4lg70j9/ZZwQpo6jiO2RhOyrq6yAG/ByQSTmYAg1cBf1T5HhX1cyCCUAaExa6caDWni71uBtwTufhiDWTdlBmakB0V7QlVAGRyJKzaKoJkrL1JRAwJ8LyrywmDpRrE8o6D3JbG56c+TPXmTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762913424; c=relaxed/simple;
	bh=BvUb/yaofmO3fmkC1lDAB8q3pcGVZHADxRwUljCieeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=q499QerdbZGMmwcQsYUeizmh10XwQtgkEzpXkVoN54kga3JkPZucaLuDh10xzYmPysY3IagpOnX0+28lWdZJeH/o2SPCoxZq1tZHYd9sqi09Tz8sQVsGahCwbpzhuMfW4hrK3XY59bD1Ppt3SyQ2HOXuBkS+2J5DyiooM0PXVzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K7RVjU+L; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=Cj0tiv1YrXlK1Am
	HXUGCqMa9Ip8rNuXArJeCHSLI0LM=; b=K7RVjU+LkWNo734KPekTzcIup2abS5U
	q7iy/NQqXm7T9DjBgFPcduxpJjkZpb1b4/o1Iq0YGdjg9axK1HtDzcSdPkTjVzT0
	7lOQwVgWH8kQu39ESUjO4zw987sDpFte+BwxWub+x8nQgqMGpkXm/IXZOjLeriav
	/amk9Snz2Kw8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBXD0xd7BNptMyYDg--.29307S2;
	Wed, 12 Nov 2025 10:09:35 +0800 (CST)
From: Wenliang Yan <wenliang202407@163.com>
To: krzk@kernel.org
Cc: christophe.jaillet@wanadoo.fr,
	conor+dt@kernel.org,
	corbet@lwn.net,
	devicetree@vger.kernel.org,
	jdelvare@suse.com,
	krzk+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	robh@kernel.org,
	wenliang202407@163.com
Subject: Re: [PATCH 1/8] dt-binding:ti,ina3221:Add SQ52210
Date: Tue, 11 Nov 2025 21:09:21 -0500
Message-Id: <20251112020921.104041-1-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2bc7a6ed-582d-41a4-a6a7-36f24165519c@kernel.org>
References: <2bc7a6ed-582d-41a4-a6a7-36f24165519c@kernel.org>
X-CM-TRANSID:QCgvCgBXD0xd7BNptMyYDg--.29307S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFy5GFyxWw18Ww15Jw15CFg_yoW5Xr1fpF
	Z2yFs8tF4xtF1fX3yI9F4kCr1rAw4Iya17KF1DGrWIgan8Gr90qrZ3Kw1q9F9xXrZ3WFW2
	qa4Igr1F9w1jyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JjfTmDUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/xtbCvwByRmkT7GAyggAA3N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

At 2025-11-11 16:17:26, "Krzysztof Kozlowski" <krzk@kernel.org> wrote:
>On 11/11/2025 09:05, Wenliang Yan wrote:
>> Add a compatible string for sq52210, sq52210 is forward compatible
>> with INA3221 and add alert register to implement four additional
>> alert function.
>> 
>> Signed-off-by: Wenliang Yan <wenliang202407@163.com>
>
>
>Please use subject prefixes matching the subsystem. You can get them for
>example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>your patch is touching. For bindings, the preferred subjects are
>explained here:
>https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>
>It is never "dt-binding:". Also, all spaces are gone. Just look at `git
>log`.
>

I will change the subject to "dt-bindings: hwmon: ti,ina3221: Add SQ52210" before the next submission.

>
>> ---
>>  .../devicetree/bindings/hwmon/ti,ina3221.yaml    | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml
>> index 5f10f1207d69..0fae82ca3ee1 100644
>> --- a/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml
>> @@ -12,7 +12,9 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    const: ti,ina3221
>> +    enum:
>> +      - silergy,sq52210
>> +      - ti,ina3221
>>  
>>    reg:
>>      maxItems: 1
>> @@ -77,6 +79,18 @@ patternProperties:
>>            exclude specific channels from the summation control function.
>>          type: boolean
>>  
>> +      alert-type:
>
>Not a generic property, missing type and vendor prefix.
>
>This clearly was not tested.
>
>
>> +        description: |
>> +          The SQ52210 features a configurable alert function with four
>> +          types: SUL, BOL, BUL, and POL. Each channel can be configured to
>> +          select one of these types to enable the alert function. This alert
>> +          function can operate concurrently with both Critical and Warning
>> +          functions.
>> +
>> +          The configuration must use numerical values 0 through 3,
>
>
>Don't repeat constraints in free form text.
>
>> +          0 corresponds to SUL, 1 to BOL, 2 to BUL, and 3 to POL.
>> +        enum: [ 0, 1, 2, 3 ]
>
>No, use string enum instead.
>
>Anyway, does not look like DT property. Why would alert type be set per
>board? Why I cannot change the alert during runtime?
>
>

You are right, my previous consideration was problematic. Indeed, there is
no need to set the alert type at the board level. I will modify this
content and test it before the next submission.


Thanks,
Wenlaing Yan


