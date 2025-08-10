Return-Path: <linux-kernel+bounces-761610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0EBB1FC76
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E455C3B7611
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0790329B79B;
	Sun, 10 Aug 2025 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O9d+Ajgz"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987601DF97F
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754862850; cv=none; b=h/vi6F6XICBGfarCwx2SUkdPEkQo3QtzvL/ytzhAj9MOVDSADRmGH76CCnWh2EXjCN51HWaCUSaI1pdIU5kIuVAcC7YplreBEU8LuXP6HZwj6lq3w16ab2FcfEycy/ARURCCPmcI9LGgumdwvW+LLCWa+0P68uLsepSh7I7xn8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754862850; c=relaxed/simple;
	bh=vSsSMn/9fqoTxHujBDUpBLFjebEiHOOZRkvaVIYfVn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Whh0RVQ9I7JSOdKBgBI36XlI8iJwI3+D4erf4dXHVoAwqMH9l9sNgMYl7ekf8HP3S1DLr94CGVsWD3ijOcS7M7qweL1oHSV7RKuM2dYszr0c4OwJbnaWRGLvK27ycr4JTmw2sIgsvxxrJA02gheSbTcu21Qqw+gWW3yKu8RKvSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O9d+Ajgz; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754862835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EV2BWPFCHA/5r+SQ5/78lZ/eRjTiq2HMm+8pHdqqWPc=;
	b=O9d+AjgzxdqIL094+cWBPrSdagjbrk3RJCGN6XJ63TFuhFxdM3+9N/nY3R3eAexVxOTR/W
	oOfykWWqm+IbRMffpSHCkDdTyYOp9BS9vdzn/il4pUZCH0XCN5QYK1Qo3laKiltuOn4Yha
	iU6u0mYWDSKmmeRlcYAxSpRlC+ihAFw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] Bluetooth: Annotate struct hci_drv_rp_read_info with __counted_by_le()
Date: Sun, 10 Aug 2025 23:53:20 +0200
Message-ID: <20250810215319.2629-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by_le() compiler attribute to the flexible array
member 'supported_commands' to improve access bounds-checking via
CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/net/bluetooth/hci_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_drv.h b/include/net/bluetooth/hci_drv.h
index 2f01c44f05ec..3fd6fdbdb02e 100644
--- a/include/net/bluetooth/hci_drv.h
+++ b/include/net/bluetooth/hci_drv.h
@@ -47,7 +47,7 @@ struct hci_drv_ev_cmd_complete {
 struct hci_drv_rp_read_info {
 	__u8	driver_name[HCI_DRV_MAX_DRIVER_NAME_LENGTH];
 	__le16	num_supported_commands;
-	__le16	supported_commands[];
+	__le16	supported_commands[] __counted_by_le(num_supported_commands);
 } __packed;
 
 /* Driver specific OGF (Opcode Group Field)
-- 
2.50.1


