Return-Path: <linux-kernel+bounces-892304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B61E1C44D03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59BEA346124
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE9D24169A;
	Mon, 10 Nov 2025 02:59:29 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C98C217F33
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762743568; cv=none; b=WpR3HQfSSRWmNd2onHOhO/qIC4chtpZs+EUnK5ryIcq+7fvkXpwFcZPA/i0eaTZMxWMWF6EnwWBQTkJUyCD5xI2ATEojfEQ2vEls/jPoVvNO6MZJCrAXOtVpkLe1PkhW/HW2Z0mO0Y57sI9fmwBwJLOXIdxpU8h+WMN9MtfaVMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762743568; c=relaxed/simple;
	bh=Xifd8ZaWsLkNZz0Hh8Km26lmPVu02yMtqS4EyhMVj80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0OQiuUj8QQ2fRGKx46yzUF6hcKJep7riN1tK+WHvwM9dgjX/2jT6C+qt+hp9b13S+XGHSykrfXpQeMO7hqjOPEXHj+K5OxVMzRL/FE3g/+L/M13Kkhn2EyM4PXNkjuq1EACHvqIa9dx5sm55KZNs5AtPuB1E0+tVQeioyNLrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxndIEVRFpw0EhAA--.5888S3;
	Mon, 10 Nov 2025 10:59:16 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxXMH7VBFp6YktAQ--.14886S3;
	Mon, 10 Nov 2025 10:59:16 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] LoongArch: Use CPUCFG6_PMNUM_SHIFT to get PMU number
Date: Mon, 10 Nov 2025 10:59:05 +0800
Message-ID: <20251110025906.17096-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251110025906.17096-1-yangtiezhu@loongson.cn>
References: <20251110025906.17096-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxXMH7VBFp6YktAQ--.14886S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZFy5GFykCrW7tFW7Wr4xXwc_yoWfCrg_Gw
	nrG3s5Wr4kZan09wnFgw4Sqr15XwsagF95AF9rKws7G3s5uw45A3yUt34rZ3s5KrW7Zrs8
	K3yrKF9IvF1j9osvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnAwxUUUUU=

Use the existing CPUCFG6_PMNUM_SHIFT macro definition instead of
the magic value 4 to get the PMU number.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index 8ad098703488..2d0c14bdadda 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -851,7 +851,7 @@ static int __init init_hw_perf_events(void)
 		return -ENODEV;
 
 	pr_info("Performance counters: ");
-	counters = ((read_cpucfg(LOONGARCH_CPUCFG6) & CPUCFG6_PMNUM) >> 4) + 1;
+	counters = ((read_cpucfg(LOONGARCH_CPUCFG6) & CPUCFG6_PMNUM) >> CPUCFG6_PMNUM_SHIFT) + 1;
 
 	loongarch_pmu.num_counters = counters;
 	loongarch_pmu.max_period = (1ULL << 63) - 1;
-- 
2.42.0


