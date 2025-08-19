Return-Path: <linux-kernel+bounces-775440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EE1B2BF28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584EC5E3B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D74322C7E;
	Tue, 19 Aug 2025 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgG4qm/y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EBA322C61
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600014; cv=none; b=Ifz8e4ypwls/MnLm+w+qFRCMAVDlD3ueGpAhK9+1+B7WpEyWdhK9WVEL9yNH5bltYMRrRJq8bYpQzqwLuxVMZQ62aD6gA2DZ2JcboRLJtg1C9XL/5YOohh3a8+5HSrlTs68LmQ20Yvrd7trFZ4Wt5e+mbzj3s8KCmiktahrNWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600014; c=relaxed/simple;
	bh=6Mh3OcWG/P/mVc70L6Bz+2SOOMG4XOUFXpU2o4QLQUQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sb0bBaiM1U9BFEEfODQ5pFguoK8MPQeC5Xt48Kv35aXtPXTrOIafWzal164jMTNCV6NDcg7S62Smu1zyes0cndRWIB8pwsWCAVqx+l/o0HB4Lmlkww3xggkc8B5cQKCWsppRU+6BKqqetNjB+WufkIB12V6XrbCDEQPEtpYo5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgG4qm/y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755600012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6Mh3OcWG/P/mVc70L6Bz+2SOOMG4XOUFXpU2o4QLQUQ=;
	b=cgG4qm/ybHxUbnzWz4Cpk67HaMCgTrHHfXChu3hCQz0ymSzRzqmPEy2B4A6dsmYrOu8f2W
	1NyDiVpLVh5YHRXXNy5MOvuD5qLcoDDKjrQv/catJsC28eKOdAlyF8D4JhxPEHnb7RTkPs
	Ta68HRiSAmCVtdv3hq+gQntn+H+xwbw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-9OT6-x-uN8S72f-pWbJjqg-1; Tue, 19 Aug 2025 06:40:11 -0400
X-MC-Unique: 9OT6-x-uN8S72f-pWbJjqg-1
X-Mimecast-MFC-AGG-ID: 9OT6-x-uN8S72f-pWbJjqg_1755600010
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e8706a5e78so2362839685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600010; x=1756204810;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Mh3OcWG/P/mVc70L6Bz+2SOOMG4XOUFXpU2o4QLQUQ=;
        b=wkPKWv/ckNQxd5VQEEVjVSnDVbRcLesJIVlix3lMpH4ypjTJVMZ7oBih1ueOw8TLf3
         xPpOtSlIBKUUtd29E9fDQXIJ2QBiek2V8cvUU4CN3ClvobWzhpn56wyeh/Ec686m6w8D
         Xn34PBw3xZa4+Q88cp000aAr2MOson8hscLniKtXrtXbpU8yHyMhDaTnxlA63ZH9qJIm
         cBurAK+hpZptz0tuePNTJXDhc/nci/iDbQm8gRyUiem5boT8yBr2COHqi/KMiUuMvtqX
         w3C/C09qXOz9K041qTi/sGVmbcuMZ0EUebsW9iUOXgssODwe7yFc4DJfk/hvwgcVNAuD
         BExg==
X-Gm-Message-State: AOJu0Yx/BKrQlwLJHyFmiyFrBR6nHe84Ax8xLWtBRinxIbKE0hc6jPgC
	C5tjLf1Khi7rhDv2OizVJWvjcspGhD/n+oS2T6gwjMEdXHfFahDktiIA7amp/lCu0HqKyIlbScL
	OMbNDsZId4B/NBSfwa0YZf5E4CtKoFkbkb11/LMMduLu8fBWS7ETqafgMU/OezqIBIw==
X-Gm-Gg: ASbGncsC4UYWcWFAJ7Q+0jsqQsbAAC4DKylzsk+IlP+FpekN1A439JfxPbbDqPFT3qv
	m0n6xYt8zmITxBDV5onPpw8zU4mjOskZ7DwnTyL/tU4mTySVWIcFSxjsdMY7GZwsZzjy7Q31G2F
	FSdMHEQu4AzvOLMO8fjtAG/8VTXspncfgSJAN+CVaQ7D5W2gCXxUwHOar0sivrri8YqBRYIK8PB
	Ma5gGwrvx2bRw/MnC1S1R3u80zH+HWZqnkZ4cLZC/naMh6W8QJXTv9SGbF4tqIOITQg5oqJH75a
	4UlUHrWg/8Dp+BOq8ZE0ECgwDx9v3wmuA5cOxiCE8mKts5yu94TImRU+Url2KRO+uw==
X-Received: by 2002:a05:620a:471f:b0:7e6:998c:99c0 with SMTP id af79cd13be357-7e9f32eac3amr281898885a.24.1755600010562;
        Tue, 19 Aug 2025 03:40:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx+fHRkuCSbwkkENyWo6GP3r/1txAJ/JN4LqgGMck+98eE4qPrdw+WG4j41jvp+1cDdp6qNA==
X-Received: by 2002:a05:620a:471f:b0:7e6:998c:99c0 with SMTP id af79cd13be357-7e9f32eac3amr281895985a.24.1755600010157;
        Tue, 19 Aug 2025 03:40:10 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c0eabsm745844985a.64.2025.08.19.03.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:40:09 -0700 (PDT)
Message-ID: <cdf1912c57cc49d203aec31c645c1c38e863a0ab.camel@redhat.com>
Subject: Re: [RFC PATCH 11/17] Documentation/rv: Add documentation about
 hybrid automata
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet	 <corbet@lwn.net>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,  Nam Cao <namcao@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 19 Aug 2025 12:40:06 +0200
In-Reply-To: <aKQ7iaSb9GGUtuCZ@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-12-gmonaco@redhat.com>
	 <aKQ7iaSb9GGUtuCZ@jlelli-thinkpadt14gen4.remote.csb>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-19 at 10:53 +0200, Juri Lelli wrote:
> Hi!
>=20
> On 14/08/25 17:08, Gabriele Monaco wrote:
> >=20
> > +
> > +Examples
> > +--------
>=20
> Maybe add subsection titles to better mark separation between
> different examples?

Sure, makes sense.

>=20
> > +The 'wip' (wakeup in preemptive) example introduced as a
> > deterministic automaton
> > +can also be described as:
> > +
> > +- *X* =3D { ``any_thread_running`` }
> > +- *E* =3D { ``sched_waking`` }
> > +- *V* =3D { ``preemptive`` }
> > +- x\ :subscript:`0` =3D ``any_thread_running``
> > +- X\ :subscript:`m` =3D {``any_thread_running``}
> > +- *f* =3D
> > +=C2=A0=C2=A0 - *f*\ (``any_thread_running``, ``sched_waking``,
> > ``preemptive=3D=3D0``) =3D ``any_thread_running``
> > +- *i* =3D
> > +=C2=A0=C2=A0 - *i*\ (``any_thread_running``) =3D ``true``
> > +
> > +Which can be represented graphically as::
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +=C2=A0=C2=A0=C2=A0=C2=A0 v
> > +=C2=A0=C2=A0 #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D#=C2=A0=C2=A0 sched_waking;preemptive=3D=3D0
> > +=C2=A0=C2=A0 H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 H ------------=
------------------+
> > +=C2=A0=C2=A0 H any_thread_running H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +=C2=A0=C2=A0 H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 H <-----------=
------------------+
> > +=C2=A0=C2=A0 #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D#
> > +
> > +In this example, by using the preemptive state of the system as an
> > environment
> > +variable, we can assert this constraint on ``sched_waking``
> > without requiring
> > +preemption events (as we would in a deterministic automaton),
> > which can be
> > +useful in case those events are not available or not reliable on
> > the system.
> > +
> > +Since all the invariants in *i* are true, we can omit them from
> > the representation.
> > +
> > +As a sample timed automaton we can define 'stall' as:
>=20
> Maybe indicate this first one is a not properly correct example
> (correct version follows)?

Yeah I should definitely be clearer about it. As you've guessed, this
example is to show things can be done differently as a tradeoff with
responsiveness, I should make that explicitly.

Thanks for the comments,
Gabriele


