Return-Path: <linux-kernel+bounces-807744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B30B4A8A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D64C442E96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D692D2496;
	Tue,  9 Sep 2025 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C9hEuPpr"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C812C3242
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411064; cv=none; b=p5xAhRiy2ouC0QLVOq16sR6Nc4HMQEGU5evrM66aaA9pHS4DcTIsmlGsirzzODO1duK/7FGPNh0t1lAS8vUM8jdTwj2DnG7XNzwFy+qA4Vgd93NhxglaytSx78/4ntPBduLrpUMDBR3gwMk4cb12bP+mLAGU6i1mwCK4pMAM0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411064; c=relaxed/simple;
	bh=eLy6bDCevS2tNK9rNs6DH/hKKBVbYKeLTD6U+wj9K14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/0jV5bqxqfRxTgk99itvUCx+y3wP8nVRyCcBn+1iyjTitfqMmX92JsG2vja7ZSt8D3Dck+7pQqnRlzwrTcXQvF77MqzkKvYdL9S81LuzYAzKCHAONGPanj3ml1ZMMGIk/H4iPioBuxdc+f0WjLkd5RlesleKezL+Q3sSFJmuSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C9hEuPpr; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b52047b3f19so3074277a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757411061; x=1758015861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNSKqA4FeSJiysOxNOABoHv8THsX2hgL8yWWgcs2JIU=;
        b=C9hEuPpr6p/YMxskQJeReNOhXTPdo2R0pBdCsdvUC31HskzClwu55ulTiVeXKmHJ2D
         VhVVXf8US0HOJ8yvfoJWB5e7sJgAzz6vsbKlBxFKEy9ZFokK0R6AVFLqpvZQWO/EhcMs
         4B+6C6NrXacxXimtYrpi3C8gKvNu6YbXAwkQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757411061; x=1758015861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNSKqA4FeSJiysOxNOABoHv8THsX2hgL8yWWgcs2JIU=;
        b=VrSIdTo/ch7X7CpjyR6njRrDJEwkRP8LhIGg9JwZvWl/z4h0oCdADcSdBQ0btkww6b
         8vpu26bOsyZDS1TlxUEcAogyAKeg6M43FVWIOxK+qq7+Mn2FFp3vDRuhrlE5nUGvk8YC
         MbgeNDilAe4zQpqmHSSlZoKGqzYiKsa7GbRkZF4C60cyHIbxXs6zTCclTeoGlrzx9GTS
         nq9i0jc8dnX2F7q6F+0jE0SzO/0jyygim5ss+3WT1I4lL3nS+3/3cnP8C8a8yo9ZOW65
         UkvZRKJVj86tRfTU8vNArM/C0oB6J1u1Qp2Bd6yVZv8v3IXzEbCLXEKyQs7zbBobRZ1z
         syuw==
X-Forwarded-Encrypted: i=1; AJvYcCWQP14D/EcNEhC8epCnoaHN0N4dXRzo1lOZejgXgvAD8QWb6sfPI6WcL4vYW38YMYtUlKG+lLgY9HsIytI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf6Z66WTbCe02G2Fcewi69z1S1Kc2iaNdnu6bIu0rJu+DtuKc8
	yOdd3ePjRwSUMGjEg6CD6xuliRMtfV/TaQfgMvv1c7nwsYR7ZDp9v+UeQSKe36gO10ug98rz8dp
	733U=
X-Gm-Gg: ASbGncv3BoAfhEd8PHk8Xoct28XgqShjTWyUb7zASAEkdJB08MgS6Q28VeESWAvovHI
	2LI1Akm6zcDiqUjNmEPbDT5YnObzd8x+JVGRUH4VcVCh11fJdnGXbd9cQIhiTYpwts5vswf5BeL
	CF016iFfOiTd4HEuFKy1SRpsRsYNExuxRxQNijWnNDmXD6Blq8OwS0RXAfRVKeSZJFJgn3XsIrc
	2bTLHoZlyGZAW1GYaibiHi4Bc3rzhyhMtV9N0uRqMTtBAms5kcH3yjoojb2VSgkojAOkDe60+Nl
	cEztCD8myap1nPnxlMmpQXLMJuXafBTr3sXX+D0HQtaN8b8JCCQe5S+cZn7MPsm+lmzU3BmLM2g
	HTpIMN886tpNT32AScEI3Glae9GwYKyR8CDGTKBids/aE0oADRgKBI2DQCUYcuRd98oj4LLhQWp
	clC4fymXkqpzushQ4ozVw=
X-Google-Smtp-Source: AGHT+IEJbCkMk2WOO7Rli+cDTTLMIoXQSbucT4RRaZh+UkjjwMN9fgCH9pmoHw713wmDTDIQIB2SnQ==
X-Received: by 2002:a17:903:2ca:b0:242:9bc6:6bc0 with SMTP id d9443c01a7336-2517286296cmr132776965ad.55.1757411061526;
        Tue, 09 Sep 2025 02:44:21 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2a00:79e0:201d:8:c214:51cd:3c3a:7a03])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced7ea628sm120471065ad.6.2025.09.09.02.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:44:21 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
Date: Tue,  9 Sep 2025 17:43:30 +0800
Message-ID: <20250909094335.1097103-1-treapking@chromium.org>
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

Add DL_FLAG_SYNC_STATE_ONLY in dpm_wait_for_consumers() and
dpm_wait_for_suppliers() to fix this.

Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_STATE_ONLY flag")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/base/power/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 2ea6e05e6ec90..3271f4af2cb65 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -282,7 +282,8 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
 	 * walking.
 	 */
 	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
-		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT &&
+		    !device_link_test(link, DL_FLAG_SYNC_STATE_ONLY))
 			dpm_wait(link->supplier, async);
 
 	device_links_read_unlock(idx);
@@ -339,7 +340,8 @@ static void dpm_wait_for_consumers(struct device *dev, bool async)
 	 * unregistration).
 	 */
 	list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
-		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT &&
+		    !device_link_test(link, DL_FLAG_SYNC_STATE_ONLY))
 			dpm_wait(link->consumer, async);
 
 	device_links_read_unlock(idx);
-- 
2.51.0.384.g4c02a37b29-goog


