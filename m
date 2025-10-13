Return-Path: <linux-kernel+bounces-850953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C78BD4C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA71188A0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D4F30E848;
	Mon, 13 Oct 2025 15:49:33 +0000 (UTC)
Received: from konstriktor.siski.de (konstriktor.siski.de [5.9.99.39])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8E224225
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.9.99.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370571; cv=none; b=gWju5KgcQ0vfNdGC1Gk0qf734UA4pNAcOMTynQHDVSBEcQVs8fffOcbpPhKYWrQweAhUHNdfroEXZ2idQtoNOEyL+2u6PgXwZ8W+/HF0myBFtT3+/S2N7c9odsz/A4QToY5IEYqO9e7bl+p9tlnRLyox+AM6QbvFpOLjRDcMqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370571; c=relaxed/simple;
	bh=20lUfQyjBhpWg7jlnKA9FxsxLAEM0/vjdWanK5AVNio=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JXxrJl9Rjo7xwDjXisYdljSH8upMDgNr1FXt3YIAbvoIQfEWTrSohK7Sg733pXraTy8c/vKBTuggI12w5OaKlPmN8YLJ0DE9/8Uaa/ltSAvS39UUGEjbMLF1hS1T8QrV2/MF4jV0XdchLARci2a3ZwsEgWVRQoLnLXnv12ArVO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siski.de; spf=pass smtp.mailfrom=siski.de; arc=none smtp.client-ip=5.9.99.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siski.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siski.de
Received: by konstriktor.siski.de (Postfix, from userid 3015)
	id B739E32801E4; Mon, 13 Oct 2025 17:43:12 +0200 (CEST)
Date: Mon, 13 Oct 2025 17:43:12 +0200
From: Carsten Gross <carsten@siski.de>
To: linux-kernel@vger.kernel.org
Subject: Intel iavf: Queue count cannot be increased after iPXE boot in
 6.12.48 (Debian trixie)
Message-ID: <aO0eED8yVkgF3FI8@siski.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="I0mnNbF/GVMYYdj8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


--I0mnNbF/GVMYYdj8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello alltogether,

I'm using an intel E810 card on a proxmox/qemu installation. The virtual
functions (VF) from the E810 card are imported as PCI devices into
virtual machines running inside kvm/qemu and are supported by the iavf
driver. 

The iavf driver should use as many interrupt queues as configured during
startup of the hypervisor via
/sys/class/pci_bus/0000:3b/device/0000:3b:01.1/sriov_vf_msix_count (this
is set via udev for all the VF). The hypervisor system is running Debian trixie
pve kernel 6.14.11-3 using the "ice" driver and all virtual machines are
using Debian trixie standard kernel 6.12.48. The virtual machines are
running with at least 4 cores.

This works as expected as long as the virtual machines are not using
iPXE boot (from iPXE.org). iPXE boot obviously uses a function to force
the PF (physical function, i.e. the driver for the real hardware) to
configure only one interrupt queue for the used VF. This can be seen in
the kernel log of the hypervisor while iPXE boot is running.  This
message is logged by the hypervisor if the virtual machine using VF 10
is doing PXE boot.

ice 0000:3b:00.0: VF 10 granted request of 1 queues.

After this this VF number 10 only provides one interrupt queue for a
linux virtual machine using debian trixie (Linux kernel 6.12.48) and
this cannot be solved with tools like ethtool inside the VM. Even if the
VF is later assigned to a different virtual without iPXE boot this "only
one interrupt queue" stays active.

I tracked this down to a patch from 2020:
"[net-next,02/16] iavf: Enable support for up to 16 queues" that removed
the possibility to increase the queue count via ethtool and just uses
the queue count provided by the PF (but in my case that is configured to
"1" by PXE boot that is running before the Linux kernel is started)

I did a manual change (see attached patch, kind of reverts the above
patch) the introduces the possibility to increase the interrupt queue
count manually via ethtool inside the VM.  This worked, the MSI-X
interrupts were established and I got 4 queues as I ordered via "ethtool
-L enp1s0 combined 4" and the MSI-X queues could be seen inside the VM.
This was logged by the hypervisor:

ice 0000:3b:00.0: VF 1 granted request of 4 queues.

This means I've a working example that the functionality of
increasing/setting the queue count is currently missing and how to fix
it. Personally, I think to make it acceptable patch that does everything
"right" automatically some additional work is necessary.  It would be
great if someone could look into this. 

I think it would be a good
solution if the iavf driver could read the MSI-X interrupt count from
the PCI info like this would be done with "real" hardware and configure
this via the VIRTCHNL_OP_REQUEST_QUEUES message to the PF.

Thank you very much.

Regards,

   Carsten Groß

-- 
Carsten Gross            | http://www.siski.de/~carsten/

--I0mnNbF/GVMYYdj8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="reverted-test-patch-iavf.diff"

diff --git a/iavf_ethtool.c b/iavf_ethtool.c
index 74a1e9f..cea2d82 100644
--- a/iavf_ethtool.c
+++ b/iavf_ethtool.c
@@ -1650,7 +1650,7 @@ static void iavf_get_channels(struct net_device *netdev,
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	/* Report maximum channels */
-	ch->max_combined = adapter->vsi_res->num_queue_pairs;
+	ch->max_combined = IAVF_MAX_REQ_QUEUES;
 
 	ch->max_other = NONQ_VECS;
 	ch->other_count = NONQ_VECS;
@@ -1683,7 +1683,7 @@ static int iavf_set_channels(struct net_device *netdev,
 	/* All of these should have already been checked by ethtool before this
 	 * even gets to us, but just to be sure.
 	 */
-	if (num_req == 0 || num_req > adapter->vsi_res->num_queue_pairs)
+	if (num_req <= 0 || num_req > IAVF_MAX_REQ_QUEUES) 
 		return -EINVAL;
 
 	if (num_req == adapter->num_active_queues)
@@ -1693,14 +1693,7 @@ static int iavf_set_channels(struct net_device *netdev,
 		return -EINVAL;
 
 	adapter->num_req_queues = num_req;
-	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
-	iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
-
-	ret = iavf_wait_for_reset(adapter);
-	if (ret)
-		netdev_warn(netdev, "Changing channel count timeout or interrupted waiting for reset");
-
-	return ret;
+	return iavf_request_queues(adapter, num_req);
 }
 
 /**
diff --git a/iavf_virtchnl.c b/iavf_virtchnl.c
index 7e810b6..fb3286d 100644
--- a/iavf_virtchnl.c
+++ b/iavf_virtchnl.c
@@ -426,6 +426,33 @@ void iavf_map_queues(struct iavf_adapter *adapter)
 	kfree(vimi);
 }
 
+/**
+ * iavf_request_queues
+ * @adapter: adapter structure
+ * @num: number of requested queues
+ *
+ * We get a default number of queues from the PF.  This enables us to request a
+ * different number.  Returns 0 on success, negative on failure
+ **/
+int iavf_request_queues(struct iavf_adapter *adapter, int num)
+{
+	struct virtchnl_vf_res_request vfres;
+
+	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
+		/* bail because we already have a command pending */
+		dev_err(&adapter->pdev->dev, "Cannot request queues, command %d pending\n",
+			adapter->current_op);
+		return -EBUSY;
+	}
+
+	vfres.num_queue_pairs = min_t(int, num, num_online_cpus());
+
+	adapter->current_op = VIRTCHNL_OP_REQUEST_QUEUES;
+	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
+	return iavf_send_pf_msg(adapter, VIRTCHNL_OP_REQUEST_QUEUES,
+				(u8 *)&vfres, sizeof(vfres));
+}
+
 /**
  * iavf_set_mac_addr_type - Set the correct request type from the filter type
  * @virtchnl_ether_addr: pointer to requested list element

--I0mnNbF/GVMYYdj8--

