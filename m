Return-Path: <linux-kernel+bounces-844909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0CBBC308E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 02:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A32C4E7AA5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 00:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1471D7999;
	Wed,  8 Oct 2025 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a++kbnUX"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C881C3F0C
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882249; cv=none; b=UhuhmiXrUnoLUWbRd1CG/iPQPAd/uylNCXYAUDSkBuGq1iV2wfo3UgdYji4RRmW+MZMuH6u7btLc6nKimGOiov/tQif4xNRGOVXJa4931HdoDPuR8if9mhxQyCiSlGrDiofW3iedtbPuXz9rIL5gh4Q9ORRLdh4abTsdxCwS9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882249; c=relaxed/simple;
	bh=5DjQq9GiDEKkg86E8LlrByJSBd0L+Mv47bskd5ivaiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpDVxD5lvnvWEBHUP4oYMzdg2JUvnc0SkncQ9aBTRzEX2/JJJVdZVdGY0qHH8p4FkzoBcUTJf2EDqmiTte0exqke0UNKCjW8h7FA8Eb7OHI1bU/V4tYnMYr7Po5LVwEwCJwAbNJMGCoLG6NSuqkRTzn95apQTite7yYvPUtfdgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a++kbnUX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d2c35c459so49967945ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759882246; x=1760487046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5DjQq9GiDEKkg86E8LlrByJSBd0L+Mv47bskd5ivaiE=;
        b=a++kbnUXls80kZ7XDSqSEUInqPJigojDkH1eqmCqIJUWuypYFfVGtXW3ZHIJqZY7PA
         yOpKfzgrO0WU5YQeq4K/W3gytLpg8jEZogcysb3PMtSPPbusoZ+Jqr5GfWga0UMNXNWK
         ovWrlwzhkDxmo4Wek+3ivWsy18Vz2Hfw7k+ffmLaxFQ8zTZWFBthL8LkbVXcBOTs5aq8
         1OrXH3zDPEFn1R3tltilA45keyc9Cda+gYo8lp0blJBW18owJsjWoDqOKOgLWwh6pg0I
         GFmd49pmmdMoE/QcYASB/wHlo6WKu1jET9e1uxnBX8CxJWF8++6XclgbRvBPtOQYPSCN
         HDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882246; x=1760487046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DjQq9GiDEKkg86E8LlrByJSBd0L+Mv47bskd5ivaiE=;
        b=Y84j76t+kwCurOszJ9m8i0fiytfoR1PQt3wkk56nQCBgb+Rj38LyoEIp0XTlT+NyZB
         7YTdE2ejcs8MI9eyk195uhgCrM9c9zV+ncSkokLgBYpuKD8qkFHrQACI5Q2eVtGnuXCq
         1NnJ4f43xFKLTTCaHzt9VlbdFY8UxjGin0aPakUwEk8GTzTqXhoodf4d6SB+WcTGLLAy
         pet66KzzYekmxA6G67w3cc2+qToVQXjnnk0rWGg8727JN3G2qtmIDb9+RxuoLdumurl3
         q3y3l5pn8BF7PRzOigvOrtyV+F+YAg8vmDo65zEnktGpIpe8fHIUCAx2msEH5B/8DcXP
         r/IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN9Q+WaX5h/CoJmx9MvLh7aA9M4jD+RYmh1jwhecRvz/ik30/+Xl4jNO1bP71bhMx2Ypqg6yAlIuJcHIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ZhrzHMOGUWKRO6sTEqq1nwIWdIMjqNvtHKP816bQ2c3Apr3R
	Kbt286ZKeVKFyrp/COzS10QuPzc0cwq+9hJgYCmLd6AbFKTF6R+aNKHk
X-Gm-Gg: ASbGncsZN/FqJ+M8+lUotIKITvzmq7htbeCOygVZZEMJL25mnizaWl+f0wQoRbjq8pq
	8EG0ZZ9nuiIeDkuwLw0TS9eoIUaaMbaBmpaHlJ6aYwhMuUyJRVM/Bw7vOm1Nz3SPpgXTIbI5ZoM
	a9RQQgUQlnzlysyrpcA1NFJ2Tu402FuuI38Rg86ZP4TXAqcAPBQFvwqpni8dv3GDkSOADU/XsTU
	+hp7EnF5dqxo/D+LSsiOJrFN3qe7je8QD3lbKQIGGRH6kfBg62mAJ6RMH0znp7I5sKomQ6yncvW
	e7VteJy9EX7RVeoMK/mrJzvL8Zvo9ok4bY3oqhiqu+1hzwBH8MZvSNDHcwWEvc62ZSuPa2AhEI8
	lYpkdl7YYakhFc1ic55l2mzp7ODeIsAvq+7yGEGqktR2BYjZYfQ==
X-Google-Smtp-Source: AGHT+IHgwCD+l9vU2RGoqSNi25s3Y73FXtbqCN1chUFkrAL5OHXH3HCXgZb11azdn0WBZQ2RZ5Ft7g==
X-Received: by 2002:a17:902:ea0d:b0:267:44e6:11b3 with SMTP id d9443c01a7336-2902737494amr19890155ad.45.1759882246372;
        Tue, 07 Oct 2025 17:10:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b87acsm179342975ad.76.2025.10.07.17.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:10:45 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B28884233430; Wed, 08 Oct 2025 07:10:43 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:10:43 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 7/8] Documentation/rtla: rename common_top_options.rst
Message-ID: <aOWsA-HaX7A9Uqox@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-8-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xXfMCs0OD+RwnfE/"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-8-krishnagopi487@gmail.com>


--xXfMCs0OD+RwnfE/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:56AM +0530, Gopi Krishna Menon wrote:
> common_top_options.rst is intended to be included by other rtla
> documents and is not meant to be built as a standalone document.
>=20
> Rename common_top_options.rst to common_top_options.txt to maintain
> consistency with other common_*.txt files and prevent Sphinx from
> building it as a standalone document. Update all include references
> accordingly.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--xXfMCs0OD+RwnfE/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWsAwAKCRD2uYlJVVFO
o3/hAQCgsR/Awy30I6u1h473v37KycMP9YzYPoQLzG7GDP3h9wD/fINZ49mckUaV
QQJZIpiPaubn2Y1EnpJshktreCf2igo=
=4+9L
-----END PGP SIGNATURE-----

--xXfMCs0OD+RwnfE/--

