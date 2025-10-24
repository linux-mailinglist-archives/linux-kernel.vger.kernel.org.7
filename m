Return-Path: <linux-kernel+bounces-869103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB9C06F48
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D7303527EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC7A326D5E;
	Fri, 24 Oct 2025 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="YMad+Ui+"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F183A3AC1C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319559; cv=none; b=tF5oz1Y+f7DWYprIWIzzowdd9GAkYgqJoHCchp8FcaVAfqrCdo8IBF8ziTs/Lc1ybHEZo/GLCUeCNJAXtIgQ+KF/Ia9tiz2uabWVPsPShQlxh7vKfPbNmfpdK49H7Q33jQp9PswbSa8C74eClrwaS9p5h6xZkNyxUoQwNh/PQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319559; c=relaxed/simple;
	bh=fja91hhNTAD2uFFp9ltnm5Xmev+0fEePBFFlNHs6kKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkTK+Hv+Bauriey9xUCz93c3jjte964Vkj1rt2vBT1kmYxnHf3l8FoTl0o2hDBS51wX7+om4QwdpmlgTpTBJ7IY8UPSveCJu/rdUlXhtxhqMm8EU2d7FC7XAMqCJmfJSvylfbCvQkZPr562JRiDWaWOqXF874IMm5YxDNJjUbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=YMad+Ui+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290c2b6a6c2so24640225ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761319556; x=1761924356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/T1Z+K8DQK4zGm2l4hT1fnBVPvldXVlObiMpVzg/wBA=;
        b=YMad+Ui+gCzdOxEHZy8gSopcxU+q55qq5CTnsvUPnj6nRulddk3QK1GjtLohB8kOWu
         H/rx2L+ADJQtkEIYyHsLmIw/rHfaTQ9lzFxhpk3yXVxcuut2OJ4DLRCEs407+WMZl674
         eq7nyRwbvwfL6+2I+4LcF7pCzvhxLLlaooBtPdBGtH6VUTYqJTqqB80HzVz2jMPh2LQS
         eKsnx3gvCza93nLVaBF2iyiSUISejCbeHJYJAt+3WovLLj4IW9UJYKL2HC3jOLJ2pXBa
         CDLRoUpv8YBTnR0gev1Way3T9guh+9TUOSTBdqAV/3f6TJw/h7kubVSdmWUKubum1Qeo
         +qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319556; x=1761924356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/T1Z+K8DQK4zGm2l4hT1fnBVPvldXVlObiMpVzg/wBA=;
        b=AE+H4fD2dX0bR1La3T2hWcR2dJpt3FYkByPYFKIB2fIKOvnPHs0tn6rASOeAtdAadI
         U/CiKFOtrBhQ6061fytoYiCtThpktOqvyeAVIsWoS+hMfIsTY36HQXvNfm4ugbvB96S1
         XTcAqiWVMLn5Xpn19iPVD55FPu3rrl0PU3urf32JknzQ56v+1MwK+qVkCTiRHIJ+Pc7A
         NbO+RDu0tpTIiPEE8HP7VO+cpwt2bIbXsdU6yjf2zlbvQciXi7XcFS1ycTL85dfP08rh
         0D1Ulh6xOeX0JBumCgOzN6ZrnzSjjGl0jXBBWmjOGE1TYVRkaV9MPRQiBRn8/DpflhyF
         kQJw==
X-Forwarded-Encrypted: i=1; AJvYcCW2eKU/l5rHR+gVyMwDfFWwECljUZ3jDPiWar7FB3rJ+5m7LYap+Sa+Ir/2buA02B5V4rKrzcjLhhfyZGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy57waIAb3IhC5KyBxjGHRNw+xeOpTZDtnprxsgN4pmOpWU/JU
	4n9dXDRgTiWkid4Wpofa6l+0rfw9qAvuHESWYNoQip2YQFkLOh/GBuYBEikcHeHX9Gw=
X-Gm-Gg: ASbGncueZ5HTGOL6s9uVRkH4LAex9kP5Z3f+a1y9n9272AltLpIec+VTj4JNcHF1Bmg
	8+5muOppgVvioa3e0j4sezOfmWuKXD9RKsxbwafUNmUXFtcecj3GmlztYVW5u6QYtzOBCGTAVFg
	XXD2eMIHz4/1il1BxfU4tWrFlg+XjSXpv8U/Y5JikQrZGTmIBEAqjVgavHjPZprPMmcN++gY6Uc
	tw4zkWrrblYg8fHe724xJDpWg3SVYzCaAlIQzsWIydmMuD45RPX3n+mmojyRRWCPz0PxDJLErmC
	tFWQWR3KTdvvot7KS64ZXk2yfRim8tK9AeQobFlLmqJ9m27bJgHBdjbnk6Eo83AsPjc+Z9POSM9
	ro6l8Tv+KIjSvEaEj7Huw86Tw0pP2BVe1ppiEpBvtXAGo/0EVpXwrAJ3kbRPS12Jk8eocI1zt6d
	sXfadv9iqc2NhrwWrn5tAlQQ==
X-Google-Smtp-Source: AGHT+IHrQTR8H4ei07O1j4Cthyaw9aGZFdCNOut1bzwa+dLtNpq6RmIRrnDxWJ42MNn2CSeAbj9IfQ==
X-Received: by 2002:a17:903:19cb:b0:28e:a70f:e882 with SMTP id d9443c01a7336-290c9c8c5f5mr17531795ad.11.1761319555989;
        Fri, 24 Oct 2025 08:25:55 -0700 (PDT)
Received: from localhost.localdomain ([49.37.223.8])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-294942c412bsm5135135ad.72.2025.10.24.08.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:25:55 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: kuba@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	tglx@linutronix.de,
	louis.peens@corigine.com,
	mingo@kernel.org,
	mheib@redhat.com,
	easwar.hariharan@linux.microsoft.com,
	sdf@fomichev.me,
	kees@kernel.org,
	niklas.soderlund@corigine.com,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] nfp: xsk: fix memory leak in nfp_net_alloc()
Date: Fri, 24 Oct 2025 20:55:22 +0530
Message-ID: <20251024152528.275533-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nfp_net_alloc(), the memory allocated for xsk_pools is not freed in
the subsequent error paths, leading to a memory leak. Fix that by
freeing it in the error path.

Fixes: 6402528b7a0b ("nfp: xsk: add AF_XDP zero-copy Rx and Tx support")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 132626a3f9f7..f59466877be2 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2566,6 +2566,7 @@ nfp_net_alloc(struct pci_dev *pdev, const struct nfp_dev_info *dev_info,
 	return nn;
 
 err_free_nn:
+	kfree(nn->dp.xsk_pools);
 	if (nn->dp.netdev)
 		free_netdev(nn->dp.netdev);
 	else
-- 
2.43.0


