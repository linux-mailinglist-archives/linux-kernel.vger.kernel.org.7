Return-Path: <linux-kernel+bounces-748957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4CB14804
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB6B7AA524
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC2A258CD7;
	Tue, 29 Jul 2025 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORAju7PU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3371D516F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753769421; cv=none; b=cuNj4bk6MtghretqP+OY+27/XmSgs6D4zoE+VcNqDRuy9up4DWVKYWa33jV8RaH2Qktgoj4Jwzk94GhaowxZyjB/xXCUkP40jefy/0Iz0tbDQb8rRZf+w7nrLFoqKKIQyHworJzgy+K1++4j/61s04e0LK56eNUcbC6fOXtmqKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753769421; c=relaxed/simple;
	bh=Pbb6JSQlddgzo638LBFnzbyCC1IuUBa7KRA0EO6+tt4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NqXMt0CV09A9eIf+xH7B/rf+RRgbF8CF4iT6dbK/q7G0D4YYpq5KoEIRZqo+tV1cwtKUbqxPZ/XGogxcu1g66Qsa+5mFb8dA8WUupwlJqGdMiMMYi4a49laN55nzSE4/zZ2V8uFky1C6Z4rszsDb43SQyTvK0xyYCWW/kJOR8fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORAju7PU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26985C4CEEF;
	Tue, 29 Jul 2025 06:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753769421;
	bh=Pbb6JSQlddgzo638LBFnzbyCC1IuUBa7KRA0EO6+tt4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ORAju7PU8nUg80drYIpXbABGfnJ2jaNgFTDgle5Bn6p5HMdG917raR5pHmJiaWHce
	 HLyh9BFnceA4t5XdbOwGO1EKvGA8m4T3tYjdeXmYjYuHT6x/Q8F/EEQzX2bRlfE9dh
	 x9/lxvjbAlP3D68N0VwJIv9aDtRvAwVSpuQpNvBsyXF9epmc76TFWVJlQl5+He2QER
	 zlbT5S+FmQyNTaWyIpwO6dAj1RtMXM1psp/qsryMQGguNBYvd0Ido1t67uA8MYjc/0
	 xTRMtl4Lx5OzvbPG2lyQyCWFP3JVVCGejqnIpsjqvn1H5ADHH0CqGFoqkS2bU97gNm
	 GRR6G/pClR4FQ==
Date: Mon, 28 Jul 2025 23:10:19 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, David Gow <davidgow@google.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@loongson.cn>,
 Ingo Molnar <mingo@kernel.org>,
 =?ISO-8859-1?Q?Jannik_Gl=FCckert?= <jannik.glueckert@gmail.com>,
 kernel test robot <lkp@intel.com>, Lee Jones <lee@kernel.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Marco Elver <elver@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <n.schier@avm.de>, Nishanth Menon <nm@ti.com>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [GIT PULL] hardening updates for v6.17-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wjZkusqUg9nt66xYVeXxMcmeOw_-toc=-kwPi5Gad4y1A@mail.gmail.com>
References: <202507281251.8989493D@keescook> <CAHk-=wjZkusqUg9nt66xYVeXxMcmeOw_-toc=-kwPi5Gad4y1A@mail.gmail.com>
Message-ID: <31A791DF-C044-4883-9074-8D13A67DE89B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 28, 2025 5:43:08 PM PDT, Linus Torvalds <torvalds@linux-foundation=
=2Eorg> wrote:
>On Mon, 28 Jul 2025 at 17:01, Kees Cook <kees@kernel=2Eorg> wrote:
>>
>> Please pull these hardening updates for v6=2E17-rc1=2E Some notable thi=
ngs
>> that stand out diffstat: there are many scattered changes across arch c=
ode
>> to clean up __init vs KCOV instrumentation=2E Most are landing here via
>> the hardening tree but 2 landed separately in their respective trees:
>> loongarch in v6=2E16 already, and platform-drivers-x86 that is queued
>> for merging:
>
>Is this the cause of the new
>
>  section mismatch in reference: volume_set_software_mute+0x6f
>(section: =2Etext=2Eunlikely) -> tpacpi_is_lenovo (section: =2Einit=2Etex=
t)
>
>warning?
>
>It does seem to be a preexisting bug, with volume_set_software_mute()
>(not init) calling tpacpi_is_lenovo (which is marked __init for some
>unknown crazy reason)=2E
>
>I'm just not seeing what changed to *not* inline that trivial
>single-instruction thing=2E So something really bad is happening to the
>compiler because of this hardening change=2E

The change is actually *removing* sanitizer instrumentation from __init fu=
nctions, and this seems to cause GCC to play weird games with inline vs sec=
tion markings vs coverage sanitizer options=2E I scratched my head over it =
for a while but since GCC has had this kind of "unstable" inlining behavior=
 before, it looked like the fix in similar situations was to switch it to _=
_always_inline=2E In other cases the use of __init was adjusted=2E

The fix is part of the platform-drivers-x86 PR, specifically:
https://lore=2Ekernel=2Eorg/lkml/20250529181831=2Ework=2E439-kees@kernel=
=2Eorg/

-Kees

--=20
Kees Cook

