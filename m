Return-Path: <linux-kernel+bounces-763226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB80B211AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E805A7AE193
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA4296BDF;
	Mon, 11 Aug 2025 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PskRseUp"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8E0296BCD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929283; cv=none; b=XX/pOXG2+6XFlclxEwP3wPu1n0S3UHBjj/AGwaXHwpA49wcby5JbVgmfyR4nQgvtmPCWtV8kqbiCkEgvgqaqY4lqf0HPK0RXHLwrFJx0GpyHdcwD8tWuJBWJfU6pa8fZ3wN0whHoGd6nVpIudunPxAwFT4QoO4k9tK+JIm8+74A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929283; c=relaxed/simple;
	bh=s5bt6GFiE6bMNBu/lzmSJYG/tNT+JL+uAYtxA5bAwHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNa8fhNnUK4TXbyQILIQtwX2+7lfRN6//RhxXdn4fSv27rpGgE4L9B/wiq/TktibZRmJkHzA5PnO2LbfIF56xu6Oy9R4qc//8wTXOkn4l7FoP7+F15htq7D++6i0vj35yze/luq3pD5+LdYrtUk0vjCK1W4j2bKyX0n9RqCydEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PskRseUp; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b07d779287so43718541cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754929280; x=1755534080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awL0JISook8hWw9o6aqgJ55OTTrQ762wx6oz1JCvYrA=;
        b=PskRseUpRRQ3CA1E5fZ8UsWF/9a9BHGgilbdIJWJyhGT5X2pTgE5nQuPKsNwjDvSPg
         gYBpZun07D7KQhOzOkGDsO8w0dM1UlpDwpSLixoLSkCvWK9oxR6LeLDhwvUiPtp5Kw0R
         OizX76loLUxMqlMUNr8Iz2jRRWingJXf1EMkc2sUNFClXwo87CjFsD9KfmUbVi1FGqf9
         gCJq5kcMEWAMRlgBcMvEuf8Iqnrd3N1zPwD651fP9TB0V+Ywu30ts8HcYtSnQqgn/wLC
         PNelNxgxGp5VECWzkElYBwqzjb7NBh+K89dzjqfTRrgb0Jqq1VNBRYT9ZossoHFC/PIC
         SA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754929280; x=1755534080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awL0JISook8hWw9o6aqgJ55OTTrQ762wx6oz1JCvYrA=;
        b=fTqyE7A3NjF52aTKMhs0/bckvvCLnfWkgSGUCQw1Iu/eIGHb5CpUzZczzsZ9TitSMG
         vuO6h2y1keNCo0c2jmAHgFmfQPJpt93A4/oQ2xfN23GNqeHBXJOlSSxWSTTCvQUyWYLh
         CqhKGgbvQv0kw+QUJ5KjU7/SYTZG67QkdK/GdBiB5kvBbgpvJKo47KIj7xZDWZLyQv48
         YyYBnkC+wf2C28enQJLp6QtVUzhbeSwNfgaaeMUDhSLO0tDPMA3qiy2icnmbChE8jxBc
         1/cwMoKm/p9txo+ux40dSJ3pwvOv1pcLr0vq29DEHfXSzRxr5D5QsTIn72pD+EtJxbqx
         kUbw==
X-Forwarded-Encrypted: i=1; AJvYcCUUzHRfk5egqbHmO0xQBb/USu9sGD8YfKIGKFjU9Ls4YUGPsJZU6uic0SdEFTMzb2ymNjT6HMYZaAhX/dU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi5kM/kcr/q4sO1gwyZLy6pyYE+k44aDDhBeTsOIVdzkcKDUed
	vMqUpqPrWpNR4cIOEc0L7GI76YI3cUAMqoZkuFNwaWc6Nf7yV/zHtdm/nYYh6MwbHsk1KeOKPPf
	I26MDpXAIwbmeSmM00uzmhJl1d1KT18A=
X-Gm-Gg: ASbGncsbbbiOsofnNiSiAm3Ctd4HDtCerkYlaj5FoIUb3oYug5HnFefPdLUEzWpMJyY
	tW/0Srk9cfcl0rD+CW6K/eg3f6wfsUbtcic0gTSnNFzF+gTm0ehyz6LSuHgE6nL85K9lBhsZSqY
	bs/ZNN+EEXt09mpbyObatpa8T5FVfNZNpiccmY8nSRCEyyWDXh2YpXq3GS7D9nBpHbZ8n7laz2z
	YQ6lHM=
X-Google-Smtp-Source: AGHT+IEDpLTv7rwI0cAD28QFliIQ+yhsQyc/LNmqJsRa+8ZnXDomS0x3dmlWYN6EUAqJkku1zV2hhhFk3Xiacn8G2Ic=
X-Received: by 2002:a05:622a:246:b0:4b0:6d53:a0fc with SMTP id
 d75a77b69052e-4b0ecba90cdmr1727651cf.7.1754929260980; Mon, 11 Aug 2025
 09:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811092659.14903-1-youling.tang@linux.dev>
In-Reply-To: <20250811092659.14903-1-youling.tang@linux.dev>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Mon, 11 Aug 2025 09:20:49 -0700
X-Gm-Features: Ac12FXzUld0iGaUsswbNzvqcYCLYuSpImt4hSWuMJKJTIUip4EMBCi_zM0pJ_tc
Message-ID: <CAK3+h2zXBcAgtWJLXhAzzTZQ6_7Epqc6HuOassm_o5JAftK+Gw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add kexec_file support for LoongArch
To: Youling Tang <youling.tang@linux.dev>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Youling,

On Mon, Aug 11, 2025 at 2:28=E2=80=AFAM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> This patchset implement kexec_file_load() support on LoongArch.
>
> This patch series enables us to load the LoongArch vmlinuz.efi or
> vmlinux.efi by specifying its file decriptor, instead of user-filled
> buffer via kexec_load() syscall.
>
> To use kexec_file_load() system call, instead of kexec_load(), at kexec
> command, '-s' options must be specified. kexec-tools needs to apply the
> corresponding patches. These patches can be found in repository [1] and
> will be submitted to the kexec-tools community later.
>
> The basic usage of kexec_file is:
> 1) Load second kernel image:
>  # kexec -s -l vmlinuz.efi --initrd=3Dinitrd.img --reuse-cmdline
>
> 2) Startup second kernel:
>  # kexec -e
>
> For kdump:
> 1) Load capture kernel image:
>  # kexec -s -p vmlinuz.efi --initrd=3Dinitrd.img --reuse-cmdline
>
> 2) Do something to crash, like:
>  # echo c > /proc/sysrq-trigger
>

I am new to this feature but I am interested to test this feature, How
do I get the second kernel or capture image vmlinux.efi and
initrd.img, do I need to build them separately and how?

> Link:
> [1] https://github.com/tangyouling/kexec-tools/commits/main/
>
> Youling Tang (6):
>   LoongArch: Add struct loongarch_image_header for kernel image
>   LoongArch: Add kexec_file support
>   LoongArch/kexec_file: Add initrd loading
>   LoongArch/kexec_file: Add crash dump support
>   LoongArch/kexec_file: Add "mem" parameter to limit memory usage of
>     kdump kernel
>   LoongArch: Enable CONFIG_KEXEC_FILE
>
>  arch/loongarch/Kconfig                     |   8 +
>  arch/loongarch/configs/loongson3_defconfig |   1 +
>  arch/loongarch/include/asm/image.h         |  58 +++++
>  arch/loongarch/include/asm/kexec.h         |  12 ++
>  arch/loongarch/kernel/Makefile             |   1 +
>  arch/loongarch/kernel/kexec_image.c        | 112 ++++++++++
>  arch/loongarch/kernel/machine_kexec.c      |  33 ++-
>  arch/loongarch/kernel/machine_kexec_file.c | 234 +++++++++++++++++++++
>  8 files changed, 448 insertions(+), 11 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/image.h
>  create mode 100644 arch/loongarch/kernel/kexec_image.c
>  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>
> --
> 2.34.1
>
>

