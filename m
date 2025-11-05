Return-Path: <linux-kernel+bounces-886356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C603C3550F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34D224F5900
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C282F30FC2E;
	Wed,  5 Nov 2025 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzuYDp1w"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2530F929
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341460; cv=none; b=q/Po0zOubv727JnUTM18+0pyFx9qZfyCR+G77y558wG6b2GU4Tf8JPlHe6WT4AnxpeMSD0iLxS2AXmeXqu+TYFdBr/k1CxUh1+JPfvbEKQZvuR9WoaAz1ePC1MKMY3oL/SOYZQHU0A3mi/fuFHnqRdB2yjL5XBY2gECPkJHsqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341460; c=relaxed/simple;
	bh=K0CJ52aXaW30yOkXOm79Sjwlq8KF0ufVGkRrUk+tqGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z2OigFmsf00CoGrhZ58rFNhXLT2nSi4FlJ1yIegJmafImitVLePVPdCki6X2KEzX2Z6lKHhcZJZyk4zFEIfVswaf4a79dYTOv2dzEVJRHTRm75/1UrNHSHa2DJOSfnX5QhqcXsixI8o+PPcPXDne3khUx6axPaotVhUe4cEtG9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzuYDp1w; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a9e8a15502so3231707b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762341458; x=1762946258; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4cPUaZ1vu8lY7gSxHHPShFsBPH7l58KtQzSSmUne/Kw=;
        b=bzuYDp1wLcOMG/+Fp/vDm9KoQFVQF02SVnzTyQhTWQHwQNe0gFA820lpG0f2yyGR0g
         TvPCe/c7lhI0pbEaHmo6KN9IAwfP1hDzVyQMPlRXoyrIbgbuBzdYclUDFpLlDAXeNiJ/
         p+XqQug9HUR7PalQZA26chhYQ0dcvx6esENuXAZgQBbBFqIWqEm4y/91MjPhCLBfRuhR
         UAn75qQHFQZhFBUOZD37cltocNbFxpjkPMuol/tBV/11SYG/NTtCI/l6AtepRYV28Y5L
         Rk3kRqPXkZONiVLGvh8l9K7FEWRedzcpf2M1aa/dGObgzzYP5BS13qOqGV4wnx8hmfd8
         MFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341458; x=1762946258;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cPUaZ1vu8lY7gSxHHPShFsBPH7l58KtQzSSmUne/Kw=;
        b=BHADdWtyC0piVScAkZYiZDwTpIhFL2SMywX8sGHj0cwBQwhvF4tEt6vuxeM6Yc7fBo
         s1Uli1u40hNiNIwEWQicytt2/tRzLA79chxnWAeoal11PiHvRLAFxHaVVHsL1mhL4Til
         E+hIQv6rZpE1Mhd/v+Cf9E0R9nvDTMioXwlKAUQ9E4mgPZXzV+oda/EqF30va6yiNCMR
         l3Vxu8Iy3C064Ur6BzHYGrrXx3z3QSHzcmxWn2QKQDIBKysjAkHRKkOQ1gF5V+6OFQGu
         pR5aiA8AltHVPWZsp1LXxb8AO4Txs7//vfZF0zC2ycqtZu8rqZHsRR31u2x+ILiaOQpq
         Fphw==
X-Forwarded-Encrypted: i=1; AJvYcCXQZ4CpDk4ZuKdlAQBhrHEIGNerBVCbWQInwDE/RbzDgxLP8a1lCj+pQ6ZV1PQHYB+BG4nKZMfdE0fEIPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv9Z+6PAut3jkwFZMldiVfb08Qn/cwWXRD0mjQr5wDuRh1UD0T
	/Rev7oIMsA/qNH6nj3yyoM7DUbs+47ToDVuT1OoqLSgKK6SB0WKFXZxP
X-Gm-Gg: ASbGncvOUDzr68SUyNCuk9P70sjHcsCZ66T0elYCkCoTy9DX2BAaYp5N/nGc3iZ3LM8
	qoPHoY4V0RM/bWhu/bZt/XkVAzu1si+cBWzQc7lcHJ6MdjGK40yGgRS+gX+JxRb1QPyXOtXbAsF
	Zt4jhlMDMjQ8Fya7FsyHKXBsln4Br/6Quq8kEckp2CuAtjr0lqUGeztcG3BPFuSYSCpw7iOBrdf
	mVIjbC0lik09Rn0VQHqBK27I6mGi8/b4oYKuZftGlBizHm/U5PpSWOlqWT7382o6TXKLN+0IyMa
	/ZEwdtTFLXlFXbM4c20jtHS2t8tsESlLpC+4EceXcpnAoa7aIKEBHlXC704mzNuWx7lmfmdfbh/
	VeLIG34ktGAxsKEMvcnvYeoo87eed0x3Yk8hdMndW0ALIr5NUTr2QYrzOmKendht8cu89zk0967
	Dd
X-Google-Smtp-Source: AGHT+IFZaWbZGtAjGdCfp4O+yDRRSOyspGYsQrG3GxUOnvH5XrXZUNFKqmpRaeacRw4JF67zTIEhLQ==
X-Received: by 2002:a05:6a20:3d96:b0:34e:e0ba:7bf with SMTP id adf61e73a8af0-34f839e0a8cmr3972462637.1.1762341457709;
        Wed, 05 Nov 2025 03:17:37 -0800 (PST)
Received: from aheev.home ([2401:4900:88f4:f6c4:54cc:cfa8:7cce:97b5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586cec1sm5914971b3a.38.2025.11.05.03.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:17:37 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Wed, 05 Nov 2025 16:47:21 +0530
Subject: [PATCH] net: ethernet: fix uninitialized pointers with free attr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-aheev-uninitialized-free-attr-net-ethernet-v1-1-f6ea84bbd750@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEAyC2kC/x2NwQrCMBAFf6Xs2YWktRb8FfGQmhezIKts0iKW/
 rvR28xlZqMCExQ6dxsZViny1Cb+0NEtB72DJTan3vWj927kkIGVFxWVKuEhH0ROBnCo1VhRGTX
 DfjBF7044hnlIE7Xgy5Dk/Z9drvv+BeWgZBJ8AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3554; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=K0CJ52aXaW30yOkXOm79Sjwlq8KF0ufVGkRrUk+tqGg=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDK5jbzeLrarrTJbv8jhoV1Uz+lgBfPeJ9Lhc15/n1e81
 zz/wcWWjhIWBjEuBlkxRRZGUSk/vU1SE+IOJ32DmcPKBDKEgYtTACayso7hf5rCe93pl8x+tb/O
 miN6XWDtImevtV8Ef7QoJU5fuvajwGmGrxJvLt9rqLFNFHtgXvzgCk/7goaFaTxWh7LW7v37+gc
 HHwA=
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
 drivers/net/ethernet/intel/ice/ice_flow.c       | 5 +++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 5 +++--
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

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
 
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 43f034e180c41a595ff570b886569685a56f9fee..8dcba7ee36130d94ba3436c99a5cd5f792a2962e 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1505,7 +1505,7 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
 		     bool skip_first_cpu)
 {
 	const struct cpumask *next, *prev = cpu_none_mask;
-	cpumask_var_t cpus __free(free_cpumask_var);
+	cpumask_var_t cpus __free(free_cpumask_var) = NULL;
 	int cpu, weight;
 
 	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-net-ethernet-7d106e4ab3f7

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


