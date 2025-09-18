Return-Path: <linux-kernel+bounces-822832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6308B84C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43022545A10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5108F308F0D;
	Thu, 18 Sep 2025 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QupOPcvo"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EDC27F171
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201345; cv=none; b=Oakk1D/IKSUkYtbA0PFiirA//zRG2/eLQkklxkLpJ2p/WFElBg0b/amgw7lPuoLOipxlGith+Z8N3Hj+NADWFS4POKV0bBKta90sbfaCgJ9NGJGf89Mn8d8YcEu3CKCB1fmS3XOExBML/ig619Wb6XXKZrzZQygSKid3MKjBhCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201345; c=relaxed/simple;
	bh=vCwW3fPtoB+FbX1hIE9ZZO2T7qCinTOaCrEh2NsxC+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4GOp1Obii6ObDAaFaZcfPdAkscRCy0tNV/MfGV0TaH2VvmKQPsdduAlvRBe6imJIlCxTsb20iX7QwCS2qAw8w9SWBXOI7vaBNg2gmIioqHBgEDzdb3cW6ferfuGUXKhu3LuAtlJljWojcsRvXBsficb3mJZUX9RJW3OAn3uAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QupOPcvo; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b5488c409d1so677769a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758201344; x=1758806144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yE34uiJAxjOCRXMZb/gdhVBd/0cCnsnfIfmCkzSAFk8=;
        b=QupOPcvovHnbrAVMbi2CBDv5Rdo6CyBlGgfHFaNTEnLmktwdkfFeYvjBQvM1IPt/Q3
         4c4ncE6OSVoJxf2vzeL4SmXQH6tGiTF36BgKYFXI12ERdaXUREettRdiErgtcZhgTSpV
         O7Rc4dODBg2gfGRQoowzCh0qYZdvHFI1UEYMq03F45lDyo+PwxQ4JTPc/dO3KLhjr3zf
         WK94K3sCwEiK4V7+4Xam3wmfipVYG2x6XbXY6pLuRXUjU1kV687OBMtzaeSZcWMp/OWz
         Z5OFRq95WBzmPmCoMXVAX2Fgq25TCBLJChD12QdEqJXSJBU06MdFYMiGegMbJwWdlXFe
         dtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201344; x=1758806144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yE34uiJAxjOCRXMZb/gdhVBd/0cCnsnfIfmCkzSAFk8=;
        b=PFQra+T67ic4f+TBnoBFFVv9lg3ztNIv9K0E8flehlqPCmkSfXGpLjG4pzpXWMH/Ns
         bRT2bxyUIcLDq6NfSxkZMN/xAWJ6Gcf9ZoKPDq4GkjGj+O24i14vMaB1YLTCDGT5cxqE
         v7DzKyyhUK8W9l1Am3HsQbEnebKp5YdKrrhe/9rsK4apYpl0pe6Tano88rNt3XuHY9Fp
         aZ8wyXZjkjdKQqiuvMq2rM6GVDOwwErtPwSwnOhccSB73z3xrHBX92d6negnwlcNmoe3
         oa9+ZO8YnZhwCZYFhV8NEWiIaQkdL9N/5+GHoAtKZoMoOuU8Of99nf8XlSh4P78Tek1X
         aWmA==
X-Forwarded-Encrypted: i=1; AJvYcCX6pNYNoJcYphPuRW95epYcNSJXLnfnWanj39QPdyNp+Otz0fnge7ljreJYfKUXdtU4C/TyUgKQFteVzzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwWPNCmFoK9EAPKgU0MJrpZvqRSYH+icuiyWXhmHHpZMeHokyr
	s/aQju6L9pbIcb1JGceFCRHOATq5QrAwH4+LZOoqAa5Auxs0qvr7i6/Z
X-Gm-Gg: ASbGncvT0MRBUD4R7ibX//o9NVO8pPcZ6EUt42kF+sPZJyL+ESc79UGsd2+BZhc/XXm
	Izcw36O3qy8Kf7ypunl2MsR7iXosOEGbDxzHGRal3f9j/LvR9Dc/O/FZ70xZFZ1Ijxt8QKB8IN2
	BEmeaeMAa3sSpJMjUXq0fzhTwUyVkHWLkcMW/sXLZm3pf/t9LHUd/Nn4rzXAYPxHrpCW0D1Bg2H
	1PExWlaB4vE1HXJCl02AUyXVkFPXRZ4gYsNEJIMGSGTy8k9w9IjvWrwpjBqps0M0fAlRLsApGoO
	K+pbztaBXOlFyoFGNbv3arHL6SYRtXpttf02lwl6SrbFgs+Ox/2JKNUt8QpRh1evO8QZzHxMFsU
	0+ncbVUhsqIfGVRybFXSopS2fdFjpk8Cyln9Slzb5Uw==
X-Google-Smtp-Source: AGHT+IGsMo/8lQqefuavLtapLE7AECgG8b9jcfsyTOPdN+syxzbumlh0WE+7dvjsyXF6z+BpZPP70Q==
X-Received: by 2002:a17:903:fa4:b0:24a:8e36:420a with SMTP id d9443c01a7336-2698aa45676mr34911085ad.40.1758201343497;
        Thu, 18 Sep 2025 06:15:43 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:c81b:8d5e:98f2:8322])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033ff66sm25343095ad.133.2025.09.18.06.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:15:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	"Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] powerpc/smp: Add check for kcalloc() in parse_thread_groups()
Date: Thu, 18 Sep 2025 21:15:13 +0800
Message-ID: <20250918131513.3557422-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing it to of_property_read_u32_array().

Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 arch/powerpc/kernel/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5ac7084eebc0..fa0cd3f7a93c 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -822,6 +822,10 @@ static int parse_thread_groups(struct device_node *dn,
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
 	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
+	if (!thread_group_array) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
 	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
 					 thread_group_array, count);
 	if (ret)
-- 
2.43.0


