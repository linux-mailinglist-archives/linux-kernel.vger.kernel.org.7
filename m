Return-Path: <linux-kernel+bounces-827884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A12CB9359A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD7548050E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FED283FEB;
	Mon, 22 Sep 2025 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tXLvEXO+"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0543628505D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575478; cv=none; b=MiCUNNr78iOMa58jFYwdupkwZpMf7OgVhdngcyl0wJhMA97GjJ1f9ZVpDr7l8LSwzihoVOXBBg9EM8Zrc+00/gu41XhaRcKuGN9Zm4QUN6rhlKESkK+8BNShT+1ojHKJaFPLNv1rTZK/4waefjoh9IW0NjH936GBgDne0bbQqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575478; c=relaxed/simple;
	bh=XzbjLdGwdorUgzFZNNHEJOdjHSCRBfkUY7BNS5tTsgU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KXbzgGECxiI0w2coIDVbSeE71rD3objiY4Yc0twoGB7/AE+Cd/CfItFP0JPJn0mu3xAKxGwgeFfu2hTh96knn1NRZnnfyWBOFXE+EUxFbAmQzlKCGuqojMQM1GS3nNQOn6fPDxU8+npV8CKh4BjxI80LcMECpTxvTL4TQTPQgpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tXLvEXO+; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758575474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzbjLdGwdorUgzFZNNHEJOdjHSCRBfkUY7BNS5tTsgU=;
	b=tXLvEXO+0G3oeMOAVCtE/toOx3oPlmimyv0uE412gaNkTB2AaVt2Cc3MGWaCvL6Vhfhz9H
	ZF00ApxeA8gwQWXuJUgDEbTfTAhwPiRWCJ2ncpwo6s6rVgBfhn/zuCByW/TyqTAe1yDIOA
	aBOxccPN0zk07+h6eKLoOQQnJrxRkKs=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND] sparc: PCI: Replace deprecated strcpy() with
 strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <d676606e-f448-434b-be26-c839dea4f5d1@gaisler.com>
Date: Mon, 22 Sep 2025 23:11:01 +0200
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-hardening@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <57FABB07-3C1B-4D33-A5BB-8D402A20487F@linux.dev>
References: <20250917155038.GA1852582@bhelgaas>
 <d676606e-f448-434b-be26-c839dea4f5d1@gaisler.com>
To: Andreas Larsson <andreas@gaisler.com>
X-Migadu-Flow: FLOW_OUT

Hi Andreas,

On 19. Sep 2025, Andreas Larsson wrote:
>=20
>=20
> On 2025-09-17 17:50, Bjorn Helgaas wrote:
>> On Wed, Sep 17, 2025 at 04:47:30PM +0200, Thorsten Blum wrote:
>>> strcpy() is deprecated; use strscpy() instead.
>>>=20
>>> No functional changes intended.
>>>=20
>>> Link: https://github.com/KSPP/linux/issues/88
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>=20
>> No objection from me, but no particular PCI core issue and I don't
>> maintain this file, so up to the sparc folks if they want it.
>>=20
>> I would consider making a single patch to address this issue
>> everywhere in arch/sparc so it can all be reviewed together.
>=20
> Thank you and sorry for the late feedback. I agree with the above.
> Thorsten, could you fix this for all occurrences of strcpy() in
> arch/sparc?

I just submitted a small series [1] replacing all occurrences of strcpy
in arch/sparc.

Thanks,
Thorsten

[1] =
https://lore.kernel.org/lkml/20250922210408.1723452-1-thorsten.blum@linux.=
dev/


