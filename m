Return-Path: <linux-kernel+bounces-792225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A18B3C1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21E11C804E9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE82E3375AE;
	Fri, 29 Aug 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EhF7Aplf"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA3201033
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487840; cv=none; b=iqXzIDHIzUmeeVhC3lsSyaNQzXm4YAvGC7vje4/B/JBXeIOcjjTPOIKuvjv3DV5LlTjWyV4Oty3Fejd2mLKs9UmUH+v4WC8VzUeaTGF5AQOfo9QBEa2aJ7/sKMg4qEUFp4+ReY3J1Cr3aGcZzSwFtj61+nDyUrbzH1ZVLnYq50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487840; c=relaxed/simple;
	bh=IBtpyMyCDK1szOTv6hKPQ1XBcbyXLs/xB9Wy4H5DtS0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R61uQz97oU4CnlOPoNThUf57+SACaCirV+qj42Z9XFETcy3hjzdfXFXY8hez0bZfq1/LxPuqzrDb9NcrK/Vbev/3YqbipLK1gei7kDQrcHAQxXC+UzazMSaTYcdLRw1ElEuCOO1IUVcWdP7aEU8mO69cTQ+U+bbnIXprKX0DWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EhF7Aplf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D775C40E0185;
	Fri, 29 Aug 2025 17:17:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2uBgxehETMd4; Fri, 29 Aug 2025 17:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756487822; bh=25wZ+JH5mg8MQj9ElsXO9yrBDNK5dg8ZFEJmzubRlhs=;
	h=Date:From:To:Cc:Subject:From;
	b=EhF7Aplf5WBtuTdSiDZN1t8L3lS6eeS+L/A+prwlKw36GsgrlQ/LLi5tWhBjq93on
	 ndDQytjQFwUtDikpcmC0XAPhJWMA8qWdpZFsv8BVLtgMjgIKPS9JoSo6s4nbvGBQ6K
	 2cW8bhWn4HMnS0bVcLMCGwLh+znQquMxJ/bqC6mir/XrHDifbgzUj9bfl1T7xB7enZ
	 CoMIa8Sfns0HP203IaNszyqXInAHcjtZG1jEMlgTgW1+CuqcANftPLe9ZzmcMWDb8K
	 MCoJx86VyGdVumAONbofH/nn80s+ZfICiNhXOj0WEx9+vgMKL9C1OFG0Ffhx7zoX7j
	 ODQyB48qJlK8J4hvASUJNZf8FwM2Xbpu+Ob4wFrq2Li0cO2c58EkBUguoOcrYJi7rs
	 VEkWtQ0mJtul1KAq93QX7xJLl7/l0KmwRQ5cSy96nrKFCybGhwM23JnseXEU9HwE29
	 /va+VqaVcSxOg/TvGr9T1vCdwpPkcz7gaR2EdNSZlfCRZc2WO2KHGJx7y53/QhJ2+W
	 nrodQ1Usd40JFGSLZqwXjzlG60y5oCYxMsYLCAfgDQqH2mG10i2ti62kjyy6J6KRlm
	 ZZsLbO18WDt71P9hfImObmMnpWQGCBo99chH4npXvfzdZvG6z1Y13f0Lp8octTw9vb
	 AQNJUbfSfo7SAJZNI8MVKRnA=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4BB6440E0177;
	Fri, 29 Aug 2025 17:16:56 +0000 (UTC)
Date: Fri, 29 Aug 2025 19:16:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: evergreen_packet3_check:... radeon 0000:1d:00.0: vbo resource seems
 too big for the bo
Message-ID: <20250829171655.GBaLHgh3VOvuM1UfJg@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Heya folks,

this flood happens with plain 6.16 on my workstation - haven't done any hw
changes:

[   29.094609] evergreen_packet3_check: 115 callbacks suppressed
[   29.094615] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   29.106737] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   29.106740] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   29.106742] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   29.106745] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   29.106747] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   29.106750] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   29.106752] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   29.106754] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   29.106757] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   52.579786] evergreen_packet3_check: 29 callbacks suppressed
[   52.579792] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   52.591825] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   52.591829] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   52.591832] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   52.591835] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   52.591838] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   52.591840] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   52.591843] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   52.591846] radeon 0000:1d:00.0: vbo resource seems too big for the bo
[   52.591849] radeon 0000:1d:00.0: vbo resource seems too big for the bo

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

