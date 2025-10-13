Return-Path: <linux-kernel+bounces-849855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2F5BD11A6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AEF3B232C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140E725A65A;
	Mon, 13 Oct 2025 01:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5BTaGCJ"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012272327A3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760319334; cv=none; b=N+qLLOzCsZDsUMwnfZR7oJxX/pSiypJaVDDOYU7yWpCcPjcs2EolQGu9pbulPH2HA0aLy3h7sGbCirCyG9h6Cmvjf2gWJLk63n88E11YH8jPhNUBHBxn5cfLnahcYgWUdgVkXbgXtioTMKITpyQJIe2e5Ou1OxmrmB/P8iFL9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760319334; c=relaxed/simple;
	bh=SNT/gQXeYMQbe6CiuE3g4PgI7DmGrmHhWTT1uedgyFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIcKfpFmeiu857z45qc8ZiJMw4zzZiQeXqOAmKUa9t25HPee2baxOnL/jKtM0APj3Wf5vh8DuHbgk6LP1UgE+HfvUVe2AqWqJfiVpHulkAZfu1loXhTH1VUuIVvf2xCNzhYb6z6ZwxRJrx/67wPx8KWdN2kKQ19slbyVmAdUN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5BTaGCJ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b556284db11so3325412a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760319332; x=1760924132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qptI1D+UsB6BnqEGTBrzAfay9TK/go8UORV6E6C+E8A=;
        b=Z5BTaGCJLx/63VotjXEZ/jOJHtm4G1x5RXVZJA8sYygcTsTgAaGPxwfIfMQvGK3zVh
         LnOewWZVd/vNd8/Fby3U2wnbqEpQervrho2Nc+uvUowcLp2iky1K17ghPX0Qa+wQZmR9
         /0t9aZLeTR9kQXIjbN9Sr0fCOqvOkbocT+4c2hIpypL+nQ48DjiHd6bfsY4Jabsr+8p+
         /MZugeUUgxwZJyVMrbQMJPOL6DWMfpZoNO8hFy0ugGDVueTPKnf7N74l7gQbPJvnB7rm
         Swz0GS8YQZ4EB8uKDg2cYYtMY8PQAsr3NzFAZFJMuDjusEowBIbw0hBa+68lJDYgHeZN
         2QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760319332; x=1760924132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qptI1D+UsB6BnqEGTBrzAfay9TK/go8UORV6E6C+E8A=;
        b=vo0pR1FKFnzPnDKz1DsWpvki6+DwRlyKOv6XNm+Je2yegN9BAPYX30rPAeR7ZS2PgD
         aeUwNdG+mJp22SuFEPH+JUEOlnCq2pfILgeW+CW3dMfdEOiiFGiJVioFaSzFVSP4WhMf
         LySu1NdL21f5GK1Q1qSKWUoBEucqLR9/hUNASAavjm0oKRzNrJD2rfjLRVjVAi9KUVxa
         tk+TMH2Oqz7LV0Qob1yCk0VTOHt25d40GHc+PAQ2qY/0dhwyAtHwAt9aD7/K6nuSfZ7D
         TemK+uGx2GxlgKM+bXkT2c+PkMWmurUNPdVyA0UINWgVjdz5o2GsVrY+lQA5rarV4tSP
         9PBg==
X-Forwarded-Encrypted: i=1; AJvYcCW+xl7xMc+fAl+LQNc+nFZc6Cegrhq/mDMs5hpbtL3KbpRPC4VtlY03iq+5VBoqvhOBIH3EBTX01lGBTEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTT/eOnh/2Oo2ispym5ppxUG5hkMPlKRWoZbl0uEBkR6Gtkv2Y
	ErdNNgun2XK2uZXsY/ck2K41X9ZKJn8urSeW/m6XFgUe6XNbimwRr+li
X-Gm-Gg: ASbGncvEu1wryKPIcmrp6q2RoY+srHvqsHfiFMr/g1Fg1gs/5ehRktlr0bLTogUcIw+
	8Vpha0GQx/7tk0SUVHQyLA5wTCOir6JZpW3imS2+txIAIPSFGjvnhj4H9omdd47LijaFPAL2EiY
	pI3x0y1pJvYrw6iMmgJeonYvU+7dOuvlwMIBoERnWO47h7ajMu5iGhgtBXFUnlMHyPW2rndfwj/
	v8OnpOV9cvRjcc1fdQiVJh04Sg/t+f9gJ0/p5EOpOhcJWc2/Gvc4afujfknz9mOnaZMxVs1/Y+d
	aSiW0Ntzq+n+mGjQmIBbqFmQJ9J+CmgnY01pM1obnn/schrNkrNzii9GOOGdwtiLT2JiKFk6z1J
	f73J+an5DHAvcfjmM4PlC/GAb67dOxIwNXmiLECtArX5dOtR5t1yEnReM54gXWPNocNdp8Kf4zH
	JRpTgZQC3pVdFCZfREFh/L
X-Google-Smtp-Source: AGHT+IGroTw4Ts05YI4y+eOASl5mjOVLbfKOD2hQkPWmmvN/0O+Vt+Jh4T1ULkHRoFOV/204fLbaYQ==
X-Received: by 2002:a17:902:f641:b0:28e:cc41:b0e1 with SMTP id d9443c01a7336-290273ef139mr239114615ad.36.1760319332207;
        Sun, 12 Oct 2025 18:35:32 -0700 (PDT)
Received: from fedora.. (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f35e62sm116996925ad.88.2025.10.12.18.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:35:31 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	leitao@debian.org,
	mark.rutland@arm.com,
	ardb@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH] arm64: use SOFTIRQ_ON_OWN_STACK for enabling softirq stack
Date: Mon, 13 Oct 2025 01:35:08 +0000
Message-ID: <20251013013508.74677-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For those architectures with HAVE_SOFTIRQ_ON_OWN_STACK use
their dedicated softirq stack when !PREEMPT_RT. This condition
is ensured by SOFTIRQ_ON_OWN_STACK.

Let arm64 use SOFTIRQ_ON_OWN_STACK as well to select its
usage of the stack.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
---
 arch/arm64/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index c0065a1d77cf..15dedb385b9e 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -62,7 +62,7 @@ static void __init init_irq_stacks(void)
 	}
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static void ____do_softirq(struct pt_regs *regs)
 {
 	__do_softirq();
-- 
2.34.1


