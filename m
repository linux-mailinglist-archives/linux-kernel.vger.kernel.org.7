Return-Path: <linux-kernel+bounces-873424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8183C13E70
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F12A465B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A7284B58;
	Tue, 28 Oct 2025 09:46:02 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0591E49F;
	Tue, 28 Oct 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644762; cv=none; b=cS8xzwpK8luYzy6yBVKAy2spNplaDTsJZnD4ItSJJ/hhrU8csRZ9RyxojKuMHSVRCBDL8O2FZ5VVDlqFA38EUVFEbaD62ou6UAsqJEnapVTXwcX38449nUH9DfZmCKYe2mgGvqQ5OZ5fJNWaNkYss89BkdOYQlyXEWEtCsGwA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644762; c=relaxed/simple;
	bh=OeBemUa7PV+8jvCNGHnSvP/OLM4r6o4ThqLdCCcUufw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2uBJNtg0h/5USkpkckc6jykUlo2lhl/+Y6UfnosRHuNGV+a5YzjG0fqol4Se0pw0KFNy64vx3guE6WHGRompBWy2FNiyT74OKXGt/Z61chP2L1hLL75Ma7EAJMwGksqyEXRc4Ajh6S/L9dTHPctet+zJJnPjfaSwezJ5h3MUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1761644696t6badc7b6
X-QQ-Originating-IP: OiWb3yCwJkW93ilCz0aFHt4DXFMWxYcD3+vm7HIDNLc=
Received: from [IPV6:240f:10b:7440:1:27fe:5767 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Oct 2025 17:44:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5025758860806143264
Message-ID: <870075785A1ED2B9+6fb5238e-dc57-406b-acf9-b88b237d8e5b@radxa.com>
Date: Tue, 28 Oct 2025 18:44:49 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: rockchip: Add Radxa CM5 IO board
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Joseph Kogut <joseph.kogut@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Steve deRosier <derosier@cal-sierra.com>
References: <174735136138.1544989.11909422896170025756.robh@kernel.org>
 <20250528221823.2974653-1-joseph.kogut@gmail.com>
 <20250528221823.2974653-2-joseph.kogut@gmail.com>
 <20250529-impressive-real-monkey-a7818b@kuoka>
 <6443BD03B4C4F1FE+d20c3903-e2dc-4c2b-8f6e-fac38f242898@radxa.com>
 <2f4e7f94-2921-493c-94fa-45749a060bc0@kernel.org>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <2f4e7f94-2921-493c-94fa-45749a060bc0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NRkWGnbnkwTmU/WK0mSt5e9UCz0f7jbg1RWFgtKdB72zlIwDHGbo2JsE
	dYtTSWn10sSp1/i1eKhF16i+Nzb4lT1ZsszT0A719dDTphzwDX/aL0G2Lyx374s4xQrZbHQ
	+nAh/WcPyyfu7/3XcgjUv8xiONH7Uwf8HiDasd6/rauAziJ0lBUzu49mvJQ1g6ZWGCj9MFz
	NB09cteOHv4ykZiuje+xXGao+Qu7EJv/g9UrePH1un1un5JMO3qn/PqnZZxRPUa+WKtyuj7
	5DnRazsV4cDuoiazRNpHNWEqPKVU1Fq8FG9a3bfR17IwAUyKqwHLYAkzyHtlaydSPAQnc6p
	MnMgxY7Ju7HBTgDS5VvZmMBbq0jKAiE/j0R7NyjS8hM8bn+jASMzSxnVNlWuhUBL8FjkYA6
	F3K3l0sh6SFa100T8YfkPZkxF6y6wQmpy/hjkvLXe7taEJS+trETC16W9pitkElcpIz4uXA
	CDmgfrgZd5+8WF4c/2fTsCJg9VLUXiWK1ZuJigwkiKpUEBejHMcMy1e18UUOgz8s25aE1o2
	5QeLYK6bpSxlDPOA15k3hzABkHgz0F5IuItfBLH8CwXy2nguj9yPO7GkdCId61Ir4/OziQh
	nmHtUdkWNt74FOPIL+qhkM5SG1bO6ncE/bI9fx1OCebcAO/qtR5KEPH1J+imPYdOIiNsiQD
	ULLYypuMmhImsfVAkbdZQiJ1x61EmVcwi8rS3Tl5cGv359ZezSqrcsj3f6y77A6jfuWXI9u
	O3UcU4YZ+V9Q2/j/Q2hTMcNj5xs7o1/dO4QpkZH3Rswhk4VP5bhKnLINeGU+DV6g4FQ5E2b
	Z37N097oJJAFeR6t4LqS9uC5uJm4kXPjUWNRKRQqXbwkCRIw3rbGxAqnXNy9wskz8mfU3nx
	OWlEKHsHX+mUJwD+oiqTP0JplAv2iyCYF1leibGTVPLbmE2OjYFao7uamDeKQoe29y3m3DT
	YKCmAb6MSI1RiBE2wVM1yUSsJEF2qTFXSMY8EziD+eKsHpbcDbyy0TX45V8YVnJLK4xPIEm
	7qRjQ4lywoCeff5Lddn5G8aRmkeD0uUqbzAPxn9A==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Hi Joseph

Your patch seems to be NAKed.
I will submit new patch soon.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 10/28/25 18:37, Krzysztof Kozlowski wrote:
> On 28/10/2025 10:33, FUKAUMI Naoki wrote:
>> Hi Krzysztof,
>>
>> https://patchwork.kernel.org/project/linux-rockchip/patch/20250528221823.2974653-2-joseph.kogut@gmail.com/
>>
>> On 5/29/25 18:19, Krzysztof Kozlowski wrote:
>>> On Wed, May 28, 2025 at 03:18:21PM GMT, Joseph Kogut wrote:
>>>> Add device tree binding for the Radxa CM5 IO board.
>>>>
>>>> This board is based on the rk3588s.
>>>
>>> Do not attach (thread) your patchsets to some other threads (unrelated
>>> or older versions). This buries them deep in the mailbox and might
>>> interfere with applying entire sets.
>>>
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Please explain the sorting rule used for this file. You must have known
>> the sorting rule; otherwise, how can you be sure this patch is correct?
> 
> Huh? I don't have a clue about sorting rule but if you mock my review
> let's make it different:
> 
> NAK
> 
> Best regards,
> Krzysztof
> 



