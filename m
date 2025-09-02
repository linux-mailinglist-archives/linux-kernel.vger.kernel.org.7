Return-Path: <linux-kernel+bounces-796332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D231AB3FEEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7596B7A1DFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA430649D;
	Tue,  2 Sep 2025 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nzlbz7w2"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B72FFDC0;
	Tue,  2 Sep 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814228; cv=none; b=P58CakZEicAbl81RgwheJjBaSLX4QRC4KpCrkS7tBQNIKVGgc9hrFVuM3HXTJDNM9ttnPhF3GmRtRRLp2ued9SOedmo8mCMFaGsmiKXeCFVP5F7xsSLD75Tzv8OfaPGXWzqThfCrERGMfRR3GE8whUurlAEikllan0HH1YZ0KDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814228; c=relaxed/simple;
	bh=9uEZ6utveXtfTTMtUje7zgLsdsyYKMyPkIX+8uCOD1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rGqJD7u0H0CsvQtXrGK1y30z/gxESn+L1dMBhyLFGj/3ecz0fVcunjDvIG2V55bzIUvs/KQvbJppFx4X98djnP0FTvjwAMJrhjSKNLag70wWMrpgXYIR0hFpcHFHqtQ5/yOVNs6X2otNVHr0hcMVlFrf4mMShPQIZJyeU+iXVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nzlbz7w2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814224;
	bh=9uEZ6utveXtfTTMtUje7zgLsdsyYKMyPkIX+8uCOD1w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nzlbz7w2COjp10kn3HfBIfWqCXrKFSRW254ZfL5WFL/uXZGxVx0DmY+hqe9SUZxWu
	 v4ADLH/kSK02+ooAY3OAjdM6Z1IuhtDoe6+XUvfxrdXHPcVz2az962/W9GVMhjE54/
	 UAdvkyGuSZx13nbb8xci67hSZRnR6rbXVKJAa4bi2RRNuJdMrcx6u7lNkPzZ5tbifZ
	 2Z74rOuS6+zSS6TNgZvgnoRsrJk96nWZVNzS6FTVEEYU5/FBXdze8fIkd2ik//XHnZ
	 nScZJddoOhA7n4d1Nst5q0wN8naVQx0lsiIghNg8yjxGvMFssZ66/tU8liA3zijUmr
	 /RPifgIstZl3w==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 3017417E0C21;
	Tue,  2 Sep 2025 13:57:04 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:32 +0300
Subject: [PATCH 10/17] usb: vhci-hcd: Simplify kzalloc usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-10-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Use the shorter variants as suggested by checkpatch.pl:

  CHECK: Prefer kzalloc(sizeof(*priv)...) over kzalloc(sizeof(struct vhci_priv)...)
  CHECK: Prefer kzalloc(sizeof(*unlink)...) over kzalloc(sizeof(struct vhci_unlink)...)

This also improves further maintainability.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index e989be33ada00d5073f5753b72bb71d349c67b83..5b9cc84947781f79d69751ebda950cb293db7cb6 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -670,7 +670,7 @@ static void vhci_tx_urb(struct urb *urb, struct vhci_device *vdev)
 	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
 	unsigned long flags;
 
-	priv = kzalloc(sizeof(struct vhci_priv), GFP_ATOMIC);
+	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
 	if (!priv) {
 		usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_MALLOC);
 		return;
@@ -926,7 +926,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		spin_lock(&vdev->priv_lock);
 
 		/* setup CMD_UNLINK pdu */
-		unlink = kzalloc(sizeof(struct vhci_unlink), GFP_ATOMIC);
+		unlink = kzalloc(sizeof(*unlink), GFP_ATOMIC);
 		if (!unlink) {
 			spin_unlock(&vdev->priv_lock);
 			spin_unlock_irqrestore(&vhci->lock, flags);

-- 
2.51.0


