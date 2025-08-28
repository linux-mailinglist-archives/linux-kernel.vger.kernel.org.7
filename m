Return-Path: <linux-kernel+bounces-789462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AE9B395E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CD5A4E27FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC47027A130;
	Thu, 28 Aug 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB2nH5Nb"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B929F274FF2;
	Thu, 28 Aug 2025 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367404; cv=none; b=GxKo1CIpUolosbMxDQjrmm4ZHYlQZqy6Zf1uxpWJJezD+LWMCNpmJ2F4gmhiYQejiAdv+5BlUahJhT7C5Ca4Tbks1VMRr2+aYWS5aVkl9UQCh/I28qYActMkYVErf0ru3yvRIKL0bV6HDl8fy5U5cPt9G9lOlF0ku9z+XNqevQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367404; c=relaxed/simple;
	bh=3wVV6hBVMMEFQ257ekEynNzXAAyie2/L9MmDfS6aVNo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ObjLUfsI2sOySiVPcNzt5AMnW2pMFxlKaNKERW4YauV/Abz+HV2n6X6IZZk1VEANAThELtvSYkJPQVcYfckS3Yf35c7/7weAo7epftHXuFELmtNZsZRT2620tlPiJ2T2teyuxKX/3HOig5quI9o5Dsczo3T5HMhNDV2tWgcHIzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB2nH5Nb; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4717543ed9so491918a12.3;
        Thu, 28 Aug 2025 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756367401; x=1756972201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjHOGNG4+d7HZdoD4W/KYIfSNIi2J/bMo0iyGxOFrQg=;
        b=FB2nH5NbYjctGaxShRV8oN4e2jigIJBKqZSIPHyBG8iWwQz8oMwag1x/jJiq45n/mn
         Ho/xuOfmAOYADDD24Q90i8csA2pTwaRpy4wgBxWU7cXrs3/kO+Enw84MJyQym5QS3RVf
         dlidSI7pXprBOp58ts/h621uH6M/0J0SpWyL86KdnPlYsUYRdaTLccBcwWfVymPkAA3c
         eKjVNdNvTCHMuosfn18SYyCFwaHMlA8IwETFZBRLUxhcq1GxSIOf5TglXneh9pIwqwMj
         FUPBYQHLTc0290ygA8FU7Pp9kCmEcVJ0zNjdp4EkOPum55jv9UBhkh1i8TQQzChYd7aP
         UV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367401; x=1756972201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NjHOGNG4+d7HZdoD4W/KYIfSNIi2J/bMo0iyGxOFrQg=;
        b=b5FsoSacRbIt58uYjos7GPXoB/pIrCNhs7osaXrOoLR9mQ2qnoy+KfcYthc7psL6Pl
         Regtb7XNMV1pCj5lNz/2Poxc4Tahjt9ALhtgLlb0+r7kIgrBymhKiy2nB8ejUcQYvMmc
         hRyKFjg6lvEdvqES9lziRFYWQCT+YWJKer6DQNiWJpxNKH3DtVKXEnhAU0LY+al838Rh
         3NEE7qz8IzQ/GTAYOvWgD5vQXUt6dG0bJi1W/OYUAfTd8kH0B1sDVrzTzW+7YbABcCdc
         7Fl7q9MVKNPFmq16abTEU5DneMe/O3T3JxxoJ6FP+99DHsBUJYEyDvxVubcWurWROkFB
         C/7w==
X-Forwarded-Encrypted: i=1; AJvYcCX5pEy+hvRXvnYbIDXo81totyuWdz5XfgvhHhrgIirAlgho3s1wvwds3EvdMTKartP+7A239RrPypDx3p74@vger.kernel.org, AJvYcCXXNTj9yrRQXHYLpzc1kyuhTsUQ4W0EquOY6YfnRs+de44BnNiQMFaKvxWoU4PXPYh7w00NAOqo1kqh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7uhOo42CddT0kDY1Yy6vGPMpxAnStllMx8Q721f2CpJYDbrdq
	5URAAJ44DW3oUizDZwEPFrgsJt4zbglkumlfzeMq+agq91A0VYJetZKi7d8Krw==
X-Gm-Gg: ASbGncseq7WPZf/ghIFS04nXrC/hyDMLyL7z+p0QUnALBRXAKCd2BbmPc5tC+y95Dlk
	eziXgeLouPUrnbDhSjXBpIrWVkKM9eSNOB9PfmdJ2iDuAeEinzdoK3KjnjnMqiiUHs361B1NWlF
	Xy2+Bldk/HZOVJ4dh5PAYF72RX/sZGXepCsy8i8rvEE3+6dVZV1FC2WQxVOToZBI14gOFLRsXtO
	xat723Fcl6+1lnpjODYN2TMKA8fQHhGgC1O4NXCCdNj7PMXKK/tW6JGX3ycK1DZttcmkkOZPhFz
	6Y4Egmxg+aACgcTVkkwvcBPM+A3cCAOovO4B8qZTPkIMPbnm6H5es4H1kCrbZlXfMf8bLTyGutS
	RHnMiYOFfVylqCrPTulYyXQulCICY6mFUzFzBeJl31X4ZITRcFFUTTBFAau9p+4JTc9DuiMoHji
	B4CSdLxZkQ1wFzNC9aBbL3Km1iW8RxpTmmTj4LD8g=
X-Google-Smtp-Source: AGHT+IH5WPqqBozEMKrHMq/PF8PPjFfc9CCGsxQOZ5GAqhbwcMu0aIAwPYCwwEm/tWUHMLGYhvRR/g==
X-Received: by 2002:a05:6a20:8093:b0:243:a0c3:49ea with SMTP id adf61e73a8af0-243a0c34c2amr6067769637.36.1756367400761;
        Thu, 28 Aug 2025 00:50:00 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35e-4238-7ad6-5c9d-99c8-92d0.emome-ip6.hinet.net. [2001:b400:e35e:4238:7ad6:5c9d:99c8:92d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb9d226sm13272038a12.41.2025.08.28.00.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:50:00 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Thu, 28 Aug 2025 15:49:50 +0800
Message-ID: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
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

v2 -> v3
  - Patch 0003 - add HSC mp5990

v1 -> v2
  - Patch 0002 - add power-12v-memory-good

v1
  - Patch 0001 - add power monitor support
  - Patch 0002 - revise gpio name

Base: tags/v6.17-rc3-39-g07d9df80082b

Peter Yin (3):
  ARM: dts: aspeed: harma: add power monitor support
  ARM: dts: aspeed: harma: revise gpio name
  ARM: dts: aspeed: harma: add mp5990

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
2.43.0


