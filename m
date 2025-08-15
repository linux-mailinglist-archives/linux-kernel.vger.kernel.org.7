Return-Path: <linux-kernel+bounces-770890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 051FBB2800A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C4B7BB958
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452BF301023;
	Fri, 15 Aug 2025 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BktOj1Et"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA02741CD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755261258; cv=none; b=RWe6aubzWLMhwvnVCakGTcDbRM5lu3GsLlgtWXE5AVCLwl+FAU9E8gSLxAvoZXRsI4T4xT2M+zwcU+ZvdiNSgyHowKFS5dianbox6JV4ARb6XrdVEecIGHntMTVMJ2LnbnZ1S6UYdioJnYuZ88cGeTUc4cxHPV9lZdVmhgiutgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755261258; c=relaxed/simple;
	bh=2NPBJgIbug0Bh+0ak17HZ4aogx7N/v5utSxx0PGuCKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njkTx+Q1ZtMtpQRqujzjLEUT4nCCa98wLPb8b1CPAd0pqUInviK38x1ERw3OJZFfPSYtrgR0kgsjtDLV/3LairOjmVpexJGNjOyZO+/ANS+rsEz80Dzu7hf6nRQKxPvLPbpzhARXHdGwZSHkIdkkGKwWZIgDH7OgKyxoLYvyMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BktOj1Et; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9d41c1963so1068565f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755261254; x=1755866054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NPBJgIbug0Bh+0ak17HZ4aogx7N/v5utSxx0PGuCKs=;
        b=BktOj1Etftc/hzF6N+qUmNOfwsQvBMN0/m8i1mG1pq5xDUQQVMs02tCISPs/rCWs6S
         7UJTC7SWBT/slTELayNHsnPQ/w0dMRvislbFQ3t00+sTzf/jYLJ3Ofn1ySsfGbu7dY8b
         1GwF9GPmdW+yqZch7hoG7FaNuiN8qj0rXGqLknOCuHdVCspxzIwjZ/JAAPIf9HWxtOOI
         ZjhthdD49OtsPSLhpV90AE31+E5TjvKGR21C35KgElXWUCVKbIlcuJQaJAdzHhyG1TgW
         lAMCxYOyGs9Ei4N7lm+DdzDoJ2roBHhnOAa1hlkF33SVmaBS0rmNlqiJov+efQ64RFWX
         nWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755261254; x=1755866054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NPBJgIbug0Bh+0ak17HZ4aogx7N/v5utSxx0PGuCKs=;
        b=v0dH471W0b7nbl39UjSvmD2wl95mr+xk37ig6maMUBKwhAGDv5sYQw7flySdIHZYyc
         gJY2Q+QzQZwFPsoR6BgXR7MUQlLX9XtL2iyfIkrFXxhRDn5gZ2QrPcmhY8a7xkQpDE/5
         SKUUzixZoTt3B7RLyywqy5vnqQT3rMZTsHnFVY6/HSst/+oPNAkBQA6WzHwmomJNZaRK
         R5opH4eES824clvuyzJWH0GtMQRLSpdz8tMUJiekD+LAqeUAO6+RyjYsnqzmmnBW+KzR
         LpLJGfrlGxzrRLDfXI+qqm5+uWwGP7rzqk0v9t5uepF9Cta6FxwuKKWCi7Wz9+AGXwFZ
         k1Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU0uq4VuU359mshrUHthc+0n5Z+P7qT4sTwABrrSsYWfqZgS15yBKRD+5JaYzH1GaJaGSl6L6KWsrT8eA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLX49n7rigQi1PON86kifyIRyTcDmjTEW8InIOSwy4RjWoyZI9
	lIHqLlWy9cfsV2BQsaB++OHlzdHZvKhcDrvgjWb/GqomrxCIdQeFKQxYlGD4/Q6XPPA=
X-Gm-Gg: ASbGncutfz+OXvb2P0BE85/Kc1WHe1Jtc8M2TKYXZpSMesoIGW86PF115PKR7DMZqOU
	LZMcTOAyHwbfWDvOTt70w+kPrFMG9KvZ1qfFTVZWXC5X+7w2g7ItMG6VUK5BivMrYPYY7Wv93kD
	JSLMDQI4ITIhQMO82Xegaw0Ps0lUA/10l3CUT1GNYiDOroWsgAHOvgk2dzi/GVaAgBWX+mK1v+O
	90GMu6wufvuWaBNMk3QaQW1kKsL5DcE3aVyTWh7L15152oEMfo+dV3P0ZyqhQHMUZw3iiXh03fL
	A4VwSzjllZGQcaMgpgXRjJd6hXmYe9PlW8LaJE1EiCrctdp3MYDZXhYjIEgRRhjoU1wJRDy7V35
	r/LxlmMgf0XT/P6RD6csA6rirMoc1L0Mn1SLEPgZKuz+PILjdQVdk
X-Google-Smtp-Source: AGHT+IHOvaE7tZeHngdDROJ3VBbwyIHwQY//OcWQOpF4xFO/7x0xp2UXIVTyys/GbEi0VR5R6Dqu6Q==
X-Received: by 2002:a05:6000:1888:b0:3b7:99a8:bf6e with SMTP id ffacd0b85a97d-3bb694ae038mr1734547f8f.51.1755261253797;
        Fri, 15 Aug 2025 05:34:13 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5f4539sm1195356a12.14.2025.08.15.05.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 05:34:12 -0700 (PDT)
Date: Fri, 15 Aug 2025 14:34:03 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: lirongqing <lirongqing@baidu.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Remove redundant rcu_read_lock() in
 spin_lock_irq() section
Message-ID: <f64n5c6dkdjuaudk5p66mvpjyjulrjytmndqufmdu3uhft46sy@bem2gx34zhkz>
References: <20250815091430.8694-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lxgzoylpx6c2h6sk"
Content-Disposition: inline
In-Reply-To: <20250815091430.8694-1-lirongqing@baidu.com>


--lxgzoylpx6c2h6sk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup: Remove redundant rcu_read_lock() in
 spin_lock_irq() section
MIME-Version: 1.0

Hello RongQing.

On Fri, Aug 15, 2025 at 05:14:30PM +0800, lirongqing <lirongqing@baidu.com>=
 wrote:
> From: Li RongQing <lirongqing@baidu.com>
>=20
> Since spin_lock_irq() already disables preemption and task_css_set()
> is protected by css_set_lock, the rcu_read_lock() calls are unnecessary
> within the critical section. Remove them to simplify the code.
>=20
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

So there is some inconsistency betwen cgroup_migrate() and
cgroup_attach_task() (see also 674b745e22b3c ("cgroup: remove
rcu_read_lock()/rcu_read_unlock() in critical section of
spin_lock_irq()")) -- that'd warrant unification. Have you spotted other
instances of this?

The RCU lock is there not only because of task_css_set() but also for
while_each_thread(). I'd slightly prefer honoring the advice from Paul
[1] and keep a redundant rcu_read_lock() -- for more robustness to
reworks, I'm not convinced this simplification has othe visible
benefits.

Thanks,
Michal

[1] https://lore.kernel.org/all/20220107213612.GQ4202@paulmck-ThinkPad-P17-=
Gen-1/

--lxgzoylpx6c2h6sk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ8pHgAKCRB+PQLnlNv4
CLeEAQDhACSSxzfculiGEZg5K7CYSS8BDwlcU8+9yAxEJIfsLwEAmbKaApjfh0Ki
8I+wSutS8pxwWUO8EeeZ9jbous+NrQw=
=uUm4
-----END PGP SIGNATURE-----

--lxgzoylpx6c2h6sk--

