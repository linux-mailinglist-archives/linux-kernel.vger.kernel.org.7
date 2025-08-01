Return-Path: <linux-kernel+bounces-753237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA97B18064
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E761C81D9A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13779238C2A;
	Fri,  1 Aug 2025 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWQFOMw7"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22DF218ADE;
	Fri,  1 Aug 2025 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045236; cv=none; b=FTKN3DtAi5+qMj5Veji4OqmlzxXQ0csDYrsGe4hy4BG2YZVtJS+yaPOVkOsXRq+NOT2+lW6dviS5S45h1gshSdbnM0zhiHoecNvo+8prqP40ZdY7nsGm/X66VRaz65QaNx3ZrK2O5ukvT8jVu2wVZrJJyckCTpaR/XYiSijRmv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045236; c=relaxed/simple;
	bh=Be1VdHknPGZ0mnCukpBYN7nwrz6fHVbtRMnRJIgiK/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oKHME2fzvGlrstbyetIMQrv5beIKiosqf3jUNmj3HW9wgpYk7f+Wz3RoKUdMttt0b/NTUb+X/DDDk/CKQKBbmwN+5vFEIaQc9LAtNfcaa5cSPsL8jJtC4dQcbrg1mZ8Gaf21fcVDMgUgdI8NYIDLrxObED6m4oqa63QHkhQcIwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWQFOMw7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so1766252a91.2;
        Fri, 01 Aug 2025 03:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754045234; x=1754650034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmrAbzYZUxB9t3jmDwLlL4LFVN3kzC0P+SWz2BBpLpQ=;
        b=BWQFOMw7XOANBRg5fIxraWLbLNKvCR07u5kbczZ2InHUTIb3kaTwRMJh2lXG3wnFMD
         MnO867zz/RwMYQ8xytrE4FIhh4/kEoFGVuXSDhGS9sEaV30oNNytqk5hqGIYbMRQaBAG
         NB97Dl4Vmz4AsHkgq2eH3B9GsvlvApksLbieiuUl/C+GAboyZrwhMgj8/kxLtQK87KaK
         4C2ExaQGoA5dUpw+tuKn7s92f/1eivjoyx6V74Snn0DjUAf4rMoeNo6PBZEF7SEdCxhq
         6wuiiMdZCvPzFSsy9OJHIIqpuOQf9S2W/oZeZEWKKlloIPvlIgAsWBIo13+tYjjwGYoc
         mbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754045234; x=1754650034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmrAbzYZUxB9t3jmDwLlL4LFVN3kzC0P+SWz2BBpLpQ=;
        b=INriFbsvzVYDBMwWjpCeQDgF542r6cPlNF6YEEYepgguraXK8Ues415qjcoLQAJ1ps
         nRBTwp9NzWm9KH14CB74LnDvzUX+9SxFYg22yaqCP6jsQMlKKFwSoZCEWDbd8XddojH6
         shafXSRvw9qoiuv+XPVfB+emK87kFvei0dQTqmCYQnM3w+/TFoj0dWWOoZyGe0RtDqjV
         EF7+F1Uf1CSduYQ4zqgnEgmKpEvStKMq05hsJZIunuTtpYL7A/rU0uGa0pj2Xc35zW5G
         HFluI/d6cVhfITeQB9dRbNPWYFHybHftY7gF3crFymy0+DM42K/ft/21sPnwrFAQerZd
         79Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVQG47r9ihvh2VlN9kIuVeUTQQHMfLaVpcGudp1Ia1Hi+bLxPQ/uxJr0lQ52ScIgF6FeliMethrw1zn024=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmo/OvLFdL/h6V+JbsTjg5hFLSA/TnbkSA2BchFKAZbjONKr7
	qzsn5rVCVALrgM2kGkHyFN5uGM48Ck9FrIYYQ1i/awGxjle6SUcKLczGkvQLdr5R+YkFcw==
X-Gm-Gg: ASbGncvFz4RhJBraDLBX3lzrTQtO9tv0DhC9KqrL3FtWmckdRbi9pxx3Aj4ypI9eWbm
	ecrKqSVZckJSy8JEtdAqgvq2Xzl8EqV/OQDi5c9xLiqI54tREw9yk+qQj8bfCJltf9mEyynTGBz
	mgtIzDG/hKeGzbZGy0nBl2piyI4VoOdRnfDkwH0BmNzBp9XSp6/lFPNucf4M7SSuSRc0Yu3iyoH
	Yb0Z62Sb0AxvFSr2bSXSuPZRmGe7aGH1lHpUHyxZdLHQcgf8KYQsYBYMpulr4shxClq1ji9i25n
	88WyjMLcdWbJyw7+R+/I/G4Al0gX8iTcGYNrLFqCyU4G8KymaN7FtCc8/UT+1i4pjPQj7DpSDY0
	bXZI4039HMF/lrNE+p367Bncl/2mG8rbJ0mzsqPNnMHzKLaK+
X-Google-Smtp-Source: AGHT+IGNMZmsxePR1+idcUjHltzGKr71lv2D833dgV8FkSekSun2b0iBomBYX74UhGSDiSsHy3+gaw==
X-Received: by 2002:a17:90b:3c07:b0:31f:20a:b54c with SMTP id 98e67ed59e1d1-31f5dca2727mr17026023a91.0.1754045234007;
        Fri, 01 Aug 2025 03:47:14 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c80:a6e0:3232:35a4:62e3:6fd8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-320f77d81bfsm2102298a91.12.2025.08.01.03.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 03:47:13 -0700 (PDT)
From: darshanrathod475@gmail.com
To: platform-driver-x86@vger.kernel.org
Cc: stuart.w.hayes@gmail.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] platform/x86: dell_rbu: fix assignment in if condition
Date: Fri,  1 Aug 2025 16:17:05 +0530
Message-Id: <20250801104705.1824495-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Darshan Rathod <darshanrathod475@gmail.com>

Refactor to remove assignments from inside if conditions, as required
by kernel coding style. This improves code readability and resolves
checkpatch.pl warnings:

    ERROR: do not use assignment in if condition

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 drivers/platform/x86/dell/dell_rbu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/dell_rbu.c b/drivers/platform/x86/dell/dell_rbu.c
index 2a140d1c656a..403df9bd9522 100644
--- a/drivers/platform/x86/dell/dell_rbu.c
+++ b/drivers/platform/x86/dell/dell_rbu.c
@@ -232,7 +232,8 @@ static int packetize_data(const u8 *data, size_t length)
 			done = 1;
 		}
 
-		if ((rc = create_packet(temp, packet_length)))
+		rc = create_packet(temp, packet_length);
+		if (rc)
 			return rc;
 
 		pr_debug("%p:%td\n", temp, (end - temp));
@@ -276,7 +277,7 @@ static int do_packet_read(char *data, struct packet_data *newpacket,
 	return bytes_copied;
 }
 
-static int packet_read_list(char *data, size_t * pread_length)
+static int packet_read_list(char *data, size_t *pread_length)
 {
 	struct packet_data *newpacket;
 	int temp_count = 0;
@@ -445,7 +446,8 @@ static ssize_t read_packet_data(char *buffer, loff_t pos, size_t count)
 	bytes_left = rbu_data.imagesize - pos;
 	data_length = min(bytes_left, count);
 
-	if ((retval = packet_read_list(ptempBuf, &data_length)) < 0)
+	retval = packet_read_list(ptempBuf, &data_length);
+	if (retval < 0)
 		goto read_rbu_data_exit;
 
 	if ((pos + count) > rbu_data.imagesize) {
-- 
2.25.1


