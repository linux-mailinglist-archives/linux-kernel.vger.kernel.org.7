Return-Path: <linux-kernel+bounces-749214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 889EEB14B84
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF660188A537
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEBF2882B4;
	Tue, 29 Jul 2025 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cxiBp5yc"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57572877F9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782157; cv=none; b=nLaU/fdlKNTl7VtZlRmQ+jGvMhhynSjGDAFy5G2MiN3uihGnFwI9enjacSQ7sC9ZrnHog/eXcBqVToqcs7ztE+z9ja4g6NkYHizezOlMhfqfi6GY8xLjjDNJLlA13tiLS+CahLju8GVIWZS/+wa1blKHXjCO5Hboj2r0JInWnW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782157; c=relaxed/simple;
	bh=qt58Gnd/lzcr1Ku8NCqo7aCR8cm6ZUzHGC/tvVv9LuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYkzcrx21BEhVYXvPYzm3arHCk4d+TMbOIWDUKjFbAYK2Tt519j+JfiPkBs975WU1nlKz62RF0lLnD8Rwy3WAEa+m5ox0ZCQW1p9pzia5NC5np++VFy3lhS9q8504mUp7gPYaWym3ti5rukoMB24cnjX+q0Wt5b3IGCWEqHrYzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cxiBp5yc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-454f428038eso46523815e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753782153; x=1754386953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ef5rgY2lnt4OvcvoVg9/XVQwH6qXB6/1hQPiF6E+H4=;
        b=cxiBp5ycthmtNXiDAHXWr08AXMTXNGnBTJ5hVu18xDKcA2bskvXWQDC28uc0IG3f4e
         j0pWxNOmu2VqDE/WJsUc5eAIASvyjYFySoSDZsU332c5mdotNPT0cGfm73DQfh3WGCjs
         T7YpaWBWim3TEn9mEXQFIJ/4JBkPZbsKoMfc2oJkTm3/XOCbjF+Fiwy0oONrc/3iWW3J
         pdjCxyOyToPRCE9NUI4yMfPmE6viRqvjFzc+Iv0PHfwlKg8HIX89ju0WeA9ar7X9YXfG
         nU3/UCgf815scX8085W+FqrFVA6S29ofaRruBGTlsWeFosSyqXv6hxOV/klLFQi4a67q
         TPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753782153; x=1754386953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ef5rgY2lnt4OvcvoVg9/XVQwH6qXB6/1hQPiF6E+H4=;
        b=I2uyiiR7Miv8/IWARqEMkx9aIhbJViACmsA6Kel5rW905aDKsVVhEJB+5eGn4r2QXm
         MMck+hAEeng0McgsFaQSMkP+Qr2FAHqBkgRsKSYjG/ePf3+fZJbgfcKtd3tO+N9YvnUB
         mr/MmtY86LOnIcQomXLyK8M4NUhDLbax+u7zhrBuE/STfVFiAVUMxXYtHhDH9OAsRyIk
         XljP8sLRd9LV1U6XWYiTwuecy3+pIqFInPiAnXfB/6drMaPu1/SksrdxiHXwJpwdP4np
         Y22YpV34chf492PSVMz0F3OeYCMqxEzmnqYgq0WVj+9nD05jlQWqePTVD/dBcKzc7HUW
         kCpg==
X-Forwarded-Encrypted: i=1; AJvYcCWC9YwwRJ3nyhVr3+ipUzouvdv7CsnpQsV41oywB0XdX8SvGQu3TYGHQFW8c+D7MidmpLJ2zYFkoNJl/0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoG+BaSa7ueG3+9414Q9JAthNzqgmtEWth5FUng6RqZVmC0hAz
	rWiS2DC1e8kOr7J9qKlwiz0X0Fvwmbyg3MXjCNtQIE8tm39rOeWZ1JyXxPJyBQJCfpk=
X-Gm-Gg: ASbGncv9Mc7kNKu4o2H9Z+TUOMHC3Wcab7R+awC7D98YUhok4XkxGhhDb5k5SoEnjgF
	y30rmaVcJ0HOevdSXwdQmo0coMhef1MI9mNAlUxCJWDVywMogUW6Lvfo0ZN9MmMajq38BWjl5lC
	bYidSA5Mbe7p/Nmmsf7uGjDPP3uBBp2Gu0ziXO1USq4jqyoeKNKMXTBD5Hk9FLwMY4BbxTNVduB
	KeiJSpO2OLKZYMA8MmHUTnNUGprmdzWAwLpnysua9+9fXXYTqduI2pGyKm8xrWXiLsh3xiZsebI
	4r6D9tNsDEIHarcHEXZ7+10yrzpZ1O51iUrf7aEK1TuyIZgNfRPIY1RImV+x4InFq2O9Gbgmayo
	UlNYb8EQyJ5q6Q+NdYRooVA/k1AAsa0TG2SUP9CgwyA==
X-Google-Smtp-Source: AGHT+IEg3FocgRMXUTosfo8Ye9Llf6PkHfOrGNXyUlE+u8EhOKaN0vlka4uim4KCJebnGYemr/ns7Q==
X-Received: by 2002:a05:600c:1992:b0:455:fc16:9ed8 with SMTP id 5b1f17b1804b1-45876651bfamr145394865e9.30.1753782153141;
        Tue, 29 Jul 2025 02:42:33 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705bcb96sm196404755e9.21.2025.07.29.02.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:42:32 -0700 (PDT)
Date: Tue, 29 Jul 2025 11:42:30 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/5 cgroup/for-6.16-fixes] harden css_create() for safe
 placement of call to css_rstat_init()
Message-ID: <lvfxjlx6gok6lhwvf2h3reiizfztjfsyuspa7avzog6fbuozsq@bqpqe5g4fj5j>
References: <20250722014030.297537-1-inwardvessel@gmail.com>
 <cughucmlrkwe3unwwmtx3yrqyrqwsedrbh2ck5feqs6cr36j3z@fhrnw6nfnyte>
 <e8156c36-48f3-4983-8a2e-5a5a4444a473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yc5dur3zyh2gvpsd"
Content-Disposition: inline
In-Reply-To: <e8156c36-48f3-4983-8a2e-5a5a4444a473@gmail.com>


--yc5dur3zyh2gvpsd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/5 cgroup/for-6.16-fixes] harden css_create() for safe
 placement of call to css_rstat_init()
MIME-Version: 1.0

On Mon, Jul 28, 2025 at 11:04:56AM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
> I did consider adding an "initialized" flag to the css but since there can
> be multiple css's per
> cgroup it felt like it would be adding overhead. So I went the path of
> getting the call
> sequence right. I'm open to feedback on this, though.

An implicit flag that builds upon the assumption that css_rstat_init()
must only succeed after it allocates ->rstat_cpu (didn't check gotchas
of this approach with !CONFIG_SMP)

--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -488,6 +488,10 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
        if (!css_uses_rstat(css))
                return;

+       /* Incomplete css whose css_rstat_init failed */
+       if (!css->rstat_cpu)
+               return;
+
        css_rstat_flush(css);

        /* sanity check */

--yc5dur3zyh2gvpsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaIiXhAAKCRB+PQLnlNv4
CLYZAQCNoqPVQ+80PlkqExKestU8doSIpaQsFTe+9sM3bMirGgEAlP9HHPLTU5lU
ooXDiqP+bfhMUnoLW5mj85Pa0BKKNAY=
=QcPV
-----END PGP SIGNATURE-----

--yc5dur3zyh2gvpsd--

