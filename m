Return-Path: <linux-kernel+bounces-857319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8229CBE6811
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F7213569E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CFA30DEDA;
	Fri, 17 Oct 2025 05:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF84fDNv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE8256C9F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680517; cv=none; b=Z2Ute4zeWPXdgwA6lOAtuAy1a/SMJknTH/o0rLtgvhe28CzYQC3L+hau5MZdO3ihBCtuyEA68hWj2WNQHYNy4YxgnIkqnpRhISUuxE6syGROzdDt07VMGSbLt3x78isbwRvdZnTgjPK2KcmZ514+zrnXCncKhfW7q/t/5mf9Yl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680517; c=relaxed/simple;
	bh=qdkC8n5UYL12HB+OuzzAqHEJ7yUfLSJb17ftt81iTKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xy35P3pfp9mXs+JFg0Wa52SqhdUt0lA8jNTnEHF1ZFUxXe7C1cmzGjk0D4KOKq9eT8rC7xuLckHD5hsxBcprmokfzWfOOaaJClpUgNxR3NoAL+5zHvRN5S3OmyNVM0g0TvV+SvPXH4RmbXIFeeKat0etD81uirpyMJSgjLYqohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF84fDNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93581C4CEE7;
	Fri, 17 Oct 2025 05:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760680516;
	bh=qdkC8n5UYL12HB+OuzzAqHEJ7yUfLSJb17ftt81iTKo=;
	h=From:To:Cc:Subject:Date:From;
	b=mF84fDNvMXf2PJD66eyeTmp2SWDIg/20bptYDljDFObmc3i0VCktf2xk/99c9AqjP
	 sjK39JGsZiS16xX3ux+euJD93P2Ky9ko0UXYyHere8TFeyPndFjgiRnaVub3XnLGhk
	 +LL2gcqXXsf2hWEdNFYNEr0QJVjH7ueD3egKjJ0hFDaC0GHG5ds98ITSi04ToS3lMi
	 8SFFKEKK8r46xsfQrIf0umUM/5F1UFpIDkI3khidWTIJ/DaKkWSpVv1MtsT10rmmrp
	 bARNE9sJhrg9KGOT+8VEO/sFU9PFQ9nGKUjIdmZGrE7QRTEq8pAzZdMwl4iowKGqOC
	 uJUfACpXCxt9A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v9dQt-0000000022I-10Ag;
	Fri, 17 Oct 2025 07:55:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH] mailbox: th1520: fix clock imbalance on probe failure
Date: Fri, 17 Oct 2025 07:54:14 +0200
Message-ID: <20251017055414.7753-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of the devm_add_action_or_reset() helper is to call the
action function in case adding an action ever fails so drop the clock
disable from the error path to avoid disabling the clocks twice.

Fixes: 5d4d263e1c6b ("mailbox: Introduce support for T-head TH1520 Mailbox driver")
Cc: Michal Wilczynski <m.wilczynski@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mailbox/mailbox-th1520.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/mailbox-th1520.c b/drivers/mailbox/mailbox-th1520.c
index a6b2aa9ae952..626957c2e435 100644
--- a/drivers/mailbox/mailbox-th1520.c
+++ b/drivers/mailbox/mailbox-th1520.c
@@ -435,10 +435,8 @@ static int th1520_mbox_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_add_action_or_reset(dev, th1520_disable_clk, priv);
-	if (ret) {
-		clk_bulk_disable_unprepare(ARRAY_SIZE(priv->clocks), priv->clocks);
+	if (ret)
 		return ret;
-	}
 
 	/*
 	 * The address mappings in the device tree align precisely with those
-- 
2.49.1


