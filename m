Return-Path: <linux-kernel+bounces-840991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E34EBB5E99
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 06:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810EB42814F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 04:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EC0213E7A;
	Fri,  3 Oct 2025 04:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPLD3Ddt"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C81D88A4
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465953; cv=none; b=nFWCB4jS14bg7Jc1A3bjq4Mk8irvoBkQZxVuMynOlWVqepqajcALGwTajtTR8KOlEImQMk4nZs+b9EJxC6ec0VB6LDBRfblToSgvtEP/bCbAoxPc8rCI0OlEz4f938WZSci9c7+G+bYXqBZCgjEcfIul1A6GeN6i6nSQsLm3pRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465953; c=relaxed/simple;
	bh=7VMPKWz5uYNRKWr5qHgYxgxuacRdmA+VUVAZxwMcJxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TupkcGVVPw9TzdSTgps5Q21kwni8TKRNbD2hDIu6V50SYNMtSIO1+TpkBGFiiJKqB8wJV6xgbfO+d+c9yypSk/Sq8ljeMhN8wM1VSgFWqSmCdtRIO9bggTI8cRrkZC9zYHiNEE014Bzj20lSeEFae0SJ9RK7GyyKsatA3K9X6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPLD3Ddt; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso3174906a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 21:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465951; x=1760070751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z24lKsLPaefpARjOZTyt8urU57ilAGB24wkoWzevBy8=;
        b=BPLD3DdtB8ezPycD7XV3c2ksupBMXIpPLNXQFJ4fnB4qJJGkL9lu8iUiIqg43OJCSn
         fvX/Ymv4ymYTXYEejadMn/MKhLI3GhPNwY1jYT43Y53la8sjKYvqI+IAf9LxftAnbI2U
         xP+NwaMJb6bhCYTMwFCi6q5Tnu8JO753X+Lr4ddfCraPBWOz2fYFovDUb/LClNhWxu4U
         /y70RHJl5VDQGp7CsZhi2FjF15MNtCI+UeMEzjm8XYkrGCwTOjA4r9uOXncxmQtND3K7
         vT3jkq44UdKrRkSzY/pS5mSZh6WI6wFZRW4fMyfppsdHx9Naxxhl7kicLSXNY71LUBgV
         +6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465951; x=1760070751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z24lKsLPaefpARjOZTyt8urU57ilAGB24wkoWzevBy8=;
        b=Zw91ADRTx5MaifgmU7hyDaJjrBxGug/pcF5q51kneBGk9nyIjMEVngvntR5tWEBztz
         EyPv0AxJXNrGCWimaLBrdUSnGg3QoVjg5YAbSE08HA0bunB9v3BN5Zb/7XkNNdD8YF0r
         9W+2gCKzo95wrLozoBCNziAS5yvsKGZmiW2DfAh1QxEv6DOZjoV+IQv0kFkQL/OX3auL
         tC/beiS+5aSP2tX2jOaPc0QWI1JYybN8OruzHjnaQcl6MMhkP3tcJBGb9u1doXmSXAQ6
         U/SI0HG3DSEptm66dRUbb6ZuJ6IMayzjJaCbRr/BXvyHZGKFxNvxTN+9pCZr+6zGAu3o
         cloQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeiWhqGCbivF5Xf3wGuOeqQy5PneMQxKs1CCrznMMcMi5Dl0Bst0wvx2rGnbj6McqeuoqyD4pBEDFrVh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC/FBlncuzayePnX7vwznXaAiKzcVtLWvaMGvk/UyFbrOijZat
	E+dPpIeSAzVO/z8oDI91wpJJJ2URYg0RURY/BzReO6BJhE8op4CzJnCu
X-Gm-Gg: ASbGncsUc5YZzjkynwJF/G4hPXYOHiKB75L2mFT5MSmtgz61VaS1NDc2qjOgpkw/oQ7
	LYbQDcTsosh/GXrW7aXoTaFP3uEUlNKe3WmsB5/t2LP00wMVzyRso/OouikC4j+qlvUppCbs0uE
	SdI3HwCURxDNjR9UUcq0dOEFBrNs8qXYXBbC2T8hGUO0OOPuM1fodtkg0Dhi0LKctyNBVjiUghL
	f6TqlisS61Xu41R4I50vcIIdfjy4J4Qr9oDrc7iZlMPvCuD2jYEv1melW2AwF4jYp6TzgHJSsKi
	Y/SBi9iESsz9bzq3tjAvdHAxmN8ngyVxujL95VIJx+XosA47DgwLOB8Ok5qoCQzqHaNIRkIDEBe
	MN9yDSlr8K8Y8x31t+H9s0y6ZRuoYWdt1yrQabdHxOh8GevngG7e2HqDd9OcUkjCXZpgko7f9/k
	EVM/PLmwfWINMsrNMlb+piYSUaWX9sQb7QU0lPDY56BBeeMrFE92JJ
X-Google-Smtp-Source: AGHT+IGILMEf9Tw/o2u8qdi5b+EnvPskNraurbyacR0IziRkBvpz30elIe0oEPrEq1mEn5hgoKypZw==
X-Received: by 2002:a17:90b:1b12:b0:314:2cd2:595d with SMTP id 98e67ed59e1d1-339c20c099cmr2180806a91.8.1759465950687;
        Thu, 02 Oct 2025 21:32:30 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 4/8] nvmet: Expose nvmet_stop_keep_alive_timer publically
Date: Fri,  3 Oct 2025 14:31:35 +1000
Message-ID: <20251003043140.1341958-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0dd7bd99afa3..bed1c6ebe83a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -430,6 +430,7 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
+EXPORT_SYMBOL_GPL(nvmet_stop_keep_alive_timer);
 
 u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
-- 
2.51.0


