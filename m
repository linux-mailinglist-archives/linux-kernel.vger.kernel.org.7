Return-Path: <linux-kernel+bounces-816112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A013BB56F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F61189AC55
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00C7274B42;
	Mon, 15 Sep 2025 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bwExPnFd"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5521F09AD;
	Mon, 15 Sep 2025 05:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757912816; cv=none; b=CdUoK2Z+nppJlee+ryx6DU7cOOqQQFHI9IoHp2zGk3j9Pj09vsO9vTy0kB1UrYzZM0BPAE/2ODftY2EXiMsS0nmTDLWiISea9sYL6tQYVwaH8SsHEAHV1EB9Hxe7hCB53KZ9L3TDQYyx1UqzDIeWjGeSMIfbp6/Q9/N4Da5jCCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757912816; c=relaxed/simple;
	bh=oNMOaL81IkhElHKr2VApsXrxfwnHiJNxSJBV5ekXwTA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Khjy6/C5Nr+Z3UJXG7fGxbf3gUf+I3PsZhr1OZZG8LYJxq7zSJQ8n8b06FvikyvRio30IrJ5rPioTaCYNuIROwVKJSRe+evSg5FWiaN47NRFFey3Pnj6vOIPe55IP2p9w/PGcu4mLMCI3bsdWJlj5cWHbcEfbx/H4422EdpV+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bwExPnFd; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1757912812;
	bh=oNMOaL81IkhElHKr2VApsXrxfwnHiJNxSJBV5ekXwTA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bwExPnFdRLkhCTTi+hk/aoWc+gY5XGZePQgDQN+4nim/C8quuZxzvEFZu002gI0rH
	 9MQhVepzXwruhuA5KoAaeQc1UVV2xJ40DoOw7W6aSSAU39KsCncmJCpaaUbZo6Vhqg
	 /IWyQZ0XW1SBb4NrMgUYpB+Z6F7UQuFy9gpVrgCP5ChIKmMztJMLz8FrXlEoK/OX0M
	 R6Vmg4eHGafzc3EEDbyG3WGrF8dkPqJERJ6wqUddiRub+QPew+DrAs2qpMgSmaY9Yf
	 /13wRgEQSpA7Yf/i1nm+adpnqT6V8yB1yH/BQFxjL8qyojo0YjyFdbOZ+DasjGATJg
	 ljuHfKM4dmbVA==
Received: from [IPv6:2405:6e00:2430:fb15:b2b4:1872:3690:c682] (unknown [120.20.190.44])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F1C9864CF0;
	Mon, 15 Sep 2025 13:06:49 +0800 (AWST)
Message-ID: <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from
 round_rate() to determine_rate()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Brian Masney <bmasney@redhat.com>, Iwona Winiarska
	 <iwona.winiarska@intel.com>, Joel Stanley <joel@jms.id.au>, Maxime Ripard
	 <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 15 Sep 2025 14:36:48 +0930
In-Reply-To: <aMatZAX6eFI1RmDH@redhat.com>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
	 <aMatZAX6eFI1RmDH@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Brian,

On Sun, 2025-09-14 at 07:56 -0400, Brian Masney wrote:
> Hi Iwona, Joel, and Andrew,
>=20
> On Sun, Aug 10, 2025 at 06:21:51PM -0400, Brian Masney wrote:
> > The round_rate() clk ops is deprecated, so migrate this driver from
> > round_rate() to determine_rate() using the Coccinelle semantic patch
> > appended to the "under-the-cut" portion of the patch.
> >=20
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
>=20
> Would it be possible to get this picked up for v6.18? I'd like to remove
> this API from drivers/clk in v6.19.

My (strong) preference is that Iwona applies it, but I'll keep an eye
out for any unusual delays.

Andrew

