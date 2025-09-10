Return-Path: <linux-kernel+bounces-811131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12288B524C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68A0C7A5C22
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFFA30F936;
	Wed, 10 Sep 2025 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR8+Idjh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3A21ABB9;
	Wed, 10 Sep 2025 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757547698; cv=none; b=E80PaQ9OHltPXRuNjYr+JzQIIzgExQ4wFqzPzqAisZu5jmp/wXUR7MXkis7c1YPB3yMVFL4/8VtMBVitR0Rl0CWOtBfdJNpUtjFPi25KdFOUc4bGmQV5Ux9/Zq0JROeCCVo1AjGsPeK6hd9xWDcvemgnBaAmduLTWXMjQZVbqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757547698; c=relaxed/simple;
	bh=/CIC7CwmIJL1HWJm+gFKpQIYWIydgvlXQgBo8aAnR68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWcg7EgILLSddfzHAIo6FiRBwmKJDq6VRuOUTABNJE/jlR/VUaIoyKqdAPRqHI0DydSsTsgnRjGqoqAhl27HJC5wdeECsHYYiAmdHGa8YM2nfefz4DJgH+VKsJ4LMnst/hzU6liBcZHdUdKNvfoK5sd4ERk0DJQVFlvTA0g31UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LR8+Idjh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24b2de2e427so632945ad.2;
        Wed, 10 Sep 2025 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757547696; x=1758152496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CIC7CwmIJL1HWJm+gFKpQIYWIydgvlXQgBo8aAnR68=;
        b=LR8+IdjhqKUZwWG0xyghMkN9bGftbeLhCNN2ftE9g6FAHf0CuyEsePiuhol+JWqhcz
         yT3sgZYj3BevIP2YGyZL3Ifw5BaAau4ZGo/TxSt1HRfgAJCpiTi4FOIQ8fsLG44R97x6
         XSc+hQEovjoN8biOJMVRuREgBA5V1mLBH8GK1EKH+LamoQ11l+zZQDnyJCGdXWuqAU8V
         bM4SEuvS7KXXD/xdUmt7V7U1e80q41L0BLVlnc+pVnFhoml4OP0SPSTwPjwvcSklw5p2
         qNRX9Osbf303+0QCczqrgoncZrFRsWRaWgNxPfjVxeHT+3PJqmuVYU4Kq58TRmEk/LBT
         +quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757547696; x=1758152496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CIC7CwmIJL1HWJm+gFKpQIYWIydgvlXQgBo8aAnR68=;
        b=mR6hw0ZQOYxE135IW9onVE6GoI36C/cfp1lKH7h8ql3WsQwHZ/LfS5pLe5K/jkizGm
         83ju4PhS3eYm9SGZ5AB23szO7kCUyu8UboJ7exGRJxxzjRAzaarRmeP1zngyfqcTtBir
         4SDXpSD3wohWe5bevqgoIdTzEZZPp9GxQm40mreDquuLUNjFkZKWsxg83JOL/2VphpQI
         qc1g4IJ5n9pAH3HFq3QZ5zO5s2MQv9yW1BEVUQOsLaGo0WhkpqKXHjXSPB1jB3Aytf9k
         ZNGL2nerw+s1wxbVUCTVtkBvNOKfibgDw3qoNv6gxBuKuql4244alKgMsD8YREFxR/qX
         tC9g==
X-Forwarded-Encrypted: i=1; AJvYcCUPuq1+2asozDDqd0BtV2lX8WPKes+Kb9PAJ1KtSvrigEjP5Kv6YB2hzePKX76yQKaXTQkIiNBC+Cw=@vger.kernel.org, AJvYcCW58Gju0tDSGK5XVYvvOD3YaWAMXxMuAOp1WIk2Q54Uf5OtxybEY007pWfhL1Fp5luo0OU8UpZltxO4fF3i@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2FhlFerLcdnHiysVsUdy0HexvzSYT/e6EZuiufw7KOIgntecv
	MxDN7K41fJw0xMUdF09oKMmD2cFdguF97NerNXOlMGMhCpT5zhHEjZ57
X-Gm-Gg: ASbGncsoWgl1s+4z9Qo0Ew78YkXZzprf5CYIzlASwMUf9jLG5mcIDV4zP6VDdGo1FT3
	xW/5ZzMlmPs09lSqzWdQr9WLN9ruLoHOnigqgK6hEH4jNU9g9YVSXRXfNjQ6udY8UAfETcXpLdD
	jH6tw1uEFqbFobCzmC4U4U91EiA6GlFLEAeGw0NXL1qyN3ibSGOGSzKBg39h7cMydTEeAx5VwNr
	f3KLYE4XtlWZBWFVGCO54Mz4woddWp/p+SMwufPUDINNQJ8XU03jiEa60a8biy3mp+D8KrBcitf
	oUIhYMTAh2UlASYAcNL+8z1+/QnhWrbalfvTK7brE36XNJj3PKok7qEQm2Mz890F+8QYLjV/eJN
	1D7JCxiaz2wqG6fOabLvhmlV+Gg==
X-Google-Smtp-Source: AGHT+IHU2zlntDNV6h4NG6CW9V6x20J9LTc0sJI2cj9065qL+Weta1oYP+ihM44ibqxT3EDmV8tEbg==
X-Received: by 2002:a17:903:3d0c:b0:25b:dcbf:43a2 with SMTP id d9443c01a7336-25bdcbf45e7mr7234665ad.52.1757547695955;
        Wed, 10 Sep 2025 16:41:35 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25be6fc0f23sm4297075ad.48.2025.09.10.16.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 16:41:35 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DD5B041FA3A1; Thu, 11 Sep 2025 06:41:31 +0700 (WIB)
Date: Thu, 11 Sep 2025 06:41:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	Bernd Schubert <bschubert@ddn.com>,
	Jeff Layton <jlayton@kernel.org>, James Morse <james.morse@arm.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] Documentation: gfs2: Consolidate GFS2 docs into its
 own subdirectory
Message-ID: <aMIMq_8i4LUe9yOX@archie.me>
References: <20250909014606.15043-1-bagasdotme@gmail.com>
 <874itbv23b.fsf@trenco.lwn.net>
 <aMC4LIltHWlpF9iY@archie.me>
 <CAHc6FU709iYrAVB+2DeL8+AkCMtgwtqC-7ikx+f=wqYPAZfjmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OVswxxCfIJEK97dT"
Content-Disposition: inline
In-Reply-To: <CAHc6FU709iYrAVB+2DeL8+AkCMtgwtqC-7ikx+f=wqYPAZfjmg@mail.gmail.com>


--OVswxxCfIJEK97dT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 01:25:13PM +0200, Andreas Gruenbacher wrote:
> Sure, I can take it. Can you please send your v4 patch to gfs2@lists.linu=
x.dev?

Of course! I will prepare it shortly.

--=20
An old man doll... just what I always wanted! - Clara

--OVswxxCfIJEK97dT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMIMqwAKCRD2uYlJVVFO
o1nWAPwJPNLFwTgriVEqnN7Jlnjk/u/i7R58qvOBwAL7J96sXQD9FuoTv+2Yb5va
sQrdnSCbUPZOLQWc88YU2k3Z+dgK1AQ=
=eyoj
-----END PGP SIGNATURE-----

--OVswxxCfIJEK97dT--

