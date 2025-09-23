Return-Path: <linux-kernel+bounces-828846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 204DDB959D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09D42E15BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5EF3218DA;
	Tue, 23 Sep 2025 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtShq0u8"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF95D3203AE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626452; cv=none; b=aPhW3VMqTj7SBFew41+pPARBQZuJfvSrFrj7uGenfendhjR8pCn68azmQDHISp6j23/B36FnpSxQluN2Hx2reub48g/dv2AVmTHrCceVwHx4i4oCLOIKj/tGyZ72qfrlxo2+eBVnYTieucpq2CPmx4k9ya9K1GDGRhL6BUZo2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626452; c=relaxed/simple;
	bh=eJliZ++5VLobZbvP2Qe72C0QCu7EczhThEbLO5tMavE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QnaNvJNsyM/XD9K2Z5amibTpypEZIIYCQg6ASKYvd+yzp3DnTbBXW1rkyqZN27E/zdVUzSZJDZw25ez0LLpKFITerXDMmZBvAhHQQ8qp59VuXOISHSHglIhoUROPRCn1gFsHQ/FcYKoyLkqikaMhUKjPg1+iq4/bXlszoDod6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GtShq0u8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f0308469a4so2109193f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758626449; x=1759231249; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9zredUSynQCwtloc7g5NGofS4JgiDu7n8B9m9/iOKfE=;
        b=GtShq0u8Ox+G+as6n1sQ/UNEvHSUL4sGvdmQ96ylXy0rGwgmK0D7e09CQQcxSNohmv
         zYfTD24hWO2afThqKXOqWaj104tmEG6HAR3wgKUkIjI65DUfflw9WvZJOtMa5WRh2KnP
         D2z6Mngj3zC4KqbSECmXiQWcZrlDqtJhF8hbnrtbRhc2d+weKtwPNmiMl8UjRwbJn7x2
         4gxPKr63AbVOiQXcuPRaNIVp+D7HCewRHhG9TP+gR72enuioAzLSESrGDU2OnjyYAFfd
         VV3pA2z9ov9Z0F5CkV2jJUfsKkNbe0KuBioMhZm/57LFu13Xnt1Q/Y66e/GGv0upH+I0
         SK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626449; x=1759231249;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9zredUSynQCwtloc7g5NGofS4JgiDu7n8B9m9/iOKfE=;
        b=h8GDw4TJuy4SamCej4T2B/oCED9PdUxD6UMuOKsxrXf6CsEsEFemsyPyRSSiiZB4ZW
         ykQwK/n7yoMKH1TW7qAy44BhS1fL67gLsVRO/plCawLHCOpk3ZYvEO/7xMprGjK54thm
         Jy1jZ+Yp1YwtrUtbNqvhTj/wbOeiV82GigJelK9J843A1ynokAq9j2hZ9Y34YZsu/yPD
         E21KXVAsn2IyFAR8V4lOo9SQSmYJFr53XkX221X5xE14aVWHSzkjUlm4PEdmM+7a+i/K
         CHMTkkruB9MWj4bbTbwztUuK3ugPr6koufor1iKMLurwUDI+mnBjzxci+odyUp7On51c
         fiqg==
X-Forwarded-Encrypted: i=1; AJvYcCVRknTiCkZX/zS0ztvlaEcVLj6YhoCtAWh+UktGbuy11d+9sgDNgYGn1O/yoKH8G1wG9AL/J0dgpFlXeGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOLb1kMue+rOL4UeJrkWg7SIr/0jfw3aWun3/DhxYAljxiCnSB
	J9EhkSizj1L0OUB1H5tZT5XixYmzlQBbwzkLubHVZulP9pK/JszigdGUu+lNf35ny4o=
X-Gm-Gg: ASbGnct2GmrKv4C+H08SC2xDt4km8HszU7pqd7ZxyiNcm4ul+Q9guTZTq22t6/WKWLF
	Qbic+9ZPQBE3bJXa4jU/nJ/Mu6NTXrynZa/YZR+9q284MyoNnipms7G/a8r6Fcf0mGDu5vhq0XM
	WGzjCmLCcy28oIyqQTKW+GlV9UrynQKCm7HypMwLSTPKuOahaxPImD1VkKFYJgyr1S4ZslpnXH0
	28wf6V9WvsHaDzYRl+E3AyPqEfc2wkNlHNpZnC5q61nLS4DgByEoG6wtdJzKC6DU+KIEU16WUI/
	4SI/OxzWClDMdFgdPnilywrPYdCAcN1vx7FbqB5MUxdRbF0jko4UrLqMlvJmuSQ40B4VLuRYHug
	JRcDaBjFIOotvXqB3tlZx+1DlBZ62
X-Google-Smtp-Source: AGHT+IFOLWwlUksxJsVUnIS1To44S+BUbgVSaPlPESYIl9UWZxAJU0rpuoUTCO7CBZd1r0VNy84pmw==
X-Received: by 2002:a05:6000:40da:b0:3f2:dc6e:6a83 with SMTP id ffacd0b85a97d-405cb9a5341mr1917861f8f.59.1758626449168;
        Tue, 23 Sep 2025 04:20:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbc7188sm24521715f8f.37.2025.09.23.04.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:20:48 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:20:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Faisal Latif <faisal.latif@intel.com>
Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] RDMA/irdma: Fix positive vs negative error codes in
 irdma_post_send()
Message-ID: <aNKCjcD6Nab1jWEV@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code accidentally returns positive EINVAL instead of negative
-EINVAL.  Some of the callers treat positive returns as success.
Add the missing '-' char.

Fixes: a24a29c8747f ("RDMA/irdma: Add Atomic Operations support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 24f9503f410f..f9d9157029ac 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3966,7 +3966,7 @@ static int irdma_post_send(struct ib_qp *ibqp,
 		case IB_WR_ATOMIC_CMP_AND_SWP:
 			if (unlikely(!(dev->hw_attrs.uk_attrs.feature_flags &
 				       IRDMA_FEATURE_ATOMIC_OPS))) {
-				err = EINVAL;
+				err = -EINVAL;
 				break;
 			}
 			info.op_type = IRDMA_OP_TYPE_ATOMIC_COMPARE_AND_SWAP;
@@ -3983,7 +3983,7 @@ static int irdma_post_send(struct ib_qp *ibqp,
 		case IB_WR_ATOMIC_FETCH_AND_ADD:
 			if (unlikely(!(dev->hw_attrs.uk_attrs.feature_flags &
 				       IRDMA_FEATURE_ATOMIC_OPS))) {
-				err = EINVAL;
+				err = -EINVAL;
 				break;
 			}
 			info.op_type = IRDMA_OP_TYPE_ATOMIC_FETCH_AND_ADD;
-- 
2.51.0


