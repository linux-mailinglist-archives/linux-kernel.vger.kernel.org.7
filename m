Return-Path: <linux-kernel+bounces-817658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6956BB5850C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73703B6B33
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC9F28135D;
	Mon, 15 Sep 2025 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="SsQ0ITuy"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AE016EB42
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757962832; cv=none; b=klSOvAiJIRRaURqSfWo67tdShdddyDr/MbATx3GvStBHbcdeN1LeYrsykNRDBxX0rkwPaTYRbAH5m1ieeol/85Achfifbh0RtjdGl5gcwJyvXm+Yrb6UnLpD3hkgtIOlMrs8UBTXdMEpH9Qz3plq8oa54KwH10WWjRmVQWkHZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757962832; c=relaxed/simple;
	bh=Y6a6sZnzeW2F2Gn+5O0zLJq+HCMmLBinmNAxZ+66w1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+mp2PWku+AHf0Yrve0BiBwKtn7UPn7PhDh5BRAIXhdL60MpGjoDfSlUr0xmQ281YHI2TW1W+VhE9B/WOsNYL919fqKcQlLhlJ0Obe0Asra/9rFegL3GngMaZqrEWDBgCETwMb3W2SoMAqwpdGysRna+8dwnxGpxg+BrraLZwBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=SsQ0ITuy; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C92E6240029
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:00:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1757962827; bh=FiSuNHGevmd26kBGyenDRGXjSi97SCJVo++uujoK+0o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=SsQ0ITuyhOTb25xjfdO8+Ydsp/8Ma/oFkslyTAMMwVVhslP9m9qJnlNQzzKxkfjF9
	 qdNwgWjPiRjmvzeeBeQ7U/thcyeUPRIC1OU6NQtKx/1niurLL3FMUZu9jjRIlh2k+f
	 uKHuLCpQUUD9wXWFhCWY1WEadjFUrNfxXaO8kqFJYCLgtAb/U1UlzNk4RmOQcpt2kD
	 f7cpLRXNpNVume8sF4UVStc1Dy8EF6SVi17SKIv1OjIj2FN+1ywwBN+JEApACvDqFO
	 bN9eV5VKVelrhIOlsb9UBqRBO5rIAbONAV30aj1Oxtg4HiJBwfPiH0sgYWc6Evb5Jl
	 cMTwnqZw67WUQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cQZ9N5wG8z9rxG;
	Mon, 15 Sep 2025 21:00:24 +0200 (CEST)
Date: Mon, 15 Sep 2025 19:00:26 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Andre Przywara <andre.przywara@arm.com>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= via B4 Relay <devnull+j.ne.posteo.net@kernel.org>,
	j.ne@posteo.net, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Initial Amediatech X96Q support based on Allwinner
 H313
Message-ID: <aMhiSDKgc7lnv802@probook>
References: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
 <20250912110222.5e4153ec@donnerap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912110222.5e4153ec@donnerap>

On Fri, Sep 12, 2025 at 11:02:22AM +0100, Andre Przywara wrote:
> On Fri, 12 Sep 2025 01:52:08 +0200
> J. Neuschäfer via B4 Relay <devnull+j.ne.posteo.net@kernel.org> wrote:
> 
> Hi,
> 
> > This patchset adds an initial devicetree for the X96Q set-top box.
> > WiFi, Ethernet, and HDMI depend on drivers that are currently not
> > available in mainline Linux, and I didn't enable them in the devicetree.
> > The builtin infrared receiver produces IRQs when a nearby remote sends
> > events, but I have not checked whether the events are decoded correctly.
> 
> You can either do a simple "cat /dev/input/event<x>", then check whether
> keypresses generate (unreadable) output, or you use the "evtest" tool to
> decode some information:
> https://cgit.freedesktop.org/evtest/

I get nothing out of /dev/input/event0 (the sunxi-ir device) or
/dev/lirc0, which is quite strange. After putting some printks into
drivers/media/rc/sunxi-cir.c, I do see the raw events, but they are
somehow not forwarded to the input device.

> 
> But I guess if you see interrupts consistent with remote keypresses, it's
> a good enough indication it should work.
> 
> Cheers,
> Andre

