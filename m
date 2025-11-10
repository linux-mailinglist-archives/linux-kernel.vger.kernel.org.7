Return-Path: <linux-kernel+bounces-894076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A475BC49395
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7649C18906A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FBA27AC4C;
	Mon, 10 Nov 2025 20:25:51 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A128000B;
	Mon, 10 Nov 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806350; cv=none; b=ohk95vcxcFmrH9Ijt8TEC+iY9U8yQZzYEVT6mAhTiWacwxbtRntRFXdH4KsIWqheg+feBlPz+BoxeVCXr2SaX0Bu6pAAPizOUShcByksYXQhNBBwEDJUvXWraCNGNwYvMXxkpsy2idfi0+HkDpQHjgYiQXg2F514RIqi//ct7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806350; c=relaxed/simple;
	bh=L7qUPrj9zPJEA0pzgGDw3h6kHJ+Q94P567LKoLIHNrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxbVquqXGuZ/z11IWKBtG3/y2sYNsB78HxLE3/v7rmnLg9EcDTCwkxmoWOeDh0NYzZyGJ08clODP0HOju4KfhditmdFZsxh3sPuLIPjGX44gUWlSunzfjvBFyf4CCuPpwzHDVAeJzXthM81Venmlsfg+vV6hDaa/WxJPh7VgaMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id E50C11DF6C3;
	Mon, 10 Nov 2025 20:25:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 0D75E20023;
	Mon, 10 Nov 2025 20:25:41 +0000 (UTC)
Date: Mon, 10 Nov 2025 15:25:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin"
 <hpa@zytor.com>, Mike Rapoport <rppt@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Christian Brauner
 <brauner@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Vlastimil
 Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
 "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>, Dan Williams
 <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>, Sasha Levin
 <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kees Cook
 <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel
 Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <20251110152550.5d462fb2@gandalf.local.home>
In-Reply-To: <20251110-spiffy-intelligent-cockle-efde1e@lemur>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
	<653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz>
	<20251110-weiht-etablieren-39e7b63ef76d@brauner>
	<20251110172507.GA21641@pendragon.ideasonboard.com>
	<CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
	<aRIxYkjX7EzalSoI@kernel.org>
	<CAHk-=wir-u3so=9NiFgG+bWfZHakc47iNy9vZXmSNWSZ+=Ue8g@mail.gmail.com>
	<A274AB1C-8B6B-4004-A2BC-D540260A5771@zytor.com>
	<CAHk-=whczwG=+-sAzoWoTY_VOwdFH3b5AkvQbgh+z98=p1iaXA@mail.gmail.com>
	<20251110145405.5bc87cc5@gandalf.local.home>
	<20251110-spiffy-intelligent-cockle-efde1e@lemur>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0D75E20023
X-Stat-Signature: 4eg9c48ys38wj9qpyxq11fmcbc9ciep4
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18oPbG4zobniY+OHcdjesyIJghSfa8m1os=
X-HE-Tag: 1762806341-920127
X-HE-Meta: U2FsdGVkX18Hbux9ScpxOgizMIUE0KT/uDM4MaDbvfNrCyqytGrUwcnSTuiDWg4T+RrHg9NQu7mrlSMeN2t4vFqxakNFor5ewPY2sMqfE2tbCH9Ef8y7I1LYA93L17rlre0JZWI/RWsyu3mCNLcfVWkyxtd6UPH87ppYUe+I2xLwl+NNtSH9szvRrqGjncV8xXuKrpa3F97FrFH23VS0pFWQKUlplK0lGQnnIjk2C8Ea3y73lOD5/lTqp1qBFMWemnbIV8/N6iw0A2YPEps6FhfxWZLzzBcwK9mBmemOAmNbHp49tyA/9OEm4tTpXVNoXMhPXE2yjqiJR1jq85D/HjwvPQZkydqFjvkOcupu1E7kxKEKHn/769eJpneGszCD

On Mon, 10 Nov 2025 15:00:54 -0500
Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:

> On Mon, Nov 10, 2025 at 02:54:05PM -0500, Steven Rostedt wrote:
> > Probably no difference. I would guess the real liability is for those t=
hat
> > use AI to submit patches. With the usual disclaimers of IANAL, I'm assu=
ming
> > that when you place your "Signed-off-by", you are stating that you have=
 the
> > right to submit this code. If it comes down that you did not have the r=
ight
> > to submit the code, the original submitter is liable. =20
>=20
> And if the lawyers come back and say that the submitter is not liable, wh=
at's
> to prevent someone from copypasting actual copyrighted code from a propri=
etary
> source and adding a "Generated-by: Chat j'ai-p=C3=A9t=C3=A9" line to abso=
lve themselves?
>=20

Wouldn't that be up to the courts? I shouldn't say "the lawyers come back
and say", it's more like "a court has ruled", and keeping to court
precedent, the lawyers would say "this is how it was ruled before". Of
course, today I'm not really sure how much "precedent" matters :-p

-- Steve

