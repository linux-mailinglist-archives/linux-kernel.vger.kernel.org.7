Return-Path: <linux-kernel+bounces-814035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC29FB54E72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0528486958
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA74F3093B8;
	Fri, 12 Sep 2025 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eRBTg1kU"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2A3093BC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681440; cv=none; b=AfhcFzJyB+7Z3SxAlLzaNQXkmbH9/dvRx13l5RCAHpnGnRqQXMsPnXR+KDYu1DqEEQPagESRKjD7SwwpHfnC305ejXd7JEnDhgC34DPN3FSJb79Af06cHjbvM7T3o/8P+i6gKAeeYQQQ7bWvINOjz2rIE0RmebceGqKfG02azEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681440; c=relaxed/simple;
	bh=1oQXwWv+lJSNtgMzc7cQmQhi/nz00C7zSGZfOqlTCPs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mExsabdUBIMMwvuxI9OWhSCChFHetl41KKURlTF6J6/easT5JLLXubJyqjNO/R0gkYCt9ZP1rR3Zkz08/+8+u0z+CWGxicnhbkaICeLldsm5Ik0+4EiC1niJ94EaqR3hltE0FYULGYd0r7ME32un+/WsVkMizzUeanTIbyCJ3QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eRBTg1kU; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757681425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYq3AqU24weJAslNrHOd3hJqC0HeulXIDNwwV6Fs/KY=;
	b=eRBTg1kUDpov12hPolDE9KMaj4VnodINYcyfhQqLmN64t3PaZITFcmFVemf/Iz5lK/EFEY
	MXHpHgYtpFegIrJX9e+1KlXgIN33e0az4PgVT90O/2eVE3S3POQCc7oOYDcREVySMXo9h/
	ZYbgVGMbS/zPG6oLF/BSFz1pfSEtp78=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] s390/hypfs_sprp: Replace kzalloc() + copy_from_user()
 with memdup_user()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250912110619.10147C7e-hca@linux.ibm.com>
Date: Fri, 12 Sep 2025 14:50:12 +0200
Cc: Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <BABCE4F4-7C7A-4D25-AFB6-1CF9476151A9@linux.dev>
References: <20250911214539.1483234-2-thorsten.blum@linux.dev>
 <20250912095620.10147A01-hca@linux.ibm.com>
 <D56B6A09-8633-402D-A942-1C24AE465AC8@linux.dev>
 <20250912110619.10147C7e-hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On 12. Sep 2025, at 13:06, Heiko Carstens wrote:
> On Fri, Sep 12, 2025 at 12:09:43PM +0200, Thorsten Blum wrote:
>> On 12. Sep 2025, at 11:56, Heiko Carstens wrote:
>>> This is not an improvement and also incorrect, since kfree() may now
>>> be called with an error pointer.
>> 
>> Unless I'm missing something, kfree() works just fine with error
>> pointers. See linux/slab.h:
>> 
>> DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
> 
> This is for automatically freed memory, but not for the generic case.
> See cd7eb8f83fcf ("mm/slab: make __free(kfree) accept error pointers").

Interesting, I didn't know this doesn't work for the generic kfree().

Thanks,
Thorsten


