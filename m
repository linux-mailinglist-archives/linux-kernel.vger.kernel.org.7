Return-Path: <linux-kernel+bounces-898770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 591F1C55F91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06573348EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B7320A0B;
	Thu, 13 Nov 2025 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvbFTyxF"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5E9289811
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016588; cv=none; b=D++g07mkuonGtrPphc45BhvYq6QErS52uBjuDGbuGQam4ZkQkx1vONydSxFh19/IBesgAtEG7DiHHWV4mkmwf4+ITtV7atSNO7az0e6o/O6/15zMggmX1m1QjsdSCmBXRgANlj4EU+1yg4xZLtn49GmB8tYuoDcT+3QCpyOuRGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016588; c=relaxed/simple;
	bh=29nAki8ESaO1fL9aGhOKACF0bJg24F8USzUzT2R+14k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IcptWvMHzfG71gb2FNxCFkJLZC2T9/TiLb4LF9GgfclcZgyzfdjSpuaKd3cnKLTilRe75v+tStdH6+SGsD9F91Mlln/VXFnRUGrSMfCGo/XQWNlOGGk1QRICUi177wFFA/mz2EqyqWfTk+KKgQZk79uwr0W0CJyQCIz2DWoFYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvbFTyxF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3436d6bdce8so564802a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763016586; x=1763621386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T84pQ1+9aq8AWuzbsa/zDb8vuVA7/GAGMhFUb/seRIk=;
        b=XvbFTyxFH48sRBlCsuND1ti+4HkLaua4NcMYB3AsL/8Mxqm8SpmHlKiW9F5EX7PxQs
         x8Kxsa6+RDM4CkXHHtCWHxXmYsJabD5wfjvs+BLf2k4oxhwX/YtXCAep8TjpymS9/E1H
         Uke8t54lZX5gEVSC2gm2xcM+rwasguzDZJxSYeeaAqWznRBQy5AzCbfkpTffPYHkgMNP
         i1rSSQ2ZhSMpk2kUgYqjhofIWRioc4rGeaTQ6MsqGG+rVtqKXEjR6EiOLdPIQ066k79I
         Z/XwMNDWspfslUrWwnPWISv3Su7HiT/FhchV3yceNXw8ceR4WfI8d2ly/vZSwFeO1/xD
         hw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763016586; x=1763621386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T84pQ1+9aq8AWuzbsa/zDb8vuVA7/GAGMhFUb/seRIk=;
        b=eCJS3KXcTL6k0Vtd55YVvVmu41s0DjFx5hljx79DiszbIynBAbv7sFudLH47HEvuz9
         gsQKCPanBUjlbGWOH2O93SeXvP6nIcqFHFUg+G96qki8FggpAZVEtsSEARsc/SvWNLRD
         UxFiK3sukbh9+zkvDgkkgREw94vdKJ1/CpcycEX/p3YAACsRPELW+FYn/nHyPSSJX7+I
         WmWdBCjfchRNQkqIoKlUbjUiLK1yEB21Q9VVVFaszyWSODGXsDMfB6+FXnYspadLHf65
         kH12rNyqUXbraDWQLDECujzpnFpGSUV7AhlGAKam5PFM1WoECIRk29PbkP2lNWQUHpFB
         V6fw==
X-Forwarded-Encrypted: i=1; AJvYcCVrPCaYCcH7G5+vWxIFApmuUexGYtvCJbFqu1w0c97h/K1jOijG/vzpoZ09soanwX2b+8fyqYA5/KaccdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwLe/KJhWknYarp7jCxinxVQswyI7KatwxeRDucidivl6omFom
	MgQZmilcVngyIOke89MDh0x2eCatmZg9n7FA59rShM2wD8y/K5Z+u2jH
X-Gm-Gg: ASbGncspiqNQGwsaaEpfD/HMT0953yuDJ+ZjcS3jPmdaYJggBpj83qTlFq2EXvqStzl
	V74Xw3akV5pMfJFodcA0EFxXj4APDF0s6hOOtxpQ+3XwTHqEKeeRFsY/FASh11o3Uz30iUvLhmG
	HUgOJq3KSmJZsblZPg1b65PbEdvAIIpDZmK0IwpSdYFHlrGcdPxi45e6KxK0Vg4+vxAmiIe0f2q
	vtkE5ecomvuUppnWo6y+gRQx1kqbOGNNRxHbD2iCjqXEcszbHbA7t3w/odsgR4cS7PNhD1Mpy8n
	/Nuq/UHAUGAk+QZpenHtWuS/17CqniLFMXNAv/E6OP7ljlr59Y+RtjUjAsDVU6Hq6/5qOWTgXDm
	m9/JvqYg3ikAvw4o0QJNiWPQH0zH7nzkWP2oKzQ37KpMMQGiDfDNpBk7xyqR4iEaMmEGbW0Q9mj
	QCclWDjlEP61AA9KJW1+r0WIEk
X-Google-Smtp-Source: AGHT+IFcm/7eA7OM1o0lYGSXbMuGwXv23lCAu3vI178c0WrBUNLFpdQ0EvMHjhKjzvOvGwj6jeFaVQ==
X-Received: by 2002:a17:90b:5487:b0:343:c839:21d2 with SMTP id 98e67ed59e1d1-343ddef34c5mr6162819a91.28.1763016586418;
        Wed, 12 Nov 2025 22:49:46 -0800 (PST)
Received: from ti-am64x-sdk.. ([14.98.178.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07156absm4838126a91.5.2025.11.12.22.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:49:46 -0800 (PST)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	bhanuseshukumar@gmail.com
Subject: [PATCH] docs: dmaengine: add explanation for phys field in dma_async_tx_descriptor structure
Date: Thu, 13 Nov 2025 12:19:37 +0530
Message-Id: <20251113064937.8735-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the need to initialize the phys field in the dma_async_tx_descriptor
structure during its initialization.

Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Documentation/driver-api/dmaengine/provider.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 1594598b3..f4ed98f70 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -411,7 +411,7 @@ supported.
   - This structure can be initialized using the function
     ``dma_async_tx_descriptor_init``.
 
-  - You'll also need to set two fields in this structure:
+  - You'll also need to set following fields in this structure:
 
     - flags:
       TODO: Can it be modified by the driver itself, or
@@ -421,6 +421,9 @@ supported.
       that is supposed to push the current transaction descriptor to a
       pending queue, waiting for issue_pending to be called.
 
+    - phys: Physical address of the descriptor which is used later by
+      the dma engine to read the descriptor and initiate transfer.
+
   - In this structure the function pointer callback_result can be
     initialized in order for the submitter to be notified that a
     transaction has completed. In the earlier code the function pointer
-- 
2.34.1


