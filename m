Return-Path: <linux-kernel+bounces-894771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60545C4C014
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D07D034EDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E1C34AB0D;
	Tue, 11 Nov 2025 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm2L6LKb"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B798F348458
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844781; cv=none; b=SoNT/D/td4eupunx4Zlj8g4F7VlW4AL0jedoua7tf9wBzdXANwve4k7V+s43DyxPmdrbENEJjOCKpER2XDrpk+Do28LGTzzh7CdU/IWtvSVhF1///jZEaueMsMBzHbnD7E6TGbfaj4xTkQ0+o52Tm03jpouPaxTKD1oLzb8LoDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844781; c=relaxed/simple;
	bh=yIdvyF3gzCSmMa7JjqM4x9chXbYDzVsQAR8cg9etAeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i2VwmYOQDJxSTigT/naISfr5jxYRQnoHSCOTEp6clzJI2G59Iv1jQG8HP3yZc0UbczUPcp4ujoNKWHosM10v8ML3wQ4hWWZ2U8Lqf+3XMPGAic64+KPIL/nq7dRP17gigBpgpvNf7NR1mXLD7Yxuf94AYDoJ1iwPsoO6++FK15Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jm2L6LKb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297f6ccc890so2159105ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762844779; x=1763449579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hG8GeeNZLRMCptK974y73GVf3lQ3b5vjFabIgGEhvCg=;
        b=Jm2L6LKbgNVAlEBFNAgrBZ53xqAmApcLsTub7B1S3ihbDI7jq7ow3njPAX4FG9fgc7
         hQ9viV/htxfT3Pn2RgbuFZvI34m84t0weZguQzLhStLW3fRsHwszeaVQ+W4hIoYuiecj
         jEUdfxsoJTdRnVTsdWFAfWdDOWBiSI7NxeOIiTnWdTbkCiPyw7uVYG3hS1ZEk3UOHrrf
         eGEtkmmv8RemI7AfWxVYnjZhlpC8BxyFGoIyJjYbSctezxDSPpB87Fogw/VOfTzaWkL6
         qgOJI9plcRdwEdy2H1bsuSvcXqZKz3PzQBnGlh71QiSoI8tiS6jIeAMKerN9KJCnMxwn
         PhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762844779; x=1763449579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG8GeeNZLRMCptK974y73GVf3lQ3b5vjFabIgGEhvCg=;
        b=kbICeecWZR8TrpJg0r9gm2p8aFbQzPuHNMmNP314CJ3AyTs1cYBZUxQ10l5EeO+7BL
         HZZtQCri3i/1pUpYrlWNarMYAQmUziaPcvv/DmrPbZeY1rks74/qmVIxzWL7dQzkWyoE
         dl+OV7Atd8AX9KaOD9DAieG+hll47cUlRoaPneM+wPLkX6M5sR9dWI9UBiOyV06lbdpb
         u0aoEChRMPEebg8IGB0kEtmiLNnOg68wA24wGU7Hs9HknzKBLPjddte2k0fBLQevgEp/
         OZuj2C02YtH0UHQx0umWj2p0cE0W64+2F4/dTWss6Arg3ND7GPNNQREqaKiTAxyBiau3
         7UKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpZcW91JvnONcLxljDxPCZAzYOY0dxv9mave74EBa+Ty3BLsXVMFMrE3nuKE60OZ0LRkom0rA9b0AS87I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOO48aWlbDmKagaUie0zGDsQknkI28+fipVeCHvDRUJpH/u6+i
	/G0ByYzhGBm22K1GuTvMcg/AENbNLzbg7DeMBPzi8AAhYu7jYJRLUWsl
X-Gm-Gg: ASbGnct08ybNFWaG7cuFRjvDdbu9FE4+fIU9s1mUejo7u8IGYHrf2ojO/kW83YOVihi
	N+UxsBavmZQtiskihFaGBAZmcFOEiBLivdtbGxNsxl9ft9maQmKdxH+Nwjhf4uTayGv1ZsFOasa
	dusF+mkHLC/4YpF2ZYPjhEFWwpq5VwPjiT9iI+9SsX9g293mxqVJTdCep0pOWbMdMSkwEcox41/
	EAUEZgSF7QW1zeKnUscbuSo0Vfz7t7ovQp68ndFZGwlR+Fe1rsw7kbwm+N8IGhPWcmiQHsIEa1R
	HEmkZu2ArdNVifQJ/tPFiCdT306b3e7MfK6XBy+q5vrFS8k7vDnUjzaxWM7Wjr1JOsUAQIhZeqU
	otCzQy0sGanbn3UlvB7kaxcYn/lKJGLTUpOKf6iM8JIujN9uZXzM8rY+Hbwe8MvVs9t4Y+CM6FV
	BYxlwurnqULggPx80EPXkg
X-Google-Smtp-Source: AGHT+IFDRWJUbjlU49NMp5vrzNBe6mYRB0vkdh/8U7PMF7Hafyra6SQ728XFlvN2IRQiW++gi4XTgg==
X-Received: by 2002:a17:902:e353:b0:297:e604:598 with SMTP id d9443c01a7336-297e60407famr50041575ad.4.1762844778684;
        Mon, 10 Nov 2025 23:06:18 -0800 (PST)
Received: from localhost.localdomain ([101.44.65.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297ddde1e7esm110430465ad.77.2025.11.10.23.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 23:06:18 -0800 (PST)
From: Yiqi Sun <sunyiqixm@gmail.com>
To: sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com
Cc: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	Yiqi Sun <sunyiqixm@gmail.com>
Subject: [PATCH] smb: fix invalid username check in smb3_fs_context_parse_param()
Date: Tue, 11 Nov 2025 15:05:39 +0800
Message-Id: <20251111070539.1558765-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the maximum return value of strnlen(..., CIFS_MAX_USERNAME_LEN)
is CIFS_MAX_USERNAME_LEN, length check in smb3_fs_context_parse_param()
is always FALSE and invalid.

Fix the comparison in if statement.

Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
---
 fs/smb/client/fs_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 59ccc2229ab3..d2cf1f60416a 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1470,7 +1470,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 			break;
 		}
 
-		if (strnlen(param->string, CIFS_MAX_USERNAME_LEN) >
+		if (strnlen(param->string, CIFS_MAX_USERNAME_LEN) ==
 		    CIFS_MAX_USERNAME_LEN) {
 			pr_warn("username too long\n");
 			goto cifs_parse_mount_err;
-- 
2.34.1


