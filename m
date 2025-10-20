Return-Path: <linux-kernel+bounces-860375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F3998BEFFE5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E016343D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99D22EC0A0;
	Mon, 20 Oct 2025 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3+XLvL7"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20E21F1517
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949556; cv=none; b=HCa+1ROwc2KpcXKsx9PuUgwFnw5kdKAOvIKUJ0Di1KYkHVdOzar+h4U7OV0Pe3U+aNXYHP8lQ++uTTLw7Z6iHAyj9ar8VdDazvGBuHbKkgV/6YLZeFewCghQFQtE5ioAsnS+zaqLhWpHbvUmFEcSunrgfIbeFWtehQVyUmQ/ZFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949556; c=relaxed/simple;
	bh=Ln1cpTJYDMfYJSK2ETGhBkeC8n5lFPLWaYaKEejfbjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lwh0GMisKe7tn7ZTIxCuLpgXwfk5LY7sjdQzCZG1haW8ZxwlRPBqSvqa79PhdOm/LaXbwnB/4hMgC7tCftWQ/szKSKRWOn3Z1MDONEwIPVQ8BgEKpDJodAx78RZqKAAcclJt3G68YTCF2zaSR7DjXRPcDVN2Mmv3T03WXOpeIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3+XLvL7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-791c287c10dso3153353b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760949553; x=1761554353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lC0+koW9LqBuD2DjLYQLY3ByhReVTR9v1Ofuem5KTnM=;
        b=M3+XLvL7V8KX9SrVY5ChmjC+lrZgcdH1JjukLvndceOTSBPwnQxT2ndzWjRDOqqq7K
         wU7bISEkycH12Q6tXx6WJ4GWA3w7vjeZAobYx09usHMVeldkwklJwowm14EJmvG8GWX7
         VvEKIlYOAthb5lub1jMI29LHvPEtXGKJAy6Z/HaFT3eu5K79kYeiWu4P5vp88/e7LPfZ
         YtaIaFqQWe5HEU1SC5n1os03HtFXwlRy69dFv5ITc5kwmvk6uUMjz6q3Bi0dfP+LOBii
         ESjrEGZMLHhiRr5Cm5gEoxNqn+wnd0eU4Jq5cyi3az/6kBmJNICgjbzJvX5kZS3hucsl
         Cr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760949553; x=1761554353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lC0+koW9LqBuD2DjLYQLY3ByhReVTR9v1Ofuem5KTnM=;
        b=ZRVrJeI8DOj0mfMCOtwbUISc12hPPEvUy4OhhNHQ9tdEGTjXEjHa/mfhNhxTUtdYRm
         T965Ik1y3WrQH9zplPmeohmczvH4LWIPvm5ngocctA3KgBrZKk369NeY6RoeQrBQbxeu
         vY9+odxRTEyuwMZPuWJBf+DFX0OZbcvnAHOtnTCzA6WNddqjgFXa/A6gthSguB62//Rt
         4AqnKiplYhkaxq5/wzmAxbtTk6HMIqTiM6Cc6KOBqWYRjjDiMpKWTbZ1WJeYSpXKsmwy
         6OAsKzdPa1i+jrBFudQ50sX2BlJfBwfiP2meFLa1RcK2yZp2sIxH3DTdFUdIbUfgiufE
         mxXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw5Lcm218kJKTB928kff/x9lSSl+CoTKXIiDlzKdWFqL/gFCZ29OfmxqSJVcCbdQ5WKbWq+FYKLsl2jsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0IUd8uGloy0OU3iZ99HdNlFpmoz9Ityw4yzlfpyxJPDxKqaE
	eGo+hZrd7LTEs18UW0EoPf/DrHgXtszLe0YXAttZ0ZgAHqw4vKvRzHGa
X-Gm-Gg: ASbGncs4rJcfSKPsrm/zoqQCaYDIlLWA9+GYa+VfxTJ2eBo12UiI1xUUKbG6KhyHE67
	dtoo1R/EPGuL91HxvBHYIwXIjLJEzrU8+qwHfiuqmUEBoxGehTffnrPQdofolQif60F1KkqYbDk
	rYNfNF35q21UJmaDGhbfVDHqcqZRdIzArmcgH0Ng1bkgTUHZOuFO03/vrXN4avkyHeDcFXEIWxz
	mhKAHtPSs/j5I+1HpW0VtUHSyJNuafiggeFwHniXh9NgDfpP/yVZWhAFVW9E1TCeKochL1jRxTa
	L3na+bS9ACIE20BmIopJMVLrKaEtUo7/w5/7ga9BZXZxvWZ80wch+jvqjSgVzS3aBEQPfuxOOHe
	ugY3Tav2bs85J1/HZH+Y1pIlgnkHh4BnmZzoPDrGgsOFKC/m30YhaCVEoig3cpr1i3ZlsQ5IoKy
	Mtaln95PUQYP30tWP5
X-Google-Smtp-Source: AGHT+IFfolMgNTgrjg6QCUPSwye2gWTgy0cB2CyUntFytqmxf6KYJJHGK5kXGlssp1Efpt+QdGtvtQ==
X-Received: by 2002:a05:6a20:9144:b0:2f4:f041:a065 with SMTP id adf61e73a8af0-334a86103e8mr16827774637.38.1760949552820;
        Mon, 20 Oct 2025 01:39:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b5d0b4sm7062386a12.29.2025.10.20.01.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:39:12 -0700 (PDT)
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
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: Longbin Li <looong.bin@gmail.com>,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/3] riscv: sophgo: add top syscon device for cv18xx
Date: Mon, 20 Oct 2025 16:38:30 +0800
Message-ID: <20251020083838.67522-1-looong.bin@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add top syscon device bindings related DTS change for CV1800.

---

Changes in v2:

  - Add ranges property.
  - Use proper regex in patternProperties.
  - Add complete example including child nodes.

Changes in v1:

  - https://lore.kernel.org/all/20251012022555.6240-1-looong.bin@gmail.com/

Changed by RFC:

  - https://lore.kernel.org/all/20250611082452.1218817-1-inochiama@gmail.com/
---

Longbin Li (3):
  dt-bindings: soc: sophgo: add TOP syscon for CV18XX/SG200X series SoC
  riscv: dts: sophgo: Add syscon node for cv18xx
  riscv: dts: sophgo: Add USB support for cv18xx

 .../soc/sophgo/sophgo,cv1800b-top-syscon.yaml | 81 +++++++++++++++++++
 .../boot/dts/sophgo/cv1800b-milkv-duo.dts     |  5 ++
 arch/riscv/boot/dts/sophgo/cv180x.dtsi        | 42 ++++++++++
 .../boot/dts/sophgo/cv1812h-huashan-pi.dts    |  5 ++
 .../dts/sophgo/sg2002-licheerv-nano-b.dts     |  5 ++
 5 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml

--
2.51.0

