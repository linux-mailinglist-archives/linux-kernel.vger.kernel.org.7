Return-Path: <linux-kernel+bounces-844903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EB7BC306A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 02:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8AB64E36BF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 00:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840A134AB;
	Wed,  8 Oct 2025 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq3YzqhF"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325AB15D1
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882033; cv=none; b=AbyTPZ8IAl/y1II0KEQ5eQRhqtekccxNHaUGr8MvPL9Sy7gruXnOV/JBLilkPTm74X+iUSq/AcYAB+WRcP7oV71TOO/JDu4h/EFenDEcbTBD75A8SYob8Az8/C8dtEkh4lbRYLB1WJWKc9W1GFbKWztiZcHuOzgM0zzc7kHvrBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882033; c=relaxed/simple;
	bh=vC8ooiip9yJoKnRrYy59NMGAT5KdgSyvEGK3SSFeUbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGHXpr0zXahJgBDSboftsLTDUf+37uOQ2qBO1EFNK/OJbNB6rVO+QsIujgKS5hKucqXWkg0RY4PRkwLtxHc/+h1gIw7X9rgJfuM0wBKMm43PeYZgrzVV6E/Eanq2UFwcVZzHN2+bATOwUeYn1pT7uOseO3/LdMzTeVufx3KHeDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pq3YzqhF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-791c287c10dso2284609b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759882031; x=1760486831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vC8ooiip9yJoKnRrYy59NMGAT5KdgSyvEGK3SSFeUbc=;
        b=Pq3YzqhFrWQhgS8sBvscxPq4JRDaw9JfdcZRYivF9acsS1Q9pyXtRGgrRfcpJBahTv
         LL5TKM2sp5WfdL3XvY17I+jrWlsskBzdrO7PPXN4ceuwZ1dUd8ftlCY7UGNeiX0TREWV
         dSkLAuJspqpd2mO20l2nyhO/9ovPItTwNpj2K5H3/B+OcbFB6B98NBlBGWOFb5GFjWLl
         vXDPAUT/rR4srMKv2MKe22sfEXuQkgVWXF+GNuChdjxZgjc4Vx8TtJ+BKRVvndCxyz7M
         ubVSDLagaFX0gXAf3fXLgD0PLWfHgszehyRSdV5QBihebyzK+Xs371EXE9f2a3RBBK0g
         ahuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882031; x=1760486831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC8ooiip9yJoKnRrYy59NMGAT5KdgSyvEGK3SSFeUbc=;
        b=bKqZU7MSXomkjms/cAYLNGbyBVbtdfMwxX8/AD1U21IwpSW16GFB3DSq8boZ/L2Wg3
         YNkCamU4UljMV1C4zNLyVWcopgfNz0fVba7kIgFMQ0fFFNg3s4DaQGHOz4gzGSQ6qqcu
         t4sLhzib0zH7dqOu17sU4UKNmKHfi3NKJ/8B5gT7pcmFknW4v2ndAMuqaRlVmH8n8rnS
         ox4Oza37YK7CD27dp2CiQszP1Kumr0EXaJDjPT9jGGHjv0MK6UsM5e6gvTo1/7yoVWmr
         XzO9Yl6e4BPidiTeUk6MWm/B+eaQGcZXPubNBaT6xsR/FwaIWGQCGyIp7hzZuFq36oli
         nTkw==
X-Forwarded-Encrypted: i=1; AJvYcCXOJodqGos6fszzTzUgPHou+bxAMqggVWtAP0ElY0MBNrXZKLMUX0Q3svNymcZ6lR2wjtO0ttK8lvMYOsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mFt2OgoLXU3PASu1YuPdrSN7jGwUoCI/n1DZ/7hNYhpxFHWh
	NxFzD1qkoA4osbkbh+/8RHBN818SQRwGRO1675nvRP8qGqwvbQebvQNzyVLtWCdf
X-Gm-Gg: ASbGncvfo9zsH9b3yNiorv7jEt8NzUz4WBlrtOQ2qUAGwPzNTHi96erMzASkPg3Q+DD
	NS6wSw2mn51SdrWFoohLpkKKpyDjKlHewrOTcAIev1mEblSzFaCCsOIWWam2QHeduw4kL8FhRbN
	hIj5Jbmztq+DMiJqixA3QswDxraHMuN4bjyd/TcAqfpqmmD1EtFGX8iZPacPRAyjOLW3foMoU5u
	pbrHGv10dmlmmtum22fc78sMYJUXLa5xBqYEFb2Omg2RNA8cHMx5wHmoA/IDY1ZFmFEBkVTrzgK
	uvkq+Vw0H6WY5NJgD+aEVaWPSXAw1MxU0cXkQqe01Lv5k+g1gAw6DtA4QlcrHssWI4GLnpTlCdw
	rQs/4PNzSxwp26G0lanqnYxY0iXeZ7Ph+45V1svuxV6MOJujMLw==
X-Google-Smtp-Source: AGHT+IFc8t5RIReyxhe/YhSffa5uXVtkzd3/79NpH3j4fjj8RiMnktaajaSJ8gcmock1LzX66HbTfg==
X-Received: by 2002:a05:6a00:17a5:b0:78c:99a8:d294 with SMTP id d2e1a72fcca58-79382c6bb87mr1630730b3a.0.1759882030944;
        Tue, 07 Oct 2025 17:07:10 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020537d2sm16845105b3a.58.2025.10.07.17.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:07:09 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 50F3C4233430; Wed, 08 Oct 2025 07:07:07 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:07:07 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 2/8] Documentation/rtla: rename common_hist_options.rst
Message-ID: <aOWrK-vPQaqbgUAH@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-3-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B//GlOCCMvZhY8mv"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-3-krishnagopi487@gmail.com>


--B//GlOCCMvZhY8mv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:51AM +0530, Gopi Krishna Menon wrote:
> common_hist_options.rst is intended to be included by other rtla documents
> and is not meant to be built as a standalone document.
>=20
> Rename common_hist_options.rst to common_hist_options.txt to maintain
> consistency with other common_*.txt files and prevent Sphinx from
> building it as a standalone document. Update all include references
> accordingly.

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--B//GlOCCMvZhY8mv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWrKwAKCRD2uYlJVVFO
oy9ZAQDYJV6qE/AzMUzQwGGq8HBR5bcwCtyChfYiU9bhnHMyLgD/bkifhp6WZd4p
YPpU7zjarwlFUjfFPhgF7OOFDRTrkAk=
=kSCJ
-----END PGP SIGNATURE-----

--B//GlOCCMvZhY8mv--

