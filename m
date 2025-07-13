Return-Path: <linux-kernel+bounces-728885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03643B02E7A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 04:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F832189CA8E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 02:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E223F150997;
	Sun, 13 Jul 2025 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxg6rflZ"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025FEEB2;
	Sun, 13 Jul 2025 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752375208; cv=none; b=Ggg/OsY/9qOVQQLX0EUuLipiHEadX2+FBMc14Yf/S0uN2YKyGfI4uxqCX280W5I/omiP/0a2KAvcjbDHG5T/dekx/Z9Tq14uRqs3dlvvHXgOaivgM3K6r4MtUKTEoXlXDEuYPPg4ZgwWXcN2X1bl8ccbn+2Z14IunvHyS/nmGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752375208; c=relaxed/simple;
	bh=ZB9cfxxbIVyP7KXrPJ/Yfc0y2pVJ5wU7NtYTFa0gomc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QiawEUxqLB4N94br8ikiD3Ak7MOYsuG1ftoM6DHUIlE/RDiRtM39lHfngHYGLQc7Ow54U1ZmXqdURGGWwpQGjfDyuzn8EpZ04qIuiNTONtjHppSQ0Zh2rwnY+iht5t2DypQOsKNc3mFJgVF7tKvtCCPJH90CQvT0ztGhHGojHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cxg6rflZ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b3220c39cffso3390848a12.0;
        Sat, 12 Jul 2025 19:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752375206; x=1752980006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=acNe71zhPgHfE83GbVhM4d777Q2BYU21y6svlMAOGRE=;
        b=Cxg6rflZX/FypCLbjaWXZKLvf47G9l+LsDWR2PcC1LBHecvWu7NleVOLd9+99oNHO0
         cXcysN3Aj3epFLO0AvoNVqemYb21VxqbNA5OLu/4JHCvT5uqQcZjtHAJ31EsuOrPoUnA
         iBsLCFXSTzPJGOIbQC/HExZ33PYvspeCsooTUvHgq2A0us6KqvE14vt0QelKewrabwoU
         tUubNV8yhtTb08lgk4ijDB1SeCKeagVO0/w+4EZL371+O4rvmnqwx6tCnwN9uQr5EMCk
         nRDcHDywqK+nfiFfSHKaws6uESJONBj1KQH/VpIEpVCS+gX5J3YNkaDaJo4hcSrkkwRM
         XELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752375206; x=1752980006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acNe71zhPgHfE83GbVhM4d777Q2BYU21y6svlMAOGRE=;
        b=l9laXusjHKfsj7GbpKDiq62OiYwzukIqH+TvolF1zqA8i4cEy6199V0ll1ypa4iG6n
         FtiPJCPy2Z6kQwqcOShin9Af4tgbAC/WoselWw/cEcRf9gsfw9Knqzhs1cn/qD7Cm6Lb
         5FsnWcmTfilKss78KOOrluoY6ZWKyoxj3fwBu52WByzYccuQr+gdrDYm10/3ZmzNitsq
         D+VIH+LuQCoaLIaERDfH7JfqnMASF4Q0C4OXZv9a4PG7fW9s+3efPFaHVEGyrKePBd2a
         maR4B6gVxPFGoc19OOmR83ArFgU5PT1HC6HI2YXTA4IDLyoLj168s7UQFe9AnHqgsgYC
         tLqA==
X-Forwarded-Encrypted: i=1; AJvYcCVmlFf89I+RYQf8KGaOI7bBD3y/MoH2QADx3Z+mM3PPLiSlGPRHxvk6jMph8OZaKk5rP6JbeSzQJiuz1Ns=@vger.kernel.org, AJvYcCWIM/jGYWS9gXRWSWsftAwm/IytJcB7hUdZk9ko0pf21hAj6QlRmmqjYaUhYdM+LKv6KL2xKZhAJ+3EwU4JClk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzrfPo9u3fdu96qXUWjUw7afC48l0l8hG3ItvEpq5SFo/w5FJT
	FcudZfMG/+ZhpsVOZPp10NdAHyrkUhfImPFiBfmDANt/PJvqn6saBVCG
X-Gm-Gg: ASbGncv5DGSLqOVymN1YG20ga0YhEV+YNSL+vh/4LSjNXP3JWovQF0oGY4illMoIB15
	7lplmfOmk1RGudcM51ExHI9loV0VH1SLaQRVLq2ohoatFyuiiYPhd3EpcZHTLJnoOzmuR1H1GLq
	75hjFN4EmXqipCZjvC5/ou8j+73uUaSVprDZyL5nZiOi/XwkUUJKgddJZ2g+xi8ttnoq01K6Dad
	dhYtPB/ZXJf9btt7unvEs2/T/A1wkMI210ZJZN4dSkfH7QTw0QT9ZNkGIXjbP7K7OM7NaruNSQU
	IE5MlokvHhpc0rhpRfBPqGnNrY6gA3TTdojWzuij7pzgvUoznKJzfukzgGxqOp8yQqyb2Rxw1ur
	dNKgiCuNcovKkz7Vx4LVLjR+j
X-Google-Smtp-Source: AGHT+IGd8q7vYPk8tC8e4wXZEeiN7rexsxjv5S+Uzeguwh00QdTa0AZAe4a4z+mwvG8FjYaTfd9Kvw==
X-Received: by 2002:a17:90a:da8d:b0:311:b6d2:4c36 with SMTP id 98e67ed59e1d1-31c4f5ad1e1mr10884033a91.26.1752375206071;
        Sat, 12 Jul 2025 19:53:26 -0700 (PDT)
Received: from quat-desktop ([2001:569:514a:9100:3f23:7b0f:f6a2:1ebd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4286da3sm76345145ad.34.2025.07.12.19.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 19:53:25 -0700 (PDT)
From: Rhys Lloyd <krakow20@gmail.com>
To: dakr@kernel.org,
	acourbot@nvidia.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Rhys Lloyd <krakow20@gmail.com>
Subject: [PATCH] gpu: nova-core: fix bounds check in PmuLookupTableEntry::new
Date: Sat, 12 Jul 2025 19:51:08 -0700
Message-ID: <20250713025108.9364-2-krakow20@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

data is sliced from 2..6, but the bounds check data.len() < 5
does not satisfy those bounds.

Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")

Signed-off-by: Rhys Lloyd <krakow20@gmail.com>
---
Changes in v2:
- Ensure commit description does not spill into commit message
- Fix author to match SoB
- Add "Fixes:" tag
- Add base commit

---
 drivers/gpu/nova-core/vbios.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 663fc50e8b66..5b5d9f38cbb3 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -901,7 +901,7 @@ struct PmuLookupTableEntry {
 
 impl PmuLookupTableEntry {
     fn new(data: &[u8]) -> Result<Self> {
-        if data.len() < 5 {
+        if data.len() < 6 {
             return Err(EINVAL);
         }
 

base-commit: 215a3f91713383a3c0d2da82d223a608a3c17ac1
-- 
2.50.1


