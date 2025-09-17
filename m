Return-Path: <linux-kernel+bounces-820612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55952B7CC65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF24328758
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EE832BBFC;
	Wed, 17 Sep 2025 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTRrwU8f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1F32BBFB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110894; cv=none; b=p9SpY5SkAIub68HbN9k8mlKQs4EQAjMpmPNE9GSxOS42Lf3CN2jAgvQOwk0XNR2sQq4saW2uKuu8EADRlw8W5iQx1CUI1Es9/Uqx1kEy1YOD1n6p7evH+To7a1cF+GhTt/HIvgBQViSCpMRrLJb+FLK7sAvrziGfshBS3yqpFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110894; c=relaxed/simple;
	bh=piXssCGGVpnNRYKOcCyPQSu+7t/KJXU+Tuyxxx36xG4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bGmkD6i69iZSDgnkWSj1XOu2MUKX9kjR7GJnFwvimiRzT31RHa8fyQRUyjQj6ySR7tGq4skLpybw5/qoZZVvQAZw11zvQqqukCOgcMdYC2VhzPvYNaAF5V/Qub6BcerPDwhNwIQfltdlh+v/gpNumpXEgOxGYAyNa6NzeEN62uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTRrwU8f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758110891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ttijvk6a9f7X+8g/bgTcSq4o31dKHeeSGnSIznqt00I=;
	b=DTRrwU8fEa6SUFTtAlGTvS1KzSnSa8bQXC74bRE0eINvQiAg9uQVjB2SJfGP3EZ3UcDaW3
	d5IF2gb8or/H4aCoJxze8j0/00TJ7XMOHANeCEKtjEVpxfWMRvmQDKavPjA8eAAnrUXbdT
	gkbjY1xi722L/6k+iPPYlMa0hKfWtfs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-7d8KLYW1N1m2aKnkiRD31A-1; Wed, 17 Sep 2025 08:08:10 -0400
X-MC-Unique: 7d8KLYW1N1m2aKnkiRD31A-1
X-Mimecast-MFC-AGG-ID: 7d8KLYW1N1m2aKnkiRD31A_1758110889
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45de07b831dso36219295e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758110889; x=1758715689;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ttijvk6a9f7X+8g/bgTcSq4o31dKHeeSGnSIznqt00I=;
        b=JZglfffpal1efQYZnngVAkHiKe0xcTUuaxzo+jvqy/50aOfWooTxHr93gNN7UEOT6B
         6qbKtLgHf32BOFglcxOW0nmy1yvVi9/49MKFCw2cKkJKFBEwiV8OVQMKvyUpsW5Lcr2Y
         Ic67M95f4Cv9CNTVA/SdOqhKNntuSSjTNJTBlCpsdQg9pJ9oRcA5sM5IXHTA0QB90/tC
         9pjOX6JiUAx1+5utqi7YTfZ/D2M1/w5xn/XM4Xdgo1cUY4aSsZCP0rZ8DdmfbQKBr/1E
         QNLoaEP/iDs4wlFbCerN+ia9Qqk+QqORHFnxbneYV8uEZ4pWYQy9SWdM92Xs/s85VboY
         tBMA==
X-Gm-Message-State: AOJu0Yx8/jThPoK95DFXG+X6EiiL+cU3A4Lig1ZyRiQQ6fpOQfAapttE
	t3e52HOZA7wv8bCZfmn8NebuOZ1C6/EqQ6guTuCuNH35vFffQmZ12X72zazmwpmWy6mEQA2VRbs
	GMYAyrAkmbGeeArvM9PHbaO1YJsK1/ivZhlpnVVxcGSRni75pmdkn8ja+htM2578TtA==
X-Gm-Gg: ASbGncuKXaM/ktdvvrqq+E3zubN3FLFRPv41bbM4wr1usH8whK1Gmc2QPLybp2xAFpo
	qY3cPxyKehTTKZNqIkPomMpXys/eGbCQOlnxsxqioqiIVMMHPtVfhR6qct5e8jZjTP9y1NbfkDZ
	7aHC1tZIZevA3KJnPrKkb7ty71BJVV4F6MByolbLyBlqNiX6aXI4Aw3hBqY2dRxwHl8hiyNdfyU
	GCemofrpVAbMI72inmDLGwoi/2ffhdKYeO8h7PBUGSMeVxaSkxWiPHF4HLiZB55EQek4l2+vG0U
	1o4L6v2hyLlWry1oijGbmfC9gSw5Hn0ZZglybWHEgYvWa6jx5W4oiERDJC5JwUnQGg==
X-Received: by 2002:a05:600c:46cd:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-46206842acbmr20258965e9.31.1758110889265;
        Wed, 17 Sep 2025 05:08:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMtSXBAr7MjPGCinzNKNwmt9SApt5OE3jhHmNpqe9bkGcfpMc2s+brmV3PcaX33DNRBuYmbA==
X-Received: by 2002:a05:600c:46cd:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-46206842acbmr20258495e9.31.1758110888692;
        Wed, 17 Sep 2025 05:08:08 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461394f6081sm35304735e9.20.2025.09.17.05.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:08:08 -0700 (PDT)
Message-ID: <1d15af4ab9f8f63dafbf4810a76eb3d547217596.camel@redhat.com>
Subject: Re: [PATCH v12 8/9] cpumask: Add initialiser CPUMASK_NULL to use
 cleanup helpers
From: Gabriele Monaco <gmonaco@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>
Date: Wed, 17 Sep 2025 14:08:06 +0200
In-Reply-To: <aMqdzQcwvkjl5WNA@yury>
References: <20250915145920.140180-11-gmonaco@redhat.com>
	 <20250915145920.140180-19-gmonaco@redhat.com> <aMg5EzmxG3hG7aJK@yury>
	 <820443ea-56d7-4fd0-9535-b1339e53240c@redhat.com> <aMhcYCCJDFWoxcyw@yury>
	 <aMlJqDjWNyak07LX@localhost.localdomain>
	 <6aeda48661359eedd232c9bb0c337d93c36dae70.camel@redhat.com>
	 <aMqdzQcwvkjl5WNA@yury>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-17 at 07:38 -0400, Yury Norov wrote:
> On Wed, Sep 17, 2025 at 09:51:47AM +0200, Gabriele Monaco wrote:
> > According to what I can understand from the standard, the C list
> > initialisation sets to the default value (e.g. 0) all elements not
> > present in the initialiser. Since in {} no element is present, {}
> > is not a no-op but it initialises the entire cpumask to 0.
> >=20
> > Am I missing your original intent here?
> > It doesn't look like a big price to pay, but I'd still reword the
> > sentence to something like:
> > "and a valid struct initializer when CPUMASK_OFFSTACK is disabled."
>=20
> The full quote is:
>=20
> =C2=A0 So define a CPUMASK_NULL macro, which allows to init struct cpumas=
k
> =C2=A0 pointer with NULL when CPUMASK_OFFSTACK is enabled, and effectivel=
y
> =C2=A0 a no-op when CPUMASK_OFFSTACK is disabled.
>=20
> If you read the 'which allows' part, it makes more sense, isn't?

Alright, my bad for trimming the sentence, what I wanted to highlight
is that with !CPUMASK_OFFSTACK this CPUMASK_NULL becomes something like

  struct cpumask mask[1] =3D {};

which, to me, doesn't look like a no-op as the description suggests,
but an initialisation of the entire array.

Now I'm not sure if the compiler would be smart enough to optimise this
assignment out, but it doesn't look obvious to me.

Unless you were meaning the __free() becomes a no-op (which is true but
out of scope in this version of the patch), I would avoid mentioning
the no-op altogether.

Am I missing something and that initialisation is proven to be compiled
out?


