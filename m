Return-Path: <linux-kernel+bounces-659436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B8FAC1048
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 17:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A590B500E79
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF30299A9D;
	Thu, 22 May 2025 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="W8ucw8tM"
Received: from mail117.out.titan.email (mail117.out.titan.email [107.21.18.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736428A402
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.21.18.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929006; cv=none; b=kY0SWRV9SopOgVvEO70m3t762S73+d6Knja9L2LGSCsIr/VDBSk214BjOqTRWocUA5slWD39LmnIshoPHMCdJ2slvoEYg27Lxkee9oI/Gk2A5g9Z75XP+LVgm5Hm4nEsIW9VYRF6uXPyozwxA/3X0yO8AnPsmwVCoF6SkjvhiVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929006; c=relaxed/simple;
	bh=Q0PYmNdAm+3Qf4fqBIwBC7PH0E4dHRftuI+OgdY3lXM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VRUp/cSZKEfp1aBCp2fdC2IW2Ak9I2YvVWKJ0d5lT6PxMIJWcffLk8Sz4lWIvSLOupAUNYosSubKjAhffNgZEMRYZN5JQuusYPUGaeVsBQDOzlxZAXZuynaLJ5LnRo1kztxbqJMTxHAMo4rfbEJwFeOyouDUzGUTpdtoArtIQP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=W8ucw8tM; arc=none smtp.client-ip=107.21.18.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id D1F65E0015;
	Thu, 22 May 2025 15:14:27 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=taO0LrTM+GjJ2q8d/yfaS+WGBoxT48m7W5053bW9Haw=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=message-id:subject:from:in-reply-to:cc:date:mime-version:references:to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1747926867; v=1;
	b=W8ucw8tMezn3KIC4AFxXK1J6IzhuvZBneSaYRQmF7H49EF1xj6Vyjq/pTeUhLKtkG0KOOv/J
	neFKoI1pJk5KbvpApEKtvNaBm/AqDNSXodeuZFiGCy9Hq0Zn6gRXAA+U+hRXpg5mMrt80j+TPJa
	IIjy5ka6U6tuKVr75SFVsxSY=
Received: from smtpclient.apple (n218103205009.netvigator.com [218.103.205.9])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id A39EAE006A;
	Thu, 22 May 2025 15:14:24 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: riscv gcc-13 allyesconfig error the frame size of 2064 bytes is
 larger than 2048 bytes [-Werror=frame-larger-than=]
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
In-Reply-To: <CA+G9fYv08Rbg4f8ZyoZC9qseKdRygy8y86qFvts5D=BoJg888g@mail.gmail.com>
Date: Thu, 22 May 2025 23:14:11 +0800
Cc: open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>,
 kent.overstreet@linux.dev,
 Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 linux-bcachefs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <36D1F736-7E76-47F6-9E26-0E8E8F4E9B44@coly.li>
References: <CA+G9fYv08Rbg4f8ZyoZC9qseKdRygy8y86qFvts5D=BoJg888g@mail.gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1747926867682161361.26132.8009154321890797791@prod-use1-smtp-out1004.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=U8BoDfru c=1 sm=1 tr=0 ts=682f3f53
	a=eJNHGpZBYRW47XJYT+WeIA==:117 a=eJNHGpZBYRW47XJYT+WeIA==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=Oh2cFVv5AAAA:8 a=KKAkSRfTAAAA:8
	a=21D8NHQQAAAA:8 a=VwQbUJbxAAAA:8 a=uOdo12Paqm2KlJZ413YA:9
	a=QEXdDO2ut3YA:10 a=7KeoIwV6GZqOttXkcoxL:22 a=cvBusfyB2V15izCimMoJ:22
	a=aE7_2WBlPvBBVsBbSUWX:22

Hi Naresh,

Bcachefs has its own mailing list linux-bcachefs@vger.kernel.org =
<mailto:linux-bcachefs@vger.kernel.org>, here I Cc this email to =
bcachefs mailing list.

Thanks.

Coly Li

> 2025=E5=B9=B45=E6=9C=8822=E6=97=A5 21:29=EF=BC=8CNaresh Kamboju =
<naresh.kamboju@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Regressions on riscv allyesconfig build failed with gcc-13 on the =
Linux next
> tag next-20250516 and next-20250522.
>=20
> First seen on the next-20250516
> Good: next-20250515
> Bad:  next-20250516
>=20
> Regressions found on riscv:
> - build/gcc-13-allyesconfig
>=20
> Regression Analysis:
> - New regression? Yes
> - Reproducible? Yes
>=20
> Build regression: riscv gcc-13 allyesconfig error the frame size of
> 2064 bytes is larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> ## Build log
> fs/bcachefs/data_update.c: In function =
'__bch2_data_update_index_update':
> fs/bcachefs/data_update.c:464:1: error: the frame size of 2064 bytes
> is larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
>  464 | }
>      | ^
> cc1: all warnings being treated as errors
>=20
>=20
> ## Source
> * Kernel version: 6.15.0-rc7
> * Git tree: =
https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.g=
it
> * Git sha: 460178e842c7a1e48a06df684c66eb5fd630bcf7
> * Git describe: next-20250522
>=20
> ## Build
> * Build log: =
https://qa-reports.linaro.org/api/testruns/28521854/log_file/
> * Build history:
> =
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250522/t=
estrun/28521854/suite/build/test/gcc-13-allyesconfig/history/
> * Build link: =
https://storage.tuxsuite.com/public/linaro/lkft/builds/2xRoAAw5dl69AvvHb8o=
Z3pL1SFx/
> * Kernel config:
> =
https://storage.tuxsuite.com/public/linaro/lkft/builds/2xRoAAw5dl69AvvHb8o=
Z3pL1SFx/config
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org
>=20


