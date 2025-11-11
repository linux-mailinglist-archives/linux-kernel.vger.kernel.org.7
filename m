Return-Path: <linux-kernel+bounces-894899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4C8C4C684
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB3794FAEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02CF2DF71D;
	Tue, 11 Nov 2025 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPMjQh24"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337126B760
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849444; cv=none; b=enr4qu8mZeFW44ENjknBHMNp0JV7zMCXb1VSaMBtuayhqBo2W590E9WK3QA7jlqUKNs+k/5T960YlFPJWig8rrr1j9Yv+bQ6IufLe7K6q98mx+mm8voqye/V8QsMAvTejbyoUQkXHe4LJuKkQ0c4PpKqyk5te3UtuJGxM2QYAEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849444; c=relaxed/simple;
	bh=7WOHY6Tm97xi/2igTJFMDZsoJ3MtW8Vq3e7nbJKy+9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bg+vi94JqS9h4YDITovmp2ad7cK1yGSqhw8hNoT2tGWxamXtxw0N7QYOfTF+tkogUCCabfQIkaHWqAW8VJ3MOUkB+9mGnEw5vt/TG7jFzzabmd0KtxKwnCZeHSX4U2xNRJNSBxRrXdT5dblYr9NiOaY+wiFdswgGR3WRHO5H9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPMjQh24; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ba488b064cbso2749428a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762849442; x=1763454242; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ma9rIXQwGFXqsO0TkfjLnvKeht33Ts48WkEjqYw9Mio=;
        b=GPMjQh24107jh6qWVeuIRdqBAvKORqW5fhFqN/JLUMuMdBBJvVk4pVH1Xrqsfj74HK
         lXXLi0hy0pKetzCBZcuPe8cQgD7xTCdsBJx3hwsFdYRlPlLnIF9kHSYvEGsPfK0izTAs
         7MyJs9t8DmH0qhAHlDl8vLYuHXqAc0hCYtClEwQSAt/kOemErLHT4Woq6/tzpqmRjzCd
         iOkWack+59abPff56GvbdTXQww5conUdrniWB8P3MA3zV2QIPkRS09sdeKA9HAVCX3Lt
         x8IooZdjDsNuAmVx28hg+X4Y7vOTQkltkzBqbntfoE9wBkMnyFJStO1mvoIfIHGMBo+3
         i1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762849442; x=1763454242;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma9rIXQwGFXqsO0TkfjLnvKeht33Ts48WkEjqYw9Mio=;
        b=oqNFwzZAdjTGvoeDhl3vK8+Ydu27KPJTwhBvOrJSSZFuAPbya0gOz6OEgArYMcv+WV
         Fot8rn/qRvex5m5rVvPgMkxgF4s079VsS9bscz8J3Vb8KYP2MQx3JPbDQ8MyDA9QGhEY
         6duvpvLjSfUr+PxvTZif7VvQKcUtzNy1Ex86z/Vurn15igJDaKExjwyW56hSmBFt6xLi
         GgVKInZsz6lVndoDMBSO1RjEA9aiOpz2/jyf6FB/oJpNvui5LpD3UdDxCfjDPK0CQlyL
         MWcUc5+nid4buwSQMA4GsHO0CycoaOMkPIxVxf9ACH4kuthb+8aUyAJYOSPu9oPBkA6z
         moFw==
X-Forwarded-Encrypted: i=1; AJvYcCXoHh4ArgFzFj+KQEraVq/Q7gUQUBBLXx+seGuYtOAU4OmdCavJFUguBwt2ABvjJSB4VLEcB0b+DKiRC9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc9XwHHnQ2gIg5uPh3bASEac+T509fpBJ4My6vPjrksOuTtrmH
	AJlLcWPQzaCGCNLGM7PMwJS5f3bEFB7Wzs8I8mrthU/yAn/dRfwltMSxsOOg8GC6
X-Gm-Gg: ASbGnctEhslMMOIrrrcGvHphki3bI9zuvCUXznkQgEzGq5Om/+Nq3f9Rqnp6s8S/5Ul
	8y5oXOqbeHfi9n36Ho5B8+nD4yreh3nVSIcCb4ZTYqfdvjc+jm77QNRz9ncBIDXbdmd1wtuXxzu
	mIkZn23Fp5oz9EMEttPNV2+c/05k/1PgFdy5r2P2j0tscqeanQfO7udGlSBjLD9E6VSleINn2T4
	u1gnsDYYREWCgOuL7IxLbAciLrMKbvL3/J6xgTD2k5NwHn4TxGIsHY0OMuJlFA/XGQ+xftQKUU2
	OiFtluSXPvnauTJmI7mMuSIiWrjmQ+49h0QdAygNT9mLYJ0ebPNSwOXKe1tTrDF58QYmQcP5tsF
	ke2KUAIqSrCR8632NbSAb54anELf2RQP63v4W0q04Aunc+mVSCVCTQlrjTqlbTJJXzqmrbffp9n
	0=
X-Google-Smtp-Source: AGHT+IEeZ7bYdlt5cfuvraVmJHUc9e5eydPeAgrttdf5m2Leo/giPrvnaMzhna3eyxbGbeA3p+aSyg==
X-Received: by 2002:a17:903:388e:b0:297:f8d9:aae7 with SMTP id d9443c01a7336-297f8d9affemr132401255ad.46.1762849442096;
        Tue, 11 Nov 2025 00:24:02 -0800 (PST)
Received: from aheev.home ([2401:4900:8fcc:9f81:b4f9:45ad:465b:1f4a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b62cd94f6bsm2000428b3a.23.2025.11.11.00.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 00:24:01 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Tue, 11 Nov 2025 13:53:51 +0530
Subject: [PATCH iwlwifi-next] wifi: iwlwifi: mld: remove unused variable in
 d3.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-aheev-remove-unused-var-old-keys-v1-1-988de3a91b1c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJbyEmkC/x2NwQ6CMBAFf4Xs2U1oIyb6K8ZDpa+yEVvThQIh/
 LuNc5vLzE6KLFC6NTtlFFFJsYo5NdQPLr7A4quTbW1nKuwGoHDGJxXwHGeF5+Iyp9HzG5uyac8
 h9O76DBdLNfPNCLL+F3eSZVwkCEesEz2O4wfiJgrDgAAAAA==
X-Change-ID: 20251111-aheev-remove-unused-var-old-keys-104ffca9bf62
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=7WOHY6Tm97xi/2igTJFMDZsoJ3MtW8Vq3e7nbJKy+9U=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDKFPs299mH31g2auUU5uecN7yycyZ50Y3VTtcqk6pcCX
 59w/psl0VHKwiDGxSArpsjCKCrlp7dJakLc4aRvMHNYmUCGMHBxCsBE0vcxMvwTrsiT/bzx3JGr
 Blwc63MO3b8S/DH9uX7OhS3t2Rvsjy9g+B/j3n+A/VbntDVvDm54rC3ycc29Q6zqvyct+tBklpJ
 Wfp4FAA==
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

remove unused variable `old_keys`

Signed-off-by: Ally Heev <allyheev@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 1d4282a21f09e0f90a52dc02c8287ecc0e0fafe1..fefb4f532a1f9fbb1a4a5cbd2ade817d5c1adb58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -996,8 +996,6 @@ static void iwl_mld_mlo_rekey(struct iwl_mld *mld,
 			      struct iwl_mld_wowlan_status *wowlan_status,
 			      struct ieee80211_vif *vif)
 {
-	struct iwl_mld_old_mlo_keys *old_keys __free(kfree) = NULL;
-
 	IWL_DEBUG_WOWLAN(mld, "Num of MLO Keys: %d\n", wowlan_status->num_mlo_keys);
 
 	if (!wowlan_status->num_mlo_keys)

---
base-commit: 4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
change-id: 20251111-aheev-remove-unused-var-old-keys-104ffca9bf62

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


