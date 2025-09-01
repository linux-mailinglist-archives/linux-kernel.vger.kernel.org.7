Return-Path: <linux-kernel+bounces-794271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 145EDB3DF52
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42C9188B28E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F74B30DEDA;
	Mon,  1 Sep 2025 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WSmy2zED"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794363081A9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720737; cv=none; b=eqULqCGpFWJ+4Gk+1R8el1/ETOtqfhaD8v7xgXwF5Cx7i8Sw8yHHtu/ktC35mpCVKFSByhUfJTVzmmk7SmBmoaK7m/EAIzrbDFo/OWWnQP8xSIMd8K1yyGrws8cXKHZa9JVdCfpkV8YH41VTRiHGgwHaWlxcqdG8F/scJ1Hk0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720737; c=relaxed/simple;
	bh=QxYLehtcBAi69d1LkCeE7+C8BiDvA8vqNgIgSEupEwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWJ7RwF/uHecZDIPeuCDTnvqTqKkDH+58CVIrTViXISZqHuSn8Bshxe4UVZ1V7minjXNI/TzEV8+3LP+3MKPi3rqA00n10VDVCxGmsDfY7z61709EEjw1ys901z4rwUUH9mzw3cKyGHWiPRcuoXWNw8hAjkYvojsvqL1PpK6vdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WSmy2zED; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3c51a9e-f0cb-4d25-a841-117da0ff943c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756720733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fI6X1gDmQhfOpGtZzFYvtwz7XRWedoWtufSbGm0SwBE=;
	b=WSmy2zEDWPbn5oFdmmVc3IDdc2eJhB/I9aZ1OYqW+aqA59vXbyQswdwNGNSq9ru7Ct8Evn
	GXdQL+qnYtOSBejWu8Ijd0rsfetJxSOwQoKqG+vL8ffIQKwOlSsGDftO6J+gqWK3Lqj3Gc
	A+FLEptHCF8FI8LenrRw1GMW8Bp1erc=
Date: Mon, 1 Sep 2025 10:58:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v9 1/5] net: rnpgbe: Add build support for rnpgbe
To: Yibo Dong <dong100@mucse.com>, Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
 geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
 lukas.bulwahn@redhat.com, alexanderduyck@fb.com, richardcochran@gmail.com,
 kees@kernel.org, gustavoars@kernel.org, rdunlap@infradead.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-2-dong100@mucse.com>
 <dcfb395d-1582-4531-98e4-8e80add5dea9@lunn.ch>
 <8AD0BD429DAFBD3B+20250901082052.GA49095@nic-Precision-5820-Tower>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <8AD0BD429DAFBD3B+20250901082052.GA49095@nic-Precision-5820-Tower>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 01/09/2025 09:20, Yibo Dong wrote:
> On Thu, Aug 28, 2025 at 02:51:07PM +0200, Andrew Lunn wrote:
>> On Thu, Aug 28, 2025 at 10:55:43AM +0800, Dong Yibo wrote:
> 
> Hi, Andrew:
> 
>>> Add build options and doc for mucse.
>>> Initialize pci device access for MUCSE devices.
>>>
>>> Signed-off-by: Dong Yibo <dong100@mucse.com>
>>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>
>>      Andrew
>>
> 
> Should I add 'Reviewed-by: Andrew Lunn <andrew@lunn.ch>' to commit for
> [PATCH 1/5] in the next version?

The general rule is to carry over all the tags if there is no (big)
changes to the code in the patch.

