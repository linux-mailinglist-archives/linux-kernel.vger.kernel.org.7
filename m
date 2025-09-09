Return-Path: <linux-kernel+bounces-809084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA46B5084B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9D61C65FFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C75F25BEE1;
	Tue,  9 Sep 2025 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiUByit2"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECE31D380;
	Tue,  9 Sep 2025 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453887; cv=none; b=i5VZWZ0ovFVkHS4/UuCAMON+4g7bjYG3HWe94nHQ93oCmoGPfyRuN/+HtR/PJNe0LncLqLKdj6lC8ffvXUGoLlsuWHKsnbyk03oH1/UZ4xFFBSpBh31ncFlLohvsIywMUZJVbRCofCSgdtMsk0huhowKV3RZw5iN94WCK6IUr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453887; c=relaxed/simple;
	bh=+KlaB2ZRUlkXAjDQ0cgQArXWIVoa1KUG/Gd4ELTPYiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkFOq258Xg4bPeUiGykboznBaKgXADHZIt93xgS1t03XEG/FSqHvhcFaiKAjUWKKK8qcnyCrXwnrGSpqfQKf25qipw49kr6agJnTGaxTmFkF+oIJ+qeg9VCNm0VG2xjQ9HafYe9Mtaj00JB4ul47aV/9+k9lS0wHltV6FID4y1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiUByit2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso13183895e9.3;
        Tue, 09 Sep 2025 14:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757453884; x=1758058684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9bRzHx5EoiydheNT5Yf/8MPbvT1DEWaavIvj84zoZs=;
        b=FiUByit2jNW4OuZZRdVJGxZPw4sTGaz/7HcLxEhjF9cXBUKWlkdN3ZuPSRFB7QqNb6
         4ET5fOK1Hbj37ujC4s8265jBiOzX83GHX6RCGtJURFSz6ts77KK6S4/wAHjte4EfkYU3
         Mm2FRSYV9BDH+wd7auinGOUp/NYE5HFmRqJ/tlvJ3Fd6XnoCXeaxD/MX5qxwCvMnSRHP
         0KD72ItdgovunyyTFHkB/YCPG8r3OFRB9CT5fgm3p4ej1bA3Y1ZNTgNO5oB0WkUhTPCX
         Q3PMSnZgLz17/P7nJWnL4oqRCEh5XDGdRCW2G8w04yRexSdrzsMo+n/Sg0PeSlYEYwqp
         yn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453884; x=1758058684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9bRzHx5EoiydheNT5Yf/8MPbvT1DEWaavIvj84zoZs=;
        b=HnSXMYZ+dRRLOiXo0VnJOHb1OmJpHHiMdMETt4P+GOzP+xVYq4ky4SbG4khK3t1h6A
         fMvCXUexkdnrShjVjToAR9PsCJVrCbqmhZMvTYamNDiyRioB2MSg011OyJva56cb0JFY
         xdMSXEKEFQvO+U6CIa3wq54Xkqd9l4wTwcZD+KTjQ4utq5AuQxZeuOE8zCvm+1M+FckI
         vFetcl6coPUpwPc4Uf6uWl3uJz2Kek5h4HncFEoPVLwaBvKur/wq821wLVqp411GFPwa
         VvKwgVae8K9DJonZB21lwN+MhsOxfgpdyLn8OJYovjVA2uIdCWnqZgFx1Df2dkRDp6Gi
         o1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUfN8yXOwfIiFwLwjpVahxdFUrU8mLUgwgbQd13W3pEgmIrenN6oXe2PNlT7aUmDArv9PMGmbM/tvdw/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk8+x8aBj5AbmchU+2AHNnZMy89qSqrzkxary/ZN8RSYUgoWlJ
	0gZ0X5Amp9Duo7szO0dErcMp3qHQVMsn0eb0i+ie0yPPkybkliHU7huf/IAMFm8n
X-Gm-Gg: ASbGncujazm34hLaZJ/qYtzNeiR+JnqDIAdZ0ajTd9aQM4XJAR7xgVjpjsURhDMGIwL
	CkGgfgSoOMflkt/VEsYO0Tl2cg9epzkyJr33snGZyL2AmgrAuBolwgoBVecg5BV4kHNEgpTBzPa
	oNpA/AG7Q8cUdAgRynQSSscKbvoJQ2Un8KKPNEAa5c1qN3Z4vsGDEfWz5zyiP3qdAKgyib92Viw
	95dEaGUxfc7j/3Y35ZdnlSfRRvT6Zh0szBXnkeZJxMx/n4p4AuqmYsWgs84+neAZH9suZg14m/f
	wF8unLGErMSV/nLiCvawcfySwqPgl4OyWS8KMD7xfi53qDUHJekqF8oQImDemuDUg9xlpbp76Ww
	0kyxUMPF7IBdS+qMtbd2tXkn+Ps71Ydt3vGpueojclduo3bY=
X-Google-Smtp-Source: AGHT+IEaYCcYmIThqF41pmILuOuIJ2YZka3UAOBXQPT8N14he2DWgi46sPZw0th9YjJQIKcRzA/Tag==
X-Received: by 2002:a5d:64e6:0:b0:3cb:a937:a35f with SMTP id ffacd0b85a97d-3e641969f7dmr11109760f8f.23.1757453883833;
        Tue, 09 Sep 2025 14:38:03 -0700 (PDT)
Received: from localhost.localdomain ([151.84.244.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81cbb08sm2315165e9.2.2025.09.09.14.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 14:38:03 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 0/3] Add support for Variscite VAR-SOM-AM62P5 and Symphony board
Date: Tue,  9 Sep 2025 23:37:38 +0200
Message-ID: <20250909213749.28098-1-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the Variscite VAR-SOM-AM62P system on module
and the Symphony carrier board.

The VAR-SOM-AM62P is a compact SOM based on the TI AM62P Sitara processor,
featuring up to 8GB DDR4 memory, eMMC storage, Gigabit Ethernet, and various
peripheral interfaces. The Symphony board is a feature-rich carrier board that
showcases the SOM capabilities.

The series includes:
- Device tree bindings documentation
- SOM device tree with common peripherals
- Symphony carrier board device tree with board-specific features

The implementation follows the standard SOM + carrier board pattern where the
SOM dtsi contains only peripherals mounted on the module, while carrier-specific
interfaces are enabled in the board dts.

Tested on VAR-SOM-AM62P with Symphony carrier board.

Stefano Radaelli (3):
  dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
  arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P
  arm64: dts: ti: var-som-am62p: Add support for Variscite Symphony
    Board

 .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../dts/ti/k3-am62p5-var-som-symphony.dts     | 500 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 387 ++++++++++++++
 4 files changed, 894 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi


base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
-- 
2.47.3


