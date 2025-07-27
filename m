Return-Path: <linux-kernel+bounces-746955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FF6B12D99
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA96189E4C2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E8817C21C;
	Sun, 27 Jul 2025 02:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmYcT9+l"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D246D2745C
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583463; cv=none; b=ldug1lSGeerH5oUNpxQvZu8nHlOmsUOva/F/4aq56aHwP35Fdi+BlJLgcYQDsMWG/a4WQk3yNzgJnkZQfJDzPZIoW0JO6wSWfuLIGWiOhMFSarFYm3MEKkOcepXQi/Ym2cWSPdQws+VdK8OG9gWJuZQIhQyqBW+2mW7eq+64leY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583463; c=relaxed/simple;
	bh=fqs60mNymrnRSUVGHkXrnH4Z3yjihDz9M8sUk+MLMEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZgX7NEjuz+repONLmz4Q5GcNKLZU2cY9g35pIirknj70/pqfNlRqCPA7MitKdxHidMLG9ZqxnNHts4KnEzZ0gu87sYEl1pvUW856lwQU9zC4GsdIRKz2ALWDvEMkweecDwrAaVFF5itevxrXlJiWvBB97j9omln0CGEf7nd+v3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmYcT9+l; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b170c99aa49so2466718a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583461; x=1754188261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hj+APWp+57RtT613nJGuVXjTE+L9D8ELpPO8/QoU/I=;
        b=hmYcT9+lMHP6/rGqHlHwYZKC21bgdZugnc2rEWnqVHlzF5qaUC//zwBOIEKHkafVH0
         xilFszi5Zw3YArzXgkX0PtvUzMLZkL1k13gii7iaRz1m4ilyDavb/Zvq7PjKgjbieBny
         k0Y4gr6WfwJog0H2vdMqKMJv+toSXfu3oJoEv9kTZIAQCSvRRLHRT3rA7IfZJ8Lua7ID
         oUT78+gez5duRv7m8oXvOrJXdmYH51/q4joXHESfTTZNxTvcSG5Zy4ngPSEHpcqhYtpa
         Vm1XTmHpGqeUp+OHAQ0BLSuIZSb8j2tilJBjSOHWv5aekw3WFVtJt2fJ4CLRsX4cmtB2
         ltSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583461; x=1754188261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Hj+APWp+57RtT613nJGuVXjTE+L9D8ELpPO8/QoU/I=;
        b=V5yQD5lbQu7nqFHaikhQnNFajyEUtWL6qDj+IFDfrYdDUFy06UC2Y4QKXwMSOz9ct+
         pEoL0muFdCMoNwrwvlkd4EQEOsII8OUm+nRfW3JgMqSXpO5yWQ4PiIeCjYgUnjWCg/KV
         B5yXOiWQXk2OQIV4++l1DPi9X3zcCjLgDWeGIMWdCM6L9ZnOkzorlRvRibzS1utai7OH
         pWpbM0ThDqWojsJjL6+EM6WC+nqEWvooUfLmKQnLmnzulhZLJibOvmedDbrlwzSvNI1c
         Kz6uQBt8TdZ/B2Yn07B8cjEi8EHdExVSg6Cq8XORd5ouAltCTUrkuy9ef1OHGFthxe0b
         UvMQ==
X-Gm-Message-State: AOJu0YzMT6f+9DS9mrhKB//4ogaKUmfO1aVWreQit6rzXe5c2ubp9SJd
	0lZOXKEkT2OSKXW1JFP6781QRyJBevrPyWLDqbPgWbZgS2uCO34dNqlULTVu0uY4
X-Gm-Gg: ASbGncuhxHGQL/igGCgklv/R76VqAlS1vLLT53dMSqdNaj56KtwqsK2VSxrrdpLjyh4
	tu0ZNe0dzB9dD4Vz2d/CTwQXh3+4mytVEixS6E7s0KrBraweJnQEzy4pNkv9zPXrsIJ8DPt0B75
	bFrwIXni6KmTBiT7h8Qyjx+NUa92Rzkbe5wsdLCr3RhrN++ijN9LiMBFOsDusSUa5coCosNvtFX
	yzke0BSj/S3jgB9MGXmRMI6ywLh6kQQ4H8c4JLo12NCVVGKAsyzQ1ILH3SJnhu9QdqdxL0CRuEK
	k922Z12yW90jMdmc1VQqNwjSP1YlHb9kg5MdIQGYWuZzsx9vhrmq7Gh1FqXfMcInup3Ow884tsX
	JxRdozs7ZXpBTRIWX5bzTPXUoZBRSAshYdzudkTGfRm08Cfx7BXDreSVA
X-Google-Smtp-Source: AGHT+IFGN72qQiIgJbBwPYjLkxR1mCSgTPqXwml2o+mCoR35bEJBNktyKAttWewSRaQz3x1DsmANUA==
X-Received: by 2002:a05:6a20:9150:b0:23d:491b:76a6 with SMTP id adf61e73a8af0-23d700e83a9mr10961885637.20.1753583460708;
        Sat, 26 Jul 2025 19:31:00 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f568ac1sm2391442a12.5.2025.07.26.19.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:31:00 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/gpu/drm: Fix typo 'minimun' -> 'minimum'
Date: Sat, 26 Jul 2025 22:31:04 -0400
Message-ID: <20250727023104.82427-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/gpu/drm/radeon/radeon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 63c47585a..6af55b3bd 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -1156,7 +1156,7 @@ struct radeon_wb {
  * @needed_bandwidth:   current bandwidth needs
  *
  * It keeps track of various data needed to take powermanagement decision.
- * Bandwidth need is used to determine minimun clock of the GPU and memory.
+ * Bandwidth need is used to determine minimum clock of the GPU and memory.
  * Equation between gpu/memory clock and available bandwidth is hw dependent
  * (type of memory, bus size, efficiency, ...)
  */
-- 
2.50.1


