Return-Path: <linux-kernel+bounces-740875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204A5B0DA82
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05983AA6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25632E9ECA;
	Tue, 22 Jul 2025 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvLprJn5"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697A2E972E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189620; cv=none; b=Un6cng8fStqW2FxDV3VVfnEOhgZR9YSVFkPyPeJcVNJEUPnVwDZSuyqRizervrLNITAauaYPVykTNXNI90cM584uqi/p5Cm7dke5d1c1KxOZ7JwjrpxPcbq8qgOgMuFKn/pub7bJTQZtah37lp5uJ/DV4T2zr7sI7+HN0R+Wt9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189620; c=relaxed/simple;
	bh=hilKGZUP7y5d1I7SUkMYXuUmhe9zt7HQf/8BUez4l/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=peosrZ73yo/vtJRwO9FtrBMmAP2RtZArECbp5cef1EFbUyvILEIz9h5dvA1c2CxZ/rFJrjHuEdhxhZ11ksnKAEwUwUq2wBeeechJ1gLrIyBzQ+xe/1yeuK7D5MYxwGEdVl9NsO6UWqBOPopk2Te0+c/u2aqdqLUd7Us8expscd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvLprJn5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab58105261so101269551cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753189617; x=1753794417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wHXGkDCdTi/1FkvrPEpgEX+BFsQbleVdLRAj1y6UuUA=;
        b=JvLprJn5gd4PYFv+E1dRx/LmZ1CMBkdt8d7T9earOL+kyrXh7l5wkj41dw9aOK802C
         WrRDTaWPlF4efKz7HezTJYIcNW/aMjJXhw4xaczTVq5wxsWMkBjh10JyKrq1MSWpQ1mV
         38/DIM/L3jw813waIVS+ei8WAqCF6fKf6duI/jlt9kuz0VPNysBZ8d1ebApeJbbOJHec
         sapNEsu73BGMTAXT0bH8F/XCH6sFYPjKkrYRct8BIHidhKuGG9C7g8tiwT+2N7fE5Qci
         SDyXoq9W+NBgdf4RlkWd22Pswwe7fedG2Qll91Fxvf3e4d287G+7wk0r6/2P7tzolDFZ
         LZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753189617; x=1753794417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHXGkDCdTi/1FkvrPEpgEX+BFsQbleVdLRAj1y6UuUA=;
        b=UmTWVd5sTb0vqVQjYr+LFuBCIxCDDt99Ru/A53dgkrqxsIPG61z9odHQ4+6MzfQbh+
         xhRBomutUAbxUo8KKvCOCDNxQtCOEfmijIi0Vjbknc1qo+KmxfOM7SNALtIjUN4uga3n
         FXcjJXbV0GB5L6V51gCtN2aROHnWRWgRHp6MCjA3fEuO+fvQaHZJNrTEKRcj+8ZFV2v4
         8TmzcamGG70ZbI9iYL3+Dlvhduo9lvxkNwIgABbgm0Hjca0OWHQWemFnMNUW4awgEKTh
         xUyuJIULQZLmwIP0xK56rJO4xTnYyvCVQ9u4waXJ/BGVwHSdSSHZJq7vxe2aVlnk7NKM
         D+og==
X-Forwarded-Encrypted: i=1; AJvYcCXU+hV/3W4p4loI5ODu7otiP9ksPkSf7ccvsAMHL2C0YD8csQvilx5ae1G2UYW8+RM9dV4EvzqSjgPQFd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BB8d5RTlkkJyq86LO1n7z/9jm7qv0flk9T70xUMU2ec6Hjef
	jl5CcHDjKKXddIDsuXXEWetaaRg0hzmW1AJqPZ2dFmCubn8YRhB1j6Ti
X-Gm-Gg: ASbGncu3/el/UYzsmcYAbcxXIdUi+2lNBtZ5C9zZkMQN5UeBjYgyVyWzwvffQpn+Gle
	4SWUqr5a0FtDRETsiwNxh69s3UkxT7nl4hb4E9IQPRqAJJ/KlrPG/h11Clr97sZZeE+UtcY1cj/
	sE9gbDlEKNNmsWJ9pmU706F6XlcdzppizxgSq+Z4iC79Kge/bu+4RyQqNaGY6mOUgSE4oZgVE3k
	66kE8IfCc6bbH+r2OJz1j7giI/2Y1moiGtezUO+IPfOFQ6E9HRjQsGC4HG84KB6yCQyRRJZFE7M
	i8mSFAG0eGM0MnqVCps3NuLIXpG4EyTodoCtFB9ohIN36tX/mxEyFMSESbHHf4oDS7NiuhfpG4l
	JeRTt/MHe+LtWrQHIB/4WJQ==
X-Google-Smtp-Source: AGHT+IF6IjDqyjw6zDnG3oxKNR+WfveKAXP2vd7OChY+/7yqNei8ee7Mwd/9T8BjrslIPwUvBnIohw==
X-Received: by 2002:ac8:7d82:0:b0:4ab:62cc:971b with SMTP id d75a77b69052e-4abb2cab50amr310328961cf.17.1753189617109;
        Tue, 22 Jul 2025 06:06:57 -0700 (PDT)
Received: from iman-pc.home ([142.186.9.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb49802efsm53977981cf.7.2025.07.22.06.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 06:06:56 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Seyediman Seyedarab <ImanDevel@gmail.com>
Subject: [PATCH] iommu/vt-d: replace snprintf with scnprintf in dmar_latency_snapshot()
Date: Tue, 22 Jul 2025 09:11:17 -0400
Message-ID: <20250722131117.2739-1-ImanDevel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snprintf returns the number of bytes that would have been written,
not the number actually written to the buffer. When accumulating
the byte count with the return value of snprintf, this can cause
the offset to exceed the actual buffer size if truncation occurs.

The byte count is passed to seq_puts() in latency_show_one() with-
out checking for truncation.

Replace snprintf with scnprintf, ensuring the buffer offset stays
within bound.

Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
 drivers/iommu/intel/perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index adc4de6bb..cee4821f4 100644
--- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -122,7 +122,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 	memset(str, 0, size);
 
 	for (i = 0; i < COUNTS_NUM; i++)
-		bytes += snprintf(str + bytes, size - bytes,
+		bytes += scnprintf(str + bytes, size - bytes,
 				  "%s", latency_counter_names[i]);
 
 	spin_lock_irqsave(&latency_lock, flags);
@@ -130,7 +130,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 		if (!dmar_latency_enabled(iommu, i))
 			continue;
 
-		bytes += snprintf(str + bytes, size - bytes,
+		bytes += scnprintf(str + bytes, size - bytes,
 				  "\n%s", latency_type_names[i]);
 
 		for (j = 0; j < COUNTS_NUM; j++) {
@@ -156,7 +156,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 				break;
 			}
 
-			bytes += snprintf(str + bytes, size - bytes,
+			bytes += scnprintf(str + bytes, size - bytes,
 					  "%12lld", val);
 		}
 	}
-- 
2.50.1


