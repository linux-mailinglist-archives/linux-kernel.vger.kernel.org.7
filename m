Return-Path: <linux-kernel+bounces-786800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C4FB36B99
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9CE9864AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9929B3570C0;
	Tue, 26 Aug 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="annMvEk9"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F44350D4D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218320; cv=none; b=EG41riDXsKVEFEaSO3vHZ3pwCSe1mxsOXVNOd4139oeqwX1SD8gEr+X/f3IschorfUiKcBiSqx+gCCTxOK+IyrTQgzZPFrpi6TV0ekcWec5k2ErmrJpq7oNYI9Yb8jiTyqZl3/YDLTUJO+1rWw1AtJyJHjTypaz4fCYvmo3DYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218320; c=relaxed/simple;
	bh=TCJ8NPvTP7ps3f62uSRNkK10ZrwR7fQVXrD9FQiGDP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlKTXKJq8LYbsrhTV7mRSoLUwrNJGUzUw+tMezO9oyedu8KCVpre3vSCIvZQ8mUEVda3DWkRwVN4ieKaxlPsKottLwgGCZ84Oa1rqHBgpswKkVRvq25LpCmZMRt+5qpx5cqxhw/0vz/hquyO25BiX/FlL2yIf5+tH3tN9Asxb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=annMvEk9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c73d3ebff0so1224853f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756218317; x=1756823117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=praZGcG+svmhEwcOoZkoGr6SneBmB8gN1Y505qdv3M4=;
        b=annMvEk92BZUbClS8F7IBk9qNzanbvcwcJHJ2QM3bC5vit73hXaJ2pOpmaOsHb8WeJ
         l2ob31j8RrNDuO2+YfB0pPs+74+mRyaf/AMAXZzdApQqgTbCyVn9uzDTql4ocmrxQ5HN
         SSYDlqxp139oIk0DCw/NJuu4xoPCd/S+EyLm3RThuEhrCnvGyCnd1xPF0Ny25z1goZSg
         BhVC6hnoF32Rm5+EptmtE9N9F2xsugsTtDjI32/xz2EfnX20z9ko6Ll5rfB09iuQuIHi
         GjN/dRsh1WiRnHKLBQea39K7qWiXDtSGGNgU4cvRI6a+vk5iZi8Mby6Ss2iDPGg4/gvm
         guOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756218317; x=1756823117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=praZGcG+svmhEwcOoZkoGr6SneBmB8gN1Y505qdv3M4=;
        b=DBXtAD/oOym6PM2dezchAHf3Qk1TppAdFD8gBramFuUaFbN4fFfsP38cCspGweZWut
         axrWcVIdS4FRT2W4rIyqDJJ/KJze0IT7y/VsbObAfYSexOraOVAsKILQsTg/YEUwMc5R
         Jws2LbEpGR/MhYdKg16wOazPDkriqFHDIWxQizVyd+T0ABtbMxBX5XHm8Wj8u9dWLgte
         xdwuVNX7nSV8sW082BxOmPXCESqeasUwkvShbCWgIATcc9ousSRjVYbUFUyDn8TFjo6a
         n2iRA7bZLYdL9NYjuqBg4Erp2IH4qDrN2kxEjesd2CbHLGMPp59s87leziDOFs+p5krA
         8TLw==
X-Forwarded-Encrypted: i=1; AJvYcCX8BD7EpSV0Gn+8fMWf7Iq1xsYFbSMXzJXDDwtvICwKCXIlyx5KTwr4MBC1C4lUFJGYPY7qUgBDAvK81yE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Sa8eJc4b5mgBbbnI3uvfE7QZf0FrzFJG0Xcf/vu4PPHhKkcW
	CSIjoNXU+6vs9FSNkjAC0buf7dqTbsHuacqJBcYQkVw9XC6J8QgxDLRC4E4Pe272mF8=
X-Gm-Gg: ASbGnctLqNDbgHpI88dGAaIjrBnn8QCIFbuP4K1EW7OzBMpqfgv3qsSCTzPFSDIhu8k
	MitoYb8SU88qmfR1RNV62jSlBmLtHuNFn2Wg+6YoabmQGL7GpyON4rYzASCQD8NEe+5pIvi+Tmg
	fwZuTTwiXfuik4jYHHVmgUwZPVC3H7Oy/AE/pFmB74FN6i3+DgRfFt769Z3u3xhD6oD4zsQHdLh
	Or2CECPj89pVVQD/xvdDEwicqqo8F0rnu2IUYqT05Z8K2OTaORXHGlBYOIo9UQwEB5EGdz5v/9d
	ZYhTeaZloWmXCVqUwMMlgymb3nQaxvgWkyH2oJH2n0KOnD+DK46YRCwA1Q5hZ7Oc8yvplugPq5z
	MjfqA1jkVEU3y7E8zdCo4YNQwNjQ9Yi7xzCLYoEZEOvI=
X-Google-Smtp-Source: AGHT+IGiyPC1ji27qPD6oBh6HqY5oEKAa8jDCI4Wp7Eb/P+7XPuJ/OsjkI/jDyAdj8E7LPD4BQscwQ==
X-Received: by 2002:a05:6000:24c6:b0:3b9:14f2:7edf with SMTP id ffacd0b85a97d-3cbb15c9fd1mr1421867f8f.1.1756218317198;
        Tue, 26 Aug 2025 07:25:17 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877c0aasm98187355ad.15.2025.08.26.07.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:25:16 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:25:03 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>, 
	Chen Ridong <chenridong@huaweicloud.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v3] sched/core: Skip user_cpus_ptr masking if no online
 CPU left
Message-ID: <nqes55hiydw37qpt5mrqwzyhan5nxlzvuoccei4hmjloccr5xr@aqkuqerfwomc>
References: <20250718164143.31338-1-longman@redhat.com>
 <20250718164857.31963-1-longman@redhat.com>
 <2vpxlzo6kruo23ljelerqkofybovtrxalinbz56wgpek6j47et@om6jyuyqecog>
 <9bd275be-45df-47f3-9be3-f7e1458815a4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2qm6lhw4n6animmp"
Content-Disposition: inline
In-Reply-To: <9bd275be-45df-47f3-9be3-f7e1458815a4@redhat.com>


--2qm6lhw4n6animmp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] sched/core: Skip user_cpus_ptr masking if no online
 CPU left
MIME-Version: 1.0

Hi.

I had a look after a while (thanks for reminders Ridong).

On Mon, Jul 21, 2025 at 11:28:15AM -0400, Waiman Long <llong@redhat.com> wr=
ote:
> This corner case as specified in Chen Ridong's patch only happens with a
> cpuset v1 environment, but it is still the case that the default cpu
> affinity of the root cgroup (with or without CONFIG_CGROUPS) will include
> offline CPUs, if present.

IIUC, the generic sched_setaffinity(2) is ready for that, simply
returning an EINVAL.

> So it still make senses to skip the sched_setaffinity() setting if
> there is no online CPU left, though it will be much harder to have
> such a condition without using cpuset v1.

That sounds like there'd be no issue without cpuset v1 and the source of
the warning has quite a telling comment:=20

	 * fail.  TODO: have a better way to handle failure here
	 */
	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));

The trouble is that this is from cpuset_attach() (cgroup_subsys.attach)
where no errors are expected. So I'd say the place for the check should
be earlier in cpuset_can_attach() [1]. I'm not sure if that's universally
immune against cpu offlining but it'd be sufficient for the reported
sequential offlining.

HTH,
Michal

[1] Although the error propagates, it ends up without recovery in
remove_tasks_in_empty_cpuset() "only" as an error message. But that's
likely all what can be done in this workfn context -- it's better than
silently skipping the migration as consequence of this patch.

--2qm6lhw4n6animmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaK3DvRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ag9xAD/ZbEZKa9lcu5wS6kW+R91
XbafykmOnnjnsp0X/EvwukgBAIV3luX5EnleVFAMs3vNtlFMg4az0uOkkxBk2DI3
0CEE
=W2tu
-----END PGP SIGNATURE-----

--2qm6lhw4n6animmp--

