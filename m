Return-Path: <linux-kernel+bounces-888417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB552C3AC49
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7028E1AA58A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523C03191A4;
	Thu,  6 Nov 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOAX6D83"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D412D8379
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430181; cv=none; b=CoWY0KcSG76v4hy7NrSGfEq8LtvTr6kti+3uZ4q1Q0fsRvJ/0dL8jr13eC6F8P78oKKzV8SzubmvJdKDrx6P0AieCfAWb/LgdShibvXJdUgkZBGCWUxLKwMXndBvt6TqPT4uyUicvJp3mopqtyV4UQ2ACzGqZuc+EqxmvrYMDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430181; c=relaxed/simple;
	bh=F5ah8MsnK3Z9znouBMKy+zHLSoJBwjNa27W+pmH6JFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LjnfLjucEKqQ7BPJfyp4JBgX03ZixwZSvcmck94Npb//SpA1lpN0XjbhDGWTdoEAFb7p6FlBWqlTzUTrqNi2wSQgqK5sYkV2AssQgnX1VNysw54HnZ7WbymzSF/PsYeCefbF/RY3REKoDRB4HnPmBNPx5i0H2v2ps6YDsI7aOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOAX6D83; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a1603a098eso563173b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762430179; x=1763034979; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uNpcXHGc/4OOByDk3Xi+rklLjzHFy8Vk5vFGZ7I57lE=;
        b=dOAX6D833vsJj457zNJu0vLzK6iIzbzazjs6i30oiu6LagC9kcB5mOjq6+prtGzY2x
         ELku25DIxYDXi0vHZduZsz2tbEct4gYpppv3EAhpvTBCfE+Rt+qwuQvW7kfusC5O8T0S
         OFcepC1TW0V4epixtjgBnPkXzgx73pt7bpwvQ0OaIQ9ixwNDcqF7b+i7l7XF/GCUflyN
         rjVVJmrS9ImWpMK9YCfQZ55Kh4BGE3AeX2Mtl07dQ6N9SO96pXzA7WQwaxhoisJS7HiA
         jXibqUsz/8fDQfnRahsesqH6WqR90E8J2G70IB3Y3Zter8I8MO4mvYYMdfIECKdJFhEJ
         1Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430179; x=1763034979;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNpcXHGc/4OOByDk3Xi+rklLjzHFy8Vk5vFGZ7I57lE=;
        b=d8DTPoAET4l5GRD3qCOTwhHhY3U8AIaWBSYC2qeMocVEm0kFi//rG8CG10ELEs4ZzH
         apcZ/PGD7vTV0cIVDTSTAkdgshs4GBswMGsHB9rKRblRTTTaTvA7qY6JWr44ezh0rfvp
         0WHMhDiBq4adUkDGCWLOYRsmiE2lRD1VqrVD+Gl+u6mTBDds+0rZka7b3kb0HKIdmFGY
         PS5ZZjTp26t11MHQh847stf3jC+B5iPf9lMuVbcTVwUk3SnPViZQJIViuVXgaXaEVgt6
         C4S9qkThEGXIWluHfjrYKDZgbeF3QauU9wUgmiOFfHJNpQTXz68q7QMtsNTzetyxFKkQ
         AW/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWolvyHNhLPW0T55FT2pBEv/IA2R3dJ+uROjMFhvKlK212f23Znv41mSUZcpuXI1Kz4BZD2IXtf90DVdiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0KJecJuE7IvFERwSLAin+v3OIz4tsVZ8zHmfOzN2sW27K+Xzg
	rmxxjM2t1PbTpafQU7DZXKQdncy01OzOXZPPZNWXsSlbti2LyrETY2Ii
X-Gm-Gg: ASbGnctvmUzdkOe4QSYnGSKQAK2FPWImukCah/vGUE73I6r9oo++G4mBA088eSvyH/b
	f4yzgaYkRWmwEy0PlyuNJDD3SZBid0iokdk2YN9fApDdKSRdrQ8488d4RFB+Q/gbc9P7zkgfHsg
	AhgpELkgCBXByWAkU8798wadcHWKXgckQWR+9kEVTgOOBPMOsWUFLTyhaZauVNU/MoaqJNu5k2z
	X7Uod+GzxdisxOCKC495Ya5ue9C1nrN7ZGMpizAb1dEz9qqf4bT0CTqQ258i34q8AKNU478uGuO
	kKcZj4qw7En3vb+GM/FovWdWziQd9CPda+pfb/MNgcqTyLCfHrPKgj4RP6hWubR7THW/IMwZIG3
	Jmpp0u8YvWNVrDy3f3B7yn3z10aIVFEItYscebzpqf03v8VWv1YiOi7bbs2h16uKK+W/JtwZyj2
	Y/bmyyDz9/3yg=
X-Google-Smtp-Source: AGHT+IFZTfSSmOqsnzyenxwbnVCwSP1cwq60iDyw7m55VKi4EtHZ+78miYEWY5PRHYIS5Aaap/hNxQ==
X-Received: by 2002:a05:6a00:230b:b0:7a2:81fe:b742 with SMTP id d2e1a72fcca58-7ae1d63f297mr9571953b3a.12.1762430179016;
        Thu, 06 Nov 2025 03:56:19 -0800 (PST)
Received: from aheev.home ([2401:4900:88f4:f6c4:5041:b658:601d:5d75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7c4115a9sm2648580b3a.0.2025.11.06.03.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:56:18 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Thu, 06 Nov 2025 17:25:48 +0530
Subject: [PATCH v3] net: ethernet: fix uninitialized pointers with free
 attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMOMDGkC/52NsQ6CMBRFf4V09pkWaCFO/odxaOkDXgLFlNqoh
 H+3MLHqds8dzlnYjJ5wZpdsYR4jzTS5BMUpY02vXYdANjHLeS6F4BJ0jxjh6chRID3QBy20HhF
 0CB4cBsDQo99GZQVXWGpTtBVLwofHll577HZP3NMcJv/e21Fs71+ZKEBAq1DXpTG2kvzajZqGc
 zONbMvE/KhWP6nzpOZlbTVvpFVGHdXrun4B25jupz8BAAA=
X-Change-ID: 20251105-aheev-uninitialized-free-attr-net-ethernet-7d106e4ab3f7
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3128; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=F5ah8MsnK3Z9znouBMKy+zHLSoJBwjNa27W+pmH6JFY=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJ5ei7Ny4nVWfJeUGdH1rezCw5x/ljgOH9Tku3f6Bfbb
 3n5zI/b0lHKwiDGxSArpsjCKCrlp7dJakLc4aRvMHNYmUCGMHBxCsBErjxk+Gdsc+VJcu2UZ76Z
 Mq++hx007zi/87TXp1fBFSw28svXBskzMuz7vfxP6VEnIc2bpmJMT+PsuSRftbJyfHZ00HG+I+d
 Szg8A
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behavior as the memory assigned randomly to the pointer is freed
automatically when the pointer goes out of scope.

It is better to initialize and assign pointers with `__free`
attribute in one statement to ensure proper scope-based cleanup.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Changes in v3:
- fixed style issues
- Link to v2: https://lore.kernel.org/r/20251106-aheev-uninitialized-free-attr-net-ethernet-v2-1-048da0c5d6b6@gmail.com

Changes in v2:
- fixed non-pointer initialization to NULL
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


