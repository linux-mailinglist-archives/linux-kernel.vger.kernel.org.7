Return-Path: <linux-kernel+bounces-866462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208D4BFFD12
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6458B19C547D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8FC2ED844;
	Thu, 23 Oct 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n80zUjvc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9DB2ECE9E;
	Thu, 23 Oct 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207229; cv=none; b=eyX7hsgiUanqEEHRD1GL4tCwppLQUY6Cc666H3Tjfu86l8DaSu90SOyx7+Y3mvAVCZg9I0cFW1qS547lZKlIUgq2K414RIiLQle6nSsdAhMCKQ0khDKOiMKXbchsAU535bAfh/UWTEOPayoMZ2yKe1TMigxyNTPEQB8MElY6eM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207229; c=relaxed/simple;
	bh=N08iz0FZi/4DAGP0fQITJWM7z8TPyQLOvy0fiJOEgyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hpOIgGgOdYFWs7qiSQqEJGLyEiq3Lp7o+mMBFFFmqNKpOepsDDED/zn9uO4TVqY+gAUS1nD8YzXj1bE8xDhuuCZNNtYvGZFKPNLLfKijhzePVrevvfLe911iJ00m33iVqSQxHIJZ6Bv8ZQz4RJfJj/4Vdg6UIqk5rhMDqNVTP2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n80zUjvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C381FC4CEE7;
	Thu, 23 Oct 2025 08:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761207227;
	bh=N08iz0FZi/4DAGP0fQITJWM7z8TPyQLOvy0fiJOEgyA=;
	h=From:Date:Subject:To:Cc:From;
	b=n80zUjvcwoKLMcYdcTzky8kNe1xtVwtM6xCnVPTZW4pERRNdB49Lo7FoZWiT++APB
	 Am2y1EdwgyC3kiIu//JcYCzabwP54PloI3PQkIMy2bEmBUOu2rV5Hz3t3kZm+zDZO1
	 8cYdLUTRcR6YtlnzWG2bkhkww2DRw0ruBdGRpL7cmO4f9s9Vf8C3G+viMYzT+0GwpM
	 y/ySdDB6tkHMeXvezDNUs81/JEf/TsJVelq1+8eE4vxcQmcM8+qEr/NTQ2gQvdxyoJ
	 QePmwNE5PBHKVLIYtHx97FLxFbHycaJ3p2Y4E0Dj1x9GcK8EaGHMHUx1q0cNH7vY2+
	 RqAlpyGOST/bg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Thu, 23 Oct 2025 10:13:42 +0200
Subject: [PATCH usb-testing] usb: typec: ps883x: Fix missing mutex_unlock()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-topic-ps883x_fixup-v1-1-2afb5b85f09b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALXj+WgC/x2MWwqAIBAAryL7nVDa+yoRIbrV/qRohSDePelzG
 GYSBPSEAWaWwONLgexVoKkY6FNdB3IyhUHUomtqIfltHWnuwjjKuO0UH8f7weih3YVUE0IJncc
 i/umy5vwBHevK12QAAAA=
X-Change-ID: 20251023-topic-ps883x_fixup-67dc74f23a9e
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jack Pham <jack.pham@oss.qualcomm.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761207224; l=1370;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=PLNnwPW6dGdsIaNgt/EJHySYtNZ8LWCH3iXORHHRlCs=;
 b=gFVn2GbDemEFkU6ra1LDVWJ5vQOhN03Ahe6/x7TotlAvkkUQPASB9YRLzZvud3Fc7YCrE6Fqs
 vNqa9V+bmFVDCCCtUVJvYkTn0Lm6JDOrngsyWG5canY0hdl89ehWzBz
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

There's a missing mutex_unlock() in the error-return path inside
ps883x_sw_set(). Simply delete that return since there's another one
3 lines below.

Fixes: f83cb615cb7a ("usb: typec: ps883x: Cache register settings, not Type-C mode")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202510231023.aJ09O6pk-lkp@intel.com/
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/usb/typec/mux/ps883x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index 7c61629b36d6..5f2879749769 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -192,10 +192,8 @@ static int ps883x_sw_set(struct typec_switch_dev *sw,
 		ret = regmap_assign_bits(retimer->regmap, REG_USB_PORT_CONN_STATUS_0,
 					 CONN_STATUS_0_ORIENTATION_REVERSED,
 					 orientation == TYPEC_ORIENTATION_REVERSE);
-		if (ret) {
+		if (ret)
 			dev_err(&retimer->client->dev, "failed to set orientation: %d\n", ret);
-			return ret;
-		}
 	}
 
 	mutex_unlock(&retimer->lock);

---
base-commit: 93741bd104ce07a790519ecee3a331ee7cf61ae3
change-id: 20251023-topic-ps883x_fixup-67dc74f23a9e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


