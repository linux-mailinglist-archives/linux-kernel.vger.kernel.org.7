Return-Path: <linux-kernel+bounces-791770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B4FB3BBC2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E502B1CC0711
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9135731A062;
	Fri, 29 Aug 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bcc.bai.ne.jp header.i=@bcc.bai.ne.jp header.b="yiDV/oPh"
Received: from rmx-b.mailgw.jp (smx-b.mailgw.jp [210.171.6.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8609730DEA6;
	Fri, 29 Aug 2025 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.6.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472037; cv=none; b=SzyuaMZq19OK9WcHssHpo5o0BhWn6WICzOmn+Ncp/Wp9+Pt9rdG+L1mBNgwqJgIYaUmLz3hads67sCzUkGp43tE8mUKM8ruihi0WBJFXux0T/aRt1JCMr2jrKAxqCBnJVznwpSLfCOLtJCaF3RMORx65x4HSJcBipsXMYvghrZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472037; c=relaxed/simple;
	bh=6qgtIlhSKeL38DV5YELUJOtzhcntW357Kh0m7EBNIxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQBcAS0MqbzT+1dV7ilNLVY6Vh87jfKYhwthaWCusa1G9OlNk5XYgJ4JxKM3y9nhD0mrBZD0p9vO6B6uovThQliKy1oVDmD9VwF1lq7WUzCgcCYgm+gZqExoO32rPXVH29b0eRvUagjUIGN4A8enqVlpR5jZd9LBiE2+jNdMIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bcc.bai.ne.jp; spf=pass smtp.mailfrom=bcc.bai.ne.jp; dkim=pass (2048-bit key) header.d=bcc.bai.ne.jp header.i=@bcc.bai.ne.jp header.b=yiDV/oPh; arc=none smtp.client-ip=210.171.6.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bcc.bai.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bcc.bai.ne.jp
Received: from bccml.bai.ne.jp (bccml-a.bai.ne.jp [210.171.3.161])
	by rmx-b.mailgw.jp  with ESMTP id 57TCrNJG016915-57TCrNJH016915;
	Fri, 29 Aug 2025 21:53:23 +0900
Received: from [192.168.11.5] (bai859bcd79.bai.ne.jp [133.155.205.121])
	by bccml.bai.ne.jp (Postfix) with ESMTPA id 79A4881773;
	Fri, 29 Aug 2025 21:53:23 +0900 (JST)
Message-ID: <023eb3ad-0826-42e4-8172-08a26db31676@bcc.bai.ne.jp>
Date: Fri, 29 Aug 2025 21:53:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enables sound output from the
 audio jack on OrangePI5 Plus
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sound@vger.kernel.org, robh@kernel.org
References: <20250826134456.9636-2-opi5plus@bcc.bai.ne.jp>
 <AM7P189MB1009A67370CA029038DF2A69E33BA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
 <0b061e42-0a01-4839-871c-a5d760dbddeb@bcc.bai.ne.jp>
 <AM7P189MB1009CB3632FAAEEE43D9CED5E33AA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Hide Hako <opi5plus@bcc.bai.ne.jp>
In-Reply-To: <AM7P189MB1009CB3632FAAEEE43D9CED5E33AA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FE-Last-Public-Client-IP: 210.171.3.161
X-FE-Policy-ID: 3:1:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=bcc.bai.ne.jp; s=20240516; c=relaxed/relaxed;
 h=message-id:date:mime-version:subject:to:cc:references:from:content-type;
 bh=sw/Y+heIE2Vkbrbo96JH8p+ZhrdF9Vqpg0lLY9c5cd8=;
 b=yiDV/oPhM+N3eRfoDyIkF25NIdhLR9RhlFvqCT3kLrNvWAbL9xKedo7hm653n1r8+M8UjIJZvXja
	vW1PIfBcYUWTfnfWPGY1/FPmmfARC3ZBmnbBgbnzKrDOQVlddS+PLdcf9JaPJr9LR/xqip8iRFeP
	7L5cvn07bUTACgBxcvrjnMBiUmeKcP05mfkGnCiBYuPFsk2ub3HUMGdrz+W8fEFgpQzm6r8DPR5R
	n1TJlyJLsgDjwwOCZ5nEcqT4UO3d4UffsUZ17edLfizS0DOAHwM4pBsr0mDfy3bal56tt2b7kKWW
	/dp5m1736qCWzgEMXnYAPkspnj+UTc0vsdyXcg==

Hello Maud

On 2025/08/29 21:09, Maud Spierings wrote:
> On 8/29/25 13:59, Hide Hako wrote:
>> Hello Maud,
>>
>> On 2025/08/28 17:47, Maud Spierings wrote:
>>> I recommend rebasing on the latest next since my fix [1] was applied.
>>> I also recommend testing it with that patch, for me that fixed the 
>>> headphone detection and enabled audio playback. The microphone is 
>>> not working yet though.
>>>
>>> Link: https://lore.kernel.org/all/20250823-orangepi5-v1-1- 
>>> ae77dd0e06d7@hotmail.com/ [1]
>>>
>> Today, i build linux-next.
>> But sound not come out from headphone.
>
> Is that with your patch applied ontop or unchanged linux-next? The 
> audio was very quiet for me, even at 100%.
With pin-switch patch.

Analog, hdmi0 and hdmi1 do not exist in /proc/asound/.
Hide


