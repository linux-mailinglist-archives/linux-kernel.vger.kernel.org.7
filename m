Return-Path: <linux-kernel+bounces-783026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8427CB3288E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07361BC41CC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F6C25F99B;
	Sat, 23 Aug 2025 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2rz1Jfy"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2158D259CBA
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953022; cv=none; b=ZqKNYJgJowaJgcaCxk2GAeeg4xHpJB1l5VbVpsh8KrtdiakL5YNqcsiL9sZOQqv5FJK1Fxd37gqSuqdRoQr6E0bj9XrUdSG/z/K7bruDBnek9PpuJhXVZPZKoaYorfi1K9ECSX9uaJmUMVi9faIbooK6hm7OsSQGZnG8KC8LDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953022; c=relaxed/simple;
	bh=K2GtzP1Tp6PLlfmQr1Kp1P75OZIn7IvpZyIysY3IAnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXpaQx6aGOER7oGbXG7ONU0f3HDNKPE3rBWfQKrc8QMLAUgZ6vwhUCfOU9iAT+HyaYwJHYp54OXboVlXo0rhA5BFpLmkpUAhQ3XPkdIa8y4BA13A5wfXkBES+y0BwBNklq9n5KHwEMbOzLyyzko/S9UwI7SPMKG+ThOPJvpIAbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2rz1Jfy; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb6856dfbso540080066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953019; x=1756557819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/T8DTnsDa48J8Nw09VdyHPo/w3+O0UEktrhRhKVLZc=;
        b=V2rz1Jfynm40GV+DpqdWZd+NL5qG1DJZmlrA3b4Qw59O+9scm//yH+JO8hmsS/VOn+
         lGWqmYW/PKtv/8uWDunaBr627saz9WqRZnfTEyAW4d8EJfcmNiq/SNES1iU8BvpPCYsV
         B8CumTk45fM+pJzEQoymOPfdXsmf99iafiw7+5sdscrMsesqhZfamKnvh43NnOMYMDWe
         TvABnuSyq9D/a20IzRWWSqGZsJn65TH4qaqZlWkVsStQPfZ6s8AUMwt5IcDkejOAXr6r
         fOmlrGO5I8P2V8OF3w2osqRw6qsxnxhc1cUy+t+Onm94bNOfDkOZucIbcashCTm6WiE5
         rWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953019; x=1756557819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/T8DTnsDa48J8Nw09VdyHPo/w3+O0UEktrhRhKVLZc=;
        b=vvJN8W3wOMuVc88T2JPiSQqGcPZMh9DwKh/i5nngoNaWu1v3hmwUyARmCD3HR8G/gg
         R1NPuMzlJVnZmdvEyEZpn3h0JjQu4hx0qNIpS32xD0AvQsWU8GhskF9PEWa9POnLzhf9
         rbMQ10OIXP1mOQw2ikAEyv+AoRJmaI+xyNTQVP2ll0MOVHIu8N8mnV1+aY7jR7PD3U8e
         xhGQOpn8b54zf3JQd/C61u60SbBtHTVDMDpgEjTLTyG49fBJ+u2Q4ejVN6d4FAllqlFw
         M6j0cyXzed+rl7dbpg51giEKSiYV60DEEfyQ9SYiZ96y2bK6zalFBysaZJANNNV723R4
         ztVA==
X-Forwarded-Encrypted: i=1; AJvYcCX1QYZdsqPxBJGlEuQYELh4pvyBOjkQZ8Qc3hj1WAT5Z1+3iLSQ60U5PxW0I4xPC+LEVAplaSa5MyCOrwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3z56ShFcPRv5AyZe5jE+gQ03GHfeaIZ/TpG6x0AkRfq/cpUl4
	7Z6rxbvlR3AlaaE+v5f0kBrnpiZoKja2rmGJ3HINmn/cIFNyZqRuZ52X
X-Gm-Gg: ASbGnctyMoM7oECCIrLpe1mrs7UeJMOQDV3g9+G+xNqbq8uAZyko8gb3ws1YN5+LeGe
	J1oG7qjhD9e/VkufveTHLo+9y/Dc8r7+4lte9NI/Q/sCJqd9ukspPdq+RgdVadqkIYUPGqnvrpD
	nSFnodH8wbRT2FVDM1ILg77Kb7Pdf1pqTXIXR96McT5xS1u72tlYlBQYm12lypgtAwNnrjTBWjk
	ofmXiNfjREoa1fH+FpHwQSzxpSrIVr8pLMOPaMphgDkVrOR50TIIs6fGeGGL/jxcIFbaOKVxPF8
	D+l2VVLhAP82xSska25kFlJ17KcWy8C0ouGSWm18AqKmwcDFunSMTd3zRBWIvm1r+TIhwcSKyqC
	WXd7b5CG3RGwwTY0htNIjRS7FeA==
X-Google-Smtp-Source: AGHT+IEheKPxRuuoJ+c7oqo62GuSN8YIYg1PG8sW6j7mepnpvA8qCpSnad+S6HjtVsMmkKwECfvCew==
X-Received: by 2002:a17:907:9693:b0:afe:5765:2012 with SMTP id a640c23a62f3a-afe576604e0mr183099966b.15.1755953019144;
        Sat, 23 Aug 2025 05:43:39 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:38 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/14] staging: rtl8723bs: remove wrapper efuse_ReadEFuse
Date: Sat, 23 Aug 2025 14:43:11 +0200
Message-ID: <20250823124321.485910-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250823124321.485910-1-straube.linux@gmail.com>
References: <20250823124321.485910-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function efuse_ReadEFuse is just a wrapper around Hal_ReadEFuse.
Remove the wrapper and use Hal_ReadEFuse directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 42 +---------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index e865f83c0967..1079e2bc3287 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -97,46 +97,6 @@ Efuse_CalculateWordCnts(u8 word_en)
 	return word_cnts;
 }
 
-/*  */
-/* Description: */
-/*		1. Execute E-Fuse read byte operation according as map offset and */
-/*			save to E-Fuse table. */
-/*		2. Referred from SD1 Richard. */
-/*  */
-/* Assumption: */
-/*		1. Boot from E-Fuse and successfully auto-load. */
-/*		2. PASSIVE_LEVEL (USB interface) */
-/*  */
-/* Created by Roger, 2008.10.21. */
-/*  */
-/* 2008/12/12 MH	1. Reorganize code flow and reserve bytes. and add description. */
-/*					2. Add efuse utilization collect. */
-/* 2008/12/22 MH	Read Efuse must check if we write section 1 data again!!! Sec1 */
-/*					write addr must be after sec5. */
-/*  */
-
-void
-efuse_ReadEFuse(
-	struct adapter *Adapter,
-	u8 efuseType,
-	u16		_offset,
-	u16		_size_byte,
-	u8 *pbuf,
-bool	bPseudoTest
-	);
-void
-efuse_ReadEFuse(
-	struct adapter *Adapter,
-	u8 efuseType,
-	u16		_offset,
-	u16		_size_byte,
-	u8 *pbuf,
-bool	bPseudoTest
-	)
-{
-	Hal_ReadEFuse(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
-}
-
 void
 EFUSE_GetEfuseDefinition(
 	struct adapter *padapter,
@@ -311,7 +271,7 @@ static void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse)
 
 	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
-	efuse_ReadEFuse(padapter, efuseType, 0, mapLen, Efuse, false);
+	Hal_ReadEFuse(padapter, efuseType, 0, mapLen, Efuse, false);
 
 	Efuse_PowerSwitch(padapter, false, false);
 }
-- 
2.51.0


