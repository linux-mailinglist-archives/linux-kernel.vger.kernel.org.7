Return-Path: <linux-kernel+bounces-722335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 374F7AFD84B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0ACF4E03C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05F9242D88;
	Tue,  8 Jul 2025 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ej9tjHnw"
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298F23D289
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006144; cv=none; b=S9zh4PGWq00gqDl+VUOV3YxGG7laxKIZFAl415gj8ERUI0pzD9N003NSJcambRZ/evfJg97c4E1SpCYcr57S5Za4Q+/sQdBQsxF/+gkUhk1jsZ0IndDx6ojuv9jkz+aythO7ehl3rzdCHutsKcmTsbcZR2mS7bJ7Bdl/KICebkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006144; c=relaxed/simple;
	bh=K4VZVi3xDLWT0DEl3LNGUBjrD17+mi5NFECXhkIiWrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RllNDZUS7L48Obsb5dRfx3qRviOswsXW/0gOd57U4IcWEAoy3UUTpXWvKWyabZraqr8IvKcnFhxiPXGBiet6nbJs58iwl48T/eEQwShPBjqTFLkKuS/6klOrBrUUcROWEBzZ4j2kMYXF0UERSeV3v5ZExbywcg8e0H717CkyS0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ej9tjHnw; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-8749beec4faso22962239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 13:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752006142; x=1752610942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd50J9nYsG0TeiIeJPqTSZq8OKqwb6u/EH2G1EHnbLs=;
        b=ej9tjHnwPQOvu2AwCbPDthCD2tzHNrSkl0T+E2Onn88MUdrXwzHOOSjIyBg6fliKPF
         sf9ZqSzcP9h7gMmdiJldzni8+95nnAh6K/V2t+VRnJQWAj2UBybfQvPGd4AFMhPfUZAV
         kVOhkfMrO3sXnh9mmxgrzOmfmpMN1A7ODrCR3BwLLZ/N1HmFmQKfvE8g1Ci6baKUw9xt
         whe1OJ2tA8CUjBb5Zjkp5oogYjA8p8LljYlOqyFY9hizuvg4yLBdYcsDJLOG/PMbWNOt
         NWFWQr/8gdRnfQLjFX8a3XQGtACUfCSg6vPhjZEwvjy10fsUK91g96hqCmqC0jn96Ut2
         1gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752006142; x=1752610942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pd50J9nYsG0TeiIeJPqTSZq8OKqwb6u/EH2G1EHnbLs=;
        b=EMSaU+ixZ9pRBJO/QP6hoKiewL2+WFyO2AQl/ILagRmim05ibWVslZ8aE0afg0QGGR
         3SQywL3vpMyR6LqHdqVPsHlHs/NgryNwmVmCORXtg0AWW8FOVnRbagIwhbekjaLw//Yj
         ybfqqI0VBZA14fgg4PhRjfbg9tLP2F/39b9EjTeCWVkvj5BHjAA/fpZjhAkUB/uRufUi
         HnarXqFxnP6zHxWMp6N64+6kVk1z/EW082MOMQd7A5mb9v7fXfWj15wb2F2VIeGt/gih
         d9RBGh/CVkd61ZNJ+H1ANGeicpgrFYUcfUcYt+LDJsn4K77x7/XVonCW1HX3sDZeyNFC
         sThQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd5xMsLQMr2n9wBS3LIv8g1qnB07hg2Y9wYhTh3pEdZHN/s5tm87XjkNnSQH35fJI5f2JveLKdvNBkUhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxddbwgxE6EtPUPCqRtKiW9Q1uTR76P445tDxRPhxIzdB+YZBAh
	QKZ4B2xQaVstNUjmCgMgINe33HUzpfEDOD/g0Fx7PDlqkGp/UrThO9mHCZjVJOiWL4C1z6DhLdQ
	ii6DkBt1tj1VBVsLhKPwsFVhMOh5gzOxQ9I2t
X-Gm-Gg: ASbGncvYhyrGFU/cItF0Lkh35E29kB+KtuSF0MX4KvSLJK+nCqFJxIvLJJyz79QpkFA
	kPU6In6fnMHQbpkEmj1IiBpDuJYZOUbIFDBEfnTE95b9hWSQwzOuhG+qRzlXR5xgJTXdl50znst
	GtZrFftrKp/tGZhu4xsxwi8MaJd3Bcycf3UUOX99loaA/jY5X+rhDCPeFMDfFXHtN9CQoqr6V8x
	b92xvaGKJp2jphMF2ZaY+Mh9uMcS+Yw6Cb/Mtl6V3iOMq9zDsqbwMXT7zpE/hsnmh2aAPzhE1qY
	Ep0M4dBh/Bn/ziIbcPpQv9NGAIK0/MHnxeOMHTZ1CThqN8xaOMtwm4s=
X-Google-Smtp-Source: AGHT+IG+alU718jhrtLgwSBCn0Hg1VyWjiAmiqngDIW05UDrmRiP8JyfLGPlu3WX7iH1exrAX1XOBeOJ74cm
X-Received: by 2002:a05:6602:2cc9:b0:876:a91a:9076 with SMTP id ca18e2360f4ac-8795b08bfcamr2487939f.1.1752006141957;
        Tue, 08 Jul 2025 13:22:21 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-503b5a14ca4sm385101173.26.2025.07.08.13.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:22:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 20B8F34050C;
	Tue,  8 Jul 2025 14:22:21 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1E893E41CDE; Tue,  8 Jul 2025 14:22:21 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Mark Harmstone <maharmstone@fb.com>,
	linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/4] btrfs/ioctl: don't skip accounting in early ENOTTY return
Date: Tue,  8 Jul 2025 14:22:09 -0600
Message-ID: <20250708202212.2851548-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250708202212.2851548-1-csander@purestorage.com>
References: <20250708202212.2851548-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs_uring_encoded_read() returns early with -ENOTTY if the uring_cmd
is issued with IO_URING_F_COMPAT but the kernel doesn't support compat
syscalls. However, this early return bypasses the syscall accounting.
goto out_acct instead to ensure the syscall is counted.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
---
 fs/btrfs/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 913acef3f0a9..ff15160e2581 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4827,11 +4827,12 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 
 	if (issue_flags & IO_URING_F_COMPAT) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
 		copy_end = offsetofend(struct btrfs_ioctl_encoded_io_args_32, flags);
 #else
-		return -ENOTTY;
+		ret = -ENOTTY;
+		goto out_acct;
 #endif
 	} else {
 		copy_end = copy_end_kernel;
 	}
 
-- 
2.45.2


