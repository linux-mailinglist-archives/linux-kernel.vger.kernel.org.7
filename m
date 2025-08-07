Return-Path: <linux-kernel+bounces-758986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F834B1D69E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7711E3A7039
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2629F27876E;
	Thu,  7 Aug 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cReP764f"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB4238140
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565973; cv=none; b=ct3ZiFp9JYhMB+Dx1bxFlVCzCivKHwmJqT/HrwsVKoNMtlj5FWa8akVGAnnIwkfVwvLJLFWDMlWGDYbyA1al79aM1o9d+W2fgofTlS+rEbPvLmU48xBbJTPv7SlVJTHl0uC1xKYBdcP+Q2JwzCZgVGiohBUql8iTvY2WxhGqgeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565973; c=relaxed/simple;
	bh=aCk5oBf+uU7I0T67cVUY2P43B9j9NJNVcq2Wlv2cyTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4uSR3iWVFWGeNjCfGCZMcpsXyU9mO0rMilYDUjE1TnARgDYRQI/NoCSeZcj4T9H81ZAEqWHx/ytNtUu8D6PcdD8MVGQGL18loYycDEd5GKtCJF9KKZgxng6/MpyesarQPs2PYH5WlSTu56LLpx++Zo3JGPBe2m2bthQi3ZG0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cReP764f; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-458bdde7dedso6673635e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754565969; x=1755170769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tS5WCia7qftr8p2mf2/K4AYPK240rc4xhDYqqtejS9o=;
        b=cReP764fH6SbywmbRHh08uylSrtsGsdQvSXkBR/isHxijCFkVF+2FpNGaJYbT5PZGK
         iyy7TWnVVt7bdugOF84PONsGjNFFKHjm/1hG1BaGcgOvEEiSdM33KGKm9HqK0uJKKno6
         uLP2A6buqh3toYI5Ga4LhYGegQKx3WhK5bzsnbQ16RurNk+lqUHH7CHG6ex3YOLJewbx
         avORP64DYcKt/JKD20pduAd/vVSkHOR1kFGQ0T4z6gFGslJsf7nXpOkPTRDkoMoEcnG0
         3vveTsDjJluPTk4ISFJTq21LZshEaB5fbSoAxvrI8WPQqCco9zJGe7OJXui81DQIDaVM
         w4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565969; x=1755170769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS5WCia7qftr8p2mf2/K4AYPK240rc4xhDYqqtejS9o=;
        b=QNpKJMa6NfV3iopK1XRJoOV5RUl8SXHjFaCExXEzlzmXY1f/oK6k9gmXEZ1Psv6OQ+
         tim02Y95Pwrty1psh4ZL/mf7gzZR++jjrzG6dmo/oLAx4j7ORwF0iq+LQIc5X2TBdYSl
         OnxMD4GSZYK746RlIpHaPAvTvA2AQ9/rsCgWLOA2c5lxdFQ0rpwnj3eE/j9AJDm2PcXM
         QEV1dLGMmnWpnQV2JWo37K2wA83s3Eya1OWK1IX3V1A/FDTr2X+JTx1UGMAhfOsT957h
         6EcpW7HJfuDoOaDOlQvxFUBQlX/9jCEfsXd58OcYGSWlQn/VEX1iXXod6fusNoLXKJ3i
         Wo4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAkdCLXtiM0scQBh0AG9MO2K81GV+Harm3GBhdDoMLxF7jCQTckSzuKo5joHpgIt3/sRd0jKCdVEwrlZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7e0VyqpQCw5/Gry+VDg83CJ7QuH5tWBRYvp6ob1BC7pWWab2p
	rVF0fBPwMrW4k8onL3Ws2IKtcaXzHT7fwR3enYpeTPlwsIWZSiEEHEr9Q71tkn7XW6tL7FrmAnQ
	P/THs
X-Gm-Gg: ASbGncvOoV8Usdrdf+cHF30jsRWHShmSljFP23HJ7tzpB0uD07ga9C39BMpYza5AUe3
	9lioZQCSu5eUFlvwKL+V+k2+bf/aPcwbgyhTXqQhISfpFwLHGNrEBi6lIwcI/gCGXmg/z5YbvQm
	+dn3e6GtA6BveMs4NmDsP2fNue4Yv/egBT1dvdl6KIxkpqODAE3ciykDNJKZOK+L6Zt4HyOnX72
	Pomhu/ezoVXSOr+MX2Zs90pqGWuow4fDBgfIgcuEVlJe3c8TRx8SCGaYKRSt3zbLZTbrY21+29c
	5IYHoc6Bg9kgK0bRBFq12A26twf9J6eEaSq4SKgdXVujk47BIrgG2s1yJGyfp/2Z9bVXiBdAUQb
	FL6GqiEFys9MsxWc5iG85a+zqMkiUxZedofS+RfSVTiztMWcfYzpK
X-Google-Smtp-Source: AGHT+IHJq29PT0clhBo6F0cn8O2V+zRK8NjH0FuLASC4fLJxcSmkIT7c170Uwdmbb9l2y/ilSTqY7A==
X-Received: by 2002:a05:6000:2381:b0:3b8:d337:cc16 with SMTP id ffacd0b85a97d-3b8f41b523emr5416087f8f.41.1754565968809;
        Thu, 07 Aug 2025 04:26:08 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977345sm181545495ad.108.2025.08.07.04.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:26:08 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:25:57 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 3/3] cgroup/cpuset: Remove the unnecessary css_get/put()
 in cpuset_partition_write()
Message-ID: <7u4dmzplzjnj2v6l54xrabdy23laax6rwjhvt3lncbueoekfbc@g6ug5de6c7u2>
References: <20250806172430.1155133-1-longman@redhat.com>
 <20250806172430.1155133-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kkslxjt4uy5baxbv"
Content-Disposition: inline
In-Reply-To: <20250806172430.1155133-4-longman@redhat.com>


--kkslxjt4uy5baxbv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] cgroup/cpuset: Remove the unnecessary css_get/put()
 in cpuset_partition_write()
MIME-Version: 1.0

On Wed, Aug 06, 2025 at 01:24:30PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> The css_get/put() calls in cpuset_partition_write() are unnecessary as
> an active reference of the kernfs node will be taken which will prevent
> its removal and guarantee the existence of the css. Only the online
> check is needed.
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--kkslxjt4uy5baxbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJSNQgAKCRB+PQLnlNv4
CN56APoCoplEsb9HyNijcd6TFKw7nn8vADYOfifnkefkpM0rWAEAgdX037v2++FT
s3OlTMXJ6WNnYxx1X1RPo7nS0T9iFgA=
=3StA
-----END PGP SIGNATURE-----

--kkslxjt4uy5baxbv--

