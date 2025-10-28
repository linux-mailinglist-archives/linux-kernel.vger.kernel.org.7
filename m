Return-Path: <linux-kernel+bounces-873408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47275C13DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768A73B7905
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6287B304BDD;
	Tue, 28 Oct 2025 09:34:56 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4829E30499B;
	Tue, 28 Oct 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644096; cv=none; b=nZPo7ZDseJXUXdhMHRncTot92lOviEAQU6/YZBDF7leyJKOla5fsaiG0uJaeRK4nUPsQ0ov0o/kfRRHQYjKRUdQeBaw4mBKQsRIWW3QGRUWrCqEbsf0e/OB3nvAZIc03Jbx73bF7ngDIKw148ybhdi8jAIZGwKEYODf5PLxQCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644096; c=relaxed/simple;
	bh=n3ag4l9DR9C7HYAl0AwhDUgt+hS/RPZwKzqoWc7z474=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pw3XrSX6UF5hX9LRGr2VHbHiiio430WvRMp7qnCoL1GqmNmGg4cLD+2gsHc04l5bMXif6/GVrcQQBqwKs/lNIHSqWDFkL7Of+7+cBkXGjs1N/vv7Hf/40+fuNTOqDhSPBfUthZcDTt1WEUgSVYwVkOtXWxYRdrEofZBJfsbf85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1761644020t944cb695
X-QQ-Originating-IP: WmyZaQKgFgULUT5JCy5bTNzR7Fslt2fRzX9qsnX5Cns=
Received: from [IPV6:240f:10b:7440:1:27fe:5767 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Oct 2025 17:33:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5111663429691748184
Message-ID: <6443BD03B4C4F1FE+d20c3903-e2dc-4c2b-8f6e-fac38f242898@radxa.com>
Date: Tue, 28 Oct 2025 18:33:33 +0900
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
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250529-impressive-real-monkey-a7818b@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mvaw++KQIsq0vFjigxIApDXHlXSParZbMBCXdY0NCnb+NjkVkf72zTUz
	laU/rSvBCEYvwiw+KLYBl4tSL/kFDzndJUphGV64uhevw5fR+YgE1f6pgDdY2K8xTDEAeKF
	2zoqnXNpF9nkAxmaPLGU78zQBDJ9G5GPrtSxYX+QjQQL/2bOXaorLnD78twqiI8dcUcXT6E
	02KU1ZZa7C6eioZTW5kRfIXoU/M3SfXULgPheoaom0iYwgLlMOo3fRB0lNUlzHLxuSB40IM
	uwVomI4M/Rq7Px0nTC5hTfCUrd6TqVKGm70pki/EaPCDCBstzOIOZJcOGCbvDd9k+c+Jkz7
	Egs+6DeHoCH46JP69RlTofXDcfEsxm3IXYAlTfuAm/P2VcByHCdNCWlcF0pbUffc6VGnLuV
	JlRi4QAs+eJiKuu2bsy8EA/MqBr/o6uhimhptr4KEYLxCFPTioL1tsiTMqfzXwF4aIJPvWE
	IKLNCnOo0/6nszujGQzNPRHtwdlWOPJ88Q/0eHYCiVU1sVDGUQE/onMFQingUMrdzEAO2Aq
	Q5aJoSX8ONSY7NbKrYGGqt2HrlSndi9JRpoECkCBRwYsrytLvH4CKL7bx5OtBnroSsibtc7
	gj+tFAaQ4Ne+4Jd96Id4qwWeE+i+25YwaQnh8tHAJMEfE81Fk9D5SxQKj3b2Pe8EvMTupcD
	FwHc7yyABBhtQ25ca6KC0VJ3mQ+uhLnWIXwOEaSwAOE2YbJF9GbYAusebMzaodlPzJuwocl
	BPVHAbwsxI4YVhoMcnwYzcDQ1BZBJG97oC4iqBU02E+nVFL7b5OhZ9VvWrKOa6j404c4/YR
	oCHnEI58mt9jlwGVnohX1PWbkur6pwr0+yyz2suvV5VOHoNC/mWrVX3Q7bb+cPa0j1Yqxhi
	Zgk9FV3z7fhbsjrVOztksY0UelcIXjIv6cWY6J5kqjqOS3q3x4YIdZ5icffks/uvVa63zAX
	6NVmbSGvvjDMjtZmeEYhqho8vBjQc1iAJj38bMMHBMReGvMr21/7nF1zg
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hi Krzysztof,

https://patchwork.kernel.org/project/linux-rockchip/patch/20250528221823.2974653-2-joseph.kogut@gmail.com/

On 5/29/25 18:19, Krzysztof Kozlowski wrote:
> On Wed, May 28, 2025 at 03:18:21PM GMT, Joseph Kogut wrote:
>> Add device tree binding for the Radxa CM5 IO board.
>>
>> This board is based on the rk3588s.
> 
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets.
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Please explain the sorting rule used for this file. You must have known 
the sorting rule; otherwise, how can you be sure this patch is correct?

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.


