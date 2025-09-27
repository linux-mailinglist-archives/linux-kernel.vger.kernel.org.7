Return-Path: <linux-kernel+bounces-834980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83400BA5F4D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D38D323761
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CA719EEC2;
	Sat, 27 Sep 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYUv+w51"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96DC1E4BE
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758977414; cv=none; b=WAH4GnhMta1W+v5XChoemAKhIMAAaSB91blAxisXOejuPQPo9OhhgO1kXkyCk7gOzfNK+6h/9HBwb9xKdtUjgYarGcPiQp5yzdSc56iKWv9TSB3c/ib4q1O1iGEEF/LBmr13UV9JC0nsmONVukzmH7O3ELwaBLODqo2D9UVAbh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758977414; c=relaxed/simple;
	bh=D2542oNaoMpDO1bW9r88Fw3LdBuOKemDD3iAsb+8pyQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Dv+xn6V+cZdba+/rMe1Bwp+9JUe/Ka949WFWpN1rLJplVAo4gMKcaF/mnhmp8mv/u6RrV8URPST3ejNXjQVFa60EEt363elj2bXas93uRSZ0JL7FGirV1aYHzmCLQrk6UpE+4kGwpE/8+OpT24Ba5kvuhy3bCAg/txksqwLGJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYUv+w51; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so2517748f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758977411; x=1759582211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SDIgvocR7eSGyBef7vxMCGlKJolA7WVr3JO0DUc8Zu4=;
        b=DYUv+w51oGPXgIr0y6VuJhar61xskg9sq7iPbDugw3rFZ3vtnK3xthjW+obf+5GPgU
         QrAHd2GhoPbvP2nfMw7m3TjLUQVvnDHqVEOfC90aDQG4FSgDVyUtY5u/jabQLPt7PEZB
         WV6gZfaVZbYeJYCueZTXWh18FRIaorZ/JlxTGXws9Ja2Vln+niOz+mgV3VnwJHAKhwZY
         f8wkjaZg25i1vA5RrlCqPprq8zrZd//sXCeRHqotm4ihoD0hZSSEjfOK7appONgEUbb9
         HUTeY3ceg9WmGgZqRjy4dxTbdAhVHfYjZ+MSccm6uAeK3GtXK0eGAAaa5WuKnCjqD6oF
         6lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758977411; x=1759582211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDIgvocR7eSGyBef7vxMCGlKJolA7WVr3JO0DUc8Zu4=;
        b=leCwxxEgndfo48rD/9/pK6abp0+eDNdT4v9SOeRuL0Dy9ojRrCwVYuqjM4oV5RiSrU
         kMF5/iKryc3ItJCDfYU51tm81UO/Kigi4mBGOPE35/6SSxpxhkz+HAzb+BWaDM2rHDv0
         2Xi6oXM/0biuJAxOUKkQVS5H75DnYy35inPOLr3os/h1Vqs9JJxvEpDjtC5bm9eBbS0I
         8ND7IoCONL9Cn+DG3MxdGl8fpGlhdP3w+ZAANfIpgbZAqf04hH777/mp3+1HLQtDx5fq
         +XIyciqLGa9FWvOx+KV0MWJUKcqHLNqy442IATyrqzL5xv1WyiPavV/VOwpFG9DbLLGY
         i0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbyKOBZTjYaleyLXeBmxbmkczuL0l9WIM45u+FlVayGnDqCEuyoxTpkOYp8R22bESz8jNLYceG4iesXQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmsaU83ZhNEi+hII23Zfso1I/kUHucqn84KTSzQf2S8i2JG+B
	Oywh9QaYjDttYYXmQvMusYHss8diF6lq1UqdJFnsecOExc7PYglxnE2k
X-Gm-Gg: ASbGncuELSnlhO8VpwKVUmE4s0jgvy6Ech1uxptPLFmC8nm6N4qEE5i9hfHYeqjWEDx
	R3MPFBXqi0vlf3BM9Uz9jobp2kZW9XGWU6d7VtNP28ULhy0PQgXmv2zIFYib6y2j5V6K0rGdzhH
	8AqIeSla/mzIksccuuP6DeFtNZUGKZDx79mLv5yI4YCiJmk9mnKq9XWI0MdgCFzbffjk72iYflt
	zWxsfM1Lcxx22UKrSagNxjlfY0yDvAgkRgOZWS1tCLlLi8C/eRGL4VA4zhEO/Ozr0SFJFCrE7Jh
	OQq7p9Mt0nwCbDXfxd0W2dViE4v+vowrU07ZSrh/a3k5S6sACP2vNMnlDrCTPWwZPQ58pL5UAdq
	1nVOHIIHq2KsKfytqqgVCNtyEgEIrbuil9ZizYg==
X-Google-Smtp-Source: AGHT+IGHl/MrvnBmwYJlng90W0ae6rxBIE9Nf84TxnL8stOE8Xyl9IXCEHjFwJhjKBi77KUw7CW0SQ==
X-Received: by 2002:a05:6000:1ac7:b0:404:2fe4:3a80 with SMTP id ffacd0b85a97d-418069559cbmr2197982f8f.25.1758977410844;
        Sat, 27 Sep 2025 05:50:10 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bede39sm115338255e9.18.2025.09.27.05.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 05:50:10 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add support for Tanix TX9 Pro
Date: Sat, 27 Sep 2025 12:50:05 +0000
Message-Id: <20250927125006.824293-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Oranth Tanix TX9 Pro is an Android STB using the Amlogic S912 chip

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 2a096e060ed3..08d9963fe925 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -134,6 +134,7 @@ properties:
               - libretech,aml-s912-pc
               - minix,neo-u9h
               - nexbox,a1
+              - oranth,tx9-pro
               - tronsmart,vega-s96
               - ugoos,am3
               - videostrong,gxm-kiii-pro
-- 
2.34.1


