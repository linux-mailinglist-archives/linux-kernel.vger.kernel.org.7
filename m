Return-Path: <linux-kernel+bounces-835732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E7EBA7ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DED3A7A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 04:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E66217F56;
	Mon, 29 Sep 2025 04:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoxVom+K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D41A9FAE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759118515; cv=none; b=Dw2uM3Op1Wb7AzhIsyHxRToBSUCMwrDcH+NAoadEIHjUz6L9/jco5Vamg5NYP1y0DbYp0l8l4TGyBz0+F7IoMfcEhOQiMwSq3Nw/W0f7eIrhpiyutQDEP9UHWfr7k3F6eMZx25j5kJTQqSWMO29GLEAwNDvqdxaY6glsZGMfrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759118515; c=relaxed/simple;
	bh=nHlXSI3s1SeNU4+GOTvAJhhQyHmYoguxC2iBIE01rYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFiSHWwljh5ezXFye6IE7Kg1NxcSgSazNdS8/jfBokBQp4uPwCIkICLMq7se1IlVw9+CACew9Xt9LfU6vYpmPgwNTNsE1ghgmyjle2OHdIP3vFf3dsuZZoKuLXMVTCpH4gzhLCb7PLCdgHWh2YQDYvqqBoV4EGoVGftnjkCTPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoxVom+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45EFC4CEF4;
	Mon, 29 Sep 2025 04:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759118514;
	bh=nHlXSI3s1SeNU4+GOTvAJhhQyHmYoguxC2iBIE01rYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZoxVom+KWnRWZ4yKl5eBI8HuU1HUP8igOIfHfxoBm1tWNIV8c0dXQ0xVWUxY9XHqy
	 mQD6PNUgqiBbnCdp62VajD59sVK500qd//4SlRGKc4mzoGKUDS0WD2sEb1PyXLtg3H
	 Q9k9zwl7BiA/GqWgqBSsIF2HbHjHHT0gSJRnNd7yB1hIohC5gcg3qQbyDCi+84xAQq
	 p1DyP6STDKDFK+PAp3vyks9JUTjr+C4oFfCeYwpnX88BXyF24R1mCO+dV56DlDqQCw
	 +Jwc4vyfsdFXto0GNvLQwPRVADg3bGHFBm30SKzMUGjwdR8P6DdPd6UC67pPWHahPO
	 oBAO1Fdk0cyPw==
Message-ID: <1e07144c-da10-4817-a2c6-ea11988936ee@kernel.org>
Date: Sun, 28 Sep 2025 23:01:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/CPU/AMD: Prevent reset reasons from being retained
 among boots
To: Rong Zhang <i@rong.moe>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
References: <20250913144245.23237-1-i@rong.moe>
 <20250916140227.GGaMlt8xSp3eMI8Veu@fat_crate.local>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20250916140227.GGaMlt8xSp3eMI8Veu@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/16/2025 9:02 AM, Borislav Petkov wrote:
> On Sat, Sep 13, 2025 at 10:42:45PM +0800, Rong Zhang wrote:
>> The S5_RESET_STATUS register is parsed on boot and printed to kmsg.
>> However, this could sometimes be misleading and lead to users wasting a
>> lot of time on meaningless debugging for two reasons:
>>
>> * Some bits are never cleared by hardware. It's the software's
>> responsibility to clear them as per the Processor Programming Reference
>> (see Link:).
>>
>> * Some rare hardware-initiated platform resets do not update the
>> register at all.
>>
>> In both cases, a previous reboot could leave its trace in the register,
>> resulting in users seeing unrelated reboot reasons while debugging
>> random reboots afterward.
> 
> Just a heads-up: we're figuring out internally what the right thing to do here
> would be.
> 
> Stay tuned.
> 
> Thx.
> 

The internal conversation points in the direction of your patch makes sense.

But I don't really see a lot of value in re-reading and printing a debug 
message about what was cleared and what's still there.  Do you see a 
reason to keep that around?

