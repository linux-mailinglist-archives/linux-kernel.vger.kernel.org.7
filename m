Return-Path: <linux-kernel+bounces-614214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68605A9679B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 13:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C837D3BE305
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 11:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941D2281358;
	Tue, 22 Apr 2025 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlPpLfVC"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE63280CCF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321551; cv=none; b=Z8io/q9VJcLGXkYHUfCFtcF9V1lZGTORed65G+PtDkwJiYzvCMcyGjzc961G53fd9Ke9K6jBlkYPKRBZRJBwE5Yb8QABmVl4ySVyr4wFE9hKR07Mf90pkgU/vi+hiZro1FrF5f1KG5K2SVL5wDcmowy0V4D7Bp7qoIqd64C/wwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321551; c=relaxed/simple;
	bh=ZFDuP50cM3MaZ7k24hjB0hKAUp2z1/JdcCExNP+BxkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLRJMx6EB0QgesulaZqabCwaJjivDrsKn8V1u7tqBnhZjhhUiTC+7xfrlLZY6ZFDDuTsmY/sc3El4wEZvLH80Crh2lZzplj2H3VzWb6CxeyjVHMmW0q6jXjOdRuI0QXIgbu+S1tQ8oyATnzO7KGnehr8a9evaOQ5Vi/kdhfppWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mlPpLfVC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39ac56756f6so4976660f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 04:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745321548; x=1745926348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWRwjTKda8Cr+xTaLfEjNwhn6lD2r3hsck/mBkqRC78=;
        b=mlPpLfVCiSlJjJ57uNkNvxe1RSlCRtZ3r1wXGH8e8b5QSUtIWkZsm6cruZ9pY+ZenM
         dBDL6VLPhizQxaqxNMi5rkOVpuizigdsm9YyIKM8adB9tELEz9M2/E2oPZAaaWKTnuXO
         qmC+QLStMbC2JuCvk6nRiJcXalao3i47qxlH0YIkGj3NnhhVlJsq5tdQj6mH0KPnIJPj
         dtU7B0dvfYkCrvOVW85SKnFukUBDg4bSqtxN4cwTJp9CGvZp5gAzjK/hPU7dI7WyZnxU
         d2ry5zadgGRGbZTI+DVHEde/VzbnkvM/La/YDvktVsQszqR1+coYS06wlrSSyPe21htK
         IWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745321548; x=1745926348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWRwjTKda8Cr+xTaLfEjNwhn6lD2r3hsck/mBkqRC78=;
        b=h7AWYlPFrVqJ7IBguPF8WVisb1biq6oqCiywRQT5mqmBX1e3jp1sNQckILObznmcKC
         HXmnA3yw31/eNO5PtI1JSZHd32sboaw3XV9KaRuZQVb8iMckgThrkfBZBRxJKk5MqRR/
         aJfvbNQVQk/j+P+nvZCHYC7jUcCoOKMJtaFACZJt6FTXJfg24qkMrG39BEnHTzFL/cug
         OKbWjQ8wyVBYHDs4+Mgr6PQRWbGdrTPc19lFmONaHrFXgVgBt6MZHS057QGW50i6xKd1
         gt7ogBdzkjS1kkVEOLYfxhO0cfdUysjFJDmSwbpW/reCjdAJjaaXoddFxRwLSdCsXuA8
         MKXA==
X-Gm-Message-State: AOJu0YzViIL3OFbZZLJV5FddfYUHQQ6W6TSMFJcfCXGkWVC8PY6gY5b/
	Eubet74sLYHxL5mtkhBKPJzzNGbHF3WMtGSAlNxfqUxtrhwXB5cj4FO1XZCi5pgGoI81cXRNOmK
	x
X-Gm-Gg: ASbGncvAe0P8uw/9kbF1p2KTyDgVOnGeF/gYWbmehtME/8GBcoJPbhSwc+Kc08bn8Fq
	jEb2OxLNng/D2vBseFfxs+Jm96/egj4SADd13Zpm3NaTpItFNEDzRYjZT2Acx9cal1Tskzwj/eK
	wyvYoAv2TLdhUQ4d0k9+o81Dq1vrGArYJ6qVh5RRtN27gsGKEn6UIisN0NtNIPBF6ROtT5Rsj2E
	W3hXT0BwZ05IwVi4BMLZ/LZdm3xPXL8RKZ482xGbXnO411/z4mZcoWP21tC/XA7Stzrl5dMFz24
	LkTVEvwiuVQsz/+cr5+T3YDkM1ZgD6jcLPYq0rQcv3JXXXgk7PIZ
X-Google-Smtp-Source: AGHT+IEEw44a5vK2IjFWiYA0X0j2siN1vTRb5HOMU7dDGydhv1gxPnFyAxYzd0KC7UUWKC3HvgVANQ==
X-Received: by 2002:a05:6000:4304:b0:39d:724f:a8c1 with SMTP id ffacd0b85a97d-39efbb020a9mr11656442f8f.47.1745321548490;
        Tue, 22 Apr 2025 04:32:28 -0700 (PDT)
Received: from eugen-station.. ([2a02:2f0a:131e:0:1820:da87:73b1:d80c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa49312fsm14907887f8f.70.2025.04.22.04.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 04:32:28 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	andersson@kernel.org
Cc: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	pmladek@suse.com,
	peterz@infradead.org,
	mojha@qti.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	vincent.guittot@linaro.org,
	konradybcio@kernel.org,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	eugen.hristev@linaro.org
Subject: [RFC][PATCH 12/14] kmemdump: coreimage: add panic registration
Date: Tue, 22 Apr 2025 14:31:54 +0300
Message-ID: <20250422113156.575971-13-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422113156.575971-1-eugen.hristev@linaro.org>
References: <20250422113156.575971-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call panic registration for the core image.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 drivers/debug/kmemdump_coreimage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/debug/kmemdump_coreimage.c b/drivers/debug/kmemdump_coreimage.c
index 2144edcc6157..7f3b089b5739 100644
--- a/drivers/debug/kmemdump_coreimage.c
+++ b/drivers/debug/kmemdump_coreimage.c
@@ -5,6 +5,7 @@
 #include <linux/irqnr.h>
 #include <linux/kmemdump.h>
 #include <linux/kmsg_dump.h>
+#include <linux/panic.h>
 #include <linux/utsname.h>
 #include <linux/sched/stat.h>
 #include <linux/vmcore_info.h>
@@ -76,6 +77,7 @@ void register_coreinfo(void)
 
 	kmsg_kmemdump_register();
 	irq_kmemdump_register();
+	panic_kmemdump_register();
 }
 
 static struct elf_phdr *elf_phdr_entry_addr(struct elfhdr *ehdr, int idx)
-- 
2.43.0


