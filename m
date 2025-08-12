Return-Path: <linux-kernel+bounces-764113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8DEB21E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EFF503060
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F25A2D781B;
	Tue, 12 Aug 2025 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JYH5YnHQ"
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46F2C21C2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979711; cv=none; b=eWGq393aSSNwepcU5WnCFGigp5ZbtmAoccGsyYFM8WuicliT1SIFVhbhhoOyWTMEtXotszqVFBs0O9asiQ15oFt8MxCvjDBBaTfoPDixv0aZSTbrNmIw5bpd4WKGHNmSsvE1tikvlxl6afmZHwkFyWyCqKZ63MahKNb+Z+iA5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979711; c=relaxed/simple;
	bh=j9SeDoRL/zhcDIxNSS4UctRBSHg1RCzqAgMYHl9qkqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qgkKbFtxRd3b9wWFarXTZPA0OejaNSsMt+3iL/y36JGheBGUMZZ5+V/6VgYjGQ/cIZnaSSyWpBuGWbqnCfCzA9K4SL5rQXjBh1zXp4ow1EB//O9Gv34Zakop9YZJPpUBVNgJlzfRCGMlISWPpCyDikzXmt6eAcNIiIah56AqoEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JYH5YnHQ; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3e40ac40940so24859025ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754979709; x=1755584509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCHLE6MOqroEiy+1R8X845jTZo3rM4OTlMeoN6yXvZg=;
        b=UlSHIUJbeEbtjHocZCjSjxQNIHOZPHQWtwaKE+scgyPkzWgl+czwA7Gvg8ZirzHNDk
         m3sdVCgiE6Icl+WBLCJdGD4JHFw2L8SLkg0dTg8gCDBUmTxBqWvdZ6+gb0uj7BNQ4wIO
         gfSQ4szo+Gs/lA2eYiUJPdXFoHzAF5pkTwtvkjhFSK+5CnxDOSSdXDDIgaVPT9ahJdW6
         IOO2e1D4hrwrDV36hdHlObMFr7lcMYLDqkZTKEVcyGq9ZnnlxS3ZNkIbX/bc3PTMtbpd
         tah5BBAIuWjMZrHrkjEjquwNxN3OBWuDRsoSNEFm30UCHoO9wcYXBXrRGH7heXawyZIF
         czjw==
X-Forwarded-Encrypted: i=1; AJvYcCVVDNbxkDxMyQAQEAMeMoB06lL9G+lxdTdFytVaVhs5/RSk1ffHnNmIzcAO8Ax2xIGrJ4m8PyvWJd7YBho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2nCUuhZe8OjpfCZNBdG/noGTB7jp8Mpp6BTHZYsfjyKRby1A
	Dq0Q9Jb0c6wDFg5n6jEBWC5JBFqhOk1a24dPvEBX+rd63+NoJVYj79Hmd5wbjZitw6lRB1LB73j
	Lmd4RbTHQ4/1M8ZI/6fAwHsbNIDGrJZ5NBALSbIqVpdpRm/rArAaOIR0Y4wN7dTO5XzdEuwA0tV
	HUMRtiU3mYQ0tZbJHS8/rrqqD3H3j3o1ervEqGyr0vU+iSjT+KA4zsY0ItOJDU1U8BWETzjRnLa
	6lJweJL/S0GHiPFyKlYTyQ=
X-Gm-Gg: ASbGnct55EUxOJPATT6W1gWEbWHi4nW8LwHqG4AqV6kduB4UMe+EYtS9uj/G13lGDJz
	fi6JE3ykbikA089NnUzpjO4Tvyh6Ox7sLaVci2k8enorNd+UGHlF6fpesvN7XH8c5Y2B0+zPrfw
	WEtZE8F4Deq9LzBJC5RbJP+iYuiM18qTQnOLNAwVY9sJ+GCIXs5FXTdE3W9AJd+axImJo18jtb0
	v4LEqvV5cycjXXXBVEhCeuYd824Euld7FCQnILltHJMBIgUUEby0KkpaMYsE9sg00JiJ71nVL7A
	f4/uz2fLarwXWdzs1LGSIcVmqL2H753u5hKZg5k/weke9ltYiIfUSpWKHD8v33s+IXZYEQ3CIpr
	KKtWpMPYjEQtVz+gY3yeKfCjXM/vW3sgHZWzN4zyXYE0WLUVKh3UzOavq+s6bh3OLzPiIfTV7bz
	xuiiLxYw==
X-Google-Smtp-Source: AGHT+IHc+QegXKVOo4WKeHLiggmA7tvDHTe/1Kov7hdt1vMuwmOWdDIzStSdrHM3Lic3Jdpbk3cxaGVdpyXD
X-Received: by 2002:a05:6e02:16ca:b0:3e5:54d9:67b1 with SMTP id e9e14a558f8ab-3e55ac34dbfmr37256565ab.5.1754979709297;
        Mon, 11 Aug 2025 23:21:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3e533ccf918sm8406095ab.45.2025.08.11.23.21.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:21:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e82b8ea647so1066859185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754979708; x=1755584508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wCHLE6MOqroEiy+1R8X845jTZo3rM4OTlMeoN6yXvZg=;
        b=JYH5YnHQbjvf+g2d+XFQbDxl2nbUFvOxWnBsmHvnGvFI1TWIWIWCVnG2DoR1dfbL2Z
         0J+p6X/inANSbCCX8XWudKGae6KIVgy+n500419nVsgyUyptzq/we3Mqo6sJbXT7sNda
         DskgSjig9wC/ajj7H8A/IMEN0qNYeiV9+qwo0=
X-Forwarded-Encrypted: i=1; AJvYcCVrHPY/pBQI0jGfDg9DSSUpk96xti+9RSSnxWf0T7cGnYtPWQTLrce1YUlWDyy3xkuBP/Nr3MaGuflFSa4=@vger.kernel.org
X-Received: by 2002:a05:620a:bd6:b0:7e8:71b:96ac with SMTP id af79cd13be357-7e858daee46mr342622385a.11.1754979708280;
        Mon, 11 Aug 2025 23:21:48 -0700 (PDT)
X-Received: by 2002:a05:620a:bd6:b0:7e8:71b:96ac with SMTP id af79cd13be357-7e858daee46mr342619985a.11.1754979707824;
        Mon, 11 Aug 2025 23:21:47 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e826e22c13sm800422385a.50.2025.08.11.23.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 23:21:47 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	James Smart <jsmart2021@gmail.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] scsi: lpfc: Fix link down processing to address NULL pointer  dereference
Date: Mon, 11 Aug 2025 23:08:22 -0700
Message-Id: <20250812060822.149216-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 1854f53ccd88ad4e7568ddfafafffe71f1ceb0a6 ]

If an FC link down transition while PLOGIs are outstanding to fabric well
known addresses, outstanding ABTS requests may result in a NULL pointer
dereference. Driver unload requests may hang with repeated "2878" log
messages.

The Link down processing results in ABTS requests for outstanding ELS
requests. The Abort WQEs are sent for the ELSs before the driver had set
the link state to down. Thus the driver is sending the Abort with the
expectation that an ABTS will be sent on the wire. The Abort request is
stalled waiting for the link to come up. In some conditions the driver may
auto-complete the ELSs thus if the link does come up, the Abort completions
may reference an invalid structure.

Fix by ensuring that Abort set the flag to avoid link traffic if issued due
to conditions where the link failed.

Link: https://lore.kernel.org/r/20211020211417.88754-7-jsmart2021@gmail.com
Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index ff39c596f000..49931577da38 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -11432,10 +11432,12 @@ lpfc_sli_abort_iotag_issue(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	if (cmdiocb->iocb_flag & LPFC_IO_FOF)
 		abtsiocbp->iocb_flag |= LPFC_IO_FOF;
 
-	if (phba->link_state >= LPFC_LINK_UP)
-		iabt->ulpCommand = CMD_ABORT_XRI_CN;
-	else
+	if (phba->link_state < LPFC_LINK_UP ||
+	    (phba->sli_rev == LPFC_SLI_REV4 &&
+	     phba->sli4_hba.link_state.status == LPFC_FC_LA_TYPE_LINK_DOWN))
 		iabt->ulpCommand = CMD_CLOSE_XRI_CN;
+	else
+		iabt->ulpCommand = CMD_ABORT_XRI_CN;
 
 	abtsiocbp->iocb_cmpl = lpfc_sli_abort_els_cmpl;
 	abtsiocbp->vport = vport;
-- 
2.40.4


