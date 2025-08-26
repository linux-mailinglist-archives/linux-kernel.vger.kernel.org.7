Return-Path: <linux-kernel+bounces-786365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0678AB358E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 971CF4E38B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508693019A2;
	Tue, 26 Aug 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzTkJ5UL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB92F83C1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200554; cv=none; b=a/PSnH2FVIWTTBchVAG8K8AIUwSdVMOBduigwot/4Rt9s46kdoJ0gM0kFDIS6wkf1DsFG7u6Dl6NSToPwjeM8umBTc0l9PA6cfVSCNHn2sE1RL0NI6EA1R1SYLQEOFSubjy1hRWZPfpT9Jf58Yj2msDApZvCDXl6i9ivnsnUicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200554; c=relaxed/simple;
	bh=c8PjhPCCnTgJeUpJFTJS59xt6J9KPnPZPyUlPHKDLhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTY4/g+YkuABNEfZ62K/nRp3uYelzw1Prn4+E71w68rvmQO3tCsAxCvBU30Whr/bR6GbKRc4tExyK/zxCKlubKtFCNhYK32YsAi23uW+clsjn6ia5Vbigcgdz9+7PuOR7Z/GoNK2Z1cURJV7oiosusjLmBlUIgA5Sfo3HQOxyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IzTkJ5UL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756200550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ibjPTMAiwCSgwdvKGbpBfuqA/Z8D2h5jZa+FGc831mU=;
	b=IzTkJ5ULK4L4J3mb8+TWyD01nmc4kK4ipk7EwuKHRyL6lqY7vhpKnJGLTm9Z1y0eFE+Vqs
	qdQgtnc+Op6i+eapkWEylbsqBxONPN4192IUNrIOlqQbbsDChAJgANtTA8cabb209dlVDx
	7z6+zzlOmKDIZIZWIZ4iP8TsgOvOj8o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-EtiKexvRMcy3TiL4P8qlag-1; Tue, 26 Aug 2025 05:29:08 -0400
X-MC-Unique: EtiKexvRMcy3TiL4P8qlag-1
X-Mimecast-MFC-AGG-ID: EtiKexvRMcy3TiL4P8qlag_1756200548
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e86f8f27e1so1391281085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200548; x=1756805348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibjPTMAiwCSgwdvKGbpBfuqA/Z8D2h5jZa+FGc831mU=;
        b=gEqhPX9ROu75IM2lqNbgrOIlZPWFS4X8wJCa4lW1MH1Rvtv+n7m5B+SqYC3xviwgPO
         I+z/OgAwg1UqkcJFDs7WeKn7+5auQstnGX8+jtmccIXOgHOMiii6P5jiDPft5j+FzljD
         5Lw/sd90nWWMUb630snUpJbqHJUuQpV+GP3t9MzCROqNcxlIBqSAitPJNHOE20sZbUrj
         94YpI5zZhbB3qY2MnuSlh7G8ojRFbWZP9Y/BUw7FzqhZCPQXz9tCxsxZr2olyUTGq2KZ
         ptUD6/b74WaSf+B8xIc4su4HmN34TQnTz2YnRMVOPnReXdap0PhZ/RZotu0dJW5zVhY9
         NA+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4+ar1pYuxsgGyuiWEtZQuV40rLOnY9eEQ6NVXeWv4Hz/M81dcN9I98B4G2Fdg85SuqCCQ0tcgupsqMog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwllkyQIpxBxqdweF3VjmxmXsy8s98YUg9/MnRZdQKDq70zk1SE
	x5Z8w8xUEZ74MaypEsU8BKz5opi4vohprFCno0Q5ZwJB2YqOUfxoAsnqGdh6/4KKojWPHrMrSHY
	3aaWuqroW62HNjXcU7CmPN136kkVJyAvMMFd+g1seqDDcPCMtD953H1ogJUfTmXVgag==
X-Gm-Gg: ASbGncs5fUK6MvcAhLQ7oZAz3Y1HTglaeHV9aw5uceZ+nJYgT83UyWwCB+M8txL+FBx
	TkYZ2keyxaR0UoAoekTb7BhFxNjoGeuyh417Hd3fqsX86xlFHKA0xf68y6GUm8J9K9i/ziE/wVM
	woizwE9pYaOzUOr0PkaYll5YyuXHz+EFiLoJBEyzQm0K/kR8Wr/Ec8qHXECTXsA9pt7XBTzIPla
	McLdMSoHJnXYxwLu2g3W5pDVv6aihRWUSpvTp3VKiG9bxY1EokIA5mZL+ELkFSgiyDzu58GQnhn
	w1scFjUthVr1tPF+pbxoABVXXnUYvvYRqOE7y3LpCD3M8McXulZldE4n1JkX5zQTkNLXONEW8SC
	AIiNV7c9rJA==
X-Received: by 2002:a05:620a:471e:b0:7e7:f2a2:251 with SMTP id af79cd13be357-7f58d942015mr57564485a.27.1756200548178;
        Tue, 26 Aug 2025 02:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpr7ArFXT7ZO1WWZDThLtmtRC02lQO9+8IZq21Q57x0kWr/JgXF3wJtr0chhDvtcW8744jFg==
X-Received: by 2002:a05:620a:471e:b0:7e7:f2a2:251 with SMTP id af79cd13be357-7f58d942015mr57563285a.27.1756200547767;
        Tue, 26 Aug 2025 02:29:07 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebeca23e3csm660193285a.4.2025.08.26.02.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:29:07 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] ARM: imx: Kconfig: Adjust select after renamed config option
Date: Tue, 26 Aug 2025 11:29:01 +0200
Message-ID: <20250826092901.43141-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 3f490a74a8a1 ("clocksource/drivers/vf-pit: Rename the VF PIT to NXP
PIT") renames the config VF_PIT_TIMER to NXP_PIT_TIMER, but it misses
adjusting a reference to VF_PIT_TIMER in arch/arm/mach-imx/Kconfig.

Adjust the config reference to the new name.

Fixes: 3f490a74a8a1 ("clocksource/drivers/vf-pit: Rename the VF PIT to NXP PIT")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index dc47b2312127..6ea1bd55acf8 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -242,7 +242,7 @@ choice
 
 	config VF_USE_PIT_TIMER
 		bool "Use PIT timer"
-		select VF_PIT_TIMER
+		select NXP_PIT_TIMER
 		help
 		  Use SoC Periodic Interrupt Timer (PIT) as clocksource
 
-- 
2.50.1


