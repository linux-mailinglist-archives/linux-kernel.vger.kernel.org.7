Return-Path: <linux-kernel+bounces-736215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63083B09A24
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5835A267E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3016198A2F;
	Fri, 18 Jul 2025 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeOaozD4"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C341B2E36F7
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752808934; cv=none; b=Z1SNTbGxF7p8VZyEV4Ff1EV73CI6L7VafLpmsHdvlm2e81663JI7wrdgKpSDzIKHkp7WHX7oTxpZio5Tadn7J4dNbFMSihRs3yDaTCy7vkIvBx+ItqhwuZAJ06YRfWoNGu5HUEIz1IXGa/l61zy0Fi7vy86zwlwNzprbgP+6wmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752808934; c=relaxed/simple;
	bh=n6utyHrS1klbIJP5UqovfPWnPhkm3jElbTknWQ0KIcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=STj5AEP7sksBRMUgBbT1KzfmZwxXtMUM+98LoZvzcbcLb9memsj1C9gj9lHUHAdQNyXJjCsFaDr++QQEy7lROafUtDgfNKvFZiLDZeiB2RHF4DSRypXDTZgU/XNUZX8bHvECcbuEJIvLvXQ8n4vQA0nirWcXxl60XxEV3JUC0sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeOaozD4; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d9eac11358so164929785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752808931; x=1753413731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=STDQsD1yvbYQKJ20DIXlZqPy3dCRbK5oAjMrl9gSagM=;
        b=EeOaozD44EEwjjVfLtP8xHrz5LjszPV+YAyQDrfzTd/EYBwegJa/m/GKi9WPOTKvg/
         RooG+oH2OJ93i+YuET9fm1X6QXJoUyRdR2jsLx4+uRfB41d+8R2RWPjYZzoen3QjAsZ2
         lqK04NkczlB9jqH05L6liQO7FMTuIpqUphIp5kyWSXdgrAACghSQ7GQ6MpzXJcj8CSb4
         4Fjb/l4FQROQ0mFVx/9I8jJ6h0awQ/oO3vJGdWllnlz9WakJeI78fsY6tCLafqMg3dP8
         Y5AcgHIYYZZvqZKc4jpuOiHUe17Ug9ZN1l6ZAtAm/mhnVtHjg524R4U7eLou4u2sR3PD
         nwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752808931; x=1753413731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STDQsD1yvbYQKJ20DIXlZqPy3dCRbK5oAjMrl9gSagM=;
        b=cpm3f5he4S08Re94AWNqNC9H0fPCrZKAgs/AIWP53943R/aaxKLrjRHuzYRNknpd5W
         xdyzheZRta/TFYMoeMmqIk7NJYTj+GmST1Q5Nam8TR5BoKab72xaBVPlOEM2kbamFU7f
         HbBDxwZnCbD01Ep+ZmqwKA/zFpQBJT2Nt3xH2CwUJmdhiJlwOebRWAA+oXSbXUhqDJrg
         snXKeX4J5XVDnUrNuK4bVfVroJ56f5LWPO6h2HMzIICytCI4Z1Mwwh/Et/kCW1vh4Mrc
         0V58H0fb/gY1LVcUdZMT0tjJaltkXcnucL8eGBUR2p676OOu/PRwtotCr+ktKM/jKAkZ
         Q8ZQ==
X-Gm-Message-State: AOJu0Ywd9HzPcAAIRrVSUlJQY+jJ+tlhckD4S8u4OJi0Z+sQarpWp7ON
	X0idhhs9KZMn9BF/ruSbk21gMuBUh+s9BPGAdgYZll+YxedrqVNZ5Tz7Yow+RQ==
X-Gm-Gg: ASbGncuBDDZ7d/USlFX65UuQl7ohXs0zi7evp1cwM+p10h490TnbMdPN9OLdp6Khmvi
	7bcUTAlLpgCQMt01XXcNzi7My6Jby+UFjhC6dYW3FVlZ0WNswFaAUa9fnYtZQnBKmt3vVThqF3V
	V9rmM4cdczeV8MXzLnm7dU6lp0oTN5pBepCeaJ9s9ZZI+lifJeu2i/z3QHB/rAwKYC/2EdPakvC
	z/VX1fYTzu5H7Y0/vuaGadNm+zYW9cYw2vrlAt2h1N6gjSstwRh05T7V8TPiKSb3KrZRo0xOScY
	mHMFr/FpE9sndXM/FU54Hfkd3B2cl4sAnJMtFiFwHVBvmduqHkoRChDl8e0dQ9M/NB6RsTRgy2d
	eG4GHwtnomMmvSFAlKDsYkaWk4Nu6P+u8nQCKMl0n6MQTK06rG6s=
X-Google-Smtp-Source: AGHT+IEC6JTp/JGOhneMz1pTM3MlZvUY8Hu95wzlpk1ZfgOP6zSUG4B1xM2Efsz8n5qls4LtK3doaA==
X-Received: by 2002:a05:620a:7088:b0:7e1:a84f:d9f3 with SMTP id af79cd13be357-7e34d8c03c7mr711999785a.7.1752808931053;
        Thu, 17 Jul 2025 20:22:11 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c649c0sm39584185a.73.2025.07.17.20.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 20:22:10 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH] Documentation: remove trailing spaces in sysfs-bus-pci
Date: Fri, 18 Jul 2025 03:21:58 +0000
Message-Id: <20250718032158.172387-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 840727fc7..c0f923639 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -171,7 +171,7 @@ Description:
 		binary file containing the Vital Product Data for the
 		device.  It should follow the VPD format defined in
 		PCI Specification 2.1 or 2.2, but users should consider
-		that some devices may have incorrectly formatted data.  
+		that some devices may have incorrectly formatted data.
 		If the underlying VPD has a writable section then the
 		corresponding section of this file will be writable.
 
-- 
2.39.5


