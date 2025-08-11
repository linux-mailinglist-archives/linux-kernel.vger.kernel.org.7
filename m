Return-Path: <linux-kernel+bounces-761668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B59B1FD39
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935331895D65
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13364D2FB;
	Mon, 11 Aug 2025 00:10:22 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A994A2D;
	Mon, 11 Aug 2025 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754871021; cv=none; b=pFeOwK0yQOJ8wUYFAnoQ/fYqyYCvvF961CX6VTbohCDI9IVXfBYtGWwFoEYMyy3umE1QlkNV5L1VAS1qjfZgc5ZWyKnz+HSoIpFUnpNAn46yzznW8rPjc3l90PRtLxfhMx2lLi6GhI2itxbdaAgECBhyUP4xkrsrA5OljCipsKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754871021; c=relaxed/simple;
	bh=8hwwZNPOCYpNxCxer0VxJ1qiElxYhy23+OK7racy2nE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iyX5K9UmhfaxKqiAg26l64SdLi5IDTyX9jqLx0pHMgsWWMxYBTVM5P9aZF3vYJhqwhxmj1T0hOaCCHfrxvXxm9Cf7oKtVV4hYMkZ9SAZLwtCkIXZ03EfufEXeXMWfepa8mTq+DpMHlWfq3T0ryvlMMyqTYoXy3qGxGRFNfgbipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 2A23FC05A2;
	Mon, 11 Aug 2025 00:10:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 9B5DD6000F;
	Mon, 11 Aug 2025 00:10:15 +0000 (UTC)
Message-ID: <6a9620575d59483b105a35e8c2f53890a5d1f159.camel@perches.com>
Subject: Re: [PATCH v2 1/2] README: restructure with role-based
 documentation and guidelines
From: Joe Perches <joe@perches.com>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, josh@joshtriplett.org, kees@kernel.org, 
	konstantin@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, workflows@vger.kernel.org
Date: Sun, 10 Aug 2025 17:10:14 -0700
In-Reply-To: <aJjM1oF8hJJrqDhN@lappy>
References: <20250809234008.1540324-1-sashal@kernel.org>
		 <20250809234008.1540324-2-sashal@kernel.org>
		 <bee3cea19d9fc1c97b1816f516fdd5283cebc1e1.camel@perches.com>
		 <aJjM1oF8hJJrqDhN@lappy>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: eobbaqiebk7z393ets76zxnbr6xt3z37
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 9B5DD6000F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19zrOciS4xm3vyDpEqG1tMZN+HqTSsJnCo=
X-HE-Tag: 1754871015-939760
X-HE-Meta: U2FsdGVkX183GdC57GyHLKXG38ktqNK5G9QkEVsK/2TROQ+PIDYCZW0+2HOvi9MXr77jcZo4U5dgi2+yx1RbOs/WNEmVxkUNlSj4pPuzVTViV8E4Vi4l8NGEWYfTq/bokFYNB2nlD13i0JmQ+amArgkyXGNzWi69HTIpARwfC4D7cwjlM03jlpDF+rZjbqNcLT9ZqgjS0ZgtMuQl+xLjUol+ZTZwaa5X4igftSOV/mqWRit6GTnI0u3RBXN3SqGdyLko8+o6foztuyxRaXE9qvlXDRXG0FHXr+2wBcomekyIp5BkNQBI7cMtDk2ZX4UB

On Sun, 2025-08-10 at 12:46 -0400, Sasha Levin wrote:
> On Sun, Aug 10, 2025 at 08:44:58AM -0700, Joe Perches wrote:
> > On Sat, 2025-08-09 at 19:40 -0400, Sasha Levin wrote:
> > > Reorganize README to provide targeted documentation paths for differe=
nt
> > > user roles including developers, researchers, security experts,
> > > maintainers, and AI coding assistants. Add quick start section and
> > > essential docs links.
> > >=20
> > > Include proper attribution requirements for AI-assisted contributions
> > > using Assisted-by tags with agent details and tools used.
> >=20
> > Nicely done.
>=20
> Thanks Joe!
>=20
> > Perhaps the 'Assisted-by:' tag should not be limited to AI
> > assistance but could also be used when accepted notes were
> > given on any revised patch submission.
>=20
> The suggestions from the previous patches around expanding this to be a
> list of tools rather than just "AI" made sense, this is the example I
> gave in the cover letter:
>=20
> 	Assisted-by: Claude-claude-3-opus-20240229 checkpatch
>=20
> I find something like that useful because it tells me from the get-go
> that the submitter ran checkpatch on it (without having to spend a line
> in the commit message saying the same).
>=20
> I'm not sure about mixing human feedback into this, it might be
> difficult to interpert it later.
>=20
> It might work more naturally as an extension of Reviewed-by?
>=20
> 	Reviewed-by: Developer A <a@b.c> # Improved the XYZ algorithm

Maybe.  Dunno.

Sometimes I just give style suggestions or notes for things I'm
cc'd on but I don't really review it as a "Reviewed-by:" tag
seems to imply a more formal process.

> > Oh, and maybe a checkpatch update like this?
[]
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -641,6 +641,7 @@ our $signature_tags =3D qr{(?xi:
> > 	Reviewed-by:|
> > 	Reported-by:|
> > 	Suggested-by:|
> > +	Assisted-by:|
> > 	To:|
> > 	Cc:
> > )};
>=20
> Yup, makes sense! I'll start including checkpatch updates going forward.

If the AI/coding 'Assisted-by:' tag doesn't have an email address,
then checkpatch is going to complain anyway.

Something in checkpatch's

	# Check signature styles

block starting around line 3040 or so will also need updating.




