Return-Path: <linux-kernel+bounces-807463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EC1B4A49D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4EA1B2166A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5913F246335;
	Tue,  9 Sep 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c9P1qOg8"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B9247284
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405318; cv=none; b=if7glpHopfkJQHojtkf666Z2NvdSxZQ+2juTOehHWMg2+R4vJxgXVFneCvKaV7vWdv9JNCyjeF7ymNSZ2hb1AJ61m3KM2iJ68XQgXFlg/JNtp2jXsslHneR32cQ50jfMi/pDkiRuW9JyNIv4Tp4onq45uq3xUMYXG//n5/JSTLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405318; c=relaxed/simple;
	bh=Hmu9KwXDkZaoAeYjfvjgDpFGYIXfNrE+7BfpMSVwxvw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IwUTFmuF7rSeCOw7zxF+Y0y6t1z6W21EgeGtuBqGL/ADv0Gy70VgNSWYlnCmt5iE0o6sU96hd87Vz+9V9bd2GCPHMgGFmpuapt4lM2qS9iIfGgJIiMI9vBI4FhRNmg/ScVFMf1HF0Sv8U9HB1kDmWlB6NBvU1kOE98eAtmztr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c9P1qOg8; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757405304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeCy6rDe75jPH1TgHGyr4cgF59Lim6HqxL9skz46sME=;
	b=c9P1qOg84FL7MhdmiPZ+ysoISwjx10XIdVx051pe0kt4Ug9g1kICNVyfYSANmX9dbT4OJW
	mJbwSWoogwWjKnO7zRjpU9jdb+2IVjb8PqdhrABq+DctZ4xsyl1R4MB6yt2c+/NkQSZvNh
	LtAS8dsFT1233SVKLMZTu5FiE0y14Co=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] s390/nmi: Simplify return statement in
 nmi_registers_valid()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250909062501.8968Abb-hca@linux.ibm.com>
Date: Tue, 9 Sep 2025 10:08:10 +0200
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <87A2F1E0-17E4-4C28-823A-3D6C3379DF41@linux.dev>
References: <20250908153221.383589-3-thorsten.blum@linux.dev>
 <b1bf1f70-8b4f-4e96-908a-907da1748377-agordeev@linux.ibm.com>
 <20250909062501.8968Abb-hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On 9. Sep 2025, at 08:25, Heiko Carstens wrote:
> On Mon, Sep 08, 2025 at 06:52:11PM +0200, Alexander Gordeev wrote:
>> 
>> This change does not make the whole function readability better.
> 
> It actually would decrease readability since every if-statement tells
> you one condition when registers are not valid. Negating the last one
> makes this harder to understand.

Ah my bad, that makes sense. I didn't take the whole function into
account.

Thanks,
Thorsten


