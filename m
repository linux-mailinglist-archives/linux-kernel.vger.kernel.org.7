Return-Path: <linux-kernel+bounces-801348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1BDB443F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9901A43996
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45EE30DD02;
	Thu,  4 Sep 2025 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AMWec8tx"
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F7306D40
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005755; cv=none; b=oNLzGrcAYp7ewkAieVkbXUnF7WGWvsTMqcxGxsj6kqt/Sgxsn/khfF2ePl8Cgwe+U87lkOTcfKBaeGeFGOGu5zcVBPSMBK9cB8ulDLDo4YIhnglp10H+xt8wKw/rLn17f38+4NAWPIxwWf8kjTpZcFtamiyOGga0HcgY0VMiZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005755; c=relaxed/simple;
	bh=4EJdvMqrIYCvAJeNvKYQAAuONryGXpzTRoA/GVqa/Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NK/lLIx0/OU4y0P6VVstpsD4PjMe8i+vobwj0dG4ZQciWLW8DFWAEIL6QDSBZfiht9hPni80buLNJnMJvCXgygCRVWxpNGQVBnEGyzLnEnPYFlZ03Osds5wg1ZF8PvUfD+eUWXtwEDx8AFyiPDaxiDOg2wCqyM/vzSICo4pQRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AMWec8tx; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3f0505a3b59so511905ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757005751; x=1757610551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVTxjV0mJqvDlcDpQyKjIaqAIkiVF/PV1uLNyI2CP5o=;
        b=AMWec8txgLGA7vwM0Z/K6Yv90nXf4C3IQaIjR0lGZiZ1I+g0POEjvzaXqrg9aCpiEK
         9rQWvm9uW4nZYWZ0ZJL/qCaipoyRe+/z5FO26c/Jz/S8Jz6F5n8PG6hJ/2a4f+fLtuaI
         AVbLGywfQNDeEiXNNMhjR8aEsBxXm4mqFeplJjPVTtVQqRAWH5LaSa/d7kuH5UpkijW2
         vc5905fdsdDDyW3wBoREk07P9jV946YYWFULB9Ylw1uGPcT9hMc3+YVhY4RcQ0aUZf7y
         xzUBIlcYvFXumKf2KBwrcPlLF6zEyEjRNA73pE8ptgSVCg0YOLsjINcA/t58OCJR/tOK
         MQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757005751; x=1757610551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVTxjV0mJqvDlcDpQyKjIaqAIkiVF/PV1uLNyI2CP5o=;
        b=Dw0dx3MqXpEpjy64c0ZYLvLX7qIOutUDX+nj26crfEJ1M1z1tNX79fBQAb1Cm/rJ/Y
         Sa6LtR33vavj+Ke0CxPlISocrN1Ho1Ybg3RyA9OREC7EkF5vI9mqwujz/O/4ldDUatZd
         p6ZWkM5e45d8to4l6Zq+fKgZ9guQwFci0qT+Ng57AFCfQWrRdLS/+n1IZEBcS+pOsc1m
         btmAQu0ZjpB8qPS2e0Rk2BgknDpy2Smx67i3VrLz0SuvVmLiZ4j/Rf5D7xx64rKm+GnU
         IrqZ8byCXXyDyNdGG2s1EHhTOIYrUcUGtNakeel2st26jskffJqU5qSGvv4rZzY0mK8Z
         Km3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVv04BfB7LwQLxvpoOCOLCOdasjczI0XacfGFIH7pgnHDJvfGpUu9HAMX5ARDFoPTPUy1cCY9FjB8C5918=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK4Cxani1jfG1L7E1rfendgSV5JT8F0yapqkW+axtxcNmJMtvT
	uwHUgwrBqaKm22NoWB15RHB01+HT+eT/TYNv4sUb3H22SdGVsngR1G1TljqHMamMt3hq573h0rU
	vGqkZ0cykkgj/LoRAD/vZGKctwEcChWlSsx3D
X-Gm-Gg: ASbGnctOPxCCs0QE6p/7UBa9mI6+Gxd5C18T8iL7geJsxM5Fa84Oz+GS/DC+VgVvEEc
	qBnbXd/LHo3bnTtGXom2DiR91rfjIIgzuTP8sMBZH6TkM44YG8hqDIELzX1MiF3zywXSkYLyHOp
	o6yDXjYZlx00Vr3wH5ZdoAghBI00OI98kOkrrnVf4dJ5HAH6uSZKkDflVpdT7PVhktS+wC06/pS
	kLVEI6Lo+LIupKGpPQc+M2xuVTyiadgiIQf4FKcJGn51WxkSW+kfNed4Anbd/dYl7S6aiuKMpFA
	CLK/7rD0gRYZ+ixSrh2qo/49sgjB7A29nZPuyo2UQ5diUOIeWa8vtzzoe+BWpeV5xIrQrikf
X-Google-Smtp-Source: AGHT+IE0lZfGt731rn5d1UAUZe1ngI1v3uSXy8aFU52mwbq1dHjZ9I2FSA6BGtpmM4zV4hgx5lsHZhfmladu
X-Received: by 2002:a05:6e02:1d8c:b0:3f1:a5b9:4a3a with SMTP id e9e14a558f8ab-3f3221b05c1mr128641845ab.1.1757005751241;
        Thu, 04 Sep 2025 10:09:11 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50d8f31b06bsm982808173.48.2025.09.04.10.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 10:09:11 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 005B83407B4;
	Thu,  4 Sep 2025 11:09:11 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E1D28E41979; Thu,  4 Sep 2025 11:09:10 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 3/5] io_uring: clear IORING_SETUP_SINGLE_ISSUER for IORING_SETUP_SQPOLL
Date: Thu,  4 Sep 2025 11:09:00 -0600
Message-ID: <20250904170902.2624135-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250904170902.2624135-1-csander@purestorage.com>
References: <20250904170902.2624135-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IORING_SETUP_SINGLE_ISSUER doesn't currently enable any optimizations,
but it will soon be used to avoid taking io_ring_ctx's uring_lock when
submitting from the single issuer task. If the IORING_SETUP_SQPOLL flag
is set, the SQ thread is the sole task issuing SQEs. However, other
tasks may make io_uring_register() syscalls, which must be synchronized
with SQE submission. So it wouldn't be safe to skip the uring_lock
around the SQ thread's submission even if IORING_SETUP_SINGLE_ISSUER is
set. Therefore, clear IORING_SETUP_SINGLE_ISSUER from the io_ring_ctx
flags if IORING_SETUP_SQPOLL is set.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 42f6bfbb99d3..c7af9dc3d95a 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3724,10 +3724,19 @@ static int io_uring_sanitise_params(struct io_uring_params *p)
 	 */
 	if ((flags & (IORING_SETUP_CQE32|IORING_SETUP_CQE_MIXED)) ==
 	    (IORING_SETUP_CQE32|IORING_SETUP_CQE_MIXED))
 		return -EINVAL;
 
+	/*
+	 * If IORING_SETUP_SQPOLL is set, only the SQ thread issues SQEs,
+	 * but other threads may call io_uring_register() concurrently.
+	 * We still need uring_lock to synchronize these io_ring_ctx accesses,
+	 * so disable the single issuer optimizations.
+	 */
+	if (flags & IORING_SETUP_SQPOLL)
+		p->flags &= ~IORING_SETUP_SINGLE_ISSUER;
+
 	return 0;
 }
 
 int io_uring_fill_params(unsigned entries, struct io_uring_params *p)
 {
-- 
2.45.2


