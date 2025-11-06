Return-Path: <linux-kernel+bounces-889544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC70C3DDFA
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A76DA4E7AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B05034DCF2;
	Thu,  6 Nov 2025 23:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3OQPmqm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+eQvckk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7034DB65
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472463; cv=none; b=f0FSL133R8RsiHC5RJUi6OUKK7XBXAWf+8UMwrlg2UThnh/AISUtr77FNoIXpdK0Nwe8vSWy5F3Lws9knTokRjJLHRwub+lFvhUFpJQLPkXPXZ8CjcY6nHEFFEAYl/9CrQiY2s2eaTCHtXtJiAEgvrepOnHffdY7NJjfJ9f3IVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472463; c=relaxed/simple;
	bh=9jMZC6UuuQ859ZjuOTCqEY6qe2p5U3lf+6XaIq1aSuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ftyzg8hgH00wauBUyIdJqvxHzjsO486Es4/nSZBYz2bLbXCvLWDgh0gowt56Bb2/c2YybQvymeGRAaXFLztZQefrdciNipDs8lE3nS3vGBnPEm6P+84+rhAx+KcWReJzUAS7WQEDj9wzYGapWIWtTSSBZUTXJdx8IeG31Q/eEl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3OQPmqm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+eQvckk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762472459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qSi4lhcoeovU0a2BfWKOwxA6Oh5Rnt06ISGW5gYuQ/I=;
	b=Q3OQPmqmVbT/Gg3Y7Ut3ZnE0lxF2MKVSZNwh38ECFTQHgJj9nwJCJYFPXFMkDlTeXm2y/5
	I0XAxMIaRQTiSqV61R6BKx2bF/q7BKDKS/5P3UZiYjw/WetwhHo0tzlRvduj2rBot6gjds
	ao5ZinuppKfFV0Imo9By0jzHYTZhSKA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-7nVb-hgWNsSidQRRMjCKEw-1; Thu, 06 Nov 2025 18:40:59 -0500
X-MC-Unique: 7nVb-hgWNsSidQRRMjCKEw-1
X-Mimecast-MFC-AGG-ID: 7nVb-hgWNsSidQRRMjCKEw_1762472458
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b24b811fb1so13507785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762472457; x=1763077257; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qSi4lhcoeovU0a2BfWKOwxA6Oh5Rnt06ISGW5gYuQ/I=;
        b=d+eQvckksPH1tycXuIt2zTEwVBSQxhEf0aNwlzi2LHzbH35GKpxMZClwPFC3Tkl9S1
         U0Awurub3ly8lOiC//FyJcLg+szuKSjQ+9O7jgYF+ZTs+dmA2u4Hk05rrigUzGF5H+PR
         o5WH/SpvcXxNaShEyGwFIw7AkkwzwJneqjIROGF0KCi7pFzHk9/rX36jqkxsRRBLY2wR
         SoC5BugwWe3pfwL0Ub8w7dxvIrr10976izR6GPyhYOnRV9m0ewP99KVdfYN/ywu4DflE
         jEim8MicdBldDyLyLueJBO9AzyGwEfePr2msCF7eoRlZY8IL0oPIeH39HKsNKGPplzF7
         OWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762472457; x=1763077257;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSi4lhcoeovU0a2BfWKOwxA6Oh5Rnt06ISGW5gYuQ/I=;
        b=SeifndzfmKMEli6SqPhYfBxLlRN7s77R50wxn3BKHs8RU/8Vb0yycccC12EJGFccvb
         xOxPmRkVApvX/tn0p1EIEGJD5XPNc1O0LIyIe8qdAfqdRydu3HJB5k7dXUElUPxc9tON
         gX8Y/dBh05NEANWNxHiNeOMxICptDGov2tvvRhqSdtDi56kAiNv3MDrLaL8rctToapWD
         SIYhZecktpx9F4LsUAMKdGwIVKfpg8lWXj4Nrhg6mmg7qxEfuJs8vbigYtVYaN2Bt67W
         hNjbnHbUJfSaJwwE6JFt9krvkclMKSHWziQIPMShLvPDn8QYnNPks9cDeTLEhwfHtg3E
         vCPw==
X-Forwarded-Encrypted: i=1; AJvYcCUAWLfv4UowuINy6EqP5BWr6TzzQXA2gJ9aC+68ZfNl2TM+OCMpu8lQaKcOtyjchMt/40KJpSDxeoXQwpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbkj/oSVHFAEJAbcdyQpiWpgUSMtsX4MT4q4nCknL0XPeL+c+d
	bCKHM46p0jYlOqhSxkOSl5ujZfzPB2gJ2DfBH2kPctvCtOiWr4255YmdlW4/JZZtr04aKCi2hh7
	pJKsBHUBEpRVSXfqiZ5aLhV/U9t74Q3pRkm0mQfHcV+nwZUZwzLrb75pyEcVImbO7HPIZJBWfJC
	LeuuClSv2RSI71DjZ89cdE+qlDbhMz2SovcgPF4EQY1F7/PYaw
X-Gm-Gg: ASbGncvaBpC5BgihVlT19jna4s5NTX3s5t3RY6sgrgiBojbkTkHi/v64aiwu1DLHBE4
	LDYiDAECn8shdwm2HADp87C/DrFT/H58x4/3c0v3UX0Jh92RPL/WnmejQKC6whm/vb1O1x+24jK
	ReaoyOKJ6pnlmZ3RkKrlWnF3vWHvANSEugYYqnMc+UxBtQwwlMSmOkvPnJ/hj9KWBzNcvP0Rs9q
	t1Xtl3oh7m5jh2znBk27PVIxK5zkWoHuJZbv22KCpoHMFSJbo0UmHgwshGacbEB/UaAYrjjHplO
	WgBSVaSHU9jezFESTmuzBGEODmu07i5EgIdWsUJXiy/1WObgK7VYwNTva2gETzFg8I4zDOmuRvn
	9CEMf
X-Received: by 2002:a05:620a:d88:b0:892:234a:2b2b with SMTP id af79cd13be357-8b24529f2e5mr192101285a.12.1762472457312;
        Thu, 06 Nov 2025 15:40:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZT+H167P7va194juS5N/5Rv6J0nRNzshDMiBhjOQ3sW7gz8j6IeeYjW+L3gANSgDWIEeOcA==
X-Received: by 2002:a05:620a:d88:b0:892:234a:2b2b with SMTP id af79cd13be357-8b24529f2e5mr192097885a.12.1762472456852;
        Thu, 06 Nov 2025 15:40:56 -0800 (PST)
Received: from [10.197.115.224] ([2600:382:8110:2352:2c3:1cdc:5b7e:f260])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235805139sm289359385a.40.2025.11.06.15.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:40:55 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 06 Nov 2025 18:40:43 -0500
Subject: [PATCH] pmdomain: mediatek: convert from clk round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-clk-pmdomain-mediatek-round-rate-v1-1-49441ea27f84@redhat.com>
X-B4-Tracking: v=1; b=H4sIAPoxDWkC/x2NQQ6CMBAAv0L27CYtKAS/Yjys7CIbbEu2QkgIf
 7fxNnOZOSCLqWS4VweYbJo1xSL+UsEwUXwLKheH2tU3712Lw2fGJXAKpBGDsNJXZrS0RkYrjO2
 1p/41dtw4gpJZTEbd/4vH8zx/6JthAnIAAAA=
X-Change-ID: 20251106-clk-pmdomain-mediatek-round-rate-649a9bf7d30a
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2324; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=9jMZC6UuuQ859ZjuOTCqEY6qe2p5U3lf+6XaIq1aSuM=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ5jVh3Tb953fHtbe7Iucvuvtlo9X/DzsOGdqZLv/+TV
 svzYtnQ0FHKwiDGxSArpsiyJNeoICJ1le29O5osMHNYmUCGMHBxCsBEeOUZGdadZkl9b/baRNZs
 97Tz9reK+u+yMl67wrmFf9aUB+8V1igzMqxKux40T++Tb9H/bQqnX0Qmb17m17p9rXzE9jNZVzp
 dbTgB
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops, so let's convert this driver so that
round_rate() can be removed from the clk core.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
index af20111067c02a5f9a0d6d751e9e0dc32c1a4d90..9bad577b3ae4bf1b83d4f782bb52f56f779a8974 100644
--- a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
+++ b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
@@ -309,11 +309,11 @@ static unsigned long mtk_mfg_recalc_rate_gpu(struct clk_hw *hw,
 	return readl(mfg->shared_mem + GF_REG_FREQ_OUT_GPU) * HZ_PER_KHZ;
 }
 
-static long mtk_mfg_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *parent_rate)
+static int mtk_mfg_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
 	/*
-	 * The round_rate callback needs to be implemented to avoid returning
+	 * The determine_rate callback needs to be implemented to avoid returning
 	 * the current clock frequency, rather than something even remotely
 	 * close to the frequency that was asked for.
 	 *
@@ -325,7 +325,7 @@ static long mtk_mfg_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * high current frequency, breaking the powersave governor in the process.
 	 */
 
-	return rate;
+	return 0;
 }
 
 static unsigned long mtk_mfg_recalc_rate_stack(struct clk_hw *hw,
@@ -338,12 +338,12 @@ static unsigned long mtk_mfg_recalc_rate_stack(struct clk_hw *hw,
 
 static const struct clk_ops mtk_mfg_clk_gpu_ops = {
 	.recalc_rate = mtk_mfg_recalc_rate_gpu,
-	.round_rate = mtk_mfg_round_rate,
+	.determine_rate = mtk_mfg_determine_rate,
 };
 
 static const struct clk_ops mtk_mfg_clk_stack_ops = {
 	.recalc_rate = mtk_mfg_recalc_rate_stack,
-	.round_rate = mtk_mfg_round_rate,
+	.determine_rate = mtk_mfg_determine_rate,
 };
 
 static const struct clk_init_data mtk_mfg_clk_gpu_init = {

---
base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
change-id: 20251106-clk-pmdomain-mediatek-round-rate-649a9bf7d30a

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


