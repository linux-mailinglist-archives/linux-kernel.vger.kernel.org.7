Return-Path: <linux-kernel+bounces-757680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E277B1C550
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD113B8C86
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB10E28A3EA;
	Wed,  6 Aug 2025 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUsa2BFn"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8AA28BA95
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480721; cv=none; b=lmPcyf+oRzsbpMqpFCRQbXmFywUFq5ijRi7hYcP6JK51Yi/hLJPMJyZHYrMH+fnf1u2VCi9koj7dbt3vmuQN2Rd5QNwwMf3vTQkYNWpTDUYq5QPuDxA5toaesZ21GF5+v6A0P/x2DrCj+qI5qA3k5firclxQjSbI/bH+2gtLwiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480721; c=relaxed/simple;
	bh=F5eRXrtsxffdegpuQ0f4xPChPgfV/JPNT5j2y0VgMrc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RAX2ELpwKnl7djAGiGi9oPmvvweHFOnmssFRRyNLtapDoevXgArJ6CvDWViYBBQhfK6P6Hybd6fMM6rvdYBO9uBiRPqhQzT3woQX5ux25Bpq51UM7IUClBZp92adhYqlvuFdVqiInVVW+qDiomMPhy7vpEsHSqFz6sdCTg+FRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mUsa2BFn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso3814004f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 04:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754480717; x=1755085517; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzJczgeb2E2EatXdWgiOPTAxDTD2f2zBu8DeU1yQO2Q=;
        b=mUsa2BFnbNPGG+KtAsxrAg4KKJUIQlbfDjU1ZVbwgHYBeSj445hqorARUFAaC6vuWd
         f5k3SYTBxoBT6VMgKWJTOJixcf3TORX5ogXM978FTjlVRILTHjbuy8nDUxdKGoInt7CB
         Swm+G4uiqyxJEx4OZggG1W14sq5DL9ciR5tpclVBY2vC1DEFrmrXZVLq6njvs8DhOwQg
         zGM/RzPs8UT0SYu1q5K6pg52Jna+wF5hrWAicHiAeX1Bqwe3RI+lYyWSPlV+/430nkuF
         w2UOtRNPvXYFMO1p5bGgWW12TEGO6kEk9wXqT+WHUkvkhAK92H5f4HpxLF8VsP1wQb8d
         xzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754480717; x=1755085517;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzJczgeb2E2EatXdWgiOPTAxDTD2f2zBu8DeU1yQO2Q=;
        b=bqYaUx6oKKw/M2PCp1SSXNxs51nw64JMA/koGmj2rarGMw+laAmpwa8zXITDe3/LkO
         kHZ6roUr5KPon+Ur5nM483AHd9JV2Z1bOEGIZ9LpzCU9+Ir5wr9i+IOqgzacBC/nPvCT
         OPE1Blhzcnc5rKv6dqu0sL94ju4x/XXFLjWOumpGDY+BQ7o/sPUx4TLyIRaN2jLKMHpD
         JVaV74pOnOCc6CWGki568i7aRM0h1ACYrzcvqT/MaNQKyhjh3LfE9pyXwrK4lpkLlz6d
         WV5zubXnhqsS7Yu7P0axI3s7YPEwKKN9yluHur/C0zZKmzVVM/a8zPUmZl0BzMF8Brvq
         e7jA==
X-Forwarded-Encrypted: i=1; AJvYcCUzUglnpfPweyMOyw+Q32yOY5spbjcfF0hJh9vI+M3cRNRC0woKMlK/LJtqNCKukEiX7hl+vgRZHAMACi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmS/4sEClqM5gCGpTWvYtZFo7JdraJ0QAF7tySbAvo2Hci7te
	EVRNH/DWcaKMBSR1u31UXIzL2GyZhOg0xHe2CwPfQqFQDrDMLplCgalbSBcR3gjYa/I=
X-Gm-Gg: ASbGncuQ5s+DFN5PlYQCv1wUtNZxCZgzkkgJ+2yY9Q1wSFvuIma9WbEikKYa+kJgbSU
	5Khq0zc4LUAWkXUG6PvjQYb4jkjUCOgl7K6uB6yRKJtSP3AFIEoJUOn8COBgKryFkh4TT966EyX
	/LX/4DT2z3M3Y+nhqjVW9ppejv4kvBbnp/IoQVlmRe4a40I8Md0gPL/m8h5Ls+DSDA2QGIa5/zr
	C/6KPH7nXPEXt0XyiTxAfdGay9FsV7y2FaXd8fj8s3eAh7SePCcNb/2XlHYQFy6Sum2wJQR9ojK
	v+ki5FGQl2GEiZg5b6kR4yguvRltgrrYT8BV6761uzgiVXgNLFmxp9Z8v1ns9T4aZPqAhhuom3v
	2Kba4f8eAH+0SaeTOeYK7XwHls3E=
X-Google-Smtp-Source: AGHT+IErH+bIbW86Py9obhBfpJ7Ic4nUmflEhhhvraU68gExR0HV14Ll3Dg9SWn5Dg7piKiH/oo48g==
X-Received: by 2002:a05:6000:2dca:b0:3b7:973b:39bc with SMTP id ffacd0b85a97d-3b8f41bea48mr2156278f8f.54.1754480716705;
        Wed, 06 Aug 2025 04:45:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459c58ed07fsm142317845e9.22.2025.08.06.04.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:45:16 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:45:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] smb: client: Fix use after free in send_done()
Message-ID: <aJNASZzOWtg8aljM@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The mempool_free() function frees "request".  Don't free the request
until after smbd_disconnect_rdma_connection() to avoid a use after free
bug.

Fixes: 5e65668c75c0 ("smb: client: let send_done() cleanup before calling smbd_disconnect_rdma_connection()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/smb/client/smbdirect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 58321e483a1a..162f8d1c548a 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -286,8 +286,8 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_SEND) {
 		log_rdma_send(ERR, "wc->status=%d wc->opcode=%d\n",
 			wc->status, wc->opcode);
-		mempool_free(request, request->info->request_mempool);
 		smbd_disconnect_rdma_connection(request->info);
+		mempool_free(request, request->info->request_mempool);
 		return;
 	}
 
-- 
2.47.2


