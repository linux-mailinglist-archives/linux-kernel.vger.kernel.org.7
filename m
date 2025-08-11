Return-Path: <linux-kernel+bounces-762829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7C9B20B36
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619C916C9C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4928F1A314B;
	Mon, 11 Aug 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="OHQt4NpI"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56231F91F6;
	Mon, 11 Aug 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921105; cv=none; b=I0U6GwBttGX4ZE1G93KSi8qvFDJeOl8sELxdw80LNiTvK6tmsF0AJDbUto3XN5xctSolAxZ7g6mc2VFy0o/nabIF7X6vqcihWqf1fucKJUlGp9uv0ikYFN8QgeHDP4Ggpxm1u9AzpnO8H5umEADmELGRaJmjuUKVy0D7BmcEmg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921105; c=relaxed/simple;
	bh=z70+6t8zQfe6gg2EzvLCmWTmpQzeFdqDzTO3JnB6imA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N10CzYvGWYyJsehCTMyCNHwr6eBmXWtFzl0P3b48rkSfv+hLZENe4wRuHtVOnhaZbI3DhK7OHHkO91PuVUzPCMV9l0nSKzWBlM/RPAvzx6p5frjYYAFGX8F5ph4m0uLzYEsJJfUuKC9aEmYIXNpvHAp4pCbNzTYiDZTaLyCAZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=OHQt4NpI; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754921084;
	bh=OTPCPLnwbS9eTCXGHSG2KsfDknKo86Vz6KTpbMSyVrw=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=OHQt4NpIbigM6isG7g/EGWBPkDVHIK9I5rTt+ZELcVC2oxC4jbPrgsiywWqI/nviL
	 vtzV9i7E71JNMobqo5prchuJwvagLOBMJUEn9gs3NJEiLJZPCIq/HaO9q+rpHvbeLX
	 nkI+nUFbf9f7DEx4LUHbRWojheqhrYicW0Y6TxVs=
X-QQ-mid: zesmtpip2t1754921083t53edfe55
X-QQ-Originating-IP: H70G/aROUpW0T5k2Dez7TdHMWBIax7uH7QdV5lc7now=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Aug 2025 22:04:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12609989171803677751
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 11 Aug 2025 22:04:28 +0800
Subject: [PATCH v2 2/4] clk: spacemit: introduce pre-div for ddn clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-k1-clk-i2s-generation-v2-2-e4d3ec268b7a@linux.spacemit.com>
References: <20250811-k1-clk-i2s-generation-v2-0-e4d3ec268b7a@linux.spacemit.com>
In-Reply-To: <20250811-k1-clk-i2s-generation-v2-0-e4d3ec268b7a@linux.spacemit.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jinmei Wei <weijinmei@linux.spacemit.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754921074; l=3244;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=z70+6t8zQfe6gg2EzvLCmWTmpQzeFdqDzTO3JnB6imA=;
 b=bYG/SvgS92wz4cP7uwrGWGWSfpZjCqtZoRlm9epxOT09HCebNp/gKHhdGXQcKNs9/1iJG9avD
 TIZ3sKcEehtDcYqfqNcfe8NrTca1918tLYJuwlkfZqeavdrl7FaSPOi
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Oe+QC9UX0c6WCBuE2VZ3TW5aB5Fcz8S2xE+klfVAIUX8pG6eM3s8mDXz
	7L7LQvcQTXEZM6khcRQ16xyWWNPcKO33WqZ7LwRG1EFVsB/QJ8kUNgTJsHeJeEjIGgu6Frf
	bGIId377clfB/FgrmkIM2jAohraiuSy/3GBNd5bX+iXwncVdrQvHjHfYJrRRLUrjppig0+s
	f+YPksgFtip8yWEA3vKTqN+9JCW+bTLOj55I4ICmwzhvJCDQjDRHc/y4ZU+tklCDHEaOcTn
	K8EN41kdIq+BMMRTGCqc5zK2UGds9515GvBcvl/XDYhEQqHlk4hzv8hDT3UucmwsDAkIVVO
	/5qsk6MLiDZcg6Z/0rP6PLIO+xXA8qkhyW+vjhckc9zDyDi0vyo+YRRCdvoWPbso1udnjJA
	3rjQayyuYIOuSJL5OCys6vi1fn8gxSx+U4h3SgSxTq9fR3OWjP8ZIt6fPRAqkioaqt7WGsk
	OpsTPBL0ff8q0/0IsuBXAy+kvst3GoYm5dKwwFjKc8VDMNSuNZ/7eNLZTVoCI7U1oHU2YOz
	IPAPGf1296x4FVrxkuNKhevgh5WC8ny+Hj7YOQhEJZZeFjavfBtt64R2P3ts41U3HA+GmO5
	/vWxZj+QLDssTyOaadHTtZCrML57heh0H1jmurl9jAbhho/cwU9j2ucYutHOoe7IkuZG+t5
	W9bK8aguDf/9DEZiN5t91bbANRXij5t3iwzhXfSlSPWsD5+kWW/hz5AHxkyC+tCiPPIyyll
	CZeyofBkWwinEzIA0VUtKA+eDK/aES+n2T/nznx6jB8AUiSVPHQ/cPj4WZfyya47lWmAQxD
	aCHxncsbjidKbCyMhyJBJCT+hUVhyNydl9JY8OiTWKpX9AQ+1OJuq2NzL+IDFuxfURH+8wK
	CbGHPdL5k58Yu5PS4fwfxpb3RNsIB5aGitvPK6rchkvD80KQlEHq4qPLlTwcGAvt2OzVRR4
	Qo7YfB6NKUYraJTVUxFN1fuLdxltdKFi0KXT/CAVzbXjxcOIQFuAE3n3IccrqMiiAaaPGFN
	PYE92vmwAnujAJS36sJdWaOHtzt9D9q/CE+ngj3p8s1zFlnn7x/bWHuDb6I6ahiUP6UCTVL
	ua4Fm8xn3GJw1T1VegOkaIKFzshO9enWuOsLEzrzeZAEBGg3xjPI6E=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

The original DDN operations applied an implicit divide-by-2, which should
not be a default behavior.

This patch removes that assumption, letting each clock define its
actual behavior explicitly.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 drivers/clk/spacemit/ccu_ddn.c | 12 ++++++------
 drivers/clk/spacemit/ccu_ddn.h |  6 ++++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/spacemit/ccu_ddn.c b/drivers/clk/spacemit/ccu_ddn.c
index be311b045698e95a688a35858a8ac1bcfbffd2c7..06d86748182bd1959cdab5c18d0a882ee25dcade 100644
--- a/drivers/clk/spacemit/ccu_ddn.c
+++ b/drivers/clk/spacemit/ccu_ddn.c
@@ -22,21 +22,21 @@
 
 #include "ccu_ddn.h"
 
-static unsigned long ccu_ddn_calc_rate(unsigned long prate,
-				       unsigned long num, unsigned long den)
+static unsigned long ccu_ddn_calc_rate(unsigned long prate, unsigned long num,
+				       unsigned long den, unsigned int pre_div)
 {
-	return prate * den / 2 / num;
+	return prate * den / pre_div / num;
 }
 
 static unsigned long ccu_ddn_calc_best_rate(struct ccu_ddn *ddn,
 					    unsigned long rate, unsigned long prate,
 					    unsigned long *num, unsigned long *den)
 {
-	rational_best_approximation(rate, prate / 2,
+	rational_best_approximation(rate, prate / ddn->pre_div,
 				    ddn->den_mask >> ddn->den_shift,
 				    ddn->num_mask >> ddn->num_shift,
 				    den, num);
-	return ccu_ddn_calc_rate(prate, *num, *den);
+	return ccu_ddn_calc_rate(prate, *num, *den, ddn->pre_div);
 }
 
 static long ccu_ddn_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -58,7 +58,7 @@ static unsigned long ccu_ddn_recalc_rate(struct clk_hw *hw, unsigned long prate)
 	num = (val & ddn->num_mask) >> ddn->num_shift;
 	den = (val & ddn->den_mask) >> ddn->den_shift;
 
-	return ccu_ddn_calc_rate(prate, num, den);
+	return ccu_ddn_calc_rate(prate, num, den, ddn->pre_div);
 }
 
 static int ccu_ddn_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/spacemit/ccu_ddn.h b/drivers/clk/spacemit/ccu_ddn.h
index a52fabe77d62eba16426867a9c13481e72f025c0..4838414a8e8dc04af49d3b8d39280efedbd75616 100644
--- a/drivers/clk/spacemit/ccu_ddn.h
+++ b/drivers/clk/spacemit/ccu_ddn.h
@@ -18,13 +18,14 @@ struct ccu_ddn {
 	unsigned int num_shift;
 	unsigned int den_mask;
 	unsigned int den_shift;
+	unsigned int pre_div;
 };
 
 #define CCU_DDN_INIT(_name, _parent, _flags) \
 	CLK_HW_INIT_HW(#_name, &_parent.common.hw, &spacemit_ccu_ddn_ops, _flags)
 
 #define CCU_DDN_DEFINE(_name, _parent, _reg_ctrl, _num_shift, _num_width,	\
-		       _den_shift, _den_width, _flags)				\
+		       _den_shift, _den_width, _pre_div, _flags)		\
 static struct ccu_ddn _name = {							\
 	.common = {								\
 		.reg_ctrl	= _reg_ctrl,					\
@@ -33,7 +34,8 @@ static struct ccu_ddn _name = {							\
 	.num_mask	= GENMASK(_num_shift + _num_width - 1, _num_shift),	\
 	.num_shift	= _num_shift,						\
 	.den_mask	= GENMASK(_den_shift + _den_width - 1, _den_shift),	\
-	.den_shift	= _den_shift,					\
+	.den_shift	= _den_shift,						\
+	.pre_div	= _pre_div,						\
 }
 
 static inline struct ccu_ddn *hw_to_ccu_ddn(struct clk_hw *hw)

-- 
2.50.1


