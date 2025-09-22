Return-Path: <linux-kernel+bounces-827470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE0B91D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E285F4E2612
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5D2DE6F3;
	Mon, 22 Sep 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtmW1BKG"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA625CC4D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553495; cv=none; b=jokDcn68bIOpCtV+VA4uQpoadhCv0MH2f9EKC8IBUba6f3KT+V94r8GgHh+ri+mBpkvK/ePOcxZ2k+tAC8MSkVyHmI6s/xYQIFRNAGwwdnHu5HuWtXUT5UxYlTeycm/cu4ltE68SZw2l3mq4Ctn7VFx9Q71jcqxkzhMb/XuTkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553495; c=relaxed/simple;
	bh=F3TQtbkViaiam8gUJt5ndCncukrSdnsgNg2kTTZJSK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eU7EEJhsBfoKwPoDzg0T1SajEkM7CzSnZ6Bxje0PnxH7Tmq3duW7YLl5s22sQv6IHEMOocpneirn/zAK0KyPm+khqK/ZKkjbMnOo5PJzFKjlzhZpFY2BzQNXlq4hLIKwO9BmQbhM7NIWlGqcW6rgn7deHKqlqiKPqSTnjVBnFZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtmW1BKG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f2c7ba550so1260961b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758553493; x=1759158293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0Wzhr2GBiLR9XupCOurqAE0qKgHtMmqWf9RdNsZ+l0=;
        b=NtmW1BKGGXMF4akKDR7W8Y3PfmjDMZtzHAxyMgSBdtVcQyd+6B5f+Nj+v7Xk4DvqhS
         QwZzU3bc/2wWI6zpVqCNUZyZamT81yzm5FEe863uLw+UoqSBC9BT23aeALwkgvefQChl
         PMoe59/atJf2iQg3NC53bNUuONEWjIgFc5VQqjRfy6YU/TApf9E5Nxtlcj/aP8Js60P7
         ZubE89DEB1fUrfabpCP8ZxBWdz8D9HRLHgrvUs6auqKvNQdVMZv/on65p0MXB+km4KSv
         PlUpv68WyNLitxpzGXrhZgpFc9ql7Od4ch2AqROWBeJbBf2ny6lrNAgyL4xzgwX/D3qs
         Y7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553493; x=1759158293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0Wzhr2GBiLR9XupCOurqAE0qKgHtMmqWf9RdNsZ+l0=;
        b=bcIAv8WKSke1nuHQV/+e+TrsEPbXwcGQng6hAjCk8m0f/nkr/33AOZHDLw5EMTCSfP
         vleMWuukSOMPqHadEPnYlxyJL0M5Dmt4QKAHFn3q1aVpDf8B1SRxyo5Y+50jI1/k1TA8
         4mefw0Z+CwhdYUGOTG5kjUXcQ4u/TknPb/4pjuZSXM2JspWN4LbUeFE9wC6n5DROPtRk
         XrJ7+KvjReZuPllXraEFl80e5EzjHDtQgsKJZ+fC6k8WG91TOcTWvW9qA4NjWMVMc1tV
         IMyNjhIoHMQIJKlSBoK6+ZPqlLCHhSguBq/47/vMWJ3Uo3wPQEdWipzsholWey+/3arC
         jz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiHI8ehGqtPihhPNnJq5dqu4PlZx2v3Zc9AKL7RQ3wLLMWAwsge8X9aISSaVvhEJzX4gqb4HbZThEjB/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/TtKclTCfZCEHCQCHQD/u9Q+dNsduONYb4LbvJFDM3OcuTJHo
	P2GMfGxj0nE+JZtIj9Bsl54wY7zzVYljZo/+yoGFki4l9776B5Q0nZCe
X-Gm-Gg: ASbGncuVKXA28VN/zBl+CKlhUW3UULfNkVFrsJhlhznO+R9LpNRtL4jA3meO3Rq66GD
	LHk3ml8oGqpBxDKRdJ+b+89nLGuBlDsLb8iYQFj5jhSbeBM1Q/V9sJMQIEvAhQeWjCfFJY3WFpb
	wE6QoQHh6yX5Cp/9h7eDK/3AfrvjRNa/hj4TVp63KqDwdDCJOHRSqsX4mUR4j/TN4U3NaPFQNpl
	BQ0IhAtmzMXz2U08HT1troa41mjPeM3U7CFVn0iOUoFEKqubsVVCOvq6V0tVeRxG1zD0r30gRiR
	yo+M9FjCmleZ68PTK36bAawBjzwsJfqvsImcpuDqMTycYOT3xU5P5bCZIh0D+cn8b/CKPaJXG/r
	14SyR5iGQYCtWKXvmpVRhdA==
X-Google-Smtp-Source: AGHT+IFeAHlS4iAJPoHh7ZOm/cwEens/eNTaBkhmdeLozkDog20ChhiRrPA5x5jaDTgoFT+gLSoGCw==
X-Received: by 2002:a05:6a00:9289:b0:77f:2ab3:32d0 with SMTP id d2e1a72fcca58-77f2ab33626mr6873061b3a.31.1758553492759;
        Mon, 22 Sep 2025 08:04:52 -0700 (PDT)
Received: from lgs.. ([101.76.246.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f315029c0sm4101850b3a.47.2025.09.22.08.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:04:52 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH] powerpc/smp: Add check for kcalloc() in parse_thread_groups()
Date: Mon, 22 Sep 2025 23:04:42 +0800
Message-ID: <20250922150442.1820675-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing it to of_property_read_u32_array().

Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 arch/powerpc/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5ac7084eebc0..2da064e00d0d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -822,6 +822,9 @@ static int parse_thread_groups(struct device_node *dn,
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
 	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
+	if (!thread_group_array)
+		return -ENOMEM;
+
 	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
 					 thread_group_array, count);
 	if (ret)
-- 
2.43.0


