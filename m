Return-Path: <linux-kernel+bounces-829762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 657DCB97C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269CF2A6321
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CB730E0E2;
	Tue, 23 Sep 2025 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbcKmYAX"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462512F657A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758668623; cv=none; b=JnSr2bMAMgCi6BElF0lIX9rlszCSMdvVeUd05ZHpHcxoqMFyROqN5Tr/lJNA85e0AsGXJEBQs2jXFjFDH0hnmjFpEW1Aqu+XPnfuVnK59lXLPYVwM27IevUjpmLFGhu3Y7jC547UKUyV1gYQqjR0p7oNTGu32v0ugcXE0gIQAK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758668623; c=relaxed/simple;
	bh=MHMaUS9naR0vIV9JTYsRgzOChzGdvox3pKFEbqzWur8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLUWhacHbLRQiSsO6ccIRhERJ5y08ql6p1uBmoT/hlBwCQA8Xjz9ow+Odu6Rsy7JJ6awBNivUYhoAjXwW0B1mSlhzYIWgY3dKQnkDYJD5K9Mkz3SSOM5CYz2Zh5hYtcCNMuOeiAdnoQeC45qAi8JFvJlBTiQZFPw/NuB0Eff1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbcKmYAX; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b55197907d1so3366151a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758668621; x=1759273421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHMaUS9naR0vIV9JTYsRgzOChzGdvox3pKFEbqzWur8=;
        b=MbcKmYAXBLu15h/Rf1JsS4T01Zwm+caHUe0qeeBr3sBHR3+KTViCOqwPpfYzfIRNqB
         enRFr+5SY5W2JuQEpQmk5w3XV/EUDpiRvzBqumGBWVCkkuwEbv+TGkwq5V3G5HwIbJ3d
         8K5NleZraMpVMaN8zACO8UYeM6NMCq74qnQCuxtNoMgvY3RvI+Q7H/ircBktDzx82aEG
         4h/dM+JHAzQ+PsNTQe7sIg2l7ahP3sgBq4PutHadWUFHUAmq0nX5Bcdf60vSPdL2TZsS
         cYA9yURRY7GUK3Jc79E9nJ9VkidyscqdBwBEFhTAhbZom16lai4Y3W+8U0Dw94ugcZzC
         MTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758668621; x=1759273421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHMaUS9naR0vIV9JTYsRgzOChzGdvox3pKFEbqzWur8=;
        b=TR1CkvmunFyfUWgejWuhlMlsYpUHlHROP9gAGGhg7yteZOPN6D1d341iuXrzgh6hPc
         Vj4Th4HCmDGHhfdomnp/x+S97/V5HxlGpM3OTxSDI22VGZfwHAFKfYV//jGPHSMDny8L
         IJ5Fws3bnDJQEkm8m+94g1HcKZafSB+UHK/uyHk1WOfFO15KVDLYqbob0iDQ9qkpNBYJ
         NMIpohq/nY0RE+RnLc0RC+QveNmnr4hpj4GeKkIux9j4/Li79blnZxVnWbyPr9oRnlvG
         aU5j3F/Zv+fHrK7fwUuiy4vtfTv9eaVAYjjgV/M41KlFPhN+ZEwT6XlfAz5PNK0KoIZ/
         WutQ==
X-Gm-Message-State: AOJu0YwYL72I7kgc2gREvXb1WeinokRs6WhMTwAubhUp/7hzuj+beIAq
	7TmSDbjtYoQnP5Cy9ph0978rKRky0QdfbCzCMMZZXmP3PDKoql5xF1Fs
X-Gm-Gg: ASbGncssKPxmWFEWdPfjc0CgGKgB5MhbnTcAjtZ96cOTdz9dOzYBjOsB8lpkoMvNdyv
	pivVfxhfn/9igduBUTWsXE5ud2JpxZayaduZQENVzvRxKaW9nuZ19j3ahqGyGmV7BUp4HwV++Ui
	kxy+VSnqMt2NSxVhOC/exBXZ8OxsUFbxbtc0cWNyt8GG6saSa5FhR9oScjhizr5tz9al9PI0HBW
	pSlJ+2Iby8KqxuSO7e4aeREkTOCvxdoEZ9KoDj6f6SqyoDhQtPiyEnQPThJ3PaqAl7HJ+CAh/zS
	LTaAfy8cgL8EiHGmHynpn/z5fFegAI882404aygByfwtsI7dgEMW3kVpvg7A71+vaWsR9Dat36S
	RyjgGMdr+dxeq5ZEchesQ60HcU4sEeST4
X-Google-Smtp-Source: AGHT+IGB29W3TqgK5gfHdx17rWs6QdlKifvPHsUNAQVltUUYu2zh/Zwdpk0V6cpL4DLVztirvIJtZw==
X-Received: by 2002:a17:903:2352:b0:254:70cb:5b36 with SMTP id d9443c01a7336-27cc0db9ba4mr41304715ad.8.1758668621281;
        Tue, 23 Sep 2025 16:03:41 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-272435b6822sm103636345ad.125.2025.09.23.16.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 16:03:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1DAC6423FA7C; Wed, 24 Sep 2025 06:03:38 +0700 (WIB)
Date: Wed, 24 Sep 2025 06:03:37 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	James Morse <james.morse@arm.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4] Documentation: gfs2: Consolidate GFS2 docs into its
 own subdirectory
Message-ID: <aNMnSapfyfwga0Oz@archie.me>
References: <20250911004416.8663-2-bagasdotme@gmail.com>
 <aNJ9yJ7XT4Pnsl9E@archie.me>
 <CAHc6FU7aGJZZzN8zhtnwDgXX9gVMh_fbi+sUpJ7tg1MWMa8XVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TJFNCLqvXEgyfWhu"
Content-Disposition: inline
In-Reply-To: <CAHc6FU7aGJZZzN8zhtnwDgXX9gVMh_fbi+sUpJ7tg1MWMa8XVA@mail.gmail.com>


--TJFNCLqvXEgyfWhu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 01:44:18PM +0200, Andreas Gruenbacher wrote:
> On Tue, Sep 23, 2025 at 1:00=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> > On Thu, Sep 11, 2025 at 07:44:17AM +0700, Bagas Sanjaya wrote:
> > > Documentation for GFS2 is scattered in three docs that are in
> > > Documentation/filesystems/ directory. As these docs are standing out =
as
> > > a group, move them into separate gfs2/ subdirectory.
> >
> > Hi Andreas,
> >
> > It looks like this patch isn't in 6.18 PR [1]. Should I resend it after
> > merge window (and for 6.19 instead)?
>=20
> Ah, I was already wondering what had happened to that patch.
>=20
> Can we just put this into the next (6.20?) merge window?

OK, I will resend after 6.18-rc1 is out.

--=20
An old man doll... just what I always wanted! - Clara

--TJFNCLqvXEgyfWhu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaNMnRQAKCRD2uYlJVVFO
o0qlAP45w7y0ijoPca+WRWWR7uDsyafheW+piv5hf202bJQxhQEAnpSuvMubtyMj
GGi6LPIrwatrZPCjfKwexwl+kv/kRQQ=
=XR2A
-----END PGP SIGNATURE-----

--TJFNCLqvXEgyfWhu--

