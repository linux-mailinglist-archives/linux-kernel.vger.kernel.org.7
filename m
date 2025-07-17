Return-Path: <linux-kernel+bounces-735359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA90DB08E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D651AA8602
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CD02E542C;
	Thu, 17 Jul 2025 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SYcyU7B7"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E712E4995
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758914; cv=none; b=ob0TWvUwtAmWifjets3jFbRegK09DIpdEqJUzciX/hdLf5ZZT3SaqLyFKnUebLQHk0kciT6ViBxhnn67ZF2k4xG/ugUbTZ2LG1T6Ft3UruPqF1csAbu9vUBTin/TSMB2mRc1sBbRZ+P3MlxvPyE2sxehQetsRLxy0ZGJp8bN0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758914; c=relaxed/simple;
	bh=uhLICpyonaXsszXJDK/zPlGgsrZp0V9gZHcTjqC4y5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOsLn0O/0yxLZHRIN+5LAKpodcp277VctQDnJczKxOSFdPUxrIGIIHFgg84jUHjPqwmwD3A/zajSiVscm5EXCKZEt2nKaRyLWl61zA8EougYNHFR6DM7+IccGRp2v0nnqXfR5lhM2r0s/4ZtMl4S3cQlmtPgX0uxuQc4/PDXaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SYcyU7B7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so1741534a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752758910; x=1753363710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhLICpyonaXsszXJDK/zPlGgsrZp0V9gZHcTjqC4y5g=;
        b=SYcyU7B7R96EUeLIq46nPnI1v7HDYsFFND9TTaj1oQGQoSfquln/NnSEZaBbSVm5p0
         Dql2DITPQw4RR/62PbfgcY8EQoOMDkteyzsY+fqIUe106azRlkeljlVpmmgWtGjpQcDp
         vSQFwDojKXXk20K9ziV7yxTeGbZpwLcgiDOCA8oPnsGiqfiWjrAPRSAtqN8YfJWsaU2e
         dmUOyNABiZuPH1wKM3fnY79Bu3prDsXJMqlcPi2cvBPSR2391iyC6sEZT34oPdeCt0tH
         +PX4fi4sFMnT3MH5DPC7p6cBvCTZV1wdAZmx/AyeA4XPnVekFwbjhbmpoy4fsRbQOSJt
         O5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752758910; x=1753363710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhLICpyonaXsszXJDK/zPlGgsrZp0V9gZHcTjqC4y5g=;
        b=S9AGvi80OnINLohOS2GuzCQvvhCkSoLF2+b0yMHRosMF0Uz+lvNbSJeKHIy0ewvW/i
         u8wIXn+oc3kvuEGmrlSRWNkb555q5tG4ltCtqUvqYfDT2RVKHFH/96L87GTIUH9Wjful
         xLQY2R0Io+BPMg+L9CXJ9CJZDTlX7Z/AXoMllOIp2VPl4d6PApCHX00HVYCsAVSZpjnX
         TINWRiMOMcAZfJKGcawU9T3FVpNbNx16TJGxdi0yeFpqeWHKnhYnFqPBZQrJ3kAWyDjw
         2P5j0Zkom1iU84rGuYNPtAZQj1cdvCDy3HFIO80U+1SygRHAGsL7EPX6yO5oAKyWhC1z
         h6qw==
X-Forwarded-Encrypted: i=1; AJvYcCXjWC84/m3LdWEXmQ6ANxWp8tuJenFJ6lFDJFtIbE/7DHt6XSpfRe6wMuEBQtJkyivtoWksHylna7RA6Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IoR5foh6dQkuCbTfMLS5ICsLcrWZ57jUN6Ut2j1iL6BPcKF0
	XIqAPav3avrZ1aCuflZN4SzNf9hQZJzDCaWK6wysHXV9kHrhhyq+jrfjLcyjQTQZCYI=
X-Gm-Gg: ASbGncvCI6eyb8Fmuhmf3pq/0I0ufeS7hTMyn/EzlLRnmFZygPq3Z212/4nwsp+j2Pk
	WsbREKDzc14bV7ZajDjF3R8+IZuCda+N71jSSXVwT5WhK9NbdetGaBe4TxgQo2cmXGhz1zaTHQy
	G4Xo3K5jPIaBkt9dE2rYytMeyViITewMrcN/GmsvjFORBSIOtEd6FBr5ld/fFF9kXpxjLLM5663
	118SJ2HoJezVv9XDxZHRtvp18QQwB7zTL+aDNoSec62Lguu1GEsgGg5VRmQBiWtijAsKBpZRJ4f
	6A2IMP+EUf5vRkApamCbvI+EF2lyOkAPMQSiz2hPdUIENHYvOPTxiLG5qzASxghtAboaHmpix3Q
	ZCzyvWvzOYIB4zzsz7kMA2Ep+NITxqrmPvIs1407EBiQmJCwU7CZp
X-Google-Smtp-Source: AGHT+IGbH2JFwBLPGaLraTVu5QEVZak5Rl1cRsioev8MLGku57cqKjJrgA7FyxKjd1yCd7BcoUWJxg==
X-Received: by 2002:a17:907:894b:b0:ae3:90cc:37b3 with SMTP id a640c23a62f3a-ae9cddddbd9mr695822266b.17.1752758909512;
        Thu, 17 Jul 2025 06:28:29 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611d06bafb0sm9850766a12.21.2025.07.17.06.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:28:28 -0700 (PDT)
Date: Thu, 17 Jul 2025 15:28:27 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
Message-ID: <ammabsnegvc5m5qdj3xmydq3vhzw5igiy4fofpzyyzcwz5y7ib@rgbbbvxfxrf3>
References: <6874b1d8.a70a0220.3b380f.0051.GAE@google.com>
 <2b10ba94-7113-4b27-80bb-fd4ef7508fda@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zd2szp6eksrzw5d6"
Content-Disposition: inline
In-Reply-To: <2b10ba94-7113-4b27-80bb-fd4ef7508fda@gmail.com>


--zd2szp6eksrzw5d6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
MIME-Version: 1.0

Thanks for looking into this JP.
You seem to tracked down the cause with uncleaned rstat, beware that the
approach in the patch would leave reference imbalance after
init_and_link_css() though.

Michal

--zd2szp6eksrzw5d6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaHj6eQAKCRB+PQLnlNv4
CKckAP4t2sTel5NAIcoMDkPLhVj1Xa02VVfnsF7RBxyxnK9dsQEAnyOuSjGR3Zgq
rB+TQqoGgTO4G5NzZzpXEZxBkKWGdA8=
=HKJL
-----END PGP SIGNATURE-----

--zd2szp6eksrzw5d6--

