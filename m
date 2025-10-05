Return-Path: <linux-kernel+bounces-842210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 357E4BB938A
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 04:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B34B7346898
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 02:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12401128816;
	Sun,  5 Oct 2025 02:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="E+8Zq62P"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA0B433BC
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759632672; cv=none; b=ZDXAETZ41aQSReqDs5xBHTaNY0BVzigjMagNXGVAdpxbbjzR3qwKnNTOY8q0JjDgr7cHgC5p3h/+BgjthiuQfZQqVJawKVeohRDZEUOV0rezDyuqc/IqV+mBLQ6U7RjHGquO9XZPNElOAOO94VMvBYXqCWyXKarxxEd3oeJI0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759632672; c=relaxed/simple;
	bh=qdR16QGlOw3QMB4ZlEPRhJpWolXLRul8WqpJyyEnZg4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pO2ameUX4T/LEtSlh3OTMR3pj5ZUGU6HSpmlgH9qbwzgqijmRew2418/1Uzbfd5OlhShVFbfX1FJIC+GOnDE187rqabsbnCz9jUXKzDgT+9x2yF7V7dlf1+/m1QeOalfp9rvyKlOTFBkBboKOa5vqeHW6ExWHg7TubKxFvoiOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=E+8Zq62P; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 65B6A40E019B;
	Sun,  5 Oct 2025 02:43:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xlX3i9qVxaW8; Sun,  5 Oct 2025 02:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1759632183; bh=X0lIb26WZnC4G6p5Jl3GTgsvF6Jwwmx0oWEbZcCct7M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=E+8Zq62PK6xpaOPxdESO5I1oxUGCpy4wlF2hCjBr0XUOl31Z2q96QlRvDnE6oXB1T
	 3Lye/jra2sLiI3D8z6iVmS466Ym3+Gkqwsl8JjHREInpzgE6OP9uTBUjhSRSMXWeJX
	 deOKOsNnzKB/PfMSobHfUwRI2bwP7ZBQ9LvT5CJ+55bvp4HwfZjRw312lVt5dcriNT
	 QGWEwDASCwDjva9xnVuaiCeLsgWcbEr7Su5uKlVh81z3FGZyLZ25e/Xy+kCkE7MdNo
	 lAWqZFHjeOpHFL0vDuQmu+cTOJnxkMgoIW6tNqh77T9Z6IaRSsdwP7m6pYJ61bZvfS
	 rz1fb2f0fMWUkR73xP/PW6wSADJwlvLt3RZQ7/VJeLKlJ0kTiZasGsLEx9oCxUDplw
	 vN63ErUizbYmJUQ763hkStweI0X1rq8USc+kfkD8Sd83EtZPW6sPLwpby5ciSoR3mD
	 17RJsbs7LcHjUAqyS8Z1PDpH0DDLXcfAtk5q1jCjl3DSqR5qH4WOP1x2JqV6zRVOXg
	 xfUahUqOzJGGeNsqZQUhnM+92kZ+fLT4JvtT2H2s1k4XbJOV3rY4KzQVdxGPzOqI0e
	 DGcED5exyW75BTLH7WizMoBBQpkfBEWj3vcUoavA/mhtpLq91zxeY+pCLVO6ddUAbM
	 pWhqDgfDBUBiOJq9vXgizyow=
Received: from ehlo.thunderbird.net (unknown [IPv6:2a02:3035:e62:bf7a:f880:d6ab:37f8:f6f8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3820540E0194;
	Sun,  5 Oct 2025 02:42:48 +0000 (UTC)
Date: Sun, 05 Oct 2025 05:42:42 +0300
From: Borislav Petkov <bp@alien8.de>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Alex Murray <alex.murray@canonical.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86-ML <x86@kernel.org>,
 KERNEL-ML <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC=5D_x86/microco?=
 =?US-ASCII?Q?de/intel=3A_Refresh_the_revisi?=
 =?US-ASCII?Q?ons_that_determine_old=5Fmicr?=
 =?US-ASCII?Q?ocode_to_20250812_=28Aug_2025=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251004222528.119977-1-xose.vazquez@gmail.com>
References: <20251004222528.119977-1-xose.vazquez@gmail.com>
Message-ID: <8F0DE1AD-5532-4581-9716-581FB2777404@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 5, 2025 1:25:27 AM GMT+03:00, Xose Vazquez Perez <xose=2Evazque=
z@gmail=2Ecom> wrote:
>Update the minimum expected revisions of Intel microcode based on the
>microcode-20250812 (Aug 2025) release:
>https://github=2Ecom/intel/Intel-Linux-Processor-Microcode-Data-Files/rel=
eases/tag/microcode-20250812
>
>Since v6=2E18 will be released at the beginning of December 2025, this in=
formation
>will be almost four months old by then=2E
>
>
>=CE=BCcode changelog:
> Security updates rated HIGH:
>  INTEL-SA-01249
>  INTEL-SA-01308
>  INTEL-SA-01310
>  INTEL-SA-01311
>  INTEL-SA-01313
>  INTEL-SA-01367
> Plus updates for functional issues for several CPUs=2E
>
>
>CC: Thomas Gleixner <tglx@linutronix=2Ede>
>Cc: Ingo Molnar <mingo@redhat=2Ecom>
>Cc: H=2E Peter Anvin <hpa@zytor=2Ecom>
>Cc: Peter Zijlstra <peterz@infradead=2Eorg>
>Cc: Josh Poimboeuf <jpoimboe@kernel=2Eorg>
>Cc: Pawan Gupta <pawan=2Ekumar=2Egupta@linux=2Eintel=2Ecom>
>Cc: Nikolay Borisov <nik=2Eborisov@suse=2Ecom>
>Cc: Alex Murray <alex=2Emurray@canonical=2Ecom>
>Cc: Andrew Cooper <andrew=2Ecooper3@citrix=2Ecom>
>Cc: Sohil Mehta <sohil=2Emehta@intel=2Ecom>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation=2Eorg>
>Cc: Borislav Petkov <bp@alien8=2Ede>
>Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>Cc: Sohil Mehta <sohil=2Emehta@intel=2Ecom>
>Cc: X86-ML <x86@kernel=2Eorg>
>Cc: KERNEL-ML <linux-kernel@vger=2Ekernel=2Eorg>
>Signed-off-by: Xose Vazquez Perez <xose=2Evazquez@gmail=2Ecom>
>---
> =2E=2E=2E/kernel/cpu/microcode/intel-ucode-defs=2Eh   | 40 +++++++++----=
------
> 1 file changed, 20 insertions(+), 20 deletions(-)

This is turning into exactly what I was afraid and I warned it would turn =
onto:

1=2E https://git=2Ekernel=2Eorg/tip/952df63ef426b21d6da14bb48748f12b0ae2fe=
36 - we *just* updated it and there's already a new one

2=2E Random people - not Intel - are going to be sending updates too=2E

This is a mess waiting to happen=2E ;-/

