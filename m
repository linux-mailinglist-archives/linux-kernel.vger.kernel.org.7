Return-Path: <linux-kernel+bounces-725020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1136AFF9D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15258169573
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E227287278;
	Thu, 10 Jul 2025 06:29:29 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCBA43AA1;
	Thu, 10 Jul 2025 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128968; cv=none; b=A26PkJiehsZnQWr82qLyOxReJztKHH2x67hC/RH8euJcpLhfSOebjem9YKS+rahyzagrdHsZaEFNCqFdqTKVMHS7evjgLuCFSExd7KJolisaYfLkA+Y7q97CGZskpi937QVIPa0efemwgz4He+Yhg4S/RHeH2E6wO3tIjP+jhCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128968; c=relaxed/simple;
	bh=gvdq60nzfNG2esKxBfmnuhBh+aKn0Wz4qX28y8HNUkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ez8zywGSqFCQnhslQD60ODQoAkeCZunkBsIjv6IOOwtyYHw/jUvwXbsthFtuSMyzsQJ6rAN4i431PxyFMvZpTS3hxTNyExzCPqVxgS3o4DvCFi01pKfKDQm06Tl4uOLrfZmpkbYZMDeSC32oiGBvGFMaTgcPAvsAliMrjGF3A4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 30d60d2c5d5711f0b29709d653e92f7d-20250710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0043cf3f-91f2-40cc-b799-60f2b559615a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:14aab8415650b34f3e5ca436a8a56690,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 30d60d2c5d5711f0b29709d653e92f7d-20250710
X-User: dengjie03@kylinos.cn
Received: from [10.42.12.86] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <dengjie03@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1849901318; Thu, 10 Jul 2025 14:29:11 +0800
Message-ID: <0056f856-bd81-403d-84cb-339a37a73b8f@kylinos.cn>
Date: Thu, 10 Jul 2025 14:28:43 +0800
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
 <4bac2d53-0e5b-437e-92bc-12921a8efd8d@kylinos.cn>
 <2025070810-nintendo-congenial-95d4@gregkh>
 <92f1e73f-5814-4e01-98b6-1c9c0b87f903@kylinos.cn>
 <2025070902-service-foam-1da5@gregkh>
From: Jie Deng <dengjie03@kylinos.cn>
In-Reply-To: <2025070902-service-foam-1da5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/7/9 14:21, Greg KH 写道:
> On Wed, Jul 09, 2025 at 11:40:03AM +0800, Jie Deng wrote:
>> 在 2025/7/8 15:33, Greg KH 写道:
>>>> 2) linux + arm64: The SanDisk Extreme Pro 55AF device will report an error
>>>> when
>>>> using the uas driver and the driver cannot be loaded. USB Controller model
>>>> (Vendor ID: 1912, Device ID: 0014,uPD720201 USB 3.0 Host Controller).
>>> Ok, that sounds like an arm64 issue we should resolve.  Why can the
>>> driver not be loaded at all?  What happens?
>> 1. During the process of loading the uas driver, the following error message
>> will occur,
>> resulting in the failure of driver loading:
>> scsi 3:0:0:1: Failed to get diagnostic page 0x1
>> scsi 3:0:0:1: Failed to bind enclosure -19
>> ses 3:0:0:1: Attached Enclosure device
>> sd 3:0:0:0: [sda] tag#10 data cmplt err -75 uas-tag 1 inflight: CMD
>> sd 3:0:0:0: [sda] tag#10 CDB: Read(10) 28 00 74 6f 6d 00 00 00 08 00
>> sd 3:0:0:0: [sda] tag#10 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD
>> sd 3:0:0:0: [sda] tag#10 CDB: Read(10) 28 00 74 6f 6d 00 00 00 08 00
> Any chance you can use usbmon to try to figure out why the arm64 system
> is sending different commands or failures than x86 is?
Thank you for your suggestions. I’ll review them thoroughly going 
forward.🙂

