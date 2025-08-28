Return-Path: <linux-kernel+bounces-789386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EAAB394C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29E61C25F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0022E22B5;
	Thu, 28 Aug 2025 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkVi2KD7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55CC2E22AC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364976; cv=none; b=WCKMPGsvccd+xciPqgsaYsJP+USOY9lSdBhfjgtYO3Vf7sRqsoUlaUEAR2fTZynTc9ImSj7agrkG9h1CCbpw2fVkhLUo8R/yAeryZIn/Vt3ZI05gKSsbKGFfi55I2N8MJOOV5+61KDY0+jA9N4tuoDCugYPrdDukgM1OWdvjycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364976; c=relaxed/simple;
	bh=CRTcNqNyMT97ewqeVrG1k8KzvI3+QazP8GobQvTtyyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emcgmbz013dXL7c/sZoLVaq0pzOot0LwlF0sYZimO+TAgimfQwCfQwPxOe16mngHd8p/hAipcqhQfbO8r8ShpKm3ON/0pdNuePaJdr+wrjarjFkRaEx4m8OohCKDmDmlL+kKoSC/wt6lb04JyqgmePQW+ClraXt6tRYSuM6mBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkVi2KD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605D4C4CEF8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756364976;
	bh=CRTcNqNyMT97ewqeVrG1k8KzvI3+QazP8GobQvTtyyk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SkVi2KD7jMQ3zyDRiTmnoePBAFmboUKKC2ROYnEPhJq0wC5YV+3ih5saZwUyj46Kn
	 4MQLi5mdr3lZ0tDNCeWITma2hCjGg0D3jx77pktq6dsXlH/LbUUlvMm/hABZmtlHkW
	 LZZhc7uTw+47S4MICG5CpBM29tP/z1rw76yQrPf4ii8qRjheugIixyJuQB/pWPdHdC
	 noGxsoqNFHecocwerP1qRJua20hBbAT9Yabzl47BqD974xRMd9kfHmN4oujrSFglm8
	 AjwllRS/FCvwHE7aoeKirVYhZFNmQNsxMbe9pFHkTaTkz09Tq0VikJIfyN29aOqwuu
	 JVpTCyyhcDUhA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61c22dceb25so882137a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:09:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbPFi+dUciljcwR9vn+nvox1WdLjskTmMMshJEm/7uLEL4llZyM3WKR4ireKjQRvG8AlWwEEMlZX5YEgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvFXfToeeJzwRyqi9ZLQ100O3FJao+zfPX5HkqBiRoIfj6Ky2l
	5IdkL5zUC7FoROx5jb8Iw/qi83cCL4k0aGFoOn6n6FjVlO8kh4gQ6tb/tqr/c19AHqG4tFRO9lJ
	oIUtpqga1SQaWWdcyqK3e78cdiiszdiw=
X-Google-Smtp-Source: AGHT+IEdj4uyB2ezk9HhUf79b9OJBHcgtGmr8Mnd99Hiov12Hmlp+SKv3xAlPf7+EC+8aF+ULSBXtIr0Vo2k5/jXtk0=
X-Received: by 2002:a17:907:1c93:b0:af9:d80f:645d with SMTP id
 a640c23a62f3a-afe29793340mr2068986466b.57.1756364974923; Thu, 28 Aug 2025
 00:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826113225.406238-1-guanwentao@uniontech.com>
 <20d3df642aaff2a771e74452b81463709f7c16d1.camel@xry111.site> <tencent_6579F3317CCF94D00EC3C7DD@qq.com>
In-Reply-To: <tencent_6579F3317CCF94D00EC3C7DD@qq.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 28 Aug 2025 15:09:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H68Tzewu3x+8=Psb-8Hqg58o4v-8QyvFew+Wuo=Ne-iAA@mail.gmail.com>
X-Gm-Features: Ac12FXwfMgWNNgv10BfeNOpoGdtGBB9VwNXLisbu4V2-a35ae4seuy97OFb64IQ
Message-ID: <CAAhV-H68Tzewu3x+8=Psb-8Hqg58o4v-8QyvFew+Wuo=Ne-iAA@mail.gmail.com>
Subject: Re: [PATCH] Loongarch: entry: fix syscall_get_arguments() VS no-bultin-memcpy
To: Wentao Guan <guanwentao@uniontech.com>
Cc: Xi Ruoyao <xry111@xry111.site>, WANG Xuerui <kernel@xen0n.name>, 
	linux-kernel <linux-kernel@vger.kernel.org>, loongarch <loongarch@lists.linux.dev>, 
	=?UTF-8?B?5Y2g5L+K?= <zhanjun@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 3:06=E2=80=AFPM Wentao Guan <guanwentao@uniontech.c=
om> wrote:
>
> Hello Ruoyao,
>
> Thanks for your review.
> I will test and send test results later.
> (use different gcc verions and remove the three flags.)
I think kernel's memcpy is still needed for CPUs without UAL.

Huacai

>
> BRs
> Wentao Guan

