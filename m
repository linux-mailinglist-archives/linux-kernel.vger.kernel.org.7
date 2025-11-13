Return-Path: <linux-kernel+bounces-899305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBF6C57582
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1501346A98
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5F534DCC6;
	Thu, 13 Nov 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isITHALc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A14D34AB09
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035811; cv=none; b=S2MkOxdOWn8FqDZ4xuHfuGzP/gDsf+ZthWC2w1BUS6YNdTSOdxQz/0Srm/0MxZH5FYLYUSD7gRnoICHaYkUMxdnSPdDiMqL+Lnmkjaaqfh594P6Pnl3q+T5m8Zhip8ZhuRShe8FSAhz60JIsltMniyfaeyE5n9VS/tWVl2++814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035811; c=relaxed/simple;
	bh=Qyw9iG0CzdG/4+p8EcrutwNw+cZTi8P2KxxppelH7dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itvswhBZPHSdTUfaiKwxvpjlImuFxm5qWNJiwg1+m2yzUUuo+q04RpMPXy2wy68wHfmkfyE8kcrgHm+XiRDlZqI9sQ0ZfFQJRaZ+LBw5kceYdJFxWRbEaGX1XJZws9C8zvTAShT7YC/TS27RqHSqRznPOsdEfxEO9wI3sgR1lEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isITHALc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3587AC2BC9E;
	Thu, 13 Nov 2025 12:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763035810;
	bh=Qyw9iG0CzdG/4+p8EcrutwNw+cZTi8P2KxxppelH7dc=;
	h=From:To:Cc:Subject:Date:From;
	b=isITHALc7NklYMJxudHByEhJuJyXFzRuaICLwGyGMf6B9Cvd/HzqrZjhVILD+/68k
	 Yhn8M6ja7teGVaT1qmiioaXhJ9z8zWTL+SwlQs3NqsrZ0ugMUL+Ic6akh+dm9sSlz/
	 G0gXiAEad5KQgRgr4RFJIh7A+C+Ucm053NOEYe2+XMuZkWUjln0IkPaX+rsB9x0s0A
	 MNTkR/t3U7WDrobBnCcBroVN9+kE3YYmsI5DGob6w3YozXwIHFEC5bU3ww4EWB6V2+
	 PAOkHnjczxXzz2IhiMR1lvBsBHqvS0zIr3LmThtaCLQG3r3zX1PLZ8uizO2QquIXB7
	 6Far/3C9k/07Q==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 517FFF4007E;
	Thu, 13 Nov 2025 07:10:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 13 Nov 2025 07:10:09 -0500
X-ME-Sender: <xms:ocoVaRc9dpPNy7XsCqZ5lFJmtnMM4WX_mx8BWih7Q2INPAaMfbq69A>
    <xme:ocoVadcy56l8j1C4A5hn9Mw8ckncJaHeQpy0CzqpDn8irKHYAS0cMtnZTr7LlupAN
    3WU4e5o1XZ45g0I8ck892aG_CDKG6bQeaAjZR2c5DdSp5chzOTaPYQ>
X-ME-Received: <xmr:ocoVaT0ToFbjTJeiKCss8QVDA7Uu9JGOT7QZvc8c068SLyHtXHijBtIScJSvpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeiledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefmihhrhihlucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghl
    rdhorhhgqeenucggtffrrghtthgvrhhnpeffvdfhtdfgkedutddtffegleejheeuffdvgf
    ejjedvteeitdeffefgtefgfffhffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrg
    hlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghl
    rdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeduuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtth
    hopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehhphgrseiihiht
    ohhrrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepphgsohhniihinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrihgtkhdr
    phdrvggughgvtghomhgsvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsvggrnhhjtg
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ocoVad_RkUysjHHgItcSqoczU_bUFANDm6rUW543-Sg5hOtdiGY1OA>
    <xmx:ocoVaQ7RA0hNZiNncUZEP6pI8rZeld6IJUK-oeMhf_8aIDYmaaCYAA>
    <xmx:ocoVadsBjLEpvJm9VuGHe_pOrbVMz78rCtJzFcRt5I4BrXRPei8qcQ>
    <xmx:ocoVaa3FfMoVUS7McIPXZjwKUN8nLjjdNgGKhL7Wd6fgPWXnEqmBHw>
    <xmx:ocoVaerV48TtEEygnkGz0VNIh675dfjnTDwk82aA0Dp9PFoXDYwWy1Ni>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 07:10:08 -0500 (EST)
From: Kiryl Shutsemau <kas@kernel.org>
To: dave.hansen@linux.intel.com,
	bp@alien8.de,
	tglx@linutronix.de
Cc: hpa@zytor.com,
	mingo@redhat.com,
	pbonzini@redhat.com,
	rick.p.edgecombe@intel.com,
	seanjc@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH] MAINTAINERS: Update name spelling
Date: Thu, 13 Nov 2025 12:10:06 +0000
Message-ID: <20251113121006.651992-1-kas@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use transliteration from the Belarusian language instead of Russian.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 .mailmap    | 2 +-
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 369cfe467932..0f74e16e239c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -426,7 +426,7 @@ Kenneth W Chen <kenneth.w.chen@intel.com>
 Kenneth Westfield <quic_kwestfie@quicinc.com> <kwestfie@codeaurora.org>
 Kiran Gunda <quic_kgunda@quicinc.com> <kgunda@codeaurora.org>
 Kirill Tkhai <tkhai@ya.ru> <ktkhai@virtuozzo.com>
-Kirill A. Shutemov <kas@kernel.org> <kirill.shutemov@linux.intel.com>
+Kiryl Shutsemau <kas@kernel.org> <kirill.shutemov@linux.intel.com>
 Kishon Vijay Abraham I <kishon@kernel.org> <kishon@ti.com>
 Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@linaro.org>
 Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@somainline.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 46bd8e033042..ffd964b0a9bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27845,7 +27845,7 @@ F:	arch/x86/kernel/stacktrace.c
 F:	arch/x86/kernel/unwind_*.c
 
 X86 TRUST DOMAIN EXTENSIONS (TDX)
-M:	Kirill A. Shutemov <kas@kernel.org>
+M:	Kiryl Shutsemau <kas@kernel.org>
 R:	Dave Hansen <dave.hansen@linux.intel.com>
 R:	Rick Edgecombe <rick.p.edgecombe@intel.com>
 L:	x86@kernel.org
-- 
2.51.0


