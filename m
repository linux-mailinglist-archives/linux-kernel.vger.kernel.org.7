Return-Path: <linux-kernel+bounces-796198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B53B3FD39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D114851CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B160E220F5E;
	Tue,  2 Sep 2025 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMFwX3Wj"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FBA286408
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810705; cv=none; b=HGIll4mQUH5CiJ5APFN2ph24x4bxcZnwvcirvt0eZ6cdhC8Fz0Fu3JmhUUz9ueN14AvvRv6BqJoy+/V1410b/D2zyGETWeVIegHQArDGxPQexY/pPdpHWRYAGA8hZc7vBSJEeh1pLlHDmKAUQ74Ud2RgN2rZzZtRw0QYqcEIdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810705; c=relaxed/simple;
	bh=gfMxdtz4DcDDUc86U5Qw8d4o1LVk/9GYcubnw19a7Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RU3+VYnLQWDWanMpmXWYnCxa0UQHfts/On1ufmWvnmdsfmyI0E077k1Vs8dBYpt2Yy77gItUpinfLHpDpl4t7FFbjX5qEE1NP9Fmz9QxBS6/pEY/0J3tA7vNI/m+jk0N9Zs0LyL+Alt2p3wQtuXBXBi3y+BVblACxVzH1zU3reE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMFwX3Wj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32b4c6a2a98so40581a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756810704; x=1757415504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfMxdtz4DcDDUc86U5Qw8d4o1LVk/9GYcubnw19a7Vo=;
        b=mMFwX3Wj5nuAkDJpkoo40mdQDRAA3EUCEa6bHkBR6aVdYFy3ZRUXmVETVTf0QZrDtk
         boc6fDVm+XlbgS/GoTXA/zHNsb02McskfEEwDzI7KTod+ih7aVlbOoRNMX9D7LSLUtfe
         6mvztAmHxgHArioLDpBGp+hFGVF7PewZBk5+ZmbzOws18ILDpL8rMKLWOkTtyWiBl6NR
         ZjumOnzD7cCAqWhsFhOAlhcmfSapafKSCYFtczMyfoqAmQYSCg2K7fmgNF+6eJSx2zAK
         a9osnR+RrJh0K/+rtemjM2Ep6y+zIOqu32Sj1DmJEcHIO9ywoGiY6uw4klN3M0u4I/S4
         i4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756810704; x=1757415504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfMxdtz4DcDDUc86U5Qw8d4o1LVk/9GYcubnw19a7Vo=;
        b=lEjl0SBf6TCWDZyH43hnOZPL2p6szbp9HJrE+rdlviJ0eI7xvJFuGlpOC01r+07uVS
         05rX6VGQxwm0JIrWyXFD/qCRRx2o8WjfjpPY/OXinc/+1s+55UFPz+U4y5Yjt9Y6/mCq
         a9M1ajtdcfi4hwO/IQRWpTlewavcmfhuoPIn0U/J908o2rtbuo3IOD6p8fPCSpDEYjbx
         GlBTR3WPsykiXzjeiTXkt5Ri9mmK24CKzLdz0tfwbftkiMbVkOpvj+c0LhZK1UPYWzIN
         q0JFQ7Lcqg4K0KWyvu2b3bcSY0QFLOuiPBENSYSCgfNb5loUk5l1MGF1exZEZCvhXoCv
         SizQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3UhMaYaoilP5Dg+8bSnL7nXbj45MhMCst32WHDOV6fVy7SJriSlvjNmE4uWLpdxlAyFE5A+RllL403m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZ0rRckvy3ytQR4g0NIEnSo+x5uTR/yewqLMvF5J610Hp/GKn
	bRl9tsMlmXuBrAABL7kzF09Em4Xhks1b0Qnw3MiDBbA2B/4qNxbPwSEL44jniDYVZBB576I2WF9
	LrCTAr0B76Wgj3kmX7sDYk8IYAeG7Cd5DfRQXxbu1dsrJ5US6KdBq+P0=
X-Gm-Gg: ASbGncuAAR73FQ5SkXsPKAnEyI+By5QC+zvkzFZ2HrA2IiZn8ILTluzBXbVZzMcfqTe
	vRHvj/joEUrkzNelTySUhRrQdNEtDhV39vN6GseDp7SxHPDWe78gLiwGvCFA9n+ajzxoKOdTRIK
	JV3bUVIYjhUZeeFBt2EwstJwu6ilBRbzYP2hKpjIAI76KzMcbE4e1vHjCYFoHw1u9NPROyFWbbT
	0ObqTaMoXOJhwsgaLbdlVFwTpg2VSu8XPjXI1zSlk9K6QZzkLQLxBd80Oqhgw==
X-Google-Smtp-Source: AGHT+IGJeRstlFmXn141hA2zh0v1vPIYwwf6A3NPxDQM214Prr0kW78Uc+Oyrqot7bU7+e2O3OZyDHf9cjoIhRs+pqU=
X-Received: by 2002:a17:90b:3c8a:b0:31e:ec58:62e2 with SMTP id
 98e67ed59e1d1-328156c9641mr16594645a91.19.1756810703718; Tue, 02 Sep 2025
 03:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtktEOzRWohqWpsGegS2PAcYh7qrzAr=jWCxfUMEvVKfQ@mail.gmail.com>
 <hyqcffknmjwjuogoe4ynubs3adk47t2iw4urnpjscdgjjivqz7@b5ue6csrs2qt>
In-Reply-To: <hyqcffknmjwjuogoe4ynubs3adk47t2iw4urnpjscdgjjivqz7@b5ue6csrs2qt>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Sep 2025 16:28:12 +0530
X-Gm-Features: Ac12FXyK-roq9UdfvDh1RySejuG-CgVtu9pGL08wENDIna7l8Tu1FBMlsn9aQjg
Message-ID: <CA+G9fYvA=945et87Q=_c6b-TWjSBxy4H-X9iNsb1_Pj9GCXUaw@mail.gmail.com>
Subject: Re: next-20250805: ampere: WARNING: kernel/cgroup/cpuset.c:1352 at remote_partition_disable
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Cgroups <cgroups@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, kamalesh.babulal@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Aug 2025 at 19:56, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hi.
>
> On Thu, Aug 07, 2025 at 01:57:34PM +0530, Naresh Kamboju <naresh.kamboju@=
linaro.org> wrote:
> > Regressions noticed intermittently on AmpereOne while running selftest
> > cgroup testing
> > with Linux next-20250805 and earlier seen on next-20250722 tag also.
> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? Intermittent
> >
> > First seen on the next-20250722 and after next-20250805.
>
> Naresh, can you determine also the last good revision? That would be
> ideal to have some endpoints for bisection. (To look for any interacting
> changes that Waiman was getting at.)

Michal,
Since this was an intermittent issue, I do not have a good end point
of the bisection.

As I repeat,
First seen on the next-20250722 and after next-20250805
and not seen after this.

Reference:
- https://regressions.linaro.org/lkft/linux-next-master-ampere/next-2025080=
5/log-parser-test/exception-warning-kernelcgroupcpuset-at-remote_partition_=
disable/history/?page=3D1

- Naresh

>
> Thanks,
> Michal

