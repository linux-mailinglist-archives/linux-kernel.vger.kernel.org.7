Return-Path: <linux-kernel+bounces-813102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110DB540B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400E91B25BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED9D22126D;
	Fri, 12 Sep 2025 02:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKoIXlND"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE321FF4C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645721; cv=none; b=gkxdCCi1aunxWtWVo3kWEI6e7aULGoIJDhx4tQ5XUauCk2wLhCBBAAS5wGMXH5NonOxLrWhGQwfGjZinSXID/IhQS5/mQQ7NMnx6WlW6TJJIJzuobuMaN5HK4EwWgDjI3wurJkMAbv62AS5XYaPqH8K5pY+5obtf0AshPNTpo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645721; c=relaxed/simple;
	bh=8dUblNqD+QvR3lypM6+6pgQKaz5acFHh70UWBGlz9eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmLY8HHc/Bz8HQNM+vlo0nTW0/jMHBwZNlqLeDDGmYApNbcp2VBep+yi4cuDzZsWNHO6zcSiuXeO6T/E0acuF/mDBug0FNn3Zmw6R4+HVUygD6xv9A9goKqfypTW0uVz0eZkaG9kCpOTdSZywcvc9d4BtXKC9ZEeY2/pHCY61/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKoIXlND; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32b959b4895so920268a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757645719; x=1758250519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8dUblNqD+QvR3lypM6+6pgQKaz5acFHh70UWBGlz9eA=;
        b=VKoIXlNDVjjQcM0nV8J6JZHH10HMkxnCiF5gnIodzWTX5ioxi3aujvaz4MP4X1JgaE
         gMg3L0M4m5Ykn4sFNfDpBvLAijNPWD44+UVuscgXpHhJn4lJfPIGnvxIedOYeS/9S800
         qiA0A7DDRCTduJa5zK7HqOBc1dv8EeKJUKMqvrH3WJ3FXiUMqZ4ObrA/PHTEE3ntiTjQ
         CfSkB1+OuOl84NrRiTB7BPkMGo2Kt0Eku4xt4znS20bqfufpJdSc7TadRbgcUq2OVSyd
         wMdGS81EkZuHLxsXzB+e1DQAEEY6csky8ch9I4XocMIjQG1Aepm1Hd/CUTXkFOzoMwRw
         lS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757645719; x=1758250519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dUblNqD+QvR3lypM6+6pgQKaz5acFHh70UWBGlz9eA=;
        b=BcnqR4omZUrX/D7f3qebmrWJs0NJkET0JXVz942hlZ4i8+iUzjl9X3eKr+i3JOw36a
         DQ7OMIsXrMlslqIyLQXLopJq4I6ay+s0MR6W35i00NRoIxoDWkjdVOm8378Ux2Oraaok
         90/fydYuV19vN+dJaT/x6XNoyOUXEUwOuvJQX5Vr8rQ+HPJXr81trAPzOkY+FWaY5C8q
         WYHMAILK2i3of3rnh58DY8jfRZZl9ty5roEo0HZvPzldaeuw70Db7OfxGLZfFDP9BidH
         1v8ZJYus7vOrcQif7ZFiACbV3+5khFXzxetYwrU2W/UQvCvmtC7b6qIT8cffSRrMinuB
         7VjQ==
X-Gm-Message-State: AOJu0YyVpkhjVVQpdExlg7K/Sw6zqvQegRjJi0aRVGrvKgvakr9EGkg3
	J9XPj4JUnrqt573aF0VJwxqJpqPvKWlhLFcfJU8Lb6uRRkPnI2walxzY
X-Gm-Gg: ASbGncuCWAHHgWyIP6Zdwl/OQGXVkg6+NOApwBEqhQFjOgkb7d6VuzWHin0Py+UFwix
	YSWEo7i3SBVhjjXCDhSu3T2SbFmRwLRFORggQeAHBb7Wc1QZbSqArMijw6XlantUf4wbsUY/2ru
	nqkhBek7RxrOU+0aIhf0sdPjb59xgFdQnq2UVjYQG/ln89Uf88V/i/eNJCzG/WF95PsAVC5sBVv
	ve+cu8CF0H24zrvGMittE9KMmTEBT0e62InbJX8uTbJaY3Zv3SSXg0uORr5FUT26Wf5H/sveqjx
	SAvxR2iWw9dHnLM4Kla7DMJLXrIg1PFr2lfo7UY94qe60qsLYEWM2H3P2zs9QcoOGLl+M167pFW
	aCoaSM2cHltZqsakYkOhh0qm8PQ==
X-Google-Smtp-Source: AGHT+IH5JN5qNkoNcsYWg6dw0fXdbfeF5sEn0cts8H3wCmJnWb9B3BmToRmZiDopftsOn3Mj7ikpQw==
X-Received: by 2002:a17:90b:17d2:b0:32d:8eb1:4e26 with SMTP id 98e67ed59e1d1-32de5144a8fmr1650790a91.30.1757645719140;
        Thu, 11 Sep 2025 19:55:19 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd632692bsm4479084a91.25.2025.09.11.19.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:55:18 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1BF0941FA3A0; Fri, 12 Sep 2025 09:55:15 +0700 (WIB)
Date: Fri, 12 Sep 2025 09:55:15 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 5/5] Documentation: trace: histogram: Link to ftrace docs
Message-ID: <aMOLk7SAOrjogIy-@archie.me>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
 <20250911042527.22573-6-bagasdotme@gmail.com>
 <20250912095827.3d5a3feb80d5c6c44667328f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0lyQ/UvkQaG+h1EJ"
Content-Disposition: inline
In-Reply-To: <20250912095827.3d5a3feb80d5c6c44667328f@kernel.org>


--0lyQ/UvkQaG+h1EJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 09:58:27AM +0900, Masami Hiramatsu wrote:
> On Thu, 11 Sep 2025 11:25:27 +0700
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> > In brief "Extended error information" section, details on error
> > condition is referred to ftrace docs. Add the link to it.
>=20
> It seems this does not add the link. Can you make a tag and
> link to it?

Nope.

What the patch does instead is to convert :file: markup to proper
cross-reference. I will fix the patch description in v2.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--0lyQ/UvkQaG+h1EJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMOLkAAKCRD2uYlJVVFO
o+jSAQDIDumTK8LVsSWKsUI3RUgdsGDqRYt2dirDbpbLNSnz0wEAhsnSBv69gyj9
k5kn7BpHmEuJjj63nZFMXRa0UbXj8Ao=
=+PaU
-----END PGP SIGNATURE-----

--0lyQ/UvkQaG+h1EJ--

