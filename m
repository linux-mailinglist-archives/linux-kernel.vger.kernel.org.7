Return-Path: <linux-kernel+bounces-745278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6657BB117CE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF52C5871E4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC75242D67;
	Fri, 25 Jul 2025 05:12:01 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6CB0323D287;
	Fri, 25 Jul 2025 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420321; cv=none; b=Mq6XxFCpV9A5x3X5k33sZsxBI4mAeS0MfVnYVFfs2aLQvFE9VB4ShCPtM6nkfOWkfCIWYxnMGtcvJ183MFOfzrPoRfPMtLzi4XG/LNIDkoRHFFk3TK0pyxEg6VENpieG64l+Lq1DNWWkW+ec4mJQTOR72Ri38yWwqlx6xgw8abY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420321; c=relaxed/simple;
	bh=SZ2LyOA0qe0gAsOSU7ZRO65oVGsuBI/uDLe/0pa76o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=CssR6UNW7v2FCBacqYj4fLpv9SpQCiwe+fwRjInsRcsbxtRsyxKQxk/M5sdaIDYRs3+TGnuOqRPsMvOTD8Rrwbj8xZ9oidbN2YkKo8+9BHh5TBnqEfNegl7OarxXdIWm5ZjTZ99+kJ8Mokqi2EQtk0/4WuaKcdSz6+Nz6qsdqJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 223D46018B955;
	Fri, 25 Jul 2025 13:11:43 +0800 (CST)
Message-ID: <40390378-714d-4f46-8e13-93ec3c75f2f2@nfschina.com>
Date: Fri, 25 Jul 2025 13:11:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: print xhci->xhc_state when queue_command
 failed
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Su Hui <suhui@nfschina.com>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <2025072530-stimulate-gush-6820@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/7/25 12:43, Greg KH wrote:
> On Fri, Jul 25, 2025 at 11:13:09AM +0800, Su Hui wrote:
>> When encounters some errors like these:
>> xhci_hcd 0000:4a:00.2: xHCI dying or halted, can't queue_command
>> xhci_hcd 0000:4a:00.2: FIXME: allocate a command ring segment
>> usb usb5-port6: couldn't allocate usb_device
>>
>> It's hard to know whether xhc_state is dying or halted. So it's better
>> to print xhc_state's value which can help locate the resaon of the bug.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/usb/host/xhci-ring.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>> index 94c9c9271658..a1a628e849c0 100644
>> --- a/drivers/usb/host/xhci-ring.c
>> +++ b/drivers/usb/host/xhci-ring.c
>> @@ -4372,7 +4372,8 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
>>   
>>   	if ((xhci->xhc_state & XHCI_STATE_DYING) ||
>>   		(xhci->xhc_state & XHCI_STATE_HALTED)) {
>> -		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command\n");
>> +		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command. state: %u\n",
>> +			 xhci->xhc_state);
> Don't you want to see this value in hex?

yes, hex is better, will update in v2 soon.

Su Hui


