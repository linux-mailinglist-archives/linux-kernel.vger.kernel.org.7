Return-Path: <linux-kernel+bounces-846472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D783BC81A8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 035D14EB0E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173942D23BF;
	Thu,  9 Oct 2025 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2uVAKK0"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429052D3225
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999451; cv=none; b=iVdP5mMvEMF8hrWGRzeOf4EoXSC4dhywZa+fmagk0muFdcbXMsptIK58DlxLWv+yFI3mAw0aLmSb4BVGcZCfKPgzeF3myItC9PjVE8/qV3C2g1G+OGNEY3zONh2goSpx639fNEPVN5ZVwF1aQvUKFPkvj8CHy2CmZscF72iqskk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999451; c=relaxed/simple;
	bh=k3m1XT+tVJ9SU1qc7aJbhzhVsswLDKqkHKsOAeavVnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPRURmx0n5Ysb7LIXYFTD+OO5pQYfAUgGiS/tdDlslM8JL7UfY/lEhemNYZnbQw9gMV8eZlnqPici/C49+fQGWtaE7TO6q06YU3y5fcroH60kWLS+g6zMPAu7G7MNS2+gZgrByYc8fRWeN76zpHHpEgU1hC6R35+ksHI4RtuD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2uVAKK0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7810289cd4bso696261b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759999449; x=1760604249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lPxY6O/wb2QYEN/tX+ej2UY9DnTOP3+s/1F27dh2aw=;
        b=d2uVAKK0N+JTVO9S5Zn60Hmev4yHkJZ6lpOknxSONns8ieetWgbKVaXSM40h50kNFS
         yngyNtHLDtzw6cf2wVGhQZIym8B4dG73jzxDIxuEgblcslT9dDLfm66eZLu6VMDKl8/P
         muDbHQOHXRlczmaUGSA02YbRCYp69H3o3Bl4XK/LcySqD/nSQmmJqIHzdGmg+mZSlgHi
         UgscimgWpHmvAozlOUvrmlYfC928HG1RNLU99Mahg+NNtuVCDeMdwBm1LHUKSOo8laI2
         luFNcBqK+4IzRiB/MOv37bLD7KNjb/z6HUZvQJPAb4p5/nCYiGKqA6x772E/z6V3jqI5
         URQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999449; x=1760604249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lPxY6O/wb2QYEN/tX+ej2UY9DnTOP3+s/1F27dh2aw=;
        b=m+7o+PJ8rPnRyrz6Cp7psDwt0+3Xflktz+wleYRrFJjNPiHML8VrR/2YzuFogFwkLl
         0J1B+Ev1qYtniyjGqUGBna7tw8sCdRzEnY+KpZNMi4dLvNwQ3t0HdXVlgtERakLZmZWB
         H2nKcJQ77GhGfJXmsOlFIEHpFQDbWfF1DXwSp7I7pTEexrYuajtXu8hHnMqo+WB09eOQ
         Uw98xxJ8wxNBVgd3SdanXvL+EqJLTKgufcklASKjyRN7lrHWC7ldxLVl+ToHRq6PiocJ
         DtxujbL+hNeLLRNE+bsuNTNHo9mFOSbhMsL7ak+yQInzpal7LakST7VsihVBPVdtpfhn
         gtdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7jJZJIDeedrHLxQJfrkLS/Ew5hLR+8KvGEJl4dyDKnah4VGlYGefG+Vi3j3QSXPXYZOOs0apAlXJlW/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBbADu/dIMWiuyRKxPgCHVRbR2ouJ+Y6A4xmD3FVIe1e/wFNGo
	8FgabybcCPPdUmvLpcnFZJRAI8sO1zAOXboCKjRuMn3UNQ2FxOnwo/OG
X-Gm-Gg: ASbGncvABFOOYtKRYQWJDf19PsmxGCDxuZg4yJY/ElKTUFGbkYI5242ziP+pWLcteP0
	OnTIGx1udtqMTNvcA8JkzRJFa3lIGeRoGflKgA1BUIG6vT0eL5xSBgPcoEYzMVL1FLSPL/sOjEv
	gCiF73TFB7pTSv7YZ/EOcPFr0Yd7uQuHquqTDq7pQ5JNKV/qgvhl8vivX5l8mnFrxJJKli0HoxV
	NBmLpde2u+t39VCWmRaUXRN5u9aYyWWawlxfi7SGVnfkf/KADcjuZa0GZbz3ShqYdkBfbxCfJEl
	okROJ8ObfAm1MuyMNlmyJNiYth+TW/btYHNuTVhccHsexvDqrX2rC1aaHuSda/aDiWK8/5U7OYQ
	jXV9ALAaIQbHJ5EM4tBl+NQyd7liIh2tqtK6eWPjl/LJ18UYEYCq8p7Wxo3IT3y+QS/ui
X-Google-Smtp-Source: AGHT+IETniAu5RF23DXJl4RTeUmT+jz72oj/4aPrk1D9mhpfpOOTuJt3CBKA7KYp+BQekuHfY5Km0A==
X-Received: by 2002:a05:6a20:12cc:b0:2ff:3752:8375 with SMTP id adf61e73a8af0-32da845f843mr9302925637.45.1759999448580;
        Thu, 09 Oct 2025 01:44:08 -0700 (PDT)
Received: from MRSPARKLE.localdomain ([206.83.103.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e06fb374sm2141633b3a.56.2025.10.09.01.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:44:08 -0700 (PDT)
From: Jonathan Brophy <professorjonny98@gmail.com>
To: lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jonathan Brophy <professor_jonny@hotmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH 4/4] dt-bindings: led: add virtual LED bindings
Date: Thu,  9 Oct 2025 21:43:39 +1300
Message-ID: <20251009084339.1586319-4-professorjonny98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009084339.1586319-1-professorjonny98@gmail.com>
References: <20251009084339.1586319-1-professorjonny98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jonathan Brophy <professor_jonny@hotmail.com>=0D

Add device tree binding for virtual LED groups.=0D
=0D
Co-developed-by: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>=0D
Signed-off-by: Jonathan Brophy <professor_jonny@hotmail.com>=0D
---=0D
 include/dt-bindings/leds/common.h | 4 ++++=0D
 1 file changed, 4 insertions(+)=0D
=0D
diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/c=
ommon.h=0D
index 4f017bea0123..39c34d585a47 100644=0D
--- a/include/dt-bindings/leds/common.h=0D
+++ b/include/dt-bindings/leds/common.h=0D
@@ -63,6 +63,10 @@=0D
      "lp5523:{r,g,b}" (Nokia N900) */=0D
 #define LED_FUNCTION_STATUS "status"=0D
=0D
+/* Virtual system LEDs Used for virtual LED groups, multifunction RGB=0D
+	 indicators or status LEDs that reflect complex system states */=0D
+#define LED_FUNCTION_VIRTUAL_STATUS "virtual-status"=0D
+=0D
 #define LED_FUNCTION_MICMUTE "micmute"=0D
 #define LED_FUNCTION_MUTE "mute"=0D
=0D
--=0D
2.43.0=0D

