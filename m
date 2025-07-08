Return-Path: <linux-kernel+bounces-720938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD888AFC250
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D0A3BF7AF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911FB21C9F4;
	Tue,  8 Jul 2025 05:58:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B667217648;
	Tue,  8 Jul 2025 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751954293; cv=none; b=i85sT4PsIHdjLEYXdHJnwRI+H53iz4cqUbjmdnIeY2ZoZxJMTFYmjVWcf4KuPhD4YfXXioWSLa07yQQb8fTRyhFRYwAuligQsxwe7ahAdmbw69HcJkxpjpq5OUiV/K9Jg6MwZ9uRrKkxipglca4Ejvovx2fTrCsYSyLpNnSa4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751954293; c=relaxed/simple;
	bh=TAZTZ8+vZkd/Shy2rLj20F+q03dzYCCSZ8zHvr/aoc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uv7c/f9VHRqaN2Imdcftj7xvIv9eCRMfwlHNDHSaGlv07R/NG0DAKwNz+vOKqJ/MwdpuSWmUjXBTdF7rH3rkYIxQfs/0KHmi8IcAAzNe43YQ1sK/xJpI4jnghCPTl89z0ASK6ATJGEzrK4SQVk4LyYWIdMaU3SnOyj1y3jipNQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 817e14d85bc011f0b29709d653e92f7d-20250708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:68b2d49e-6976-40fd-a1d9-1624069277ef,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:8bca6426d360aab6cb6fbe7b44bd2824,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 817e14d85bc011f0b29709d653e92f7d-20250708
X-User: dengjie03@kylinos.cn
Received: from [10.42.12.86] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <dengjie03@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1020781394; Tue, 08 Jul 2025 13:58:01 +0800
Message-ID: <4bac2d53-0e5b-437e-92bc-12921a8efd8d@kylinos.cn>
Date: Tue, 8 Jul 2025 13:55:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: storage: Ignore UAS driver for SanDisk Extreme
 Pro 55AF storage device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <2025070422-punctured-opal-f51e@gregkh>
 <20250707062507.39531-1-dengjie03@kylinos.cn>
 <2025070702-unsigned-runny-62c6@gregkh>
From: Jie Deng <dengjie03@kylinos.cn>
In-Reply-To: <2025070702-unsigned-runny-62c6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/7/7 16:49, Greg KH 写道:
> On Mon, Jul 07, 2025 at 02:25:07PM +0800, Jie Deng wrote:
>> The SanDisk Extreme Pro 55AF storage device(0781:55af) has poor compatibility with UAS drivers.
>> The logs:
>> [    1.359859][ 0] [  T163] usb 2-1: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
> Nit, the [] stuff should all be removed, it's not relevant, right?
>
>> [    1.385708][ 0] [  T163] usb 2-1: New USB device found, idVendor=0781, idProduct=55af, bcdDevice=10.85
>> [    1.385709][ 0] [  T163] usb 2-1: New USB device strings: Mfr=2, Product=3, SerialNumber=1
>> [    1.385710][ 0] [  T163] usb 2-1: Product: Extreme Pro 55AF
>> [    1.385711][ 0] [  T163] usb 2-1: Manufacturer: SanDisk
>> [    1.385711][ 0] [  T163] usb 2-1: SerialNumber: 323234323935343030343636
>> [    1.927603][ 0] [  T306] usbcore: registered new interface driver usb-storage
>> [    1.940511][ 0] [  T306] scsi host3: uas
>> [    1.940584][ 0] [  T306] usbcore: registered new interface driver uas
>> [    1.940843][ 0] [  T188] scsi 3:0:0:0: Direct-Access     SanDisk  Extreme Pro 55AF 1085 PQ: 0 ANSI: 6
>> [    1.941363][ 0] [  T188] scsi 3:0:0:1: Enclosure         SanDisk  SES Device       1085 PQ: 0 ANSI: 6
>> [    1.941697][ 0] [  T188] sd 3:0:0:0: Attached scsi generic sg0 type 0
>> [    1.941783][ 0] [  T188] scsi 3:0:0:1: Attached scsi generic sg1 type 13
>> [    1.942296][ 0] [  T189] sd 3:0:0:0: [sda] 1953459617 512-byte logical blocks: (1.00 TB/931 GiB)
>> [    1.942373][ 0] [  T189] sd 3:0:0:0: [sda] Write Protect is off
>> [    1.942374][ 0] [  T189] sd 3:0:0:0: [sda] Mode Sense: 37 00 10 00
>> [    1.942534][ 0] [  T189] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
>> [    1.943586][ 0] [  T189] sd 3:0:0:0: [sda] Optimal transfer size 2097152 bytes
>> [    1.976797][ 0] [  T189]  sda: sda1
>> [    1.977898][ 0] [  T189] sd 3:0:0:0: [sda] Attached SCSI disk
>> [    1.980406][ 0] [  T267] scsi 3:0:0:1: Failed to get diagnostic page 0x1
>> [    1.980408][ 0] [  T267] scsi 3:0:0:1: Failed to bind enclosure -19
>> [    1.980414][ 0] [  T267] ses 3:0:0:1: Attached Enclosure device
>> [    1.981068][ 0] [    C0] sd 3:0:0:0: [sda] tag#10 data cmplt err -75 uas-tag 1 inflight: CMD
>> [    1.981071][ 0] [    C0] sd 3:0:0:0: [sda] tag#10 CDB: Read(10) 28 00 74 6f 6d 00 00 00 08 00
>> [   33.819186][ 0] [  T188] sd 3:0:0:0: [sda] tag#10 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD
>> [   33.819188][ 0] [  T188] sd 3:0:0:0: [sda] tag#10 CDB: Read(10) 28 00 74 6f 6d 00 00 00 08 00
>> [   33.843186][ 0] [  T309] scsi host3: uas_eh_device_reset_handler start
> So new devices are being made that can not handle UAS?  Are you sure
> there's not some other quirk that could be used here instead?  How does
> this device work on other operating systems with the UAS drivers there?
>
> thanks,
>
> greg k-h
Thank you for your reply.

1. The information within [] is redundant and should be removed
2. Regarding your question, before submitting the patch,
I conducted the following tests:
1) linux + x86: The SanDisk Extreme Pro 55AF device can be recognized
normally when using the uas driver. USB controller model (VendorID:
1D94, DeviceID: 145F,Chengdu Haiguang IC Design Co., Ltd.USB 3.0 Host 
controller)
2) linux + arm64: The SanDisk Extreme Pro 55AF device will report an 
error when
using the uas driver and the driver cannot be loaded. USB Controller model
(Vendor ID: 1912, Device ID: 0014,uPD720201 USB 3.0 Host Controller).
3) linux + arm64: Add the parameter "USB-storage.quirks =0781:55af:u" in 
grub.
The SanDisk Extreme Pro 55AF device runs the usb storage driver without 
any error
and can be recognized normally.

