Return-Path: <linux-kernel+bounces-799518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A594B42D13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89659189A0D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE592F0661;
	Wed,  3 Sep 2025 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBfRI2nJ"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F466266B56;
	Wed,  3 Sep 2025 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940111; cv=none; b=W3JRfYgQ20X7UqG0ZVaOk0PtU4Ica8KSu1NVMsSCIELA72UMwgBWBDRXDu8Du6mmBZ8BOzd+/1JddeEXiLIlPW1WwbXnJ8jefk8KZjQNYg1id47TMlhjv4aCs97rkgE2viE4efukJybFRsATBatzou9who9Cu0Jt0YGxoHRTr2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940111; c=relaxed/simple;
	bh=YTif8nlR+x/ov/wR8rwfjz8GDHBZB2oD1g0nOfm1eRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjTKR/k4Fs8h5e3qmESDUMlP6z0k3VNB+IoHbIVqOjcjhtA+nWY6HnrM8OqSB7lq4EoJhGr4W4zq/97g66I/1IaRdwgf2Bzwj0ZW05ieGpJu1ibsyofqt/pPFXDcHbGXgrOymWGtPCc8G7IHZ/tKHz6nQfZfoTWjM+dSvUvWbjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBfRI2nJ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4c53892a56so305468a12.2;
        Wed, 03 Sep 2025 15:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756940110; x=1757544910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PERM9NW9/epjauAQ647nr1Bnq/1hfYwv4hqg012Ys6w=;
        b=nBfRI2nJVGOci+CbCBkTFrr6fBQdBEiMYhjOLBZfHNenytt1RBRQ7RSb9aStrVleDp
         w+OcCQ8nnOXpOxUreYMOM//o2pbnGehVcFGkIxGvU7+H8j5WjjNxfuZOcOMkC2ylxq6q
         RczTOw7rLhQxlmhv6yV0VaZC2lDOqe3grtyLLK2/m0WjTB2Wfg0XzfE7liqHbHt/u4hx
         Kfz5WJ0W6hZFR+5rflI2n7UqnkTmKmvSAl41qVhF4TMt7THV18AZP3ONTTs9Y+mQXz1J
         mK5njWhYhGnV+OaKTRpjA5UpSblV1ATu7uwTs5lQ36uV7cMlMWyom9M/FvqGFrHsAZZ4
         l+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756940110; x=1757544910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PERM9NW9/epjauAQ647nr1Bnq/1hfYwv4hqg012Ys6w=;
        b=nlOV8KDpJ8JKWGUJP7SR0WINlE9bgxrE3siaTQ6NmfkrNwPq+qQjMlPlKPCL44fk8H
         Y1DziqmxDLECTPngZIkgfdaMCxhw2EWscRITkFNWvIVFT3Ja3n8OvRMgRSMn6U5RuobZ
         rEQxrr2fHQY9zFPgr6QPjExJme8caulLVsvSzYSaN/JF7yiTJB7adNuch7LUzFwutiZC
         RTdy1+va9dFAi3m53/7fo91WXINbCAVw+Bdkisy88udqZO5cwz9OWDEWdiPjn8Rc5mjI
         1hZ5XXdyurk7T3Yroaxq3zOSli6Q2L28TQy1s2UfWdOTUd6o8tqc4ZIc8LF/mg6QmfX+
         Cnxw==
X-Forwarded-Encrypted: i=1; AJvYcCUwpCa43Se7suFK+9ZhoYj9+wttzAlv9ehRwgBg9lqG5O4n15twXm/be38pQqCus1J6xwBYcdCGEI+n0nJH@vger.kernel.org, AJvYcCXFradGkLCT9XhF0TZRvnQUgcp5S+XvVBcHLykcVq1hOPyUFAJ2y58DR3fhmzHcwhN6bupxFyipgyAA@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVlhrW8EFcYTJ89aWArsvil2Rk3WYRWBXMQaPCMCatwmOq+3v
	vmxAX/wvR4tMK9qOEdApHRqAmNatTFAMkUF7ivneGsrq7k3EPagNm4rF
X-Gm-Gg: ASbGncubZ2YPOa0ixYmfCnqwG65JdZxDHiZRdGZ3cHgsxsdGkJquHAhklufqJMn9HSL
	Y/ez0O/I5qWJnGF7M+B006LD2bMUREwvYhJqnf92662nuezZjZ/kRIlJoCoPTyQ97vqG0yuUfcn
	j+TMK4JrPAasVPmdAtj5cIlSoLG5p8ZQoq/n9Hi0+u/INTc+zj5ZNehxLbM/ywBBRit0Dxj7qBE
	yPa7Wv4Znm5iVe04KRPnkksBjokVL3G6X2y4WbglSCo6VwP5h65Idwj9z/YfOuC70rc5HvRdQWb
	b3VK3tOwI5TriHHR3BChYkU77/NqtfXtc4XV+dngWP7D6VRfDD4Wyubxpu3d+LXtLmmjtRWSrKv
	6CC5JnuyQQlz8fdH4qDGURE+xR6hHSZpAGzQl48S9ycplirZeu8rDwaGCrjYvC5uOT6sQkdwS5h
	0+I4fHrYTxbmqmYfejxT8K
X-Google-Smtp-Source: AGHT+IEsF/meH81c94jigsHRiHn2Bi2s+9U2J/0U2y+3EgRD50sJHl+AM1/5H0vpGBx0GalxnBVwlg==
X-Received: by 2002:a17:903:38c7:b0:246:2b29:71c7 with SMTP id d9443c01a7336-2494490485bmr220520735ad.25.1756940109605;
        Wed, 03 Sep 2025 15:55:09 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24c9c2b1288sm25505435ad.106.2025.09.03.15.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 15:55:09 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: add MediaTek MT8196 compatible
Date: Wed,  3 Sep 2025 15:55:03 -0700
Message-ID: <20250903225504.542268-2-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
In-Reply-To: <20250903225504.542268-1-olvaffe@gmail.com>
References: <20250903225504.542268-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MediaTek MT8196 has Mali-G925-Immortalis, which can be supported by
panthor.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index a5b4e00217587..7ad5a3ffc5f5c 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -18,6 +18,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - mediatek,mt8196-mali
               - rockchip,rk3588-mali
           - const: arm,mali-valhall-csf   # Mali Valhall GPU model/revision is fully discoverable
 
-- 
2.51.0.338.gd7d06c2dae-goog


