Return-Path: <linux-kernel+bounces-722338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4B3AFD851
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F00D57B3C82
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FE1246793;
	Tue,  8 Jul 2025 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Whn2coy/"
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F49B23D29B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006147; cv=none; b=Jd/dZylicKkRXaZD8r9E7a05tV76YxoPmWEuXHWS7s1BnuQfSsM30YFaX6G7NtVz5rUA+hrJ4U4vip5ZiIJ4WT0GiZgzoxn0xBpTYBtI1KN2FDOWBm1J0fnll2iHq85aTmALy8Dv6JGb+iYulZZJPqDbfYS8w77L0iVzowL6i9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006147; c=relaxed/simple;
	bh=4bIax1gyYYvpqMt8cPConX9wmrpXrYqQG/XPD2e8Ioo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/qT/7sYn1KJDgBzrXwUcM20ZefUADTTfa2WzhevlQzDUm8BfkQW1XnQndvTRNN9CYGxvG67mLFfU+NMrwEwi87RwEbRVYAsjbmgvXmdhtkhml7FIkb35FsgiOPRANk1h5hiQ9/ks6uQ+9rhrmuUG5+VUAw/Mwg1C1//RULLYZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Whn2coy/; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-2da39478181so850506fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752006142; x=1752610942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbVhQv8YJGYKLE0LWaArA9jYunrRwOqLWNMX36zOiHY=;
        b=Whn2coy/AFtW9ZPM+z1T2oH+6PoZhgsVQVCVe1CY2MCwCZDWPnGU4SdSu6ujxixljo
         Pl0MLQP6uico5tRnGCOyEQ0lnPeJ0flKLrF8K1p+xi0nlwuEHkJiyG/J/SDc32U16lWi
         l2PGmV57cNLNno4DI6/AM7DypdaSPu79+CE7kHRAq0S5ThHfF54DJ7xIJOmz2hfeN3sS
         wtEZ5fWLnXZC17tNYp05J2cgjSAR7UpSGKnd6ox9RMh7TPlpy2cs0SEjYv3I/91TnGht
         QUN88DmeaSbTsiW87q9pQIrA4ebMfLCPvfky5whTgQvxT/dfD7xIlJJ3+l6ecPckwHJ3
         yCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752006142; x=1752610942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbVhQv8YJGYKLE0LWaArA9jYunrRwOqLWNMX36zOiHY=;
        b=qwxyAl94/12kV6gwrYv+ewDESBSbvVKnT1F2Kq7tqfctEtsccgtdjocroLguRfHAB7
         NNIYKNr9FwcbxQg2Tv1O8/YvZ+FOQb+iasGmmSWeXUwrr35sQKboSmPKvWXjVpt6U5UX
         2EvjRN38W3/1HT63FbHANWS8JXYYaAzmfLICoElsepB69tTewHQvcNy5/chh0MJZagGB
         HdPaYs9F6cfc32nUd0QtpFL2+XDR7DK0QH8gY7LrQrbbJQK58wZbcCXkqXDv8wXY3v1O
         E3zv9RSC8q3Iyx39+RatCqNEPz2H+ZiO4HncgyplOE+Y0b4GrgARcEG/gxj3gOnvWIfX
         I05Q==
X-Forwarded-Encrypted: i=1; AJvYcCUb+Q5JGwVSgK/LiJmTg27oDox3z++WiNHHMULL32Kdqrscix8KouUAKwumsKYlw6/jFGWBjTQpv3Mm/Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB4Y9FvHj71BHVY8a2yL8bbtmhODS2gCIzSDxBr6Tc4u7BF5Fg
	4ptwl9kSuFI88EloiqUjaOfbUcbM2PDQ1mJVE0ci4AWjsk1+Y/pL7kCZNuTlUfgGGoKqfWvwLgc
	RPjP+0BVTAeVwaqxYwrtjmWtnjhjsm1JwAr8uZVgDmrWVoS6NpXc+
X-Gm-Gg: ASbGnctU47z5nVPSRyeN8t8QfUnGP9/DRvtdW+5k+iEGAgLsU+81A2DM4orvLVQUDH8
	nePo1Hi/MBtXoqcKLEW1BVKHeJlowCd3NVz37l5V+Dkp/INbe/G921EqKCKzwZF0G7rI8ljcBn7
	azibybETN3ipvP1jzy+yULgEWox4Ln+J51tOgMxufXNrrBYWeJanSzqjikBRC+krEKs9dCgq2cl
	/saEW7+XuNWZAejrQ8S1fdu+cz5HV9ceKESL7XWiTWlIigktPAVzdaCYmHf+c1Jvo9bUXHLM1VT
	2bqXl0FaMjnPqG9EIysdXU+kyFp/RmXhc/en/2yM
X-Google-Smtp-Source: AGHT+IE8YlKT/00F+Yu2SYeEG2yU67VWu/UZkefui/vdHgZzLvAUibn1j109YPG+6uWbe8+4Dc9QKFIVL0m4
X-Received: by 2002:a05:6870:e0a8:b0:2e8:f7fd:6a75 with SMTP id 586e51a60fabf-2f796a0b1afmr4657958fac.12.1752006142392;
        Tue, 08 Jul 2025 13:22:22 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2f78fdff09csm717795fac.8.2025.07.08.13.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:22:22 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A4BA13402B1;
	Tue,  8 Jul 2025 14:22:21 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A2B46E41CDE; Tue,  8 Jul 2025 14:22:21 -0600 (MDT)
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
Subject: [PATCH v2 2/4] io_uring/cmd: introduce IORING_URING_CMD_REISSUE flag
Date: Tue,  8 Jul 2025 14:22:10 -0600
Message-ID: <20250708202212.2851548-3-csander@purestorage.com>
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

Add a flag IORING_URING_CMD_REISSUE that ->uring_cmd() implementations
can use to tell whether this is the first or subsequent issue of the
uring_cmd. This will allow ->uring_cmd() implementations to store
information in the io_uring_cmd's pdu across issues.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring/cmd.h | 2 ++
 io_uring/uring_cmd.c         | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 53408124c1e5..29892f54e0ac 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -6,10 +6,12 @@
 #include <linux/io_uring_types.h>
 #include <linux/blk-mq.h>
 
 /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
 #define IORING_URING_CMD_CANCELABLE	(1U << 30)
+/* io_uring_cmd is being issued again */
+#define IORING_URING_CMD_REISSUE	(1U << 31)
 
 struct io_uring_cmd {
 	struct file	*file;
 	const struct io_uring_sqe *sqe;
 	/* callback to defer completions to task context */
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index b228b84a510f..58964a2f8582 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -259,11 +259,15 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 			req->iopoll_start = ktime_get_ns();
 		}
 	}
 
 	ret = file->f_op->uring_cmd(ioucmd, issue_flags);
-	if (ret == -EAGAIN || ret == -EIOCBQUEUED)
+	if (ret == -EAGAIN) {
+		ioucmd->flags |= IORING_URING_CMD_REISSUE;
+		return ret;
+	}
+	if (ret == -EIOCBQUEUED)
 		return ret;
 	if (ret < 0)
 		req_set_fail(req);
 	io_req_uring_cleanup(req, issue_flags);
 	io_req_set_res(req, ret, 0);
-- 
2.45.2


