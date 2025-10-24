Return-Path: <linux-kernel+bounces-869526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82B4C08116
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849E4401D66
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30012F4A04;
	Fri, 24 Oct 2025 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sD9SzhQj"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8442F531A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337843; cv=none; b=GlZhmDXT0EktXRnkwfJnvS4M4F1Sj8Qw/i05/GHe45FNhKHnLGQfMwxvsUNrEmhkVFj5rkT0c9VGuxmFGYuBmsM/fHPsCqAALMCytVK30+HbNzYIfTitJvfu9kHrgKLU6eEoSjGh7KfoCig9CX7SyOV2ArWTcXlN75KAyeYtDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337843; c=relaxed/simple;
	bh=nQeNx77M9GNsvNsj0uaAFNT8vsSZ1sInNZwHTtssP74=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Y1Av2FNhX5fBJjN+jDQrxXfbPjAijUnce/6kbEeF0Dg2g+MtxlbqOp4IIidx5yZagZWLyG1mMhu9jj8QJjHgJHaTXrYoBxWiN7j8Bi/R72xLOIxzloHpA3X/6MeNKzD2g6BUZEpcuVu3MiFkYncDEmi768WTSRrNphVHBs6gAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sD9SzhQj; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761337829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUAc7RyUs/W8P3y6SnjtTEvtL3gBSKAWO9I3OtKKUT8=;
	b=sD9SzhQjlOjtKL1woGx3mGNpYb1wkdGlAcJHLUr+y+V5Y4WWsIudhfcQT+aI4FEBMrTUjt
	id+AnqQCxynrDsy+hWlLpv+tmlP5WQDHtbSyihS4VkjetUg8dBoHqfOdDhf01lQws4RY7Z
	ItMf9dbP12KBmABelSybbtQ2h9MJACU=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] keys: Fix typos in 'struct key_type' function pointer
 comments
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aPvNqCRlMN5c8GaR@kernel.org>
Date: Fri, 24 Oct 2025 22:29:57 +0200
Cc: David Howells <dhowells@redhat.com>,
 keyrings@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E9856573-8D4D-4392-9AE5-5D40D1FC13F9@linux.dev>
References: <20251016123619.98728-2-thorsten.blum@linux.dev>
 <aPvNqCRlMN5c8GaR@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 24. Oct 2025, at 21:04, Jarkko Sakkinen wrote:
> On Thu, Oct 16, 2025 at 02:36:19PM +0200, Thorsten Blum wrote:
>> s/it/if/ and s/revokation/revocation/
>> ...
> 
> The comment is also formatted incorrectly. It should be:
> 
> 	/* 
> 	 * Free preparsed match data (optional).  This should be supplied if
> 	 * ->match_preparse() is supplied. 
> 	 */

The other struct fields are all commented with the first sentence
starting after the '/*'.

I can fix this one trailing '*/' in v2, but the others should probably
be fixed in a separate patch?

Thanks,
Thorsten


