Return-Path: <linux-kernel+bounces-634453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C14AAB194
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 06:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F95461242
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 04:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66CF33520A;
	Tue,  6 May 2025 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDbAxf5N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50051EB5C9;
	Mon,  5 May 2025 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485519; cv=none; b=a7taW4sTZoPwr+6jlIfldbGIdMS6DFOANgKUNR7fGYfJz9pQDD3Y8ErhZ5HB3LUdqmkEVryGlnrHBbNYSVIY6cci1eGw31fA+CX/+5UqtDSLMr0ITEC1NpkY2XNqT4OOx8R514GoleIIlO1ZFf2M6s8mhum4D3zF2iA8bePrwbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485519; c=relaxed/simple;
	bh=fWvF3AkFFMwjVFkX9yjj0BGbiK9cnNKoLzPlGLrNKlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RU4voykRij+HqyXxZgWkVUzp532+5VJ/xzornLgF0sZZC6NQoUx+y6+v8VuyeJYgOJNwpZR5r8eGLYJ+l36BugtmGvKVfxpnWmSVg7NYbCmlyU+Zkcp3mOA12Og+7TKjxai6KQBxsR1ucasR0mIy3H3Bk+2HM1Kf3PjDy7gabok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDbAxf5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B290C4CEF1;
	Mon,  5 May 2025 22:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485519;
	bh=fWvF3AkFFMwjVFkX9yjj0BGbiK9cnNKoLzPlGLrNKlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDbAxf5NPsuWQ94qDPnrWWGqRG9wqrX4bGAEmvQ4O1HSKfbVn05ufA3zfRslRNdP9
	 zTPgVB39QO8heCHxt/RU2sznUhisU+HSR6khcMoAa7EwG6AXjTZiCtEy3LAeJmGf5v
	 M0bWw2VGLnghePixOPVbLuqInUZjz+nlllcU9IEflEKriigzchruiOVefh7RAhlCah
	 wfN6hm+kFTqTHoxMA+Ssz+fL/b0YJJ6m746r0LhrQQyb77zwRHlt0fJYyOlVcYg+wd
	 eNphkv1wLBUzZf95MQDjCwrYN0XVpgHMRXlLKWG3VEg5+f+5X33i/4cJ07AXNKoTz8
	 chxWs9DuRX79A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 358/486] soundwire: cadence_master: set frame shape and divider based on actual clk freq
Date: Mon,  5 May 2025 18:37:14 -0400
Message-Id: <20250505223922.2682012-358-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit e738d77f78b3ac085dfb51be414e93464abba7ec ]

Frame shape and curr_dr_freq could be updated by sdw_compute_bus_params().
Peripherals will set curr_dr_freq as their frequency. Managers
should do the same. Then update frame shape according to the actual
bus frequency.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Link: https://lore.kernel.org/r/20250205074232.87537-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/cadence_master.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 05652e983539b..6f2b5ec5c87c6 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1341,7 +1341,7 @@ static u32 cdns_set_initial_frame_shape(int n_rows, int n_cols)
 	return val;
 }
 
-static void cdns_init_clock_ctrl(struct sdw_cdns *cdns)
+static int cdns_init_clock_ctrl(struct sdw_cdns *cdns)
 {
 	struct sdw_bus *bus = &cdns->bus;
 	struct sdw_master_prop *prop = &bus->prop;
@@ -1355,14 +1355,25 @@ static void cdns_init_clock_ctrl(struct sdw_cdns *cdns)
 		prop->default_row,
 		prop->default_col);
 
+	if (!prop->default_frame_rate || !prop->default_row) {
+		dev_err(cdns->dev, "Default frame_rate %d or row %d is invalid\n",
+			prop->default_frame_rate, prop->default_row);
+		return -EINVAL;
+	}
+
 	/* Set clock divider */
-	divider	= (prop->mclk_freq / prop->max_clk_freq) - 1;
+	divider	= (prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR /
+		bus->params.curr_dr_freq) - 1;
 
 	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL0,
 		     CDNS_MCP_CLK_MCLKD_MASK, divider);
 	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL1,
 		     CDNS_MCP_CLK_MCLKD_MASK, divider);
 
+	/* Set frame shape base on the actual bus frequency. */
+	prop->default_col = bus->params.curr_dr_freq /
+			    prop->default_frame_rate / prop->default_row;
+
 	/*
 	 * Frame shape changes after initialization have to be done
 	 * with the bank switch mechanism
@@ -1375,6 +1386,8 @@ static void cdns_init_clock_ctrl(struct sdw_cdns *cdns)
 	ssp_interval = prop->default_frame_rate / SDW_CADENCE_GSYNC_HZ;
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, ssp_interval);
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL1, ssp_interval);
+
+	return 0;
 }
 
 /**
@@ -1383,9 +1396,12 @@ static void cdns_init_clock_ctrl(struct sdw_cdns *cdns)
  */
 int sdw_cdns_init(struct sdw_cdns *cdns)
 {
+	int ret;
 	u32 val;
 
-	cdns_init_clock_ctrl(cdns);
+	ret = cdns_init_clock_ctrl(cdns);
+	if (ret)
+		return ret;
 
 	sdw_cdns_check_self_clearing_bits(cdns, __func__, false, 0);
 
-- 
2.39.5


