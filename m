Return-Path: <linux-kernel+bounces-821411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86585B81307
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65C4188766F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850292FDC5B;
	Wed, 17 Sep 2025 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="KUbqMYcL"
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F282F2FC00C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130499; cv=none; b=u06srII91B7fBgHqttfahSjswTRio189qHtGkNclbDsit8JzdrhsM8b+ETglvWHzJk2WM6FtB2aoMAIIwtbbNq5kwiCKLj15/62BwKEOtISpLn+89d/XMvMpc2qtHsaB4M8/vCsVD3VcdbD/OYEw+X823TbZGlZnVlH8Rjrl81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130499; c=relaxed/simple;
	bh=PgIk7pAydrZRqEpfEOg/43WUEB1UkaAjYvUby6OLvOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TX0VxTo2OHaA2lFlt3TzhFE8brkoD20lcg69MGpxgM+1Ra/B69VeGqslUhnM0DrV2G9CjzGdn68W5olT6twt2n9L75OUoT+TaewS+2QDIzhHmd1eVSPyxOrPYHme5kl5theFGYgCkeMpeuQ6G65BCl3oIlbXEVLpCa3PEE2E4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=KUbqMYcL; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:571a:0:640:23e3:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id B879482019;
	Wed, 17 Sep 2025 20:34:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id nYVDq8EM1mI0-s34VGMgc;
	Wed, 17 Sep 2025 20:34:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1758130493;
	bh=pJez7eM27aCVPjmB28OI3T/+XuwR6tdFHJzjmSrfUAE=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=KUbqMYcL+e1e7LtPsUzJnBThOMpawF23SygGp7oSp3z13m6aC2sb2WjjAEYvTSoV8
	 kyejtg4v+n2iMTQnQNfEuoOJNu2ZzDxOZlpSPczRrQ+QhaTzR6wL+oCn4J9t1PsP+L
	 DUDqsu3Z1OHQLXOHAiL1BKBjHx+B5V11luEmQRdw=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 17 Sep 2025 20:34:48 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, apw@canonical.com,
 dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Subject: Re: [PATCH] checkpatch: warn on unhandled placeholders in cover
 letters
Message-ID: <20250917203448.569ac415@nimda.home>
In-Reply-To: <9a84b9a3adf08aa468252fddfdbb0d9a8506fd46.camel@perches.com>
References: <20250917114909.7678-1-work@onurozkan.dev>
	<20250917170110.4e6d4831@nimda.home>
	<9a84b9a3adf08aa468252fddfdbb0d9a8506fd46.camel@perches.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sep 2025 08:43:16 -0700
Joe Perches <joe@perches.com> wrote:

> On Wed, 2025-09-17 at 17:01 +0300, Onur =C3=96zkan wrote:
> > On Wed, 17 Sep 2025 14:49:09 +0300
> > Onur =C3=96zkan <work@onurozkan.dev> wrote:
> >=20
> > > Adds a new check to detect unhandled placeholders in cover
> > > letters. This prevents sending patch series with incomplete cover
> > > letters containing auto generated subject or blurb lines such as:
> > >=20
> > >     *** SUBJECT HERE ***
> > >     *** BLURB HERE ***
> []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > > @@ -3339,6 +3339,15 @@ sub process {
> > >  				$fixed[$fixlinenr] =3D~ s/^/ /;
> > >  			}
> > >  		}
> > > +# Check for unhandled placeholder text in cover letters
> > > +		if ($filename =3D~ /cover-letter\.patch$/) {
>=20
> Probably don't need this $filename test but do need
> some test and code like
>=20
> 		if (($in_commit_log || $in_header_lines) &&
> 		    $rawline =3D~ /(?:SUBJECT|BLURB) HERE/) {
> 			ERROR("PLACEHOLDER_USE",
> 			      "Placeholder text detected\n" .
> $herecurr); }
>=20
> > > +			if ($rawline =3D~ /^\+Subject:.*\*\*\*
> > > SUBJECT HERE \*\*\*/ ||
> > > +				$rawline =3D~ /^\+\*\*\* BLURB HERE
> > > \*\*\*/) {
> > > +				my $placeholder =3D $1 || $2;
>=20
> $placeholder isn't useful.
>=20

That was a left-over, sorry.

> > > +				WARN("COVER_LETTER_PLACEHOLDER",
>=20
> s/WARN/ERROR/
>=20
> > > +					 "Incomplete cover
> > > letter: placeholder text detected\n" . $herecurr);
> > > +			}
> > > +		}
> []
> > I wasn't aware of the checkpatch documentation in
> > "Documentation/dev-tools/checkpatch.rst" file. I guess
> > COVER_LETTER_PLACEHOLDER needs to be documented there?
>=20
> yes.


