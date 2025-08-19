Return-Path: <linux-kernel+bounces-776524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8683B2CE78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7E668491A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2CA315761;
	Tue, 19 Aug 2025 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8+pTpIB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C826B764;
	Tue, 19 Aug 2025 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755638600; cv=none; b=dc3JpNVXDOpRPzWChQUezLrpnhkH2GZvgar6em7FgJuCM8l7cwWLMFWjptssucKdov9gSBKMbpA3vfjP/bKuZitnfcJBtT+t3TBNEZj3DzPwTv/G1w+mcz9LpO1C5WxL2pHva9DujEs1mbmAX4FXFUpRf0UGMedpR9kFQky4cQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755638600; c=relaxed/simple;
	bh=3pFPE8xixveb6M62NQOr/BCbEUe9A8UWN05O5ypZr7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJ4BELtv/QYOvuJe7duHWKOdbnU2rSAF319szoXUMUD5rUqyv7nIBJiC+kBIKUF8RF29ZxND6C1yAW05fLSlCzPxUfO8xTkVoGmfR40825eRAb0lBhWpW2XXYHs/nWEYG6kf/3jZSBC0sTaLv+NKvWXOyPkQv1B7PAA7f4Wn2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8+pTpIB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445805aa2eso48045565ad.1;
        Tue, 19 Aug 2025 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755638598; x=1756243398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PSmrBC1d6V94gjkuBfdG1y/aJoYUJfpUXKEMb53Azh4=;
        b=P8+pTpIBr4GJswnX+npbsLKUq0WHgohLYI7YwYiRBnHQR6nTYqXqlK0uPV0lavqGuL
         jAZ0vIIW+lwb+ddWFdmf5A3m39T0iAzOYq5MjOzEcwFTYvP0OKr5fNNK8Vlis9shOXZL
         IgBFUzwMYLk5TuxhAEmklsbg83mzFHTRWCJJ89rJ/wm5IQIuor/3OG6bCfpT9vXByQda
         ECHSxgt9h4QXELNHWek4dlaFHffZltbwZ8rKKuK+d0Ace60i8SML+GroqgZrLoomV3PH
         NXDJMKjPq6WZovH9akdpsJpUn6EmSSLOfNUF3xqFW9sCG7ORrLJMePA1/iqTDqHlSABh
         4B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755638598; x=1756243398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSmrBC1d6V94gjkuBfdG1y/aJoYUJfpUXKEMb53Azh4=;
        b=OARoB4jMMcTWNpyfdyQwgBvZYGD70GHoQKT5Ks/xcA4Vm8OIi+eHZXWkm9L3Jp6YYp
         FVDipVwlPOxqu+uvqABI6DXuZLwy0QUmzVsn4bwuZYppAfZBJtILWb6duwy1Nd/9pomM
         U2ltALBmRYBqIe/Kb6f5W0xiRWxA9WEU04RxN6aqiNokKfYsNDrVpkut77nonrgET6n9
         ubR7mJF1hvw/EPfv+1e5aNQ3B8pih8SGDGp+dcW5V5FWE0C6dxkaR5eLLP0tZlzdoegH
         zAg9T9DMea36Cdtt8xoF+Z6IEEo53cIrxzxxa+G7O2/iet+gX4bkVGxK0UJ2iUDvbN24
         ZgMw==
X-Forwarded-Encrypted: i=1; AJvYcCUX5HWgsjUcAMiduZoCWuV+/M5YTE30VB2w8mF9+U4Z0vTG/FqmCsfcY1Tlfim1qWnuLmQEUt2J2jQ=@vger.kernel.org, AJvYcCX2lOQWtxYD8pslyb7Tcp/ay+BPfvP/uFBcAvFCvk7Kfj7yGD7csF+AAjhkcUK2Jw0aWmEVDcNR9XZRz0BW@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbwt+Co7ulCqyzhtTU7ACuw7DJjQddzFLwYQNIIg/fgP/AC1/
	9aZXnFkBahIU76JJS64s3zrNgvmLha4JzrfIQUda01cHFoUAqkQMuloLHMpQt5F+tkY=
X-Gm-Gg: ASbGncvXC3LT5YxooJooEd0bAzLgb9RyROklLtcJpVYHzInMac3Tpf0Uga2SRdqXYQP
	1uNNmUUjCjarhflNEmX81Z4IdZynt7wZtbb5BnAiuJxGtN2jH3DbNaNDsF67/22VLR5PxQo315r
	4sPi8umS5lBBzoOt2UFAHbWH8HVcyBjuttc9r7TFxC0fRxBuzS/ji/rMxm/PHsLreywbEtElkql
	/8IibwzT/0DsMJ7LRUp833xzj3K5+J1sp3QnZ12eX3lJ//zyBn9IRzySTPM887+/KPa6HoGE8bD
	06BOK5p9jVVpFkZSQ2Vovy2t4UVNT1D4zTaJjf40rhXwOE93P6DREhVaJ69Am7WU47OLIhbl8V3
	edUrbqD+FHJUNgqGlFQofocQq67KkZVPMCAcqq/U9ebA2tg3DFQ==
X-Google-Smtp-Source: AGHT+IEh4Uka68y7Zj7GJebi6yM8KMmJWwpaYwlw+QFwbiPeXXdYTZC6/PqbjtfhSYD0c3fy30pHXw==
X-Received: by 2002:a17:903:2ac4:b0:240:9cf:99a8 with SMTP id d9443c01a7336-245ef0eedc7mr5753865ad.11.1755638598444;
        Tue, 19 Aug 2025 14:23:18 -0700 (PDT)
Received: from localhost.localdomain ([202.164.136.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4e9bc2sm6364175ad.113.2025.08.19.14.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 14:23:17 -0700 (PDT)
Received: (nullmailer pid 17994 invoked by uid 1000);
	Tue, 19 Aug 2025 21:21:51 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: skhan@linuxfoundation.org, corbet@lwn.net
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Kathara Sasikumar <katharasasikumar007@gmail.com>
Subject: [PATCH] Documentation/gpu/amdgpu: Fix duplicate word in driver-core.rst
Date: Tue, 19 Aug 2025 21:19:58 +0000
Message-ID: <20250819211957.17871-2-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate word 'and' in driver-core.rst.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
Hi,

This patch is part of my work for the LFX Linux Kernel Mentorship
Program (LKMP). 
I would appreciate any feedback.

Thanks,
Kathara

 Documentation/gpu/amdgpu/driver-core.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
index 81256318e93c..bd4be32f2725 100644
--- a/Documentation/gpu/amdgpu/driver-core.rst
+++ b/Documentation/gpu/amdgpu/driver-core.rst
@@ -65,7 +65,7 @@ SDMA (System DMA)
 
 GC (Graphics and Compute)
     This is the graphics and compute engine, i.e., the block that
-    encompasses the 3D pipeline and and shader blocks.  This is by far the
+    encompasses the 3D pipeline and shader blocks.  This is by far the
     largest block on the GPU.  The 3D pipeline has tons of sub-blocks.  In
     addition to that, it also contains the CP microcontrollers (ME, PFP, CE,
     MEC) and the RLC microcontroller.  It's exposed to userspace for user mode
-- 
2.47.2


