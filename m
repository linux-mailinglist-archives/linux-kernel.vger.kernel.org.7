Return-Path: <linux-kernel+bounces-894151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28B5C495D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DF83A2716
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6222F5A3D;
	Mon, 10 Nov 2025 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6de3lZi"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE352DECAA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809061; cv=none; b=VOzkBybQdzmVa7mXSuab1fvm6P/IBRsxXM9nK43ZcM7fIvwCzbpjlXsqMu/UAN9Swjr3oSt0vXvWexDHPs6BAmgT2DVVIs6e0t+fkyS/HF0Kt0HEmbpkFCSuxSqZF5HMMIhF3zHZWelzvFhVzlKYDbteb89nPsqEZe+/aTXiXFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809061; c=relaxed/simple;
	bh=5A2x3M04AnvOkfewgoNI3cPsxt1f+pgjuFoeucr4xmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LShFtIynBKD0/e02NRuOiQdHOJOSIa9Mu2fS2Jz/sacGu+pPq3Jz/zMy1TgSZdmBjnvD3QdbcK8Aci6zMzXHaB8xofU44p2jYBDTcGV8O6V2kBP+H6MySTgOq1UsITbu/W2yFdeNIh7WPN/iZMap2he+26arqy3jvpkSRMuyId8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6de3lZi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477775d3728so18736135e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762809058; x=1763413858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s6pHR7F03/pIPTipT8rH7/Q5PrxczVrwgluDM2gAtnY=;
        b=Z6de3lZiYReXuMupgfzhnV9WTGWgAPWxTS8srC62Cr0D9/m3cBsc8alZtHT7yxHnU9
         MRIY29lNOyK/Bi3HkKVQV8MC7eP9pkLazzDz5r18lJLseAiPNCWaSp1LopT1Thp//XOW
         qqAcRMVU322Qmz4aNV8hcotcNMyUEIfWFVtFK5VwM7VKRUMKRXO07oG0XVb3d6jIY4YX
         fT2aMA2RZryGa/ni4E2QKzOpU3zYOgkx805sL+yyB5uBmtel2vMMgZneRix8lydvWTJX
         PiAAerCImqQUD+menT8aLbl8OC0MB8oBKjEk1fkwjVq9WwnN7lm48XqsE24/6rYIW4L+
         672Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762809058; x=1763413858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6pHR7F03/pIPTipT8rH7/Q5PrxczVrwgluDM2gAtnY=;
        b=SoVPwkXYkz1Mr2i6kMj7I8Rkzh4PLtF16aNlQriRr4XAFjdxxzntbygZcgMrATR1bF
         FW1LU+765RKVP6DTorw2o8T2c50v3Z8RGM6ldXMZJ0Wy28xqaJE+RJ9dZGYNNZy2LciL
         MijBQa9CecEGD5dS4UX0SK/kHgcxE9EJyN6urcn8QPKbGyHg9M0uNFfGaAaWplqWc4fw
         lKvwybAioS8cQu8sllxGU6ex0GUNIlQcBqrGaFfx9CgwS+q54TA47fw+bf/F/k9xaCeO
         eOihW6yj6QGlXJjFxsAFK5TeiZaOOX2NoJV2n4ZIcxMLRC7d6gaW05lA1ThZIVvIw1lF
         D56w==
X-Forwarded-Encrypted: i=1; AJvYcCUXEjTrUyq0aAt0iFvCXUHzTmHlmWLEUaX83YvL6L8SfI0QjbsKivo0rJ/baOAysGZinPqYxdkoG7Ktz6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHb7s6XEA5KL/EEx+Yra9GAAPq8NoVLr6qnv81wq/QKBJhJWp1
	phNR8i5Td9PTAAL5gSoS3jP+PuMlp8RK7O6lG9EmJ5cPZKNr60TIaGg7
X-Gm-Gg: ASbGncstJWsJVlh7+1Iush0G7Ixk/9WEBxbMHG8wW8FWpBs0qcPt/u4XdRdROtVOeEY
	a2aLK+g+O/NAC0DAK/Qfu/L6CkIWlFDHJLerDQC0jUtnrmqSEwZDU3jK86E3eBxaYg3mnT1HufB
	9pzbYag5lIm2HMmWk63zMslFMe8lbz/ROl3S4iVupEvVOZtByx8tm0XWujKQM9nS5SyXbQZ7N20
	7RpVtXPt4WmrC/GFqTUSKPclFhbJtKikf958xrbMgutSdRWHxHil71cTqlVZFY/+xlCRQIuCi3R
	r4Ha2Px/O7jSdhm+Svu1OHZi4NxLAbZmE8wI+ydETS79e8sj9dC2qAySDvT1hc8lsO+kqUYnh9Q
	HGRFvJufjBggXY1hd752Nhy5HGb1j4tOr6JDlcfdz/fd0yeLubXnZyY7O5TJFp7N2Lsh0LcVUmP
	pxnyzq
X-Google-Smtp-Source: AGHT+IGoIT5w+QUViZBORjTwCO0tphc5Rsw+ZwM/XoSTGH0I5syp92nB5jyHfqFFdSWjwPM/eSjHXw==
X-Received: by 2002:a05:600c:4c98:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-477755b5694mr45928235e9.8.1762809057974;
        Mon, 10 Nov 2025 13:10:57 -0800 (PST)
Received: from osama.. ([156.223.120.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47781d68e3bsm1181165e9.7.2025.11.10.13.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:10:57 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: maz@kernel.org,
	oupton@kernel.org,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] KVM: arm64: add missing newline to sysreg init log
Date: Mon, 10 Nov 2025 23:10:51 +0200
Message-ID: <20251110211051.814728-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

missing newline so the  message is merged with follow-on logs
the change only affects console output formatting, no behavioral impact.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/arm64/kvm/arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 870953b4a8a7..156cd1a6106e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2845,7 +2845,7 @@ static __init int kvm_arm_init(void)
 
 	err = kvm_sys_reg_table_init();
 	if (err) {
-		kvm_info("Error initializing system register tables");
+		kvm_info("Error initializing system register tables\n");
 		return err;
 	}
 
-- 
2.43.0


