Return-Path: <linux-kernel+bounces-747088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323C8B12F82
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 14:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5A93B7DA2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301FD213E7B;
	Sun, 27 Jul 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w/VPAo+Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+aIAwIqC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185BE1E260A
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753620008; cv=none; b=bbwbNJLEcmVXCinymwirq+1UrNSDGBFkAQgMdwokGaypwH0MEunHwrAXNf4/fuWw9GOkBDGiFwmKZRXgVd2oGMgkYP4zlIYyfSVnu+IMfZcnb7/zLkzfxsFttlZKRtdkz/FL0hM9B/78hcY52Ufn9qgYuz5guAu0DyWRzQaG8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753620008; c=relaxed/simple;
	bh=ADmBBA/sidvPoRoH2mrfan+jR3VhBnGPGZ+Mq04pyR4=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=g4UAJlusOZDBNGEaRcsMvH7h1C2kzryHbNvpQFYeSwhlpBOYY0oRJMMaIY4e3RfF23nNcMP1QK0DZYSooW1UyQWy4SdMRe20iEg2t/4n/ZLMlEbA26stFPxxh8szxot5qzIPsVEqENqIZDQhX4x0kL8ITlIxslXqjtjAEUEGvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w/VPAo+Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+aIAwIqC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753619999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=NV+hbQhR2OUcHrTrxWFrSK1ZRivP69+9iBtnlXWeJEQ=;
	b=w/VPAo+ZpTqfT2HuXxbIfbHhxcxzyd6opYa/ikBIaHI89hClrIhLpq9vYfWePrentfpQUH
	1+xmqP+9TcXxXNXoZn41ViS4w2DTN6DcY31VH1tNeXtABXpETBmBQM8KWuxwma/m3LhlLe
	2wXMr8IhIAgCU1F5RHYkBLctdEmsJZ0xbflJtP/ufT4WWJB0271zkifpOEcgck0KKdlIDu
	/JMwITYNQ/Yxbwcd2DoK2Hd0YkmJy3KEv0y+ucP44w98R+A8opgCfbhlJs09dNOkNSz5FA
	Y2P7Vu3B8XAErMzelvjYdWYRrG8Sfh6vuJ/kBnQMD1QsYXrokyRdychAnrnSVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753619999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=NV+hbQhR2OUcHrTrxWFrSK1ZRivP69+9iBtnlXWeJEQ=;
	b=+aIAwIqCBjDC8NLMsFD8MYrvI6IgEr0hZUw0NcjeUqLFgK/tZNkPn5wAN2xSI4bpOCO+7P
	o9TmCQGkezpBnzDg==
To: Yipeng Zou <zouyipeng@huawei.com>, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, sohil.mehta@intel.com, rui.zhang@intel.com,
 arnd@arndb.de, yuntao.wang@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [BUG REPORT] x86/apic: CPU Hang in x86 VM During Kdump
In-Reply-To: <b31a5b91-bc94-46ce-8191-c6576c04f05b@huawei.com>
Date: Sun, 27 Jul 2025 14:39:58 +0200
Message-ID: <87h5yxq02p.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26 2025 at 17:50, Yipeng Zou wrote:

Please do not top-post and trim your replies.

>  =C2=A0=C2=A0=C2=A0 I skipped sending the NMI in native_stop_other_cpus()=
, and the test=20
> passed.

I don't see how that would result in anything meaningful. The reboot vector
IRR bit on that second CPU will still be set.

>  =C2=A0=C2=A0=C2=A0 Given this, is there an alternative way to resolve th=
e issue, or=20
> can we simply mask the IPI directly at that point?

Good luck for finding a mask register in the local APIC.

Even if there would be a mask register, then the IRR bit still would be
there and on unmask delivered. There is no way to clear IRR bits other
than a full reset (power on or INIT/SIPI sequence) of the local APIC.

In theory the APIC can be reset by clearing the enable bit in the
APIC_BASE MSR, but that's a can of worms in itself.

The Intel SDM is very blury about the behaviour:

  When IA32_APIC_BASE[11] is set to 0, prior initialization to the APIC
  may be lost and the APIC may return to the state described in Section
  11.4.7.1, =E2=80=9CLocal APIC State After Power-Up or Reset.=E2=80=9D

"may" means there is no guarantee.

Aside of that this cannot be done for the original 3-wire APIC bus based
APICs (32-bit museum) pieces. Not that I care much about them, but
that's just going to add more complexity to the existing horrors.

The other problem is that with the bit disabled, the APIC might not
respond to INIT/SIPI anymore, but that's equally unclear from the
documentation; both Intel and AMD manuals are pretty useless when it
comes to the gory details of the APIC and from past experience I know
that there are quite some subtle differences in the APIC behaviour
across CPU generations...

The stale reboot vector IRR problem is pretty straight forward to
mitigate. See patch below.

That needs a full audit of the various vectors, though at a quick
inspection most of them should be fine.

Aside of that there is quite some bogosity in the APIC setup path, which
I need to look deeper into.

Thanks,

	tglx
---
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -136,6 +136,28 @@ static int smp_stop_nmi_callback(unsigne
 DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 {
 	apic_eoi();
+
+	/*
+	 * Handle the case where a reboot IPI is stale in the IRR. This
+	 * happens when:
+	 *
+	 *   a CPU crashes with interrupts disabled before handling the
+	 *   reboot IPI and jumps into a crash kernel. The reboot IPI
+	 *   vector is kept set in the APIC IRR across the APIC soft
+	 *   disabled phase and as there is no way to clear a pending IRR
+	 *   bit, it is delivered to the crash kernel immediately when
+	 *   interrupts are enabled.
+	 *
+	 * As the reboot IPI can only be sent after acquiring @stopping_cpu
+	 * by storing the CPU number, this case can be detected when
+	 * @stopping_cpu contains the bootup value -1. Just return and
+	 * ignore it.
+	 */
+	if (atomic_read(&stopping_cpu) =3D=3D -1) {
+		pr_info("Ignoring stale reboot IPI\n");
+		return;
+	}
+
 	cpu_emergency_disable_virtualization();
 	stop_this_cpu(NULL);
 }

