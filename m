Return-Path: <linux-kernel+bounces-874328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8A8C160D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14731A66243
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A88422A1D5;
	Tue, 28 Oct 2025 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="c4GnotxL"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C428D8F4
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671121; cv=none; b=BJ6+1ZC2sydeNTtZWaYy/cFmyOZE6Bim3uw81q/F/FzGFu4zyZo/dwlkDWoneXuZHip8ziGXVjO5S13L0g+AKbCNxTieQ+kTvtFY6K0S3SbmKNWx30/5UeZNrzFZKNwG0U9Zx59jnnyGNlZOKA3yzDojRGHjKsI+5gOWac++M30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671121; c=relaxed/simple;
	bh=N0/zVLICnxNKLek4t08+XI7tTQ7F4VIB4xy8YpVu/X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oR4hYUXHRToMZDsrsEdLeKfkpfyJiTiFozeKsUckLUtjpy2Xv/mPX9MUpg9wqye2QkOjI6uYhnuBK1uylaKylu67H1Bn+CFlEKFa1yd1FybXQaZ5LeiDfoGC9UvmTs1PKZTYTe0WDjzxUFei/sEq87tBrX1zpVE/39NKPEYarR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=c4GnotxL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-780fc3b181aso3957530b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761671117; x=1762275917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iBmB4qbptLfyTLiupE29rEaJ57aI2ZRJhbVvsp8ICt4=;
        b=c4GnotxLcEERpWB3rJJziQb67+ooOwT+vJQuzsz1SOuEEGUpXpRKHh8kTpuid2pDYy
         OL3qe4qNpzOX06It+jQomvRqgIXkHTgwpBDwvzVzoE351MyvvQujr0ng/BbxWmlJk542
         Bxl8J8jgULU9ykuI9LfGKLyEfvStXDfqJwGs4T+eq8hD1H80HTvmZbKB5DX+XNXgxChs
         +lG2vnE8bwQP5PZi09wi8chmv0sTCmpyuVy/4yTDZY+uD5WD/My8Do/rosOzIb2Q/iJ5
         hDUhuzuOm6n/48NnzQX6tIP/AhAB4dZugVNYBpaZ4eRHQfKPSXO+vDsYQJuBRyNMsqlI
         JayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671117; x=1762275917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBmB4qbptLfyTLiupE29rEaJ57aI2ZRJhbVvsp8ICt4=;
        b=h+s3K0Dlib68k07w4FpdIEd8j+23xBpTZyi99KHCsPJEuFNYJDRmH30UCUH+pIMjlr
         3/90rI2ov2foDA+Wv3NOdfmu4O01CPTGKviKuPldbtyQP9q1wmX3MNAT+gbRA2s6vwrz
         lshAvxUGnitU6lvIZ4VdeUVsqPxXJbtL7Mnl9iAzuccRaKWUf01nHDZ7riJ9/oeqm+E0
         30VQ9311NbNT42350Nk0PFmlbl84CiBlyJG/NRr+JyMOjmab69bFul9dPQNJPByikadU
         imRvp9W0x9NTDNG98QEE+cVpSdw3DxyOrS+Vmiymx8WRrRbT4q57KExxnhg9QEhDQvxo
         U1zA==
X-Forwarded-Encrypted: i=1; AJvYcCVZhwx/u4N3hMMnhyVgajl/h7vbd1YxV9b7/8JbUVSjPvGvBQ+XmdQ3cn0CMCPEDZlKT2fl0rZtd4cL1cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfmcpN1bxCLBXyqoVVnuWkbfB9vZx0dxsxt+vg1xW4rMFJ4Ic3
	D1EtEorOgFOly80DXMEpJrH0UEcKCkswYcWjDGtKNFexGmRdFFYC8SoP08KBYLMy+LQ=
X-Gm-Gg: ASbGncsF4TVh0kCB0vqDFhxqXQQyPAOQTpb8T3ddhfkJyJ91xzIYDpiI99tFBbkpyc5
	z5UkwSEMCY1S4ZjZAunh5G14CC41KTC6+9zqpxneRd1HvbbFIY1lkkUeyiuu9EcYnNIBE4jhimQ
	S7h8MIY4xeAmL3ONG3TsNnH30U47VvFpaEzEpJUkAxYqgLoWo9z80NrWajQ91TQrZsvu9iGaNc4
	ExiIhxXjoonxGp6VjJS4sqaxlOwcF+gmo6vHCIESuH/cIW7bpWqrhhSc+fVBoUaZdvZPh0E8R3w
	cA0FZGA6MDPjfsFiC0N4dLM6VbS9fM+2MCTnQh2QZmHQTLcZ3KjA3DoQPJO12LcApWYsnhUFTuU
	v1uFF7ulvVxTNCa67mO+jBXlOveLslF5thBs1dNV+ivJRFlvTYjf+wgXMg1u1iabVmmZMkic91n
	OCry6il5O/V4lR
X-Google-Smtp-Source: AGHT+IHjvH8tEuZg+gXvi6IM/+7or2ktCuzjFSHVpKfrsaF2EYXSWsRTQJnVaoBW4TL1kdx24muqFQ==
X-Received: by 2002:a05:6a20:258f:b0:334:89c6:cdeb with SMTP id adf61e73a8af0-344d441fa42mr5353099637.56.1761671117283;
        Tue, 28 Oct 2025 10:05:17 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.46])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a414068addsm12508862b3a.44.2025.10.28.10.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:05:16 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: jjohnson@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath12k: fix potential memory leak in ath12k_wow_arp_ns_offload()
Date: Tue, 28 Oct 2025 22:34:55 +0530
Message-ID: <20251028170457.134608-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the call to ath12k_wmi_arp_ns_offload() fails, the temporary memory
allocation for offload is not freed before returning. Fix that by
freeing offload in the error path.

Fixes: 1666108c74c4 ("wifi: ath12k: support ARP and NS offload")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/wireless/ath/ath12k/wow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index dce9bd0bcaef..e8481626f194 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -758,6 +758,7 @@ static int ath12k_wow_arp_ns_offload(struct ath12k *ar, bool enable)
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to set arp ns offload vdev %i: enable %d, ret %d\n",
 				    arvif->vdev_id, enable, ret);
+			kfree(offload);
 			return ret;
 		}
 	}
-- 
2.43.0


