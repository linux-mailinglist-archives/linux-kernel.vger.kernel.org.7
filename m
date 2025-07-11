Return-Path: <linux-kernel+bounces-728372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1204EB02791
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7957E17BB1F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFAD222590;
	Fri, 11 Jul 2025 23:18:16 +0000 (UTC)
Received: from mailout.easymail.ca (mailout.easymail.ca [64.68.200.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509BA1C4A17;
	Fri, 11 Jul 2025 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.68.200.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275896; cv=none; b=Lk9wUj4xL/26iwesXw3G91zjkuGIBJ0iQlRXMZ4F24eehTaj4An0fF/E8a2MMDOuO02stC+BFfAUfjNfKG2ixuoSkVHwFq4bG+bcI1QPf7nJpiVrFlsLkY63xCiBzBaFdGb/Q6A7P3DOhhzn6+jlN1QhWLsetbtIknvcQhAC36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275896; c=relaxed/simple;
	bh=rl3L/R0zR+OovtcJG/ouFXqVg/aeCaP1IaQ3COgxqPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSABUZUvIFyAUv6YB0Hycq5PyI10xTy8FvBggXvakze9THuj9vdOXtudWk9hVbMUcoPzkhADOo69BRenhjNnEg9E9Ms6q00ssr0AQxyAJLcley0+igM5eLXcgaQuGiELnB+9ajPJERveJgKFg/tlITimFH7HLwM4cz38bPjHzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=filchenko.org; spf=pass smtp.mailfrom=filchenko.org; arc=none smtp.client-ip=64.68.200.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=filchenko.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=filchenko.org
Received: from localhost (localhost [127.0.0.1])
	by mailout.easymail.ca (Postfix) with ESMTP id D3A22E09F6;
	Fri, 11 Jul 2025 23:09:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo08-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
	by localhost (emo08-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aMJOQ1O2aY1L; Fri, 11 Jul 2025 23:09:30 +0000 (UTC)
Received: from ymir.lan (unknown [73.95.76.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout.easymail.ca (Postfix) with ESMTPSA id C8075E09EA;
	Fri, 11 Jul 2025 23:09:29 +0000 (UTC)
From: Dmitriy Filchenko <dmitriy@filchenko.org>
To: joseph.kogut@gmail.com
Cc: conor+dt@kernel.org,
	derosier@cal-sierra.com,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	honyuenkwun@gmail.com,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org
Subject: [PATCH v5 3/3] arm64: dts: rockchip: Add support for CM5 IO carrier
Date: Fri, 11 Jul 2025 17:09:16 -0600
Message-ID: <20250711230916.2089410-1-dmitriy@filchenko.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617-rk3588s-cm5-io-dts-upstream-v5-3-8d96854a5bbd@gmail.com>
References: <20250617-rk3588s-cm5-io-dts-upstream-v5-3-8d96854a5bbd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Should `vdd_cpu_lit_s0` and some others be in the SoM device tree instead of the IO board? I see it on page 18 of the schematic https://dl.radxa.com/cm5/v2210/radxa_cm5_v2210_schematic.pdf

Additionally, I am getting the following during boot:
```
[   38.190604] rockchip-pm-domain fd8d8000.power-management:power-controller: Failed to create device link (0x180) with supplier spi2.0 for /power-management@fd8d8000/power-controller/power-domain@12
```

The device is an RK3588s CM5 on the IO board powered through the barrel jack.

--
Dmitriy

