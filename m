Return-Path: <linux-kernel+bounces-877502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED45C1E470
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA60188E330
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552B0285071;
	Thu, 30 Oct 2025 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii33pclx"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5095429B8F8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761796296; cv=none; b=D/kjAxOkbZoJp4pzM0daZDjrY9zp1QLiOzU0fCMsJ44y8vKj0dnRq8qkstFcL10J4qpWUQODDmVWvCLbunnaO0xvwx7G7awim7i5CBDyU35lNNtRlvB1mq0Ds7/qUd8lbPxCoeyILdw11n1P/ybADD81HnkXd2R/QDTOfYghnXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761796296; c=relaxed/simple;
	bh=IsJxZQkO57xF953K5xHhWXR0z2NymjzNWHGtiMrLTDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJh2KuPgs8SNpzJHv8C6T19WViyoTCVvLljFLosqKweHhGhkmAcQAeVcAofvh/qdel3yKzVjkOj8pdUqemgT9hw9I8s0jtEp0RqMThbZnGiLIAH2uCYi+26G+Ep7CUo7ZhFb6RFZHTEOjTbpqDyVZ6XmJOa2l9F5H6rNGK8ouPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii33pclx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-294fb21b160so1428345ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761796295; x=1762401095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN0fRpH/PCnIiX5ASSuQg4IoluSNnvJUR3iBGHC2JFI=;
        b=ii33pclxTNLvQFHHngkm6pLnwD37UPg1AGKSMvHVGhkisZD+rIDHKhhTpZS5qrEOZ6
         5i9bTFP1UhviHFfJLewzkWt+Kc2Xd7IRtyuhIFog8UKJk/QV0W93CMN6Y9SeRSmD1YNd
         AKVri7L0QXDipGrAnEA+He0+C/pLh7bxprdIA3QwZrRHha4+QmqKG8lHw+Rg8Hkrh0yK
         Kd+DluB2ClC2ZO3+frJl/wXV4pdRTR3OOJO3x9kDl94ckHVuY9HBNh7NryZUVhKPLkm8
         m2p2GEwzlUQm+fv24ic8ouV0Q2kk7kraomYwxRnRsZmIvk/kxtbe+SelEWREW1kkl1ej
         O99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761796295; x=1762401095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN0fRpH/PCnIiX5ASSuQg4IoluSNnvJUR3iBGHC2JFI=;
        b=Rv1nKUuHTSM6o+cj6KHEnyJ6UUKKR67jBSTWs7nuqMNcK3sBa9boHsB9ahrPd5SIpL
         oJtyFWuNxXBAvrlYjXLxmSJljUFMun2N1XPL33qi7kIy8o/1D3KGaqy0d//mMUobCNdd
         4L43f1oHeg+X+9wf6+DtwEPkLAfKWwOmG1yoN3wxRNYUetn9AMS/5ZkEr9TgZxRHTz9y
         IT4pMiILBdiouLYkGERpsdn/bkGdbw9znE3r62hcAgDPG2IkSF1RqSOzgg+uP4yaPUE3
         Nhpe7RJB3dnEUyV3K1KVHS86nUp0qNHgifviXAfXchfR9Uppy64gXxDU4a6fH1l4J9wU
         H01Q==
X-Gm-Message-State: AOJu0YzdjZM1+unMxLxK3j6sbLoiF8nSt9elH/BabTeO1nIh+0uaQz7d
	C/H046rYaXMxhICCpW3Lo01q1PV/MkfsZIKda1JUVbcrUUBQ8/qzSg5T
X-Gm-Gg: ASbGncsAi1bgIm8Ot+1QPOnRxPdvyz+DB2m2TsXZVRBVGMyfkJbpRQP+812P0U0v3fF
	eVarnEAdv5sN/ioeqArMZG/ZsGPQcVvb7vvt7bab+nh1Y/9SUyw6NBNCpY/mvTctLMKIqxd0hlc
	+h/+v++M/MfSWEE7OMCjslxmtFXY/wM9TDgGuFWNehFBMxpr/3YwXqEGjRyVIkvYAWamEGHNr6e
	M4/+cjrnMU0iyf0ztDSJaiLq037q3Visx1s3NM9zNMrCTwohS98ux6DAERYtHXfTmlq5/I4n/eC
	/oNmqjstUamKyy53FS9qPn6V+FFQ7++43aOkKVmK5HUH5mMB87GMEWjXBv2abL2asAIzCZ6U8GO
	DAXlcrwRUrzcq8twPgzCGR/hmLrFl63uPAO9i+uQIQVWwIJidhdV2lM/yQu0FGrCUXGzxWLUelt
	iH5Jlo9lYXDWiQfSDaLjgwVuCLmLODGEdVvyeXAv21SoFQO8bCGwDzVfQ7T9tFSHRKkL8DWLrvk
	IZu3ikZwA==
X-Google-Smtp-Source: AGHT+IFDmCt6OxS1lG5usvyxQO/ayx75zbEn+wDdcRO8migbMEW884MG+r2fTQz9vUZXdmTRBF86sg==
X-Received: by 2002:a17:903:2344:b0:24c:d0b3:3b20 with SMTP id d9443c01a7336-294ede8b3d5mr19471615ad.37.1761796294581;
        Wed, 29 Oct 2025 20:51:34 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3381sm167953225ad.16.2025.10.29.20.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:51:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/3] nvmet-tcp: Don't free SQ on authentication success
Date: Thu, 30 Oct 2025 13:51:13 +1000
Message-ID: <20251030035114.16840-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030035114.16840-1-alistair.francis@wdc.com>
References: <20251030035114.16840-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Curently after the host sends a REPLACETLSPSK we free the TLS keys as
part of calling nvmet_auth_sq_free() on success. This means when the
host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
check for !nvmet_queue_tls_keyid(req->sq) fails.

This patch ensures we don't free the TLS key on success as we might need
it again in the future.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index f71456a94b66..5cb857d21dfd 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -574,9 +574,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, d, al);
 	kfree(d);
 done:
-	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
-		nvmet_auth_sq_free(req->sq);
-	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
 		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
 	}
-- 
2.51.0


