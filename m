Return-Path: <linux-kernel+bounces-766880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD8B24C44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343C55A58A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ED31DE4F6;
	Wed, 13 Aug 2025 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsd8bPt/"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBFE1E2858
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096019; cv=none; b=kd/EkYM54viNufuu1H1GIJXoKfh/rMolNsSJ6IkVON+17UGlmDWjyPiWxbE6wb2LdhZ58ybGa8UtVmkjqBYhA8IKx+bCxvmFSLPq4kkk9ofoO4Te16pusAGhQrxVbvVoNgh2i4+wmGhyUlSOE8sRaz0sr7EXQ7dfy/l3xLVfR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096019; c=relaxed/simple;
	bh=3HeV/s8mf6bCb3MW1eY0o3zlnm8JOlPksfvUeKtjK1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QAEdFTfogVmNUtbxSgI6CY1zf0PV0RFyUA2IUu59wPId1oPPSfjtalTE2AHfnYi6fAXhO2LjtVEKEcHOs9lnP89uwz+c8t7/8+exhrHG505ooyMTiRY9vPMco/XOP5Uqi9MiaWEBtw+FGiqqt32qIZyqt2PQBUmTZcXWP+Ow1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsd8bPt/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-321cf75482fso1021339a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755096017; x=1755700817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pDjOa/Xp81rs87L9VpRbzpj63Uj07ISfrQi/o1gFpf8=;
        b=nsd8bPt/1Bjmcer+FwGQmOdXHpt8iMEYAhRdzVl2k2OzNbh2PW+8p65EH70QyCHt5h
         pLIzCJHqrjOV9mHD9WV/HoDwxowAf68gZ6rlzRgsCJZbnm4V44YAYhs1qxUZLFeRuXMd
         WY8ncinCK6K4NFxejcipVkljPpU40/Q+v0TdSHpVJ7dbV7W+njp5QVlk9TOoeSgHZvU+
         yVtyxz+Z623RyRAPzay9mHMEKNoO1KvM+pwA431aLPuTm45NMogebw+LgZA6l0b9ggaK
         nUZXfeW0AM0sIQ+U2beYSbIfElCWYGoonFacKhMqx4QNQr/sq3A8FkWVQ0pD46YY5u0p
         YJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755096017; x=1755700817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDjOa/Xp81rs87L9VpRbzpj63Uj07ISfrQi/o1gFpf8=;
        b=c5n0ifCsWaUKphgBf3bGTuqiJ902vDi5i/J7Z4zMrTUpTrnb7CrI16cOmyRYNRCH23
         kW6EQ3yEldFv+4jEdbCVEaQEfpITkY6cb8W2b/PsNP+u6vNTZCsXqOB+Xe7F7qcsJPhF
         tVqW4naJ+pxlCKQpc/dWjQl3O0giyebrqajvyZoCcSTHQLhvWl7hLlTyT8yzsZ9EAxwu
         UbWwa0MbEnNg+yyK5A8fbh96S8kHWlAAZfQH+mS4TipSR/cLd22PLkS9W1LZDvRXnOEa
         g+KyKWpLVmKMo8zull30N0wBeO0F+whOZEhIFeaGOJ1giVXPRFsyhsNLFAi2KZqdMiTe
         vHFg==
X-Forwarded-Encrypted: i=1; AJvYcCVXkWhCttOCyQi1yl9HZUFQ3iaOp8g75Ph/G7K954nlq+IJu5ADVY97xhaaTgFmqb9m7LQ7HIsjn5az9Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpB/KjdasKN12QHsNQ0SDHbrzSY0MRtJ9a81PViGKD1Oqiuxau
	Xos2yHcxqXezi0XUuse/mhbHVocXSYQ2zQ+aTKLJiVQP/kfDegpJYR0p
X-Gm-Gg: ASbGncsjTwmqoYpVJjvNjcuZ1oq00BEkDPRQPBBFnGEy0oe441jeU01GeGew1kYIcCX
	sZOHCZ/GlAgbuSMYgMH0alvMjgPxtc1p8O1mcTT0+O7IAKtknqMVhU5s6Y7wLJ/EbOFH91wq3zu
	LEqghTvwuPOyWTYvr1Cp14Y9yecVoRGTiPK11ExO5B43pZizXWg0hcm3reJdUsN/IuOqPHWqpBw
	G2egEmLfIf01l7Vtne5CxMDTVh7hytNQyCzu2C5eLc22l6uQM3QuOUyYmgJ/4JqVvCQozJrw9bT
	3KPsPMw7a3fmgB4dYQIeCLtzRgouvDy3+LU4a/0LxogkXiv0VPvfwfA91D8t3csgBrQmiWVZJ//
	60nDuksMTMPRylTzQRE/9J60S/GpFvtVrpE+82/c8i0f6B/5GDwcEWYzH48p6P8TXyCSSldd+XP
	dzWw==
X-Google-Smtp-Source: AGHT+IESod6XYiMhJI1NGrL964WHvDNp1rHtkyu3jVsoDJf3P/8fwBq8TlO5GT+GL3HwCUf4laJ+Nw==
X-Received: by 2002:a17:90b:164b:b0:314:2cd2:595d with SMTP id 98e67ed59e1d1-321d27edfbdmr4479992a91.8.1755096017234;
        Wed, 13 Aug 2025 07:40:17 -0700 (PDT)
Received: from chandra-mohan-sundar.aristanetworks.com ([2401:4900:1cb8:7b85:9b4a:84f0:66de:85c7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232556018dsm373059a91.12.2025.08.13.07.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 07:40:16 -0700 (PDT)
From: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
To: jyri.sarha@iki.fi,
	tomi.valkeinen@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org
Cc: Chandra Mohan Sundar <chandramohan.explore@gmail.com>,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] drm/tidss: Remove unused value
Date: Wed, 13 Aug 2025 20:09:59 +0530
Message-ID: <20250813144002.111689-1-chandramohan.explore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value "ret" is being assigned to zero but that statement does not have
effect since "ret" is being overwritten before being read.

Remove the unused value. This issue was reported by the coverity static
analyzer.

Fixes: 7246e09299455 (drm/tidss: Add OLDI bridge support)
Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
---
 drivers/gpu/drm/tidss/tidss_oldi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 8f25159d0666..7688251beba2 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -464,7 +464,6 @@ int tidss_oldi_init(struct tidss_device *tidss)
 				 * which may still be connected.
 				 * Continue to search for that.
 				 */
-				ret = 0;
 				continue;
 			}
 			goto err_put_node;
-- 
2.43.0


