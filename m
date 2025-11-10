Return-Path: <linux-kernel+bounces-894265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CD0C49A31
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CFD44F455D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C10B3321D8;
	Mon, 10 Nov 2025 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z040SfpK"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D729E325701
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813983; cv=none; b=Szz8OZLf6Tt6//3bJy6VSasGSEjM+7XUr8Deu520RlQruY74WPceSkXWeX/I3WhEfFEPR8PWJwHVEHqTY2bn9JLhgmNW3H8aLUeb9sYQGWWZsSGQZBDNSZA3K7y/qe9pThJf9KuPF6/djAPtbkVseXNOZEDGLEV1yeFjhLkYOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813983; c=relaxed/simple;
	bh=yk1yYuYmjJsC5CDrVftccmHeyS7L41wSj9mPTz0Omhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aY59rifF+zCrdejQR9/l5Y47aPwpobbEoFVSZk4VoPS1zg+z4wAGJQiNzRtDJ71WL+hZzHYfqwzUACSuD0ovGWsJLWRQ97LQ3/Vlbu847fUM9KoftwmHUDBv6aHmaLWMW/k5DKOwl+YrM8jbJ4HVb2bFNFvRRK9DvNQ6EHAXTxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z040SfpK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b727f452fffso38265866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762813980; x=1763418780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UyBpCGifQVlJDpCJOaH3WD1JvZJofmloD1dzHBacXxM=;
        b=Z040SfpK/yVsfvSZoUuWBnQFv0UHr4BF1yzLj4yAovlK8KrbbPnpZH0gtjUuxTdBkh
         jvMiGwP82Fx9m6/Epk2De1JTr2upc5Y+cBq2dHx6rA9GhA4xKf+260+PnQkMDKIFF1yo
         nXwchIbmLAyQR6S6Y/L0Zm6LmdvqluaK8pdd2AS9j6jxKHG3Ica4997QJJLsOYHKqUZu
         WXpkdq2gJWvpdZ01lT7+zMryoDD9CNP4gQchI7GHJrsuZDtcu32TKWurGIiqkiU78+oJ
         mQoHzGy6xyEd5C66gulZa6VFY7qaRCkctQo1lGqMAhAoxwLkkT4m/BGZUnLwGaDUIov4
         VAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762813980; x=1763418780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyBpCGifQVlJDpCJOaH3WD1JvZJofmloD1dzHBacXxM=;
        b=gdndpP+LCPzhxQRa2nijvIr6d2JFob+I4IskNqaKBvB+/X9hmmx/G8RnU4u5pWw10G
         ujDR4u3hOz0IM7k9UaDriP2H0uoSrVKRaezdEd/tLeBg9k2AOHezDRRCb5yY9UDgAKXJ
         jHxwaR2gBe4rN+1/eOBNP3DpA4+8jJSlBR5h9Z0gT0SS8SWtTHHr2na3fYanahTuZPQm
         Mne/+tyu5EfCG+1/aa0dPli9v/H9takEgVKccqHl9fGg2FRmAsqa5mLkrGj93pbcHwGp
         E5e98zKdaN7yOpRLCOvS3amn7fEGtJt4z1+481gQyjvuPYjAez7hGZ132pNRNcd/xn3O
         nVAA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1CjW2ptIkxVzqmTy3LOwAhZhxlK2Pr5CfPFnD7jVXkQU3/nvO0fSOC52wvHGCtoRWZSDP5ADHitqtoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDEryBO79rmdTRze5a0n7EGF5zrqtMThnuvns+I0LPTkTMDVwh
	kHvFIa0y+rrCWsPRFQopJ0QQTJaa9Yea6fxhhy09Hm4gj57y3nUb2nQS
X-Gm-Gg: ASbGncvZcqLlgkodDkKve9k7R8QFH6lsRTPbJGzFbNcegFedU/2h6mkf4TecQtyYjy9
	ph4QpbFUx/bOz6Hgx/vosh4KaJ7HTjOfa+8j+xHz6O8KnIUu3wdyFSafbMc6njav/K3Gtnmuhjd
	iwEAx5grLwstptS44QVbAPUfpovJdmgNyhPo3z0/MVrKcbD4ExtxA8GWpGn1CJ04rEfToCJVTAF
	HaFjJdmtclhb1fo4sNjjmbFhiUkWkY4EXE4jSqFnZWrphop7EgMIM/NK7YJ6oVNsl4nGIt8AYRo
	mFlsctABywQ+F2uTQMH9ufUOrPBMFX/fS/GImt9KUYu80INujFYZWUJsyHisWjNzhIBCcG7pSXB
	Gucbr+0rfTweqZaiVkTgYRp8mKqtD7TEkuTkb6ZEbAxcoUyy1XHf1Ybp4z8ZI+zlGxZOx1fERK6
	TD
X-Google-Smtp-Source: AGHT+IHO6nboW+bJKkdw6mU1aOUB70KzLUlDK4XQa7eW/AJKPJ2ciXptFZBqhytjxpUTpT72XboVhQ==
X-Received: by 2002:a17:907:728c:b0:b6d:5dbb:a1e1 with SMTP id a640c23a62f3a-b731d179197mr120768466b.5.1762813979862;
        Mon, 10 Nov 2025 14:32:59 -0800 (PST)
Received: from fedora ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d430sm1255734266b.37.2025.11.10.14.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 14:32:59 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND] x86/asm: Use inout "+" asm onstraint modifiers in __iowrite32_copy()
Date: Mon, 10 Nov 2025 23:31:39 +0100
Message-ID: <20251110223247.54486-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use inout "+" asm constraint modifiers to simplify asm operands.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/io.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index ca309a3227c7..2ea25745e059 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -218,9 +218,8 @@ static inline void __iowrite32_copy(void __iomem *to, const void *from,
 				    size_t count)
 {
 	asm volatile("rep movsl"
-		     : "=&c"(count), "=&D"(to), "=&S"(from)
-		     : "0"(count), "1"(to), "2"(from)
-		     : "memory");
+		     : "+D"(to), "+S"(from), "+c"(count)
+		     : : "memory");
 }
 #define __iowrite32_copy __iowrite32_copy
 #endif
-- 
2.51.1


