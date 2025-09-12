Return-Path: <linux-kernel+bounces-813652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B130B548D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14D064E026D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A292DFA32;
	Fri, 12 Sep 2025 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hwGq0ebk"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7411114
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671801; cv=none; b=XgayZPjs8McSBCHQbp2GIrmB+6pl5BDqMdr1nQSdzurCIxokJRJ+H9RzKrcpofT/bq5Pko4yxc4f3+96WAETiqucPj9WSQrT3QvN0pcyn8mI8BwEkzyCAO4pEi+xIr/eejgS17NyG3m+w5iWbjXS7ojhz1oGAa3Sl2Cw5n+bfqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671801; c=relaxed/simple;
	bh=p/25+iTnLf2/5ri1w9iLBubRClgO3AP4oUzybDOKHc0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VIbSsm1quyiLHeFEHQ1a67Jxiynvzsq8YnraH71+GokDvKZr9usQswgU3+yjLnGoYYF7Xxj0ZkrJKJL8h8rr2Bk7/kYcHsYmhgX85taNtuDuFjWlmTaiJUmRJFViaw9r+kNSnCfBT0M2DY59zVob48mjFYSY/Z/VZQVtVnYqGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hwGq0ebk; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757671797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/25+iTnLf2/5ri1w9iLBubRClgO3AP4oUzybDOKHc0=;
	b=hwGq0ebk3CVNFcN2BcdyG7Fa1F0iCYTbTIvnZ5McIZ1jFAI35f2GtUrK1Sb7uRH3g+G1fD
	0JELGOI63B16qvvcSqLxjvkDX1w4w9TyMufglQg3K7XOmKx1HAwVgZob4124rJ8PaaDBPX
	GXMlKfkn94rb0TyhlfXvF0Zv6P2lmrY=
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
In-Reply-To: <20250912095620.10147A01-hca@linux.ibm.com>
Date: Fri, 12 Sep 2025 12:09:43 +0200
Cc: Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D56B6A09-8633-402D-A942-1C24AE465AC8@linux.dev>
References: <20250911214539.1483234-2-thorsten.blum@linux.dev>
 <20250912095620.10147A01-hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On 12. Sep 2025, at 11:56, Heiko Carstens wrote:
> This is not an improvement and also incorrect, since kfree() may now
> be called with an error pointer.

Unless I'm missing something, kfree() works just fine with error
pointers. See linux/slab.h:

DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))


