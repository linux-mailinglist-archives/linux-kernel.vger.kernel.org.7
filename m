Return-Path: <linux-kernel+bounces-820054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74013B7F361
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893953A603A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A48F2627F9;
	Wed, 17 Sep 2025 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPmfqhAe"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B223BD1F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090305; cv=none; b=BdhWxjSmXIxh0Qsv8OcaqEQLj5wPA1kPWwG2+fkyzfc8FRGEaZvPPhlxWPM2cU5xwty6X0UYXZyqhhitwxcbMazlmUKANudaRUmF1TL+DG0bJlo0Jsl54NJHFF5Xsas21fnsFpgyy3l74BsPw13jQKjkzcVHYh7nBbt7M1hHX3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090305; c=relaxed/simple;
	bh=rzXX/dtUq/UcfP9OSjnNzzhylkYRbWAAxbLeSuhvPHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWkt7h8YZXt0X+aGfLx2Zam5PysxtfrFGVqIhcE171YUuM8aW/dxT6NLeFi2UybL8Lhh3n5NPXNNahlcwBvvCGCmtHIVT7H588oW4oDgDTs2t6suyJzArluG9EGNGZD9/O/cBKOpVffCe8Hd9EVEvdE9H8csQGrBaknmJTqMHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPmfqhAe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445826fd9dso74886225ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758090304; x=1758695104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o4wyrSqJyB4cA3v/v5NTU3+JE/mrTp9rWbEkkkvfz28=;
        b=ZPmfqhAegIQqMtzBEKU2pM+gSA1ma3vIBZU/sgEVUUOHMyvjn7N0EQawZUKjyGSEmR
         IK+vEBrNns0yn125ZSWUqPkDhQzrVpiH5WKlJYd76a4q0gYd+yQYsrmRGLnjjgbjwkgp
         cz1EaXswynYuwK9Xgp2DJlDJf+Qoo4Z9JeNdC04NNEFBbgWEOo8avDuDB4dlJwhEkeIo
         C1D8ZXbrk0cSlbG6WnJ6XVtLMvwRmH1XD7zTqZFWX/sl8+B+HDWMozryUlXagzk9m6uc
         PGnNXieUiBfKNg+SO/HH2xBebiFhbO2os+5viB9Dd9RjdS3J+7lj+Ks1zsvAO3jKOfg2
         CSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758090304; x=1758695104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4wyrSqJyB4cA3v/v5NTU3+JE/mrTp9rWbEkkkvfz28=;
        b=NcEQLA6FBeULdOGtW2rFhGd9LtGX24MbcuMBnmKUDu2UxczZ4I2X0W+DkmlS8YI9jb
         9VFB8SRj8CgPxCohTzA+HQ5JnfaUaeJg1YB7yyIUNjbAZfJFDACm/JRyNxV1Idvzc6h+
         bImLnsMOkleDACmTaRd/ygLrXvP/VQVCHax/bF9/HrBXugwQjw8g/IDqs0nUPHFq4hnS
         /MXcKgSuJ39OhZfI6Umg1/2MV/kxUPAIJGtyPsM0Hw3CgAQ1EUwMWnRXLSGf4dwfdoO1
         dgGYvoe3ZWdVGJXvArj88YKbDodAhC+rJwUHLYFmYCtX8M1Yt7vG1LqWEtCib9ibfKAu
         0loA==
X-Forwarded-Encrypted: i=1; AJvYcCVVR/eUKZF6iL7LidQ+EGs2Wb7Ck2aUwh9YWsSiJEo1KByREuFL0ZJ9dcFLQjXchBojnPDjVzu02XIwbvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzngjARdIXycuB64anGSoXshxGEW4iDc5EKZoahKCanA0lLX7cb
	Vn8Op7i7Yrs/cAbniJSrPG0blDbhE30wKNUq4sJZPMeXEwZn6TRcQpEH
X-Gm-Gg: ASbGnctu+damaNYiPRWll7GUSp/nWGNhNIayRaAVTmPkzisL/IU77trWjOUEMzjjCc/
	z4ZphFIBGcMxh3sMYnElAlo6UN0gCmBk7TzdXoX4vdJ6X36Aiz21+ljSBwt2e/sBfZMQ2wqHUrK
	T1iLcwLfCUv18Yx3yElk1KjFCLMXGdO/o8lG4KmTmxCxSfGkzf1y/S6BZwiNW3WLOWVyA+LeXrf
	lbF7vdGmeMj9s2eA0bKTFDJ7NsQM90n4vZm8oQEUX5VRlmrc6QJL/4yuuoSEO3zKr49adocxdAR
	+iwh3craD7xsRvd2DyWkSlFpF8migQqqo3gMLzJbzING1VA96jf6287ktgffUxxgD19PZ0yyJpD
	R1xF0vFb6VyXtKF3DHA==
X-Google-Smtp-Source: AGHT+IG4yhx/jw9zlmBHFiucCMISe3PpQu1zuHcOTs77I7QUK32j+zfTSaEaEBRwZZIrm3ySJSWT5A==
X-Received: by 2002:a17:903:987:b0:267:6754:8fd9 with SMTP id d9443c01a7336-268137ffe09mr11586945ad.39.1758090303761;
        Tue, 16 Sep 2025 23:25:03 -0700 (PDT)
Received: from fedora ([119.161.98.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-264eeab7c22sm91296235ad.17.2025.09.16.23.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:25:03 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: dakr@kernel.org
Cc: Nirbhay Sharma <nirbhay.lkd@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: drm/gpuvm: Describe map member in drm_gpuvm_map_req
Date: Wed, 17 Sep 2025 11:54:20 +0530
Message-ID: <20250917062420.69986-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel doc build (makedocs) threw a warning because the @op_map comment
did not match the 'map' member name in the struct.

Fix this by correcting the member name in the comment from @op_map to @map.
While at it, improve the description from simply repeating the data
type to explaining the member's purpose.

Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 include/drm/drm_gpuvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 8890ded1d907..1c851c3f778e 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -1078,7 +1078,7 @@ struct drm_gpuva_ops {
  */
 struct drm_gpuvm_map_req {
 	/**
-	 * @op_map: struct drm_gpuva_op_map
+	 * @map: The GPUVA map operation and its arguments
 	 */
 	struct drm_gpuva_op_map map;
 };
-- 
2.51.0


