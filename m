Return-Path: <linux-kernel+bounces-769155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89407B26ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6AA58347B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62D121C9F1;
	Thu, 14 Aug 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KieuXxH5"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F9D21ABA4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184693; cv=none; b=nkWWJeilb2pHMc5sYKU5MRgFyPYJZM2KCXr5OR4HZl2lN25qnCYEa+wXOoR2+2X0ssPyQhWOrSE3qk4SWM5Ed5g9OmDnly22JCHyZ8EG6yzWoA6V3PLAXk/OcmQ283Kg9apvuA6WkGX19rjmGOCJDHbFTipWy9O8eggAiQPhmBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184693; c=relaxed/simple;
	bh=Ndckxh7GaSyKcvALgicX44P7JE+Sh8R8ujffyQhX8mk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gmI1qwe9wfIsJy7S9tu2X/+eUnv2/Zlc6gJ13NMLiFyTsv0LaVyraWhrZ1ESLg+QXFi4HabqgyDTBHrmi7TFyltW5MDf0CuarJi4F+SCxd2c0tYnFP0/tLbMEDIPomxZ3wsIU3lKSyikXpw9KDcxr6wjrBzHJuFlHDf3BsaQ4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KieuXxH5; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755184688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zNVCqTGXXgZjRmlbQrG/+iAmbjssxuaVUFkoMWSkGi0=;
	b=KieuXxH5EPJ2rurMTvRD6ZF6ONZgtqA2fAdXzCG4JFTRfDVmljRJoHsxwKrIdPMH0LCx2a
	3PydCZE7gxD6rNpd7kecUoS6vrm7yP6gvTk59IxzJfUhGA4VCQdzeYbDQfqjec+Tb/6oTK
	0Mxebmisb+bkMko+FgvFr9EHOz5x8Zo=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2025081456-reflected-revolver-9f5b@gregkh>
Date: Thu, 14 Aug 2025 17:17:52 +0200
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Nir Lichtman <nir@lichtman.org>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 linux-hardening@vger.kernel.org,
 Daniel Thompson <daniel@riscstar.com>,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <55A7B251-8E1B-4935-B33F-B12DF1A2B382@linux.dev>
References: <20250814120338.219585-2-thorsten.blum@linux.dev>
 <2025081408-swinging-endorphin-abe2@gregkh>
 <2025081456-reflected-revolver-9f5b@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

Hi Greg,

On 14. Aug 2025, at 16:35, Greg Kroah-Hartman wrote:
> On Thu, Aug 14, 2025 at 02:35:56PM +0200, Greg Kroah-Hartman wrote:
>> On Thu, Aug 14, 2025 at 02:03:37PM +0200, Thorsten Blum wrote:
>>> [...]
>>> -	strcpy(kdb_grep_string, cp);
>>> +	strscpy(kdb_grep_string, cp);
>> 
>> If this was just a search/replace, it would have been done already, so
>> why is this ok?
> 
> I missed that strscpy() can now handle 2 arguments like this, so yes,
> this should be ok.
> 
> BUT, you just checked the length above this line, which now isn't
> needed, right?  So this function can get simpler?

Yes, this could just be

	memcpy(kdb_grep_string, cp, len + 1);

because we already know the length which strscpy() would just recompute
before calling memcpy() internally. I'll submit a v2.

>>> -		strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
>>> +		strscpy(cmd_cur, cmd_hist[cmdptr]);
>> 
>> Same here.  And other places...
> 
> Sorry, this should also be ok, BUT it's really just doing the same exact
> thing, right?

Yes, it's the same because sizeof(cmd_cur) equals CMD_BUFLEN.

Thanks,
Thorsten


