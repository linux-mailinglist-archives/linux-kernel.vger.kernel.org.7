Return-Path: <linux-kernel+bounces-877543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5827EC1E640
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A70064E2D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E8B2D8DB9;
	Thu, 30 Oct 2025 05:04:34 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB62261586
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761800673; cv=none; b=GQCebKIuGUb8So28R4iFEHjEcNLqYtoOpkR2CVpEiXvQ7gJvVyOCVD+5VATUEJTmNUHZKfmvkI1VIfCp1QIAYBM2nn7YGE5TzKHCeAO5bnh5IuC85f7GebFfVmay1GZjyXlV8Zg3xAN55rNDv5BBsqhJAgJ2eNIyIErmctu0o80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761800673; c=relaxed/simple;
	bh=1YqZCDsoEY9HX45pEz2jbkVSpcCn0P8wmT2O92wQDMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g02kUKxhu9qgwmNuxhnhfDOMQxKgG7nhBcT5mMC7ultjBmV3SIsjl7a2GOx47xjj/5OFYJy45DnvTQ57HvT9A65/oaC7fiHlJTfbZIdqj3jRFylCbNM0Y9ftdrIaGze+C0UlWdP+7LENB6u/SdN4ZETAWZH/Ju4rJu8mt6ceXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: df66fe48b54d11f0a38c85956e01ac42-20251030
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:55417239-47e4-475b-9f73-71eab8cb4b32,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-INFO: VERSION:1.3.6,REQID:55417239-47e4-475b-9f73-71eab8cb4b32,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-20
X-CID-META: VersionHash:a9d874c,CLOUDID:4b3ca601781db4330402dd82953ad7a1,BulkI
	D:251029203851JVC5DYCM,BulkQuantity:1,Recheck:0,SF:10|64|66|78|80|81|82|83
	|102|841,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: df66fe48b54d11f0a38c85956e01ac42-20251030
X-User: pengyu@kylinos.cn
Received: from [10.14.0.2] [(149.40.56.3)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1638469400; Thu, 30 Oct 2025 13:04:11 +0800
Message-ID: <2d33a48f-a43a-4ed6-a903-aff8184eebf3@kylinos.cn>
Date: Thu, 30 Oct 2025 13:03:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arch/x86/microcode: Mark early_parse_cmdline() as
 __init
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 Yu Peng <pengyu@kylinos.com>
References: <20251029081644.4082219-1-pengyu@kylinos.cn>
 <20251029123823.GAaQIKvz4gUk3Nsaj4@fat_crate.local>
From: Yu Peng <pengyu@kylinos.cn>
In-Reply-To: <20251029123823.GAaQIKvz4gUk3Nsaj4@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/10/29 20:38, Borislav Petkov 写道:
> On Wed, Oct 29, 2025 at 04:16:44PM +0800, Yu Peng wrote:
>> From: Yu Peng <pengyu@kylinos.com>
>>
>> Fix section mismatch warning reported by modpost:
>>    .text:early_parse_cmdline() -> .init.data:boot_command_line
> 
> How do you trigger this?
> 

I found a minimal reproducer: i386_defconfig enable these two options:

CONFIG_GCOV_KERNEL=y
CONFIG_GCOV_PROFILE_ALL=y

On my toolchain (GCC 13.2), this combination instruments the function 
and prevents it from being inlined, which then triggers the modpost error.

Thanks,

-- 
Regards, Yu Peng


