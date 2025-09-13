Return-Path: <linux-kernel+bounces-815348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B95B56321
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C10189E384
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC47728003A;
	Sat, 13 Sep 2025 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCixbt7L"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB1E2367A8
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798487; cv=none; b=AqtZXdTC+yKuxLqYjK2UbC3D8CZ6bkQvZFTQO4KC9CEdK+Ct4RUvB5pIhVFMk/eHbHgH6SiQsYz718HQyxzHnn2m/f9qRYD5PrEJlR7PHfnTP7a7t407z5LJAcxKCl428BFpZ94tqo9IYaGJx8pawZ/Ccp5Z9iRzyjGZ67Dd14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798487; c=relaxed/simple;
	bh=TYNRK4+bphtWM7te51Y2NO2PW29CFLfANZF+pOwh/qQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XERt36TSCrHhP6JH2C1TBJctvrk5auis/3S7fF7iBd7tIb1QS8w/sLc2KB9D4nGgBjThAnMQxFwWy2wLPUR6CEO5Crgfien4WJcxBAFla+8MW/qu+3502U9D5lB/5x6k9ApU11M+OZxKvEdnMMfwC+WmDV1EtDufl+0NFkEkbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCixbt7L; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso23212295e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798484; x=1758403284; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUfEoumCbzIEx8AGvj96Z7JPRJbPQvAkGwx1CilBgwE=;
        b=eCixbt7LOfEiH+E5nkfZgb4/8nLdEDQTSesLwxt0ZVhx8Ng9bPN9Py8eC4Ej5DLt29
         UeJdh5Gfc/foh5++YOHuousrgQOWpnO9eyPuo0uKs4aZKdAS8oZhRB7ySaQvN5tAcH3T
         HP1x427+quB6qwnpkqdAn9WgF179YfFELVdFLFZ+gDutnSA67i/3+jZCVcY+F+f3fsTk
         KbV7kFwFvzZYX8DyIKk485iXapkza9+1OHysvXLyUCedSPs8yOyf0yMG5IFLwtZ8cdNS
         1wEzHME5gUgPL6N+f9FzsQiNwdTKnJpUKr7VFrAKnOXTfZD5fLBvhXTnR5VPK+L9qRdG
         oB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798484; x=1758403284;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUfEoumCbzIEx8AGvj96Z7JPRJbPQvAkGwx1CilBgwE=;
        b=vDD9BnYgi5EN8UM9dWKejVMAs7RRgPFSxTxHGW6ABscEmIH8v6+MZE15oKynSIvwLk
         fA/G4OnT4Bzhf7R1YZ/n915j1WdSrHxl26eMGhnFtNC+3HpnKh4qZcxs/0eewr0/W1Xq
         ktyRnLlp/I0r4XxaGBMBlCF1MCD0RD9XZwahurtMgqVKXVYsAZWLc0mlZlyshislKIGN
         Y78dORoovt2cb5vpOVuAf4N7azZeujGabc6AWAF3+jvVJj7VVxhoEt3pH+TAJV7wtn5M
         IncX5/JNKSFEnjNTq7mvtAE/m3ejWmEoNZazHx5drNjXC2mByF4qmATjoU4fkj0hAV/w
         IcLw==
X-Forwarded-Encrypted: i=1; AJvYcCXHRmJ8rikssiLx8wpQsElxKdIC93ubXeuLBnBc7llGfrWcxHHw2dX7lxQrzixEYd5bRrAc0GykbymlhXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLMTSi7BWWrOJ49WXCsVmWE/GDdKUdnx+qQRDIBye0ND8e6am
	9i6pL5rqHIQeH55WjSImr0x1XSYmTNlsxHg/2S9GrFfgu9U2bGzn4QjE
X-Gm-Gg: ASbGncsB4XCy9mzyYUqyzRY8Jji9x1Tr0ezw3+kW6SjIWPIcfdxiwai6w9UcaQTgYr1
	z6ZLlGgYO0ol872CzdhF8yfVlA+6jJP19jRG/zK3hBlpJYqgAcCmnonZZJhCgetvmdIPWeXrgdU
	9cHV8lZsgpmOBQmV/V+6ldvZT64Y/oRp/FQEq+G4LkSBIRwp/FQcAL9WNfa5KXNynvHXi8I1lqZ
	kSDGcH4F0ImH9yO7QI7M+qjpZ7ncoP7kgooUT4MQlzfrYX9iPeC4IkiuOVdWkq8ZbHBtu9wM178
	OutqDUX3ubRzRZLR/3PEY3j5MXOf4B7qPwUDuj8M9eE6MsffPABU/vKIu+7qJKNUpKcS+VmajpA
	fcrxtGoWUDZHs62DIFStXF++ciryLchkLRWjsCfyer7d3hCfqvHdw
X-Google-Smtp-Source: AGHT+IG1Lbyz/LuhSCMvFaFvWIQA+e+oeS+V5WfPI22yr5MxxdIQ2TC5LggKVWnkSIrVed1aQHOliw==
X-Received: by 2002:a7b:ca5a:0:b0:45d:e0cf:41c9 with SMTP id 5b1f17b1804b1-45f211f89d6mr50232345e9.22.1757798483764;
        Sat, 13 Sep 2025 14:21:23 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd6absm11576842f8f.34.2025.09.13.14.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:21:22 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Subject: [PATCH RESEND 0/9] samsung,coreprimevelte DTS additions
Date: Sat, 13 Sep 2025 23:21:02 +0200
Message-Id: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=TYNRK4+bphtWM7te51Y2NO2PW29CFLfANZF+pOwh/qQ=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlHH/jV+J233T/1YRr7LA/+q+zzuV2uNy35qlfiltS9f
 7PmHwmdjlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZgIexPDXzGZg+FHP2t9rNgW
 nql9ZntQ4APjT2v3POL9smtm9o0HgUwMf2Wkwv6F2M472b7v/66Tv1cwKEc9YfYV6PBy/Faiyt6
 1kBUA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

This series adds some hardware support for the PXA1908 SoC and
samsung,coreprimevelte board which has accumulated before the initial
support series was merged.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Duje Mihanović (9):
      arm64: dts: marvell: samsung,coreprimevelte: Add backlight
      arm64: dts: marvell: samsung,coreprimevelte: Correct CD GPIO
      arm64: dts: marvell: samsung,coreprimevelte: Enable eMMC
      arm64: dts: marvell: pxa1908: Add PWMs
      arm64: dts: marvell: samsung,coreprimevelte: Add vibrator
      arm64: dts: marvell: pxa1908: Move ramoops to SoC dtsi
      arm64: dts: marvell: samsung,coreprimevelte: Drop some reserved memory
      arm64: dts: marvell: samsung,coreprimevelte: Fill in memory node
      arm64: dts: marvell: samsung,coreprimevelte: Add USB connector

 .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 157 ++++++++++++++++-----
 arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi       |  46 ++++++
 2 files changed, 169 insertions(+), 34 deletions(-)
---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250902-pxa1908-dts-65d86a5d2d85

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>


