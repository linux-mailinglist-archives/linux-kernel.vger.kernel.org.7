Return-Path: <linux-kernel+bounces-778790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56766B2EB0B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF985C7554
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428462C21DE;
	Thu, 21 Aug 2025 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBjDFPZi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E52853E2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755741657; cv=none; b=snb1niHbJESlgaMoLXUzAVjRLVBeysg6t3MORb/aVtHGtuxZZFGhCWg0RyjVA03UqgHJJWHouSz5ptQiRLzIFG1FUDT7t+mGBMM5+VSyZKxgW/Cu9vhkbGkiT2rAdo/pZcPfj1LTViapF+rXgqu57YRo84sBPBCGmBG/GP0XTsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755741657; c=relaxed/simple;
	bh=Vvso8Kr/4e0NoAO0JOi2KlOzfHJm34wV62jJixj6yPo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=K5jsUYO3XjhcWMfrlKrO10e4swBjvWTm1mqlpjwI7p8pbjJTzRMR5LzuqIUB1nMQwrCGIFFzlff2LJTaXdpv4HEwNbtXSM77a7OLnfct10Hb5uqsaukPfACzjsDRZKzRiJu7GOYwIv0cIbMFuwF5lwwWJhO+unFNrPkhnQDmo+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBjDFPZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADE1C4CEE7;
	Thu, 21 Aug 2025 02:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755741657;
	bh=Vvso8Kr/4e0NoAO0JOi2KlOzfHJm34wV62jJixj6yPo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=dBjDFPZieWHAeQ+r8fkKDn/Lkcl32aq30SFEOJjPr7jSRTSgaEn9oLcwIugiJDjGj
	 Gzwj4DY21b0Zg2CjhrAvdC35UTahxAuR3KLwFCt8PR4R7+aDMKpvkB9DvGKJGuDOO1
	 i6nHQIFHmmzsmOA6Eb6A3DifWeKLLxsyus07+UcwrBn8x8ANJAss5tlq1e8Qgwa+D5
	 IGWWYxTuCRxonoBLbXudLbzpddOouUFIGfqbveeYeNn2mUvxEoM4vYLJrvmgADGjDt
	 PrGJKxJplLqln/17ViW9eTUws3GXekdC4Z7OBM+7encqKAnr26iUmB2oFGxAGgdWMz
	 8Wcn63ek3SU8w==
Date: Wed, 20 Aug 2025 19:00:52 -0700
From: Kees Cook <kees@kernel.org>
To: Marcos Del Sol Vives <marcos@orca.pet>, Borislav Petkov <bp@alien8.de>
CC: "Ahmed S. Darwish" <darwi@linutronix.de>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
 Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 David Kaplan <david.kaplan@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Oleg Nesterov <oleg@redhat.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
User-Agent: K-9 Mail for Android
In-Reply-To: <3db7d599-c2a7-4bec-94b1-4872649dde8d@orca.pet>
References: <20250820013452.495481-1-marcos@orca.pet> <aKWR8e6VUEZEgbkw@lx-t490> <2cd7b099-095d-405c-a7d9-b0f1f72184c2@orca.pet> <20250820094347.GDaKWY02hR3AAoT7la@fat_crate.local> <be242e65-b056-4e12-93e7-9a297aaf231a@orca.pet> <20250820095556.GEaKWbrMh24T7jTfBg@fat_crate.local> <3db7d599-c2a7-4bec-94b1-4872649dde8d@orca.pet>
Message-ID: <19EDD0A4-9466-4D5F-B312-BCA293AC660E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 20, 2025 3:01:30 AM PDT, Marcos Del Sol Vives <marcos@orca=2Epet=
> wrote:
>El 20/08/2025 a las 11:55, Borislav Petkov escribi=C3=B3:
>> On Wed, Aug 20, 2025 at 11:51:27AM +0200, Marcos Del Sol Vives wrote:
>>> I mean, they should know what they need to recompile if they want to, =
not
>>> just that their machine is having a bug triggered by some binary=2E
>>=20
>> And what's stopping you from writing a proper error message explaining =
that?
>>=20
>> And issuing that error message *exactly once* instead of flooding dmesg=
 for no
>> good reason?
>
>Please define "once"=2E Once per what? Per boot? Per executable? Per proc=
ess?
>
>Once per boot would mean they'd need to reboot to see if any other execut=
ables
>are affected=2E Per executable AFAIK there are no facilities to do that, =
and the
>closest is per process which is what it's currently being done (again, li=
ke
>IOPL emulation which was already deemed okay a couple years ago and merge=
d
>into the kernel)

If they want to see them again, just:=20

echo 1 >/sys/kernel/debug/clear_warn_once


--=20
Kees Cook

