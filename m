Return-Path: <linux-kernel+bounces-821201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39D3B80B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE6E5879FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C32D321297;
	Wed, 17 Sep 2025 15:43:23 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7CC32128E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123802; cv=none; b=nhcL3pmjaj0LDFpPaObmWlMe1XCcmENNPtbKea/mgfr1CHfspL6zrYlYaKNmUKkwzJPZolGq0UyNuCMpnmn+nXIBh4Bub6fKIpFpT7yyVzd0V3N4aUQHotGMDcig0KR20xnJecKSrKOxlPHLPSXjM0YtpEUw9qiY9Ref4yVAwdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123802; c=relaxed/simple;
	bh=Qtxgf4zZP83oVPAlJonNBwmxmKRa93ylWIZILKJYmKo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WetR2Aa15TPSt+NLjlw/RgFmfNCitCf8pASE9uGeoqjshPS4EmXrtLEQGXoDwKiFuDz5ul7lPyiH7eUyHQnBOaHqgxNEdfBkvObmRFOU8N/0LTedFTTIqXwD7jVyI8Gfiur4DgjcwH7/q3tUfv4zEZoXLW0XvulZIs7iXk6X/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id D49A813B5A7;
	Wed, 17 Sep 2025 15:43:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id B58D32002D;
	Wed, 17 Sep 2025 15:43:17 +0000 (UTC)
Message-ID: <9a84b9a3adf08aa468252fddfdbb0d9a8506fd46.camel@perches.com>
Subject: Re: [PATCH] checkpatch: warn on unhandled placeholders in cover
 letters
From: Joe Perches <joe@perches.com>
To: Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, 
	linux-kernel@vger.kernel.org
Cc: apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Date: Wed, 17 Sep 2025 08:43:16 -0700
In-Reply-To: <20250917170110.4e6d4831@nimda.home>
References: <20250917114909.7678-1-work@onurozkan.dev>
	 <20250917170110.4e6d4831@nimda.home>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: xxdmhw5q9hwwztpdgqmfehdo4bsgyrdk
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B58D32002D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18nD9+4YMwBME3TsCUjU8IkCfezNFPAR10=
X-HE-Tag: 1758123797-912890
X-HE-Meta: U2FsdGVkX1/BXE9IZOanHVOfSZFkEiea3jFDa4oW3uN3rhByAJQJuK8g4v/KbDGh/xf6Dkc+JElECAXgrsYsGQja8SzvWcJNMhaJ76dDoh+NC/bZ6Ki8zFOfBQg3WId8StqiLY7nV+vyIS6bXR8Q6gDRRNTKQ/2tQ0UCcNisPk8x3Y1+ZOR0cwyUQgeCqTbBdYKeC5Uo8RsWDiKzzJAvB+gwdd78twgUlUBJIjuCkR7IpNtMDpOT05vOOJQFHO+//ztkBg9M+rtQPPJSWUmozQlYK0MMGHPSLs1g8CV+pSM2PNdVGpfpmVIa1EtTOGE8

On Wed, 2025-09-17 at 17:01 +0300, Onur =D6zkan wrote:
> On Wed, 17 Sep 2025 14:49:09 +0300
> Onur =D6zkan <work@onurozkan.dev> wrote:
>=20
> > Adds a new check to detect unhandled placeholders in cover letters.
> > This prevents sending patch series with incomplete cover letters
> > containing auto generated subject or blurb lines such as:
> >=20
> >     *** SUBJECT HERE ***
> >     *** BLURB HERE ***
[]
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -3339,6 +3339,15 @@ sub process {
> >  				$fixed[$fixlinenr] =3D~ s/^/ /;
> >  			}
> >  		}
> > +# Check for unhandled placeholder text in cover letters
> > +		if ($filename =3D~ /cover-letter\.patch$/) {

Probably don't need this $filename test but do need
some test and code like

		if (($in_commit_log || $in_header_lines) &&
		    $rawline =3D~ /(?:SUBJECT|BLURB) HERE/) {
			ERROR("PLACEHOLDER_USE",
			      "Placeholder text detected\n" . $herecurr);
		}

> > +			if ($rawline =3D~ /^\+Subject:.*\*\*\* SUBJECT
> > HERE \*\*\*/ ||
> > +				$rawline =3D~ /^\+\*\*\* BLURB HERE
> > \*\*\*/) {
> > +				my $placeholder =3D $1 || $2;

$placeholder isn't useful.

> > +				WARN("COVER_LETTER_PLACEHOLDER",

s/WARN/ERROR/

> > +					 "Incomplete cover letter:
> > placeholder text detected\n" . $herecurr);
> > +			}
> > +		}
[]
> I wasn't aware of the checkpatch documentation in
> "Documentation/dev-tools/checkpatch.rst" file. I guess
> COVER_LETTER_PLACEHOLDER needs to be documented there?

yes.

