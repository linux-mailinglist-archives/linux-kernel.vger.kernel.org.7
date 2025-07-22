Return-Path: <linux-kernel+bounces-740463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 848AFB0D46B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909847AD8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E6D2D3A97;
	Tue, 22 Jul 2025 08:22:48 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DF01ABED9;
	Tue, 22 Jul 2025 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172567; cv=none; b=KxuUnwq0+5QSaJB5D6y24bShKCV0uDt+5FtgPf/1ehXtDu8lipG7Yya2l1egBrcz+CE1EuQ2TwxMuVcUaJSV5t5MwP/J4GWV/cCjg35B42/18Ovx0XttI6OGD2ehUxtTm7kulXFm8HjfKJClRoEhB3/Yoi/fkxOpT9EyLRwXyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172567; c=relaxed/simple;
	bh=2VOw9OZQqJGqbwq5qu3nzTogcdWhKeuGiM8fJb6jDZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGUcipBwTv5nMmtuRlXjcBFWzQeDTgBW4g9iigLswzH10DqJUm6c3bYvV0EVCIZJ/6/uNYgNpEnpCgojWMYuTM9i48mBV6G8eU3M5IfWPoLWxvOdTNdbNX6Zzk4jPcjXkUGYC7GfZ+oKeLJn0/tFrjWCcrqV51L2R7MZwrUN3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [10.48.133.23] (unknown [15.248.2.227])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id F2F9F41584;
	Tue, 22 Jul 2025 08:22:36 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 15.248.2.227) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[10.48.133.23]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <f4d33bc8-f988-4237-ad99-ceb2036bc197@arnaud-lcm.com>
Date: Tue, 22 Jul 2025 09:22:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: mon: Fix slab-out-of-bounds in mon_bin_event due to
 unsafe URB transfer_buffer access
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, snovitoll@gmail.com,
 syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250720200057.19720-1-contact@arnaud-lcm.com>
 <8bbc84ee-44c9-4a85-b5bf-3980b3c81e5c@rowland.harvard.edu>
 <6cd8b6bd-d07b-404c-af23-42fcae9ed9df@arnaud-lcm.com>
 <cfc6d242-df9d-42cf-b275-08de2da669e8@rowland.harvard.edu>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <cfc6d242-df9d-42cf-b275-08de2da669e8@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175317255751.8396.11842046552390480196@Plesk>
X-PPP-Vhost: arnaud-lcm.com

It clarifies things and makes more sense now.
Appreciate the explanation :), thanks for your time

Arnaud

On 21/07/2025 14:51, Alan Stern wrote:
> On Mon, Jul 21, 2025 at 09:22:40AM +0100, Lecomte, Arnaud wrote:
>> Hi Alan, thanks for your reply.
>>
>> Your point raises an important question for me: Is there a specific reason
>> why we don’t have
>>   a synchronization mechanism in place to protect the URB's transfer buffer ?
> Protect it from what?  Access by some driver at an inappropriate time?
> Drivers are supposed to know (and this is alluded to in the kerneldoc
> for usb_submit_urb()) that they aren't allowed to touch the transfer
> buffer while an URB is queued.
>
> Alan Stern

