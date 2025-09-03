Return-Path: <linux-kernel+bounces-798267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9623B41B7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA50F7A26FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38652BF016;
	Wed,  3 Sep 2025 10:15:11 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F42E8DF1;
	Wed,  3 Sep 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894511; cv=none; b=tlcOu5xAbNJwf0Nsn/mqdGd40MIqkoYx+1XQv8PPTolUdafMQYIC0KyTQ0BwI6Lk+av4BhkfJvkQXD/DyYCULJ/74MjKVhNl/dCVjpmorE6m1gJDmH2Xn0Yz0AngDAMP6FWdwOIrz+uHJCOpZ2dhebuvMgdJmrD/snvDjj2eu0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894511; c=relaxed/simple;
	bh=ZLuMOB51RsSxb00XR/+R98KZvERl3JOGAumCc74Git0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMP1C0rD8dATIwxioQZeebNYxyb4nJgurj5xNWDZbt5mnwb9Lygfmb+PqBAnXbRTJ7FSKYeuDAAjkLs/2y+zxB1CRtzslZwn/w+5vj6I2xBqk5eLKMUYMVamouaX2FtZnSWvxxnp/Nqegmz2YJXuA0Ee9cux2OU9OACizoiA9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 3F4E1B22007F;
	Wed,  3 Sep 2025 12:14:58 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	E Shattow <e@freeshell.de>
Subject: [PATCH v1 0/2] riscv: dts: starfive: jh7110-common: drop no-mmc and power-on-delay-ms from mmc interfaces
Date: Wed,  3 Sep 2025 03:13:34 -0700
Message-ID: <20250903101346.861076-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop no-mmc and power-on-delay-ms properties.

The committer cannot be reached for comment and per discussion [1] and
testing there is not any observable problem that is being solved by
having these properties for the VisionFive 2 or similar variant boards
through the jh7110-common.dtsi include.

E Shattow (2):
  riscv: dts: starfive: jh7110-common: drop no-mmc property from mmc1
  riscv: dts: starfive: jh7110-common: drop mmc post-power-on-delay-ms

 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 3 ---
 1 file changed, 3 deletions(-)


base-commit: f66eb149b87677da3171a0ed51c77c3599ad55d6
-- 
2.50.0


