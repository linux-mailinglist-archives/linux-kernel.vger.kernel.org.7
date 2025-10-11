Return-Path: <linux-kernel+bounces-849104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA6CBCF36F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9AF74E3D4E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB10190664;
	Sat, 11 Oct 2025 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y89WU1Nt"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94520239E81
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760177130; cv=none; b=AnqYid4UhEJq/iyO36XdXPVxfWQBFbaHAjz5BBu9tzIF8x3w4Wzkx4bt++vNaK8y/fpIU+OTb1J/DT26lWhdFFjXfGd1TrYVoCI+Hix5w7jZsgrcWRADKgKWFTXWRp8bglQE8+B4H0Ja6zIZtcycQSppQO4NzhAAiuqZQnSHCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760177130; c=relaxed/simple;
	bh=yD7RQeZGhHxZZG7dRcZTyZ46jmCy1pYpkl90r+yN++A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ues5Pt++G8REg/XdC+K8+rXdTQkNCHiOhwEzhGFcxoQZe+cDIWCulfYqq7j7IDZjIh7UIfEjdEsaD9Q/inigIItSwu2U9emJW8gjjjyzoLbim5I1EOrQq5hUJv0IByzcu6SFD0AL/M0b3BzCwW8JAWAa9D+AS7LNjLqx2GaGkaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y89WU1Nt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1972925f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760177123; x=1760781923; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXYaUmEOzuGL83duQA4oeQUvQii86pnI5j6WSpb5AXg=;
        b=Y89WU1Nt3v0dpsDLjnTv69WOJFVC05Knoiwt4dHQS8nwp2CsLOqvWNsk36RNaEdWIT
         bDKVm5VjmJMtW8fs0NcV10ilc3OZL5HRlkqppS5hEzzcPMRJkM1apEPYAjCcie/jYuw6
         nKm5stq3PKE8BX1KuD0sLRBQm3vvzdJGKE14LyytyKxlWnV8bHT7ivHSAvukyLnD7tLP
         /NEZidtIj+UI+fBxG+lkNLqMS83wmQyMDNAlo6igWvKAa23DIsrssDv23BT3mhCf1qYD
         ckpYNxwHVJdhgbuJXN1KKlV6hw8gTYjXRiUbQY5FWG3iiTMRnhXFSgw65GANb1AlTDN5
         wl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760177123; x=1760781923;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXYaUmEOzuGL83duQA4oeQUvQii86pnI5j6WSpb5AXg=;
        b=PmBpQGJEoGtbmHo4QPwVDZ714I9QsX6PGVG0ylvmMatGpYavrEe9tER2VEk52BMaXu
         AYjWkN1urNO0MBlzbGziRzjwTLDsNm81lYgMG/zcEA4YyMlgmJOsp1Dh9NmimAcu8ODQ
         YX54K4Mp8u6KqqxX7CKhXV9tTPKm7CduVYtfeA6nyJMsMfld6o+4w3dpZyl/VsyIoRZA
         N/1sPGybhsQUOeXDqflq4oD7pdhRxwaC96i5XtsBUbMyVBQ65Fv76EinICPC3vCplWOi
         +XfNova4sCgxQpqqnYUagN5TMwpzrBG9h0Wf1ulPiQwI3Ej1dL4UmEE2j9/JAiMRRxgW
         s+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5peBgeLJXIISfR7BEQuF6fgmyhmOomac5zAUpH+Thy0VIukB0hU1bRc2pIE8vWVWKJm7BXIa2FopGoaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9lny94DExgtG53tjsZkajh+EJC8Lt6DZxAXWPFCytZTxmIChz
	n9d32IXs0IvtW4Pfjw/PZDrBU5o9Nm/4KKcE2xLuySQ/RfJxlHd1x4njseeq7Qkw
X-Gm-Gg: ASbGncvcn8sDXiC8JqIOclpJRLNFMvd+dDLmnmstlrwtEXFX80Ia9YemRxiTadEqKtj
	MlVs/eI5QRCBoBtL5Oz/S03IholP1+jwFqZyyG6i5nkLRmX9m9LydC1r79aiyx+NpstMQ6YgIwY
	kV007Xoa2aOW61ToqMdJsI+IVd00l5LlEwjOc0QQwgGf52bMuqB/9zbF7EQawL8r+bWgcPUgO/L
	yVgbG1WKxpHxAcVzjbrf5uIN/N70t2whPqhxPo8PVsmeWNjtsN9FT8mCMjNc4nSbd+i9jl6+f6N
	Jrm8HMq06U8JqvrxucpsF0WcWzHL48d+AsJ6HMVpD17U5p+XvFfNAr1JYkcgOpRf3nJ2RPbPTrg
	AVVj1QGlATwDKbh0PBqtyQvHIWA36Yp4EtE5iw3mZixZsIAkKafYkyUWNs1YfBzOuC59ZbbJT66
	k6d/xJ0iol+uoZ
X-Google-Smtp-Source: AGHT+IED+xW+ElM2Jk98y4tVQY3+aEOn3kG6bLSCsaiJiU9WRcJ/Fl4ROiHdoOx3iLBNRTWKdp4WQg==
X-Received: by 2002:a05:6000:2dc7:b0:3fa:ebaf:4c53 with SMTP id ffacd0b85a97d-42582a055f0mr12786285f8f.29.1760177122484;
        Sat, 11 Oct 2025 03:05:22 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cc0esm8322319f8f.6.2025.10.11.03.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 03:05:21 -0700 (PDT)
Date: Sat, 11 Oct 2025 13:05:21 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: vishal.bhakta@broadcom.com, James.Bottomley@hansenpartnership.com,
	martin.petersen@oracle.com
Cc: bcm-kernel-feedback-list@broadcom.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: scsi: vmw_pvscsi: fix license+checkpatch warnings
Message-ID: <aOor4Y2zzTBLr5NA@michalis-linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As suggested by checkpatch
  Fix licence by adding GPL and removing the address of the Free Software Foundation
  Changed unsigned -> unsigned int
  Added some newlines

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 drivers/scsi/vmw_pvscsi.c | 42 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index 32242d86cf5b..6091777dd37b 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Linux driver for VMware's para-virtualized SCSI HBA.
  *
@@ -12,11 +13,6 @@
  * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
  * NON INFRINGEMENT.  See the GNU General Public License for more
  * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 
 #include <linux/kernel.h>
@@ -76,16 +72,16 @@ struct pvscsi_adapter {
 	struct work_struct		work;
 
 	struct PVSCSIRingReqDesc	*req_ring;
-	unsigned			req_pages;
-	unsigned			req_depth;
+	unsigned int		req_pages;
+	unsigned int		req_depth;
 	dma_addr_t			reqRingPA;
 
 	struct PVSCSIRingCmpDesc	*cmp_ring;
-	unsigned			cmp_pages;
+	unsigned int		cmp_pages;
 	dma_addr_t			cmpRingPA;
 
 	struct PVSCSIRingMsgDesc	*msg_ring;
-	unsigned			msg_pages;
+	unsigned int		msg_pages;
 	dma_addr_t			msgRingPA;
 
 	struct PVSCSIRingsState		*rings_state;
@@ -325,9 +321,9 @@ static void ll_device_reset(const struct pvscsi_adapter *adapter, u32 target)
 }
 
 static void pvscsi_create_sg(struct pvscsi_ctx *ctx,
-			     struct scatterlist *sg, unsigned count)
+			     struct scatterlist *sg, unsigned int count)
 {
-	unsigned i;
+	unsigned int i;
 	struct PVSCSISGElement *sge;
 
 	BUG_ON(count > PVSCSI_MAX_NUM_SG_ENTRIES_PER_SEGMENT);
@@ -348,8 +344,8 @@ static int pvscsi_map_buffers(struct pvscsi_adapter *adapter,
 			      struct pvscsi_ctx *ctx, struct scsi_cmnd *cmd,
 			      struct PVSCSIRingReqDesc *e)
 {
-	unsigned count;
-	unsigned bufflen = scsi_bufflen(cmd);
+	unsigned int count;
+	unsigned int bufflen = scsi_bufflen(cmd);
 	struct scatterlist *sg;
 
 	e->dataLen = bufflen;
@@ -415,13 +411,13 @@ static void pvscsi_unmap_buffers(const struct pvscsi_adapter *adapter,
 				 struct pvscsi_ctx *ctx)
 {
 	struct scsi_cmnd *cmd;
-	unsigned bufflen;
+	unsigned int bufflen;
 
 	cmd = ctx->cmd;
 	bufflen = scsi_bufflen(cmd);
 
 	if (bufflen != 0) {
-		unsigned count = scsi_sg_count(cmd);
+		unsigned int count = scsi_sg_count(cmd);
 
 		if (count != 0) {
 			scsi_dma_unmap(cmd);
@@ -487,7 +483,7 @@ static void pvscsi_setup_all_rings(const struct pvscsi_adapter *adapter)
 {
 	struct PVSCSICmdDescSetupRings cmd = { 0 };
 	dma_addr_t base;
-	unsigned i;
+	unsigned int i;
 
 	cmd.ringsStatePPN   = adapter->ringStatePA >> PAGE_SHIFT;
 	cmd.reqRingNumPages = adapter->req_pages;
@@ -877,11 +873,12 @@ static int pvscsi_abort(struct scsi_cmnd *cmd)
  */
 static void pvscsi_reset_all(struct pvscsi_adapter *adapter)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < adapter->req_depth; i++) {
 		struct pvscsi_ctx *ctx = &adapter->cmd_map[i];
 		struct scsi_cmnd *cmd = ctx->cmd;
+
 		if (cmd) {
 			scmd_printk(KERN_ERR, cmd,
 				    "Forced reset on cmd %p\n", cmd);
@@ -1037,15 +1034,15 @@ static void pvscsi_process_msg(const struct pvscsi_adapter *adapter,
 	struct Scsi_Host *host = adapter->host;
 	struct scsi_device *sdev;
 
-	printk(KERN_INFO "vmw_pvscsi: msg type: 0x%x - MSG RING: %u/%u (%u) \n",
+	printk(KERN_INFO "vmw_pvscsi: msg type: 0x%x - MSG RING: %u/%u (%u)\n",
 	       e->type, s->msgProdIdx, s->msgConsIdx, s->msgNumEntriesLog2);
 
 	BUILD_BUG_ON(PVSCSI_MSG_LAST != 2);
 
 	if (e->type == PVSCSI_MSG_DEV_ADDED) {
 		struct PVSCSIMsgDescDevStatusChanged *desc;
-		desc = (struct PVSCSIMsgDescDevStatusChanged *)e;
 
+		desc = (struct PVSCSIMsgDescDevStatusChanged *)e;
 		printk(KERN_INFO
 		       "vmw_pvscsi: msg: device added at scsi%u:%u:%u\n",
 		       desc->bus, desc->target, desc->lun[1]);
@@ -1065,6 +1062,7 @@ static void pvscsi_process_msg(const struct pvscsi_adapter *adapter,
 		scsi_host_put(host);
 	} else if (e->type == PVSCSI_MSG_DEV_REMOVED) {
 		struct PVSCSIMsgDescDevStatusChanged *desc;
+
 		desc = (struct PVSCSIMsgDescDevStatusChanged *)e;
 
 		printk(KERN_INFO
@@ -1164,6 +1162,7 @@ static bool pvscsi_setup_req_threshold(struct pvscsi_adapter *adapter,
 		return false;
 	} else {
 		struct PVSCSICmdDescSetupReqCall cmd_msg = { 0 };
+
 		cmd_msg.enable = enable;
 		printk(KERN_INFO
 		       "vmw_pvscsi: %sabling reqCallThreshold\n",
@@ -1204,7 +1203,7 @@ static irqreturn_t pvscsi_shared_isr(int irq, void *devp)
 static void pvscsi_free_sgls(const struct pvscsi_adapter *adapter)
 {
 	struct pvscsi_ctx *ctx = adapter->cmd_map;
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < adapter->req_depth; ++i, ++ctx)
 		free_pages((unsigned long)ctx->sgl, get_order(SGL_SIZE));
@@ -1328,7 +1327,7 @@ static u32 pvscsi_get_max_targets(struct pvscsi_adapter *adapter)
 	header->hostStatus = BTSTAT_INVPARAM;
 	header->scsiStatus = SDSTAT_CHECK;
 
-	pvscsi_write_cmd_desc(adapter, PVSCSI_CMD_CONFIG, &cmd, sizeof cmd);
+	pvscsi_write_cmd_desc(adapter, PVSCSI_CMD_CONFIG, &cmd, sizeof(cmd));
 
 	if (header->hostStatus == BTSTAT_SUCCESS &&
 	    header->scsiStatus == SDSTAT_GOOD) {
@@ -1489,6 +1488,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_LIST_HEAD(&adapter->cmd_pool);
 	for (i = 0; i < adapter->req_depth; i++) {
 		struct pvscsi_ctx *ctx = adapter->cmd_map + i;
+
 		list_add(&ctx->list, &adapter->cmd_pool);
 	}
 
-- 
2.43.0


