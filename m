Return-Path: <linux-kernel+bounces-790443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4B1B3A743
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C2B16419A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9FE3218C2;
	Thu, 28 Aug 2025 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K88uUqBi"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC1211706
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400587; cv=none; b=FBRN+gW6TQ46Tub9LxiXmDikgqkixJgTBrD7ARWf88Pz9ngMA5HNJtNKpqBk6myw2eDwzBs5lUk90gJPyvOUZxPOWJVfusaaWmHBmFhJTATx17fqxD4ZnGp37djmYatqEeQWoCoDSEzAglaphJBfSKILDLo2MiLLTIqlVVCcS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400587; c=relaxed/simple;
	bh=lc4yQLlGQ1ALDQQJS7QLyBBBdQD7Q9TQBdMpceMI9hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlXK/GmEDJkcujO4M5R8NY1Oqcre86SG1RhvB635F3TbxFcLkQ2as4PTNISJf+tT293ylCLIZAnXTqzA9IjbvTj/TqsIonFRjgqd2wWxFgJhQPBiqLWB9MHzozIKm0duJRdcPmnVvxine5u4/S+Jn6FYwiStTKcOT7dSXc+2KxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K88uUqBi; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 49F50C8F450;
	Thu, 28 Aug 2025 17:02:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA3DF60303;
	Thu, 28 Aug 2025 17:03:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21CAF1C22DD92;
	Thu, 28 Aug 2025 19:02:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756400580; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4Vex+Mkvb0GemWYHmwN2TZzE127JKaTead6sfS0g/BY=;
	b=K88uUqBiCBmZYOXjE7eaX15VQS5Y/Ibuox7+bHeNP1PTVBAlgYC+/JcBeCy6VcGGzpV4pj
	5No3PKiewSUFyztDWjZSg+SYBIXI2j0TZhjP3cxfVJ88Mx+1bo5P2g9YaAF61MGTFZZkxo
	D2ihndxTq0UfY28cIyiTH2qPn9Dq1nbuknrDK7XN/4dT/MWkC/sxPuZtqKHDnhflmMF3pn
	yTMwbfDlvSzkX1GmcMlpSQ1ooW/TrcLB+VoyYLFDB6P4uBwurHDppwCnHU9e7cVR/409Wg
	JE73AvIf6jwNIVWuXKZmfeRuk+M/VLeO/ev5PyXFvCOiExR3xWCLmP/Cwl9+kQ==
Date: Thu, 28 Aug 2025 19:02:43 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Message-ID :" <cover.1752076293.git.mchehab+huawei@kernel.org>, Linux
 Doc Mailing List <linux-doc@vger.kernel.org>, "Akira Yokosawa"
 <akiyks@gmail.com>, "Breno Leitao" <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, "Donald Hunter" <donald.hunter@gmail.com>, "Eric
 Dumazet" <edumazet@google.com>, "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>, "Jakub Kicinski" <kuba@kernel.org>, "Jan Stancek"
 <jstancek@redhat.com>, "Jonathan Corbet" <corbet@lwn.net>, "Marco Elver"
 <elver@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Ruben Wauters" <rubenru09@aol.com>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Simon Horman" <horms@kernel.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v10 06/14] docs: use parser_yaml extension to handle
 Netlink specs
Message-ID: <20250828190243.0d3f74f6@kmaincent-XPS-13-7390>
In-Reply-To: <20250828185037.07873d04@kmaincent-XPS-13-7390>
References: <cover.1753718185.git.mchehab+huawei@kernel.org>
	<4c97889f0674b69f584dedc543a879d227ef5de0.1753718185.git.mchehab+huawei@kernel.org>
	<20250828185037.07873d04@kmaincent-XPS-13-7390>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Le Thu, 28 Aug 2025 18:50:37 +0200,
Kory Maincent <kory.maincent@bootlin.com> a =C3=A9crit :

> Le Mon, 28 Jul 2025 18:01:59 +0200,
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> a =C3=A9crit :
>=20
> > Instead of manually calling ynl_gen_rst.py, use a Sphinx extension.
> > This way, no .rst files would be written to the Kernel source
> > directories.
> >=20
> > We are using here a toctree with :glob: property. This way, there
> > is no need to touch the netlink/specs/index.rst file every time
> > a new Netlink spec is added/renamed/removed. =20
>=20
> ...
>=20
> > diff --git a/Documentation/networking/index.rst
> > b/Documentation/networking/index.rst index ac90b82f3ce9..b7a4969e9bc9 1=
00644
> > --- a/Documentation/networking/index.rst
> > +++ b/Documentation/networking/index.rst
> > @@ -57,7 +57,7 @@ Contents:
> >     filter
> >     generic-hdlc
> >     generic_netlink
> > -   netlink_spec/index
> > +   ../netlink/specs/index =20
>=20
> Faced a doc build warning that say netlink_spec/index.rst is not used.
>=20
> $ git grep netlink_spec
> Documentation/networking/mptcp.rst:netlink_spec/mptcp_pm.rst.
> Documentation/translations/zh_CN/networking/index.rst:*   netlink_spec/in=
dex
>=20
> I think we can remove the whole directory and change these, right?

Oops just saw that is was some local leftover. This first warning get remov=
ed
with a clean tree.
=20
> Also got a doc build warning that says netlink/specs/index is not existing
> even if it exists. Maybe a sphinx parsing issue ?!


>=20
> Regards,



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

