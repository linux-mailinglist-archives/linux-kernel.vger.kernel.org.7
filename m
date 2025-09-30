Return-Path: <linux-kernel+bounces-837149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E76BAB8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C8B1888055
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE0327F012;
	Tue, 30 Sep 2025 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpmMDhJb"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC927EC99
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211439; cv=none; b=ShaxEqZ8+5G5BWSurBE+5t4WBXejIrbRySFgNkL1MFND03Xn69535g+PTX8V2FrKnDxQ+zlm8KEle2HuuNKSuIR3ObTuupHZxpUQAqFKFNzWkCiMMxGMTnGBMOave3zxu7gRL7ZaQy4DJpA7ztHHzPiZE7i/JHUN1ByHIdhknDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211439; c=relaxed/simple;
	bh=i8ILy3efLeOoD5Qf+e/n7DFmvbPzfKevH825MWgSvZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipXHStY7VyBd2NIEIznI4oNaJM5BSFjkPOtLnPfSDzPkgbQiJSxDZMj37z6jBEe8IeZmH/7DD45km8AcQDI+6JvfgAMbMYeMonLzY12HEue+SvXnCqAFaQ8DJMvzBBAABrjuLxDHKXxl5bvzZHqgNjaHNViknFWsR6FUZoNdR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpmMDhJb; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-85b94fe19e2so538951485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759211437; x=1759816237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8OhPkz1QMasSzFJcM2SsPKD0i5kQ3GIw9/NmjM3cWc=;
        b=cpmMDhJbmAAOHG3BSgQtcufOOSarxPB1NFvBRRNTNQmBbEujg9G2ccB6yUkQGV9OuQ
         IB+AomS4L7nj2PAwPuCo6nhN9W+qiHD4YP6REBEC0UlatORKwZpTdhBsGvceR74L7/tF
         VQnwV0S7fkjOJ2aoIJHCr+3TECBaEdFHcrZbr9BA8xlkEkRlMTuuOTmVswLhVpgl3KX1
         EouI5urPMx/1d3WB+1Bbqk09ioLhkSqZt2xiRR4x8w/tz03jH4ThnsaPj4ps0zF45QxV
         NON+Z6PKDuCiXSawoe1YtHIr9E2pyzs8/Nbd+oi3Zq3hymvz5mfskIw1LXKOEfIJr3S1
         waOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211437; x=1759816237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8OhPkz1QMasSzFJcM2SsPKD0i5kQ3GIw9/NmjM3cWc=;
        b=Ts8nen1oJvhPVxhmRolKrR3lvQ5GxZt9BK2Ur6VaQd+XLj0tSR9Frahztp2ZPd+Ahg
         KNdXQoV71m08yituYWkFNqSmVLCJ8q9r6jLTIH/3Fo44LEyT5DpqIsCSItNPTvF3efiV
         7ER7L2l6Gdw9GXnichsN2hQPD9rKepKJDRh21LNtvbKY6xrXa9wa24GyDjgqElbA06dx
         UuV9wCiVNllFFI+o9kn+S4wkajQynYwN8Lkevf/garQ1hbfItHV3Fu+TFHbhp3eGAyjv
         6K34eg9QF1PeRHdKay756/q2QPdexp3lwB9qFtg18ffzPJz/2oTzZmzHGN5dH6cCCImm
         L8bA==
X-Forwarded-Encrypted: i=1; AJvYcCXxsPfQeHQ5J/CAzXBkTnZ4Qq6sY+Ji7lw3PO/uOtrGagAyYh2FhWeMA2d29J8XOPUfzb9vvTjquM/W7Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyG6CxO7sTROXBnd1c65Ei2JY31iHbDM05YMMzy0Ud+Lpz5T/G
	zuIbbGRFLDnPDm/sBkw31NGDrckbhoZ8XfjGZqio9LEa5Y9pPwwg3Zmt
X-Gm-Gg: ASbGncs94z4n8skfFE463Z3wxN0CxjOmJe6v5i5CA+XOJY0CQALKmybj5yXLDNCXKm6
	ltahh0c2JBP2FERS/DBdzqTL1cg2HTBs0mBA37k+EhxhbuiOLc21Aw9t9SrpKhnFhTes1hW8iow
	Pib/Q904JyXs2Wzgk1RPwFDA3Bh7W540/zj7HkWzCnOWafk56Bf6TPSFaeHgnZ1LNsk243XxHQ7
	IFfeAxrKN12vvZGSGxBRUy8BmIAanx2YtIlqjbw0GszH++VO2//TM/Luif6u2q7FS7T7toRvHhG
	0cyVJlkBjMU0nlepCqj24hPRjUZW1kMqTv60iHU19VsbeRlsMBWnQnWB0SBOFIeY2342uhmIesn
	d0zAJeN+ijG+8merrxjDXnwy8D4LDJN3Q85xe7GcPj8reA7Cwy1TvxTM=
X-Google-Smtp-Source: AGHT+IF1NCZYHFGJtQBXZPM7yoZ9n80a/zNf/Zh6Vz1P6UZxNFVTcoi8V03+lauZsiqM2BR9Y4W8fw==
X-Received: by 2002:a05:620a:2904:b0:86e:8d29:4629 with SMTP id af79cd13be357-86e8d294680mr492575185a.80.1759211436821;
        Mon, 29 Sep 2025 22:50:36 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:3981:263c::3cf:53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c306b5f64sm971990985a.32.2025.09.29.22.50.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 22:50:36 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	kever.yang@rock-chips.com,
	naoki@radxa.com,
	honyuenkwun@gmail.com,
	inindev@gmail.com,
	ivan8215145640@gmail.com,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	dsimic@manjaro.org,
	pbrobinson@gmail.com,
	alchark@gmail.com,
	didi.debian@cknow.org,
	jjm2473@gmail.com,
	jbx6244@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Document LinkEase
Date: Tue, 30 Sep 2025 13:50:15 +0800
Message-ID: <20250930055017.67610-2-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930055017.67610-1-jjm2473@gmail.com>
References: <20250930055017.67610-1-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase is a company focusing on the research and development of
network equipment and related software and hardware from Shenzhen.

Add vendor prefix for it.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ec8947dfcad..db496416b250 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -873,6 +873,8 @@ patternProperties:
     description: Lincoln Technology Solutions
   "^lineartechnology,.*":
     description: Linear Technology
+  "^linkease,.*":
+    description: Shenzhen LinkEase Network Technology Co., Ltd.
   "^linksprite,.*":
     description: LinkSprite Technologies, Inc.
   "^linksys,.*":
-- 
2.51.0


