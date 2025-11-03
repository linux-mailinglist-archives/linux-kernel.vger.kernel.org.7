Return-Path: <linux-kernel+bounces-882580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C70C2ACE7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6972C4EF71B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160952EDD7E;
	Mon,  3 Nov 2025 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCg4DDPV"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC22EC558
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162724; cv=none; b=dg5Uf03NeVfF9Hsp+eHPeFpO8NxYeDPCFdo4QYiFDfr7uzIjbeLJs4WBlYd2kvyRWD9HdMhWcUNcUvJEq4XFyKS2toDNL7V95GuTBBZ34e4TCYmYp3kr5Cxn3/pPBYvx/Y+ghF5J/w24RDAmWttPcb+K38SToxCp+4NpbTpEUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162724; c=relaxed/simple;
	bh=XcUoAMRzud/BfROb5OhjCoflIe9MEY9CwYTvjsrXxPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1SE5Z3tjaF4OShMAfloAvPuZXhALbZmccneT7e2wwNKKc7po0dMBDgdQLWHniIensuQtUeF7AqGxRVxFHTRDt0xtcV9pVZVrhyal6x5bmihV6zMcqTLExhPZwgRN9GvUTJGqAG669crt90DLmpv+w8UD01fTUTEp/itxGrXrR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCg4DDPV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4eba313770dso54554281cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762162722; x=1762767522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=orYKOBy17NEykTrxNf6mugIktE10EGb2kttQR8e1ZFU=;
        b=XCg4DDPV/u4xdSif1BbH7XCvUtUKq3bGISI/gduWjTIBqsD/eGxp0fOtdR5k40VTkv
         S36Tjo2Owuv+/Wht8jXmTDhuRdoOojjRzpEwKGZP4Nhi0R/zrTw3iSKXa8q/w39XIBVP
         sgRElx3g2yylFSrt5Tq5RgC9leLzXJPqV1LAtXmaL5r1I4lKAQjoBbWXXxCo5cI1aoWt
         nEaAFQzgJ9GvmCOBAQRN06hhbwDdMWvhKyUjXQrLuU+Z591eOCiRfTDz2lcjqinCFNxU
         7RUeBn0IT9GSTF91h5ny7QjM0PY9RwgoJ/cjssnuRZIUoODt05ktlIFU6CCyMWx37fgP
         vEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162722; x=1762767522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orYKOBy17NEykTrxNf6mugIktE10EGb2kttQR8e1ZFU=;
        b=mSbjh9KiHJGVtC0ll2rBquOWbv6MPh3X8Jc+tP5KPLW5phj9sCkWs3poGfKmmR7do+
         pBqzEY7M71bH7L+/aEOsE+xb7y1KoCtNljvFg2mWP9ElGIi+BgnYUvjrLRtJWyxdJyCo
         JpeEfL03yQgnXTBholwB0TtkI3YJT8PhDy98db/T39/21gOPJc4jOSH+7TFtl7oLTJLN
         e9B5VNzbuyGHvPbhejj236I/+QYe9wSxjktiAz3p/Hkv8V4ShjHDruMDz4Lr6KMPmkix
         dHGmIhJHzX7Or+mV1GTIBrNrBOxDqDKKPzjVBGmLMX3q7pL53x1r49INE3XFvJNlriLs
         z7fA==
X-Gm-Message-State: AOJu0Yw3rN06W0ep7yrfclccVeedn72oqz8t/PLwotlTQyhmWys9v5/0
	of6tpZyC0rEKWjoAV2J7Xql+lCAyGITbsrgaHJX8bpgQ10u479r/JcXRFdtJVcFlu7I=
X-Gm-Gg: ASbGncuu4qbhODaN1b/5w8r5OtahTnj2ryxLujw1uBhEykMI3NFVLJvZmnFW+Nqa9MI
	cFxi7fobn02Rpy2p1nJeMzRnUCbLnkN+NvY5kd/vUXzjPAKGntkvTlln5sNa80lgYBnpQZUt65g
	jLtQOnv2UpDPVR0Fy48ydh1gKNuy5t3SeJeVONv5WjIO96bISzayITDfmkIpG52fEDH1MfdRcIR
	IppzbDITENN9Eikvut87dobe3E9vU3LbuUkTXRn8W6MFaPwD+sDcZPmIskI9d+Z9GGDZBxym8g+
	8R52QqUkaT/doOKmr0MN4Cse04efDRpSxlHUnXjEclbfso0DkOOUySm9YcN73XMIAcynsrubXdA
	F1VWO2cEvRLiaIo16bfxLa/Dmpk3ZA3XffYBeats6kVUlGHaHBCAysFWFw2ACNjbEz8F91t1///
	aabrbJI4g/BWk=
X-Google-Smtp-Source: AGHT+IEAjr7EvzErs5Y5N+6wg7bTwAwk6233Z5S8GHDoeYwXQDvl5I5ydM0T8MjRo8Z70j4pCMd7Qg==
X-Received: by 2002:a05:622a:4c8f:b0:4ec:fba9:e0fe with SMTP id d75a77b69052e-4ed310db742mr156874241cf.55.1762162721600;
        Mon, 03 Nov 2025 01:38:41 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed413de9efsm40662811cf.33.2025.11.03.01.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:38:40 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D3824420A685; Mon, 03 Nov 2025 16:38:35 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Accelerators <linux-accelerators@lists.ozlabs.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] Documentation: uacce: Add explicit title
Date: Mon,  3 Nov 2025 16:38:18 +0700
Message-ID: <20251103093817.52764-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=bagasdotme@gmail.com; h=from:subject; bh=XcUoAMRzud/BfROb5OhjCoflIe9MEY9CwYTvjsrXxPI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkc5QvaeLqCGSednXTq28oDe3SPO1ypCp7ySS7mrbq4D qfsqRrNjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExk7g1GhuWcOy+LW/gWLYpK 7Nm9PmfXlCtex9b9bztfriH25GuX6SRGhg0yc5+/7Vf5El1+ymnhXQarJ4+OCHbdfdIr/d63kiX 4OQcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Uacce docs' sections are listed in misc-devices toctree instead due to
lack of explicit docs title. Add it to clean up the toctree.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [1]:

  - s/acess/access/ (Randy)

[1]: https://lore.kernel.org/linux-doc/20251103025950.23159-1-bagasdotme@gmail.com/

 Documentation/misc-devices/uacce.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
index 1db412e9b1a380..5f78d413e379f4 100644
--- a/Documentation/misc-devices/uacce.rst
+++ b/Documentation/misc-devices/uacce.rst
@@ -1,7 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-Introduction of Uacce
----------------------
+Uacce (Unified/User-space-access-intended Accelerator Framework)
+================================================================
+
+Introduction
+------------
 
 Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
 provide Shared Virtual Addressing (SVA) between accelerators and processes.

base-commit: e5e7ca66a7fc6b8073c30a048e1157b88d427980
-- 
An old man doll... just what I always wanted! - Clara


