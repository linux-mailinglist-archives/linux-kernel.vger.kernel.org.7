Return-Path: <linux-kernel+bounces-888208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E64C3A1FA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB2D8350843
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5639930F7EE;
	Thu,  6 Nov 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlEfJF3o"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F62D94AC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423735; cv=none; b=RU/mT+1bbxiMdhUmzeV72j1NEwIv9+r7wknh+MgaGCCfrJcRzAJG2bJ7xEuWUDsMTpK0inc4lL977gIFU6mqWo068wih774wlAFR7qXQ5w+weXgtVf3QmEKMfx0/j5w6orydnOcAJ8PRjVLRCd0PEpoD3uUw0yqNF/X96ZjPvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423735; c=relaxed/simple;
	bh=1DqFSj/S5FdRM8xI1vnmMW27R5cKr38U/BL7DRT8f0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=infK+qXc4sgkA2VxoEJ48aONfIzeQLKibkbCBWc0+6hBNGDYFX4CjPYy4MjcJ7wNAWQ6y7x9KXnkJ7+H4QAczpJNeEf/u7XDPJXZKAZ19RXpjZQi0tc5Dhz5bRW/78s4Yb6xF80HWbZS/mqNgUpfjYHNONir7lu4LHhNU5VvvZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlEfJF3o; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b556284db11so587102a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762423733; x=1763028533; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5B/ZONU+mx/MPUhZ8D2RqXDgUbTh84Ll8Fc5jTmwlA0=;
        b=mlEfJF3oPxLblRV4lAF2VG3SsP74Gq63409Ip3P24uJlVoujGz4BVdywglFT8UohXt
         sbu6VzHs7luUzp4Z9UC7y8zs3uwB55x8lHpXaMxor1J6qOkHQuDHtJYoO8tPYk0c7ZoW
         fzTsCb1fez042OSglt08WcCx4QKUXRbyk9iwd8sYTcycAoQCrooNnnMBqGUX0qcWcrBa
         Gc9BjVOqMhXXusloJxrcCe4cnNnly4TyN2D6diL3ElnY48QXdC3yBati26R+0sQOnvGS
         rID/KYCjjOKzPIHe/BNq6fsPsP633oVUrTqBptjTfvyCgB1iYXpcFvkAIxQ8dmGSMmnc
         y9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423733; x=1763028533;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5B/ZONU+mx/MPUhZ8D2RqXDgUbTh84Ll8Fc5jTmwlA0=;
        b=h/iPobYSkrgqkHEPl6+JLwCK5xU6Oc0UxuitZ8rEbd9lbahJ52Syl5wQRDGOQRWbyc
         xw79ArZbrtBRynEwyqkowrBQMLWoEV0uEDXGA2y620ESkN3TNCL0+2VPjl9ONUUNk8lN
         G9Cyg5RQpnO3W+j0AcO7Rj3yNZBEKPmqFJGLHqJ0kaW2+bvQ+6tppEYmtNlQxtlJOxrU
         hCFAFkas5/ZL3hpeK1NGnF1IZnRjUZDWRm48ddk5yqYFNpH6z1u87nAY33LSdD+tf8oN
         VkD4w8S1neJWAnmlBBdmFRmSKqaXloJymczOsnLC9G6zDanEe4K4PzTzDTH9X+N7zF7k
         m1QA==
X-Forwarded-Encrypted: i=1; AJvYcCU7CtBtOTkjVZilk9g//IS/Jad921t+FJk//RYBqX7FXuRoS9iVBTtRcAjSj+1zKvEWsavajCDRV57lXXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypjMafNEIUnzm9SzMfnxX77cDhS4zc6SEiFHzLGpUg6KPi99nK
	zJqOQDqX0t57gT6P5pduhVTsWNuR2fTPWm+qPhWYAVgKTmeEBPG0GpVr
X-Gm-Gg: ASbGnctC4spEzpxzDwdII4TfNwk+1GTvm5kT7M2aVaxKmYNZ1S9LaW3e1itFJB49SqJ
	34PVvOLZ1xCQTX0BdYV8+OFUhYp1+yutHmq6e2XQW+g6aRr8ZL4frNmR/OQb0c7BCvVGTUY6/rl
	yWVEBxRjCX2kbhrW/SJ7hwZqneuzK/4JCDxqGQgq8vE41/Uxu75381JOEVN8L8WCduxOeaZlpRq
	wyBlLdMlhms6SfUmWb9xdmtK39zrZTlqG7XtzNlH4SSZJI9Y/BDs8DB0VxOmFUDNcCPnjsH58Ki
	MOzd9aH4J58Uby4GK3l3P6NxHRT3A41dPoNmNFJZVq7z1d6FPRcKU7VxXSMWkq3B0fCtqrBUUwd
	N7TlM2iEgY6aSteMzaCvAK9D2Ot1bEt841WQDgRhgmWd+HKC41qPEopoZx7umd95YD8oFIxiPnp
	qs
X-Google-Smtp-Source: AGHT+IGGknNbfaJf1wlwBpbXS9DgfCxm28G8CeSW3otZfXLcPcwJFPQBOKlOcIpLEk4FHszmJ38k6Q==
X-Received: by 2002:a05:6a20:1b10:b0:343:64dc:8d3 with SMTP id adf61e73a8af0-34f866ffce8mr6522570637.31.1762423733294;
        Thu, 06 Nov 2025 02:08:53 -0800 (PST)
Received: from aheev.home ([2401:4900:88f4:f6c4:5041:b658:601d:5d75])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902207232sm1855872a12.32.2025.11.06.02.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:08:52 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Thu, 06 Nov 2025 15:38:41 +0530
Subject: [PATCH v2] net: ethernet: fix uninitialized pointers with free
 attr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-aheev-uninitialized-free-attr-net-ethernet-v2-1-048da0c5d6b6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKhzDGkC/52NTQ6CMBBGr0K6dkyL/BhX3sOwKHRKJ4FiprVRC
 Xe3cAR33/sW760iIBMGcStWwZgo0OIzlKdCDE77EYFMZlHKslZK1qAdYoKXJ0+R9ERfNGAZEXS
 MDB4jYHTI+2iNkg1Wur/YVmThk9HS+4g9usyOQlz4c7ST2t+/MkmBAtugvlZ9b9pa3sdZ03Qel
 ll027b9AKkmv87kAAAA
X-Change-ID: 20251105-aheev-uninitialized-free-attr-net-ethernet-7d106e4ab3f7
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3029; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=1DqFSj/S5FdRM8xI1vnmMW27R5cKr38U/BL7DRT8f0g=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJ5ite1TzulbSKvft6+c1daVuL3VXO3XN4S+kf7pZ/nF
 mfjf2sdOkpZGMS4GGTFFFkYRaX89DZJTYg7nPQNZg4rE8gQBi5OAZjIVQmG/45tCdELukNbauaV
 zUr0cPrRop6YYxkY0VLG7HF+isKty4wM7Ynayxg0fV5dMYjz6nz+fpVBVJK8j5Xa1BURM+5Nlmp
 jBQA=
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behaviour as the memory assigned(randomly) to the pointer is freed
automatically when the pointer goes out of scope

net/ethernet doesn't have any bugs related to this as of now,
but it is better to initialize and assign pointers with `__free` attr
in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Changes in v2:
- fixed non pointer initialization to NULL
- NOTE: drop v1
- Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-net-ethernet-v1-1-f6ea84bbd750@gmail.com
---
 drivers/net/ethernet/intel/ice/ice_flow.c       | 5 +++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 6d5c939dc8a515c252cd2b77d155b69fa264ee92..3590dacf3ee57879b3809d715e40bb290e40c4aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1573,12 +1573,13 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
 			 struct ice_parser_profile *prof, enum ice_block blk)
 {
 	u64 id = find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
-	struct ice_flow_prof_params *params __free(kfree);
 	u8 fv_words = hw->blk[blk].es.fvw;
 	int status;
 	int i, idx;
 
-	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	struct ice_flow_prof_params *params __free(kfree) =
+		kzalloc(sizeof(*params), GFP_KERNEL);
+
 	if (!params)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index cbb5fa30f5a0ec778c1ee30470da3ca21cc1af24..368138715cd55cd1dadc686931cdda51c7a5130d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1012,7 +1012,6 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
  */
 static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
 {
-	struct virtchnl2_get_lan_memory_regions *rcvd_regions __free(kfree);
 	struct idpf_vc_xn_params xn_params = {
 		.vc_op = VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS,
 		.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN,
@@ -1023,7 +1022,9 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
 	ssize_t reply_sz;
 	int err = 0;
 
-	rcvd_regions = kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
+	struct virtchnl2_get_lan_memory_regions *rcvd_regions __free(kfree) =
+		kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
+
 	if (!rcvd_regions)
 		return -ENOMEM;
 

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-net-ethernet-7d106e4ab3f7

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


