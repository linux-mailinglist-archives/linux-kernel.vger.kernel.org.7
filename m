Return-Path: <linux-kernel+bounces-834178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D112BBA41D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3D34C80C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CDB221DB6;
	Fri, 26 Sep 2025 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJQ+l8Mm"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B410217722
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896360; cv=none; b=CXzPRr2WnQWfIFWW+VIVSWUH1PrP4wDTcNlloFcyEoIwoxZFFfkBdI1RrNSlbSfWlHW5LFebVWv/MbmyRHnPIQACTvH365YuHbsEz/ZrI6Rgm6ssdqYjCFYORZqKM2167+uViOEx6ClCyYAGspo1xGk7Seq/tqpZAVTkBbD5uSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896360; c=relaxed/simple;
	bh=qgE1DRlyxJJu7Ruu1746EYrt+DDtbSYwSzn0fLVg2DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/yQ+ix2TELrxKWcD51pT1VeXVmNw6x8WfFqrqAnPX4YHZXiUYiKpKqJ6F/6jiJi2jXGldsmjrxgLcCveKjg90XR4lcvtoh2QNPksonc8J4a4CUifw9ytsvaJnN6G44sEUq0Fa8qeYR51pO3Iw29eLXim77opkHHZJasgt47jO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJQ+l8Mm; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-796fe71deecso14750886d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758896357; x=1759501157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9vnEObE36FL1+xYk2YooCCgZ/a3BnQWUxhVd6RBMoo=;
        b=FJQ+l8MmEX2Qtea8bjGxw6u71ksOjX53DfR+35hKgc867QXA1HihlqiDkNgIqc/YP4
         rFggfMYR9K/TbdsWgy2gOA2wmOoj7UomlewV/Ua3vOEx90Pn981WzGPZTsNyqRrV0W+F
         6W4js4xRYjKI7cqVgho0MrGw+zKHYJPzz97M3pnok0JkAcc0lmwu/CPZNjDrthF1kxng
         4wLvHMY3gWZMXmzcJwUHQKXW+avdZt/x3CEEDBtX7ufevNTinN/Em4+shPHok8su2xQ+
         EOsMmB+tNQV/YoW9/5qm15AZ//ZsAV8gJ4a1W2STWdS1UZy+s5RzlEv8sG9KOhvS10r+
         Juvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896357; x=1759501157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9vnEObE36FL1+xYk2YooCCgZ/a3BnQWUxhVd6RBMoo=;
        b=gBqplY9L7pPKNMpVPP2agV6y0eDrTM02ReUB6Gfprr1qKdfSiSV2sbDK9yzr0jRWiL
         kiQqZPzAhWQXYnhLQkyzlAen+2N2jxWJ6/BSP4O+hZFtWFnrMyIYjZ1gG80NCpn37+am
         n+z1d6iu+ruFO9Ygfwq7plrTdYHfnRR6m+0QnOEVTmxwhkJd1KR0+TDEv1m1t/ZjIDZd
         iMXnCICACNm2VGG9fp2X6iv84AecDC0RNKwYASKNebqAot4eZfwgHcxYinEhL/aLMBn1
         226PaO37TGZTBS84Wz6ejvdSL+GGeqYaZZq3Qv1EfseXCOyYVc4GFCItbfzV6/PeI0I5
         PpGg==
X-Gm-Message-State: AOJu0Yx/jaq5GymGyY58A7pc0SVhmHN0i+hfczlxC9SMMuob/8OAEpsu
	n2Kj26ba6GgYZ3st6n9zPW8pmh6OrHdGOIvf4Wkw0E/JtUk2t3FUpEoH
X-Gm-Gg: ASbGncvcgT1opdr/t2UgoCORof/qlnLpRFOc85Win6DUAfhCOn286cSH4fPvRvKhIDX
	rd4vCS+jEzZsnuwa70UYsbpsfEQr6on+0WwWjEAOyJtFBSy4R09+cjheHYST49IAjq0ntJao4yY
	DQGkDywwkGcBvv4vb7ythHsUnZRnwq/JpYdvN1o+GP12jgMEWzyynGHXq9Et+0ywLhYr3Oi2uvZ
	+amOGu7iBT5PqGTno6Y+9qvHY6ws8syjYhZ/nwjYBo6YgG4HnzlkJtD91wuSNzJpJjA0dznFeX7
	B/An0tsjvfGDkZa4aSme3ZTChe6cLZ/1uveBdfm+BQfhhnq06WqGR/57S2GB147WmJUOJ12nwdM
	gt5/yBaT4ExdOV3M/AOdAu4IZ2Zy92wQKl/26/cM18Un6gi7hwodAgFSu2nMLetLRJWP3
X-Google-Smtp-Source: AGHT+IHX+1NCTF/ARuPbB6IXv8deE5J4rPSitNxlvB/PPa7wmNUGhXtpQbzNPBYGW0Ohfyq0EGQcGA==
X-Received: by 2002:a05:6214:e44:b0:7ad:19a4:53e0 with SMTP id 6a1803df08f44-7fc2fd77573mr93039126d6.26.1758896356702;
        Fri, 26 Sep 2025 07:19:16 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80142f5d6d1sm26649476d6.33.2025.09.26.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:19:16 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v5 1/7] dt-bindings: vendor-prefixes: Add fdhisi, titanmec, princeton, winrise, wxicore
Date: Fri, 26 Sep 2025 10:19:02 -0400
Message-ID: <20250926141913.25919-2-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926141913.25919-1-jefflessard3@gmail.com>
References: <20250926141913.25919-1-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add vendor prefixes of chip manufacturers supported by the TM16xx 7-segment
LED matrix display controllers driver:
- fdhisi: Fuzhou Fuda Hisi Microelectronics Co., Ltd.
- titanmec: Shenzhen Titan Micro Electronics Co., Ltd.
- princeton: Princeton Technology Corp.
- winrise: Shenzhen Winrise Technology Co., Ltd.
- wxicore: Wuxi i-Core Electronics Co., Ltd.

The titanmec prefix is based on the company's domain name titanmec.com.
The remaining prefixes are based on company names, as these manufacturers
either lack active .com domains or their .com domains are occupied by
unrelated businesses.

The fdhisi and titanmec prefixes were originally identified by
Andreas Färber.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jean-François Lessard <jefflessard3@gmail.com>
---
CC: Andreas Färber <afaerber@suse.de>

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ec8947dfcad..cd42bf7a96fb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -542,6 +542,8 @@ patternProperties:
     description: Fastrax Oy
   "^fcs,.*":
     description: Fairchild Semiconductor
+  "^fdhisi,.*":
+    description: Fuzhou Fuda Hisi Microelectronics Co., Ltd.
   "^feixin,.*":
     description: Shenzhen Feixin Photoelectic Co., Ltd
   "^feiyang,.*":
@@ -1235,6 +1237,8 @@ patternProperties:
     description: Prime View International (PVI)
   "^primux,.*":
     description: Primux Trading, S.L.
+  "^princeton,.*":
+    description: Princeton Technology Corp.
   "^probox2,.*":
     description: PROBOX2 (by W2COMP Co., Ltd.)
   "^pri,.*":
@@ -1569,6 +1573,8 @@ patternProperties:
     description: Texas Instruments
   "^tianma,.*":
     description: Tianma Micro-electronics Co., Ltd.
+  "^titanmec,.*":
+    description: Shenzhen Titan Micro Electronics Co., Ltd.
   "^tlm,.*":
     description: Trusted Logic Mobility
   "^tmt,.*":
@@ -1726,6 +1732,8 @@ patternProperties:
     description: Wingtech Technology Co., Ltd.
   "^winlink,.*":
     description: WinLink Co., Ltd
+  "^winrise,.*":
+    description: Shenzhen Winrise Technology Co., Ltd.
   "^winsen,.*":
     description: Winsen Corp.
   "^winstar,.*":
@@ -1742,6 +1750,8 @@ patternProperties:
     description: Wobo
   "^wolfvision,.*":
     description: WolfVision GmbH
+  "^wxicore,.*":
+    description: Wuxi i-Core Electronics Co., Ltd.
   "^x-powers,.*":
     description: X-Powers
   "^xen,.*":
-- 
2.43.0


