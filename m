Return-Path: <linux-kernel+bounces-783931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A901AB33471
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AF854E1148
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC06C23B638;
	Mon, 25 Aug 2025 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="b6M6UPhk"
Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com [45.254.49.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B001A5BBC;
	Mon, 25 Aug 2025 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756091581; cv=none; b=RFbuksBmazBpqSkwFQiWLkizv6bPIyN5a0HxOUdhqrTycfNKm6qAGnuXEpwbfjz3fwVo3pTVGy7Z1mj+vKrZFK2QJy17lzQlgtPZ66bs6FEkXYSuN6ulEgJJS8SN/f5Wwh/lOrc1iBbfKHoDSQwIZjHasZ0VUp8F4Q7FKtb2T0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756091581; c=relaxed/simple;
	bh=0yG5XdTfUkLYWsRifYXye+8/PpxJP4IkPaV9PoR+Zsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPlvCML9LHowiBoxKjeaXNQkgk7qbIuwXJGdcQBLSuIgssOm3n1JA16I/w4/Fg/uKCS63mFZ9v4H7ZGRyHo5vlUPCfvsXnlTydDVRvPB2y3UTJYYCdgS1G39WYxlVxhEUi/CXklg1OvJoNhyKu3Fzwlp/szIZw7Ta8Yav5R4/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=b6M6UPhk; arc=none smtp.client-ip=45.254.49.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.33.94] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2073181e1;
	Mon, 25 Aug 2025 11:12:46 +0800 (GMT+08:00)
Message-ID: <b62f3f22-d8a0-46ca-a261-fece95d6ae66@rock-chips.com>
Date: Mon, 25 Aug 2025 11:12:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: configfs: Correctly set use_os_string at
 bind
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 frank.wang@rock-chips.com, jianwei.zheng@rock-chips.com,
 yue.long@rock-chips.com
References: <1755833769-25434-1-git-send-email-william.wu@rock-chips.com>
 <2025082244-celery-frenzy-2a70@gregkh>
From: William Wu <william.wu@rock-chips.com>
In-Reply-To: <2025082244-celery-frenzy-2a70@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98df36c91309d4kunm11a8e5e61b01e43
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk9ITVZIHxhDSExKQhgdTE1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVU
	pLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=b6M6UPhk83aNW/p73FH+nQlGI5YCvaPZ5LjUua6hqy/6owdRsc9jpNXAaetPt+pEqTdQ+3P9y5rJVz4XM5bOwUSDIfcLlGlAt5vTVzK6E0RoJDTqD1D7xUBHY3XKW5DvNyuOGlHGERiqYq7glLr8w/MIxutDcxGJuch6LCWIsGs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=yj4F49I+jZVVLGBFwXoCtgdfwHr9IKcDHw7rukvwJqc=;
	h=date:mime-version:subject:message-id:from;



On 8/22/2025 12:50 PM, Greg KH wrote:
> On Fri, Aug 22, 2025 at 11:36:09AM +0800, William Wu wrote:
>> Once the use_os_string flag is set to true for some functions
>> (e.g. adb/mtp) which need to response the OS string, and then
>> if we re-bind the ConfigFS gadget to use the other functions
>> (e.g. hid) which should not to response the OS string, however,
>> because the use_os_string flag is still true, so the usb gadget
>> response the OS string descriptor incorrectly, this can cause
>> the USB device to be unrecognizable on the Windows system.
>>
>> An example of this as follows:
>>
>> echo 1 > os_desc/use
>> ln -s functions/ffs.adb configs/b.1/function0
>> start adbd
>> echo "<udc device>" > UDC   #succeed
>>
>> stop adbd
>> rm configs/b.1/function0
>> echo 0 > os_desc/use
>> ln -s functions/hid.gs0 configs/b.1/function0
>> echo "<udc device>" > UDC  #fail to connect on Windows
>>
>> This patch sets the use_os_string flag to false at bind if
>> the functions not support OS Descriptors.
>>
>> Signed-off-by: William Wu <william.wu@rock-chips.com>
> 
> What commit id does this fix?
Fixes: 87213d388e92 ("usb: gadget: configfs: OS String support")

Best Regards,
William Wu>
> thanks,
> 
> greg k-h
> 
> 


