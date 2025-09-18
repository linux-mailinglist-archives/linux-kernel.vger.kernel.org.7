Return-Path: <linux-kernel+bounces-788075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA872B37F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC95A3ACAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C116F3451BE;
	Wed, 27 Aug 2025 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="gr7ETH0E"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538402750F3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289131; cv=none; b=JJjje6LyC7LFr0Z/maZ7jACYrYS9IiqjhmF2JZHHUkwLUPeksSHvHkMEgYQrroGcUynI+CCseCUFcWRavlAPbY3Nd5OTpeifFzSyLKLwQaGq2FEP0EmVl13/tlRbJnKj9jmHK4WQ8LC6EIY9/y0PS2s7VS7h/PJ3V0sP7perhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289131; c=relaxed/simple;
	bh=uDtonrv5F0Tm13HEdeo/NT4DyHYzETvrQtYYJEQ4+Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgI9o63Z6VFUby2w+Rm/aogE3Ey5XOTbKgTtlbE3vtgMhtKXXN125AIpOW48mib64ai++wRXSM0RLUQoWDRCHi25xdUJENhoBDdM+LW7rkZAMa8IXTy4+6rQHETxnruW6AkY6icxRJ3a2SBvy6NdzsDYDSxEryOfiTpHTxuY64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=gr7ETH0E; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id qyaPu7Hn4A1smrD1zu6Tpq; Wed, 27 Aug 2025 10:05:27 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id rD1yu0BwGCNkwrD1yulQrR; Wed, 27 Aug 2025 10:05:26 +0000
X-Authority-Analysis: v=2.4 cv=QO1oRhLL c=1 sm=1 tr=0 ts=68aed867
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=DR2cKC/DEnBA9KqqjaPhpA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=g_siC_MSOhsqshzUI34A:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6PngVi7LJ4k5lnqjspPjNk39ZzYBo+04kKzgOBdbfns=; b=gr7ETH0EDL2tSYMtLr7QuhmRH1
	bmRGHsxJzzZc6h1l+EqB9Wm9r0iNrukYEB6KLMYBfjkgzgSLk5b3bYfH1oFkR11jR6w3X4uUeb3ws
	Sj+EK+jPwSULVeAC0gCuMZfjFtIW/RNbLQsrgM0UU8hZ3lLoPNMx7qBlA90aIUEFFJlNY8F3oQlab
	35qlvrSGdEXMTgKxDJtWVDTXNXaLptCYQxh5Wck3BdzMqVykMZD1VY2Ey23O6hIMA6FnylpUZues4
	i00Uuy2O21B+2/gh2exX9NpBw1upCuorMeFb6LkOcT0G2f4WVCVEirCFe6dC+JD5O15caXteI6R7x
	pX9QA55Q==;
Received: from static-243-216-117-93.thenetworkfactory.nl ([93.117.216.243]:58552 helo=[10.94.27.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1urD1x-00000003Hmi-2Nz2;
	Wed, 27 Aug 2025 05:05:26 -0500
Message-ID: <2b54967e-bd1f-4ad9-bba7-aa05bf3d1e7c@embeddedor.com>
Date: Wed, 27 Aug 2025 12:05:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iwlegacy: Remove unused structs and avoid
 -Wflex-array-member-not-at-end warnings
To: Johannes Berg <johannes@sipsolutions.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aJl7TxeWgLdEKWhg@kspp>
 <e0aeda2d-931c-49c6-b0d4-dd097e87eae6@embeddedor.com>
 <0ef7587b7ae57d9363312ca130980707a68a3f7e.camel@sipsolutions.net>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <0ef7587b7ae57d9363312ca130980707a68a3f7e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 93.117.216.243
X-Source-L: No
X-Exim-ID: 1urD1x-00000003Hmi-2Nz2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: static-243-216-117-93.thenetworkfactory.nl ([10.94.27.44]) [93.117.216.243]:58552
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFJlpF9igi9eTGCpvRU0R8SwOoWcGqFa+y65LMXOlcyiXbpWg/mG+Fwk6stumzuFm/QgMT2DiCAfEqPtAqwNXUY6x21e3ApdwVWSRCybt/n9svg3a7FD
 F61hgy06ghQzEZVg0jRcS/cPADskocMYd3U4d17vvjR8QZYiU+QTvwPCMl7lj/nYrkxUWpK8CZsX/srfIClrvSSpSlG8PikimJqrbUqCBe9KpMi1WW3dwNPj



On 27/08/25 11:36, Johannes Berg wrote:
> On Wed, 2025-08-27 at 11:25 +0200, Gustavo A. R. Silva wrote:
>> Friendly
> 
> I contest that. It's been two weeks, while it's still summer with

Sorry, I don't really know when people around the globe are on vacation
or not. I don't think we're based in the same area, so our customs may
vary.

> vacations etc., not long after the merge window closed, with weeks to go
> until the next release comes around. Why are you impatient?

Apparently (and according to git blame), the last person that committed a
change to this file was Greg KH back in 2019, see: commit 16da78b7b580e
("treewide: Replace GPLv2 boilerplate/ reference with SPDX - rule 270").

So, rather than impatience is more about not really knowing who's maintaining
this file.

> 
> I will take it. Eventually, the more you push the less I want to. And

Not sure what to make of this. I'm just doing my work and trying to
collaborate with people. I expect all my comments here clarify the
reason for the ping.

> it'd help if you actually followed our conventions and used 'wifi:'
> prefix.

Related to my comments above, you're not listed as a maintainer of this
file. If you were, I'd have probably remembered that.

scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
Stanislaw Gruszka <stf_xl@wp.pl> (maintainer:INTEL WIRELESS 3945ABG/BG, 4965AGN (iwlegacy))
linux-wireless@vger.kernel.org (open list:INTEL WIRELESS 3945ABG/BG, 4965AGN (iwlegacy))
linux-kernel@vger.kernel.org (open list)
INTEL WIRELESS 3945ABG/BG, 4965AGN (iwlegacy) status: Supported

In any case, thanks for your response.
-Gustavo

