Return-Path: <linux-kernel+bounces-899913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C0FC591F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E09C547F30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A6534DCFC;
	Thu, 13 Nov 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="j15HEIuG"
Received: from sonic313-46.consmr.mail.gq1.yahoo.com (sonic313-46.consmr.mail.gq1.yahoo.com [98.137.65.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ADB2DF144
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052833; cv=none; b=LHpOIgfIKXRb8Rt7/GjzMUS8gh6MaP4UAILqIrrYXag+YvbNTaXqGMT3Dxmn/fqqYNvgvwPJy8PnMPL1Bleo0y6Ror9OLMfQa2zp0gWGAxxScSP7Ajn8jPeVJ0e+nvVfIHNw85zU1q6JLODbiGtDDHW0PV6jVi5hWU7nkEP2uc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052833; c=relaxed/simple;
	bh=huXAja2/nK2KKuiVMi2X13I23xiBFBpXp2FE3Dk4S1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM6FcognxHD3tyIrlIOYVLKrT83hK5hjzdjFym9kDpwOs4skQREQDXvzpWp13IaS5zm8YWr5BoAOSthBN/v9HQnFHQ977Gbaq7RH2YCsaTt+dUI5h5lJvgeAt3dxdjf6D2/COGVEr+TwDSZIwyzEI9h0mjCzTxs2bYPNtV/9EB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=j15HEIuG; arc=none smtp.client-ip=98.137.65.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763052831; bh=KPQtdqUtdI2+c/x95jhpyfFzRSF7GI1H73ITWz7wo5I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=j15HEIuG7yr989vGUMMcrVTHf2ADiWJKntBb7B+aCEwkkNTW2Y5U1IJ+okhNQb8oUL5/zYBREc0y6pXgmABMgkCGWCae9GDYUP8sshMU5ijjPcf1Bja71H1VS/PPWZRLUcIpexaheUdSlzPqexo4FAcDSwE/f9G85bIAip4VI0rnMdVRusL1tEZ9V9NK0buImIFtIBTHaHLBcHtSlSnPqgJm3XoIue78XGtr67L1OvhEjcVTX8DrwQze0tucoNjgvq3nDmGibWBUnX2dfVygKRUZj5IJa87rg7nFf7FcxkwNzhgY9w9QF5ojbu9r5tXw4E6Qsoywej6vdmqKALw52w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763052831; bh=4RwQGurVb81yamJwBco+mDKaNKN/GNNaMmE1nS+DnDw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=cQvtYTXBP/UfiMkTEzskXYHWHHf6TWlWeJmnPfg8vRwfVj3RDG2tD0i5tk0sIBwHWf20sHMbCmTLKkzqgjt9KHw2fZAuAZcTxA5lTBJo9UY5UXZFUr4fmxkGP42cCe6+tu3fqzS9iZFsvkdnTZYauUXRVMCJqxjFn1opuW68Hkqh0hjayvm3/lwbzq4bdb773WFpOBhT0HODN3CWy3Jz61Fc41y/7k+2xc6qmNe/beVv3PcrkyJSv/gHVwjThj1nuMtf4GpgbHQ8wCUv4WXVnKhesT6OjHVZrtWXOtJ33fZEjuf+DynKnZs8F7/cWu3m3nsTw37Bm3dfZpd8UuJ9iQ==
X-YMail-OSG: gTN6gf8VM1kMly0kKe.nTo7UHDusUK4tzPC.B5cWNtLkSGsJvsdALtVHcATPf2q
 LH1gMN9y.nPMmr8K_RyCMHx8URvRdpocnaZZml0ucERWfiXgCwutUZ1RNHCqEuAeA5VHc4zravZu
 Yjf8zWPimqrDgLIfO3QMDKmkxMNZnn_7r_5sUfsKYA6CoBQv.SiT_RA_3.105GQFABMdickcY1C7
 BV400zFLj71sUIgf.tiQBxl_9mvrV4xQtg0sLs0ymo6Ic0_NU23dm9f2TBviY9ZANNMJ_2A4fcBv
 wNxlHzbNKExDs5W8XObfqPCVQzG61YUmEFBiWq8Wrjwr2Syti6jRGYC2J_c1LQoBRqu0Zfos9dLE
 jBcYWOrUU9HBEoYruR2nD3y5GtIFAMXWkpNS64r4xsw0QCd3NHXqGlpEnXP9Cb5KWV0ir37Qgcbf
 HSfKkKsKyFamxuCTsEoTODcZyM38oMHCED6ugb.KTLmORXUjTaCxuO_aKiUvGTR_zLzD4Lr8vFma
 bGxsNfJ21a82iy4IlWDcu5mZz6k3RZMf1BD9ACJ8EHPcmbZtaN5AhdB09acH07WE1uo67dhXmzzJ
 8r0TGCra.FJo0APZ6Boa8EqFgBqnZB1SxjhrA4RYavaUpj9C1YB3tzoW51MVbkpTKUAtCjweqtJB
 06IRcCY_McTfyEVIGZVbSwz489KsjwUAB.NC029PSvAhIZCFne.adNjEvf37hktIBHiNv6XZTbdj
 NrnXMAp1kLgDzsqXkHe8VwGEHLNGYpLX8LNrc53X2CSHVNit22WjEGTwFEO37UcXl0mo5TqiXbFQ
 TdQiLSHmnwE23A5q1VzxGLkQ7kXH9AkFZPeswQuOM5xsyyo4MJTvkvCfByldgbKfFb4WatgZysRf
 cemF2VQhxr2sMrxVL6exxOm0fvuL3EGdFoIcNTDfv6bHlcHZB._d4XBPRa_WY316_zaJJZM66v2Y
 I4PsBGVLJkb7Miqy7eKnYYMkIdZ_hNRyrs8cBa0N3RLeho.3nolVyk_C7eR9GKn04bB74hk16zyd
 iOjXi1TJtvb1S1uq.fIKOvickU1HbYG8ss9aFrFNGQPW4EK_5W1mAXgYXtOFJjKAhXMFRo_30una
 C_xbDbxxGQl5Sx2KR3yehfrfkbo_r832vkBksblWk6kR70VsTlcVbaJP89nKcOITEhXERO2lF.UF
 YcLAxBarZ2R6acB4_5fKtCVtopCmHzb8aP3RIkwoiObF_NDNRLSiBWFJzeanXZqNstBHNxkw2_jM
 xU_zlmkJc5EGtRN6ZHJnTY8KsByuiBVeaxlzn24WvlionYxxIpPHOzvPmLDHdZSHW1xmq24fCkbb
 gVEphgBdjpyIA67V58o1qY_XcZplROlQe6CyzwKVLXYenxInPFxc3BU99E6zbyML0BrnODwdcJKC
 ULbIQtEeIwOw15vws4B.4NOkMUjaT8PvDlSR4AHFqSx.143IhgY9prtUSCpZjjgGNf9GldOESmFL
 cbXa9yThSafGo2MH_LFF6IuCJUNnjHadIXodvTnE0TidzCFe9XmNSw1GRgv1DNGl6rJuX3pqau2o
 dB5xAbiD2zYWkX9QsVRzkkx2WLNuCXmZFEn.BK_RquJb0GitjpeLnhG5kA9OKPOD_z.rLx8EKOiv
 c9y6ju3m.MsVSxcEaTQVK0cinG7UARc9FFECTiYgGlIaZ_UlgH7HWplBsuHD2xHkAnB3eCNFK8TC
 DX1FhpXPnaVChSdl0U47kqFDwvTgzrZsA90974uVObWHCKZhSagnJ9owmdz1t5Lt_KWiRPY1v.I1
 u2LJFFlhln8jrTln2EF8xZiByWC7mVWdNyi6SIz4qxDCchOFj.slQwPRJ.db7doXyDN4UKArAuTp
 GfF3xpQOEk_s4XrQaXZAVr_J9TY.mROYP2xR4y4KTt3LsgBwIuKw22rbGLEMKvfQT2nEO.ABKlg3
 jzWnQRfMSCnZwuAjH5ZpaGLL00.q.wHS2OYznNczdgCLR31p2e29bALTrFL8L02D1dqyhbLdsUF8
 rcKrdUtwDFvgT3A6uuf7mSCwwLMA3cDRGzgst._8fNMgjPNZdAx5tIIFFEWOFLlO_NmIEbTaV4Q0
 a2zCG7BUQtzui.Ryl4mlby35.M9oRxWezhQu9BBtzoCwXHN8ZPXN5Ap66_giy9McXFDPLHFewbXu
 FHuGJqJtqXe_nri905.uqoXRlu7r.wzsEUnDa_GT7oUZUhwWbpGc5IP7zSQCW.9t8uE_vLPBoY.6
 M2OL1d5LcKwJX8yNhxGzcMxShdK4nvf.rcAFbr1zz1re93ADdHuTQbwzpf2SCENMesSSGFtGzvdc
 ObCqt_6N1vZ8sniEd45_AHmWY7gjRRJRCLnFQ0.pwm.z399sR7FjqZdXh.ZGz1wbHt9TExYaarJZ
 qtMuK7J7vLkvicw--
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 7494d730-9641-4434-9722-cb7cf5f27c68
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Thu, 13 Nov 2025 16:53:51 +0000
Received: by hermes--production-bf1-58477f5468-5j87s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 06e38092b890c9492e3ff8e544d7550f;
          Thu, 13 Nov 2025 16:41:42 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: haren@us.ibm.com
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH 2/2] lib/842: Fix kernel-doc warnings for sw842_decompress()
Date: Thu, 13 Nov 2025 17:40:19 +0100
Message-ID: <20251113164019.48840-2-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113164019.48840-1-adelodunolaoluwa@yahoo.com>
References: <20251113164019.48840-1-adelodunolaoluwa@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following warnings were reported:
  Warning: lib/842/842_decompress.c:278 function parameter ]
           'in' not described
  Warning: lib/842/842_decompress.c:278 function parameter
           'ilen' not described
  Warning: lib/842/842_decompress.c:278 function parameter
           'out' not described
  Warning: lib/842/842_decompress.c:278 function parameter
           'olen' not described

Fix kernel-doc warnings in sw842_decompress() caused by missing short
description and undocumented parameters.

Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
 lib/842/842_decompress.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/842/842_decompress.c b/lib/842/842_decompress.c
index 582085ef8b49..465e2dda6a25 100644
--- a/lib/842/842_decompress.c
+++ b/lib/842/842_decompress.c
@@ -260,10 +260,13 @@ static int do_op(struct sw842_param *p, u8 o)
 }
 
 /**
- * sw842_decompress
+ * sw842_decompress -  Decompress the 842-compressed buffer
  *
- * Decompress the 842-compressed buffer of length @ilen at @in
- * to the output buffer @out, using no more than @olen bytes.
+ * @in: Pointer to the input buffer containing 842-compressed data.
+ * @ilen: Length (in bytes) of the input buffer.
+ * @out: Pointer to the output buffer where decompressed data will be
+ *       written.
+ * @olen: Pointer to a variable holding the maximum output length.
  *
  * The compressed buffer must be only a single 842-compressed buffer,
  * with the standard format described in the comments in 842.h
-- 
2.43.0


