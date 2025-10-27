Return-Path: <linux-kernel+bounces-871423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC76C0D35C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C562C403DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57BF2FB975;
	Mon, 27 Oct 2025 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXAcYIUR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478E1C861D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565284; cv=none; b=i3UlYve0B05+siQekiSEuoEBFgSgI4diKpAZ/7gTXzb6ojHrxw9FtUmTiTvhdDuWSM7Oucjx8UpSBbFCj1ZWqTuwGkZe+LAJloSMTfr0tmElyzA2GpDmj2Hsgp+/I6v0hBBoXc2VtG7fmn3oWUfxkZgR1iVWsXmLIxzHq2EBWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565284; c=relaxed/simple;
	bh=C1os0nVHtXRwt9BMyfjrMM3Csgl5ES/7g62ugKPD+ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfLRJse8orqgFRsEviG2Yg9ZSk+Bc/oZYwkOPjq3XVPPhqlWHb1wygqCEP0p1tAztO3ZyP+RN26xM8Hat1i0c3cpmSx+kobMKEREbz+3O5u7B9H1C2wP6ucgQ+R4p4IqNE6UWdlvbPcamC7/Os3LnPks/8XTYbuBC/48RwJfvo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXAcYIUR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761565282; x=1793101282;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C1os0nVHtXRwt9BMyfjrMM3Csgl5ES/7g62ugKPD+ow=;
  b=NXAcYIURLCcu+VPIN67BIwPvEclnL5BPfetibWN6c9iLbCnvf/8YIcSK
   AYE+PNqwKt5auswjoN2srMvZsQi2qdnmDihOQj7N+iqbI24z2qknAyG09
   bBwGmZeHHeOoCWBjbmbd319TSBsCtkulqiRRXbDY3kVG3atWPhe0qz675
   8qlt+0FD8vOyMYcCxUynxgczDJXqrgpPmyXUsxD6Sa8ufkBSjWxseHP0J
   pRDTc02+osmNpNvyobcyCyxIPGQ/42FrNbQuZMuI65DKMODq1cowW+QVq
   KIlRCjvC+xFuY+h7t/fnIJ2UA8UDbxp/xETpfmgRGUAE8J/citZAX/gfJ
   A==;
X-CSE-ConnectionGUID: 5qPuWA4xSSW2gF4n9e8Vhg==
X-CSE-MsgGUID: hDAklK1/SxeoMgpYBkpAtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86269872"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="86269872"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:41:22 -0700
X-CSE-ConnectionGUID: aobMIM/sSzKGYfd/bfB3zw==
X-CSE-MsgGUID: x2oaKL2yRsSBocvEx6aJRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="185106471"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.31])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:41:21 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 72C5A121E63;
	Mon, 27 Oct 2025 13:41:18 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1vDLbC-00000001df1-1gUY;
	Mon, 27 Oct 2025 13:41:18 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/1] mei: Remove redundant pm_runtime_mark_last_busy() calls
Date: Mon, 27 Oct 2025 13:41:18 +0200
Message-ID: <20251027114118.390775-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/misc/mei/client.c    | 14 ++------------
 drivers/misc/mei/interrupt.c |  2 --
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 159e8b841564..5dc665515263 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -709,7 +709,6 @@ void mei_host_client_init(struct mei_device *dev)
 
 	schedule_work(&dev->bus_rescan_work);
 
-	pm_runtime_mark_last_busy(dev->parent);
 	dev_dbg(&dev->dev, "rpm: autosuspend\n");
 	pm_request_autosuspend(dev->parent);
 }
@@ -991,7 +990,6 @@ int mei_cl_disconnect(struct mei_cl *cl)
 	rets = __mei_cl_disconnect(cl);
 
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->parent);
 	pm_runtime_put_autosuspend(dev->parent);
 
 	return rets;
@@ -1167,7 +1165,6 @@ int mei_cl_connect(struct mei_cl *cl, struct mei_me_client *me_cl,
 	rets = cl->status;
 out:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->parent);
 	pm_runtime_put_autosuspend(dev->parent);
 
 	mei_io_cb_free(cb);
@@ -1554,7 +1551,6 @@ int mei_cl_notify_request(struct mei_cl *cl,
 
 out:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->parent);
 	pm_runtime_put_autosuspend(dev->parent);
 
 	mei_io_cb_free(cb);
@@ -1702,7 +1698,6 @@ int mei_cl_read_start(struct mei_cl *cl, size_t length, const struct file *fp)
 
 out:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->parent);
 	pm_runtime_put_autosuspend(dev->parent);
 nortpm:
 	if (rets)
@@ -2092,7 +2087,6 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long time
 	rets = buf_len;
 err:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->parent);
 	pm_runtime_put_autosuspend(dev->parent);
 free:
 	mei_io_cb_free(cb);
@@ -2116,12 +2110,10 @@ void mei_cl_complete(struct mei_cl *cl, struct mei_cl_cb *cb)
 	case MEI_FOP_WRITE:
 		mei_tx_cb_dequeue(cb);
 		cl->writing_state = MEI_WRITE_COMPLETE;
-		if (waitqueue_active(&cl->tx_wait)) {
+		if (waitqueue_active(&cl->tx_wait))
 			wake_up_interruptible(&cl->tx_wait);
-		} else {
-			pm_runtime_mark_last_busy(dev->parent);
+		else
 			pm_request_autosuspend(dev->parent);
-		}
 		break;
 
 	case MEI_FOP_READ:
@@ -2366,7 +2358,6 @@ int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
 		mei_cl_dma_free(cl);
 
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->parent);
 	pm_runtime_put_autosuspend(dev->parent);
 
 	mei_io_cb_free(cb);
@@ -2444,7 +2435,6 @@ int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp)
 		mei_cl_dma_free(cl);
 out:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
-	pm_runtime_mark_last_busy(dev->parent);
 	pm_runtime_put_autosuspend(dev->parent);
 
 	mei_io_cb_free(cb);
diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index 3aa66b6b0d36..3f210413fd32 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -229,7 +229,6 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 		cl_dbg(dev, cl, "completed read length = %zu\n", cb->buf_idx);
 		list_move_tail(&cb->list, cmpl_list);
 	} else {
-		pm_runtime_mark_last_busy(dev->parent);
 		pm_request_autosuspend(dev->parent);
 	}
 
@@ -310,7 +309,6 @@ static int mei_cl_irq_read(struct mei_cl *cl, struct mei_cl_cb *cb,
 		return ret;
 	}
 
-	pm_runtime_mark_last_busy(dev->parent);
 	pm_request_autosuspend(dev->parent);
 
 	list_move_tail(&cb->list, &cl->rd_pending);
-- 
2.47.3


