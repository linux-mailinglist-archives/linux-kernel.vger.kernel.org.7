Return-Path: <linux-kernel+bounces-857648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50768BE7548
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F831AA1D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD98E2C375A;
	Fri, 17 Oct 2025 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hRwzDNd4"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266D52620E5
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691662; cv=none; b=Chifw+gqcpFN7OFwF5ow50cZLNhfS7WuJeE7GSalHMpBq4u5rsg6YNXkpLk1JdBkNZ3L8jzLm5v4gW9xYPkcLLy2zupImGQJfGMVcxnwpUMewYgf2LWWIjS67fzNMGP/lI7yibmvaRkLyBV1vhihaecuNHKR0MmfZz2SqwdrqAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691662; c=relaxed/simple;
	bh=mY3OvQ3rYUK5KdTmwUtH6nyQZzxPGP/sqEDsajp9PMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuJuTmdGkgJIXmtkLX8zPaMWPXWVX8MAIKvmK814UuK0Gso65vzQiXDLSsuJttjkSB0bTqsxvEVkBEJzcSQYf7eEOHkAn+PUIMpMPgPO9AMEEIWgZi4oR+sjArMdC4iBvRqGQq4XB2C60UMYmhUeP+kKAruLtTyNYVHvMsoene4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hRwzDNd4; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 50C4C4E41118;
	Fri, 17 Oct 2025 09:00:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20BAE606DB;
	Fri, 17 Oct 2025 09:00:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57E4A102F2342;
	Fri, 17 Oct 2025 11:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760691657; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ch81BcX9X3+I94fyKG6pbtXcoNAUDjd0YkMmgRQ8ReQ=;
	b=hRwzDNd4IM+PEVEZqDL3YELnlExz95C1x01qGbNRO1TObU4ojXT45HLTqOT1HsN7Q+iUrS
	fJbnhym8riSwpCIfEHXQarwS/vnzpcaglHTm1xBkQKff8C1CIMX+jg759ALjAvrTBh6hUd
	T9VPq3XxSt0GABT2tYHtmnYNRvwGGpz2MeoS92e90Ku4FSjvNJfRt6WIIhZ2LrUTJfp1+4
	dEu7SOHQArLSKndmX5xbU0aqI81Rq3DlnzfH9LH6bIiwNuB88E1EhzofhjtrgtlJolrj8o
	veVQQ7z2wkSo+/Uq8zkwL15xVHswpB6oJzIuZhQTkL89P9VfAvIaQi9p5/JBRg==
Message-ID: <690812a9-2f2c-4a88-b6fb-a3789e931d11@bootlin.com>
Date: Fri, 17 Oct 2025 11:00:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: upboard: fix module alias
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw
References: <20251016-leds-upboard-fix-module-alias-v1-1-be63bafcf250@bootlin.com>
 <44d6ea9f-8559-464d-ac39-20495375bf0e@kernel.org>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <44d6ea9f-8559-464d-ac39-20495375bf0e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/16/25 9:11 PM, Krzysztof Kozlowski wrote:
> On 16/10/2025 15:28, Thomas Richard wrote:
>> Fix module alias for auto-loading.
> 
> Fix what exactly? It was a completely correct alias. Please describe
> here bug (so WHY you are doing this) not what you are doing.

The module alias does not match the cell name defined in the MFD driver,
so if the driver is built as a module, it is not automatically loaded.

Best Regards,
Thomas


