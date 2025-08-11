Return-Path: <linux-kernel+bounces-762727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BCBB20A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59795188A1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E692D320E;
	Mon, 11 Aug 2025 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="DaoG2BtZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l5kV/e4x"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AB414658D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919188; cv=none; b=WFJwHG0/QBOTuCtXPx/8HUB4Tg/dnRlvThd7jMe9pOchjKFN32K3a38KcPvJctREnZJEcQbK8WZAEjeeeNSLdcTvrmVFJ5qkAjSXDg39eH9gu975pfl4I27lqwzLP0DGzEZQHlPfbZhrCT44dDfLd/PvfYDWI+COMj6pXsaRUWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919188; c=relaxed/simple;
	bh=ZoemS5u5qP25Lthyu8rS7BWn0iX48sbwwjfZ5ILVf9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeMmj6WhhFJy/EA2cJuDD4vIHOwoO5kg0OtLEvUjIoVx8ubbwwKQox5TPmd98jooMSGIi8vTy9eHhv6SeUYd3SRplRSmw33za4kjjJjK4DPuMlvKI8ueOxwA3oGXDMWkEkTJz1xxyM4NJEc39B0PkAEbURHn2tqJcxfs3nVQh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=DaoG2BtZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l5kV/e4x; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 60613EC0013;
	Mon, 11 Aug 2025 09:33:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 11 Aug 2025 09:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1754919185; x=
	1755005585; bh=gctimxa54HqQNQrX29F+qPQpcXdjoL5nPuvFUUnFTC4=; b=D
	aoG2BtZ/ICU0i4bY2O7xY+utMpleQ6+0Ne1EpD04p7ARiqnTIxTIpLUUuNEMYL4E
	7SqERMY4L7zepf3ktv3w8AaE3IJocxlpGBhvI0auV4lnm7ikj/hiae7cqaf+GcK6
	5JnR/8RHWEplr1fZCr460gsS9Ohb1dAJ1LwkSArY7wOVe3xWq+d4SvRk7SKxr5w2
	G5gH49fnd5lxucgEym4sLsw6srClhp7pvNjnynuVTzeIemDjjSiq7knzwSqH/rg/
	tkrwRmW8MXGl7+hwmoTVqpsWu9HIHzPtrj2HghQEO0tKr5cZrCK8wmXnG9JPI43o
	o5MLfEhWh6BUQ5wagr+aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754919185; x=1755005585; bh=gctimxa54HqQNQrX29F+qPQpcXdjoL5nPuv
	FUUnFTC4=; b=l5kV/e4x5bY/nQoZ+5xj8bmP4ioXgMsr0Det//KAAz2bVNpuodj
	GMsK2a2lp+9JUJPAFQg7kB3icwq/Y8moEfZLDuoSk7/LW7zYp1KsT8/76EGbkGOf
	5HNfxzjeyyeFGdh0mlIYZ4wGByARxNwQLkYTLpRrZQ3O3O2iHGqs6ARLH0Tev/Ii
	QMLaCeAnUvNRj9EE7wlnLhDDbaCxBPcg6xoFWehuuX7q77RRXrVrd8z4wZ+lFXSJ
	AXMvQObRcJvtYxeCWE0wTy05yXorntefgVFaLQvI/yilHF6+pJe1T17eMHI+2wY1
	+Le+o4HS4CfYQvRt8pdhIBECzMKTc3n1KgQ==
X-ME-Sender: <xms:EfGZaDrY4q21TojA8ECLFgZKaNPXWKXyrOwMWN5OnpUnsTE3Agjt3Q>
    <xme:EfGZaEios-NQx1YSMmjX7UZfslqjhxcM3VTFTikFEcUkEcEQOJ1sye1wq-krgCmvA
    pvo5p-MfnFjoRavDW0>
X-ME-Received: <xmr:EfGZaNLXoPlb8lD7HZagK7e9vKSFEfDxnbRSiBi-XwoKEG5mMtkdh1XHCTdvJLCm7Is8pD7rLicHKIVFGd1nLjnHCN9dxVyVRaI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevieelhfduke
    ffheekffduudevvdefudelleefgeeileejheejuedvgefhteevvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvggumhhunhgurd
    hrrghilhgvsehprhhothhonhdrmhgvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidufeelgedqug
    gvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvth
X-ME-Proxy: <xmx:EfGZaECazUry70UhWLDFtdCDjfo-hnJpXz4jvDZbo2gpq0Am0DcU8A>
    <xmx:EfGZaNjtTqgtFTWngQU0EFIs1TQulQHVCMdHKTHpqupiUY6ySiHSFg>
    <xmx:EfGZaMliVZTV31-wnr4ppumS_VWOENL7EthTntR3YX4uQIvLEvwQWg>
    <xmx:EfGZaJqzhxdZeYHjMLfvBZJKyDwuFFbr93k7_g5iJZAgKC3j2WtvPw>
    <xmx:EfGZaK8W80BE9KCTxAFWrOmbwLttLVarzCiPK9nOZUZnn4cJK1o1nJXd>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 09:33:03 -0400 (EDT)
Date: Mon, 11 Aug 2025 22:33:02 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: "edmund.raile" <edmund.raile@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux1394-devel@lists.sourceforge.net" <linux1394-devel@lists.sourceforge.net>
Subject: Re: [GIT PULL] firewire updates for v6.17 kernel
Message-ID: <20250811133302.GB267817@workstation.local>
Mail-Followup-To: "edmund.raile" <edmund.raile@proton.me>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux1394-devel@lists.sourceforge.net" <linux1394-devel@lists.sourceforge.net>
References: <20250802054917.GA127374@workstation.local>
 <pTURxXSK4yF5-FlMBbpWLMW5JUC2s1BvSYdYGKBAgEOpI9z4RhnQsLrrRj7E2Iu02sOznG5ysKRVpXR4ZWFp-CSeSebIP1YGQl7gbFLGeEo=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pTURxXSK4yF5-FlMBbpWLMW5JUC2s1BvSYdYGKBAgEOpI9z4RhnQsLrrRj7E2Iu02sOznG5ysKRVpXR4ZWFp-CSeSebIP1YGQl7gbFLGeEo=@proton.me>

Hi Edmund,

On Fri, Aug 08, 2025 at 01:50:44PM +0000, edmund.raile wrote:
> Dear Mr. Sakamoto,
> thank you for including me in the pull request, I am honored!
> 
> I tested the combination of this pull request and your fix patches [1]
> on arch 6.16.0-1-mainline (based on "Linux 6.16" 038d61fd6422)
> with TI XIO2213B and RME FireFace 800.
> 
> [1] https://lore.kernel.org/lkml/20250728015125.17825-1-o-takashi@sakamocchi.jp/
> 
> So far audio playback seems perfectly stable:
> days with varying CPU load, compiles, even mprime.
> Suspend also seems fine, even without first powering down / disconnecting
> the FireFace.
> Direct ALSA streaming or pipewire, no issues so far.
> 
> Tested-by: Edmund Raile (edmund.raile@proton.me)
> 
> Thank you for keeping FireWire alive and even developing it!

Thanks for your test, however it is my previous proposal. The latest one
is "[PATCH v2 0/4] firewire: core: call address handlers outside RCU
read-side critical section"[1]. The difference between two proposals is
just to use kalloc helpers instead of XArray for FCP handlers allocation,
thus not effects to your device.

Anyway, thanks.

[1] https://lore.kernel.org/lkml/20250803122015.236493-1-o-takashi@sakamocchi.jp/


Regards

Takashi Sakamoto

