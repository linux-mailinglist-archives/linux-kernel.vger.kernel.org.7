Return-Path: <linux-kernel+bounces-866298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5221DBFF69D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6A164F9115
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7D526F29B;
	Thu, 23 Oct 2025 06:51:45 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05B22F14C;
	Thu, 23 Oct 2025 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761202304; cv=none; b=XJ97KjFl2HpFjSr6LOyldhVJLZgdTyANAVWLbWXV+OioDKhG9tBRzJ+PhdFdX0MrIWOvth3BmIeurXfTD+8PeZIC9rkbD5yOoRrdj8FhcE9BUdOB9osWApH4ocI1zNb4hmNTDLNkYWxq2F5M6lpyB0JFx6IrcbuuJ8OvFcEoI+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761202304; c=relaxed/simple;
	bh=5X0wW6b1ns3qFdQA4XmzLO3NILrGbnhPETTrl5YCq+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7+4AA6AH7E6KcD4bqJCPiE5zgOtOGorD/RBnoZxwS9rs2Ct0fr3u2rMBn68ZN+6NbUTwAfN1uf4mZuAOmCYOmAfweWii1nsLVEMt1AmZUZ9C6m3bgRXtYD3mxM1sBKJlU0VIpEhWBep+vayOlGQTt+kafmR80HgUsXSqpTyLZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b762f90eafdc11f0a38c85956e01ac42-20251023
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f62b0f04-a88c-45d1-be64-1e6ddecbf8a2,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:3956814b1687c488fdb0059c78044866,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b762f90eafdc11f0a38c85956e01ac42-20251023
X-User: tanze@kylinos.cn
Received: from [10.42.20.57] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 178362526; Thu, 23 Oct 2025 14:51:35 +0800
Message-ID: <38901e63-422b-4154-ac39-8edde1d98216@kylinos.cn>
Date: Thu, 23 Oct 2025 14:51:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: emu10k1: using vmalloc_array() to handle the code
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: perex@perex.cz, tiwai@suse.com, phasta@kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022092738.552700-1-tanze@kylinos.cn>
 <aPnMwXMuOk7bijHG@smile.fi.intel.com>
Content-Language: en-US
From: tanze <tanze@kylinos.cn>
In-Reply-To: <aPnMwXMuOk7bijHG@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/23 14:35, Andy Shevchenko 写道:
> On Wed, Oct 22, 2025 at 05:27:38PM +0800, tanze wrote:
>> Change array_size() to vmalloc_array(), Due to vmalloc_array()
>> is optimized better,uses fewer instructions, and handles
> 
> better, uses
> 
> (mind a space after a comma)
> 
Thank you for pointing out the mistake. I will correct
the error in the description in a subsequent version.

>> overflow more concisely
> 
> concisely.
> 
> (mind a period at the end)
> 
> ...
> 
>> -	emu->p16v_saved = vmalloc(array_size(NUM_CHS * 4, 0x80));
>> +	emu->p16v_saved = vmalloc_array(NUM_CHS * 4, 0x80);
> 
> I think this should be
> 
> 	emu->p16v_saved = vmalloc(array3_size(NUM_CHS, 4, 0x80));
> 
> Or, if we have vmalloc_array3(), which I doubt, use it.
>
> But since NUM_CHS sounds like a compile time constant, the above approach may
> work too.
>
Hi, Andy Shevchenko.

I just checked the code and found that vmalloc_array3() does not exist 
yet. Initially, I only thought that vmalloc_array() is better and more 
concise than vmalloc(array3_size()). What do you think would be the 
better approach here?

> Anyway, this can be addressed later.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

--
Best regards,
Ze Tan

