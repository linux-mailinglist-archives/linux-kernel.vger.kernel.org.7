Return-Path: <linux-kernel+bounces-802264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A00CBB4500F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB231C8271E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800B425EFBE;
	Fri,  5 Sep 2025 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O54aeCDV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD64DF71;
	Fri,  5 Sep 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057955; cv=none; b=pP0ivyBRPYD9DtSwBLIb8v2SVMORNAYJY0BVFIRyPngk+uLGdNYij4NZq/OmQNNHd/n3rWMSRDqKPCra++7OIhebyY/3SeP3e8NfR2BqaCQz1EItv9aa+f1aKhF1E3T0jTAVLJMyssaBfKzAHgvDdGjjJPQ3WZwI0HoMi+yTA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057955; c=relaxed/simple;
	bh=jV94hjqYlnI3MDHfUkjssEm/lBf+AReDNWe316CAHBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UN+MmKLyD8ugmnAEuIaj54WT2UTKWyKcZkgx+QWxt7Xt5M6ECgxp3VMf00qvEoUPlyqQn96ygXbFegJ0fMbrZanjuSeTf9FRx7nvzyU65wknza9Ae+tWapYzz0WLbd09zYnZxlk86KnQ+gZ3mq8fVQtdtVrXX0IffuD77JAuWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O54aeCDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE01C4CEF1;
	Fri,  5 Sep 2025 07:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757057953;
	bh=jV94hjqYlnI3MDHfUkjssEm/lBf+AReDNWe316CAHBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O54aeCDV56bbSOp9JVigGWqnv/CVtwiPi1wF+Fr1SsMIuz0w6UO6aK/J/lHIHqkEr
	 lQonsWQax3QFhZkCX9GZFHsYmjcE/DaywFqgbSH4d2/f3ZKNeGygMf4C7ev1zGXa5n
	 c78EOa+/X+hzaWftcKLZlNxl283WH3ElFhJzvjvPn/6Z2YxawjyKZKFUXWXJmdHOF1
	 SR1bH0aASrbEVzXI/WWHOTVL3Cwf6jJCpIM+60o6fkeTppF6qagxgg+B83bfm9Q7Wa
	 L0BLgpGQ7qxpMPX5HidfdcMr6e0dWACV7Bp+ufruZfn6P0f7id3jrstte1MU9AKLeA
	 LPxrPAxPg6y6w==
Date: Fri, 5 Sep 2025 09:39:08 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Akira Yokosawa
 <akiyks@gmail.com>, Dongliang Mu <dzm91@hust.edu.cn>, Federico Vaga
 <federico.vaga@vaga.pv.it>, Randy Dunlap <rdunlap@infradead.org>, Yanteng
 Si <si.yanteng@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/19] scripts: sphinx-pre-install: move it to
 tools/docs
Message-ID: <20250905093908.12ac00d3@foz.lan>
In-Reply-To: <87ms7amanj.fsf@trenco.lwn.net>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <68810fc1065bbe8ef1305041fb10fa632bb64dd3.1756969623.git.mchehab+huawei@kernel.org>
 <87ms7amanj.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Thu, 04 Sep 2025 10:42:56 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>=20
> > As we're reorganizing the place where doc scripts are located,
> > move this one to tools/docs.
> >
> > No functional changes.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/Makefile                             | 14 +++++++-------
> >  Documentation/doc-guide/sphinx.rst                 |  4 ++--
> >  Documentation/sphinx/kerneldoc-preamble.sty        |  2 +-
> >  .../translations/it_IT/doc-guide/sphinx.rst        |  4 ++--
> >  .../translations/zh_CN/doc-guide/sphinx.rst        |  4 ++--
> >  Documentation/translations/zh_CN/how-to.rst        |  2 +- =20
>=20
> This one fails to apply to the translations - it looks like some sort of
> encoding problem...?

Yes. My new mailbomb script in Python mangled it.

I ended sending you a PR, as this way we know for sure that we won't
have any encoding issues on either side.

---

Checking encoding after the patch series:

    $ file Documentation/translations/zh_CN/how-to.rst
    Documentation/translations/zh_CN/how-to.rst: Unicode text, UTF-8 text

    $ python3
    Python 3.13.7 (main, Aug 14 2025, 00:00:00) [GCC 15.2.1 20250808 (Red H=
at 15.2.1-1)] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>> with open("Documentation/translations/zh_CN/how-to.rst", "r", encod=
ing=3D"utf-8") as fp: c=3Dfp.read()
    ...=20
   >>>=20

And manually looking on its contents, the patch itself is OK.

Looking at the e-mail generated using Python EmailMessage class, however:  =
=20

    Content-Type: text/plain; charset=3D"utf-8"
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

Python completely mangled it by replacing all UTF chars with =EF=BF=BD:

	--- a/Documentation/translations/zh_CN/doc-guide/sphinx.rst
	+++ b/Documentation/translations/zh_CN/doc-guide/sphinx.rst
	@@ -84,7 +84,7 @@ PDF=EF=BF=BD=EF=BF=BD=EF=BF=BDLaTeX=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
	 =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BDSphinx=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD
	 =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD::
	=20
	-	$ ./scripts/sphinx-pre-install
	+	$ ./tools/docs/sphinx-pre-install
	 	Checking if the needed tools for Fedora release 26 (Twenty Six) are avai=
lable

When I have time, I'll try to fix it - or end giving up of the Python
version returning to the Perl one, even with the content set to
utf-8 at set_content() function call.

Thanks,
Mauro

