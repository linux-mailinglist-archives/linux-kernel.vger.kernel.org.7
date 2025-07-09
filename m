Return-Path: <linux-kernel+bounces-723868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9D2AFEBA2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01BC87BB586
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED96C2E0930;
	Wed,  9 Jul 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="Yhs5qpky";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="8ttn5fIo"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230232DE216
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070740; cv=none; b=cSEgCtenIRQzdO5wJdwA7l9Rp2HVY3rU5uIQcCln+5+LGXDRQF12uUqd654P+xWuSxIXleYkWX3vmIPBfhzaLR3gHaT4B4mUVY91VgsHYEOPbqx3bjaZ62E/5kSb3SuIcYbmjJFiyIvb+UO+VBcmayD11bV3e/xuu8U9gTDmfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070740; c=relaxed/simple;
	bh=VnJBaXi/Msmxn47ZFyx+S85FE7Ie78Jst6FVPQyc0b8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mjaIsc2hAjHAz5anQJwf0QyEIMGiHWK51FQY3BGq4vDg4r+3bz3J9Hdyfe90QWrnw6A8DjqIkJRA/Ghc7U8JUUJcczw5qP2aajsyx/5IFRhwqUkhkWKXDiK6NToOp8BQANVkF0xt4opKXFEblBmKBDRapO2hsTBw0nxJB2bhAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=Yhs5qpky; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=8ttn5fIo; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752070735; x=1752675535;
	d=konsulko.se; s=rsa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=VnJBaXi/Msmxn47ZFyx+S85FE7Ie78Jst6FVPQyc0b8=;
	b=Yhs5qpkyX88l/r3a5QZvhKr/r9cXJdCOTTCzq905ccmtVMw8nvExUFUFUbWjEXJmCX1EuVPm5/VhE
	 w7+OGKw2ypG2OrkkjAp5AB8w5evu7Be4sYA8eLF8o8rigi5AY2V1aKHO0OXhYsAt0VwNpMAzd+bHAd
	 e4gw9Ou4N6SyOuHZQliDbLV6iXYbJ6ARfylqiQgNEbxfyI1CJzYrbhxQU+U1w5XjWq43c32XhI4Tuj
	 kuzMEhFovGHLjonXLeQNbMiToFQHUtMaP8+bPIPwtoayNEGef2uYx3elmZgbn9B79+7Ks5/Z7DtXCB
	 qMZQdCa5PvEa7Pl/iBLpk0cU+KJljIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752070735; x=1752675535;
	d=konsulko.se; s=ed1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=VnJBaXi/Msmxn47ZFyx+S85FE7Ie78Jst6FVPQyc0b8=;
	b=8ttn5fIoya029jtW8m8lwiEvGMfrpZO2CwQMosEgCvdZc45YgqvlRPyccJBmPgaU4VnRujnbXPl8m
	 lScknpdAQ==
X-HalOne-ID: a4241fd5-5ccf-11f0-84c8-f78b1f841584
Received: from smtpclient.apple (c188-150-224-8.bredband.tele2.se [188.150.224.8])
	by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id a4241fd5-5ccf-11f0-84c8-f78b1f841584;
	Wed, 09 Jul 2025 14:18:55 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] mm: zswap: add myself back to MAINTAINERS
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <20250709140635.GA56533@cmpxchg.org>
Date: Wed, 9 Jul 2025 16:18:44 +0200
Cc: linux-mm@kvack.org,
 akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Nhat Pham <nphamcs@gmail.com>,
 Yosry Ahmed <yosryahmed@google.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Dan Streetman <ddstreet@ieee.org>,
 Seth Jennings <sjenning@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BA7713B-99B3-4A2D-85E2-B0059B2F636F@konsulko.se>
References: <20250709123438.794466-1-vitaly.wool@konsulko.se>
 <20250709140635.GA56533@cmpxchg.org>
To: Johannes Weiner <hannes@cmpxchg.org>
X-Mailer: Apple Mail (2.3826.200.121)


> On Jul 9, 2025, at 4:06=E2=80=AFPM, Johannes Weiner =
<hannes@cmpxchg.org> wrote:
>=20
> On Wed, Jul 09, 2025 at 02:34:38PM +0200, Vitaly Wool wrote:
>> The patch removing me from MAINTAINERS was sent when I was on a
>> winter vacation. Missed it then, my bad, but never acked it either.
>=20
> The maintainer change was based on an influx of code contributions by
> new shareholders, but also an extended period of unresponsiveness by
> the previous maintainers on these new changes.
>=20
> You flagging this change 1.5 years later is sort of a case in point.
>=20
> Anyway, the other two maintainers acked it. I'm comfortable going with
> majority vote, and keeping the maintainer list as-is.
>=20
> Thanks

I have a gut feeling that they acknowledged own removals and not mine. =
Let=E2=80=99s get them in the loop to confirm this.

~Vitaly=

