Return-Path: <linux-kernel+bounces-890128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2813AC3F48E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F364D4ECF71
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC602EBB84;
	Fri,  7 Nov 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D06raH48"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1032F5A3F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509479; cv=none; b=ELUB+JKKSwac1OmjpJWfWvBUOk90m1GtC0J19B6xzu3SWflYoypUonvhjHlmfnX6pehZpag/cMl/XxYfybPXuo9TmzgeOdfBWfrd3Hc4/nfv/GYuslO+AdSR7KueIhFA4BRrfMJVq6b+f3N8LF8Jb+l3lHMwczmsWDxs8o6iHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509479; c=relaxed/simple;
	bh=KQApMmeyeroojj1oOh/JwuYBVW4ykgOBnlMtNZQB+YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aixKh2BYUo6GMGwrHO4wceUBJDzuugYrHiD5O90rOf59zVPjL+mtF7xYzmW6cRmQiYrM3oxWEIcV5FR9orO5/lc+C0XFYax7kUXgbqXBAKK6ddLvtIh+dUjnazdmk/rfGpT8K2VWILFqnnJW6I9k+apEciKJb6UYJtDbP2Sh6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D06raH48; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee130237a8so335254f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762509476; x=1763114276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQApMmeyeroojj1oOh/JwuYBVW4ykgOBnlMtNZQB+YA=;
        b=D06raH48kP1ho67e3kOoT2LSpBXFcforv+fHeGj5MEwPYSXcDSNfUODM38z37QiRAN
         qSriMCIQLsNFPjrWgWV0RwkHEwLckKxnbmnA/OEW2gV1MN/jowT6RDaLfcxKBNCdh0Bk
         gbQYCLiq5lKs2NM0yXwDTiV/EUc4q6CiMoCio/AxqcIF+c0iIVGYi6xGG82Yu0L8ctWX
         FDBSjKE5fPjm0PUTvCBTXbX+Ss+KIWTZNHmbR8+rHiHXLa/NUAD3Z7RLPElRhoBbquGm
         VVCyCR21AMX2lxjJLgFN9267TudGZvBNt6gLpB7V6wFvmXKQ5WA5Ev9D0eK9o4SHUOdX
         m6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509476; x=1763114276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQApMmeyeroojj1oOh/JwuYBVW4ykgOBnlMtNZQB+YA=;
        b=xQIyuKFt0KbgesqR3w5JwA7IAgv1MGGHAtYCBiweDeEP4b2vSqWCax0gafxYfAL2WY
         paiMIQtGUFqkg6oaAwYdcZQDs6hxh2vs4BdzImpczoKJ3Y700Hpci78CcL+m0c6l1vI6
         mkC8P2FUD7Rw5ijw3gsKr46mZVh+zEWLovvcVzsyljKCJAKUkAFNMEaGhoKV0u28paxU
         cr2DGzhp2yf4b04AMasurkKEMHPelU9T6z/7JwTU8X60YjU5N155tX6reWkIskCwl6GE
         2jXVPPbccevWaHgzq7mgb6qCBpRlNKmrUo6Av/lwgndmWESzj2C7iNKoKcu9YIOAa0AU
         8EFA==
X-Forwarded-Encrypted: i=1; AJvYcCVfWLbEc+IjYnfjaHqawwJcTAH1f1qfzl0eP5MP54nIpZbYY5TjQMIp5wBaYkbzAGt2Xmb2fbt+yNJRRY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/Fvid1Q9+INcNitgtytDiDa5as8M3RbFI497QJ5JU1KsPDd2
	HG3yWyS6J6mDF1ZGhx/7ZOreU5tx3GixctuSWfC72ttT8Xmxa8Ql7zrqA3WdnQdKq/puHGQUQuX
	QdWhN
X-Gm-Gg: ASbGncsa1S0I1i0uUO+0RXOn+MPm6Wwhqii4J5yCm9nGDsdVx6ndneBZqL+KGdLhY0/
	FfkNv18hChc8Y3EAYFTRndI1/tJ2NllesNRHcmnfnB5RU4QCisWySUteDU5/ymh41FtQAR0eUgQ
	CYvFDSFD4hDnNTXdriE1kjqz3vSD2pnhgLVR3ThmtM15PjLv6Xc2nO05g5EX07lKP2+oZ2d5xQF
	uMA9LNNH8+vBdjYOey81gouYCUwZPWDwWRXf5cn9thlue3sJr3iHzW0iNPIjw1U801UrtkqF6Ye
	O4SibVMauZko42lyxw2CA7UG0IDxMXfQDJzv0znPt6ohLnUpyhVO8DYGkYX8K3BcqWTysMMnB0I
	ouarcIpJ67IaizdhAKmU3Iw2+huQNk8u7YFoYPhDS6aWsZlxwOWbtZZzFUjwvbIEjyoTbrnDChw
	1LCMYdudmZ1/fRPdPKMic8
X-Google-Smtp-Source: AGHT+IGYXYnlAsEjuk23F3IZ/BoFx5TsEGM0egBLAX1ErlqS5ss+2CzpuASNt4N0drqS+uWjT87dzA==
X-Received: by 2002:a05:6000:656:b0:429:bb40:eecd with SMTP id ffacd0b85a97d-42aefb43e0emr1979840f8f.52.1762509476103;
        Fri, 07 Nov 2025 01:57:56 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675ca3csm4397591f8f.23.2025.11.07.01.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:57:55 -0800 (PST)
Date: Fri, 7 Nov 2025 10:57:54 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH cgroup/for-6.18-fixes] cgroup: Skip showing PID 0 in
 cgroup.procs and cgroup.threads
Message-ID: <5r6yyuleoru7h6wcbdw673nlfzzbsc24sltmfg5hk2mj6a34xa@2xo7a3jhhkef>
References: <2016aece61b4da7ad86c6eca2dbcfd16@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xbm34c74aqa2td24"
Content-Disposition: inline
In-Reply-To: <2016aece61b4da7ad86c6eca2dbcfd16@kernel.org>


--xbm34c74aqa2td24
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH cgroup/for-6.18-fixes] cgroup: Skip showing PID 0 in
 cgroup.procs and cgroup.threads
MIME-Version: 1.0

Hello.

On Thu, Nov 06, 2025 at 12:07:45PM -1000, Tejun Heo <tj@kernel.org> wrote:
> css_task_iter_next() pins and returns a task, but the task can do whatever
> between that and cgroup_procs_show() being called, including dying and
> losing its PID. When that happens, task_pid_vnr() returns 0.

task_pid_vnr() would return 0 also when the process is not from reader's
pidns (IMO more common than the transitional effect).

> Showing "0" in cgroup.procs or cgroup.threads is confusing and can lead to
> surprising outcomes. For example, if a user tries to kill PID 0, it kills
> all processes in the current process group.

It's still info about present processes.

>=20
> Skip entries with PID 0 by returning SEQ_SKIP.

It's likely OK to skip for these exiting tasks but with the external pidns =
tasks
in mind, reading cgroup.procs now may give false impression of an empty
cgroup.

Where does the 0 from of the exiting come from? (Could it be
distinguished from foreign pidns?)

Thanks,
Michal

--xbm34c74aqa2td24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaQ3CkBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiL5AD9H1iQzx9lGKNZBRyzM1W5
RyQlf1K/qfz8QEBX+SwBuXMBAM2seBFyUe3eN6EcRsWiedVguCDdbBxoEEDM8d5T
m+0G
=NBTZ
-----END PGP SIGNATURE-----

--xbm34c74aqa2td24--

