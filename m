Return-Path: <linux-kernel+bounces-848964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C255BCEEB4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2322A34EF1C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BF01ACEDA;
	Sat, 11 Oct 2025 03:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BcG4JDpH"
Received: from mail-m3292.qiye.163.com (mail-m3292.qiye.163.com [220.197.32.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BBE3FC2;
	Sat, 11 Oct 2025 03:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760151923; cv=none; b=i4X9bT5FRvhWOtvK2J5oaCx2nBiVg1ARCZ62ZqxXYeyrhccBCi7rR62o1hUwYVUzy8iRbpeHoPRhSJfhMUqcSCemAEZb3q6b5H99LA82yMjJ5muCaYrq5LZyI81yGlbuRRdwyZ+i9g2lrYV6oCP5f3/wbkudN8b+6n8fZBnWOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760151923; c=relaxed/simple;
	bh=IjSGK6tISxai0JQVwUngNoeu6jw5RLorQnjtddZIBu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVIjYXFqCWPy3gJOlivjEQ3BcqIsywJAM0XJZNF/n+fgps0i1c0ypdIrlKkMrnlCMapi/J28a3LQbCenyKGifqe2cURdMzgTX4lG3jLWmule3OS1Ut0HIqHf0kxS6Ap7O6Sao4n1cUCT7wAk/ruHezRqTw73PHy4qRqykg0BJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BcG4JDpH; arc=none smtp.client-ip=220.197.32.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 258448df5;
	Sat, 11 Oct 2025 11:05:09 +0800 (GMT+08:00)
Message-ID: <7a0e519b-40ac-4b43-8b9d-f553f12149ab@rock-chips.com>
Date: Sat, 11 Oct 2025 11:05:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: add RK3588 DP carrier from
 Theobroma Systems
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250723190904.37792-1-heiko@sntech.de>
 <20250723190904.37792-3-heiko@sntech.de>
 <0582b7bc-e5b2-4b5e-821e-8d2c4301579f@cherry.de>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <0582b7bc-e5b2-4b5e-821e-8d2c4301579f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a99d13ab5e803a3kunmd5ed0f611cf2f8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRgdTVZDGR9ISxgdS05MTRhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BcG4JDpHNH8v0B4VgRuWcBKp5Y0HoHiVdkW0aQ0sem1Laa/IbTNu7NbRpVErCbTBGKlINOF02NVd6bq8nOwYlmjqwfWzrHCawRddnNsSe71Ib8WxSaWhAw33Q+c7CHL3++68jO1O071FK4IIyiTo1yYhitwDBGsB9j0f6LtEpso=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=JciJ+fW3A6ZS6ImbDuDBfmOW2HRfOeNCg82yAvl2wII=;
	h=date:mime-version:subject:message-id:from;

Hi Quentin,

On 7/25/2025 8:29 PM, Quentin Schulz wrote:
> Hi Heiko,
> 
> On 7/23/25 9:09 PM, Heiko Stuebner wrote:
>> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>>
>> The DisplayPort carrier is a very simple baseboard only providing serial,
>> ethernet and a displayport output.
>>
>> But its main functionality is that it routes the Analogix eDP controller
>> to this DisplayPort output, which allows to test that controller simply
>> by hooking it up to a suitable monitor.
>>
>> The Analogix-DP controller supports eDP 1.3 and DP 1.2, so can drive
>> both eDP displays as well as full DP monitors. It does not support DP+
>> so passive DP-to-HDMI adapters won't work.
>>
> 
> I tested this on master (2942242dde896) + v2 of the eDP driver as listed 
> in the cover letter, or with v3 of the eDP driver + 
> 48f05c3b4b701ae7687fd44d462c88b7ac67e952 and in both cases I have weird 
> behaviors.
> 
> First, `reboot` is stuck for a very long time before actually rebooting. 
> I think you have a stacktrace when you tried yourself, I don't so cannot 
> send one.
> 
> Also, I tested on two different DP displays, one has a green tint, the 
> other one purple. When trying out other resolutions with modetest, the 
> kernel would often crash (no trace, just nothing on console, SSH dead). 
> Note that the same HW setup with downstream kernel from https:// 
> git.theobroma-systems.com/tiger-linux.git/log/?h=linux-6.1-stan-rkr3.2- 
> tiger works just fine. I would assume this has nothing to do with this 
> Device Tree patch here but rather the eDP patches missing some bits maybe?
> 
> @Damon do you have some idea?
> 

Apologies for the delayed reply. :-)

Since the patch series has been updated to v6, could you please rebase 
these patches? I will then conduct further investigation into this issue.

> The display with green tint is a Iiyama ProLite XU2294HSU and the one 
> with the purple tint is a Dell P2319H if that helps.
> 
> modetest output: https://paste.debian.net/1387797/.
> modetest output with downstream kernel: https://paste.debian.net/1387798/
> 
> The Device Tree looks good to me otherwise.
> 

Best regards,
Damon


