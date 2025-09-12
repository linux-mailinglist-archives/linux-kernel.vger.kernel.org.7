Return-Path: <linux-kernel+bounces-813760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702B3B54A65
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1F016F256
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261622FD7D8;
	Fri, 12 Sep 2025 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JIImcpuB"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF51DF270
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674293; cv=none; b=DalJi7/8fXyy6UwIx5MM7O9mXVa7u1dFHkey3tvGAOZHmGWHaG1Q1mzWfiNuI2ZzxFW8Qq1amYCj+AIoeQOzujx2piaz5qFjrmqFeB3Sf85IgtpqTXYtP23Yqj3HwcDWF6mqHF89rNHb87TTqrhNVsGoC/VRnvfeVnMh0RNX478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674293; c=relaxed/simple;
	bh=rPT8kl8Djel/VDY/1FH5FNC633gJWVeYWEG5cEel1Ks=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c0AxP0XSMZG5+CqVFYh1VdhG8c8tcrCzytt4PRFNwHoMgBJT2PplVRY16WRERRTCqwcPQEq6CgjcEQOhzudnCFf7RUZZHYqv0WayvEUFNuC41rLbndiH1g6UrhHA6TyatJiHq/MiVlVw6d9RnNNfaLN79PGiuAv1Y7lV6CEoTv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JIImcpuB; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757674277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IE/MP16lkep+EAW3WKRtLH4+8VRvKRySerhZmRVNrI4=;
	b=JIImcpuB/v9FKLRMQygTHLpu8RT70XrRCdp9YFtgg+MjsrTmfZ/U4VlJhFWliZHK4PcQ4o
	bWSj4DCTdSDGnmPAma44Qjz2cyWvpcEzcNNomOeivUiRrKrIZAt02D8hqajNKB/L+MBL74
	putT0+AKBmq1T01hY9akFW2Etl2RnDE=
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
In-Reply-To: <D56B6A09-8633-402D-A942-1C24AE465AC8@linux.dev>
Date: Fri, 12 Sep 2025 12:51:05 +0200
Cc: Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <25EFA2E0-5119-400F-A787-D2BDB78B8BE0@linux.dev>
References: <20250911214539.1483234-2-thorsten.blum@linux.dev>
 <20250912095620.10147A01-hca@linux.ibm.com>
 <D56B6A09-8633-402D-A942-1C24AE465AC8@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On 12. Sep 2025, at 12:09, Thorsten Blum wrote:
> On 12. Sep 2025, at 11:56, Heiko Carstens wrote:
>> This is not an improvement and also incorrect, since kfree() may now
>> be called with an error pointer.
> 
> Unless I'm missing something, kfree() works just fine with error
> pointers. See linux/slab.h:
> 
> DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))

And unless kzalloc() is required here, memdup_user() is an improvement,
since it uses kmalloc() internally and avoids unnecessarily zeroing the
memory before overwriting it with copy_from_user().

Thanks,
Thorsten


