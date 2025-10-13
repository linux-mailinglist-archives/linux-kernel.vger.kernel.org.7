Return-Path: <linux-kernel+bounces-850363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54687BD29FA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DD3189A873
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F43043CF;
	Mon, 13 Oct 2025 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jqRitX9V"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D7B303CA8
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352508; cv=none; b=s5p4a8T6077Iwfo68wsTCc/FCmKI4KbpxZ9XBqw+duOvP8BTC6pNoGl3lsvnV4EO857oTejqz0C25rF5t7w7EnvVfmVnhZk3TzFWDXL+zuPcyV8jq2WpAEAbcQWhM1xfzaW0AVbGPLzc/nNhm/r12QK4LLhnE1rASGbYXpZJjOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352508; c=relaxed/simple;
	bh=Mrb4l4VwFe57hHJrtEKqjD7k2DRvwUiyKeXgdYmWW80=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kUgb14yDRRRCR7tuoOaHK/kzXSyamp324bbcUt0OqsxcJQfbTvHNfFovjZJOBo14BnmHTpjIcW2r6jCS9VzStegGQCqlkClWCh7c/FG0hR4hQ3HDUGVyH5/aQFypdMq/S/KADbl2Cm3O6jSvaosHp9I/4sJ7eQn4NgP7tb1WsoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jqRitX9V; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760352023;
	bh=Mrb4l4VwFe57hHJrtEKqjD7k2DRvwUiyKeXgdYmWW80=;
	h=From:Subject:Date:To:Cc:From;
	b=jqRitX9VURvOh/X+D6KmLllRbR5qXzGLVkVNbzpzPiqNe5YqZwKjDbJMOCU9FShYX
	 hGXwBx0vuSGkPhOiaLj4ENKrBfEMQ4HV8E9du1RvIQVQsSScJW+Fz7SCvv4bTvVQyl
	 9zZu9gHGZkyUPyeIUuS2Vxuds/J28MBWMjms7w9c=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] x86/um/vdso: Cleanups
Date: Mon, 13 Oct 2025 12:40:17 +0200
Message-Id: <20251013-uml-vdso-cleanup-v1-0-a079c7adcc69@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABHX7GgC/x3MMQqAMAxA0atIZgNRUdCriIPURAO1LS2KIL27x
 fEN/7+QOConmKoXIt+a1LuCpq7AHKvbGXUrhpbansaO8Dot3lvyaCyv7gpI1MhAJGJEoGQhsuj
 zL+cl5w/8o6FsYgAAAA==
X-Change-ID: 20250930-uml-vdso-cleanup-001f600ffcff
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352023; l=731;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Mrb4l4VwFe57hHJrtEKqjD7k2DRvwUiyKeXgdYmWW80=;
 b=2WLmEd+A409WrKyYOGq7GyoCqX0zwTKy8RyVV4NIe9KNr8PVNUVCeI8I+19FqeJU3UNOhdnOg
 dW1JMehNlvOB+lWb5U7l4dhkbn7QdSToim7BF/DXiB6Eur8LPvU6HaY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Various cleanups I stumbled up while looking at the UML vDSO.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      x86/um/vdso: Fix prototype of clock_gettime()
      x86/um/vdso: Use prototypes from generic vDSO headers
      x86/um/vdso: Panic when vDSO can not be allocated
      x86/um/vdso: Drop VDSO64-y from Makefile

 arch/x86/um/vdso/Makefile  |  7 ++-----
 arch/x86/um/vdso/um_vdso.c |  8 +++-----
 arch/x86/um/vdso/vma.c     | 12 +-----------
 3 files changed, 6 insertions(+), 21 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250930-uml-vdso-cleanup-001f600ffcff

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


