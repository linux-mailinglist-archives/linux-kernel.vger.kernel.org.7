Return-Path: <linux-kernel+bounces-763167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACD5B210F6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C79D7B701D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6E52D6E7D;
	Mon, 11 Aug 2025 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Su+kSvpi"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561812D6E5A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927894; cv=none; b=Sa0lucFDC2PTlPqUlK+TkRAmLrg5Of1/+a5VJq8PTjmiknrIpAgyDlmnrBxp1XHzeO4km5Cbdih+d2ZZda9zivu8+M6NVt4DQsvtWDuBO5esrRALY8wBB90nOevkEQbxkejOfWN7Xip/pTUgtT/UGSgBht5B8fCD33zZVppPUTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927894; c=relaxed/simple;
	bh=fpvWnWdstGhbljo+hLXM9cxY4szZeXds+846MREusvw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JgZTOEDawApfeU69BPUgaP+Tob08o2/sEbkCTHPrM1JB+KyAZ8/warIG3E7rkgmQn1IvMr7sjuVGf6i1y6OXtM+2r9EEGcY1D+pPYKLovPuxXuZQpWG/SagElKjmlBJ7YXwMPjQYOOtxfnIKvZ6ph7IW9ms9DBDgx+kVv3GTqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Su+kSvpi; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754927890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uoUpDe04kmJ8+YWdTwk4QpPH+xCmB1Y2gfij6uukA0=;
	b=Su+kSvpi9ss6b27TG52pBqxc/KH/hbs0pmQl4uC1V3r/aRLNuRtQ9pb2yM4F6xwQKgn8T0
	OCppXHF6WHTS2kc45qEf6OQjcZfrHFijnSytE9r8/IMiVPfjwLkwMU344Jw0nm6zOEXHnD
	crW2wyHpQMk7/XlOSxalk0bXZY3xpMs=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] dmaengine: idxd: Replace memset(0) + strscpy() with
 strscpy_pad()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <5ecf9433-5de7-4e52-b246-bf17d0cea776@intel.com>
Date: Mon, 11 Aug 2025 17:57:55 +0200
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C2F1E020-7F59-4545-814D-B05FBE2D7C22@linux.dev>
References: <20250810225858.2953-2-thorsten.blum@linux.dev>
 <5ecf9433-5de7-4e52-b246-bf17d0cea776@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
X-Migadu-Flow: FLOW_OUT

Hi Dave,

> On 11. Aug 2025, at 17:37, Dave Jiang wrote:
>> 	/* set name to "iaa_crypto" */
>> -	memset(wq->name, 0, WQ_NAME_SIZE + 1);
>> -	strscpy(wq->name, "iaa_crypto", WQ_NAME_SIZE + 1);
>> +	strscpy_pad(wq->name, "iaa_crypto");
> 
> Should also supply the max length?

The third argument of strscpy_pad() is optional when the destination
buffer has a fixed size. strscpy_pad() can then infer the size using
sizeof(), which equals 'WQ_NAME_SIZE + 1' and 'DRIVER_NAME_SIZE + 1',
respectively.

Thanks,
Thorsten


