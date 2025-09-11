Return-Path: <linux-kernel+bounces-812709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F28B53BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BCE16FAAA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C856B2DC78F;
	Thu, 11 Sep 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dhqE+MUG"
Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8191B2DC77E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616016; cv=none; b=VP96dtm9NLObxJv2JULR6Zrlxo5nKuEm6i3fDZ3JuQSfWQze3+yKHT5ZaPbLgFJdE7Hgwpwql8WDE3i2kSiFY5Y97etzK4a6oONsMxK9fch1CkBuBUZ4gtzlbx/9BTpL7OX0h7T81NVBcMyp/DHBIouPVoS+VUE+N3S+Sm+j7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616016; c=relaxed/simple;
	bh=CBLCtg/bjrDjIxEQ2uJLcZ9eKg1J7B0cpzHMd/YdBk8=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=X3KmqZQEKBX9EVI5DMoW5v0eHR25l6/rFxN+Ym6zViIAPhoR0+cwbPK1cO2ZT3ATN7Xej68QHRj9BYgMzqlne8dPkV9VNJDX6GX6zrky7nfRpENBMFYFcyYlzBgtNBuZnnB9ewY8n/VwkpWNW5fWGBgJebiPAYtHF21WrFfxsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dhqE+MUG; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1757616005; x=1757875205;
	bh=CBLCtg/bjrDjIxEQ2uJLcZ9eKg1J7B0cpzHMd/YdBk8=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dhqE+MUGkusBG3JEheb/vg6DuB7G8iiNJo6Q25XEBdBZd016IlvJLcQCZMrBKEItj
	 NSQY12th92AetAKm2m8SihxWeFR8CW2iAamhBE23Wtd6u6IKa2y+guRClQllUjHzFr
	 z8Ok46AlAx3xhDdQ7dxKcSVEUatBd4VCjFuP6Li2nqBUu3wB72+zmbpyMOC0W7BLhX
	 X1Fu6uGMtP+Q3FhdQXPcB2C6yN2goNqxrVtPwaHgOhPx3aVNz6RpZYWW3W/yq2NNev
	 CBhK6L/BDn938IMqWS20xdEVLEOijpHYLQ3FYlWtz7WlkX2zDjm+7u5MF2nFgZk+VA
	 djXkZu/N/ZlfQ==
Date: Thu, 11 Sep 2025 18:39:59 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: DistractedLinguist <DistractedLinguist@proton.me>
Subject: I got bit by the stochastic parrot when apologizing (to LKML and Alexander Viro; by Hans Reiser)
Message-ID: <js2F0hMRQx22Zft8fmp1rPPcQnrU1Q6Gpd9-wrguyWL0qepBKpbaJ5k6YHTw18ok2HTKz2WZNfUiS3kdxDICKZ5sNzlckrCViYqjMzZPzEM=@proton.me>
Feedback-ID: 159306980:user:proton
X-Pm-Message-ID: ea074a16638282b2a567191aec1eb6325ab9a2ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Editor note: Mr. Reiser sent this to me to post on his behalf. I will print=
 and send any replies to Mr. Reiser for his review and comment.=C2=A0

A kind journalist scanned my handwritten apology, and it got posted all ove=
r the place. The original of my posting can be found here: (https://lkml.or=
g/lkml/2024/1/18/245)

"Viro was this guy whose career focus was locking."

The OCR software changed the "o" to an "a" to make it:

"Viro was this guy whose career focus was lacking.=E2=80=9D=C2=A0

Everyone must have thought: "He was an ass then, and he is still an ass, pl=
us he sure has that wrong."

Alexander Viro knows more about locking than I ever will, and it would have=
 been a privilege to have been able to learn from him if my social skills h=
ad been enough to earn me that privilege.

I can see that for a stochastic parrot, which understands word pattern prob=
abilities not word meanings, "focus was lacking" is a far more probable wor=
d pattern than "focus was locking". Sigh.

My humble apologies to Alexander Viro and the LKML.=C2=A0

If people are interested in my experiences of humans being worse than AI's =
due to their stochastic parroting being more affected by what they want to =
be true, or want to hear, ask me. It might be off-topic for the LKML though=
.

I humbly apologize to all those in the community that I hurt by my crime, i=
ncluding those who invested so much into coding Resier4 for so little pay o=
nly to have the dream we pursued dashed by my terrible crime.

If I should parole I will try to make all the amends I can to those I have =
harmed. In prison we learn to start by trying to make a "living amends", wh=
ich means to change who we are so that we are no longer the person we were =
when we committed our crime. I have been working on that for 19 years, and =
I believe I am no longer the man I was, but instead a man who understands M=
LK's words: "only love can fight hate.", a man who has gone from having no =
patience for the Serenity Prayer to understanding just how much it can impr=
ove my life, and a man who is now more humble and more eager to take the ti=
me to acknowledge the ways in which others are right.

If I parole I can attempt to do more "indirect amends" as prisoners call it=
, in which we try to make up for our crimes through acts of service to the =
community. I have some chip design, filesystem design, economics of free so=
ftware and AI design ideas I will pursue if I am found worthy of a second c=
hance in society. (Details if asked). Alas, I cannot make direct amends to =
the lovely person I killed.

Once again, I apologize to all. Humbly apologize.

