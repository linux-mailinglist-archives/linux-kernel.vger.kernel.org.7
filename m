Return-Path: <linux-kernel+bounces-820174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0756B7D724
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72C477B7714
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC94C2E229F;
	Wed, 17 Sep 2025 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW/AeDVS"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF8D2641CC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095300; cv=none; b=ggPvFl0bLCSN2klmdX69zPQ7JTWPUosOYUYCviIAqXcqyzvhBnQbZm437FY3/JG8zgI+IHuMgiE5MYtj79sQaBV91DNOYfD35CSj34U2L2KTYPo80aYiE1GQ+JdsORBgvOGBX/PT2wWE0RU5M0Nti0LCes9/60Sb5B4+sbvpyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095300; c=relaxed/simple;
	bh=q1jedH7VW832Xucv18MzkJx7Ax885UvbYtoCbR01+Do=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=en7ao88YF7PGL4O+XePQMVkEij2ss60pUCwztcDAn/TdVjjdbxTgV4pqUgGqBgC6eV3yu+pqgyEAL1ScVK9Ja4bqyTZaXNJUB4JXUZUW7XBXJInJQprjPDvq5LK5NOIdriIs1iikyP5F4QzsjvPTkvMvjB4jgbWumf1nHtmkYt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW/AeDVS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-26685d63201so28606595ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758095297; x=1758700097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JKGCDIkSDMV2O6Pn5OGiCTad+ltyhYyD3CS3WAtyS8=;
        b=NW/AeDVSvPMv6HOvIrK7/W7P7L3+jrO7sitY2UPXELXTOuLM2BboZNmd9Zkqcmi5xi
         bm8ouAhXRD+LaN1bLbX7oOomFGe/g/0P5nJyHHdmJ0uko7SBMU0YNKSiAqFDOAUe2PP5
         4I0Jd+yYR5UumGUP9h7LNqQoeJTrUxgm3lKGG2E8VkTqjFcfv7XuAqYrWmkmtsJgJeTC
         68vfCixdtXmW6TRqy2Ey3uy5xAmvV6T0BFZplB1n/hheBI+Bq7+DJnT7KFuVurTrgB4Q
         WespxxB9x5gbaEKVyWxHl0481qGFQJn09vVItHqQu6VzpL8E4F7au5qlah1sCDYpecPx
         09dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095297; x=1758700097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JKGCDIkSDMV2O6Pn5OGiCTad+ltyhYyD3CS3WAtyS8=;
        b=H93nthArroM10duoDKXPLbQAAOL6RkxZkh0LPz6rg3+SCPWdB70P3L+/LpiJS7ffrD
         2nLhTyzAPsllCGZVIY0JE+jt3lw8uHBbuGT8MW5zKxJAMTBKza5biOhCtrJ32ScP3eTz
         m1EVz/RY8tM+obwwhqrufQbx3scKmHVeg3sasUtCm3JBiP+VI00xOYdHjD9mMw6FwBAA
         MvBJEkjKzW5TINd9gvj+3/bPNHEdNgWvlFbCdhlriNJ/X3VfewOhhTSOc3qe4i38nk9U
         H+6SAeKVhm6aA7b97dSYYwG6jtqLATVi6QHpBj6WtesFHm9BNo5S5eWU9HQHMDj4wLT+
         U+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUsC9RV2CVJt43YGrHLyRE0aQuABPW92MFlEfJsznjcpZVyY0v8hJczWEt0yRko1AUEQSI7rcfCm3eEC78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbodBYUYplujwnFcDfgAOs5jc8HRMxRDE3D61+hoap1oylkZX0
	4zUaM0asxzCS2l9vLogdZE5zcMzNG+N7jXQ6bSyw6gdVHZZ1AVfxttJl
X-Gm-Gg: ASbGncuUz/E0j2538gR21pXdyi44NVV9Meqffc3oTjQZVT7KjDHV0GSyLzrIkWMd3h4
	DykvLEVT5lgCXK+Ktt7zW9518TkFR4cfLX2g/1cwDzUE/8UPEtAxyjOuofews6QJMJT7WQybecx
	5rJr25lMLJiqGQeQ5Q15Xkn2idfAm56VwkWPjtKa12OAPI/9Wa+xaiLdUqd5F8MWGIg6TEfBKlD
	p8JaWdfOpXJMow2rimo1f7HMRItJvQ6FbYucX+moNrXjtm0a6S6N7w1MUnPyYeEJjyiDSMunyX8
	URE8xiahJygkZd3VTttYXN3FMscB6O2EB8doU0Pn+1BOkrhJLoqBcC+LdMswiCm4zwr8InHkdNi
	ljKA1WBiCtl9H52RgwinGK4dJNKWHSUCq0wD1rQFLUOPOHVbLGCgh1AUFgoM3GV3WgRu/wfheh4
	a4rtM7eMT6EDx1+peY2usxgeMBgwd5gcb6Vp+kjhoXqg==
X-Google-Smtp-Source: AGHT+IF3iFCqidqJcvK/xXuEBMbUNqvYtrcapIiOCibgP1M/29Qz0m2dsrVVMS/TbfoPK18iCzQjMg==
X-Received: by 2002:a17:903:19d0:b0:25c:25f1:542d with SMTP id d9443c01a7336-268137f2336mr13981925ad.36.1758095297176;
        Wed, 17 Sep 2025 00:48:17 -0700 (PDT)
Received: from meta-device (2001-b400-e359-6d3b-3881-d7b4-5e6b-c23a.emome-ip6.hinet.net. [2001:b400:e359:6d3b:3881:d7b4:5e6b:c23a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267df817ef5sm34796585ad.0.2025.09.17.00.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:48:16 -0700 (PDT)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v1 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
Date: Wed, 17 Sep 2025 15:48:08 +0800
Message-ID: <20250917074812.4042797-1-kevin.tung.openbmc@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Add device tree for the Meta (Facebook) Yosemite5 compute node,
based on the AST2600 BMC.

The Yosemite5 platform provides monitoring of voltages, power,
temperatures, and other critical parameters across the motherboard,
CXL board, E1.S expansion board, and NIC components. The BMC also
logs relevant events and performs appropriate system actions in
response to abnormal conditions.

Kevin Tung (2):
  dt-bindings: arm: aspeed: add Meta Yosemite5 board
  ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 .../aspeed/aspeed-bmc-facebook-yosemite5.dts  | 1063 +++++++++++++++++
 2 files changed, 1064 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts

-- 
2.47.1


