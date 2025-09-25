Return-Path: <linux-kernel+bounces-833012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7940BA0FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC853273C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB5331354A;
	Thu, 25 Sep 2025 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DFxCrlnI"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9660313286
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824007; cv=none; b=riDL/y+1gVOYOqIjuO/4tucySGkuBjCc/rPhv7XAjc1rxCOxNb76YYJoY3j5XW2xFSNkkI6EAaDcaN2gu7yH+IBMtQNEOqG7p2GeIHZrs8InoMOsUxteUX6za8k8LziSKwr/4XCr400Xm+xHgxwaO808jSLeByal0pvIwxc8z8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824007; c=relaxed/simple;
	bh=LZH9YHW7mPrs0buqxYoniyurTyYOsm0Ano0rkj4FeAM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=d1MutUmxdYDy+Jfkp2ONu72eqd7vlG0Rt4WgwsqX2lXivB0htXW/3Ki9KsaE0oXi1U4cxis+iW9A+8AiZ3///kzHsIDh86WgMAh5MduXPJ7GMl3ng/L67keeZAQc9if+Yhg9f7MP6cR+ABO0Wur1nJ83NdyCDssaCSadqMoIoO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DFxCrlnI; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758824002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UacBu+e7h28pImvcl/11NeynkdBMBbjWx5rs93iSc54=;
	b=DFxCrlnILMnBYmDiPKrRvqoWpNacaT3v3ftHQ4Pk9Vn5+ppuEvneJeR4gnzqLiLDPRnz9F
	wWas/sQFv3iD0BWIzT2x0NwrCc4FfU5LKyiiXI6/u5S4ypinekPqKCTFq5RN7Ae2ZUq6C6
	5S/wKlEI8xegx+GRTNhvCo4cf2rvtwM=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] scsi: bfa: Replace kzalloc + copy_from_user with
 memdup_user
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <yq1ikh7qo5u.fsf@ca-mkp.ca.oracle.com>
Date: Thu, 25 Sep 2025 20:13:09 +0200
Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F0B8FDF9-027D-4CCD-A5CA-91E7B2FF4950@linux.dev>
References: <20250918144031.175148-2-thorsten.blum@linux.dev>
 <yq1ikh7qo5u.fsf@ca-mkp.ca.oracle.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
X-Migadu-Flow: FLOW_OUT

Hi Martin,

On 25. Sep 2025, at 04:10, Martin K. Petersen wrote:
> 
>> No functional changes intended other than returning the more idiomatic
>> error code -EFAULT.
> 
> How can we be sure that this doesn't break existing applications?

I guess we can't because the error code is returned to userspace as the
result of a bsg_job? That wasn't immediately obvious to me.

Thanks,
Thorsten


