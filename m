Return-Path: <linux-kernel+bounces-863677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C30BF8CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA6EE503200
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE01284690;
	Tue, 21 Oct 2025 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKsB00rc"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8226FA60
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079911; cv=none; b=DqzRBJEf4RUzfYCKKAanGrRRxuGCXHjnCqXK3ShNRkDMhMHXAOyAMDbcwJPb9ZLlp5Yus1tVMiVNlEGhe++gCRlqFjuYSz+fmNyMZicxPZnBjFtgTk8AZ3ZnhNo7gf/IF0OVOzWRWCEAinRvd6mHEGskR3Nl9B81WklL7Y59ILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079911; c=relaxed/simple;
	bh=MjkLnc2tVg/RJb5BApj/E98F+C69Oi0/gfMCl2ZTnJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLTOZ69T/zT/iy07EP8r9rr0UcIsZbIozWelC1X8sjKcT80bpYJCZGfTKXRlVmFipPQv47kcB+J8hKxMEklTmmZ8y0yiNTSqnxXVWciNhaQUE7qP63Y/2dg5txhPH4hGJCX4gx+L0f8kacA4WJl8ygMOUn1oYkLrBz1sEPWm66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKsB00rc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290dc630a07so32386255ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761079909; x=1761684709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWnNLlNkfbiftBrKkWUkiWaeBS4JxfSDDd9vblIlhTk=;
        b=cKsB00rcQJQyTGCATp4VsekVlqP3C2BXisyHnar3lm35/fbwRrlrD/xioXlquuFSre
         MnfugRQJ//NRnD+N1zRHm7zM/gko9f8q7uTlBZmo2X/ramHzyk9rdv+nj9uVwu4uT4uB
         UKjdWKCIyVp2nTzOESY+XZo2jDPhjyjsgNywDdn7w8UcVsIzxpyXAI/MjaQojwGzTBZl
         KWCNgspdu6FwEL4hnybO38OjGLmPV1yEsE9dhcvQAiYo+ha63ACbFD7iXsgbnKdcxjtA
         8pd0GP3qrKh18krBD41vP6plttfbQ0a1Ydkxb6Trud1Yty5skc0O+XHuZ43HYi/5Ro7g
         35Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079909; x=1761684709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWnNLlNkfbiftBrKkWUkiWaeBS4JxfSDDd9vblIlhTk=;
        b=jbiSCR5/doNUjsH+to/uFCXWtK0Idu+QwAbfGvOn5TEpKKMop279LyRnKrGjWTZCbx
         wrQ23+MZtKBCF3eILZ/KE7QxwuG++UeDaC+AmX+uSudOOJ40PJXBZHWP9o23nQ/STWvT
         tY/dgMdMgmhFTcvuHDOZmbb/abQPvPm9FSFlXKIYisJ+rB6xADRsjkuicEm9Cf6yZwvV
         kTcreMwVoMlOUTh0WCLcWFJ3P/rTp5+M+uAPfWfSQapgDPxKvBiJBg2LuBDL/xdWelOH
         +IZF9HbNQO6IBrPqzcESxQ4Bv9n4Q3qcuw6OnIi5wU7FbpcY5adEWMcmytaaH3mHz1EU
         G6+g==
X-Forwarded-Encrypted: i=1; AJvYcCUvd/RiOkCs85wNbCJJ7pEObJtg8LGltOENSNAIVc5RiepuDp511+bx7Y4x7zDOumYmw6BtbVpCMPYvNMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgRjWLzKufmZYcUNNM9ugFd23WLT3EaQ/JNt4XDrpW3bQ5IBdl
	hsy5FPydEJMnAKEV0+3ZqYfdbrwJbK3NVKun659CBmdmLeURhD72PTa6lu6w+nd3roalGQ==
X-Gm-Gg: ASbGncvKSFm3XNrlVSfPulHVL95G7ZdPoFeL8XhzvVkofFccv+uD7+qlvIT7sOpibYK
	eubj3VJgIcVF8IlH+ZAFCBgD/e6ddhz6ygTdj3tEBQVRmEQyR0Xnq08RMY7q+Af3Bpjicwyw70R
	0V+4iyvXKZpNiQXF+V7d6NKP6k++25USVYf1NQcwa2R/u7Edgnv2ajUdb4eta0vYlGTcY6sVc48
	U3HfFraRpzVRT1Phv74/A6yn+OwVQ+rePjPZEYmnuSy46GrLsZAGKj2ImQiPVINCoQm/El0/yTP
	Aq9Q5N4mFXdXBCVKKuSuecvi4QIcHHf0QsiJPQnKqU4qSwWGPsW5nDdrosY/4H8d9qghf4GZQhF
	5m2A2WZK+82Bf12xqBh1fyKEc8iLdVNT3y3v83EpcY3M9PWKT8K3bTfz0jcPr3W/hHjD8oN0uBg
	dDoQZONnr5EhQc
X-Google-Smtp-Source: AGHT+IEqwMCwtpJe6M2AVLhFFJ0/uoQlhALmf+ZedDkgLsoDbgVNNdvSO65CLJQ2YxoWpuTW4Nbyhw==
X-Received: by 2002:a17:903:94d:b0:266:9c1a:6def with SMTP id d9443c01a7336-290c9bea18dmr221028235ad.0.1761079908830;
        Tue, 21 Oct 2025 13:51:48 -0700 (PDT)
Received: from skylark ([171.50.223.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcde4sm119174415ad.5.2025.10.21.13.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:51:48 -0700 (PDT)
From: Amol Dhamale <amoldhamale1105@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sriram.g@kpit.com,
	Amol Dhamale <amoldhamale1105@gmail.com>
Subject: [PATCH 2/4] wifi: mac80211_hwsim: fix coding style issue by adding whitespaces
Date: Tue, 21 Oct 2025 20:50:24 +0000
Message-ID: <2120f77e6cbcd7fedf9171f7e5eb58f7acda3273.1761078139.git.amoldhamale1105@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761078139.git.amoldhamale1105@gmail.com>
References: <cover.1761078139.git.amoldhamale1105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:

ERROR: space required after that ',' (ctx:VxV)
ERROR: space required before the open brace '{'
ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Amol Dhamale <amoldhamale1105@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 95582345cffc..51c0582e3b77 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2504,7 +2504,7 @@ static int mac80211_hwsim_config(struct ieee80211_hw *hw, int radio_idx,
 
 static void mac80211_hwsim_configure_filter(struct ieee80211_hw *hw,
 					    unsigned int changed_flags,
-					    unsigned int *total_flags,u64 multicast)
+					    unsigned int *total_flags, u64 multicast)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 
@@ -5710,7 +5710,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			continue;
 		}
 
-		if (band != NL80211_BAND_6GHZ){
+		if (band != NL80211_BAND_6GHZ) {
 			sband->ht_cap.ht_supported = true;
 			sband->ht_cap.cap = IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
 					    IEEE80211_HT_CAP_GRN_FLD |
@@ -6398,7 +6398,7 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 	if (info->attrs[HWSIM_ATTR_PERM_ADDR]) {
 		if (!is_valid_ether_addr(
 				nla_data(info->attrs[HWSIM_ATTR_PERM_ADDR]))) {
-			GENL_SET_ERR_MSG(info,"MAC is no valid source addr");
+			GENL_SET_ERR_MSG(info, "MAC is no valid source addr");
 			NL_SET_BAD_ATTR(info->extack,
 					info->attrs[HWSIM_ATTR_PERM_ADDR]);
 			return -EINVAL;
-- 
2.43.0


