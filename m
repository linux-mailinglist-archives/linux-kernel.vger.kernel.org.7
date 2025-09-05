Return-Path: <linux-kernel+bounces-802954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B64B458D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3F85C1FEC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC252BEC28;
	Fri,  5 Sep 2025 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1a+VTHi"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6AB34F485;
	Fri,  5 Sep 2025 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078699; cv=none; b=COCALY0b1RiCFJMTntwpz4pt0ytHFu1MzPyCcHvjlGDno52Y+Lx1qvTKR8hjc0mZBuX078Bx1L+mUf4mNfu4DiNB+ZV3q54yk2DOH9Yq25mywBHcLUivXsaMwRO3o9XE6GAxsrnja7pYkJT9sAW3PfZlZgq11/X9rqTALCbrwpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078699; c=relaxed/simple;
	bh=BYXgjrfETWBC94bq+gRzSrmYuVcnmIm21cNjnYQZRbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DtllRYUpe+DNcECh9kzLnHFpsD6heTVIyCpVrNin9t5Wgzb89DaAfvatecZgUFXHRVBrknTGvILe4p+jHcRlHf9H+LMWDYDI9IPRxUWTtSyJgrUeX/wQy0AAD09vUZ/YDz+pV/cSQuaZb6Zxcq9uqvLaz9KXk56rvNqtZYK/+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1a+VTHi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24cdbeca71eso10141705ad.2;
        Fri, 05 Sep 2025 06:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757078697; x=1757683497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUZ+q+JJg13FrFHzy6ZfeYtYvRdE7r/MNLwJRgdnPng=;
        b=b1a+VTHiSkxGKo5/34IAmv7spKyKDjNcHrKNbLwLTwL1U9JoFmZs0nQFLkOImqk5fc
         pUM/FBWFR+OQ8PJS6KpUF2s6qGOZYQBxPF/fJXDd7Dm3dBmSw40ScgSy6ayyZCHoIGHh
         51AALkWvq7A1zYWOOO4wBLqrra0RvzB4+8/8GZUy51gFFn+x5n10elbIFq0ZXrBU/zeo
         tr8XRl7nCANY/4F/O+fXjxY2jzbFBYf7UVyWp19hDVN2NIonkcKa0Z0yDDrreQ+gD066
         jJwYfkiKB3ianbWu1l08HmHDOdYDa1U7YA/AlIOjNgOXInTFqoVei1VIuGYnrczkGfU/
         Ghtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078697; x=1757683497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUZ+q+JJg13FrFHzy6ZfeYtYvRdE7r/MNLwJRgdnPng=;
        b=pBtS12WnKjCJEB608uYwIYquKOIut3qqBlbow4DhiSJfxUwZrkJWhxv+9LF1sfa3xV
         fuj1yGtI2LyKXML6YyO5ohA4lqMVt+OYkYDtIP5vGT+v1Xe4n0xGlLquei9iG26UcCTK
         29yvaWVhC7Q1YErAqZd5Bblil4ozUhzIvtOGvJAtqJwREETWn8mwRFpOLriWrpVALk5m
         qZBpdu9HqyFwWgQRnUFhpsAqVb5oiURXOpXuYMoL0Y/Zt6kLZziC9Fh710MfTqFmclg9
         wt+OSd6VltxVH+TD2ZSu9xlSuVwCzg/Xj0+h5yhp+EluDBv4Sk9tV4MbKS+NxqsnZD7Q
         Ph3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWTk6jqJ3ZCxxtYyD+4eatsrRfV61AIdNf3+8q0/iEp1C2s3x/x4ApJauIn5Aa/Fy/NlGZWjX8GtVNFUy/@vger.kernel.org, AJvYcCWAkm9gejUhR3YMNIuWtKEMt3PWWv218Xjcx4lx50TCK9x7ebr7QSZBymyHfP12D8hkzNdiJwhW9BAv@vger.kernel.org, AJvYcCWTsj2gQDEEWeqdoI/fQX28L7GoMhar1pdMoXZqBXAOClVGjdfYwbqxADq1eFN/7Qcf66Pl91qmI+VQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LL3ZZ8Yk4iQUK6iXHxZFQ6HsRb550DIqc/on4PN3xz2IiTul
	6sIEIIvBTEq9GWqrIxj4H3gdz+dyR1Q5d0PkU+1V/Q793frsJKhPNg50
X-Gm-Gg: ASbGncunjrn3hyKf8q07ZUDKwKIXxnHHkg/DLaw09v0g0ZRer+4qa0I78nBpyqZymgt
	Lr8PFPFbqUraeVdast5JDCo51Mu87/H+iklC6OULCByhEkoMGxKZ6dOmAOzwm7ai5nJa1ACoMbv
	fa8r2+RSnFAayRYombiU/leV/IB2JcUhFNg7u0OSfv8TlKjrflOJySN7I9Qbq7be4kphXYmdKZi
	bg4oBLDgMpUVwaCnVUWTT/swUA/wXhJVzdYZzVmls08MSeItaoRfkqHLAEao4JiJsKNrDqqkyqh
	1rKaO5hagFYqLp1/oLvXCbgRRw90LvSeQTOzms2AT4ts90k0A78zYqwRSQYV3OlvDsK/oMkbWDH
	b2IO61XwUq/J72NawVwkRa/aQviF/+9qQ
X-Google-Smtp-Source: AGHT+IGUYvJbv28CQfw0PH02I1cEnjbK4o/GeReRVwIEuFF3MpQPaqUM8HGBojCALZS/4ClS+kWakA==
X-Received: by 2002:a17:903:32c3:b0:24c:8af7:6b06 with SMTP id d9443c01a7336-24c8af77cb4mr147770415ad.21.1757078697048;
        Fri, 05 Sep 2025 06:24:57 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c8945d8d4sm76447955ad.127.2025.09.05.06.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:24:56 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v1 0/4] clk/rockchip: Fix I2S 8CH mclk output for RK3368
Date: Fri,  5 Sep 2025 21:23:24 +0800
Message-ID: <20250905132328.9859-1-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I2S 8CH needs assign correct clock to output frequency wanted, this
serial fix it.

These changes were tested on a RK3368-based board with es8316 codec [1],
playback function is good.

[1] https://ieiao.github.io/wiki/embedded-dev/rockchip/rk3368

Tested-by: WeiHao Li <cn.liweihao@gmail.com>
Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>

WeiHao Li (4):
  clk: rockchip: rk3368: fix SCLK_I2S_8CH_OUT flags
  dt-bindings: clock: rk3368: add CLK_I2S_8CH_PRE and CLK_I2S_8CH_FRAC
  clk: rockchip: rk3368: use clock ids CLK_I2S_8CH_PRE and
    CLK_I2S_8CH_FRAC
  arm64: dts: rockchip: Assign I2S 8 channel clock for rk3368

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 ++
 drivers/clk/rockchip/clk-rk3368.c        | 6 +++---
 include/dt-bindings/clock/rk3368-cru.h   | 3 +++
 3 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.39.5


