Return-Path: <linux-kernel+bounces-656837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B0ABEB69
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 07:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E547A3965
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 05:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2A2230981;
	Wed, 21 May 2025 05:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VXMB3zEI"
Received: from sonic314-21.consmr.mail.sg3.yahoo.com (sonic314-21.consmr.mail.sg3.yahoo.com [106.10.240.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F31A9B23
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 05:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.240.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747806228; cv=none; b=AV6arKLTWmxu2+Al/dJiogjfD0OHpF3Ea5QGtocwvarAngYzPNIStmPjIK9R+Ta5Wlw6keXi0uZas/VYpexeVCnEYVHZcTb8ARaRCwnLb4n37LJArUxe1pIVlzVMDY5Vk3FnEEgAPcwYyXJd5v1p5oXu7WBMrJVB+yHfJVkjjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747806228; c=relaxed/simple;
	bh=hlNI3m4WG/MlpI1xk52yYu+AhqXOd7Uzdbb2Zi9rfEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=O1kwHsunbm4b+mx19CE5wl3pBnf+fxX9+NbnHZklhA0XzURvV9l2LW1tchQ/fQcL9ZnoDb8AjLmQU2i7dTtC/+28t+HaxZl/J9i43Fy6hxtDBY1NU4mbtLJKw8yTveJPcjmXnnfroTlNp6tl7RRGYpQQMBxKhhIzIvm0RlqLHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VXMB3zEI; arc=none smtp.client-ip=106.10.240.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747806218; bh=S/9bzua98W0ZPTSxA6M4c7Gw98gk98XoFj7668MMUpQ=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=VXMB3zEIMIiz9frw9Mye5EXhQzsYEL3nlwYQuFP67pZFyf4UC43q9YtxWlSwU8UFjoq3YKOzNrDYar0Aia8Gjw4BFRWoElAbMIXqNU1L0CGVh9Rtu5JXL2HXwuEeEDz5qf12MMT+pyU61MKGa37jGvaGeg5MEd8FW4lHekfviKUYs7MyXeKDa91+tb5HUTHqwJup1VbrHJ9qz5DuL7yZFt7roqaiaw54PoPp+74swBvooWejj5LFnSvFel0d5E+q8eWTaX9xnUw2ZZKM2KAdowvnqTjxAcTimOdIzlhlHAnzaPPLdP1f/oT/ZjujgD2GB1CA1f6ITkWkBLj1pPIPvw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747806218; bh=9zSb0Rm+fDZ+dKI9N5d3qAKGccxG0jWdD9EB2uBgPzt=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LFrlhjIbA7keG8GROvNQlMMsN8WS44Wdpl0pqSlHt2MTRyFsyXagMt3qmFQt3yDwhUf8QYC3VLX3vzLusu7J6TT1DJbpg1J37JTC3BnjN0C4QjBVgOenrfX3mKClmw+PoozfxrjO/ctBPB3X2zI/1bBKAjne/P7g2lpNMJn11H3IZYr2E2aMVWsRgKhqfUYNp8bFkDTUJjLkcigrjwpp2Qc4ncnQ6umlYzSRIYakWF6Uaa8+f6/yn4RSYqjPoXWx7wk6WvviwiKAn2lfr8J/TvIoABl/kgFZXqdNISeNmI6jLSp/Mw9EkuedJOGI0+NTHi/QzoArU+WclTOGcAWF/g==
X-YMail-OSG: A1v7uHAVM1moqNmZoGzV4CWMKtFAcHVVWC_yNO4yv_UYsNCXKpUmzaqqT2foRAu
 7gzMvIOSmRvzv4g5qV0kpC5IkP7dT8.JkGbFV1533rPcHFTUXwg1V2yJi6pUB_uvT.q5cASRR_eT
 9cR806Oou2w7yMTSiQs7FtjgQuelyNPiGNrIshuzLP.8TTMG0JLTKPKu71PLRNPZQkqKqIhG04pa
 SWMak.RB4X2gzyn.rf_1xO8tkM9ekfgi.Pm1i7OoBeSRdj8X4AHLCHAEkFQuZtLX2bIYHC_GdKit
 rmBx2Z03duYF60CpLFWRcBm0i8V29UuaWZ8EQA3GS198KsEVPGjfj.ags2S30as38afwc1EJnbUn
 qMUaYkPWLuOn9CqLmA.yLUKg_KbDllHgTydNCADU4R.tVf57Pr3zKmL1M7iJKoqSIosV0UmRAfpd
 v6rylxJrpDp8_VJkrw4DDcz.KHlMK.7EiBNTCRrzmtVZ8PPo54dFOesRR.h2LP4iDqtjhQ9m_mau
 c2dHS8hYkt0i5P0lEiF3Hk7c_toXbvGrmFJ9gn7NOndWrMuoMTBxC6vifiR0tiQObzf1xGyyVnae
 wbL7hUpgKHiBAN1fR7uf7RXcUKVXMtwnlHv2jS85Az_8kAzjcqM5gwz1262riWCXL0PTD6bFfdoF
 Y3RGGN_8xjPXX8SlOCyCiDv68bjVZ5MQA3tAx6O5KvTn8Kk0sjf_JdlIKYqM.HftivdqMVR696Ej
 agkTRXpS_szS5OUhSe45XeVzebnyJrTnglRKxhBu4zGQzgzCrGNx9t1L7ajmpfZAFOOU1q4dh3ek
 EbbreAzJB0jhDPUu_gp5YTpV0SldSM4SZnYFQDMiPvpRd5zIuqHJKf.8PdHh4DQILkdGJOlbJ9Ot
 ry7XzMEiG1EB_RCJKhAw6zunEZpFxVimd8UCs3uN9jl_AwrvIcaPDbeis85XD1Ibq_mESsNZR0bc
 T._YwVzz8vMh0H9S.vMjXkVfLzXKtD6Yu6kaJ0r_bSThR6LGkN48tAzmnckDvCfO4kyxs92nq1fN
 ORC3p.GJDXGOM5S0WVXGqNG864rx.YI1tCJA_kwPguiSWq1_EU.ZrhPmkRycTDhCW8l6zfdI1x29
 M0n0Y1j1SDDb_dQULYsWapW3FeKoA2FSDJSYbosww4Hj2BeAjRHZ.I64viBapxSZKQ4CuWVxPmh7
 sb1GFJls5pFnJVPljv6Nngce0alOtY4dQ.mDVEr0aSboxoMLGpFaOJRjz1_s_gIh_1R6LQYv5d_8
 .WKiGjPV.zyC.2VfvF9xbPMjNCiaYUVB95539WoHZo8pRcecGthtoeCjTV5H_vDgw8DO9ujWNuE2
 r2bV18dmmgYpVAwixIAqa8y1rdA_v2ym5Mh6lIx2qWMpZJaaxxd7HNOubl3p4vubTMW8B4iOwRYk
 DH4rd470khT6n5z.LOl_zGb4_WuBdrXQ6NNyAcDBInKHraHQ3RlwP9cJW_bhcaaVZIdlPjmVuUya
 v6j0v3DvkTVOEN1AUZuNO0An_TnwODpfDdpu3qFwrTYpMdBJ1rQn5zgXhzEZ.nn4P3dn6Pn5lx2c
 KwiKbYmp_xPlMb.GvyjB4osLID50R_JPQxEJDVWWmb8XLPScPza_KGDGOUpG4MfFExy6firVt2dh
 90Oyu5Hz6F3SgY_QcuqHU9Vw0oUS8BHHUv049HG_qXBJrSpRSVB6cfw4pZgSF0lYpJBygyOp.2gf
 nkDprAWyjMFBzsq.3Pw.y7JtkLHxMPjam.n5rF4ScZj3r1lD7JQMewxmxQcgQ9xgUUxMFxEbJbKp
 PpGqTXzJ57W7Qgapx8kOFffX0kSgrVnKseL8K8nb2GPrPVA0lKJ8kQdW4.RBfU66pL2pCKqFdflY
 P7ClsWLc3o403iHAmjbEKBez2xgLuiOQ6saVw9rEBZnDUdWUXFY6RUJw3BmSqK4.uR_UPQka1c29
 L3zHPRhsRyvng3DsM3WMAnLo9K2hoEI5UWtav.cARlrh0h2Ytn9TKHf9BQqqWvyLS2hZCWao6v6I
 Tg9gI_LSWq7xV_OIhwx6OQLE1_vIlJbIqfuzf8t5MBdOQ0Y0.qxkkIgvKt3z7c9XN4ezE6pcAbRn
 FHs.IQ0GajwV18nhYP0fZIfqXw5p1qK2cxzJ5KCqMNSUlxiyPrxhSDITKBq3qK_fkbv0sGJrjNJr
 J8fjRj43bKnHruW4PJzNQPJK2w60Alkz24K7AniECjcQUJu49yZ493YEX30FJD.F1A6MehLIlYOP
 zEJF8E4orLcvOq_315VXPrZWglS0ARrcp.8lPMMO_zyoGlJFeKAf81VGwnH4DFJLsO9_DFf8D.3m
 anuTDVkCRNWq_wuH4PzQIMDSIlvht_BtcPwISCKB2.Q--
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 405d001a-5678-4405-96ab-7f6466e42883
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.sg3.yahoo.com with HTTP; Wed, 21 May 2025 05:43:38 +0000
Received: by hermes--production-gq1-74d64bb7d7-s6s6l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa4de8c44664aa8fb2260df0a5c9ab6a;
          Wed, 21 May 2025 05:33:26 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: tglx@linutronix.de,
	mingo@kernel.org,
	sumanth.gavini@yahoo.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: wil6210: wmi: Fix spellings reported by codespell
Date: Tue, 20 May 2025 22:33:21 -0700
Message-ID: <20250521053323.284845-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250521053323.284845-1-sumanth.gavini.ref@yahoo.com>

Fix "busses" to "buses"
Fix "Measurments" to "Measurements"

Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 2 +-
 drivers/net/wireless/ath/wil6210/wmi.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 74edd007cd8d..6d376f85fbde 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -53,7 +53,7 @@ MODULE_PARM_DESC(led_id,
  *
  * There are several buses present on the WIL6210 card.
  * Same memory areas are visible at different address on
- * the different busses. There are 3 main bus masters:
+ * the different buses. There are 3 main bus masters:
  *  - MAC CPU (ucode)
  *  - User CPU (firmware)
  *  - AHB (host)
diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
index 38f64524019e..a6761a1e9d7d 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.h
+++ b/drivers/net/wireless/ath/wil6210/wmi.h
@@ -3495,7 +3495,7 @@ struct wmi_aoa_meas_event {
 	u8 channel;
 	/* enum wmi_aoa_meas_type */
 	u8 aoa_meas_type;
-	/* Measurments are from RFs, defined by the mask */
+	/* Measurements are from RFs, defined by the mask */
 	__le32 meas_rf_mask;
 	/* enum wmi_aoa_meas_status */
 	u8 meas_status;
@@ -3634,7 +3634,7 @@ struct wmi_tof_ftm_per_dest_res_event {
 	__le32 tsf_sync;
 	/* actual received ftm per burst */
 	u8 actual_ftm_per_burst;
-	/* Measurments are from RFs, defined by the mask */
+	/* Measurements are from RFs, defined by the mask */
 	__le32 meas_rf_mask;
 	u8 reserved0[3];
 	struct wmi_responder_ftm_res responder_ftm_res[];
-- 
2.43.0


