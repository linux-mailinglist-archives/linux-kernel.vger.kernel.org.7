Return-Path: <linux-kernel+bounces-878984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A21C21E92
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F8F401EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2862B29A9E9;
	Thu, 30 Oct 2025 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dw6mKfdj"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF04274B40;
	Thu, 30 Oct 2025 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852030; cv=none; b=kRWCVHGDGqQCkhXZsGmHSMyoHIvATjNjKpj2JIulReWTYzSgMkWDDnrxo4FEY31N4O7u1tAOtZTVMpb+opSQdlQsXHF8RrOqtlYWsNUFJdWeOxJ9lCQLRdNxuvpryDSIlaSRyc78+c9T0gzz9e0dygy99gbl9oGl7eTPf1f5b6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852030; c=relaxed/simple;
	bh=e5+nOD5ChcojpjB2P0akApsJaj2p9Mx7IW/vJoeVMUU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gV2O+pRbYTUwW04LuS0T4LjkIhoVLq7qu580mQSuI3rLYsyS8DPN87gM0HUq7aerNqhbjjvaVdgTWxvELlE2CAEyR4cDskDuiD3did67RS2PKj6eJ31wTYbte3UoEub2tVvnq9iGOeV5TslnJkEY+k3+3Qhgang2S377YAqgr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dw6mKfdj; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761852011; x=1762456811; i=markus.elfring@web.de;
	bh=Ez+rWdlJxXvTuZxuonAYjxuORLmLCaLwGK3tecXKsxw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dw6mKfdjEOw1ZBcAhjaD1/ldWN2xZIbrYmXT6LMACL+z8LebrKcobmXSlggPzLVb
	 rVCfeOS1XIIDDrmPLDxCJb6I6U9k9cvNkhLtY47M3Wv/pDdqdhdcgSICZbGJYI0XH
	 O7eZdqInWQCQmUbNqyp/ewBccPeACgd4eE2p/o1rg5HgtlRaFpjcC8BnPnjIQx6QQ
	 nddNqne3bonZucwm4Dj8iFlb/5aJNVhdrfxzwdwFm6mwEXPaEtTonFBFKHmO03kaB
	 80VJw6cPY/Ke4pImJrg+q7Q+axOdxr/Wsvx68Wjwu6eNjIyLHzYn7+dwuxz5lsayC
	 0dxRHjE5qIGnA0PseQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ma0Pm-1vkTB10Qjc-00MF2u; Thu, 30
 Oct 2025 20:20:11 +0100
Message-ID: <a87dd5ae-2143-4de6-a3e2-9c1f16a001b1@web.de>
Date: Thu, 30 Oct 2025 20:20:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-arm-kernel@lists.infradead.org, Abbott Liu
 <liuwenliang@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Ard Biesheuvel <ardb@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Russell King <linux@armlinux.org.uk>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 kasan-dev@googlegroups.com, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Miaoqian Lin <linmq006@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ARM: mm: Use pointer from memcpy() call for assignment in
 pgd_alloc()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V5RoG/ey68k2qK2kiaYUN5TMTUEk17nuNumKA1tewu3PWEXMDdr
 jAkFMlPire2Kstbv+BzAxfw+ehgbWiQ4HOxUiaSAaRX2BoOcoJ8UrEBejqlusCsEQZvj0gg
 lUdK9YIvBQq/mNmI1sX0GU0iySPG3EXJn2MSDvwT2cci2ietk4GijBuW3zGWBQEdB77NawD
 pKLGCYU9UO2qcuyv8WQTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:11VWYgs1VrI=;eCqQuk++6n11VUOPwjS3vVNuXb0
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 30 Oct 2025 20:08:04 +0100

A pointer was assigned to a variable. The same pointer was used for
the destination parameter of a memcpy() call.
This function is documented in the way that the same value is returned.
Thus convert two separate statements into a direct variable assignment for
the return value from a memory copy action.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/arm/mm/pgd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index 4eb81b7ed03a..5e90faaa4934 100644
=2D-- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -72,10 +72,8 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	init_p4d =3D p4d_offset(init_pgd, TASK_SIZE);
 	init_pud =3D pud_offset(init_p4d, TASK_SIZE);
 	init_pmd =3D pmd_offset(init_pud, TASK_SIZE);
-	new_pmd =3D pmd_offset(new_pud, TASK_SIZE);
-	memcpy(new_pmd, init_pmd,
-	       (pmd_index(MODULES_VADDR) - pmd_index(TASK_SIZE))
-	       * sizeof(pmd_t));
+	new_pmd =3D memcpy(pmd_offset(new_pud, TASK_SIZE), init_pmd,
+			 (pmd_index(MODULES_VADDR) - pmd_index(TASK_SIZE)) * sizeof(pmd_t));
 	clean_dcache_area(new_pmd, PTRS_PER_PMD * sizeof(pmd_t));
 #endif /* CONFIG_KASAN */
 #endif /* CONFIG_LPAE */
=2D-=20
2.51.1


