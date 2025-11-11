Return-Path: <linux-kernel+bounces-894865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 187F4C4C45B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B38418C0EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DF62F3C27;
	Tue, 11 Nov 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUNd4V3c"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF02D6E53
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848514; cv=none; b=Y0QW36MMPVJF3RO7fSJRpoCGH+t0wpF8Ygzr2T3QhCxd36odIEegWgJtnQwz79HveK7Oh/h0gOECVTAEk0HOIgURFXvGR4PdX8O+v9ENMGipu+iIExc85xqV/DxeG6ejoPPn3/5Vrvk1JAgQyhUY2Zyzm+7B0wwRL44w/7vvTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848514; c=relaxed/simple;
	bh=PIaFroRLjWBOMZ66uCeu/mB1uYpb2ubaFCpMUlAN9sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DPBRWOXUvRSFPKo963KK+U9p2GKCnzBXbFF2iPX7qUKQi4g1qChNPg8KMNUxxQSUYt+PLiG2urTaDRlLtuLiVuBda0wZtinZVQK9enu3V7ey3rinQNMyF038NoC8A22d8QimfXD5PFmLK8DxtvUyLzW3L1ra+UacoCtkHTWa9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUNd4V3c; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3434700be69so5256836a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762848512; x=1763453312; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aB4UxUzEcD78h6eg+41U7cdpSOHj7Z5HOikKQP5IqeU=;
        b=BUNd4V3cdvTgfhsv3HxNncaTt6gfdW0m9ctM1gYe6IR+8ABw3DyHDcaNaNt5PwgpFG
         LbqeuWLsN2hvtDM65ROT0ILBJX0MTYZNJGmidTsqN4bNa1KOhgpu7SzFENnVbklw8c+3
         kyY+WIsc9XfNNstuGX/DGOTHRjQv9IO7rZtkCRRDjgL0kMqCBqWjn10HpOvWxQXpueFD
         s0/MdrT1DlvsJxE7kMw8/GZoEBAIqHhhl652XyiYU3QFoOFiEmv5orJeT50YJ76FCHFa
         /cr2orRwcnBJxm+0UvzX9xjTrT/e/hRAQMBnvPs9+jy29ni0xnbWbzHo+TPDFZDByuzV
         TApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762848512; x=1763453312;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB4UxUzEcD78h6eg+41U7cdpSOHj7Z5HOikKQP5IqeU=;
        b=rAgHYlquapeGUJREO+yqyOazn6hJ0toIC8vvs9dRYisx2AnsJ7iX09hdUTdq6O0QXU
         L/7Ls+6RSOz2HO5KU5xY8B1nar+9whvKsL30aYA1XGG+GUjDbiRxPt04bJzud7KgZCPg
         3T3+3e7rm1an7mE7pfqhls/6aTA8vZeT4tTE3bzhPFjgdUya9wHenpgJ4AEurrQf6aC7
         ExxSkyEm+avA4hj53zsVoV/v3Cuu3ANiYqAIbKrTGYZb36z6s/GGReL/GHVNqcm/i8oD
         aAwryL9SPR3v8cwRJMXZEwdvszuH2ZXGGMpHBGjUuPZEaBe/PhRfu1ig0TP517PdQ03y
         MYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoTIk5SywYURzPqsQ9jMkwVHKn3MDMAuUYVF6gqY3uR79H8NzqIu/nIwZqX87e9ha85WNDA99oUD/gh70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHA9dzbPk36bAwoTsiWPHQcF/gbE42RhTZGPrTdyZysTHBHjAm
	bnff3RWaeLHFFtEIuAojur02iU8fnNNIv/4vLpkAf9WAhDUXTmCmTEhj
X-Gm-Gg: ASbGncsRKhiv5D2BGfg3MDK6finkqi5V9XiVDDMJsGF7vxKVGetMNe4Yz00tEZZG55u
	E3238H0VWOIyrQWMxchei8YIiKyZ1DfUpX3US2Vebzjalag6T47+dss4hfd3djbjd9wYEIcF7Uq
	5V4ZUPuiFFx5L3RNuJiZDAZPcKc8QkoabnQZ65Y5dl3SxKqjbgGUPaQZbbWFqxKfTZBhcT1qitK
	oUne9l+wTCXklHnQBAsmsuL5dThnG2B9V8ueW26B/4/RESXDWbcVdMlIOJFbJvuSNg86ZNstqqs
	b/RTGaHQXudhI2lND5cD/TvpmEQ7wFClyd6V5v2b+Od0ioOX2fO0s9GxQ/AnBUjNZ6XzLgVZRUN
	9gQxjgxThSEK7VL3pmYTTzYuH0PVxjLkmUJlk9WYY4GDzVHYRgYXqA7GLiqHdyB5ZZ02viUsafq
	M=
X-Google-Smtp-Source: AGHT+IFqoxnvILjVBDFIMDXe3yIwEryL6vb0p3gl9RFMnSeI7Ihc/WjBvL8XPERIO0QYQnvMP3Ihgw==
X-Received: by 2002:a17:90b:2fc5:b0:340:e517:4e05 with SMTP id 98e67ed59e1d1-3436cb3e5a6mr17682851a91.12.1762848512017;
        Tue, 11 Nov 2025 00:08:32 -0800 (PST)
Received: from aheev.home ([2401:4900:8fcc:9f81:b4f9:45ad:465b:1f4a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c30b96dsm13379283a91.5.2025.11.11.00.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 00:08:31 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Tue, 11 Nov 2025 13:38:18 +0530
Subject: [PATCH iwlwifi-next v3] wifi: iwlwifi: fix uninitialized pointers
 with free attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-aheev-uninitialized-free-attr-wireless-v3-1-26e889d0e7ee@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPHuEmkC/5WOyw7CIBREf8Ww9pqCxVZX/odxgXSwN6nUAFIf6
 b9bu3Kpy8lMzpmXiAiMKHaLlwjIHLn3U1gvF8K2xp9B3ExZqEJpKQtNpgUy3Tx7Tmw6fqIhFwA
 yKQUaOKBDjHRqUG1Kd0ItrZhg1wDH91l0EDx0Azsmj3sSx6ltOaY+POYXWc6bf4VZkqSNrXVhS
 rPVyuzPF8PdyvaXWZHVN7b6Gas+2Kp0dg1tqxrf2HEc3+g+nKtBAQAA
X-Change-ID: 20251105-aheev-uninitialized-free-attr-wireless-bde764fbe81c
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2686; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=PIaFroRLjWBOMZ66uCeu/mB1uYpb2ubaFCpMUlAN9sw=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDKF3v2udlk179Ps8Dfdl3S+GHKzv/u9JmtbzamgDj2RC
 7st1mq6dJSyMIhxMciKKbIwikr56W2SmhB3OOkbzBxWJpAhDFycAjCRJYqMDHMOWYveMbt3YpXD
 gty3d8WZO5ZsczA4qLRiycr/r1uENkYxMrx6qsSU8WtBbPeD1yXWwt8kJ9a23b4ZnjuR+8YaRbs
 0Nj4A
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behavior as the memory assigned randomly to the pointer is freed
automatically when the pointer goes out of scope.

It is better to initialize and assign pointers with `__free` attribute
in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Changes in v3:
- fixed commit message to include iwlwifi
- reverted unused variable removal. To be done in a different patch
- Link to v2: https://lore.kernel.org/r/20251107-aheev-uninitialized-free-attr-wireless-v2-1-674fc3e5c78e@gmail.com

Changes in v2:
- fixed style issues
- ignore v1 of this patch
- Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-wireless-v1-1-6c850a4a952a@gmail.com
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 4ae4d215e633e0d51194d818d479349e7c502201..c31a1187f53a79aeb0837f06250410eec4e7ea6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -818,8 +818,8 @@ int iwl_uefi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value)
 
 int iwl_uefi_get_phy_filters(struct iwl_fw_runtime *fwrt)
 {
-	struct uefi_cnv_wpfc_data *data __free(kfree);
 	struct iwl_phy_specific_cfg *filters = &fwrt->phy_filters;
+	struct uefi_cnv_wpfc_data *data __free(kfree) = NULL;
 
 	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WPFC_NAME,
 					      "WPFC", sizeof(*data), NULL);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 1d4282a21f09e0f90a52dc02c8287ecc0e0fafe1..5e986cbfbd2d263c8c300cf304f00419d6b1e6f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1785,7 +1785,7 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
 			   struct ieee80211_vif *vif,
 			   u8 ap_sta_id)
 {
-	struct iwl_proto_offload_cmd_v4 *cmd __free(kfree);
+	struct iwl_proto_offload_cmd_v4 *cmd __free(kfree) = NULL;
 	struct iwl_host_cmd hcmd = {
 		.id = PROT_OFFLOAD_CONFIG_CMD,
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-wireless-bde764fbe81c

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


