Return-Path: <linux-kernel+bounces-845195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9112CBC3D70
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8947C188BF1D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9382F5A18;
	Wed,  8 Oct 2025 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLtp0xc1"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C662F531A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912126; cv=none; b=TtComxUnjdTe9yKVNzIfTm2+7TDyknpOIOK17jHruJoSh1UKrD826PFyaubVNB982y/Gsrv8W9+0bJdHkPrUzC0u2T/EGfQai/RGadLUzLBQwCD9axc2UpV/CAS3pryVZ29wWYyD0WWfYDjnmkpACkL4A8D/I8Px9I+AbJsCGf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912126; c=relaxed/simple;
	bh=Ng+kKkFaTeAHeDn37WPq+qcIK6a1rAYErWCGcqI4JGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cH16qdXTUSLuS9Jkc04rsngBcPBBq2jQkJ2zmxaxLvLSaVGTtzrlErrxjGssFpnKb4ycGmfWWxPP6i1BeMRxZGtomQfHE0WXitUDu4+iPIGRGySLzy6VRUsbGl8Rl0F0xbErEMah9gmPDq1rOh6/UZximLA4wrSZFe60RutBGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLtp0xc1; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-579363a4602so7999935e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759912122; x=1760516922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXVMCYVqhYxHmVEcLB21GvSyFEdTGyVsbdPWOR94MMw=;
        b=LLtp0xc1tbn7Y/tGCIqtARDK8xcb5IMwh7tAvN1HsctIoRJzb9GBJ3gZFErff930VP
         c3nabZaY8u3des34DkQqNoomEMk7870rbyWY2fdW2MTppvJd4KZy2dZfCG0m5ZTSsHGM
         Bd3rubG/liZXOrSRMONjckmvfJ83TOj5cRxUePDhBeJTZEHhvFwwhwrBhBKLX/k5jhr5
         2dm1teikua5X0eq3jv/RAQEkg6onlHAKbnWKBlpJqFqCAzw66rrV5gE/mj/CdzB9sZL3
         bURuMWNaN/20sKyXjmk0w3PeYC+CWO2NgtCdDRCC6ivDdQagxs4NCABPybtXROIlf8+x
         LQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759912122; x=1760516922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXVMCYVqhYxHmVEcLB21GvSyFEdTGyVsbdPWOR94MMw=;
        b=Afx0dF4zQVaghSnCQ48xGEEFQ9r9E0Al0Uw96Sb3zrJJb1ue3hDHIS+LiYJvoNtg1U
         0/y3xtBeqL1rAGL2EInWAW8Lxw+LhIOZA+TBglD8wVVIwCS8T+Zx4zYO3r0oG98rG/5d
         hGivOBaNcUki4EnTzMx142uKK10lMqJB1NYqiHouBe2UkT1o0zJlP8Wbb24rwESgxS1Z
         oUWNMdNC2C3fmeUFTKrtlLzT0ea9f+f+jPgKf5nPGdxyGmp10fKZz6fBQOQAfBMHrkUF
         0hdKLH0jVmT2UT0YLihznScmeUnFmsHW5wvEOxn/46+VcFHwmJjdb6kfccmP7r76oVlw
         C4hg==
X-Forwarded-Encrypted: i=1; AJvYcCUiFtROVQOnlFGrjhWzMM6MJhCyExn3eLlEAxNgteeKHuKTIVVJo1v/bavis/0ZNoqMDawcpvann9ncOJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnYNz+eSGcFE6JnLfXkF1Nib6LraiPy+Ic8kzCe/FRxvFWIBX5
	WAHrRwbmk4nKwKEs3G4J0w7TRfobcnlGG+9D5/c2A3FRgLDdG/1SJrNq
X-Gm-Gg: ASbGnct6IL+0xX3sXHd6vjl/w11GM+lWSpBcnvYToltZKwy6e0Gp782rtJiH1gteTEx
	hUHMHvkV/gClvW2joISp4xKdfBDEbpfFExRbv7Docxo58SSBQzw5hqNwro8QB4nFUs6u6fcyKtw
	1HyogjE1I8EdSiC+x69oG2HCCTxrEF2DYaJ5f83OKW0bkV4sDQrDzKOCZ2PJli5kvAp0ElU3muW
	cmAAO9iqMEBn/MKCUOcWZ2cIAL52EmaeA4UGAdm4vwj5/k6H8n34anhfP5kKzOhpJ4H9jaWibAT
	uGOE9loPS7njggiAiQTrAGxoVLEZsLKiwkN8h8fFFhI8fp4lMSlll9MuiKMzxMK0jIuqx+KRlZs
	oYMY/qJFfaqmaumNGJmTBif9pvZMwJ9TGKccq4A==
X-Google-Smtp-Source: AGHT+IF+1vf4Blkz3Lq4Rw8Uqfb7Lg9ffe/Kp4eC+9aI5yktFAQzgyPPiVzBw3ZloFpXuWtIim4mOw==
X-Received: by 2002:a2e:a9ac:0:b0:372:80ac:a33a with SMTP id 38308e7fff4ca-37609e604b8mr6494121fa.28.1759912122024;
        Wed, 08 Oct 2025 01:28:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01124649sm6968733e87.15.2025.10.08.01.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 01:28:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Douglas Anderson <dianders@chromium.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 4/7] dt-bindings: display: panel: document Samsung LTL106AL01 simple panel
Date: Wed,  8 Oct 2025 11:27:56 +0300
Message-ID: <20251008082800.67718-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008082800.67718-1-clamor95@gmail.com>
References: <20251008082800.67718-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Samsung LTL106AL01 simple LVDS panel.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 5e8dc9afa1fd..c2963434c895 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -272,6 +272,8 @@ properties:
       - rocktech,rk043fn48h
         # Samsung Electronics 10.1" WXGA (1280x800) TFT LCD panel
       - samsung,ltl101al01
+        # Samsung Electronics 10.6" FWXGA (1366x768) TFT LCD panel
+      - samsung,ltl106al01
         # Samsung Electronics 10.1" WSVGA TFT LCD panel
       - samsung,ltn101nt05
         # Satoz SAT050AT40H12R2 5.0" WVGA TFT LCD panel
-- 
2.48.1


