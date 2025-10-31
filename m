Return-Path: <linux-kernel+bounces-879838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33767C2429F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 006764EA2DC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5319329C53;
	Fri, 31 Oct 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NKzmuiST"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075923594A;
	Fri, 31 Oct 2025 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903047; cv=none; b=XfTOn3nj5R7s5DuhyOpJUGHBdrlFvhyzggpRAx9bZ9wVvNltIWYNm3Hkr+9f5vm+hR45vqgLrudgcbnnFsx7RTv16o6DHe9LwMYZVzkZR9f1U3zZEHVjIGGEGoQBTWHtb0Q59x9pjuK/NOO6/jMnOAyn7O2SovmqfhwlMuQuxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903047; c=relaxed/simple;
	bh=9IClVq5T9uaOEWIy62pHV80mMMwPvKINq79C13mS+wk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mxh5lD/VujDkoP8yLRe5EkOYwYtWGq1uKtTgqfMxR+vvNWmP4cFMnWFL00DB/D3utwJNHUl99WBXgj0z5qdRajBytCrEqzqxsgIHYY8Mmp/HQxhoiGQIQqjarOVymuUeE8jqKIkmzUFrxB4E1tYa8orx+0GHwQcXnRUcw9gaRB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NKzmuiST; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761903030; x=1762507830; i=markus.elfring@web.de;
	bh=fRIri/A2G9yGHtMxY4ei6ZQvUhASGmShXEELL4cTv9k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NKzmuiST2UwdBhOqD3k1G6XrlRFfUDekxzL/0hqruumnaVKEjn5cPBqfrelH3Xhy
	 SjwP9+gn4Zetm1ncd/ryeL+YLNmY7jKRyj31e6kM0L5Iacp7mcVD8yj69R8VQIl8P
	 cBR9UOW4LSPB0Pm2WFpmWkphawyHmD8ym7O6F6NhrBUgWnKvDvOc7RbPRN094GfCT
	 DReyJs7u5qdKjDLQs2lpqXLHqHA/hgFfvPWswurFqn1Y6G40Ou4lrgF6M2c2MYbe7
	 N6Eucs4iOY0Mgmpxk1pnkgKE83PJ2/RcM3wQlJ+LsBaICY73j7lgeo/AQzkHk1Rak
	 0RnpRPfn0+E9zNzn6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MREzO-1vZkmn48ou-00V0KN; Fri, 31
 Oct 2025 10:30:30 +0100
Message-ID: <33c148ea-e1f3-47ff-8ce5-42a31a545b33@web.de>
Date: Fri, 31 Oct 2025 10:30:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: x86@kernel.org, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
 Brian Gerst <brgerst@gmail.com>, Chen Yucong <slaoub@gmail.com>,
 Chris Metcalf <cmetcalf@mellanox.com>, Denys Vlasenko <dvlasenk@redhat.com>,
 Miaoqian Lin <linmq006@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] x86/umip: Use pointer from memcpy() call for assignment in
 fixup_umip_exception()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rOI8YK9yQTEop5QMFsGrIM6VLE+lchwAKM4pdtvMStqC2fydAB3
 uagnud8H0e2QCXuVPfFHJsDqK3FSucy+5yy9Mqql0mIxuCSRd/Vk5P0/coZsNrMYoDFPP2o
 kP5ZnAPbqDnO4fd+iJnTUjLZqzNPjg0OkxKlDvMYQchL9ZdPQbsjm9jILUbm1Mkdod+Sxzq
 +doZmCtKO5uT7CiUHrvvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UV4BqjWTp+c=;9ZIKO76qk7SGsQCimNKGpglH/67
 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
 EMICVh2Vp8HkSm1T8=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 31 Oct 2025 10:10:44 +0100

A pointer was assigned to a variable. The same pointer was used for
the destination parameter of a memcpy() call.
This function is documented in the way that the same value is returned.
Thus convert two separate statements into a direct variable assignment for
the return value from a memory copy action.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/x86/kernel/umip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index d432f3824f0c..693905a363eb 100644
=2D-- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -398,8 +398,8 @@ bool fixup_umip_exception(struct pt_regs *regs)
 		if (reg_offset < 0)
 			return false;
=20
-		reg_addr =3D (unsigned long *)((unsigned long)regs + reg_offset);
-		memcpy(reg_addr, dummy_data, dummy_data_size);
+		reg_addr =3D memcpy((unsigned long *)((unsigned long)regs + reg_offset)=
,
+				  dummy_data, dummy_data_size);
 	} else {
 		uaddr =3D insn_get_addr_ref(&insn, regs);
 		if ((unsigned long)uaddr =3D=3D -1L)
=2D-=20
2.51.1


