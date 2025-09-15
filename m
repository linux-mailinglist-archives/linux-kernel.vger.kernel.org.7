Return-Path: <linux-kernel+bounces-817164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27547B57EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86182188388E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080051E9B1C;
	Mon, 15 Sep 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUfIFce8"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B91F4C90
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945939; cv=none; b=fh439w9BSc+o3LwiztyJcGa6vV32a3F7SsR8sAMp5TTvMpnAHipB/6Bqae0CsP80RTrkfx/N7c9brJJSC5/T3gFSIWCUUUwg/Nnb9YR6DAukB2Gp1mTY7uOWXnfaX5QnGuKF2ewMm32dPZQHDDUa6WVKVYLe+2nwwRASa8XFCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945939; c=relaxed/simple;
	bh=Zu1w3QZIF/UOuJi2rMXKSirnN1g1yW3DTiUUQlQFlOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q3QgMVUpQncbU4zHEwcwg9Cwi99SfjyEsrFXztAJyaahdhR6n7hjsjL79/YjV+WZZwf0aF7YQnCHbPLnbepxmVVWtjU691zPTjaAm89XxPJghI3AlUOPfMRt4lBxntOcNmR3MRnO+7W4NXm1SqRn5aQYmSv90XGkO66/a6BDU1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUfIFce8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3dae49b1293so2412543f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757945936; x=1758550736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpbkITrua1vhJUKN7WiR48HkRmbVKO0hyDxhB8JjHlQ=;
        b=gUfIFce8T24DO7bGYgoIaDVBPttqw5Qb5q5fE5QqfOIo1C7sEwL1TjFvzvaX40JIWp
         8KcJgqn9F11pBxMzYFadTxhkTs0aeF/ECInGSmdGoNbKmOykYmO+Pie/R9VFWoYs66q9
         ACE3lW/ObyhpKoV1OMSGj776Cg40fmHH/PSxrfAjIpr0pXz3Ofv0bFnCkd5KMZbmddS/
         5D3D9ZchDi8Vu7WoVtRKxCs3ozQZduMpe8TGaf5GpzH4uIyBmy6stmZoBQxNkcK6+15A
         qUdOhf7Sx69KAU4HWdtvDnxMo5l2sr5OEkeL6qJZ4y7aHKAF4da7EDkoSRfhkbhP2NIt
         FkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757945936; x=1758550736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpbkITrua1vhJUKN7WiR48HkRmbVKO0hyDxhB8JjHlQ=;
        b=vhP2eL7JQ97HC2qpQTZoYs5tGwmLypNxjMlPXxDB8xiv7LLt5G+85+6KCkejSdgxxp
         uR8srXYePGr6waZ54x7Eo+H/4dGbAE/9b5Uu1aapzn925TME+WM/jEn1ebpKWhXj6YDp
         HvbiAceL7xLi8yJyEEkudUNtUd+pSZIy89nemsCpbx8kskBqC7WzuwfbLgTvYy+NF/ha
         oWY27SzvGZB1YooscUbSns5k+ckQqLeHYLveYVyDcrtq0tWZWYNeDdRNpmDu4UDHy2RS
         icNi6Xq4nmo+sc+Oob9E3MGUUe4VxdHupduigT9jVVrREcB099aqdgtIfN3tf5pq3LTq
         M8Pg==
X-Gm-Message-State: AOJu0YwKcG36m0EGWaRmGfhO8Aci3HVDdCp2vqFxqWY8wDQD5xEgvbCS
	DuTnyerB4BIZWfP2Z9tGJJSW8kctU18TggtPclwG1G1bBsDxv8AzsvZ3
X-Gm-Gg: ASbGnct2Y/eP8cyQPAqjUce13lZFz/WJi1NGnih0eIkhhay0LG61m6Q/m27d7BtdKiu
	XphacJ1XlAY1nypK1Npng4dvMtZApbm0fHFpbPmZR/Mc6IbCC2YhqlUmTE/viwgAz0PDE7IK0ym
	lFWGHRCQeGL3YIivPzycjw+hRaoJCWBACDYVfAHph/bmgDXh1r+cra13z8p3r34+R42KOF2UoeS
	VD2s7l6tHMAw41JApsygl9097hW0IgZHB2+BuSwEHCAk2THJufrce5BIcODsRvaZLG2C8hyMfaz
	PQVQYwGR5H0xMYVV5nXReFo8NVWvLB9NptG5WjF2nwybnRsdfJFas5ytKXuCf/Xx+4RKp/PK6Ld
	dmnWJgNUBYAQDYcO/iTuv5jzxIilMjibWUbC3LLUM1Ek=
X-Google-Smtp-Source: AGHT+IHYmgT2onMqBufUPZRupmR3CnSUVb0/r+MRCOJUXUaouM7O2XSBxIvDmBdJHyG24thxg2NLpQ==
X-Received: by 2002:a5d:588f:0:b0:3eb:9447:b986 with SMTP id ffacd0b85a97d-3eb9447bb89mr1990966f8f.6.1757945935851;
        Mon, 15 Sep 2025 07:18:55 -0700 (PDT)
Received: from localhost.localdomain ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037b9ebbsm191083595e9.11.2025.09.15.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:18:55 -0700 (PDT)
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	mikisabate@gmail.com
Subject: [PATCH] powerpc: kgdb: Remove OUTBUFMAX constant
Date: Mon, 15 Sep 2025 16:18:08 +0200
Message-ID: <20250915141808.146695-1-mikisabate@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This constant was introduced in commit 17ce452f7ea3 ("kgdb, powerpc:
arch specific powerpc kgdb support"), but it is no longer used anywhere
in the source tree.

Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
---
 arch/powerpc/include/asm/kgdb.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kgdb.h b/arch/powerpc/include/asm/kgdb.h
index 715c18b75334..4c0afde87e97 100644
--- a/arch/powerpc/include/asm/kgdb.h
+++ b/arch/powerpc/include/asm/kgdb.h
@@ -25,7 +25,6 @@
 
 #define BREAK_INSTR_SIZE	4
 #define BUFMAX			((NUMREGBYTES * 2) + 512)
-#define OUTBUFMAX		((NUMREGBYTES * 2) + 512)
 
 #define BREAK_INSTR		0x7d821008	/* twge r2, r2 */
 
-- 
2.51.0


