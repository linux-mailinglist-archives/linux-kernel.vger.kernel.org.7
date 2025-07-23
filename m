Return-Path: <linux-kernel+bounces-742158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D8B0EE1A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0598918893FB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DC128466F;
	Wed, 23 Jul 2025 09:10:28 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16127283128;
	Wed, 23 Jul 2025 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261828; cv=none; b=V7gRYM/6CaZHF1d/pgXDZXAlAIdBr61/tkkRRV6dzU58CmpvGVZnbJOSGr9Qqm6KH7l9BGMs46B9sG5+FQ8jduVQ4fRBnMo7ge4MlrlEhQXvUUUPKB+jOubqIWpdyOiqTP0G+vz2jY9MgdrH3ajs2Zcz7GncK9xFZ854HUdn0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261828; c=relaxed/simple;
	bh=lT8blcXXw77g1cz/yAibCd665WXhnf7GvHfYU93BKsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VKXas3DPrfnnrgDhAHkHhJuPekH/nipCEIQHTA61OVmmvHWLmLzowyYBUoj9qCRt4D/tFkXqvmHTsDifqkC5TVqFlqbz4QPu3Qxy/1D18VtUcL6mMx09Sp6uULFYKlahYZBStm0gj5kwxXo+8VmhJORPsZAqcUhVyiAj5YZAU94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpsz5t1753261790tb48b40c0
X-QQ-Originating-IP: WbNs+T0/ecBHX5fdSFEE2bEr651tUYnehK6KHcKsIX0=
Received: from localhost.localdomain ( [183.17.231.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 17:09:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14805174978877968786
EX-QQ-RecipientCnt: 14
From: Nick <nick.li@foursemi.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	nick.li@foursemi.com
Cc: xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com,
	like.xy@foxmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] MAINTAINERS: Add entry for FourSemi audio amplifiers
Date: Wed, 23 Jul 2025 17:09:34 +0800
Message-Id: <20250723090934.480055-6-nick.li@foursemi.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723090934.480055-1-nick.li@foursemi.com>
References: <20250723090934.480055-1-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: M172b+tX+pVLtKkZBISweVia8o1tDcE7QmtqmW0XskSxO7sqEoP/jxOo
	9Dt79HTYFwjyWHZuVCYuPdd6TB1OBdBi/9PNKJC6ppnkVLQtuNs0btgPv+CfkvcLF1k8RQ3
	AkctHVmHsBROoE+YfniIqs0fPnJwwsMC65P6SaKZMWAH+JDN3SqS+fDG8C+1f5wiQPkWhHd
	u8W9fhapYe4/JomCf4ABcpyezTU8SE75EPo/COlTe/vtpKLzBOflaG9l9bq4FmT2sWhzz0q
	NQjBYNkdQYOuEhw6PKJdr6MX+rwxhTjy+kXaSZywtL9zrYlArRFXD3ToZwEdQCdW112zqt3
	O9ow0Gxi2LNCDcol/slNnfKri2Pn2HLJ/NSXhymadWtiPASKjWD1CP/PKhZd+L+gIN9nh6+
	JwHz7ATzP2IPr649KWEDHW0Zy3dgK9R3HtiGaxwdWD8AmdFUkL1m3G3Z5z/OxvPQ6DN0g6P
	nTkkqrIk/UkOum+iIV2JLtkj/kyHVKoA6ISzwb3i82dFmy79pK0c51l/pzyM4H5NBQN8xAH
	Hyq6wcZoIS+D24yMIBF0iaix49nn5iTroMkITsPhf4wo1uFoh2PeqAzIrj+2V0VakCfrNUq
	/Iz7mQxiSUJjQNVgRp33NX7boCvMMWUueecDNLYQQGiJb4MtBNzdhkcAT+VcZ3ZNWGXJ7xk
	X5j0jD5xZRCnxeKWnicyOl96qU6Q8jh9OSiTWs3twJ66icsjqsslZjHZW6Ss+agPDux/t6R
	+rmjvbKo+nm6Ahm7hTCIM+0igQWDdvFe94AZSSsHExDyaba7b+wHkIxfHonmisctiNdBewV
	73Aj9dUXWorfnZZ7ub43OMiSzkBHM47Wjw7T/0dxUR7tiyMoNLbkyLy1dIJgrW7jcy4cCA2
	EOMD9vUIe4AAIxtGYJCd63pLZzFS6C+F1q1p/cMjUDsOvlD6dtgmzljeCbjs3nbSlhJTeqv
	pn77kbulhArDSA6vHKJe+sXeiaUOS8r6nTOoUeLk9P+tr9OxQ2hDFTOViMMWwTTauR+u3Gs
	yTH8PMByQr6VLkRZXUBkDNEDETE4j8QWphYJuYIFvgwur2dbHoM9rN2iGWkFnIf/eaE15Da
	fRZWjG6NuAW
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Add entry for FourSemi maintainer and related files

Signed-off-by: Nick <nick.li@foursemi.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 62d51c5a0..88354cd80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9455,6 +9455,14 @@ F:	lib/tests/memcpy_kunit.c
 K:	\bunsafe_memcpy\b
 K:	\b__NO_FORTIFY\b
 
+FOURSEMI AUDIO AMPLIFIER DRIVER
+M:	Nick Li <nick.li@foursemi.com>
+L:	linux-sound@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml
+F:	sound/soc/codecs/fs-amp-lib.*
+F:	sound/soc/codecs/fs210x.*
+
 FPGA DFL DRIVERS
 M:	Wu Hao <hao.wu@intel.com>
 R:	Tom Rix <trix@redhat.com>
-- 
2.39.5


