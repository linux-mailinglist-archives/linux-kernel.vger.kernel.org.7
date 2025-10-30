Return-Path: <linux-kernel+bounces-878678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B60F4C213C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F6804EE66E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999A6368381;
	Thu, 30 Oct 2025 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BLTgjnfN"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC3B2EBBAA;
	Thu, 30 Oct 2025 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842134; cv=none; b=eGwohkjCniIyrDlSwFScjge+2X44makoExEmMwCuH71oWMwdab+mTcuLucxUkxdc+3ZWIskQjOU00gmeNHTM/DBZvV1zV+cZh4+U7rw7BgdpbnNqanAUPyv9XXv84iK0vJEWQI22OHZoS0vwNO4HtNghJp76/T9mvjcut9eD+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842134; c=relaxed/simple;
	bh=J+1E+iDS6P7A3lO0uZZg2MmZWn96XQS9Y1KZdeMFtCo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QluBG0QzrAWXv5/AqY6G55DI65YAo325KVOFx+Ef8o9nL5yJ1e5aeH/6kwNmLLTH6pMFjW9Sk4MzWvuIncakU5U+eS5HJjM/ErrPjWHa5X5z5v2KN5YzVTxoHcTdGztl+fgqcdmm/11hfx19aCpTGPjOnjrzaGhClWEDIiSu5vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BLTgjnfN; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761842129; x=1762446929; i=markus.elfring@web.de;
	bh=ISupMu7P7GBtERR0LzkM/epWdhXCBKb1UhzKf95RUik=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BLTgjnfNQa80pauxNkEMw6a+9RirEe+kgXCxTpNG2M9wSCa/T27kjpmvVhZU/7y8
	 /CFI6+BLe1YRw3yrwPMsY0qWp/si7i7ic+RVr+furpGIhjSVU2vul6gUoC+1YA4YR
	 gnJffY4ClyZUkZDGYiV3a/7+8fr1NZ8WMaqFh++MAt4KE6g6K+YZTDRuGyoKAcgaj
	 DmvtIsoyHlgImY4/KMwMp7N7nlMJwu6nWMVevLOiBLyNBD/lFtAmnZbWofmBJ+pQ7
	 RwtiFcPZ4tR1NTjqUbkXkESCaUV6aY2zazCkTRwLW4rf9Ty1ROc4IbtOthoYhyXA3
	 LGEB3Y0MrwJkqMes4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZHv-1vgwVl495l-00Hxjr; Thu, 30
 Oct 2025 17:35:29 +0100
Message-ID: <1605dd43-5e95-46eb-a0c6-78ff8b4d51b3@web.de>
Date: Thu, 30 Oct 2025 17:35:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-alpha@vger.kernel.org, Chen Gang <gang.chen@asianux.com>,
 Matt Turner <mattst88@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] alpha: Use pointers from memcpy() calls for assignments in
 two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2RkP4iarjNkjMV05NLN+EXufYUWe7V4Bos+LoQcGxlmAGDyJkYy
 X3GpUZ7BU2yP74aq8xsNcagmoHJ6WYiAn/4DQsf3zXzsLJFnf29rYxufv8qa2fXU74TTzwL
 o2QidhFXzC3XvlNy8duq7OuudQz0lEH5qr3tSnoGFSdRym0DjUTfBZS7JrrOhHo9B9pX6gd
 LfXAysokiMtNJXROtuoCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mc/G37Bf24w=;5bcpjZyhG0t90SSERHXv7yNGjsi
 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
 +p2zQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 30 Oct 2025 17:24:27 +0100

A pointer was assigned to a variable in two function implementations.
The same pointer was used for the destination parameter of a memcpy() call=
.
This function is documented in the way that the same value is returned.
Thus convert two separate statements into a direct variable assignment for
the return value from a memory copy action.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/alpha/kernel/smp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index ed06367ece57..8c7bc3ea7612 100644
=2D-- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -214,8 +214,7 @@ send_secondary_console_msg(char *str, int cpuid)
 	cp2 =3D str;
 	len =3D strlen(cp2);
 	*(unsigned int *)&cpu->ipc_buffer[0] =3D len;
-	cp1 =3D (char *) &cpu->ipc_buffer[1];
-	memcpy(cp1, cp2, len);
+	cp1 =3D memcpy(&cpu->ipc_buffer[1], cp2, len);
=20
 	/* atomic test and set */
 	wmb();
@@ -265,8 +264,7 @@ recv_secondary_console_msg(void)
 			strcpy(buf, "<<< BOGUS MSG >>>");
 		else {
 			cp1 =3D (char *) &cpu->ipc_buffer[1];
-			cp2 =3D buf;
-			memcpy(cp2, cp1, cnt);
+			cp2 =3D memcpy(buf, cp1, cnt);
 			cp2[cnt] =3D '\0';
 		=09
 			while ((cp2 =3D strchr(cp2, '\r')) !=3D 0) {
=2D-=20
2.51.1


