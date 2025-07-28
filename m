Return-Path: <linux-kernel+bounces-747573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B36B7B13564
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C491F1897818
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFF5215F7C;
	Mon, 28 Jul 2025 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxAidLiH"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD219E992
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686922; cv=none; b=n/nRyVGZfdddAE0j/HgJ6IoOUGHx2LiIj5I2YQnh6coMgHVOszv0paNt78yKiSPGwo3SzV4iiNtC5JK1BD1agjhCGuK6LbN1ll1WBMT6XI0fayvj07kKknxt3z+9VjcYGmB/dnPCPOlQ9tNYsnsF3oGfO6fu6eTS/mPDQMGt7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686922; c=relaxed/simple;
	bh=Qu+DbYB1mcrZ5Kxz/2iCKbV7l5qicmShpukOPKfJbDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVlgEpiXMCM/ldDX9KvH6cykV5sIfuY24hd3dQew74zZkXTvmiLNNZVrOebC9Ho9O38t597Q9OCsFBahiZlMEHuhoQTJ0LGy1IalptqxIy90O3+t1SoLJ8c7YKr6QCBxZp0uMNJvLiK5k7mOvUG8DPBkZ7CuiNDz7Ks0KL3Wtew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxAidLiH; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31effad130bso358690a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 00:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753686920; x=1754291720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4TfQbNtdnmYD64u0Hy5ONSsQ+kBtDvQt5E0InoDD5M=;
        b=dxAidLiHP+VXlGO03pj9ytbIWeRMBryen61nHAegbYzS+ZqMYGRMflT9VO24PQWTK3
         0cl4V9eiXK6TKjt1hxSetLeAUFz+hXNXZklH53KoJICmDaqnqIVXCU/QXpIf9zxFVtpH
         ujNdhhgsvA514wMZ/Q5WlMwo5UWGiCJCnDmK4SSmrrLIBEKsj/c0hw563KtQjuA8SzZ6
         X4V5BR+MHPcyarAB2PKzJFYFEfQ2vukNJDGqMfUuu/wbqM3iJ7CcQmOwUGwE5bcW6caJ
         HdBqkqn23tnra7EkLn5OXz+Ql6n7NP4FIpsxPcQM+E3JXBYHz3y/jMxrCpdUO03R0Wke
         poIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753686920; x=1754291720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4TfQbNtdnmYD64u0Hy5ONSsQ+kBtDvQt5E0InoDD5M=;
        b=oIO3ThqvGiLbIgx0b6A+Wh6UHdD2MjRqWus9ivlp+pt3mk0d/wK/rUE34VG1dybtRt
         FzNGU09wfaPxBMOz8ZDsT/09nMAkr0X5Rkm2O8b2nljZPbSne6HoVaZ6mWspKwUwjnbW
         F9yfRGcWnJag/NrssO1CJ2Gt733bmzIkrDBux9mcLM9ynha585WFbjtUwpV0WOYJu0Tx
         ABrU1I3mZBqiIN5R8YNaookkqmR4aRE8tHReKx5jQOMYQwA4XguVfEKeb9kd69+ya+bE
         99S2Es2fLxS1+7fqtDexYxOD7x+aPadgnfEVzAPEgXqTBpsj8FMgmb3AoS/04tXqHVaW
         I3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVYa4kBxNmnDypWuJgqk62PGbF1zKODRGCiTqjDNDbiMY+oSX91/4p9s4p7za49U6pPSaX4nyuY1eQYZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7VCcQJZ4LwmqTI5KiEPDrYV8rBLFhwobO1jt/kcJV2NLmvyu
	wIXfsfhuvjrcior8H+egla33fNo/0WS2nYYQsK2ay/tejqs4lFyb+HE+i7uaqCD5U4g=
X-Gm-Gg: ASbGncuHP4ayCCnmfTKgBMkU853k9Fzw7fZ1sQewCyoiJGrOAO/eWz5tPwyrW+HqJlE
	QiRkxmrTw0mGmZ+4tJIswzwrqNOS+xuKHkCj1nX9YDMdhU2LKsJNA5EDRGPbLTRgSV7t/YD5sZN
	Aq9iQMtzsiJASeFD4Wmke4sk+JbeiGmkjrQ+mlFswOUETIKzEAR6Ons4ygHjwuzf2Ep2kczy4ph
	U/TbGFrxewmIjIyn9HYxlB3LJO0LIh/IA7EG5bh5HrKW+4YxZpHQsLb3JlQ71tU2f1bTXGnTbwi
	ba61PSIo1KbNYC5gB73SqYeEd7aIr8SzmrBhD0zREzW1zSRUcic+9G2pDPi4ORXXk8Pe4KzcIrW
	Xeo/0+jLIVRqVNjROkjJrtzZ1/zTOXZDYqh7JyU9RUvHbYpvl1w==
X-Google-Smtp-Source: AGHT+IGXJ0KnID9UZbw+fN4zd48wjafrQVEJxcSOQ1U/Ob6BwjbThrSHvvwYgUHs1ZO4rW36pVWFcg==
X-Received: by 2002:a17:90b:184e:b0:31f:12f:ffaa with SMTP id 98e67ed59e1d1-31f01300158mr2108633a91.6.1753686920018;
        Mon, 28 Jul 2025 00:15:20 -0700 (PDT)
Received: from localhost.localdomain ([49.36.68.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e7250db3csm6835609a91.17.2025.07.28.00.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 00:15:19 -0700 (PDT)
From: Dishank Jogi <jogidishank503@gmail.com>
To: geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	darshanrathod475@gmail.com,
	Dishank Jogi <jogidishank503@gmail.com>
Subject: [PATCH] zorro: remove extra whitespace in macro definitions
Date: Mon, 28 Jul 2025 07:14:52 +0000
Message-ID: <20250728071452.35171-1-jogidishank503@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleaned up the formatting of MANUF and PRODUCT macro
definitions in 'drivers/zorro/names.c' by removing extra
spaces between macro names and their parameters.

No functional changes.

Signed-off-by: Dishank Jogi <jogidishank503@gmail.com>
---
 drivers/zorro/names.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/zorro/names.c b/drivers/zorro/names.c
index 077114ccc840..3e0e428a182e 100644
--- a/drivers/zorro/names.c
+++ b/drivers/zorro/names.c
@@ -36,21 +36,21 @@ struct zorro_manuf_info {
  * real memory.. Parse the same file multiple times
  * to get all the info.
  */
-#define MANUF( manuf, name )		static char __manufstr_##manuf[] __initdata = name;
+#define MANUF(manuf, name)		static char __manufstr_##manuf[] __initdata = name;
 #define ENDMANUF()
-#define PRODUCT( manuf, prod, name ) 	static char __prodstr_##manuf##prod[] __initdata = name;
+#define PRODUCT(manuf, prod, name) 	static char __prodstr_##manuf##prod[] __initdata = name;
 #include "devlist.h"
 
 
-#define MANUF( manuf, name )		static struct zorro_prod_info __prods_##manuf[] __initdata = {
+#define MANUF(manuf, name)		static struct zorro_prod_info __prods_##manuf[] __initdata = {
 #define ENDMANUF()			};
-#define PRODUCT( manuf, prod, name )	{ 0x##prod, 0, __prodstr_##manuf##prod },
+#define PRODUCT(manuf, prod, name)	{ 0x##prod, 0, __prodstr_##manuf##prod },
 #include "devlist.h"
 
 static struct zorro_manuf_info __initdata zorro_manuf_list[] = {
-#define MANUF( manuf, name )		{ 0x##manuf, ARRAY_SIZE(__prods_##manuf), __manufstr_##manuf, __prods_##manuf },
+#define MANUF(manuf, name)		{ 0x##manuf, ARRAY_SIZE(__prods_##manuf), __manufstr_##manuf, __prods_##manuf },
 #define ENDMANUF()
-#define PRODUCT( manuf, prod, name )
+#define PRODUCT(manuf, prod, name)
 #include "devlist.h"
 };
 
-- 
2.43.0


