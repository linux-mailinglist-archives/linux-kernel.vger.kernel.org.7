Return-Path: <linux-kernel+bounces-779906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF3AB2FB01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78881AE6582
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E32341658;
	Thu, 21 Aug 2025 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8EK4EhC"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F6B341645
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783348; cv=none; b=T/yUZYY1nOa4/dtUEwOPnP8tsTDcOi2DVhQb0RFKu4/WQfvxM4PTkzot56QjmqgfDHnkbx6d5OG7bMoPRf6cOklwUG79fXs7l/hJaX4C+mGYy1jEdVGGwkjt07bJNAi2FmafQ/gvHUKmj+i5Xvu8TSOQi2tKoaCUOp71dWiUsL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783348; c=relaxed/simple;
	bh=owKqLM34IVW1rgLdlXtLqa6xJwlyqjIfp5ymF/Aq0/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TCr6fHF8oWFFZaQnmwyWqucsj/+Fbt/6KVYJoRoNfXKV4s/4L+7cPH+HjdYJRmBb67xkZZmVj0gf2W6P3DlYwO5D82CUW0B1RezVxo8+VRx7A5BUJGEYB6NdL0Pz1PTTojn+qUyKOHpSgiQZzFZwqNNDYLxwsI3+9lasvwLzeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V8EK4EhC; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0b46bbso5046195e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755783345; x=1756388145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMPhhSjjqlAw7Lp0TIdRm4Z2BnzotLV7Y4X9p0D9vBc=;
        b=V8EK4EhCcl5CCwHwOxx92S2I9C+YS7/0OhbcT5SBnGOdPdQTuf9M3kMBSShd1W/Iw0
         I+hgAycXCkv2TyA7teTrOfhcaPQY7DnRltVz6JLTTkw6FbJIhSrj2MGzHbaLIgrOJtAJ
         Lwoef5/q1073tPAGMbvx9bitbuPAOw6mnbh7zahZmL4fMZ87nTj7KIUm0dc54+f/6bg/
         SeS03qiUbRgY6B7dg6Yib4VHHEpNa2A5A3VDzGaSevU8rpUtFNtRebbGYneRXkdkUMUS
         bKDMQJIlX2jmvwFJaU5UJZ6S6g1+JQn5FznUYmc9zDaxP/ADAjW5RAEXR7ZtPJKtZPgE
         kwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783345; x=1756388145;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SMPhhSjjqlAw7Lp0TIdRm4Z2BnzotLV7Y4X9p0D9vBc=;
        b=SZd2TgT2Lpjl+OiC5oRxkg32JY5ZvLZtfYmGRkh25fdYK3uSuHr/6qom5+7Trxh3if
         WhBKGGpkniGmHJWwzL13z29S6Tz1ZI44w+wLhW5DMy3gSnoRU/kmllQTm8inaVIEdhDk
         +q2u0dvqTXmghX5uiWWuHxpbmnn6gh94I2fJS8V7p15MNnj7SxLWFNhMYUgbfqVZM3/1
         XGwyssBFcVZfrMnhFdy462A9oho7rLNoVLHIQr2F+VwnlvM5L1fVDFsIiokEOA7QnWtf
         bdHSPdhgFgb8Wa9d6WgfRWsK9xQ6Tuxiy0cHaFIX4SBbhMu6yzZ8384KzlN3akO3q75f
         pvhA==
X-Forwarded-Encrypted: i=1; AJvYcCW3JksKu6Kxz2ewmLWWetrgXva99NP6NDs/W00hSWUrWODj0Iyz9j8EAgaChsy6FCYloqeIZ4sg/ay0kGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSairoL9ODLRhZtrf8xu7ApCJ8+itfaILKWkb/x/c0ZHvt1jHV
	Cdxx+Z69ne3QXrbn9ZhDdnOoqvdGfeIq04dLVmHQHWe15GoEdEzUiQ4foRk5twLwM/HuG1l9BqH
	MF+2rKgh5ZQ==
X-Google-Smtp-Source: AGHT+IHdblbgz3sSTqC3edDmWh8t1eAQ6kV0m4s/tuecO/tPIrd0onjScqdiHPU9FofrI7zG4LFvbnKsOup4
X-Received: from wmnn26-n1.prod.google.com ([2002:a05:600d:15a:10b0:458:c052:cc1a])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4ec6:b0:459:443e:b177
 with SMTP id 5b1f17b1804b1-45b4d84e192mr22375115e9.25.1755783345001; Thu, 21
 Aug 2025 06:35:45 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:35:20 +0000
In-Reply-To: <20250821133521.2665734-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821133521.2665734-1-abarnas@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821133521.2665734-2-abarnas@google.com>
Subject: [PATCH v3 2/3] staging: media: atomisp: Whitespaces style cleanup in gdc.c
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Clean up coding style whitespace issues
in drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c.

Fixes include:
 - removal of unnecessary line breaks
 - correcting spacing around operators
 - correcting spaces between types and names

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 .../pci/hive_isp_css_common/host/gdc.c        | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc=
.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c
index bfda3cd13306e..bd44410729bb4 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c
@@ -24,9 +24,7 @@ static inline void gdc_reg_store(const gdc_ID_t ID, const=
 unsigned int reg,
 /*
  * Exported function implementations
  */
-void gdc_lut_store(
-    const gdc_ID_t		ID,
-    const int			data[4][HRT_GDC_N])
+void gdc_lut_store(const gdc_ID_t ID, const int data[4][HRT_GDC_N])
 {
 	unsigned int i, lut_offset =3D HRT_GDC_LUT_IDX;
=20
@@ -34,15 +32,13 @@ void gdc_lut_store(
 	assert(HRT_GDC_LUT_COEFF_OFFSET <=3D (4 * sizeof(hrt_data)));
=20
 	for (i =3D 0; i < HRT_GDC_N; i++) {
-		hrt_data	entry_0 =3D data[0][i] & HRT_GDC_BCI_COEF_MASK;
-		hrt_data	entry_1 =3D data[1][i] & HRT_GDC_BCI_COEF_MASK;
-		hrt_data	entry_2 =3D data[2][i] & HRT_GDC_BCI_COEF_MASK;
-		hrt_data	entry_3 =3D data[3][i] & HRT_GDC_BCI_COEF_MASK;
+		hrt_data entry_0 =3D data[0][i] & HRT_GDC_BCI_COEF_MASK;
+		hrt_data entry_1 =3D data[1][i] & HRT_GDC_BCI_COEF_MASK;
+		hrt_data entry_2 =3D data[2][i] & HRT_GDC_BCI_COEF_MASK;
+		hrt_data entry_3 =3D data[3][i] & HRT_GDC_BCI_COEF_MASK;
=20
-		hrt_data	word_0 =3D entry_0 |
-				     (entry_1 << HRT_GDC_LUT_COEFF_OFFSET);
-		hrt_data	word_1 =3D entry_2 |
-				     (entry_3 << HRT_GDC_LUT_COEFF_OFFSET);
+		hrt_data word_0 =3D entry_0 | (entry_1 << HRT_GDC_LUT_COEFF_OFFSET);
+		hrt_data word_1 =3D entry_2 | (entry_3 << HRT_GDC_LUT_COEFF_OFFSET);
=20
 		gdc_reg_store(ID, lut_offset++, word_0);
 		gdc_reg_store(ID, lut_offset++, word_1);
@@ -83,8 +79,7 @@ void gdc_lut_convert_to_isp_format(const int in_lut[4][HR=
T_GDC_N],
 	}
 }
=20
-int gdc_get_unity(
-    const gdc_ID_t		ID)
+int gdc_get_unity(const gdc_ID_t ID)
 {
 	assert(ID < N_GDC_ID);
 	(void)ID;
--=20
2.51.0.rc2.233.g662b1ed5c5-goog


