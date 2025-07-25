Return-Path: <linux-kernel+bounces-746083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 674BCB122F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1114AB40282
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7392EF9D3;
	Fri, 25 Jul 2025 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W16ENCwE"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D52EF9BB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464228; cv=none; b=cuhQBh0m686OGnyLLuyUyOzZuDZ6lbvrJCI0ZYll8zDxwYhi59FzESTZVBHZDSXC9TPkavHCWP5QINYo2y064nD41onj/2RFASBI6bDry2834rbXcFoILCGed9WqrH91tFiG3+lX1k4WGvx4UCMH4hk3uqKSrOtyxiM5jdkC3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464228; c=relaxed/simple;
	bh=D5TZDlEPgBe6V0e0eEj/6itbBciZFTaEgNqYWePWGME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+sxV50GT4bltOP1XMskvDRhbs0kqP5F1doLNKBf0Llp2zuAy63DMQbCPCNi84IdPhhttBC993V5xdS7LdxZPgPIThYWiJ6klVl97sz8D4xWzYudztoqwxNRc8V2JjDxPn2MdvjFf5FIOHTc8VGAjGUO9/Va9vKbi/gzRbhT7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W16ENCwE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4560d176f97so27711165e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753464225; x=1754069025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5TZDlEPgBe6V0e0eEj/6itbBciZFTaEgNqYWePWGME=;
        b=W16ENCwEaiu/esmEZspSGHyErTKYHSCqJpiRSjyUCzQ87TiW17r4lfob+Npp9p+sRZ
         FJBFkn9PmL85y80Mg95ZTYOtwNsEACTzea4GuEWhtjmw91QVZ/wKhXd2XfeRm1VacRk+
         yMD4JZ+MhZ7NW7MzFQyV+1hLsDDEFq/GUhWOW4kFw8Yn4U32B08w+f7u39hx8uYUMKQ1
         qUB6hy9kH06CtpImh/BdRujcNpySJ15xmlX8Bxt0cJtP+NQcB1FejKFxU53XvbiebcJu
         3nwEUOEaHBFqPFRRNRTFNnllZX1ULNowhA1QsUAhry2ctyC67g2lr2Ma/uXmvhRMcsPI
         941w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753464225; x=1754069025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5TZDlEPgBe6V0e0eEj/6itbBciZFTaEgNqYWePWGME=;
        b=pdbq714L/3e/h/Skst5d/vT2aS/fnHbpunaTtCc/K1MsQQK56bE2pzAtGpTyvUEvRJ
         Lvhh9RuLhYHPNhDfyiJ6YJbXwTEg5G2rFkprsOIc+yfBnA0/FmeK1Ye9FVQekYjdJdTq
         C1AK914QKy9Kh50ovHPmoEX2GYdC4QtrV5a6MEXOB/Jg6h8FnwojGsIuji447YWpqgTo
         dypvgegprwECzk/Z7Q+f/PDnSJbjVQLrZaX2TTuwJfon8NhoS6tvuFvV1yWNliutd+8R
         pNdrEsZdoiJLwPvscDUqbwmS29O1YhE6KAhEWmJSHtAGhA1WF+8ReJbqql2Gtk6z4E31
         FQEA==
X-Forwarded-Encrypted: i=1; AJvYcCX0G0K5lwYPJIvuDvFpy9iU2+2GzAeUJJjCfiQcYEQmsw42x/l5jQX0RLLywAwlqRJxEya3+E9n8kOvw7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvkZjAD6eaEsGyy4d/CgIyNB8yQyFW83ctXxjGrJbkR4TLn91
	bwIPAMrNAs8cBxosAZD0NAUVQkrRB7tCaca0J4uFdVDJCSIp3kqOn31kNk/kwDt3T4Y=
X-Gm-Gg: ASbGncuSWfcFejtHfLN2ZZG4E2WaBcZma43vFvVotjReb76F2IvB3ovoN6IZRCswhqT
	Qrl2uVJBsk3DUYTkw4jvg4oTJv09qy+bXFGdZJvYkT2eLj7QtGB8QBFJBBZ8/kq931+/0NCVeU/
	K+9iXhZ1+b720kMu8+6YsZYginQQLqJ86AWGzrdIg79mFi7juoAsjm6FKwFcOwaI/7ZgT2yt55m
	7NznTa6g+TPgh8H/kXkooU3qS4Ri9o/hzS6JD060kU5sP3ztqaWWvVC5uGx/6fIrl1y5JG9etef
	PUCBX0zTYYso5o/VRDOgZ8gAvYBepctVCZ6JkIIASb6CHNzo7YLp29+2E/o+QUUNoNxW1JVzfAV
	iRFLjsy6LITm9bZo7j6TngF7ir9RMk5/AIgimDVaWoYkuTDlPrBUp
X-Google-Smtp-Source: AGHT+IEmETjJToaBC6uDXwn45zfx5BRKCJAgV+cWcV2CHkbcByMrQm++cVqhO4Nx+IJN1B1M5+SyhA==
X-Received: by 2002:a05:600c:4685:b0:456:2000:2f3c with SMTP id 5b1f17b1804b1-45876545782mr20723925e9.22.1753464225306;
        Fri, 25 Jul 2025 10:23:45 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac5816dsm3395325e9.17.2025.07.25.10.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:23:44 -0700 (PDT)
Date: Fri, 25 Jul 2025 19:23:43 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/5 cgroup/for-6.16-fixes] harden css_create() for safe
 placement of call to css_rstat_init()
Message-ID: <cughucmlrkwe3unwwmtx3yrqyrqwsedrbh2ck5feqs6cr36j3z@fhrnw6nfnyte>
References: <20250722014030.297537-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ferhfnh6pl64hcgw"
Content-Disposition: inline
In-Reply-To: <20250722014030.297537-1-inwardvessel@gmail.com>


--ferhfnh6pl64hcgw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/5 cgroup/for-6.16-fixes] harden css_create() for safe
 placement of call to css_rstat_init()
MIME-Version: 1.0

Hi.

On Mon, Jul 21, 2025 at 06:40:25PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
...

Thanks for the instructive summary!

> If any of the three goto jumps are taken, async cleanup will begin and
> css_rstat_exit() will be invoked. But since css_rstat_init() would not have
> succeeded, the warning will eventually be reached.

First thought is why not simply add a flag that'd guide whether
css_rstat_exit() has work to do.

This is meant as a fix, so it should have some metadata, I'd consider this one:
Fixes: 5da3bfa029d68 ("cgroup: use separate rstat trees for each subsystem")

(that's when css_rstat_init was moved to css_create)

and likely this
Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com

(Sorry for being such a bureaucrat.)

It's most appropriate in your 4/5 but do you think it'd be possible to
reshuffle the series to put the fix in front (to ease it for stable
kernels) and refactorings after?

Regards,
Michal

--ferhfnh6pl64hcgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaIO9nQAKCRB+PQLnlNv4
CK4WAQDqNVr7A6TCr81qqYBqMSBGWP+xWB1zDLSjL4f55lEG1gEA6bLsEr2M8OCO
GlMuACLcGlonmiDvvTfkQL1DInvd+Qk=
=Ync2
-----END PGP SIGNATURE-----

--ferhfnh6pl64hcgw--

