Return-Path: <linux-kernel+bounces-849355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 613BCBCFEA1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 04:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36A43AD316
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 02:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216ED1A2392;
	Sun, 12 Oct 2025 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JokoSVAA"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E20F80604
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760235973; cv=none; b=Bj2qsrR/8Pl2WNJwGLr2xWt7Wl8YQSDUETZ9YcI8mvH8nyH4xCua5CdGYTCGIj/l6i334e95pfOYlNJHCWckpoFaNzjMPW6xJSxMye4QPHfWhLknrHst7fA6Ov7fMyHUhWPUuX56i9XD5HMAQr5r5PISwUnLHgt0KFEd+tMN1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760235973; c=relaxed/simple;
	bh=sZlWQ+Ehq+TFmw/e0r2RP5C7hm4PItV+0AnNbZePiLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKRT/p81itoLZElpQMxEziH8Kt+n7oV4cXr01nz38PYYYBa0jItt84+L+dsjWRrSrmCZNnwkqJhzSSFxPKVx+o94I+/dOSFmDh/E+or+uk8IiBxHkEtZKPHdlaCteyIMW641q2aBMLFXRR/YqMl+c/UyaKfsKMbSd/QiVUIu94c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JokoSVAA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781206cce18so3288754b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 19:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760235970; x=1760840770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y+1XwSbsMVPSTNdYmAt47Cu/9qwf4w36EkkfnGxXMU=;
        b=JokoSVAANxfcfKwbiyCU4Bl1bBn/xlnyeoRVRzLnKrh4YGfZyTQokCWWi9NuL646e/
         1M5eKsp29XyQxtzsWbCMq6Uuc7nzkz+7i6z5n3OaNdfAdp/Odnr6ezLUOVDNLb4XFLJH
         qL+SsRYEWLMVgp4mDwAIz4U3JJyOb3RT7arLBQdNASaIXTymt9odpnd7uKcnwqDGgkPQ
         RbQm1YdMlEeJ7lcrcJwNCf8xV9I3yS/nrUzFLsK/La8xYhHlrtktKQaCf/zrZGaFzABk
         630IE+ELR164VYaqEzKnQ59q8z8IDcFcsPsKalrCgo3IZ9BKR0sngJlgDdN0xwM60jAN
         7OLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760235970; x=1760840770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Y+1XwSbsMVPSTNdYmAt47Cu/9qwf4w36EkkfnGxXMU=;
        b=VlBX4a4CXqbwy7a4RftKQ9S+av+cv1D10X+dloOvCitqym2b/zKigCKWCgVZQEZlsx
         mWj8Aa4O2H254HpuWWZo5AanH6YLyDLC4uS0R1q8oW+Bz8iTaroSRb1MgMV7D3Gulf/j
         gDqwUusWoWYfLCQeqQxtVkEtzErCxi81pGzBUK+BJFTP3iAIVfA5cZSO+yESmm7aw+Yf
         WT4IXBG7ugVGtMZHY+/CPc5Yre77b9R8HkwcMgoOa4DkigeKW9BiHoZZLCgk2VAhnTHa
         LRjF1VSEP6U2AfJ/SMeGqdSqwu7TcJKHZ2YcoqweZvIBa/seviRCoSgwTLcvW7yYEomd
         4Vxg==
X-Forwarded-Encrypted: i=1; AJvYcCUwoTXCjcqiQVRxtR4IdMmfGvYqMY/0y40TtLp6HL80bKqZ+xFje/Nkr8aFXSzRK4RuQXj4m4li8Pcq3+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3h29EHkqMkvlzlUxB0mEnFViQlbqncMDbjpLoLg6hAKHuD126
	gbGTzxJI6K51pbaUzPvB2CE371rfxccb0FEct3RNj3gtkB7/ACdEWFln
X-Gm-Gg: ASbGncvSWsKqt4BoCHjEc3NSsLXhKquBEtX+A57jcdIqzuTZofrDUfXW4cVK2P7lIiW
	mljHX7V6lUKeObHybxG0oup3P/lo/hpKd/wWLWXa+bWouJ5ERACovFDA+wvIDk81v1zAEHDqStf
	cJuuXltKWIRB0cFOJNl7PSyimqpE/BazVVeJqALiVMFZCJThOJzkbzyLlp4ZYUzaA8g34P9PtlD
	14z3heu9oQlYMpmnbzQ7wIR3TjE+zZVflzpussKIPMUFKsxI6VueO8A2AhkGiAhBFduti1gopFv
	wa1L3s0OArnZbR82TjqlSd9DdnqssoNqrpMS5M2xNxUrClprOFn5jmsd0eAQ0Io7P63JBHu3ttQ
	ve76cj9TIy20iQBcJplhYQc1jbQUdxKiucIK0YwmV8JJRj+97EkMARGo4OasFTUSvFaJo
X-Google-Smtp-Source: AGHT+IHTAezIVOlurkAg+7C74kvmB+nBt5xlXqzzzPRnJHFMzlSR8jL/NpvTl40u3+f4D1RCNQ2gDg==
X-Received: by 2002:a05:6a20:3d95:b0:278:bc13:d83e with SMTP id adf61e73a8af0-32da8e360e0mr23314655637.11.1760235970292;
        Sat, 11 Oct 2025 19:26:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d9992ddsm7180489b3a.80.2025.10.11.19.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 19:26:09 -0700 (PDT)
From: Longbin Li <looong.bin@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Longbin Li <looong.bin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v1 0/3] riscv: sophgo: add top syscon device for cv18xx
Date: Sun, 12 Oct 2025 10:25:51 +0800
Message-ID: <20251012022555.6240-1-looong.bin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add top syscon device bindings related DTS change for CV1800.

Changed by RFC:

https://lore.kernel.org/all/20250611082452.1218817-1-inochiama@gmail.com/

Longbin Li (3):
  dt-bindings: soc: sophgo: add TOP syscon for CV18XX/SG200X series SoC
  riscv: dts: sophgo: Add syscon node for cv18xx
  riscv: dts: sophgo: Add USB support for cv18xx

 .../soc/sophgo/sophgo,cv1800b-top-syscon.yaml | 59 +++++++++++++++++++
 .../boot/dts/sophgo/cv1800b-milkv-duo.dts     |  5 ++
 arch/riscv/boot/dts/sophgo/cv180x.dtsi        | 42 +++++++++++++
 .../boot/dts/sophgo/cv1812h-huashan-pi.dts    |  5 ++
 .../dts/sophgo/sg2002-licheerv-nano-b.dts     |  5 ++
 5 files changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml

--
2.51.0

