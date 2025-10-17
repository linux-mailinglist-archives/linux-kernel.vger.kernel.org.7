Return-Path: <linux-kernel+bounces-857380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E070BE6AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3725E624648
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878CE30E83B;
	Fri, 17 Oct 2025 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hvLneN0/"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDCB81720;
	Fri, 17 Oct 2025 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682163; cv=none; b=X0ZDXzMbMeoGFRQ9r/iyzjg+jJAPg4maqu12mHky0Z4OS4MwwypUew9Muat/aYEq6lfNBmo9jmdc/38H96MsLvX/Hx4taU+tMAJVdipoEYX5k47JXN4WX7M8GFQkwx2pR6Dlp079Xk8NODDTTuLZq3ebQsyuy9yen3QfNyBr5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682163; c=relaxed/simple;
	bh=ECOUsH1noeAgZRtyf60EKc9L4f4Ba1khmYrgNO6yCKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lmAkiGvbraBOLuG3Xfp5CMEN0fgAYMeRoPfkEPmRgSYUVJ8vBKWrQBYqxpzJrVArxYyIVUs80xjVykZ7izX37sDBGhcHo9LxMPgYK5yTflhDh+sRI59RaEOkoY5r/TL8DVGyxio+TnXdwQ5/t/W3uxM5nq+hcg17FSkdytVMlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hvLneN0/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760682159;
	bh=ECOUsH1noeAgZRtyf60EKc9L4f4Ba1khmYrgNO6yCKI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hvLneN0/Px7YzZp8b/zEB/xqh4Q/3+FDAw7zlSsc4TeURYycGuPdfKTZ3AnO7n/e0
	 dhUJwk5jSVHBT5GDP00eYJSTeCx1s03MhFSu8gi1YqapD10A3v9X4qqLrAAjfvRAuy
	 BA/l/adLjPGmTQp/adoDUvyk1LN2XrKbc9KwnxIpsExPKG+Iq5DN16jA3jB6Rp1NiO
	 18K5D1Ukc3IIEOUsC8W8YSr78oGfK8XoDXz7eJKZiyv3iS8KveEisQFKdE+bXfCKZE
	 2WNy9vSuS+0oONiu+wxcoFIxwrwQyxJfVavPLlBbEFpoS5zT5TEKTvrIFQfIWZUPXo
	 /VJuozz3Mh/ug==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 73D1B6477A;
	Fri, 17 Oct 2025 14:22:38 +0800 (AWST)
Message-ID: <ba2e6b78e59afb7c89e5022770a142ec8c31659a.camel@codeconstruct.com.au>
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from
 round_rate() to determine_rate()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Brian Masney <bmasney@redhat.com>, Iwona Winiarska
	 <iwona.winiarska@intel.com>, Joel Stanley <joel@jms.id.au>, Maxime Ripard
	 <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 17 Oct 2025 16:52:37 +1030
In-Reply-To: <aPEZSY6RC-UVclxN@redhat.com>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
	 <aMatZAX6eFI1RmDH@redhat.com>
	 <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
	 <aPEZSY6RC-UVclxN@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Greg,

On Thu, 2025-10-16 at 12:11 -0400, Brian Masney wrote:
> Hi Andrew and Iwona,
>=20
> On Mon, Sep 15, 2025 at 02:36:48PM +0930, Andrew Jeffery wrote:
> > Hi Brian,
> >=20
> > On Sun, 2025-09-14 at 07:56 -0400, Brian Masney wrote:
> > > Hi Iwona, Joel, and Andrew,
> > >=20
> > > On Sun, Aug 10, 2025 at 06:21:51PM -0400, Brian Masney wrote:
> > > > The round_rate() clk ops is deprecated, so migrate this driver from
> > > > round_rate() to determine_rate() using the Coccinelle semantic patc=
h
> > > > appended to the "under-the-cut" portion of the patch.
> > > >=20
> > > > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > >=20
> > > Would it be possible to get this picked up for v6.18? I'd like to rem=
ove
> > > this API from drivers/clk in v6.19.
> >=20
> > My (strong) preference is that Iwona applies it, but I'll keep an eye
> > out for any unusual delays.
>=20
> This patch wasn't picked up for v6.18. Any chance this can get picked up
> now for v6.19?
>=20
> I'm hoping to get this merged so that we can remove the round_rate() clk
> op from the clk core. The clk maintainer (Stephen) mentioned this work
> in his last pull to Linus.
>=20
> https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboyd@kernel.org=
/

Are you happy to pick this up directly in Iwona's absence?

Andrew

