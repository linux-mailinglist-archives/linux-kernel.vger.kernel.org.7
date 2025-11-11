Return-Path: <linux-kernel+bounces-894754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AD4C4BFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B81304F687C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0D731691B;
	Tue, 11 Nov 2025 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bTGk8HB/"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450AA299928
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844416; cv=none; b=XTY5xLviwk6DOPuLSfmikI/oI1PCvv8yfEzEIMTgKpcRaSrbPnQZOWFRcKMA6inSeKXA8yzwO4z/sfWB7wFZxDKs5VBcw0oQxoi9Oi/s2xbDZczs1LtdbaIbCjyVKcYV/e/jME6eXqN3UKNnNinAYSDyH0G4ArU7Mn3ia/mu+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844416; c=relaxed/simple;
	bh=lkoyytZzlJir/rENDnqrYHU7rJ/u7rlWl9dM0tePmqU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fb6gIPT8i7iZnvcDfBhid42VH8H4i194C4+7H/lKazkqGLVbBwtAj7eZbc81rRhGA2JyWEV21SXDqWezANTvONswb33amTiMQVGb5MU17nXidCH7+aS4T+ZERC5r5koAGWrWTopvbckqjRYcoQR1A8zOWG53HX1sG4cFSZ3FV1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bTGk8HB/; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762844411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKizkMmVoN2fp8ZV4SExztn9QwUvKPF0m1z1rnF/wtA=;
	b=bTGk8HB/wfytTP/uAxt75Q8GD5jT7jBfTt5KdC2xGpmqFyjstiPrFZRVKHDExo8qyxvZrN
	uJcPeTanJuXhKET6AwSKAXC+EOL1ohzcjGQrBzeiNQ3jMUSGcOVT7YCMi4KK8Bp4LerS5P
	uB74PhdUwRspPUv6jkL2hHN/CulQjsY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 1/5] s390/ipl: Mark store_status as __noreturn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20251110150635.15528B2f-hca@linux.ibm.com>
Date: Tue, 11 Nov 2025 08:00:00 +0100
Cc: Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7AD8A2F3-96E1-4C72-8E06-55BA50C9CFF1@linux.dev>
References: <20251110132803.1520-1-thorsten.blum@linux.dev>
 <20251110150635.15528B2f-hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On 10. Nov 2025, at 16:06, Heiko Carstens wrote:
> On Mon, Nov 10, 2025 at 02:27:51PM +0100, Thorsten Blum wrote:
>> store_status() performs a tail call (BR_EX) to the function passed as
>> the first parameter and does not return. Annotate the declaration with
>> the __noreturn attribute to improve compiler optimizations.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> arch/s390/include/asm/ipl.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This doesn't make any sense. If a function is called, which calls
> another one with a tail call, then _of course_ it looks to the caller
> like the function returned.

Hm, I must have misunderstood this comment from
arch/s390/kernel/machine_kexec.c:

/*
 * ...
 *  The call to store_status() will not return.
 */
store_status(__do_machine_kdump, image);


