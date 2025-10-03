Return-Path: <linux-kernel+bounces-841362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B21BB7193
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E74104ECC18
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AB21F0E26;
	Fri,  3 Oct 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JqEbhZga"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4637E156F20
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500029; cv=none; b=oeMo7qPZqheoB/5BB7btTdDBsvaPRfaXHaEkr9xoqCmets9XAKG59bJ4QqpeosSbXDn+YWU5zsnddWzErvw9UW0LT15EHZE5q6BkXDaVpQyePF3B9BjoV8pu7T4Z637H9akrDgf9fXWHFrHTzTot7qLfSCvMaO7bea9/pcy4MV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500029; c=relaxed/simple;
	bh=LE11OXTwtyH7n2SYHTG2RJk02Tg+uqHJe5QPkn3biIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VS8Hp2cR8T+E2fLoVMO4/am2f7faa97h98SfIVxzJgLHZIaGhEg0PHDrBMJJL3I/EtUMgQ1J871Wn539awUhiBxdRRslGQmnpowoTA5OF4UkORi1+2DFofPySwePJwo10xY8JSnF1BuII/D877DOqZVVEP/85YSLammao1QirIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JqEbhZga; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so2024203f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759500025; x=1760104825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1I+/2p2JdPvoE9EVgO8OhJv/XxdkIcGTKg91hG0OSE=;
        b=JqEbhZgaQdygIuNVhqlUubpuMSsycDexi+Avoe3jInfl6GTCwHircYlpTOIcnJHrAI
         XjM3HVXiVc5zgVkKA/wrGBCTUXQ5kEMYgP4eYBHoyQAEvrNTCJxlBkpA5T8Zk4gzGq4p
         CXGqIAdTGQm4d0IwR7DTPqqp7Ar5CH5KiXLNsoE5TsOoCfSr8hXOQlInK13VblH+y652
         R500OY4/9oXu5LRyHwPvtJ1XAD2qZAEAi2NkO4TrbiW03ghSiXwGdY+quZuNml/ztfXY
         WJwZvGq/tx0VuzB6NTiol2pbTbitGb53B3KfUg4HvIx+gFbhd5+nBjbwQZV1TVPFmUA+
         iakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759500025; x=1760104825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1I+/2p2JdPvoE9EVgO8OhJv/XxdkIcGTKg91hG0OSE=;
        b=OCJirsBaJ8c07S3snIBuS9n7kSFHgLltmNhpIcna3pfnLu5Pv+8x1RDmhgKd2IF9I+
         I8KP0xIDgrv+jzfLFbMjQWIj9dm3wTmWMkFVT5s/ErWV+mJZUHH6YY6ki14jSoUxtT7y
         FbMQSLq8NbTWTM9jSYUwT9RVlszNlCAAVGPdjxKxVQvcthaHS8+pHrPs9jXE+lk+k2d5
         dum5tzQqxojFMJDNS6Ji1WLrd6borlBkytGuQSSa0RyZ342N3U7a7iV6fOisezPKmlQb
         5PWQG8grFujWgCjeFUdUCZaOWn5RnGxtEbxa/soogyIQSRohKaG58nWdpq3GYNcqp1SN
         WRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSg3C3Ea0oqHI1iVwJqs7KDGkHO2YcUg78x58rqz17pDYT6L/E1hni7869QxeuxP2rr03QD03B5A9zH0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIuXsL9GNtap9OeL+O4dUranxEpwzj40J5rl6qQbMzFMoA8GEH
	y9VDDArL4k/S1YPOIN9s2Is1H1qHiqLcWrRAwBXqCo+4EMYoPklkSa++Jw6rXjS8xpY=
X-Gm-Gg: ASbGncu8EyWaDG+cWhJdZHCbHIxjuWKjQ/fDGdw/G3gxVBojmNP5i61eCYa2L4xgQTU
	vw/pZyT2+G3nUzJWirQC0P76aigdC6W2jJEDe/8A4O9e6sfQXAeEeHsPpgmN8Dtx6z2eQqKOXI8
	WNWhtGhGR4nEcFHYOPpjm9QT2frmDA1w0Dg5blltb4y+9/3flqMzvEkMHooinX8I81n0DDD5UwC
	oRofHddOeq7lexcTVGh/n7VN+3xdRDt4buMM/4lNTdtu7XOCWaVAWN0w2gCUAI+wY/+nTg4QEl7
	UBXlT637JwkaLk2SobRC7WX4/f3d7QKKNHZFfb2WEP1kHXhDwuAT5vpOdyqvbTIZ+g69SsLe4kf
	mSgNkER8j90WaTr5LyNnbdDZN2zP96nrX1h8G9fg35w5mzLP/F0FTK7xYCY+K1ggvOpo=
X-Google-Smtp-Source: AGHT+IGxLyC2md5Jx51m9HM2p3j5fCUCQApXbhQWufGaXIfDffbKLaJKFwko+zfFqgwUdARWXwlQ8Q==
X-Received: by 2002:a05:6000:25c6:b0:3f5:d7c0:8e20 with SMTP id ffacd0b85a97d-425671c53f0mr2152207f8f.59.1759500025479;
        Fri, 03 Oct 2025 07:00:25 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723431f5sm31917445e9.2.2025.10.03.07.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:00:24 -0700 (PDT)
Date: Fri, 3 Oct 2025 16:00:22 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tiffany Yang <ynaffit@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
Message-ID: <nbtofen2pwqmp7r5odbyc4en6vv54rpznyaanxlb6tbx5yyg25@jx2re5hdmt5e>
References: <20251003114555.413804-1-nirbhay.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="twwjz6pyzgqr4kbn"
Content-Disposition: inline
In-Reply-To: <20251003114555.413804-1-nirbhay.lkd@gmail.com>


--twwjz6pyzgqr4kbn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
MIME-Version: 1.0

On Fri, Oct 03, 2025 at 05:15:55PM +0530, Nirbhay Sharma <nirbhay.lkd@gmail=
=2Ecom> wrote:
> The commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> introduced a seqcount to track freeze timing but initialized it as a
> plain seqcount_t using seqcount_init().
>=20
> However, the write-side critical section in cgroup_do_freeze() holds
> the css_set_lock spinlock while calling write_seqcount_begin(). On
> PREEMPT_RT kernels, spinlocks do not disable preemption, causing the
> lockdep assertion for a plain seqcount_t, which checks for preemption
> being disabled, to fail.
>=20
> This triggers the following warning:
>   WARNING: CPU: 0 PID: 9692 at include/linux/seqlock.h:221
>=20
> Fix this by changing the type to seqcount_spinlock_t and initializing
> it with seqcount_spinlock_init() to associate css_set_lock with the
> seqcount. This allows lockdep to correctly validate that the spinlock
> is held during write operations, resolving the assertion failure on all
> kernel configurations.
>=20
> Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D27a2519eb4dad86d0156
> Fixes: afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>

Link: https://lore.kernel.org/r/20251002165510.KtY3IT--@linutronix.de/

Yes, this is what was discussed yesterday. Thanks.

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--twwjz6pyzgqr4kbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaN/W9BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgskQD/VZYTSgJV8TksM06o+G+A
UVtyHkxTmx7U6OUOjRKT7lEA/i5BQk7/GJc2WflFnRYc7WUQqlTYbotjwBZ2vWgK
dSMB
=4Bm5
-----END PGP SIGNATURE-----

--twwjz6pyzgqr4kbn--

