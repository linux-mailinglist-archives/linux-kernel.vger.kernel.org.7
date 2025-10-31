Return-Path: <linux-kernel+bounces-880287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1D9C25586
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C502F464CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790CB34B66D;
	Fri, 31 Oct 2025 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPKQ/sk/"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B6334A3CF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918559; cv=none; b=BOgVI+rNum0bj/plGCXvvvZJMrg9CJ2E0LBnHhfhLAFH5qdpveSM0m2GCjPpzsFS8KGd2jRyH/4AyQyUbfb5SIS2mLAnVLOPx90yT2OnEsQAK5RVqm8K/6t4H87X+6ST3WDzC9kLsCFDhprswBwRb1rra55sagc0BKMeCiar2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918559; c=relaxed/simple;
	bh=QUnsDuWKLCpT6qFwsNJkL5H60TzXRS9KLIMiUwqkVK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bdb30nXih5QWmFa4/FuyWrDORxoyDW5Zd63mJ71tjb22+jvvGKuRp+cTgvt0ufN3vRb2hs7EOYbcgF3Fi3XsV9916CCk7dgQMJdDZMeTKPJMd1zuP8uygbciBGQMPTnKe5w1Sbqfp/caBUNwBWrMT//3COqV69/zSrJirv7ODJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RPKQ/sk/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6dc4bba386so40543566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761918554; x=1762523354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o3u8UJxL7hbAI0py1rq0T8SxfElVkW8XQp+cNXon94o=;
        b=RPKQ/sk/11SpDPGhGASvGzn0BXIVHcKQcJOYzsCX4lik5CkDxMzyx95wV5y5MFt5+C
         2r3jHMB+Mdf4tdEA+If/isazXoD0N2xTYRsDxEwCnnIYQIvKdcXh89tZkSSoNtN3oTVn
         Kfr9+qpSZGY1hq7mvfyLSc51fhJ+QuICVjUgVZ5vsc7XszRERa2mklKx0L20drPBBM3M
         rHSlrYVwN8Lzsgt4RswBziTKtVyRO1mnGvMft1OLHPF07aUk5GOwB5F++Yj4ccUxJZXQ
         R/fu4RQAabEF5LaRNzoQD/T4vBbDkVPhKaHGMegZ9V+kM2AzEMjisGD1fH5WK/xp96Uw
         c9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761918554; x=1762523354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3u8UJxL7hbAI0py1rq0T8SxfElVkW8XQp+cNXon94o=;
        b=UJYftfxuUgnz1DB2G/BSew3E0THLhmdUHdS2qhbdXfgXTigt0U4YZ9VhmTaLy/e/hW
         f+k2ZI2Y2l0PFujExKzQzpt6AMPukkw5gVCADemVkwEwP37FceRDxNN5ZwHnJT+/ci83
         kemAoxq5sauw3vDoSVOXyrTjJFa5eQ0SLNKwyfwUpilC5VacvzHupwdZkQcSjJLAL5i5
         7KNcEeeR46FfdWkRThck1vZiU7kUYStG776EvoMs+w/06eD9j3lg9E03N0bT8+DyWZka
         J5CbFHzThpyWPg1zFpXMRK8sS/N++BCZzyXVWXfgUGIjDNGplCmrAuMqSSHP6Y8QCwyx
         SURQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs90ztMx/DWjZ/JTo2xMYk4nbO6fNhGSCVP8b8hl1w2tkLZCFhpj0K2DfrBnQRoDyaW7bi+gMehPyog1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcUJML8OMxexfAYIuBrUfQ7Q11pLcrPoZ9Mt7FlsIQSAbuSUoZ
	faODs2+PZdK+Otei+vHII9u9kccOycsFUmzU20GTeYksjJreXaEwUMhPVNKrRJLlEkA=
X-Gm-Gg: ASbGncshQgzX2T5OK7369MLoAWhv8dHtyz5LZHPxbw7t/IE88XS5uTmaFCvDPFYHGXb
	BihtO5oirsYQLpeE8hIhPT66z0JKVlnlpe20KE/p9Z5Jidy2t5Fjqd5m+kBrKska9WVXkBOYn88
	hKzb/RSeg/CHY7aH0/+DnZGW1jCOQv7sT855eQoeclF6oHarZLrhYQEwZShQYAtYAPXO+cZaY/i
	HZbvummQJcB6R7IElpo7/BpHc3jhqagiX9Tx8TXBRtYfSByqWFmraY/2eu/FCyBVuCBHgXUKFeN
	3qx6wbaVCp05iVZBrK1+z0PQLSIMDjaxI8S2+AvM0CTpg8Ci1enqYwGaRatRr2bI2U8v3p9RyKU
	JGjrbJJqRN521UqT2P1w54B+7FbmoxYLpxK2LRySd35f2VuwVLjvX139HvNS1yz+qlhMZrWiAcf
	w+f58GL6kHFxI=
X-Google-Smtp-Source: AGHT+IG0OL8ArPHlD3301rEU8kKZy5QIsDov88Yb4tzvBo6k8wxPmeV+jV10ivubyNsVrg8xH97iKQ==
X-Received: by 2002:a17:907:3e0c:b0:b6d:6d44:d255 with SMTP id a640c23a62f3a-b70700af393mr198476266b.1.1761918554309;
        Fri, 31 Oct 2025 06:49:14 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077cda5e5sm183600266b.61.2025.10.31.06.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:49:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: fixes: dirvers for v6.18
Date: Fri, 31 Oct 2025 14:49:10 +0100
Message-ID: <20251031134910.78436-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=QUnsDuWKLCpT6qFwsNJkL5H60TzXRS9KLIMiUwqkVK8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpBL5WMNsVRWrNbqHB4hSwVTILtueIUeqAdFGBa
 4uOS5ZBmDSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQS+VgAKCRDBN2bmhouD
 13atD/9SFFi/FAgy2mkN5UhtQV2EmHcGQEGzGWg5mTrKf3xXH4WzZPlvqQVq+05pBtQCx53LQs6
 bLk0TIkVaNs1WX5hIqXbqdWK/yMmJavEUeVSLxeXHjf1KTj6SEqFLyNFa7Dw0b2ELQzG97DzyoD
 CUHvKG8iXy7qMPDFhT0jE7+cFitrWCKIiVtV1Y3UrqeVt5SuhmqSmGuCEFP+NjlThU4jv0eY7cr
 S0u4a3KVZEcPaKxuChogazVBHJLPy1Vy94wzL0tho4gIa+zJe62TeDWDslCBy0EfV/skUb9qFum
 vrMO8QIAc1yYnBKMOrucQJLdTSjZR0T0hxHXjRiJYHkB/8YWEzvLFw/ZV4BhKY7PkH+CUl6RlPt
 gFcrwWtBkBXb2v6PkttSDbPnZlkrRDbMi1vX+wn1qZJBS129CJyyZvGrELMpOEIr2abPHqEfZ1w
 xdcx+7HqHrGvjHAYjj+M59UmXy3qQZOtKZCU0WPBFdyI6wpXoxKQfwntqmxfDLQjFQ32ebCqvPv
 Zyxp08YG1yuImb1IL27zla0eOvJhh3ovQ6nM/vxxl18bRGvk7t8yZOeua2Dt1nC7C9TQpK3ZipE
 WawEzzBfc6OrJOjuJA+gDL/oz7X+ECR3OJSk26plSph6c9nPwTlg6MUH4pextDz9+5rmw8LFnUK KzXujlZs+tVSiWQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-fixes-6.18

for you to fetch changes up to 6f37469a933030692741710db809722076f71973:

  memory: tegra210: Fix incorrect client ids (2025-10-23 15:32:21 +0200)

----------------------------------------------------------------
Memory controller drivers - fixes for v6.18

Correct incorrect ID used for the memory controller client IDs in
Tegra210 Memory Controller driver, introduced in v6.18-rc1.

----------------------------------------------------------------
Aaron Kling (1):
      memory: tegra210: Fix incorrect client ids

 drivers/memory/tegra/tegra210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

