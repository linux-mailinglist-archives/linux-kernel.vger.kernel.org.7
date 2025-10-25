Return-Path: <linux-kernel+bounces-870095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97852C09E5C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 20:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C3E04E6203
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246DB2D3739;
	Sat, 25 Oct 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OE8NXQxR"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6851121D3C9
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761417063; cv=none; b=Ak5J7YHBNSISnexqi+mUgO7/Ruj4WKO5Rt/FdivMMauXV9XdQNkCcc7nQVMMzBLclxzI0Pxf36aA1qW0Llce4KOMdg+gI4CzKBwUTGInc/EE4ldZKHMCep7+CLzpcWMMmwBFhjXKLDo2KrHqLc9cwfkHSfV4ZF8InIDhZeQM7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761417063; c=relaxed/simple;
	bh=yWBkVGNo//y95im9uKt3C7C2mYST1YA8dbepo03RC4k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=k/NLzcxMoHe4mXw36vw1AniXkwIcfRnU9NSQxU4U2CLPW0+vU+E8l8tKbpV+3gXuBvEMz4oH8jSGtM7cBMPnahh8jY9FHs3DKdH03oQZqCBiJMAt2EVdiPUpxtR13fch3SQ/R1HaXKcFQR+gwxla3guJTtBJzW63yJje8WxKlYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=OE8NXQxR; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59PITBww4104797
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 25 Oct 2025 11:29:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59PITBww4104797
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1761416952;
	bh=+WOIWjO6XmXsyaNnZAPLqdHKXgSCLdFZU1hP2VupUH4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=OE8NXQxRbOrZOSulCSksv7qe3FumT+1s7rKhYzFRpZdxls6WFCH1pN+JoCVqUgXgA
	 w9Mtgvq3p7gf/30MXc7OVLiXKctRz+VG8qVMn0nEnujd0iH5XsCTal18BepmzOMdvI
	 GbknJJ7n7LP25iC6QpgnDJbhX/jqlYGSXgUY9xGRmLftdAN/F10W6PQzm5ziI/quov
	 jemE9eHQGHhx/CsgEg/+VihnHyae3JShPIl0BHNgrSI+2Se7AzyqQjgR0lJ7l8aBbZ
	 j12Zw8NsB0AouM+rnTAds5t5nONOXlZO2rYcMB76Pc488BEdAsv7X/dWgQ/1YlZu7a
	 SbHlqzdL3cddg==
Date: Sat, 25 Oct 2025 11:29:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Shi Hao <i.shihao.999@gmail.com>, tglx@linutronix.de
CC: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, peterz@infradead.org, reinette.chatre@intel.com,
        david.kaplan@amd.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 :kernel :rethook: fix possbile memory corruption
User-Agent: K-9 Mail for Android
In-Reply-To: <20251025114830.295042-1-i.shihao.999@gmail.com>
References: <20251025114830.295042-1-i.shihao.999@gmail.com>
Message-ID: <6D2E5C3A-451C-40B6-9A03-3FBD552B933F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 25, 2025 4:48:30 AM PDT, Shi Hao <i=2Eshihao=2E999@gmail=2Ecom> =
wrote:
>Smatch reported potential memory corruption in rethook
>arch_rethook_trampoline_callback() function=2E
>
>The warning points to a potential memory corruption in function
>arch_rethook_trampoline_callback where struct pt_regs *regs->ss was
>being casted to *(unsigned long*) although it is working fine with
>architecture x86_64 however it may not work with x86_32 since it is
>casting regs->ss to unsigned long=2E Its comment says it is copying
>regs->flag into ss but i don't understand why it is copying it to
>a unsigned short which is corrupting memory on 32 bit arch=2E
>
>Regarding this i needed some advice on finding its solution
>because if we need to copy all bytes of flags we need 4 or
>8 byte memory but regs->ss is only 2 bytes which is not storing all bytes
>of flags in 32 bit arch and also on 64 byte arch it is just relying
>on cpu alignment for storing the flags which is also werid so,
>far i just added some if def condition so that it only copies 2bytes
>if the architecture is 32 bit and cast to unsigned long if it is 64
>bit arch=2E
>
>Signed-off-by: Shi Hao <i=2Eshihao=2E999@gmail=2Ecom>
>---
> arch/x86/kernel/rethook=2Ec | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/arch/x86/kernel/rethook=2Ec b/arch/x86/kernel/rethook=2Ec
>index 8a1c0111ae79=2E=2E5f6ecd6deb4a 100644
>--- a/arch/x86/kernel/rethook=2Ec
>+++ b/arch/x86/kernel/rethook=2Ec
>@@ -89,8 +89,13 @@ __used __visible void arch_rethook_trampoline_callback=
(struct pt_regs *regs)
> 	 * Copy FLAGS to 'pt_regs::ss' so that arch_rethook_trapmoline()
> 	 * can do RET right after POPF=2E
> 	 */
>+#ifdef CONFIG_X86_32
>+	regs->ss =3D (unsigned short)regs->flags;
>+#else
> 	*(unsigned long *)&regs->ss =3D regs->flags;
>+#endif
> }
>+
> NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
>
> /*
>--
>2=2E51=2E0
>

Please don't submit a patch where you are explicitly saying you are blindl=
y following a tool and don't actually understand the code=2E=20

If you did understand the code, or the architecture, you would know that t=
he ss field is embedded in a larger pointer-sized field=2E

