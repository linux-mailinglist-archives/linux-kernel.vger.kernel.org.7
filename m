Return-Path: <linux-kernel+bounces-795030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCE0B3EC03
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC480441D2D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A02EC097;
	Mon,  1 Sep 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmPcbDH1"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA31E2853;
	Mon,  1 Sep 2025 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756743135; cv=none; b=HS+9IPj0xuWDhhCmiOMgAM3qypkS05cYkcOEo3fQfd8rI55YIB8GRoO57SjUjs6ToJvpvuHzF5BSKOiPsmGh7U6VQRxnF93qq0hctQOuASZTiJcqhPbeFmROw93maz+AJ+LzaRPzf9pYQfNfbwy5mHcrSSGxJi9fvOvNJBB9nL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756743135; c=relaxed/simple;
	bh=RTgVZ/tWCs/wB1PkBZ+7HN/At0NDQ7KGQy83/JPMBrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inzybLtaK8MrKvBOI3Pks5EHxN2O7m3pGKzXObOMMnU6FVe05Gb9DIf5JcA5VQouN73bVKjGLb3oRI47TkYWMKYK5YBOaU4uTlb1n+nVOmDT+k8rU+2oPyFyr4jRgKsIazScX4FeA/VySFcA7FcuFKh4G702DPXhXtcEYGRHmGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmPcbDH1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f6507bd53so4223735e87.3;
        Mon, 01 Sep 2025 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756743131; x=1757347931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR5U0GiIoCstEf0PCG7w65hy/kq+C+pU3vbHd97JlMw=;
        b=lmPcbDH1grCwnMvAV+PD9w/ch7I0PFL+3T9goqYNw0BgvxzCqmNVjCnjMyLsVTYJp/
         93olnL4vALSjo/+9KsVpsenigfqxLs/srrzsve4Tq36QnNShaJ+rQCps7cupRCSlYolI
         eggS11uI4m8zLsLd7F07t6YBJdutwXdgQWQRh9vqzca1sPPnSBly40EQltmpMmPc42XI
         bOKkTGZS+8Ifq9T617WuT5wEckxCc0lu2RbtE42Lnl9lKc3xSvDLX8n1dcIk3vfpz87y
         PPWtCqDzSAnI94BcBEE1wQFoPMBb3aCgAU8Z0pGo4A2EXpuIE3zifOv9wZv3duqKnGSI
         pcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756743131; x=1757347931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jR5U0GiIoCstEf0PCG7w65hy/kq+C+pU3vbHd97JlMw=;
        b=CtSeKNEmL2PMyu76ojmm7tG2PUWLEGsv1RCw8yBIFx3vUml9BnmyDnMsjmMOVSQ43t
         mVdM0gTmaIOdfHlocO7WRWthf+LPG/ozIYuiEYJk15uLNdlZ2XJ6sHo9uAMUDbiMFTxw
         7r5SiDkeikrGcXorQZQEUdQFDaHmIVYQ5HkSJvesPDq4xJ5gdLo+TOZsDTznHulnfAfi
         dvlfrO3zpX2XLcBGeYUOMuYX03I0fkyil4rS8/KeBrmk/pk3jPcyWi+i28U7G33hPVqw
         foeQLqg+9A++QlDNgHl61caeshRFhwZ2+ip3SOQ8J0wBUogFkCrOS6iDiIRJM0LOg6Iv
         Zmng==
X-Forwarded-Encrypted: i=1; AJvYcCWF8CwVdZEzuZypA00j3BRe16XGUt5h3TGBLV0vwok+FuCqsnwwdRf4qSp/pMrG7ugCYBCWFtc29Q==@vger.kernel.org, AJvYcCX2wUJ3gXsIoc0KtGEU0Vri7RvnLWUh6yoIlenK2A0t1S66gjaIv7YxtBf5mWP1vT/N7kVxtzFopC63H1eG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyle+Y8/rp5GNGN6LbUb7fz+44pSGKYhNbwwl/WohgAjg3GCBFy
	NYKY0qUy6Eb8dBQW6saJnAngYBcQVMyxc35KCiy7XmK8n8EOmP0G0Sgn
X-Gm-Gg: ASbGnctjc0IshdtQXyGBaWa7lEEBB1M6JyqZjeIO9iCNmUJZoy+7Jtkv5k4QUPFSIxs
	MpUZcs0thoCysxJ/pMbgb7a+5BGJWB2fJLbbt+MTslEvBX618dve5PEA+X6QKMfURCvgkVqL9Wz
	jEbinszk7DiPYB8pIX3RPfx/rmVPpC+BZFsoVp5MOub7aufh+kLcDpa+bFB+tOapfW99ncjeAyp
	vHV4QwVSNX3C+ECKTTcql5/3qQQsQu1W2V7JUujed6QqQWtQHQWG9Ybc/6PvmhdlVdLaRMUDpYD
	SEtjG/S1bVphc0QJyKfLdsaqDydpt/nnTFyHgran1i+Gwv/VD1HcwuSoqndA0MIa70cUVWmDB6e
	SnsUk6AJNcE2d8H2CGzGSK4J3NdKcYr4D2eSfYa+DKMfHnwjj034GAFCquZeUyC4=
X-Google-Smtp-Source: AGHT+IFaXqH9CADxycoDgqI+b75bAc2xtq7NLNY7LkOnLxNd2myOg+LoH8eqmbYeCDb6MhFjgIF5fg==
X-Received: by 2002:a05:6512:a90:b0:55f:6902:c9f0 with SMTP id 2adb3069b0e04-55f7094841emr2964984e87.43.1756743131319;
        Mon, 01 Sep 2025 09:12:11 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([88.201.206.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f6771b237sm3028827e87.54.2025.09.01.09.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 09:12:11 -0700 (PDT)
From: Artem Shimko <artyom.shimko@gmail.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Artem Shimko <artyom.shimko@gmail.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firmware: arm_scmi: fix alignment in protocol_id_show and debugfs calls
Date: Mon,  1 Sep 2025 19:12:03 +0300
Message-ID: <20250901161207.2501078-2-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901161207.2501078-1-artyom.shimko@gmail.com>
References: <y>
 <20250901161207.2501078-1-artyom.shimko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes minor alignment/indentation issues in the SCMI driver:
Adjusts indentation in protocol_id_show function to maintain consistency
Fixes alignment in debugfs_create_file_aux_num calls in raw_mode.c

Signed-off-by: Artem Shimko <artyom.shimko@gmail.com>
---
 drivers/firmware/arm_scmi/bus.c      | 2 +-
 drivers/firmware/arm_scmi/raw_mode.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 24e59ddf85e7..e1e82139997c 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -298,7 +298,7 @@ static ssize_t modalias_show(struct device *dev,
 static DEVICE_ATTR_RO(modalias);
 
 static ssize_t protocol_id_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+				struct device_attribute *attr, char *buf)
 {
 	struct scmi_device *scmi_dev = to_scmi_dev(dev);
 
diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index 73db5492ab44..c85647562ba3 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -1280,8 +1280,8 @@ void *scmi_raw_mode_init(const struct scmi_handle *handle,
 			chd = debugfs_create_dir(cdir, top_chans);
 
 			debugfs_create_file_aux_num("message", 0600, chd,
-					    raw, channels[i],
-					    &scmi_dbg_raw_mode_message_fops);
+						    raw, channels[i],
+						    &scmi_dbg_raw_mode_message_fops);
 
 			debugfs_create_file_aux_num("message_async", 0600, chd,
 					    raw, channels[i],
-- 
2.43.0


