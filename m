Return-Path: <linux-kernel+bounces-845791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412ACBC61C6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AA6403E8F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A60F242D6E;
	Wed,  8 Oct 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RsWynekI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4D2B9B9;
	Wed,  8 Oct 2025 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942861; cv=none; b=cYuEm3s/hCCwGoRZ8utgbJF6/O3sx3SG9bjcGELUr/FHZji/ulGVKmaEfFUQuNuVH3tsrlr4p1MSoOstJP/tUrujwlrfJBEY0GbWWs4Szd1zrLlw2Op+5K6qp8YHeRGGzv7go2hr0jxc22bKzAbLZnpyreQ+4fOQlq50ZhJyqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942861; c=relaxed/simple;
	bh=gIO8S6Ub6n8WsE56STBvILbKuRyD5PI4baZ3jN82b0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbXRMZJYpWsRlm9rcHEELcs3bNWUVE8dES3PGbc9hseKNi1/SPlz4H8rtPndB2v5+zHKjDgHSi3soU+ucnkZmFru0O9CNIc9+yJBXABgIUeltr4nftVuqBm065M+2pl1D5ckSq8qUVkTbFInKzfd4Pi7KakC177tu0b+FeZPISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RsWynekI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759942857;
	bh=gIO8S6Ub6n8WsE56STBvILbKuRyD5PI4baZ3jN82b0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RsWynekI53iU+SaloFsb/4WQonZrQYg1NfP93gNpx5I2T8evJWMwYYgMoNXvEqYpo
	 kbMRkANmOi26ao7w8tsI0m5A9hEvsBwgdafUjneiYrV7D1AdWjfK0TjgvpmEGInlDA
	 bkdRIqePdVyKvIkG1ezpBbauvFlTO5XrkC7rHb287RCB1PFBwzm1yqGGNSHRfRJ9E9
	 VDuKohR69oBAFZKqdYBtHQbzBsS2z7Ls/1mihAH2MuZatNH2vuMhajbpVv51PfJSWB
	 PeUiMhAYz8hDvLjlCDbrctZHisTpyzZjAwta36A3uabmqLtkrvUQrxiHSiryQ6Y0V3
	 2oDJMvHxnHn3A==
Received: from [192.168.1.90] (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9BFAF17E0579;
	Wed,  8 Oct 2025 19:00:57 +0200 (CEST)
Message-ID: <d85cb819-52da-43f1-8f97-7fc286c916ca@collabora.com>
Date: Wed, 8 Oct 2025 20:00:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] USB/IP VHCI driver cleanup
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 kernel@collabora.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
 <eb86ebd0-71ff-4c00-a524-0046b86b3aa6@linuxfoundation.org>
 <2025100839-lent-smother-9527@gregkh>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2025100839-lent-smother-9527@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 2:00 PM, Greg Kroah-Hartman wrote:
> On Wed, Sep 24, 2025 at 02:44:07PM -0600, Shuah Khan wrote:
>> On 9/2/25 05:56, Cristian Ciocaltea wrote:
>>> These patches were initially part of the USB/IP VHCI suspend fix series
>>> [1] to address a bunch of coding style issues and make checkpatch happy
>>> for the entire driver.
>>>
>>> As suggested by Greg, I'm sending this as a separate patch set now.
>>>
>>> [1] https://lore.kernel.org/r/20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com
>>>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>> Cristian Ciocaltea (17):
>>>        usb: vhci-hcd: Ensure lines do not end with '('
>>>        usb: vhci-hcd: Consistently use the braces
>>>        usb: vhci-hcd: Avoid unnecessary use of braces
>>>        usb: vhci-hcd: Consistently use blank lines
>>>        usb: vhci-hcd: Drop spaces after casts
>>>        usb: vhci-hcd: Add spaces around operators
>>>        usb: vhci-hcd: Drop unnecessary parentheses
>>>        usb: vhci-hcd: Fix open parenthesis alignment
>>>        usb: vhci-hcd: Simplify NULL comparison
>>>        usb: vhci-hcd: Simplify kzalloc usage
>>>        usb: vhci-hcd: Use the paranthesized form of sizeof
>>>        usb: vhci-hcd: Fix block comments
>>>        usb: vhci-hcd: Remove ftrace-like logging
>>>        usb: vhci-hcd: Consistently use __func__
>>>        usb: vhci-hcd: Do not split quoted strings
>>
>>>        usb: vhci-hcd: Switch to dev_err_probe() in probe path
>>>        usb: vhci-hcd: Replace pr_*() with dev_*() logging
>>
>> I acked the 16/17 and 17/17 - others I don't see a reason for code
>> churn.
> 
> Great!  Christian, can you resend just those two patches as a series
> with Shuah's ack on them for me to pick up?

Sure, please see:

https://lore.kernel.org/all/20251008-vhci-hcd-cleanup-v2-0-b6acc4dd6e44@collabora.com/

Thanks,
Cristian

