Return-Path: <linux-kernel+bounces-762779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFECB20AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297D018C2AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13AF1E990E;
	Mon, 11 Aug 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1fiqk3b"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33581DFDAB;
	Mon, 11 Aug 2025 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920450; cv=none; b=JbZF46C8nnwnienWNfAOto7hJu5wXV13E590j/f2CM+feYBMNf3juUBnc0yXYHtmX1OnGgYKn7Qk1lOZZ4V4Qou5h+1Wq6i0AmtEec7stMYHyjAt2jTvTAqCZzWmceREfXvfXEei5Y1o1Z86tUn7JPazRay+yIkDMy3muBWdv44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920450; c=relaxed/simple;
	bh=o99NnlKBN0S1UL9crgyLNkOiVsvnLtsC/PZuyUJcXx4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I5rEDkQAwNzZau3E/Qq91tihLtLSaRqf4Ng/DTEl5+4UlKosfLw5J2JnaPY64GOHAFr8hTahEOqS6NCnOn3+zV9DQx0P+HYXKk3sCOJhSz4+6a5eUhhCPulAzKDv4rNhlnLxntK06dDsA0DLGnQmB9tXehZ4C3iDF9fD6BuA8vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1fiqk3b; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23fd91f2f8bso31336875ad.3;
        Mon, 11 Aug 2025 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920448; x=1755525248; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vlj+8st9s1ial1PCaVYqpAW72KD0VvGynWLvNKngKj8=;
        b=E1fiqk3bTtFNwdssnoLs5bglW99RNUFHYM7zu2xeLJrTT804leCKEUzy4T9DR82u3q
         dbdBx/fL2xtyw7gg1U3T7zKGjzStL8+vGp1udy4uvsvJrMfW1tSLwz9fHVo5JhaEt2Mt
         0GRhdkVqF2PnQtnnMxA0Fxhv74bGsaycZswreIC/sjtZdE9BUnzj958ogGNvYIy6xUYu
         34H7EmT2Dfpb/xpTXzl0fUBtLOC96ZqyK3lpsgoyCjbv5wixJiH/aNxepbxIRR3SAo4b
         gVw4MB0OjZsK6AKZUKr7lpzHDQTxuT2JtNkrlxrrg36aDlJWy1BAdbYhJBOo3sLGZUdf
         X38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920448; x=1755525248;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlj+8st9s1ial1PCaVYqpAW72KD0VvGynWLvNKngKj8=;
        b=v1OElPEgd1YpfJK8KHY2FF2XBIMBNU8rY42xANg7WQsH8pccOx2z/Pypkd+hmyDvlV
         DoyHx4DNgsF8EpK3+bGaC96H3Yv0msa5YM41ZBelWJABlKfAVIH+/d+X2lr8m2Kit81A
         HTpDPTHqZvnmG++OVIYPebaVjGLg82noZXd4XaW7Co/RIoDnQnuXK3ruaKXNgRIFtwh1
         DGNojF/LlsNbtekJidJz6jSBV9mibZGyCYCfFIiWQ0cFoPkDGjcukQCNMNO5efRhWH5M
         jOXNiTYy3MhlrMUwQHCE9CE+sYZ71rrjfY8DvOt6qARhZMuWhQUg4QWt3e5vd/zCnOSj
         DSDA==
X-Forwarded-Encrypted: i=1; AJvYcCUgPi+iwJOF1BKkfmX1oGMKX/rUVYZmDMy/yGkWyr0uWv5l5WT+yfeYmM5m4sdTGk9WYuxuAYwtVAXF@vger.kernel.org, AJvYcCXiR/K1oYbkYVnZsgfyFYhRbZPJDYKHdVHT5MdK5iIiqIFR2RLHufGfWDaBY4yP2FACwdYvCDayzWwI1YWA@vger.kernel.org
X-Gm-Message-State: AOJu0YyjOIwaEhM1f33FPrtGLzkCcBx/KZryHcQr2xb2ZG2eWa7StqhR
	8WMMR8dkXQh7OgOqBu95L2Q9Nl5b9wQx5tM+PkNWSIxHW3UzY07s4jzq
X-Gm-Gg: ASbGncv0iwwIQMTs40NqLuBqVf2pVHGiCA7DLWbfwDk7qRcFuDUUt29YDbzYSauqcaa
	syKkwhRF70SrvaEOXKX1pK/Nmo/g+B+kzsAardfdB2bH68R1xxfBubiTDE4xxXr005s61Z2YmGZ
	77D6WWq1oqWAiHykMpSWOucIOR49eLOw1AqQQh7zqIb/3BeSGdalX4M8FQ8M7BIRCrtPRRIq1K7
	AGcBSnkhEil65rsEkHxO4UoRkj31dSbk7orb3PA7OPNEVPnOh0igOj0xSquHrIzs3cNFQ8zWyw8
	+/26WUXAnkaOo0Fa6yiAy/GXbTxsiyi18bryTcMNxa/+s3Xp4026Ab9z5FfYek5vREstFrFdd6h
	O4DR9gSDdBn0l7vOlI9wYVqR5dPObkSlk3ZBgiQdk7Z0t4MM=
X-Google-Smtp-Source: AGHT+IG/FSIkhBsB8MYIghrfDMWXJJBKX4WzLZgOKcea0kw9iCgD5rO28fF7tUtsnoihFXdUVlSIgw==
X-Received: by 2002:a17:903:4b2b:b0:240:70d4:85c3 with SMTP id d9443c01a7336-242c1fdca54mr165046445ad.9.1754920448139;
        Mon, 11 Aug 2025 06:54:08 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-241e899d272sm272976285ad.135.2025.08.11.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:54:07 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 0/3] SPMI dt-bindings and nodes for Apple A11 and T2
 SoCs
Date: Mon, 11 Aug 2025 21:53:54 +0800
Message-Id: <20250811-t8015-spmi-v2-0-a291acf0d469@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPL1mWgC/03Myw6CMBCF4Vchs3ZMrwqsfA/DopQRJpFLWkI0p
 O9uxY3L/yTn2yFSYIpQFzsE2jjyPOVQpwL84KaekLvcoISywqorrqWQFuMyMpa6bFtTddo4gnx
 YAj34dWD3JvfAcZ3D+7A3+V1/zEVU/8wmUWCrvbWuE9JU8taPjp9nP4/QpJQ+g2D6u6QAAAA=
X-Change-ID: 20250527-t8015-spmi-838bb49d34ae
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=o99NnlKBN0S1UL9crgyLNkOiVsvnLtsC/PZuyUJcXx4=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfX7NEpsrFvYewCeECdsNAB5GZ3v50nSN1cVU
 6ovTW5ONaSJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1+wAKCRABygi3psUI
 JHl6D/sGsni5nK8sgiBvYX3HSSA5wnrJInj+GxT1f5lgNRwBZASQDREhEjCGS1Pm9UQMi0mY963
 iww+WaDqU9547lDdszgQptU6/Y+Rs/fspDCY8qO7asJCJJTmHxtajPGRt8s/N4MdPMudBHE1A7A
 ed2s8CLdf2Cw0FkjKJLqBEnIVG+33D4JzKS5VPJftVEHZrs8CL1hV3SkIfhrzBtRC/PrGhFMf5i
 NDGQWSsKJ8Jjz2AU0eulMvjcyIoTq8lVApjq643EB71zdM4jbIUjbxzq0JNmCuLe7h5SVPHiwG4
 BOHCXgWbPwT+4JvIGi9gWLrtsD+IL7zL5V9L7S5IpaPyuaf+XCkYCRIa3BigH5yiATYHfY+MuRZ
 nVg8mrh4AJ92qcqS95eyv9UGxkhwAplv/YufDG7ri73gIAXnA0rc+l0EqrwnNQ1/qEUh6O9L+Tr
 NBB4evbMUob+0lxLefP60bwUWl52d3RWrxLtavnX36WcEPJUVyvnEdjc36uKK1Q5XqzYZWvKK7s
 EQo/JJY+xFtG+DdZM3+hHzerO7bJbDqhf3ABV5V84KJVX5m2/HAsxYWx+8FueKS6Fbkal658On5
 ZIoPo75/93g6s+GxWqRts050MjIPR4RCICNYi9LsP/pbfH18pwTet+OhKR31oWwg8jX21CglMTe
 mm5RBIFvGt9o2gw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Hi,

This series adds dt-bindings and nodes for Apple A11 and T2 SoCs,
and the existing driver appears to be compatible. Drivers for the attached
Dialog DA2422 and DA2449 PMICs will be in a future patch series.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v2:
- Rebased on top of v6.17-rc1
- Collect Rob and Sven's tags
- Link to v1: https://lore.kernel.org/r/20250609-t8015-spmi-v1-0-b3c55ad01491@gmail.com

---
Nick Chan (3):
      dt-bindings: spmi: Add Apple A11 and T2 compatible
      arm64: dts: apple: t8012: Add SPMI node
      arm64: dts: apple: t8015: Add SPMI node

 Documentation/devicetree/bindings/spmi/apple,spmi.yaml | 2 ++
 arch/arm64/boot/dts/apple/t8012.dtsi                   | 8 ++++++++
 arch/arm64/boot/dts/apple/t8015.dtsi                   | 8 ++++++++
 3 files changed, 18 insertions(+)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250527-t8015-spmi-838bb49d34ae

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


