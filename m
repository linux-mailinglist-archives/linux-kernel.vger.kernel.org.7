Return-Path: <linux-kernel+bounces-731242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D745B05193
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF59C189A739
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937552D3A96;
	Tue, 15 Jul 2025 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSdO84tY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3222CBF1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752560098; cv=none; b=kBWpXMKZXNvwZymUVpDj+8km8oJtCyR4O7yDFGBFduPJpy6ETe3zA79FFhmUsB0pvNStKr26Q/yDPd2kJkm7eE6XUoZO2BrZzOMQLHYU1V7Do+59oyS10eP6/EegcyHlbhCAMxbXqVc1qGNUPkpASbQNDmgPVJuoyckkEr7DdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752560098; c=relaxed/simple;
	bh=Owz7HM3oZ/dUFgrktnlHBz6CNj/X+oEOtmCDPMuOjT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1EzgvnxixOpwF2zsCCfSYflVm4mx3YujoWdb6OnPnZTgAjTxsDIo18pgoKQyTtivZRqzAWHFST8MZUdRD4sBXLbtdfl32ii1aPAK4xDrA7NjubOab2OigtUbVLdSvwwdEElyeALol7ygaikaxzoJnDOVAtS7L0jg3q/0cHzoOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSdO84tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA29C4CEF8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752560097;
	bh=Owz7HM3oZ/dUFgrktnlHBz6CNj/X+oEOtmCDPMuOjT4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cSdO84tYdLtG+FlYIuKqK7r4AwuUpv3rmu0o7TkRVMe3ikLUjOuGB6SPEp07TsJQ8
	 KJyGYWauB+WQ/qmAMZT/IuffEp1hAUcfGd/9Wz9G/HM6uzsUo3hJ3qmtgFdpRip6Do
	 0rdul+ZDuFAly9PEm5tUypBvXtk0mrCMXj9oiBIdyxKI8yERdPIyXiwL4sxJxsETLJ
	 /BFMNc5C+/QTkyqUGBBhIWmO7x0zDO/15IGcAu7lSslV3Ud1cODXF7NOP8DSSjN3Av
	 vGuPZqq4pwCw3UaN6ZEixbzwNdXQhr9qNVa4IsZGhoSAFeqEgf27aK32+kfLR3tMgK
	 Z+YU1wBM3JUOA==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a54690d369so4170624f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:14:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwpcKIz6msyuycVkEgXcWIFotRHn7yciUvsJpUG8FUjC6pK7hQXG6NG4ytmFWGBReoHCeG4tcHCXWzYTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RpePKcGKsI3iNF19aAQBej+ywNFw0q2/ItP0D9hir3pn6gYy
	JCWYvT1E7cE22Vac/i2ss9qDGp9mTTe993EF8M9MJGGbKt9srvrH9WL69TKR6rovSzIothjtg1K
	EhLxN0q/AENwBhAtXFaSL67+6X6S2ZZE=
X-Google-Smtp-Source: AGHT+IHLfAgaTi5jei9UtO0v9WiiSwIuxKXHl6o/lUHfLdgZ2pE6gsJ3CXtYwTkcUEpV70z9QdrQgJYjU4F2IIogjXo=
X-Received: by 2002:a05:6000:4010:b0:3ab:27f9:e51 with SMTP id
 ffacd0b85a97d-3b5f2dfd9c8mr10772054f8f.31.1752560095918; Mon, 14 Jul 2025
 23:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713155321.2064856-1-guoren@kernel.org> <20250713155321.2064856-3-guoren@kernel.org>
 <aHXEx2a0qgiPXhBS@x1>
In-Reply-To: <aHXEx2a0qgiPXhBS@x1>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 15 Jul 2025 14:14:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQBzX9A=AEAaH5SyxWfuNwkG6eichC1w1ryEqRMeuOokA@mail.gmail.com>
X-Gm-Features: Ac12FXxIgjnJ02Xc-z1bd0MQw47wfc1l9w9HznRLlP-75-MHvnNs5H3wYMz37-8
Message-ID: <CAJF2gTQBzX9A=AEAaH5SyxWfuNwkG6eichC1w1ryEqRMeuOokA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
To: Drew Fustini <fustini@kernel.org>
Cc: palmer@dabbelt.com, conor@kernel.org, alexghiti@rivosinc.com, 
	paul.walmsley@sifive.com, bjorn@rivosinc.com, eobras@redhat.com, 
	corbet@lwn.net, peterlin@andestech.com, rabenda.cn@gmail.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 11:02=E2=80=AFAM Drew Fustini <fustini@kernel.org> =
wrote:
>
> On Sun, Jul 13, 2025 at 11:53:21AM -0400, guoren@kernel.org wrote:
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >
> > The early version of XuanTie C910 core has a store merge buffer
> > delay problem. The store merge buffer could improve the store queue
> > performance by merging multi-store requests, but when there are not
> > continued store requests, the prior single store request would be
> > waiting in the store queue for a long time. That would cause
> > significant problems for communication between multi-cores. This
> > problem was found on sg2042 & th1520 platforms with the qspinlock
> > lock torture test.
> >
> > So appending a fence w.o could immediately flush the store merge
> > buffer and let other cores see the write result.
> >
> > This will apply the WRITE_ONCE errata to handle the non-standard
> > behavior via appending a fence w.o instruction for WRITE_ONCE().
> >
> > This problem is only observed on the sg2042 hardware platform by
> > running the lock_torture test program for half an hour. The problem
> > was not found in the user space application, because interrupt can
> > break the livelock.
>
> The first paragraph states the problem was found on both the SG2042 and
> TH1520, but this paragraph states it is only observed on the SG2042. Is
> worth me trying to run lock_torture on the TH1520 for many hours?
We didn't observe that problem on the 1520 due to its small number of cores=
.
But, we still recommend the th1520 involve this patch for potential write d=
elay.

>
> Thanks,
> Drew



--=20
Best Regards
 Guo Ren

