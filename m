Return-Path: <linux-kernel+bounces-791249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3FDB3B3F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF0E3B016F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E6526CE33;
	Fri, 29 Aug 2025 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tC760mO2"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8ED25DB1C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451410; cv=none; b=se4pyhvaZnlOU6S6oAN0EmtjtYzF43qiKXFWOagvpJIQhe7Liz9TE5ctZZh21XJ213mRs5AhRxAKYinIcnL1zSseKslYdAtsxyGapx90iX0Nd5axAp/b3BsvAbswMEtjSSsTru44znh1ctLs6AZZ882nQUvvLdSX+y57RjBCNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451410; c=relaxed/simple;
	bh=GEZJSdMVr8jEWDwiStZPcrDToMn7PJQ6fBpbI/fDuo4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k6ZJkK4K4kLCoRhJPWHvHRxgPUl2MAEd3Pkuqa26ZFyVDu5ymRnVWmaR884tg+ctKqgpB08oXKVsSLApiTc3NjxwO1Llopf3TrBj1q/1EFMMYLw9qwtM5r3Sp4tuOYEYxRVsEFdGVW2qWeFIt9r9y38RFTM0ucYA4InTLcx9ihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tC760mO2; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756451406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdyTtGA3RngFs/+6P0WIzZYVPbL0BTK0wphPMTsKdw4=;
	b=tC760mO2I2HzExOQxFGRr+rEJGVNw4oOVON3qZDJSNiHIYsWznw6yjCWy28xI1//KifqBr
	MVLkVmPeRSxImqq7ODmnfZ6mAVv+OsSWOXY3zRR7i6cwGJfWiLZspI+7spQkqRzZuLjuFD
	7vrXSf7r1t6RWASDA7744VJ/yGRE1sE=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND] usb: storage: realtek_cr: Simplify residue
 calculation in rts51x_bulk_transport()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2025082922-almanac-derby-632d@gregkh>
Date: Fri, 29 Aug 2025 09:10:00 +0200
Cc: Alan Stern <stern@rowland.harvard.edu>,
 linux-usb@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B58E620-723A-41D3-9EA2-81159009A818@linux.dev>
References: <20250828162623.4840-3-thorsten.blum@linux.dev>
 <2025082922-almanac-derby-632d@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On 29. Aug 2025, at 06:34, Greg Kroah-Hartman wrote:
> On Thu, Aug 28, 2025 at 06:26:24PM +0200, Thorsten Blum wrote:
>> Simplify the calculation of 'residue' in rts51x_bulk_transport() and
>> avoid unnecessarily reassigning 'residue' to itself.
>>=20
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
> Why is this a RESEND?  What happened to the first one?

This was patch 2/3 of a patch series that doesn't apply anymore because
you asked me to submit the bugfix in patch 3/3 separately [1].

Since the series doesn't apply anymore and patch 1/3 didn't get any
support [2], I figured it's best to resend this one as a separate patch.

Thanks,
Thorsten

[1] https://lore.kernel.org/lkml/2025081358-posted-ritzy-bd3f@gregkh/
[2] =
https://lore.kernel.org/lkml/20250813101249.158270-2-thorsten.blum@linux.d=
ev/


