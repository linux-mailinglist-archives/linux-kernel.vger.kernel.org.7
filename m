Return-Path: <linux-kernel+bounces-824725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 508B8B89FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5165C1882475
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B551313E0B;
	Fri, 19 Sep 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB7wUMsS"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED7313D67
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292415; cv=none; b=M7fjsd56fioo1aTbdjMvFcE74YvNM3hN3VBsm2AILYnFmDAEkTTc5F0ABACoN2oM72GKM8t/4PMgmka7/aHeoblqjQU4pcdDE+zvO1rTSAyzxv14+JaAwAXtqh8iMhSW7xMjFZzfYEqjzK6T+gwDFHpixEWxifpohsi6j4rsva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292415; c=relaxed/simple;
	bh=qgYCemReTB8Py51vMht0sTo5gg4ywV1RMgsGRqQygTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgeG3KDf896Ie0t3yt/EC+VUFgBfeKWoXR3zI8O1gyIyWtdUFsyqQFOpZbSY+dfCd3znzdn4WBlRmzgOeJHAMBZSTWd9y4sHbrPmhsK+4DCnoJyUm+VUq54LJ6O+wRd3tC2lfU6IGV/AgNO4j5Ce6o7ZBINEmyiNweGnKLNHUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB7wUMsS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-329b760080fso1757627a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758292413; x=1758897213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nv0VRvH+2z+eOsBA/kWhf8wYjWcXeptQmY40IaARc+8=;
        b=EB7wUMsSrwI+58nU4xc+TdF6mVl/IIdox3s1F4ZVTIevyy7vFI5JF96fGpxUojpZjK
         dUmi7dIdAELWdzoPbjrzGpIBwlMba+muZqKWDMvd8cKvKGYGQCvk1OzOWmO1YX2tzD4g
         xe+0SrxHUUsChHYDZwlfok1lNz8EM2r0pAj1sGcwVJT8FV+JAzdbc/65WdhpRWsu2ba0
         DG0zZHobF2SDgbQQu41gW6st2luBHVxItNvjefNa8ICQooPIa6GTIS49+GFDO3b9mpJC
         iYzi0PKed3K8xRczbkQweNjVnJNPuVYaJP6Y/LXa6tpMo012rJ/USjhRISPvNmKJGqXm
         4TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758292413; x=1758897213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nv0VRvH+2z+eOsBA/kWhf8wYjWcXeptQmY40IaARc+8=;
        b=pEXum5msVk1c2s4MDfJB9teTS8V7TQgKOV0G9o7TB0zmazbvjFYSaiKxYwtPEQiB5m
         CmnUHrN/m0q33EULQsD6EXkDMkz7xPyb/B13vquW9IcBiEYLCRP5n0/DJ3ktdFrxSBj5
         2AbdWDAlLf6puyMmMBjDg/M8Qwg5CLsugtxBcSnXEn1rC5lUqpoKxLX8o+FJbzo8czas
         3sw3Vh/LR7HBBOfvW9Aj/C2/OD44KCKtRamnjrge5lvlB91U6vDE8Ie+uy4+fXL46B5i
         ViVAv4SSEkDAXuQ3FkKwoaPzb0IzLntw0IQ6cvKDoII8p89v6pCSUsRmfhlNfIDtGhSx
         OIZw==
X-Gm-Message-State: AOJu0Yzb8UjtZcgc5ZJuZ7OZaBpTTZWrfOOIWmVn7nIGEYGQwIWBuCin
	eFdl4yhwuhsI5ZoCRd4lAcSNZCmkBfCMv9ekXcW/gMnss6JUFCpWIdJvPuF5UZXxHyc/XVzBhWX
	FXUMUowMTwHlam0vlkuFDWosr5+aRy+G5Qw==
X-Gm-Gg: ASbGnctik1Y74uhg7XHcTcjW82w9g3wL2FSAv7jAYH+RFeXOozxdXTSs4R7ljtsFL/C
	URsUXGJUPizKm8nv1qxqyO/FLoSqJQLGpqZOt1leh9SGNzNFwS2rqzuI/ugU4hZYRKTy+uZmYD8
	s1yppmb6bjFjmx1/cqFE4hQFW+1WhFc/W38/jYKzrZt6ZDhaabAIHIwwby5c7PHFTtgjdOIQKoC
	ilrjB4=
X-Google-Smtp-Source: AGHT+IFmZHTSN2yZAg/Ty+Re3o4YJGVBq+ASNKj76DqB4hM4bLVZNcdMHBtG93fOj9zpBsN040GJk8Bru5Q2E/8KtU0=
X-Received: by 2002:a17:90a:c10f:b0:32b:d183:facf with SMTP id
 98e67ed59e1d1-3309837a720mr4023276a91.28.1758292413429; Fri, 19 Sep 2025
 07:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ72UfNaPC0QXW61ENzCYLRUuYQCXeVxir4UFj4eP4PROg@mail.gmail.com>
 <20250919135803.556437-1-zhanghongru@xiaomi.com>
In-Reply-To: <20250919135803.556437-1-zhanghongru@xiaomi.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 19 Sep 2025 10:33:21 -0400
X-Gm-Features: AS18NWDjBmTl5whX_qOxidYSoN77QlptYsKPBo3zQkrciubZc41wi2czoHiX_iw
Message-ID: <CAEjxPJ5JFqSMGSg5KEYd40JhLkgUo6g0uykDkXdKW3q5F1JtjQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:58=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
>
> > > Baseline: 512 nodes, 512 buckets, original avc_hash
> > > A: 512 nodes, 512 buckets
> > > B: 8192 nodes, 8192 buckets
> > > C: 8192 nodes, 8192 buckets, original avc_hash
> > > D: 8192 nodes, 4096 buckets ("large number" of nodes in limited bucke=
ts)
> > >
> > > 1. /sys/fs/selinux/avc/hash_stats
> > >         a. assess the effectiveness of the optimized algorithm based =
on A, B
> > >                 and Baseline. Expect bucket utilization rate: A ~=3D =
B > Baseline.
> > > 2. total latency of hash operation and table lookup
> > >         a. A vs Baseline: expect A is no obvious latency increasing
> > >         b. B vs A: expect B is close to A
> > >         c. C vs B: expect B is no worse than C
> > >         c. D vs C: see if we can save some memory with no obvious lat=
ency increasing
> >
> > Thank you, looking forward to the results. Fun fact: the current
> > avc_hash() function logic hasn't been changed since SELinux was first
> > merged into Linux 2.6.0-test3.
>
> Yes, I also noticed that. I tried MurmurHash3 and another algorithm (refe=
red to as Muladd below),
> it seems performance of Muladd > MurmurHash3 > current algorithm. How
> about using Muladd?
>
> Implementation of Muladd:
> static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
> {
>         return (ssid * 0x9E3779B9 + tsid * 0x85EBCA77 + tclass * 0xC2B2AE=
35) & (avc_cache_slots - 1);
> }

Can you cite the source of this hash function? Is it public domain or
otherwise GPLv2-compatible?

>
> Note: all test results are based on patch "selinux: Make avc cache slot s=
ize configurable during boot"
>
> Here are the results:
> 1. Bucket utilization rate and length of longest chain
> +--------------------------+-----------------------------------------+
> |                          | Bucket utilization rate / longest chain |
> |                          +------------+---------------+------------+
> |                          |  original  |  MurmurHash3  |   Muladd   |
> +--------------------------+------------+---------------+------------+
> |  512 nodes,  512 buckets | 52.5%/7.5  |   60.2%/5.7 * | 58.2%/6.2 *|
> +--------------------------+------------+---------------+------------+
> | 1024 nodes,  512 buckets | 68.9%/12.1 |   80.2%/9.7   | 82.4%/8.9  |
> +--------------------------+------------+---------------+------------+
> | 2048 nodes,  512 buckets | 83.7%/19.4 |   93.4%/16.3  | 94.8%/15.2 |
> +--------------------------+------------+---------------+------------+
> | 8192 nodes, 8192 buckets | 49.5%/11.4 |   60.3%/7.4   | 61.9%/6.6  |
> +--------------------------+------------+---------------+------------+
>
> 2. avc_search_node latency (total latency of hash operation and table loo=
kup)
> +--------------------------+-----------------------------------------+
> |                          |   latency of function avc_search_node   |
> |                          +------------+---------------+------------+
> |                          |  original  |  MurmurHash3  |   Muladd   |
> +--------------------------+------------+---------------+------------+
> |  512 nodes,  512 buckets |    87ns    |      84ns *   |    79ns *  |
> +--------------------------+------------+---------------+------------+
> | 1024 nodes,  512 buckets |    97ns    |      96ns     |    91ns    |
> +--------------------------+------------+---------------+------------+
> | 2048 nodes,  512 buckets |   118ns    |     113ns     |   110ns    |
> +--------------------------+------------+---------------+------------+
> | 8192 nodes, 8192 buckets |   106ns    |      99ns     |    94ns    |
> +--------------------------+------------+---------------+------------+
>
> The values in the starred cells could be because MurmurHash3 has greater
> overhead than Muladd.
>
> Details:
> url: https://gist.github.com/zhr250/198717da076a808b5cc78762f27be77e

