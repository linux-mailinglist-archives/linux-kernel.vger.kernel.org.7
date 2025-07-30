Return-Path: <linux-kernel+bounces-750390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E014EB15AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09BF13A3A80
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573C41EEA3C;
	Wed, 30 Jul 2025 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="D1xUyxUX"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9A4187326
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864573; cv=none; b=nj3Zuj7aVkRebZLYX4rtC3A7amDyuYb3jz2q8uF2uY0q6FQlU/s1ZdP7cg5zLaNe0LXRwLjkolPZCbVpqtYW8xnQvPr9h6n1oRXudC6yz9v68tF+ZJ6lbg6OKqF3f87LMK2sBMKLwWNboOSPgudf7pCPD06g9OsB/zCOhlRfEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864573; c=relaxed/simple;
	bh=c+k8ONlCVl0YlsBPaNzTX1J6x5OFKSYydymyWHpvq30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nnvgvMRCsgN8dt2yUJlzTKxw+yBvO/ovZNREDYaB2N7qKzOh7f9L1stH1d7fbt5ICSXcVT1fjl7BZ8pKdLclBrSmpWXKJJt5oBgK1bk5p2oPa9YphulV13+lCztYhsfq/jvzQfCaHpBA6nRd7lAST6cmjb34g7C9oHoVTQNBiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=D1xUyxUX; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753864524;
	bh=YC6hIh6daElSEWcJOptBsxGltV0bwJXNkuclAwgKbEE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=D1xUyxUXG/Z3wJfWktX6Mbz7zFoBjbH8gd4RkDVqnvKtRoTSgPpgItTNWCA5t7RF2
	 EiA9yXu5hpgyf4VqS0CR6DpJ5JQiBY7pT90FwfJzVlEyNUYg4g0d2VfqJ5eT2fITKo
	 EplWTCYzDQn4Cf96tUoXczkMEjpBxaBjm6JfnMBU=
X-QQ-mid: esmtpsz11t1753864513tfe28bc21
X-QQ-Originating-IP: WkhFEtYTQiJsJmhHi9An8eHYrDqIWOL6j/xQn/KkwSs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 30 Jul 2025 16:35:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 107627054575511903
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: chenhuacai@kernel.org
Cc: siyanteng@cqsoftware.com.cn,
	xry111@xry111.site,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	wangyuli@uniontech.com,
	zhanjun@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH v2] LoongArch: vDSO: remove -nostdlib complier flag
Date: Wed, 30 Jul 2025 16:32:31 +0800
Message-Id: <20250730083231.3027631-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NImvdRhE6fHp97mAHgu5A8fmyWLBqIsNT+1lWRP+IhYULBg1kouY7vWn
	b1agaV0x/bds+sOEaW+XU8N0Xr/p+FpYv+OJqH57xTRr4HkxLGUXxaZPFw9pUoaDcX2OMAS
	AUs3jkZPSoelYRPtkSv14B4cgXh+VejhjaUfG0b+0ZKCJT7w6nP2lMGUpUmKlAxj1v+bQ/P
	ghFAytoK5sHekCKY6+w32FASRK2BS98kT7Tx2UQP8VbkkHD4aOyPZQiTvw8m4tapsvdX4f8
	F7BptBCqfZFo7AfArtWjrHIibB1SdVQVuWVrpDt8yOznQ9//kYV/9tB1n72TYFoTQlppNEn
	d69/x/7VzmmxcKWdcwuq7BCNsoS2913PxLWIvF1t2braVBWHdlryOvt8wYrVLyliOTSrw+i
	zHzQmaC5YytF14sKNGyUt5ZeRZ+mFn3z9QSIosxdVQ0CR8SCBjlYRhHqR15zC0GYUjFqMUk
	3RbPOHUHdtGkLBBbGW1Oo8DVPKJs8xq9VpyhcybTwgfiJKs78W3wpSpVwbsoLIcufR4rHDC
	LyyvsZtfC85fqneU/api7dOFlW7Kn8/UPb6q8ebQ7sDa+GUmqbcvyjoQAeIBWc65Ml3wa56
	rnPgmgNfQyWokPzWF6puVMgLBcj8oiWO+5g8dTr/MUEOOU6gujAE1m+wna0ldRSFvbv+d0y
	xcnBog6nqW6DSmYoGwEY+aS6oPduLQWK/n3IFfYQ0+k8jfkPdtWDUd0y+RH1dDEVDnx6lJq
	GZ68+L8CwO38Emd4kxCVB6VZWC1XQryqqJmmM+CazUnb+kVZeFuBnda9FTdmVCSJEff6zCS
	xs8eujnEXxfeqy4xeK9rOghuZNg2u4ZnoCAcqauCST6NnocnBIR5Oyh/ASHspGYKUkQU6uQ
	jdR6hD8FV6lcYcF/JmVeEQiC1euxRIH/V+BjzZPrBdcawzNYF7gxriHl8DOoTDaOn5KcNxM
	TsEbAUUi4KkBgBsY8N6uz3XxYKvgMoHSdtMFmxyuH7iWTQM9YBPdiQ49Hev5El+l+zG3tL3
	Dnc8VdMz5RqEXtwjq4XG0su6dz5D5BNipF222Amf1ODsNRS33TJjizkhgIVvk=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Since $(LD) is directly used, hence -nostdlib is unneeded,
MIPS has removed this, we should remove it too.
bdbf2038fbf4 ("MIPS: VDSO: remove -nostdlib compiler flag").

In fact, other architectures also use $(LD).
fe00e50b2db8 ("ARM: 8858/1: vdso: use $(LD) instead of $(CC) to link VDSO")
691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to link VDSO")
2ff906994b6c ("MIPS: VDSO: Use $(LD) instead of $(CC) to link VDSO")
2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link vDSO")

Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cn>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>

------
Changes in v2:
	- apply commit msg edit suggestion by Yanteng Si
------
---
 arch/loongarch/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index ccd2c5e135c6..d8316f993482 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -36,7 +36,7 @@ endif
 
 # VDSO linker flags.
 ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
-	$(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared --build-id -T
+	$(filter -E%,$(KBUILD_CFLAGS)) -shared --build-id -T
 
 #
 # Shared build commands.
-- 
2.20.1


