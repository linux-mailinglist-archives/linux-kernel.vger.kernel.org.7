Return-Path: <linux-kernel+bounces-779194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C084B2F04F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD40B5C4E43
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D732EA16A;
	Thu, 21 Aug 2025 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OwS5Z+2s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pcseysWd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294232E8DF2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763012; cv=none; b=XNgj0SAe3bSMCO0fHc8Q3EJfqiYjjJ+W96YA/clcReaf0NLhO+biPq+EjTQZ51xJc3kZ8KSE2rddUIuHkG2lr4T9iRiTfX83q6sKjlQWuoW8UH+88n6Okv6x6m5v9hMkO30+2+1cweT8HIXkBgkD38URDHeW9AQCsVQiV1nyrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763012; c=relaxed/simple;
	bh=FtgeFYaDlptcACR44zN8/uEJ15VLyaL5sLAi8t0tqwg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gFfOPBaUXqUbkdE7Ap0H6Hje/ZFFcK67PPAJ2OrBJh4SGh38WIPR/RXnWHgfuBy6JRy/HM0meK1PlZx2F66eY2yhqSZR0O8VUO1+nMcRH8jy3JyWExe5eXSIjefNvlnjFXX+aSyYVRZ0Gf9BSMjNn9ZHaIiMy3Vu9itrx0QemyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OwS5Z+2s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pcseysWd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755763009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=78N5yAzXn9F4cMxhSTaeDyetjjEQj7TQb3kpzPri+ps=;
	b=OwS5Z+2sRowPnuwoMRmdCEST/rk1jg+FqeXzKunDEkEoQ/ElZ1QHyfjyNCxRxkG0TaNv/v
	HCiwqUI4MA/RgreOcaPOL1pvV1q4WJ2URLB+zKGrZV7zgf/Qbb9VhtuSqfBc5/fA869f9T
	brUYdCXzURsNfOKW9OVU6ePnTRP8DFzn7yk92gs9Fhni8+qAf1xwYfytGm3azvtgk4fmLx
	HtjhJGqzxtXAppkrCs3TnRTTVDcr2sKa89kvNRp/zW/4AHh7LXWwQlW+gDR3Ff385y7oeM
	yvyxAB05yC4/+CArYknDhQDKhPLsqZB/v8r928LVxt0tNdyuvTUkTNyRWVCeKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755763009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=78N5yAzXn9F4cMxhSTaeDyetjjEQj7TQb3kpzPri+ps=;
	b=pcseysWdxT0feFT+CR+MGviNCt1/2WmXDJPR3gu7TtTJzzPjET06k8uyj1X7rjquAvEBQp
	CoPsbF3gKF+k51Bg==
Subject: [PATCH 0/3] arm64: uapi: Provide correct __BITS_PER_LONG for the
 compat vDSO
Date: Thu, 21 Aug 2025 09:56:43 +0200
Message-Id: <20250821-vdso-arm64-compat-bitsperlong-v1-0-700bcabe7732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADvRpmgC/x3MTQrCMBAG0KuUWTsQQ3/Uq0gXsf1SB2wSZkoRS
 u9ucPk27yCDCowezUGKXUxyqrheGpreIS1gmavJO9+5m3e8z5Y56Nq3POW1hI1fslmBfnJauI3
 dPWBA7DFQPYoiyvf/P8fz/AFOR/mrbwAAAA==
X-Change-ID: 20250820-vdso-arm64-compat-bitsperlong-4f59ae7ef6e7
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: John Stultz <jstultz@google.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755763005; l=898;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=FtgeFYaDlptcACR44zN8/uEJ15VLyaL5sLAi8t0tqwg=;
 b=cQoS+W7yx1HdLENzCa9chzj4mcTqwVSeZKJmiTYpFutzIQBXQDMV8Pu/Mw4tsk3hB6r6GZ6qQ
 MemqYTqF37VBb0wqFqy7qwCqmc6oHu+DYu2hcihLlsviBu94OOA1DRV
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic vDSO library uses the UAPI headers. On arm64 __BITS_PER_LONG is
always '64' even when used from the compat vDSO. In that case __GENMASK()
does an illegal bitshift, invoking undefined behaviour.

The first patch should go into the 6.17 tree.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (3):
      arm64: uapi: Provide correct __BITS_PER_LONG for the compat vDSO
      arm64: vdso32: Stop suppressing warnings
      arm64: vdso32: Respect -Werror from kbuild

 arch/arm64/include/uapi/asm/bitsperlong.h |  5 +++++
 arch/arm64/kernel/vdso32/Makefile         | 13 +------------
 2 files changed, 6 insertions(+), 12 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250820-vdso-arm64-compat-bitsperlong-4f59ae7ef6e7

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


