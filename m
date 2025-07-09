Return-Path: <linux-kernel+bounces-723185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECC6AFE421
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164DA4E0BEA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE74286429;
	Wed,  9 Jul 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESe+ESGP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A3285C90
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053616; cv=none; b=bvLyKpNwPq+h/jsrVQmMgp9bs2gnfpVcoDo28HWgNW9xkJKHyuzjP0ml9toPujFSNV8FlLrnNPUndoEtHWKLNmZy1phf9wyrGjbTXeXDiKceFwbqd75AMGf356J+FInDIhcfHEYaEC+vySnDEmP4/Dm2dDuoeLPiwxUfl0AouZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053616; c=relaxed/simple;
	bh=6fS+pR0wD89vYAfYw3taweouBbHBQQt++VcdKGiA2NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFKZg1RKphq3Yq3iPhmRucjnQiOuLQbBZ3HfNdBG8JycthK1DEGF3VlOvDqpa7/upueRiSNCGkGkv1GuoRFrSXAj+Wm0SKCij8NhpKPoVRawOlyjc+rLVcVgHoZcTqkPZ90mdf9ZVgUEr3nNcIkiGaz9c91rG/ggSmE40SKVMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESe+ESGP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752053613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agX4lc2QF+x2yKO/wqB7T3ILVT5Q340J4HNQe14txUc=;
	b=ESe+ESGPEGPH/8zfcHYwY3SFlMg79zihuljKqz1c4hamNTTKhtoyhUCjo+bNxhG9oXBKQQ
	NWq6jSTT2McqneLEJYPgZYhoQgVDJObIqdaYyW7oHuyvrhbkszvsRGrVa9e/aJ0H73ACXR
	YR1hsbbLLe5n5DR7VN+ch4TjA/NMiSI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-44hKm15CNTaw3fh7oebwLg-1; Wed, 09 Jul 2025 05:33:31 -0400
X-MC-Unique: 44hKm15CNTaw3fh7oebwLg-1
X-Mimecast-MFC-AGG-ID: 44hKm15CNTaw3fh7oebwLg_1752053611
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4532514dee8so37069395e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 02:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752053610; x=1752658410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agX4lc2QF+x2yKO/wqB7T3ILVT5Q340J4HNQe14txUc=;
        b=m8hfYqePbXSjb5VA8V0cKmCPHhLKBCUlvLGdGHBmptrMq0bn67N0h7+bElMZrr2fK4
         FZXr9vUYFmFmN2TcFGHjrwlDielg9y6j7LL6nbQ/zYuTn+PGFDxZ0I0sO/cbvrx5+zaK
         sKGPSeXKjbOXCW0xSEfo1+mPynulDedSpTk/OT/oRdysYSiNkWS4xEFl78l9WzDXHK2P
         wsx1gJ5qBABgL5I91KP4AsSdb7dObfT8cGb+z9JgVXLza66dDEZfmukntDT0RmReOQl9
         mJdDHgY/SYUZ5wzBZjZ33rVSph3UN31BOhzpcEMa6gTvU8MJOxkWvAiREMa0CGYN+pq6
         l6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWxwDs9cIpA4veAco0TzAutfYxjSeU1IWrQsbcGddcvmjRoVyTJmFwY9wcrnrvyGz9K09kmWDomTM8aaZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZFpme2H0IZCp3qvv7bGA2VR5LD7nCXWqkyQDzH0fn5mR0DHZW
	bq1S5rKpBkVbs4BreDw7fwGB+K0BLKVfflqL+zANZikqi/E3cDsXzPVdQYQbm979pVNZ+3mLNAV
	LbPpLOAGPfTVjFuilcY8PJn03uZZGjM+nSQs7wnq9nfhHJkbMbxUXsTwAa2TG5aqbfQ==
X-Gm-Gg: ASbGncseyFusKz9Y8GsPgm7/Yck7NzUdlEIYFpTU2cBzOeORlpo2Jcb6Bb6eXtPYsXx
	EvLgymK4BrunkLSehmxYbgZ/B6+olsowM2DS/4u41W+ZQAbyxqtIaLF8G1M4amkUXrVpPkQFAxB
	mLQE33deUicWhRlmPq4iSA2Br6kT/cpSLuTgbkOEK5MqsZzR6j4aQBakdxScv833oaimNp8iXO6
	Jj3R1ECkkuryUaCtI3/iJyPQproT1LEa7bYUbw/MlQqFTCKXl0wb+5s51eDEo/a7Shjg2N8TQ==
X-Received: by 2002:a05:6000:1acf:b0:3a4:d898:3e2d with SMTP id ffacd0b85a97d-3b5e44e6b83mr1394208f8f.24.1752053610611;
        Wed, 09 Jul 2025 02:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb4h6E5uZtoXvnjY4tKnwjMDSEDOY4omojeLFdkZXTBUs9B36ru1xXqVCaLo+6kFKHtk9qpg==
X-Received: by 2002:a05:6000:1acf:b0:3a4:d898:3e2d with SMTP id ffacd0b85a97d-3b5e44e6b83mr1394176f8f.24.1752053610135;
        Wed, 09 Jul 2025 02:33:30 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285e241sm15473596f8f.94.2025.07.09.02.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:33:29 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:33:29 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kees@kernel.org, 
	acarmina@redhat.com, jpoimboe@kernel.org, mark.rutland@arm.com, 
	torvalds@linuxfoundation.org
Subject: Re: [PATCH 00/11] x86: WARN() hackery
Message-ID: <20250709-nondescript-fuzzy-grouse-6ba509@houat>
References: <20250607094224.104791182@infradead.org>
 <20250703-spotted-panther-of-blizzard-a887ad@houat>
 <20250703134712.GV1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="alw4zzizzu6jq5ay"
Content-Disposition: inline
In-Reply-To: <20250703134712.GV1613376@noisy.programming.kicks-ass.net>


--alw4zzizzu6jq5ay
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/11] x86: WARN() hackery
MIME-Version: 1.0

On Thu, Jul 03, 2025 at 03:47:12PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 03, 2025 at 03:40:01PM +0200, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Sat, Jun 07, 2025 at 11:42:24AM +0200, Peter Zijlstra wrote:
> > > Slightly less mad this time :-)
> > >=20
> > > The primary purpose of all this is to get the WARN() printk() and
> > > __warn() calls into the same context. Notably the current state is th=
at
> > > WARN() ends up doing printk() in-place, then takes an exception and h=
as
> > > the exception do the __warn().
> > >=20
> > > The problem with all this is the ONCE logic. Normal WARN_ON_ONCE()
> > > (without the printk) has the ONCE logic in the exception
> > > (__report_bug()). But because WARN() essentially results in two disti=
nct
> > > actions (printk + trap) this cannot work.  With the result that
> > > additional ONCE logic is sprinkled around for each such site.
> > >=20
> > > Current proposals look to make this worse by adding KUnit checks for =
all
> > > this, including regular WARN. Making the per-instance code overhead e=
ven
> > > worse.
> > >=20
> > > As such, by moving the printk() into the exception, and having the
> > > exception (__report_bug() in fact) do everything, we get rid of the
> > > external ONCE logic and provide a cental place for additional conditi=
ons
> > > without need to litter all the instances.
> >=20
> > Thanks a lot for working on that. What is the status of this patch? It
> > looks like Linus was happy with it, and I understood that you felt it
> > was a blocker for the kunit warning work we'd really like to get merged
> > at some point.
>=20
> I talked to Mark Rutland about arm64 support, to see if the things I did
> are generic enough for other architectures to support, or if there's
> anything I need to change.
>=20
> He said he was going to have a poke, but it appears he's not had time
> yet.
>=20
> Once he's happy, I think we can move this forward. Obviously I have to
> rebase on top of the things Ingo stuck in meanwhile, but that shouldn't
> be too hard.

Ack, thanks for the update :)

Maxime

--alw4zzizzu6jq5ay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaG43aAAKCRAnX84Zoj2+
dmMUAX9hlTw7+JUVTU7BeNhLtSJEWOIEu+hZbvME5x/Mf65yOnhARmus9S7eCRTT
npdPrwsBf1Ch1I1bnUvpfO8MJbcFj4src4qyfsuibSV8QaiXGLUtBZ2EjwVUbihJ
CYRnya0Fsg==
=Galw
-----END PGP SIGNATURE-----

--alw4zzizzu6jq5ay--


