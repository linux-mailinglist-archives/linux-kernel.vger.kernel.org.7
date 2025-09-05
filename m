Return-Path: <linux-kernel+bounces-801890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558EBB44B3B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B164587FD4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153651EF0B9;
	Fri,  5 Sep 2025 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KX0G1Bds"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9099272625
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757035543; cv=none; b=qIAwwmqt2MKeSmjFnRBF+bku08totAbCcb4k4Kes8sAhnfqs6w7JRMgEk4/fPiNH4pWGVuIzH095GRpxh6jJS68KHzSbIqV621qTiMqxX3InHSYSFRN1Urb2x3cGxEJE2Vf34ZDhY+Vh/Lewr12EKibnk92S/X5G/jYarCh++50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757035543; c=relaxed/simple;
	bh=x4M8vzAa9G8ugV41duNrOqQggOoYYSbHqlw8bIGHuNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dltRczZc8diipQF3L1Mx+VXreYyHYe8mDG6i7dUYNkTHzpJ44sGP5DylMs24sYAgvBSTg+KUdDo49tgiT5pBTjDXz6am/eJQMvXKhYtKSy/JqB8B/Pi2z+MmnrHucuM2Q5hhe/vIqArvCmU+fab5nthievOGn0F2sNYjBY4ay40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KX0G1Bds; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3f45b5bca61so1030015ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 18:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757035540; x=1757640340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gnWnwy0cMPqtw5BEHHtxoCEyhV636CoDiZ02zMa7Bpc=;
        b=KX0G1BdsNc6ziyIIZCKL5mOk9yAZHbiRFAM3rUbmRlAHkBo2ykmGSakl+JBpOeTSAO
         KHWNkTK+WJD7uDu7jfITrHQGaxfDqobMv+TBVdNwXyHTNzx3MZsgcb1P8F0iZ5KGLU/i
         tpCIBT7ALN/V+IeQ6DO3UE/4AkLiXK+AmD+Bpkh1fEf5IOA9E0HvSRRpuWe5T4fItbDF
         sbCBMNDnsrru/RFbJoUznzDhPupbKityO2PR+YqSfWINqC2+BGArFnKyJoCi1Ye3odx9
         kMZ/SEur9VABAm5QGehwvcmpGgEeBh9jPCjJXHhvJK7DYg6YDEb+9aTKRmqzSIoWAZx+
         jmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757035540; x=1757640340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnWnwy0cMPqtw5BEHHtxoCEyhV636CoDiZ02zMa7Bpc=;
        b=gugn/G1iNgD1UgWUZhFzSmKPSVCR0lINk3vCf8QsIhPrVfDx/x8AO0PelS0hkezodH
         3GVuQYT8pQomlyIOX1+Fw/Q2OLbxUc7uott9jOSOeyLnQpv/nIOIxY4SyopKcE3WHn+M
         3OD1az1RGCVW667QICt3Um7r5S3Z4D61I/JZfMdFmJH1NUr5UFH6hteXHp9sjGs6bYSP
         RL30Zs11XMgEn+9zEItUT7RhqJFZ+s4esZYmQ7+fuKTlkbOPze2rzVWMImKpwYkHEljl
         R1uCov85jBN3r6kMUtYM0nsu2pgVVHEqBzYpjkTFBrk0pL1YrwY5KAdecFX/ospbg/xa
         azng==
X-Forwarded-Encrypted: i=1; AJvYcCUTvGAoT9L/VadCNpinyYnoySt9cM8g7GA8u2n3eQsm6acdPEBENDn+140UCBGcSfx+WgOyDzl6+5SuVGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrvGNnPD1pyHFUXgabiAo/FBLzhJouwAFrGAUxHlb0omCsFOm
	/P3azFBhNYCyKuHQJ6ilbz2A5Yzk4eq0Q2IWV4K4XAUmuprSizdor5ZCEFryUx5fH1pbGCOKWSe
	9eJRHW8lTZrXaH1hg8I8PRfga/GxAbPuheg8M
X-Gm-Gg: ASbGncu4VwATrg+BluF9JuILDAvovELUBWWnyWEjBZX2z8/ezGkkPBvNvbrTzIia3OR
	3ytskiAaqdkhjcnAN2GJIYfoIxkkgorJ9S44Bve43gdLlvDHZDF/sQP/GYKAUdIsIcXedsJ8qkQ
	VIAkDoCeRQyglCa7cEpcqUeVPmZSkh1DzMsTh/jDGVZ5ZGtVbrd7OiLCwot6rIgbTB4EIW2Akh+
	o5/IclkJrtf0IlrFB9+gO+XHdy0tN6cZIdYR4KVINn6uY2TfFaDObYso2dxvMnqF1uxL+ZP0Jp9
	vlzvW/ksNdRxS8fbPKxSp1NtTFsyn68Efl1kickj1SU53A/W8sziyryG8MJBmQXDv0Nu5CsX
X-Google-Smtp-Source: AGHT+IE1TscQtnz7ja8VNIEOcYQE2LBDQ1YalQFkXxSCa5lmyVLkiFojFsDoRfuToE7u7AukvENY4JbX6eqT
X-Received: by 2002:a05:6e02:1fc5:b0:3ef:beb7:dba4 with SMTP id e9e14a558f8ab-3f321afda65mr148455715ab.2.1757035539735;
        Thu, 04 Sep 2025 18:25:39 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50d8f2deb9dsm902184173.41.2025.09.04.18.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 18:25:39 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 186B2340237;
	Thu,  4 Sep 2025 19:25:39 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 13106E41A5E; Thu,  4 Sep 2025 19:25:39 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/rsrc: initialize io_rsrc_data nodes array
Date: Thu,  4 Sep 2025 19:25:34 -0600
Message-ID: <20250905012535.2806919-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_rsrc_data_alloc() allocates an array of io_rsrc_node pointers and
assigns it to io_rsrc_data's nodes field along with the size in the nr
field. However, it doesn't initialize the io_rsrc_node pointers in the
array. If an error in io_sqe_buffers_register(), io_alloc_file_tables(),
io_sqe_files_register(), or io_clone_buffers() causes them to exit
before all the io_rsrc_node pointers in the array have been assigned,
io_rsrc_data_free() will read the uninitialized elements, triggering
undefined behavior.
Additionally, if dst_off exceeds the current size of the destination
buffer table in io_clone_buffers(), the io_rsrc_node pointers in between
won't be initialized. Any access to those registered buffer indices will
result in undefined behavior.
Allocate the array with kvcalloc() instead of kvmalloc_array() to ensure
the io_rsrc_node pointers are initialized to NULL (indicating no
registered buffer/file node).

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 7029acd8a950 ("io_uring/rsrc: get rid of per-ring io_rsrc_node list")
---
 io_uring/rsrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index f75f5e43fa4a..3f3f355f6613 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -209,12 +209,12 @@ __cold void io_rsrc_data_free(struct io_ring_ctx *ctx,
 	data->nr = 0;
 }
 
 __cold int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr)
 {
-	data->nodes = kvmalloc_array(nr, sizeof(struct io_rsrc_node *),
-					GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	data->nodes = kvcalloc(nr, sizeof(struct io_rsrc_node *),
+			       GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (data->nodes) {
 		data->nr = nr;
 		return 0;
 	}
 	return -ENOMEM;
-- 
2.45.2


