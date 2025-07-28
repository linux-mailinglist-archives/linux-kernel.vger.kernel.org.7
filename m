Return-Path: <linux-kernel+bounces-747762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B03B137CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298B9189AE88
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1592550D4;
	Mon, 28 Jul 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D11FtZdk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0CF25394B;
	Mon, 28 Jul 2025 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695716; cv=none; b=anhsG/7IC87Z3CGJN059hyCbkpCmmx9og3w6xd0ImQgB7ocqwQHAWoELGZLWaKq6w6tNjPz6ZM3owXEMXPwcNVopPanVhLz3lhDAD+zD/MMje2VmUt1NGo1FC73ssd5clPoC4qvFvnEwctz8o9TnqYC/fVXRIjUS7gZQE/AaUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695716; c=relaxed/simple;
	bh=kVjfsOeGIEnpVEHNDcMm0oIx8Y7tWx5lY9l0s3c7wxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7BFEQyMrTDTnsV35s0+z1v+1TFgVYUWAx4YRoZ5o8kXTssPZVSb4tePGYWLLEt1WXxbRn+QxmPdRznD/TOsQqOyF9BeROIi+5u24A9b+y26F1Emgqg840i0kaxrfU0mqcVCMx3br7ome/LKHLywxNRxrdgANUrbTpDftvNjHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D11FtZdk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753695707;
	bh=kVjfsOeGIEnpVEHNDcMm0oIx8Y7tWx5lY9l0s3c7wxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D11FtZdkNazlDTLv48S5AvYbi60kn6HWvS1xA4EF9nv0do74PYle+i4RLPk9jbM4y
	 3Q38DwxxDgL90rw8Rm4VCtG8fdP5Br+weLPOLijpsia6vkIeUOpy0t9w6Rue+Y+M73
	 bIOmodQUz9Ggx2ps8rIN6yVOCNr4bfSB6sQS+YHKhvfmXMAsw3QjO5pF+wkyicaJwy
	 NfcZokWZT/OZzBZV3NC9ttSwYgszVdQUZBJ63zKd9Q/gcvO48OSYkfon+QFmLTx2R6
	 i2S6RGUx3IR2gpQajfrtU0hJLKGVkREnZKy+Fs+rqWx5qn9oRs1HAyJl41aQcbhWuH
	 Y9gJnwyDaCA1A==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9D0EA17E1110;
	Mon, 28 Jul 2025 11:41:46 +0200 (CEST)
Message-ID: <3dd94c4f-0971-4744-91e1-3a5474e1576c@collabora.com>
Date: Mon, 28 Jul 2025 12:41:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/18] USB/IP VHCI suspend fix and driver cleanup
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 "Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
 <2025072637-corny-careless-8523@gregkh>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2025072637-corny-careless-8523@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 7/26/25 9:43 AM, Greg Kroah-Hartman wrote:
> On Sat, Jul 26, 2025 at 01:08:02AM +0300, Cristian Ciocaltea wrote:
>> The USB/IP Virtual Host Controller (VHCI) platform driver is expected to
>> prevent entering system suspend when at least one remote device is
>> attached to the virtual USB root hub.
>>
>> However, in some cases, the detection logic for active USB/IP
>> connections doesn't seem to work reliably, e.g. when all devices
>> attached to the virtual hub have been already suspended.  This will
>> normally lead to a broken suspend state, with unrecoverable resume.
>>
>> The first patch of the series provides a workaround to ensure the
>> virtually attached devices do not enter suspend.  Note this is currently
>> limited to the client side (vhci_hcd) only, since the server side
>> (usbip_host) doesn't implement system suspend prevention.
>>
>> Additionally, during the investigation I noticed and fixed a bunch of
>> coding style issues, hence the subsequent patches contain all the
>> changes needed to make checkpatch happy for the entire driver.
> 
> You are doing two major things here, fixing suspend, and cleaning up
> checkpatch issues.  Please make that two different patch sets as those
> are not logical things to put together at all.  Work on the suspend
> issue first, and after that is all done and working, then consider
> checkpatch cleanups, those are not that important overall :)

Yeah, the cleanup part ended up larger than initially anticipated, but I
don't really expect further changes on the fixup side.  I can handle the
split if another revision would be still required, or would you like me to
do this regardless?  I've just made a quick test moving the first patch to
the end of the series and it didn't cause any conflicts, hence there won't 
be any dependencies between the two patch sets.

Thanks,
Cristian

