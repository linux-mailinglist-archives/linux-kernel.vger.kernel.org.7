Return-Path: <linux-kernel+bounces-854767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B30ADBDF552
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55DB9350076
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA42FBE1C;
	Wed, 15 Oct 2025 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OTrVNAKi"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBEC2C21F4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541853; cv=none; b=kjUFbT0++8KtusLDLes06fMniq1YTvKEUzDHbMcxqYdodEXl1ZvsuHEfqKgyRwnUJry6HOxsroS3CHPZpaQaTx/UMdkCsLB9kwGhr+cc6guA6z9pVTMUc70CmZgGXQFLOFTHJyaRdQmNo6EErfPmLOJFjbg+/Mdk6fuuGNCP4ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541853; c=relaxed/simple;
	bh=fHi4Sy6ZO6219mNkkAMO1NN3Q4Mdyg5IgRsuybnGRaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSqUKlo66rSbqnfPuolC07a+svkml4iloBDswoHaHS6WuqHp7Rcfna9HxD7vw3tfm09gbOvan+P211ixN1wrjWrkIp/EBk+EWBoXcbXZEZ57e/CVWTR+O2QRIkgl2VB5IWzREJbvy1Q1gtuavxdU7fpFlQqgFxPTf5V3um5y2q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OTrVNAKi; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3737d09d123so52200801fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760541848; x=1761146648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSysKNFqHQrm7HW9ou4XnQTMAOsGZaUAittjs2tbdIc=;
        b=OTrVNAKiUj4qeasqNWzZ42f8ThURb98tRuuQiiRi9i22KyrfK9OaHx/EVt5x58t1gZ
         KD+YvoJB/8Eb4jVu/ECj+0iD39uQwpcNJcGFBuEeB8EoDOknVSzObH8RxQ/KGiviBBSs
         77euI61oMwKrh1mGcXqviIYaTHO8zJjouJq4r5QfSMEfQd54GfoP2v0v6IcLFJzuqJE/
         J/AFAYncprUW99IS5Hv8MtLjHLEp3ZL6EXQPztB60er91EmJrdjUxEoT6BF7pYUgoUpF
         kBfEo5rFtV3boCiHiPvxM9nc1j2eXlm5j4lMZwQDEsCKb8gWeW/i7CRo0vpWt6V+7ozO
         uqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760541848; x=1761146648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSysKNFqHQrm7HW9ou4XnQTMAOsGZaUAittjs2tbdIc=;
        b=Oh+BIKHIUPhWdWbehbFPX45LNXprxUnj4aswN4h6GaNrEWTubUDDtShWGHCq4wg/6Z
         AFFUhi07PJhZRAMoQhCi2WOhCjBPqkgIPoRKwYBLy7Wg745DO8bo9QWstXrFS7YZSVyq
         RUGQgEYM17iJlaW2ZAOWhyjvn3LdzqWE2j4IBa1qJWSvglFM0oKbGZ8JaeoDqdRwNber
         qOe1+BN2VJtomaBpvF24MpG5eJG698XJ31p36oLvXFPBrPx7PpDXrF+0dkIP4HZJYhyg
         osvjybtCQGAmzMVbvj4dFiL9bTCdrWczqiu/bpUHOQevdhkXTUgxJTQGmxRS5N5D7g3n
         BMvA==
X-Gm-Message-State: AOJu0YzmC2MbMEA2fmxLCjgoua2qoO+ZpuExF96zDAKRzpmOys7OKjnP
	SZUBrYVmAd7ePqK12qg732Rm22uFuSLVXv9/cNcu0EwbsUi2zeRIspw7zTQOaKo6OcuV+m35oVq
	2ShY7sqq0rm8k1SeJRb2PxR2C7+T2NOHKI3H1pT2Nlg==
X-Gm-Gg: ASbGnctpbZqp2cUoBcjuZaeR7I8Q4m1LuxjQBMx8kKiHN5h+Iy5UpA+NzMRGINF0MBE
	5PMmeLhMsaOZuN9PFKV/WMa1q1pbGHSXgP7J6KFlnI/am/BAIkM6FCYjCNvbE2ajpJU6LaIrA9F
	KyFWbz/e/BsnjPiux6sixIHgW/yDBBy4vyP2r0q/LrNTbR8x9WB5tHi/62TeZ0Tr1ZVazT9Eqip
	RKEbNaJVs6xH3V5z5CGCg7F5PeubrXmLqNwbjFpljVbPw0xoCXo5YAZJfo=
X-Google-Smtp-Source: AGHT+IHrIpnmA3PfhS5F43KKvrlsIpMZQHo0Y4ikDQOz1PFqFFjsj/VrWWbwy50E1b37KRiZ2S09Lm6qe0KfxZLGVVM=
X-Received: by 2002:a2e:a541:0:b0:336:bd8c:5e53 with SMTP id
 38308e7fff4ca-37609cc2d6fmr78271231fa.5.1760541848431; Wed, 15 Oct 2025
 08:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929155053.400342-1-marco.crivellari@suse.com> <176054173655.179445.8487996832699914920.b4-ty@kernel.org>
In-Reply-To: <176054173655.179445.8487996832699914920.b4-ty@kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 15 Oct 2025 17:23:57 +0200
X-Gm-Features: AS18NWBvKtm51_JvZYvvvcOsZcx-fI7s4PuiuLPeUZyiDl7r4VqZO-UJmhBVZGc
Message-ID: <CAAofZF4_0+ZK5hefqbDksxtSe96ZnR18uQrr3Xw17zvYd_fMmw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] ASoC: change system_wq with system_dfl_wq
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:22=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
> [..]
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-=
next
>
> Thanks!
>
> [1/1] ASoC: replace use of system_wq with system_dfl_wq
>       commit: 0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4
>

Many thanks, Mark!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

