Return-Path: <linux-kernel+bounces-879080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61D5C2239C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79182404F52
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AF9375736;
	Thu, 30 Oct 2025 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="B+AGGgbM"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80BB329E72;
	Thu, 30 Oct 2025 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855380; cv=none; b=ooHYjIXlmTNbDgHOkt/nmETB/kmjbYNl11u4a9r64W+V6d7z+o82p4P+tUgEvBYzh2H4QPv8Sl4v4xB8zpNSL63z6nh5pBRhnpcswHPzgd5GK9DNWrZzppwiNMLWBHmISBg6ANjxRXQX6DClV6WptAffevH9b8JEkg890OMqNSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855380; c=relaxed/simple;
	bh=yowKo7nShEw7wlPjYMHkvQdGg3GlKyxHGHjYM81NQhc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CvLSEu6cN8RS2I0vNHF+Q/gSQIi0bYuzzAnHvO7SnHtmQLIDaiPvDQDgoVBOrL8sgFZFfBkuyKvikceheszoHTTdhx1B8MQ4406+YPpt/NkDT46vPBbctcsasf9nq/nbQc2raGT6e+X3RwJhPtfdpar3d9SgyVYL/oUNl9cyuBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=B+AGGgbM; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761855357; x=1762460157; i=markus.elfring@web.de;
	bh=cAHsNtMVwc24wWBKRK3QNoBBpNkNdPaX0c4TrVubbbo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B+AGGgbMrdBg2IoARq8gD1fvvWGiVpMsznABnJR8OKHU9rlkHndpPC9W9nleJtzC
	 WTqmj/xrd2xXFBaRTTbEZo/lQWE5Hym2k9qUWSUM1bXwxuUzM8WBFfL7eKU2p5QyU
	 RUONEUkG4jze2cEPGeepHX+YXYQ0A7BEjGIo0xRIsnWdTEcbKt7OFZCXN7F/L6Wqm
	 Mrsk11gN8/V9PY/Mm5kIFtn0xep1i9qCDiyUUpoco54ZhrV46M3R+YjLArIFViaSC
	 GZ2v7dwJSmGe6MP8fnnqGoORqmOmkEjPvEXX7+rQSWint96KFxNHWNXMWmn3rPzli
	 DXjW0SL3a1DztTvPfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL0Q-1vSuWP1U7I-004ZY9; Thu, 30
 Oct 2025 21:15:57 +0100
Message-ID: <6c61cf90-5811-4450-b649-7a2c84584ee9@web.de>
Date: Thu, 30 Oct 2025 21:15:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dmitry Vyukov <dvyukov@google.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] powerpc/cputable: Use pointer from memcpy() call for
 assignment in set_cur_cpu_spec()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/w4kvdMgqHhlPWqWIJrxL4MxO5AZkrkNH/trkN0zUhCEGKGAxZz
 lGVqbHB27sesOCCqZZI+Sdg4+v8wsBNBHZGIg7WqDWVwVkrhYCbVw/CPFdSK9fDS43JL1H/
 axmq1M3xdVT24dUtp2aBGnkULXhCwNO+qwHspXzdRpHfOBcgsioCFX8YBFzq+Mb572hxRl+
 B+w2V0x4qoyf0zqSNApKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iqqW+d+XX3Y=;HATebvb5CIjUno3NtW5iCsKs8QH
 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
 erlQhcs0UjzXr3ZGg=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 30 Oct 2025 21:10:11 +0100

A pointer was assigned to a variable. The same pointer was used for
the destination parameter of a memcpy() call.
This function is documented in the way that the same value is returned.
Thus convert two separate statements into a direct variable assignment for
the return value from a memory copy action.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/kernel/cputable.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable=
.c
index 6f6801da9dc1..a69ea88b780f 100644
=2D-- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -34,12 +34,11 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
 {
 	struct cpu_spec *t =3D &the_cpu_spec;
=20
-	t =3D PTRRELOC(t);
 	/*
 	 * use memcpy() instead of *t =3D *s so that GCC replaces it
 	 * by __memcpy() when KASAN is active
 	 */
-	memcpy(t, s, sizeof(*t));
+	t =3D memcpy(PTRRELOC(t), s, sizeof(*t));
=20
 	*PTRRELOC(&cur_cpu_spec) =3D &the_cpu_spec;
 }
=2D-=20
2.51.1


