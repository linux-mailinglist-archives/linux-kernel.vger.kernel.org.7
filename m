Return-Path: <linux-kernel+bounces-743645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3570CB10144
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29EEF7B1DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F512236FD;
	Thu, 24 Jul 2025 07:04:13 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62E21F2382
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340653; cv=none; b=XzKtSbacg4PpXuqk+f06Xx7ig7uQGaTCubHEVRlIpR4TBHAfOX5kUXjwS35pnOks6qmG5MkE/ByqStteqosOHubdjRpSOh3oSxjYDVkSrAn3ZqyTAh8yMDFBJ5eQTm4woEUsbPXEktGWE8uhvVVzbTg+iOTUfXR3i/P8pQDkiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340653; c=relaxed/simple;
	bh=h/ScP4oDhq8irGt/LdHFl95HdTUuOBpD9FntN1yGWh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s7/Gl7RZSKHlgehlKgTiZFCAwWbEypjvltpKC8yX6DtWOO5D/PIxQKHdeArg99zJ1N7M36m1+9lokx+V++PNDGMfNNFXAwPEA0DbB6PYLJOk7agsV6ZYuBJEPZTQ8z/ryltstY+3fRP9mi59VB9o4V+WZF2FzmJFflsF+aMtPEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 879A81402FE;
	Thu, 24 Jul 2025 07:04:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 66A2F8000F;
	Thu, 24 Jul 2025 07:04:08 +0000 (UTC)
Message-ID: <7d938f5514c8e4705cab01e776648fd2b6be0edd.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: warn about novice phrases in commit
 messages
From: Joe Perches <joe@perches.com>
To: Ignacio =?ISO-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>, Andy
 Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	 <lukas.bulwahn@gmail.com>, linux-kernel@vger.kernel.org
Date: Thu, 24 Jul 2025 00:04:07 -0700
In-Reply-To: <20250724032842.69739-1-ignacio.pena87@gmail.com>
References: <20250723030257.66560-1-ignacio.pena87@gmail.com>
	 <20250724032842.69739-1-ignacio.pena87@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 66A2F8000F
X-Stat-Signature: 9p96rochbuwb36rjmx6mgyni565u1d54
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX199ZmwGBN5Ht/ga45rMsrqFyYM+0hWQevs=
X-HE-Tag: 1753340648-774483
X-HE-Meta: U2FsdGVkX1/xz4YYZdYQbECLMHNYsSTsopP/CAN7zeUtK8YRnN23XZ1nsQrem91nt53xtbvMJDa5mNvyWfiJvMYm9TGBdemkgTd5ZdYc6+PawiMFf8uhPGM+3QHicgJTJjo/dsha33KhULZmxBO4GX5K+UdcHEQFx3N250gPKqR2V/Qb7nXBur5xc7ymrVp60kfRjCOViI5qwWUqHyBTqbkSGoAi9ZDde8VdHPo53ieFBQ2godSnr3SJ5UbcYJZ3WBAHFiv56TiPHMoFepbRG9SZ0e883KxlXML+mCbikdRwHA4MggysFRQaWKjni5IqT+8aA26arjmpBaltip68+UBdZ80TafqM5odYr+i5rAOnjTCYvMf4dPBnslNXD/djVlfc1o0R4vNIET0gLfFkZ3Bhsh3FqP7yFwz7qh6bnbKslEtoAWGipU9ELIx5MKacYyzVF7ql//k=

On Wed, 2025-07-23 at 23:28 -0400, Ignacio Pe=F1a wrote:
> Add detection for common phrases that make patches appear less
> confident. These phrases are often used by newcomers and can make
> their contributions seem less professional or uncertain.
>=20
> The regex uses qr{} syntax as suggested for better readability and
> potential pre-compilation benefits.

Unneessary paragraph.

>=20
> Examples of detected phrases:
> - 'please apply/merge/consider/review'
> - 'hope this helps'
> - 'my first patch/contribution'
> - 'newbie/beginner here'
> - 'not sure if (this is) correct'
> - 'sorry if/for'
>=20
> This helps newcomers learn the expected communication style in
> kernel development, where direct and confident communication is
> preferred.
>=20
> Link: https://docs.kernel.org/process/submitting-patches.html#describe-yo=
ur-changes
> Suggested-by: Joe Perches <joe@perches.com>

I did not suggest this.
I am merely trying to improve the patch and its readability.
I do not need to have any credit for this.

> Signed-off-by: Ignacio Pe=F1a <ignacio.pena87@gmail.com>
> ---
> Changes in v3:
> - Use qr{} syntax instead of // for the regex (Joe Perches)
> - Remove comment about the suggestion (Joe Perches)
> - Drop the SHA enforcement patch based on maintainer feedback

This last line should be part of a cover letter to the patch set
rather than added to this specific patch.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3266,6 +3266,14 @@ sub process {
>  			     "A patch subject line should describe the change not the tool th=
at found it\n" . $herecurr);
>  		}
> =20
> +# Check for novice phrases in commit message
> +		if ($in_commit_log && !$non_utf8_charset) {

You still haven't answered why $!non_utf8_charset is useful.

> +			if ($line =3D~ qr{\b(?:please\s+(?:apply|merge|consider|review)|hope\=
s+this\s+helps|my\s+first\s+(?:patch|contribution)|(?:newbie|beginner)\s+he=
re|not\s+sure\s+if\s+(?:this\s+is\s+)?correct|sorry\s+(?:if|for))\b}i) {

And this is still not human readable.
I much prefer describing each phrase on a separate line like:

			my $novice_phrases =3D qr{(?xi:
				please\s+(?:apply|merge|consider|review) |
				hope\s+this\s+helps |
				my\s+first\s+(?:patch|contribution) |
				(?:newbie|beginner)\s+here |
				not\s+sure\s+if\s+(?:this\s+is\s+)?correct |
				sorry\s+(?:if|for)
			)};

			if ($line =3D~ /\b$novice_phrase\b/) {


