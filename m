Return-Path: <linux-kernel+bounces-781183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460ACB30E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6479AA871D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BAA2E2EEA;
	Fri, 22 Aug 2025 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsZ8N20q"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF762E267D;
	Fri, 22 Aug 2025 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843301; cv=none; b=QMUGLC6M9d+6VOf0p7LcL0+IpafFkkUzC4L34cVhU3KT6HBjAY3Bz9Wem1xN8DD1TIaYfaqfHFL26+YL/M7DetBhCG+/4oRqrP4A6gt10VVl0trIdC+OHYOxVUmcgdVpnb45X6+U2pqbDgNBRmVbxh7nAxYVnrStuWyVFmonQZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843301; c=relaxed/simple;
	bh=cYnK50WaqUx+SJGxLtazbCtXqN8Nepb0F+Lk6CTs43I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WyUlys3yDStR7ihIWysHV7Wea+Wx9ESeM423JiDBQ282+2XH4Zzk5zPbysbW1iBw2Sa91ImbtfHED/2NKJdAby3AwaHbQDxEHCYZ4C0ucjr1IaSAHwpS7PAWPtknxhfGH5HtKpJ8xXLMT7Tx/kb2u+FjkwT8GBHlXluO80jDE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsZ8N20q; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47173749dbso1229758a12.1;
        Thu, 21 Aug 2025 23:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755843299; x=1756448099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ReUPEZ+L9U/syQfiF/4viioOEqFIy3ugIcULtGFh8A4=;
        b=SsZ8N20qnWvRngJiBN4xMm3zhzcMFO9o+7DvHG20tNPExsU4KwM/FT/yuCh1pIRWnd
         mgKRpYDCsNhYD0kbN2X/YHYmZraGPeqgGLP9EuRKt4KeED40GeRxeNxvRqXX8oQIUjXT
         2NzBF/nXrW1PucP0RdF6CmFVynPVoW2m0UT8hVpYYoKoIqsAwXPubbaez+Nbt/6tOS7H
         zpMSYkKc0WhcuOpGKvzuC9/VYpSu35lWujtFtWyETVz+stsh+em7rfHZJ7KuhmpMxrH+
         sPV41InxMHly4uyCciRbgeHZIFTplZkJhtX15Tc2jO2yIXX6MU0yG9bhrBXRLf1iv1t3
         qtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755843299; x=1756448099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReUPEZ+L9U/syQfiF/4viioOEqFIy3ugIcULtGFh8A4=;
        b=rCiKd5xopeCTC0ZLzxPuJI7hCAzW7iGAcslZ2E6kAICJLgrxSi0enpGuaYPICg6bzz
         OW0Enia1XjBoELO18U4+GJE8uF1Kd6dIlKl0UncEKFcFfP5jLTXtxBMma5X+Y/BJkyBH
         yDVp/4C2Ee2GZk4xcBrTLW1GmHGDZbK7ITKRLDBvyIgny8e1enpgQMrYpuYerEzlejQF
         kNQ7lq7yFY98CTYsDa4v8H1sCY98V2N0ubNW2Qt650xhaJ6MHP3DDkJ6o9DuR7G4j+my
         IyJlpgfkbzq1Dqh0JmuYxqpUhFmlmS3C0fanVOnNpt26lysMOWmqzA+v323/9gu39XIf
         g4OA==
X-Forwarded-Encrypted: i=1; AJvYcCUtpgvAEMPIWxwOQ8NaGhK/oMgrPhQpQ0TtTKzjHcFGNjFB9ccFOQUWooasdXzE632Xq22SyKJQ6ULlGNlg@vger.kernel.org, AJvYcCXWmYG3BuKFw5v0HTxv5bM2IkDyhkITU51Kh2DTSaUJqdh76Y3zwOXAPUaAHsJavaBOPPqvmaanjak8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WmRBAqjtaoCf1Y1Gq2+CoZfkT/rPYD8VK/DiNOQYCfc52TNp
	G+Uu2u9iq87icI6YOyqKzfxfC0y9uguchQ6LRGWLQkluLpIAG7VMBSqj+/yGbw==
X-Gm-Gg: ASbGncvzMmV42hrIm1kE8c5Cz0MWETbAEzfllnuXodU4eoCsh190UxLfKUgPGyGWaW7
	sO+9i6u/rzuwNXFhLPAiJVdmY/Y0liUpBbCr1bC3FXxKHDDRaXHql0PUSbjXcMWkwU6nFSrgKEf
	kFMPJI3QRNf2AyJ53XaEVQN5dslPedHKZE7lm8rJqePza1iKWIoLO/aApwO/JLuyHf7pxu/616f
	IpqPZGjzkuKBIZTLqvS92eHwh+qYRlkzQ9mqzy+FRk5PuOqHCSVJUc+M1+1xtYGpWCTCb93uz3B
	9/uL6/VkdKpDBo3vR3nF01xqCn5MEOgHfSJRMTRRGERgxxpnSWOILqF6ahTo7kyFQNgpmLCjM0A
	MSTnXTTkh9aVHbdrYTB200xMSBlJZRFavfwlt9VF3v3jdkLRhARjBW9E7OoSzkMME3k4JTIDOKC
	17rmRYHDGKlD5R4eBAVX1KqSmzfwNhF5+aoCGeYyY=
X-Google-Smtp-Source: AGHT+IGW9JepiPFOrIKaV6tWBj8wosVylxBRGM7Di3FDW6E6ZDqNYgeHyHaeigxyiBCNZz3dVEHg2w==
X-Received: by 2002:a17:902:e888:b0:234:8eeb:d834 with SMTP id d9443c01a7336-2462ee2bc9cmr28317435ad.16.1755843298776;
        Thu, 21 Aug 2025 23:14:58 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35d-8041-a0f2-62d1-f7aa-e5b7.emome-ip6.hinet.net. [2001:b400:e35d:8041:a0f2:62d1:f7aa:e5b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246181c48c1sm28660385ad.116.2025.08.21.23.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:14:58 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Fri, 22 Aug 2025 14:14:50 +0800
Message-ID: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

commit-id: 2236141ed3d6f31f53147c26208dafef6051ae43

v1 -> v2
  - Patch 0002 - add power-12v-memory-good

v1
  - Patch 0001 - add power monitor support
  - Patch 0002 - revise gpio name

Peter Yin (2):
  ARM: dts: aspeed: harma: add power monitor support
  ARM: dts: aspeed: harma: revise gpio name

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

-- 
2.43.0


