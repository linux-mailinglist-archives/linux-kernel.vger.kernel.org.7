Return-Path: <linux-kernel+bounces-814307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2530B55229
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE12D7BE18E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7553128A3;
	Fri, 12 Sep 2025 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ign2kE1j"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61420298C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688486; cv=none; b=QHAkgR1yrKYkbixmD3+DRkTsHWUXuuyuKUxRsC/ZFuSPPsz2cKEbf+ll8S9RHovm+/TwcfNvKcVR3AgwxSfGz7FXNs4XnsVhY2kJVuTOvJx+FChgmA/qkRZZpd+/xCYnqplD+InnQXpP3cYp4jRgUo605tf+VPycOep9qr5li7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688486; c=relaxed/simple;
	bh=Yy5SXGkU+dfrrg0VvHW6KEb8jA0uCNGXZ12r9AAlWcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gS6bHECNeFjYAqEVmAEPCh0M1KhWXbAZB5MVNqw7epQDmmQlD36IivptMJja1+aqNxRDMj8/Y6Sb0z3xljY6NsyURJQuf+ve8AF6TYbHigzLAz5oIeW57+tDBM05SSnWeFGSEYnWxqxKiCBIDjVIG9pjtm6K4Zi+BEVYczQEVR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ign2kE1j; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77250e45d36so1761604b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757688484; x=1758293284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7yxEB70AFkeGldP2C4gWWQqO1ZnbDO4yOVeM1sfcVx4=;
        b=Ign2kE1j2gc9zqcos39L0KcGzBtvpqzSQP5c+xV0jm2JhkFiQMDe0gDV5KTReT0KVS
         ThnMOBDmwBXl4h6v1Ixq1lgwEIcYbFzUTApWZvM8txP+twRf2jLH9if4UH/EEqeCFdWL
         GAIyfflwNANpymDJ3gmvenQtnlGn3idYcFT10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757688484; x=1758293284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yxEB70AFkeGldP2C4gWWQqO1ZnbDO4yOVeM1sfcVx4=;
        b=j9EwI+i4s+p/KMnmdAXp8UA3kzr4c5B4afS7YxkfsSadOIUo8b3kaE1cDRlYOeqgWG
         Uu8QVpvrY1uIHzFXNmNxYQdPsngs0hqtfQCiiQEAEgfHUULWDxO9akuevp3/x09lHnGe
         Rc8C9tkZ4QAAfqx/7THyn9RnFReszbO08ZWomO6mTdNTGpGLuKdSGEJlLByKOdO2oOk1
         Ati9dfdcwlaQO0QJEDStpJU1ABP0LYIA9eGrPnjLXu1LMQowc9plKrZ/LU/4pIDxGbOd
         gCRNE7nc3oWWkt06HCKWpmMMqQoeU0yH0namVA3qm2O7i+wyjRxnOoEPhP01LH+oOioU
         WOHw==
X-Gm-Message-State: AOJu0Yy4gGiv4aq2TfVdTjsCJBJWE23g38DLCSBNdfE8T/nN1anhKwnm
	NaG1ntwi9hXEDldP33lWooR0GT/KKZcD2JHprXE9p2WWuvrHODqa281mYsPlIYYWXQ==
X-Gm-Gg: ASbGncugClkqZy5uEUoMYXrBxVaMG04FxbTFf6boOa1je9MEvw2x9fuE43wFZWJLqej
	7qQ75IN9l2IFAmw2hMxXjCZY9KerEUOImnXR7yEJD+e4NC64S93Cs0n5DKzPd1/TvfurqH3+mXQ
	1dGA1Y2SoEvwgcx3nIujxMBiLsU4wwmirNHebTRI3TjXmluxBIJUN8TS04yNiF/qvJZgr0AIwr0
	nzWgiR7IDD8liDmcEUtigH096M9uR1MfgLSjLN3yC9ft/hNPiqnhVRjySlR7s/7ZcD8bYXibqrl
	hR9OMbbALHTkiJXDPSIL+khcOMH1i86w+2vokd5mpiz+ZWb/2FlKlgfyAS9BJbmDLotCJUlwzTD
	URPzeSWNuJukmSaD1zRhuRTlqs23kHyRMswy7PuQIXx9bhG+eaagGTQB0kFGxEu2ufaw8IzcfAY
	ZyW+Fq49w+
X-Google-Smtp-Source: AGHT+IEPimbWX9IBV5n2l+0Ugiz/uhskkY0eUSm/DiWJXOTN+IfUI4glCrLUVfKmtCzUPkmJFCqwBQ==
X-Received: by 2002:a17:903:32c4:b0:258:f033:3ff1 with SMTP id d9443c01a7336-25d242f314bmr43662285ad.12.1757688483924;
        Fri, 12 Sep 2025 07:48:03 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2a00:79e0:201d:8:97c5:89a8:4826:4337])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25d9c7e5b2fsm21338855ad.85.2025.09.12.07.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:48:03 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	linux-pm@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
Date: Fri, 12 Sep 2025 22:39:07 +0800
Message-ID: <20250912143911.445452-1-treapking@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device links with DL_FLAG_SYNC_STATE_ONLY should not affect suspend
and resume, and functions like device_reorder_to_tail() and
device_link_add() doesn't try to reorder the consumers with such flag.

However, dpm_wait_for_consumers() and dpm_wait_for_suppliers() doesn't
check this flag before triggering dpm_wait, leading to potential hang
during suspend/resume.

This can be reproduced on MT8186 Corsola Chromebook with devicetree like:

usb-a-connector {
        compatible = "usb-a-connector";
        port {
                usb_a_con: endpoint {
                        remote-endpoint = <&usb_hs>;
                };
        };
};

usb_host {
        compatible = "mediatek,mt8186-xhci", "mediatek,mtk-xhci";
        port {
                usb_hs: endpoint {
                        remote-endpoint = <&usb_a_con>;
                };
        };
};

In this case, the two nodes form a cycle and a SYNC_STATE_ONLY devlink
between usb_host (supplier) and usb-a-connector (consumer) is created.

Export device_link_flag_is_sync_state_only() and use it to check this in
dpm_wait_for_consumers() and dpm_wait_for_suppliers() to fix this.

Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_STATE_ONLY flag")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v3:
- Squash to one patch and fix the export approach

Changes in v2:
- Update commit message
- Use device_link_flag_is_sync_state_only()

 drivers/base/base.h       | 1 +
 drivers/base/core.c       | 2 +-
 drivers/base/power/main.c | 6 ++++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 123031a757d9..80415b140ce7 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -248,6 +248,7 @@ void device_links_driver_cleanup(struct device *dev);
 void device_links_no_driver(struct device *dev);
 bool device_links_busy(struct device *dev);
 void device_links_unbind_consumers(struct device *dev);
+bool device_link_flag_is_sync_state_only(u32 flags);
 void fw_devlink_drivers_done(void);
 void fw_devlink_probing_done(void);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..741aa0571fc7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -287,7 +287,7 @@ static bool device_is_ancestor(struct device *dev, struct device *target)
 #define DL_MARKER_FLAGS		(DL_FLAG_INFERRED | \
 				 DL_FLAG_CYCLE | \
 				 DL_FLAG_MANAGED)
-static inline bool device_link_flag_is_sync_state_only(u32 flags)
+inline bool device_link_flag_is_sync_state_only(u32 flags)
 {
 	return (flags & ~DL_MARKER_FLAGS) == DL_FLAG_SYNC_STATE_ONLY;
 }
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 2ea6e05e6ec9..73a1916170ae 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -282,7 +282,8 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
 	 * walking.
 	 */
 	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
-		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT &&
+		    !device_link_flag_is_sync_state_only(link->flags))
 			dpm_wait(link->supplier, async);
 
 	device_links_read_unlock(idx);
@@ -339,7 +340,8 @@ static void dpm_wait_for_consumers(struct device *dev, bool async)
 	 * unregistration).
 	 */
 	list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
-		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT &&
+		    !device_link_flag_is_sync_state_only(link->flags))
 			dpm_wait(link->consumer, async);
 
 	device_links_read_unlock(idx);
-- 
2.51.0.384.g4c02a37b29-goog


