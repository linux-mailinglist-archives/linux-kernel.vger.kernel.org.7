Return-Path: <linux-kernel+bounces-851823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A976CBD75F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB96B18A7B29
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759892798FA;
	Tue, 14 Oct 2025 05:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtDBnnKl"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5B23B62C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760418799; cv=none; b=de885J8pRCZNpop2KLDFTjQtLQOWOzid06uvA+JKn1kQ38HDqhP6SXujaYfnNnSxyf0raflQu7Wy3/YWMkkcNXm9VR4K+9+ZhFSjrKO31SeWdsmkVYeMN61CYbuorP/haG8y5lecRjFjqafDMDYCaQFK7KljHL2u7T/6tTUdsrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760418799; c=relaxed/simple;
	bh=i8ILy3efLeOoD5Qf+e/n7DFmvbPzfKevH825MWgSvZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riNmdhzPWKpTeE+sC0lp7PLNWzOsryvvbB5FosENSHmIW/ckUKnvOfka09eOjdpNKl9K43kZVKj+QQukl+CD+8uJDbVenS85uHK4VM1Nyfry3SwsQKWyPR17py9wmXUxHjXfb6h4SJkHeCbmv1H5ksggRD/9zhWOXIWAGEk0SGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtDBnnKl; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-330a4d4359bso4107698a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760418797; x=1761023597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8OhPkz1QMasSzFJcM2SsPKD0i5kQ3GIw9/NmjM3cWc=;
        b=HtDBnnKlvZwOgcjNHxslP9x3jWR8AOGBQRZzaEJI0mB6aOsW2q13ti1CZDTHwsvVTv
         zvlGzZZP2miUIn4DONyPMlxSRrqNGXRI7w8UW68pC9tqRBzR3PDqZwhkq87bWMA5wYM0
         fcYEREolVHr3xq88t7DinWPVpzHuRsDnYfx4/A+gLH02oDVuwT18FUN06Uj2iI8tmcOQ
         U4xEWH5cZ+LV/lW0F2/yWncyO96/35teiNwSRXrgxrx3d2tGzQFPhYJEAFPcWX/jSiD+
         kR8fzc/fe/34oqblO8U5nRU3XtPcQ6mouuxxs/MFrdSF3kUXj+QaEbQ4pOrMnYr/w3wr
         1wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760418797; x=1761023597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8OhPkz1QMasSzFJcM2SsPKD0i5kQ3GIw9/NmjM3cWc=;
        b=j5SvurnR5yEOSKHJM1PIcDDxRLCNqUoyQPm7vZJoHvqyfPSUJcGDscHLVaV8jO9NT/
         M9kWRKi+AT7Sw1yhG4e80i4CUD5fLMDzoyp2VA4bmzhMALBG8DO8EHZHY8GgulxX/H2B
         Irp+sxmj/RyCB2rR9CWA0+REBCupYEaLPV0i5AKxbGUK/fDOSXkUB3QEJ96+m5sjzWUK
         PCi3ZbScHJ1158qpVWJlislt1tqaf5cpteLLX85cYPt0zyrSe6D+kN+ilJ+K3s3d+wrp
         rQK1RUOq3PWUVUEvuIkpLpPJIqOd065wYQRm2uQGDX6zxNRskl+O16YluqSRMsckaTgx
         I0jw==
X-Forwarded-Encrypted: i=1; AJvYcCWfD60oGrMcRnLv2/KCYtIz1ynRB3HmJpz0dw5KcxMj8/Loqgr6RuynshkGMfX7sEVEv9qjFjWqZ3fVV5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+/cQmFeSixPRZYw7XHDN2O7iSZ8id+gycCsqqNl56ppgwAAK
	TD+nHFS5T/sr/uTocksE/DGxT4y0eiJbz/hSZLrFmfG3dHCsV8GJgB5T
X-Gm-Gg: ASbGnctb68l/LfYxT19k9Gy8VtCG5WBN2VhziJGfiPG1QCig4j1JxZTl85nBbLZjd1U
	pacNbG1eUnA6J+W0lQX4yh+85wDNczYHtjrOZmGjEstQR/I1f2eTFY0dyWYJhBSPomgyWUUE/qV
	fBFf5Mv/p7dxstZj48NFAGBKyspdxXzNrPsds3i0U/+abpYxDP0eTDscvRPVVZUDYJmen9fEHwg
	hFL6vohGJ94D6UkPYJbznI8JdNT8kCt0mRs9KrP6nAIchC07o4RCn4HQOvtR1yYWa/EOMIhFksr
	emIzdecKvim9YHkAzloTVeBnEZRNN6vZWAEa7e6hS41fNeH1FQ/qPVA0OJ9qDhQhkbjO3r+knuI
	74/nRtwoy89s001c2kveVcJgH2ZiHEAbI/nvRuEjbUIDWKCyTqj0mI2oyYMxD9SnKYQ==
X-Google-Smtp-Source: AGHT+IH97JkKWq6pRYrkp4vvzMtmr+mAWYEE+sx6Tl0wnrhQDndiVYomTi6Q/s8WM6+VsXjBNCVvUQ==
X-Received: by 2002:a17:90b:38cc:b0:329:e2b1:def3 with SMTP id 98e67ed59e1d1-33b51168d95mr31720007a91.10.1760418796529;
        Mon, 13 Oct 2025 22:13:16 -0700 (PDT)
Received: from localhost.localdomain ([223.74.108.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678ddce4b6sm10902353a12.13.2025.10.13.22.13.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 22:13:16 -0700 (PDT)
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
	jbx6244@gmail.com,
	andrew@lunn.ch
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/3] dt-bindings: vendor-prefixes: Document LinkEase
Date: Tue, 14 Oct 2025 13:12:24 +0800
Message-ID: <20251014051226.64255-2-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014051226.64255-1-jjm2473@gmail.com>
References: <20251014051226.64255-1-jjm2473@gmail.com>
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


