Return-Path: <linux-kernel+bounces-862056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A80F4BF453E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD3864E6603
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1BF248F66;
	Tue, 21 Oct 2025 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZYdyGBT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA3623D7DB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011729; cv=none; b=KOtLeSl5rBFpyFi2d+GoHlA8q9fafof4ZNFtvpXc8eArLTqSKIleBQLo0spVu5G0XoV65b5wavHkbJsSqUUWhSOOZbHjkP6EuYMgzfjsqjmpRgNWY7+PdXfpea0fQaGa/3EMmNRaiZrMC4Qw+RBn3LGt7EAGMcQ+EVhCTtjyjms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011729; c=relaxed/simple;
	bh=+mHy8eS5Nt6pJighN7KNUK3EBt2S0NqDERk+gDOg4is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbRWnBXrxRA5qpEbQsF16rdwBrE9LMhDSo5f2EtcqTbqe+qnBT2Jq99+BXrxub8RPQuoLRwNTnCCreawXCW2TdK2uwdZcraBuOMutkStLfQd1KK8j74w0vIm1/eynAztzCyVHpBM2lPdd5hMlIcGt9zU4r+r2a38yDinwpF7dhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZYdyGBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAD0C2BC87
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761011728;
	bh=+mHy8eS5Nt6pJighN7KNUK3EBt2S0NqDERk+gDOg4is=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eZYdyGBTexugNCKzKfNI8noqBE1/u5nrGmVgzQj76NotObcVLVtsmO+6L432Fh+5D
	 GMNua6LidkRbf1A3wxdyDRXK0zEOpKYTD79bjuX8sc5TiFhYlOz8cf7/aeER2t+Eti
	 K69fItL/QQfUJGtSfkQSaalJdydp5GKR0BqTkC4SJBThAI86YSdYEK1eapC0GlSij2
	 Z3qwpnlfXQEMf7ZnJDRxJRnUFXIgl9BhJ+R7wbUou/cm9wPbk1g6UjlkMsc9ZDr01R
	 GQh4DbaRsPZckM8Eih6gKtaPZfwR9AY5wxNb8i7UxnwWtVqh6hfAaeLfG66ih66jxO
	 2EgfoQs2fadpg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63befe5f379so6559091a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:55:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIZhG9W1dTuSZBpcwn2rJKXHlJ/qmAy8PGrz8E2dBwqbgvMhvGASrdr7ZS50YVHpyyCVJ72u9P8D25n50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xiK6UQF5jVVCFpAfCBKpT6w/L1I5qWcYNY/aJjolD4eNyGG1
	Fj92phmnVk0pbw2aEIOLKHr9/TzbGNDYEWCGtCnPHKZ37kAyyF7JzqmtcVQUjIjN0nApbfHby33
	KvMY6oj3bly4PngL6sWCGFSf3cAjeolA=
X-Google-Smtp-Source: AGHT+IH7YsVQtiiAB0r/FcBakX7/KykMp7m7W3JxxRMUwa0RfZcTj38goSByBYV5ntMaHQ0Z3YagLvVEzZlYc0eCmBE=
X-Received: by 2002:a05:6402:5246:b0:63c:45da:2878 with SMTP id
 4fb4d7f45d1cf-63c45da309bmr11428316a12.25.1761011727142; Mon, 20 Oct 2025
 18:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020020749.5522-1-linkinjeon@kernel.org> <aPbRKScRgkxUDYew@archie.me>
In-Reply-To: <aPbRKScRgkxUDYew@archie.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 21 Oct 2025 10:55:15 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-qMVaorDLzfDBTMvf80WrrmTAt7wGzWBqzfD2bMh3RAg@mail.gmail.com>
X-Gm-Features: AS18NWAtBY81ul7QqEL6JYNltQqbNA9hu0ykyi8rWQo_96JSZfcRuJetqKx_qeI
Message-ID: <CAKYAXd-qMVaorDLzfDBTMvf80WrrmTAt7wGzWBqzfD2bMh3RAg@mail.gmail.com>
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, cheol.lee@lge.com, 
	jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 9:17=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Mon, Oct 20, 2025 at 11:07:38AM +0900, Namjae Jeon wrote:
> > Introduction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Can you write the documentation at least in
> Documentation/filesystems/ntfsplus.rst?
Okay, I will add it on the next version.
>
>
> > - Journaling support:
> >    ntfs3 does not provide full journaling support. It only implement jo=
urnal
> >    replay[4], which in our testing did not function correctly. My next =
task
> >    after upstreaming will be to add full journal support to ntfsplus.
>
> What's the plan for journaling? Mirroring the Windows implementation AFAI=
K?
Yes. It would be best to first obtain the NTFS journal specification,
and I'll try that.
>
> For the timeline: I guess you plan to submit journaling patches right aft=
er
> ntfsplus is merged (at least applied to the filesystem tree or direct PR =
to
> Linus), or would it be done for the subsequent release cycle (6.n+1)?
It will probably take about a year to implement and stabilize it.

>
> Regarding stability: As it is a new filesystem, shouldn't it be marked
> experimental (and be stabilized for a few cycles) first?
I heard from Chrisitan's email that he was considering adding fs/staging tr=
ees.
In my opinion, it would be a good idea to promote ntfsplus after it's
been tested
there for a few cycles. And an experimental mark is also possible.
>
> Thanks.
Thanks!
>
> --
> An old man doll... just what I always wanted! - Clara

