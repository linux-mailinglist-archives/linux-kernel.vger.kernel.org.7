Return-Path: <linux-kernel+bounces-884068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D3C2F4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 05:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D9974E830E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 04:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B98227EC80;
	Tue,  4 Nov 2025 04:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1y4HDFG"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC74C79
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 04:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229916; cv=none; b=X9UvskUCM4JPwK5nMU8O7JiJ9ZhPSks+y6gUNYeXGojGw39G7h1bHCDfJvYT9dqDvmLrQ73h1cUh/TfHHCWm0C9rf0Cy6IXOvxLsaVA6CVCp+9PdhRAuqFf6NWIZ7R4u11rqVEpSFnZj1qAhqz8XRviF0EjwITiEEihb3L19kjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229916; c=relaxed/simple;
	bh=PFisK2Y4v5ov4h0HXydag3IhkH/WZkWHxAtXqBYXpOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jjbpqx7JaujhWTTvHAeA73MMY/eozUf730iKbRHelQ/M1z50oM97tMrzlOBcVWu5c1VymjkrAgUgF6HAwms+EwdA+2xKTFwNTRn1rHXmELBb4783mcvpeCfJK9ZZZWYvmD2oyfN4vTsNVZcMW9oFU52V4sItdm2mC3rYABV6yko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1y4HDFG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1740660b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 20:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762229914; x=1762834714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yYFVSsxYLMJ5ZqN2sf5Eu8Pe3jUJShe4wJp81wRNCs=;
        b=Z1y4HDFG181YFbrIBi0yEkGOqwIuZF3FQC/oMFtCLLfpajvzUpImYIRHZoPvoMcTGs
         5raw/Bjh81+zFSdXUgLDT+bkXypxFf29+0NnwM1wOXGoAHmbUiWQ1Ux6m5QSsYaDADNE
         gO+JCGaWhWOKi/36arHKzlNyseWT+vdH4NnKVTW4bPfIJDP01UH44BgdS4lcfvrp9LXD
         +rY3OHPDoyD1VdWCsZ2dHCz2jDmF4pR/lagDbuVjmr7Ff3I5ZG5Tvn/N+w9PBadvePCg
         YsNAUgKfDEuEyfY/Q4jt1cEtbV67ncG0KiLuXExkYev5WNXdH6hD66QWkeQWHHf9dPMB
         aC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762229914; x=1762834714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yYFVSsxYLMJ5ZqN2sf5Eu8Pe3jUJShe4wJp81wRNCs=;
        b=AXNKA2j4CuxEghEb7IZamPdfW1aYoVZy2QdL/wT3IU/XjUcyk6AIqDadYo6hWOSjBu
         tBLTy3GzoilNQZWFrxrm2cVBZ31Li7xKvNCA9jKNx6bBYqJvmlc3M+MRV2OThKuGwE3z
         fX26Q7HbEv5HRdgQx0ajQ0+Nhts+vrYVhD75jt78Ul4K1lMj/64XZ3fjdurYAJRn87Rw
         W8ciebXo2LwKzWA22y2FZJIAz3t3FtAINaCD5yY08barPRT5ufmtCmCrhz0ntKBMN+oS
         1jBavlllFbzvujCFGYP12k9BjiyiLWGnr51RW0uedtZQD/RYxhnltZzcNxd0bwvqaqNS
         zGdA==
X-Gm-Message-State: AOJu0Yz3fWED7UPNaTK0OBssjG/VAMYdXmbfIIqZX3QlpTCwII5PLEcS
	UaHDkXkIx0ev+uZnBtzzSJSeg0rHRIf7Hn/N9VEQcOzG6Yf2l+czsTx9
X-Gm-Gg: ASbGncsQwGR1zjCYXfJnSlMZWrO+HPPeTtPkiaY5f8/9oI+ld/qapGH+gfNsPixLsJz
	IL/4hzlq2cY7y26R/6PLy5A5uJgf5xoEJ6RiIJe8zCQ4HIJVlF7NYJxi/oA8BxC9myCch1Y0tqb
	lVoMaCJEffNy88CUSXUDQ6Kov4XLKF534e8WFtONQD3LY76caJexSbK9fWTAkb31+I3B5pPNWNz
	efPZT2lADBnyOYOoIymbQuwjh47ESVyXuLkY/4j7FgWRV1ByZePJL29qdf6k2ytOQ44Ny0He2Rq
	w0wYaSj1M/ATDzvwbeIaRcLRz4OS04G0bOiyDCXE4Aqci2mGganh3UqmRXM76mZasd9Eby//SfZ
	WMN1G9K8qJpJbDdQlMOMrhwYWFFNy3Z3FeC7v8K8ct7/7uabNBBwkH24SePeJc7zkB7sjlEMBHE
	d51x79yQsUV4U=
X-Google-Smtp-Source: AGHT+IFnp1rbVVecnteXZeZnIaqpgtoYIsbHg7fTb655l/TYkGbuBKFMYcDW4EKUbz2aSe6ujVbAQA==
X-Received: by 2002:a05:6300:2189:b0:342:b918:b475 with SMTP id adf61e73a8af0-348ca5653aemr21654681637.21.1762229913809;
        Mon, 03 Nov 2025 20:18:33 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2893b60sm786440a12.9.2025.11.03.20.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 20:18:33 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 29EDF420A775; Tue, 04 Nov 2025 11:18:21 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Akshay Gupta <akshay.gupta@amd.com>,
	Srujana Challa <schalla@marvell.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Julien Panis <jpanis@baylibre.com>
Subject: [PATCH 3/3] Documentation: tps6594-pfsm: Fix macro cross-reference syntax
Date: Tue,  4 Nov 2025 11:18:12 +0700
Message-ID: <20251104041812.31402-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104041812.31402-1-bagasdotme@gmail.com>
References: <20251104041812.31402-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979; i=bagasdotme@gmail.com; h=from:subject; bh=PFisK2Y4v5ov4h0HXydag3IhkH/WZkWHxAtXqBYXpOI=; b=kA0DAAoW9rmJSVVRTqMByyZiAGkJfQGiE5u8TzO035EqLG8fweYv0qclsCh5LSy93iEYfkkSg Yh1BAAWCgAdFiEEkmEOgsu6MhTQh61B9rmJSVVRTqMFAmkJfQEACgkQ9rmJSVVRTqNeNQD/UG1J 86SKDgQI1vIuozXIBhGa4FAyv3lasv4yjgDOEWkA/1SgEt6JTFU4EPlldzqPpBg2dgW8V7LI6KV uvpy6wwkK
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

C macro references are erroneously written using :c:macro:: (note the
double colon). This causes the references to be outputted as combination
of verbatim roles and italicized names instead.

Correct the syntax.

Fixes: dce548889650c1 ("Documentation: Add TI TPS6594 PFSM")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/misc-devices/tps6594-pfsm.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/misc-devices/tps6594-pfsm.rst b/Documentation/misc-devices/tps6594-pfsm.rst
index 4ada37ccdcbae8..5f17a4fd9579ea 100644
--- a/Documentation/misc-devices/tps6594-pfsm.rst
+++ b/Documentation/misc-devices/tps6594-pfsm.rst
@@ -39,28 +39,28 @@ include/uapi/linux/tps6594_pfsm.h
 Driver IOCTLs
 =============
 
-:c:macro::`PMIC_GOTO_STANDBY`
+:c:macro:`PMIC_GOTO_STANDBY`
 All device resources are powered down. The processor is off, and
 no voltage domains are energized.
 
-:c:macro::`PMIC_GOTO_LP_STANDBY`
+:c:macro:`PMIC_GOTO_LP_STANDBY`
 The digital and analog functions of the PMIC, which are not
 required to be always-on, are turned off (low-power).
 
-:c:macro::`PMIC_UPDATE_PGM`
+:c:macro:`PMIC_UPDATE_PGM`
 Triggers a firmware update.
 
-:c:macro::`PMIC_SET_ACTIVE_STATE`
+:c:macro:`PMIC_SET_ACTIVE_STATE`
 One of the operational modes.
 The PMICs are fully functional and supply power to all PDN loads.
 All voltage domains are energized in both MCU and Main processor
 sections.
 
-:c:macro::`PMIC_SET_MCU_ONLY_STATE`
+:c:macro:`PMIC_SET_MCU_ONLY_STATE`
 One of the operational modes.
 Only the power resources assigned to the MCU Safety Island are on.
 
-:c:macro::`PMIC_SET_RETENTION_STATE`
+:c:macro:`PMIC_SET_RETENTION_STATE`
 One of the operational modes.
 Depending on the triggers set, some DDR/GPIO voltage domains can
 remain energized, while all other domains are off to minimize
-- 
An old man doll... just what I always wanted! - Clara


