Return-Path: <linux-kernel+bounces-820466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51545B7E906
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8A71C082FD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C813836997C;
	Wed, 17 Sep 2025 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndrW70/Z"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D60309DAB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104325; cv=none; b=QPOO5qqXLD45rbCrHlubjW5sgpr5ShtudFsyHH5fU73fnbQl9a7NOTRHpWZUogSUJ3yzzzvRldIYfSzg7/arptqAVGhlcSXTdraG6kS2hWUnyIzgFUaBWJNJVadUFr2ihHVMk8LXZIqM7vARa540vlEsf80SuHeYYAehL4xh+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104325; c=relaxed/simple;
	bh=c9+1zzRffLrR0HrPRkGx6haKjpruqLr9G3y9t3Y58EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+oIbzS0BMb5MZYDs7o9RvqD45ZKLh1IXJUhd4+5OEzl/7/97qMLHmaw0o4e6HjAmvZwVymRTJzLp4d9GglmfKGFAFcPosIDS6N7vhONj27lGuZZ7Y3xZCkIjryLL6sqx4ojaf1P2IMQsqU63egLsgCstx8+uoWH04hPQobBy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndrW70/Z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-251fc032d1fso73166915ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758104323; x=1758709123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zZ72N87Qaim5aMPVYiT+iILb4wfsMlQ62gUTdmY8nk=;
        b=ndrW70/ZyKiGyey30siE7OCImZ+NNRxsiTk4uf2PGGvvV0KL36BiMLJ15WU7qLAp13
         BfvFsVyrFtDVGsPBtxU8KcvlDXFeHoNuyb1qteh5EHToTzZxzpnTgYy3hXBXQ1/9Eqs+
         sR5NoeXEr+embhL4UCak9bzrH9m1ocz/Lk3E9Q32ysUyaCnZ7xTxaaf10bLDkzf4sNDg
         oYRTqqDTfwfIPa78XvHIz+AIBlnofq8gLfCBa2Sm8o9gpxUw5STIW3F/or1lwwzQlKGs
         zNKKtCmIiqcD0gqBxYTgtWFoW76Xz4Dd740rOfpGC608fUNMElTEiuaSUiK0Ds0y0YWb
         XvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758104323; x=1758709123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zZ72N87Qaim5aMPVYiT+iILb4wfsMlQ62gUTdmY8nk=;
        b=qb5LYhP4nhrjxGRKGogSCVA0u64KHovqKVIgRgQS7LrUwkiuGk+Y1Du6RlHnomq9nb
         CQs6LJQnXyrhwp9O8+sRapgP8Spgcu1Pyz7Z6wjs7z/19O4UrTWjiufHeetydM5ilIDf
         OzVX87sJ9ar+HuqWiZIVoiITfq+Ps8TIIArDR0Aghpolgtx4vM36B7UVWvafSxjK007q
         5KD5oY3pHstYYOFWcsPxIb78QN6F2ke8tm0ds5cOTyezIlmRUR/1WBT0+2eCQzZTLEaz
         LSzsgEo8EkRBLgVScuO/HC9yjHkz7mBQ5tvx9U346/ByAEPN9pZmTd3WhAPsFoer64H0
         NaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm3yiynhHSacDtsEi8QFttSYyqSHMIpF6Fc07wpPTb261ImkG4zeS1yCPpZMSZrTAm+Q2cIgEkiYFzs0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrpTIpwiTlKAGrcsx1Q3P2BUIur8tKL2lNRwi5bgpSfm+zDJb
	6721SeOiRW7j8DvgvpAqJfamLVhXGT6+/SO/rO6fGm37N6KPKdZZddrHFFt0dg==
X-Gm-Gg: ASbGncsIHRJBlHGO/XxlGbrUzJmpoWEhjTvh8RXZJ47JXyHNjxgrs9qBIgKi6hOxg/c
	8AfxwVZD42RPI8Q2nVAk38r+c+lDgqIYOlNW642xU9U8YWB1FLI5y1rRfkCF7+g10Mte9A+Uk47
	uFLZbZ/lB88qSlTUn77i19zookqqQ9aivNvuhSFECuVDGhlaEns9wOFQ5/Wc7hMUHp2mNSixfH2
	Hi23NrsxXG0FW1/AURGcF6Y2gnPN5uGA0NyQCtBYd2g7gVwwrtxQSTkDvGUpgP+OnxMU0EuQGuw
	is4/YVbPUExSvhXZ6AgDHY+pT6Hqt78fMeVpX2NknmyOR6AdIF38hInoMV4flit5UVGLice9MtP
	pZT+gbirnI1P6gjmKksLwP2CeFA96MWzIyHzxLSaUoqtRFIUVe+ZRJ/yRn8SQHdjeM8kW+iBYOr
	u4YmtxuICn+uOUJxLrD8l77vE7Ww==
X-Google-Smtp-Source: AGHT+IGJbBv49X8Fm3/hWIcTvxvlFS2nF6Nm7mbCdXfD2nMXpiK58GybyZRf/sFMYFcCCU2A4mYHkw==
X-Received: by 2002:a17:903:11cc:b0:262:661d:eb1d with SMTP id d9443c01a7336-268118b9516mr20803485ad.1.1758104322723;
        Wed, 17 Sep 2025 03:18:42 -0700 (PDT)
Received: from eric-eric0420.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267f4d286aesm28588755ad.63.2025.09.17.03.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:18:42 -0700 (PDT)
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
Cc: peteryin.openbmc@gmail.com
Subject: [PATCH v1 4/4] ARM: dts: aspeed: harma: add retimer sgpio
Date: Wed, 17 Sep 2025 18:18:25 +0800
Message-ID: <20250917101828.2589069-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add irq-retimer0-0v9-alert and irq-retimer1-0v9-alert
for power fail monitor.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index fe72d47a7632..37b5e2614a9a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -828,9 +828,10 @@ &sgpiom0 {
 	"","",
 	"irq-pvddcore0-ocp-alert","",
 	"irq-pvddcore1-ocp-alert","",
-	"","",
+	"irq-retimer0-0v9-alert","",
 	/*O4-O7 line 232-239*/
-	"","","","","","","","",
+	"irq-retimer1-0v9-alert","",
+	"","","","","","",
 	/*P0-P3 line 240-247*/
 	"","","","","","","","",
 	/*P4-P7 line 248-255*/
-- 
2.43.0


