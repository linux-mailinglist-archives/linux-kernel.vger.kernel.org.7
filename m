Return-Path: <linux-kernel+bounces-766922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 696FCB24CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B549D188C794
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477012FDC32;
	Wed, 13 Aug 2025 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tZk1OJMi"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2F12ED172
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097077; cv=none; b=XELXIW9tLUbPxUu2bT232k3gJB5pKwiQS5Nhpm7BTFqtBFXhgO+EcTzTa9TroDwhE1kAtYWn08t346Hwh0SsGH21y4TQkkATMzGP1IahsDcyRwDYTmx4XaB3Zuw8dt+jocohRWIeCwpFNbNKqwRiw6EOUnz8W+AL0x6PGa4Nhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097077; c=relaxed/simple;
	bh=2nQhhmTMpWAkEfQqSuKYdG+7HAP1ecHNw8TdIF2331E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=I8z9TT857Ql5f9ApbmO022m3k+yH3o4ZHxwpVl+Gra4gGH9eDIeSFhpyL3St0HePuUVsk7tm7Ncdp3zR/wbehIvGSRTakY0Hi+4AJmo5yGn2+DoZKuDBOTbYSFc2aVUrjF1d/ETP29Q73urzTozQsRQIb9RMulrsqcVmVXruOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tZk1OJMi; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755097062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZX0y3XqvMJOpqUkdJGA0oEg4O1RqEHyh9mxsJeg//rU=;
	b=tZk1OJMiVRqSV7+X5aLLA1tVT6SxVvMXjd+Kk/ow2bVMHraZKX6+yJO6xh4BXSDkPgBBiE
	VEwef0286emSwznk28MqpnXzWcQVfQGg77GD3z6KXOXFhZLHhHvJwbWLyfkqSTn25ff4vk
	pgUIvwh3haYsv9Og7+9GZPM9Kl8xBB8=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 3/3] usb: storage: realtek_cr: Use correct byte order for
 bcs->Residue
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2025081358-posted-ritzy-bd3f@gregkh>
Date: Wed, 13 Aug 2025 16:57:27 +0200
Cc: Alan Stern <stern@rowland.harvard.edu>,
 wwang <wei_wang@realsil.com.cn>,
 stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@suse.de>,
 linux-usb@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FD8853F3-7ED4-48D7-BADE-F69B4B6D3A43@linux.dev>
References: <20250813101249.158270-2-thorsten.blum@linux.dev>
 <20250813101249.158270-6-thorsten.blum@linux.dev>
 <2025081358-posted-ritzy-bd3f@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On 13. Aug 2025, at 16:39, Greg Kroah-Hartman wrote:
> On Wed, Aug 13, 2025 at 12:12:51PM +0200, Thorsten Blum wrote:
>> Since 'bcs->Residue' has the data type '__le32', we must convert it to
>> the correct byte order of the CPU using this driver when assigning it to
>> the local variable 'residue'.
>> 
>> Cc: stable@vger.kernel.org
> 
> When you have a bugfix, don't put it last in the patch series, as that
> doesn't make much sense if you want to backport it anywhere, like you
> are asking to do here.
> 
> Please just send this as a separate patch, and do the cleanups in a
> different series.

Ok, you can find it here:

https://lore.kernel.org/lkml/20250813145247.184717-3-thorsten.blum@linux.dev/

Thanks,
Thorsten


