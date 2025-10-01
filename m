Return-Path: <linux-kernel+bounces-838477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFBBBAF459
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE5016B929
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441CA26FA6F;
	Wed,  1 Oct 2025 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWX+ABg4"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29794248F57
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759300879; cv=none; b=rfLmloCmNPjFq/cRJ4Q14m7f+Pm0VivcY7yt7B7LKYJzhwOQ1jQj2Qz2YlhK+RLjmRMttEvqUdkMCmuzzIyfNqhNAsvjK73sy1lFbX5KkSgkVn6JHh+WUpVXTWMRdU0TNW61ybwzegLqHrPNtIce7000W50uhuaEx9Bfycj+YXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759300879; c=relaxed/simple;
	bh=733alPMo5xFF1kelhQ3Sbdb4fpf2EA/GpXViQ8Pcwmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k1vY5QMDjjiUiDYIV/LGVHaNSDlKvuyiTQFLiI+sXoSVEfloedm9oX4S2sUN/rNubH3O+375ayL8t7TrWlJoLDJDPE//aM/b1IqJRwJmjrn87I1wR+G4U49IDrso3qy3lvHmEzDZUoeMNyAeidNQT2xk7o9QKi0CZCE7Nh/Kvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWX+ABg4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so7007591b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759300877; x=1759905677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TEMQeJoNXQ2TFdkyWQlMH+1Sa/KHapB9H0jMKRUjLZ4=;
        b=ZWX+ABg4nWMA2O/c46iJplcfFDpQF7ifKgy3NUfab5IXYjLz+D87L9hXG43nfrjEMx
         O+FF4dCwF4aSIKJUMB/xoGyKZoQXs27YFlMBrUQcJ064oABojyxYAUuLlaNcX2g54+ke
         NtkP+gJVXjR3HkdLLZ1Si2Y7KKp2HIk1fsMS8Qh3yP9ymbRrzA35Qd0eukbpv2w7IIWu
         yoq2s82x5mIeS2eSLTjwXiIcnKnwVoEN/Huin2d019qoD0D0s4Bd1Jz2Dls71himwDdj
         mZ2fKwidBIthHyLhQ2Fys030ujc1zZXODSQLZNSm1kuyn6WMA2KdK/LWF6sw9faLn8ca
         mgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759300877; x=1759905677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEMQeJoNXQ2TFdkyWQlMH+1Sa/KHapB9H0jMKRUjLZ4=;
        b=rbg+He7i0aOH8BcER1lxDVKoc4GmHHf0SYS+JnA9Nfw7yUO52a+TFkYghpqQgUgRFX
         71fONwiQyV3jFfqVbKiDyFtKQKFrzcNpLB91azrqwbLH57WCNkeaBxHVwqLedhIjMpA2
         Ly9HvFCfkY6zSDFEKF7hMKKN/0g1zW/Usvk2Yxvd1qOj8IU/DgdhZeBNPJ+8veAbejpa
         SJUwkPeIBven70qre7ZS4eaVAUwCAPfxhVabKra0hoc0vuPxX35GEq8J9bHvmWoynqRw
         QE5YAFNKqplImpYg2rcJuovZW7QAr7Kf4U48jExJfvAqheQTJyRvaD0G2bzXYqS21OSH
         ouPw==
X-Forwarded-Encrypted: i=1; AJvYcCW/6O4O8AqSZvU1NiAcJkJFA5jcwc66gvwLsA9rHfFCei1FsBIXv42JOunMWI17ndcK7U5evxTG7bs/MIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB8LSUpECYRhcZyf4XdWmGNgCswCBwmOYkKRrPXPk8nWgAxtqR
	uAP+7geLOy/ee6UHrV9LFGxF31zNTBMq/0G8cenlLNIWTOyW4T7l3QJa
X-Gm-Gg: ASbGncsAanld/ukIcUmseP0hFntLKI+dBbh4F1K8xxAz6unUHU3slnQzbWdjx/fqhMJ
	358+65QSpHSaWYlKd1m6tHIFc3RlktBdLT9p8UzUnCq7iBOJFRhNSG5LeTDIuUc8Tb1sbsZVLcV
	ycrwXvOgU1bXF0SDj2V5uS7DQ+eUGGu8qT8kOb/SDyww4/XUyOCpdBPofX5hGXv0Xl/0eDgUeHz
	uK1Zu4wekaCwha3LwxGa4AXyoDEf8ruas/BbEa3VBrpn9aJ0jWrNs44SECNlwrvl6hEiTN2mCaR
	KVnshRgw3j0vVClWTjIOxz1oRuaq+PYc2a7WMSs1uxAe3Qxy0hJtju6zBBO+ouPRHdUsxdfXB1/
	M8O8y7CK+lsxY3mYCjZ6XG/tJZZNNZoQkV5PoOiIO6wp81AbPfcajKTWWwobHvQ9RSvNjq5gx+i
	0=
X-Google-Smtp-Source: AGHT+IGO+/qpAj+fCORSmpzdGC/N4PpiP9VbFEiETHa8mmm7lLl7X7Do145SUj6rnWisCtK+VJZf/g==
X-Received: by 2002:a05:6a21:2703:b0:324:6e84:d16e with SMTP id adf61e73a8af0-3246e850bb7mr1305773637.43.1759300877200;
        Tue, 30 Sep 2025 23:41:17 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.94.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78126ae02dasm10351914b3a.21.2025.09.30.23.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 23:41:16 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jon Maloy <jmaloy@redhat.com>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	bhanuseshukumar@gmail.com
Subject: [PATCH] net: doc: Fix typos in docs
Date: Wed,  1 Oct 2025 12:11:02 +0530
Message-Id: <20251001064102.42296-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in doc comments.

Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 include/linux/phy.h | 4 ++--
 net/tipc/crypto.c   | 2 +-
 net/tipc/topsrv.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index bb45787d8684..de786fc2169b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -292,7 +292,7 @@ static inline const char *phy_modes(phy_interface_t interface)
  *
  * Description: maps RGMII supported link speeds into the clock rates.
  * This can also be used for MII, GMII, and RMII interface modes as the
- * clock rates are indentical, but the caller must be aware that errors
+ * clock rates are identical, but the caller must be aware that errors
  * for unsupported clock rates will not be signalled.
  *
  * Returns: clock rate or negative errno
@@ -514,7 +514,7 @@ enum phy_state {
  * struct phy_c45_device_ids - 802.3-c45 Device Identifiers
  * @devices_in_package: IEEE 802.3 devices in package register value.
  * @mmds_present: bit vector of MMDs present.
- * @device_ids: The device identifer for each present device.
+ * @device_ids: The device identifier for each present device.
  */
 struct phy_c45_device_ids {
 	u32 devices_in_package;
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index ea5bb131ebd0..751904f10aab 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1797,7 +1797,7 @@ int tipc_crypto_xmit(struct net *net, struct sk_buff **skb,
  * @b: bearer where the message has been received
  *
  * If the decryption is successful, the decrypted skb is returned directly or
- * as the callback, the encryption header and auth tag will be trimed out
+ * as the callback, the encryption header and auth tag will be trimmed out
  * before forwarding to tipc_rcv() via the tipc_crypto_rcv_complete().
  * Otherwise, the skb will be freed!
  * Note: RX key(s) can be re-aligned, or in case of no key suitable, TX
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index ffe577bf6b51..ebe993ebcd48 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -57,7 +57,7 @@
  * @conn_idr: identifier set of connection
  * @idr_lock: protect the connection identifier set
  * @idr_in_use: amount of allocated identifier entry
- * @net: network namspace instance
+ * @net: network namespace instance
  * @awork: accept work item
  * @rcv_wq: receive workqueue
  * @send_wq: send workqueue
@@ -83,7 +83,7 @@ struct tipc_topsrv {
  * @sock: socket handler associated with connection
  * @flags: indicates connection state
  * @server: pointer to connected server
- * @sub_list: lsit to all pertaing subscriptions
+ * @sub_list: list to all pertaing subscriptions
  * @sub_lock: lock protecting the subscription list
  * @rwork: receive work item
  * @outqueue: pointer to first outbound message in queue
-- 
2.34.1


