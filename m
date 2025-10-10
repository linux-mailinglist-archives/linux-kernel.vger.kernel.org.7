Return-Path: <linux-kernel+bounces-848833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DF5BCEA83
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93DEF4EE3AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EA626D4C3;
	Fri, 10 Oct 2025 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McUYnzHj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5026A0DB
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760133821; cv=none; b=c/aRwAmlNHr4vjeZPIkr7Eb9ZHK4AEfvkEka90rBstb8F24o8NvlDkwqFZunDWL4raoUlOE4Gj2jeR3qtusnT4Irhj2BGyUWZhLiO9IRGSi4ED8Wwft0gWNLaihj//hWc0JaFqnr7/Pd1vK0V2JQMcgoH8ymWu5TQaT4YwKihOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760133821; c=relaxed/simple;
	bh=TgFISJ1MZntMoH1hi5iZjxgC0obKR62dALr/6ANzGz8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O1pWDzIlKFor7gsHX5UE7KPpgPWwwifjH+Vp2ozZhLvtdam13l4BliLmcRWAjS1FEUVc5DRbyhaKwt4xSIqbu07Lj8jk0SlqiAGHoqdEBEyACW7uKmLdc8CZVjOnefl/ygAD5wQWiAJawgQemTg/7ZDL817uWMfN5o5DgpHe66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McUYnzHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1628C4CEF1;
	Fri, 10 Oct 2025 22:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760133820;
	bh=TgFISJ1MZntMoH1hi5iZjxgC0obKR62dALr/6ANzGz8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=McUYnzHj2bdZ8y1YZNNvSmJSFS40sFQs0Ik94NPOkd3bzJ8THdtNU0tyOK4sPvOY2
	 t2L5HBAdVvB62+UyF+GoepTKtMUUlCcHRtFvrzXjyXAOVlYZeQ8zt0dhCYoj8L/iRq
	 JuTX3r8r61fEGs20wqnOXFBIj9ovLRyInJzCcZWKKUmjQwfOQlwePxNhtaPsp/8jrE
	 VkB8T2vlytRiMdq0kZokU0Gp282qC6IzkPDrMKo+aPanLraEQI951P1pzT/QVIGgT2
	 0UPwVcHzGiACFheo3XEsL9YD6LThSk5U979uowcFQ6ozVq+KGrgbdmOd9qp3AfYUUx
	 cJY4AuVYgYBDw==
Date: Fri, 10 Oct 2025 16:03:36 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Nam Cao <namcao@linutronix.de>
cc: Thomas Huth <thuth@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
    Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: Add kprobes KUnit test
In-Reply-To: <87v7l17e8g.fsf@yellow.woof>
Message-ID: <e905cf0e-3ac3-46b3-5f9e-1356f8d2a222@kernel.org>
References: <20250513151631.3520793-1-namcao@linutronix.de> <16b74b63-f223-4f0b-b6e5-31cea5e620b4@redhat.com> <87frc9h0lo.fsf@yellow.woof> <87v7l17e8g.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Sep 2025, Nam Cao wrote:

> Nam Cao <namcao@linutronix.de> writes:
> > Thomas Huth <thuth@redhat.com> writes:
> >> Could you maybe change that into "__ASSEMBLER__" instead of "__ASSEMBLY__" ? 
> >> I'm currently trying to get rid of the latter in the kernel sources, see: 
> >> https://lore.kernel.org/all/20250606070952.498274-1-thuth@redhat.com/
> >
> > It's been applied, it's up to riscv's maintainers how we should do this.
> >
> > I can send v3, or a follow-up patch.
> >
> > Or riscv maintainers can also squash that change into this patch, or
> > into your patch.
> >
> > I'm fine with any options.
> 
> Riscv pull request is already created. A follow-up patch it is then.

I've queued the following for v6.18-rc. 

Thomas: have you considered updating checkpatch to scan for instances of 
__ASSEMBLY__?  Might preempt these sorts of manual fixes going forward.


- Paul

From: Paul Walmsley <pjw@kernel.org>
Date: Fri, 10 Oct 2025 15:50:24 -0600
Subject: [PATCH] riscv: kprobes: convert one final __ASSEMBLY__ to
 __ASSEMBLER__

Per the reasoning in commit f811f58597ac ("riscv: Replace __ASSEMBLY__
with __ASSEMBLER__ in non-uapi headers"), convert one last remaining
instance of __ASSEMBLY__ in the arch/riscv kprobes code.  This entered
the tree from patches that were sent before Thomas' changes; and when
I reviewed the kprobes patches before queuing them, I missed this
instance.

Cc: Nam Cao <namcao@linutronix.dev>
Cc: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/linux-riscv/16b74b63-f223-4f0b-b6e5-31cea5e620b4@redhat.com/
Link: https://lore.kernel.org/linux-riscv/20250606070952.498274-1-thuth@redhat.com/
Signed-off-by: Paul Walmsley <pjw@kernel.org>
---
 arch/riscv/kernel/tests/kprobes/test-kprobes.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.h b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
index 3886ab491ecb..537f44aa9d3f 100644
--- a/arch/riscv/kernel/tests/kprobes/test-kprobes.h
+++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
@@ -11,7 +11,7 @@
 #define KPROBE_TEST_MAGIC_LOWER    0x0000babe
 #define KPROBE_TEST_MAGIC_UPPER    0xcafe0000
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* array of addresses to install kprobes */
 extern void *test_kprobes_addresses[];
@@ -19,6 +19,6 @@ extern void *test_kprobes_addresses[];
 /* array of functions that return KPROBE_TEST_MAGIC */
 extern long (*test_kprobes_functions[])(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* TEST_KPROBES_H */
-- 
2.48.1


