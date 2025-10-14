Return-Path: <linux-kernel+bounces-852745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF647BD9CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D04CA4E9971
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01F33148CE;
	Tue, 14 Oct 2025 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk0x0pOy"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDE7313E1D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449355; cv=none; b=VqfpYV1RbIh20F0t2ehje2DzOuMzgkMjRT7wskCzMcqvq7VogQ/5SBAEJTxV4cjJjE0aK3VBf6GD4G1FF60uROdAyQqFOOKGt2/q48jUSPO3JgwF/y5vs7BqzTyfKjZV/ib/2Tjx6iEEJcruYAGVMHZpAJCDewUPs0JxVNKb424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449355; c=relaxed/simple;
	bh=yOyz6IvWmi24PN0ZdlL2ETRoY7+x5Y4h3rMkLIMCeic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MGoDSrJB4tK4yMU4dvv83H1t+7qAQp004nu0hHsbBbf/sEIsz8cMxv47vASVeQiJYsowbUZFhe3nCY9DV7IAiAHX0tZUkhzm4U21yNWbEvmkqomBjhqaE/62lMrS97clNU/k9nZ0BnPayvsk6BEBkCklaiLjvP4dE3DzZUh/W78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bk0x0pOy; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-869ecba3bd2so831251785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760449352; x=1761054152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j01C3ZF4H0h3fr2NXxsvLtO/yyM1N0PB3fovVaXYGQE=;
        b=bk0x0pOyyE9nqqBU60hBm7GZP8hoY0dED3k+VmIm7zWgii5akLuGfI8cMSJBhiZ6Of
         TbZooksHY6J59nUiLbcYk3gs5hqiKzxSd/s/wWAdOHZMInI5yZIyeGO/aiuOawAl4P7u
         egMU9VQvlN77uYurUvp9QXMr1Cb9PYMisN7iRubn9YtCu56YpgFzL9xNIX85cvrp9iJO
         PvleSrsm80ZXZfEISLy+QFQc3X0qreS1YIVQdw2dLFVx7iLuZRvegwGRcWl5hOsRiT48
         Sd4Vndg7jUcpcmaODLQAZbsetybO9oZnZ5RvJbHwin3gzkbAbO9MCsDyXTROj64/1nvY
         gxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760449352; x=1761054152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j01C3ZF4H0h3fr2NXxsvLtO/yyM1N0PB3fovVaXYGQE=;
        b=jtDfNoF2uNUg+EMrkHZiHkwOEKEhTuLaeO9Tz25vnfN29nHH8l0vNVlvQFssjAH5i0
         ByBDW90CR3ttvKpGiU0v273KE/ann3d8Q7wmFFWDDIHE5+Cqt8bXWcfkP0GM9CExUN0Z
         IN9A5m01VnKmpWNPULT0JgeuJePEqf1nhRg38HHYk7QDhpn94FUohH7TDpub6dEjeTEz
         i8U8JRMmk4n/Qxi0PV5y7b8KU5Gy84kzKHSW/1trzI2Px1oGATDMwgTg07grz8Pjz+yR
         S/uVTjyes7PUioU10E/fBu6l1z4lhFO2Oa56SLpXn9knTwiJxFRRI6VDqo8oqcSJXpwB
         TOvg==
X-Forwarded-Encrypted: i=1; AJvYcCWDMhYnLBHWy+i7KUYU4YAIk8xJ/bFF7Zy4FEi/0iBno4ikl2992StHIOaI/QqvB6nLP+LAO3DjlqlDElE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn6EX+Bv8pnfp0EgoU2oMA9rP4Zs0VXvi7wAR+cs0eYAav6QXS
	OaebJnLEps9kF6Fhvosg5IfoUmKaonjX8hxv5mkjfFqcd2qVUTolLbev/g78Eg==
X-Gm-Gg: ASbGncsHDj9Vpyk2a9vcUqLjzQj79komgrL58J9esyaw9JFgJiRMQmCvHE/VeGHfu70
	f0YupXnc1AyRpaFbK+IKJ9wtBVMn3x6nuELz1E6TrUjzmwLf/YcdxBwKMeec7nPsJUPi+fmNeqk
	qQ9lTj4KFsKOhRQsauvFDePPP46yfAPUHpy9+tgOkeLBXC16YPkCmpY16YQd8tnZkbFERm7RJaw
	MBiJSDO4wopJ52ChH41b95jcZsHkHLB6N/iT06QgSNvuKfpvns/leyadttxz8yME/cnJChRAnY/
	jT9RZaFUaJLujih7XWDAR+F2vLXDyVshT7rMg28onXMnMH+aAhnzhdCXQfdEjZQo5z+IfFILhZR
	7XSQivBHf/YCxBCc0MY2x7zxINHAvfCObyYbFJJtmTA0VhLR/D3RRBp/QQ7DFBrP44lMG8NjhCI
	P+I8A0Y9kU
X-Google-Smtp-Source: AGHT+IEwlgpPG3uvjmGvQT2i4/p6+LKOyxSTea/Iia58pq2hmmM8J3zLPgs3I36OerMcczFeKPK/uw==
X-Received: by 2002:a05:620a:c4d:b0:84b:97c2:4f27 with SMTP id af79cd13be357-883529b5d5cmr3367221385a.4.1760449352485;
        Tue, 14 Oct 2025 06:42:32 -0700 (PDT)
Received: from kernel-internship-machine.. ([143.110.209.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a2272670sm1214768585a.42.2025.10.14.06.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:42:31 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	elder@kernel.org,
	schopin@ubuntu.com,
	me@abhy.me,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH] staging: greybus: documentation: replace strncpy() with strscpy_pad()
Date: Tue, 14 Oct 2025 13:41:48 +0000
Message-Id: <20251014134148.2597178-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strncpy() does not guarantee NUL-termination and is deprecated for
NUL-terminated strings. Replace it with strscpy_pad(), which guarantees
NUL-termination and zero-pads the remaining bytes, matching the fixed-size
firmware tag semantics.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 .../greybus/Documentation/firmware/firmware.c        | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/greybus/Documentation/firmware/firmware.c b/drivers/staging/greybus/Documentation/firmware/firmware.c
index 3b35ef6d4adb..deac8584841b 100644
--- a/drivers/staging/greybus/Documentation/firmware/firmware.c
+++ b/drivers/staging/greybus/Documentation/firmware/firmware.c
@@ -63,8 +63,8 @@ static int update_intf_firmware(int fd)
 	intf_load.major = 0;
 	intf_load.minor = 0;
 
-	strncpy((char *)&intf_load.firmware_tag, firmware_tag,
-		GB_FIRMWARE_U_TAG_MAX_SIZE);
+	strscpy_pad((char *)&intf_load.firmware_tag, firmware_tag,
+		    GB_FIRMWARE_U_TAG_MAX_SIZE);
 
 	ret = ioctl(fd, FW_MGMT_IOC_INTF_LOAD_AND_VALIDATE, &intf_load);
 	if (ret < 0) {
@@ -101,8 +101,8 @@ static int update_backend_firmware(int fd)
 	/* Get Backend Firmware Version */
 	printf("Getting Backend Firmware Version\n");
 
-	strncpy((char *)&backend_fw_info.firmware_tag, firmware_tag,
-		GB_FIRMWARE_U_TAG_MAX_SIZE);
+	strscpy_pad((char *)&backend_fw_info.firmware_tag, firmware_tag,
+		    GB_FIRMWARE_U_TAG_MAX_SIZE);
 
 retry_fw_version:
 	ret = ioctl(fd, FW_MGMT_IOC_GET_BACKEND_FW, &backend_fw_info);
@@ -129,8 +129,8 @@ static int update_backend_firmware(int fd)
 	/* Try Backend Firmware Update over Unipro */
 	printf("Updating Backend Firmware\n");
 
-	strncpy((char *)&backend_update.firmware_tag, firmware_tag,
-		GB_FIRMWARE_U_TAG_MAX_SIZE);
+	strscpy_pad((char *)&backend_update.firmware_tag, firmware_tag,
+		    GB_FIRMWARE_U_TAG_MAX_SIZE);
 
 retry_fw_update:
 	backend_update.status = 0;
-- 
2.34.1


