Return-Path: <linux-kernel+bounces-845060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6422BC3643
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 07:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33AEC34E71D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 05:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868CC2E973F;
	Wed,  8 Oct 2025 05:41:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEF41C2BD
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759902085; cv=none; b=nKOjU3tN7so22pcMF5jrpWWSGdqJ6M9ZoEj3KILLZ2QL5Ciyx69TTgKwKerkzWWmvv7iIkmT+e3m4uuqaLN4uzQx+D2UQoxNoNhLnzsfCo5PV49nmqUKlfi+T28TODdL/S3UD6BFMzpQ3EWIewjhuXuzOxhBPWRJBm3JI7LyxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759902085; c=relaxed/simple;
	bh=9tntwzmXp4JujtWl1FrQ0gJjGwfV1TKZ8QJOepZNCew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0p/vUOjB8aWIRjaX3TTbyMgyHXH2nKQDJx9NwxztbpYAyit44SUd4mDYb9gdAnvh/kGIXu3IxbIv+S31P3gONScS+frpMOD1ntzg5pHftfPqObRs852yoND1rx2APa6R7mhng1OVF7SzzXTobJofCLOdnLEXJSCHnOw2y1uxng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1v6MvO-0008Db-P5; Wed, 08 Oct 2025 07:41:18 +0200
Message-ID: <b21e7e2b-b9cd-4373-9eae-cf25209cf55b@pengutronix.de>
Date: Wed, 8 Oct 2025 07:41:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] init/main.c: add warning when file specified in rdinit
 is inaccessible
To: Lillian Berry <lillian@star-ark.net>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Leonard Goehrs <lgo@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>
References: <20250707091411.1412681-1-lillian@star-ark.net>
 <254c82d5-81d9-4e23-9ed8-29cfc3f3c008@pengutronix.de>
 <984d02d0-3862-4641-b474-345736a13b9d@app.fastmail.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <984d02d0-3862-4641-b474-345736a13b9d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Lillian,

On 08.10.25 05:30, Lillian Berry wrote:
> Hi,
> 
> On Tue, Oct 7, 2025, at 10:57 AM, Ahmad Fatoum wrote:
>> On 7/7/25 11:14 AM, Lillian Berry wrote:
>>> Avoid silently ignoring the initramfs when the file specified in rdinit
>>> is not usable. This prints an error that clearly explains the issue
>>> (file was not found, vs initramfs was not found).
>>
>> I have a system that works just fine without an initramfs, but now the
>> kernel warns me about it:
>>
>> [    2.805602] check access for rdinit=/init failed: -2, ignoring
>>
>> I suppose that's unintended and the code here should actually check that
>> there is an initrd at all before checking for the rdinit?
> 
> This isn't directly unintended. This message informs the user their
> specified rdinit= binary was not able to run, regardless of the reason.
> 
> It would be good to check presence of initrd and print a more specific
> message such as "rdinit=/init specified but no initrd present".

I didn't explicitly set rdinit=/init on my kernel command line though:

  loglevel=7 root=/dev/mmcblk1p1 rootwait=10 rootfstype=ext4

So ramdisk_execute_command had the default value it was initialized with.

Maybe rdinit_setup should set a flag or something to discern the default
case?

Tanks,
Ahmad



> 
> Kindly,
> Lillian
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

