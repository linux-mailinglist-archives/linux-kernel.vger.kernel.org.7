Return-Path: <linux-kernel+bounces-892188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97F8C44939
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 23:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F523B052D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 22:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBA92727EE;
	Sun,  9 Nov 2025 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="Ka7aCoAK"
Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1226B2CE;
	Sun,  9 Nov 2025 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762727426; cv=pass; b=czijuHdVugeLpCtFv2wXVTU3i1GL/BsuTChvlq1Bx9jhko0x8dn/0ZN3iJKPGd4b2E/niMoqCJTHDz7ufh2qQzlH8639ALA+wEYgbThijpCEA90n4GjJPiGan9BF7wmagvwE+2PTF7B/UrFAL2z0IwOrfpoL4yih+pgpxxl7fsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762727426; c=relaxed/simple;
	bh=CPAIBprsq/IZeMcOp0Iqm+vQf75yS7rSnczSTarh0+Y=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Date; b=WQUqevlve1DuU6+bYmZeadgFF78ZM9WWQk7LZiM5hNbevzHSdCI0CPwEmembAGmn4BJtWE+eQlMRTxFj/voXpxwUuo1NHtbw8aODodorSjK6K9JFRV/EbyhfQafTWXzCG/VvcU+cyra3Kc6KXFlp30tSjBBEcrZoCckXYjxIpDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=Ka7aCoAK; arc=pass smtp.client-ip=23.83.212.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DC9AF440F43;
	Sun, 09 Nov 2025 22:30:16 +0000 (UTC)
Received: from fr-int-smtpout22.hostinger.io (100-125-88-217.trex-nlb.outbound.svc.cluster.local [100.125.88.217])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6998044138B;
	Sun, 09 Nov 2025 22:30:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762727416; a=rsa-sha256;
	cv=none;
	b=QxfFoUO9hAxGp2BxD+Ciop9r+2hDlUEmCCL8pyRNqi4SoLn66FMr4S4vr7iIQqACMLmSxM
	y7bkyOKdrZ5L/z9Mv2velsoknedSpfDHlsseHGB1hP0qW8e1ZlJZyvDQKmb6JTLK4XBbmj
	Lc2RpkMPWVGCXQmuEMSBOtedCQcSMF3QRV+dCjIwyTkMixjZDQjvRU1CnNCgUvYBndFEvp
	4Lgk5kIRtkp4MSkznkRqJn4VCJKlfYM8Fn9P3cpAXO+00hnCB5DxBJ2sA48Xa+VqHboJ1P
	VBpzAH5T+OG8H99npfYGxV/ScMJUneURK2BirNJUj1NDG045Hcgm+vlLX+Z+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762727416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bYTguI9fwtbRna746WVvfaBIUA/5jCg9JsnkhV14j6g=;
	b=p2AXvFzmESiLvXPU8SzX3c9Mt0j56vEG3iQKyI6GTKtFo8+eyz9nCpUpo9uV/pgdLlgmnl
	21fubFsQOgY2Ucjh30Uk6U7TdFuu40OPHA32VC2nJOGWD/eCns7iJx0iJ4QYfQtjlWLqT6
	WoB32M7OkKzBiePb8gAKwnCN7Ry84qOHJfQRKSSr1qXdwjOLMZ9+hSn1mVRK63bg7XlTdc
	8wpMD9bWTkrS111iI4qJ9uYQdoji9a8csJoyQfiuMv7pC+f8tB5a5Ykqs/a0nPExI9soPu
	8vkMzmdL0Bf4H67ifcr+VRkcw6fkSq5Ri/kGBtrwmmL8tN4E4nkt9ZZg5aChYg==
ARC-Authentication-Results: i=1;
	rspamd-768b565cdb-9nvpf;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Whistle-Ski: 66dca66f3ecacaaa_1762727416803_1264572698
X-MC-Loop-Signature: 1762727416803:844494980
X-MC-Ingress-Time: 1762727416803
Received: from fr-int-smtpout22.hostinger.io (fr-int-smtpout22.hostinger.io
 [148.222.54.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.88.217 (trex/7.1.3);
	Sun, 09 Nov 2025 22:30:16 +0000
Received: from localhost.localdomain (unknown [IPv6:2001:861:4450:d360:6854:e5c6:92e9:8517])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4d4SD425VQzyTZ;
	Sun,  9 Nov 2025 22:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1762727412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYTguI9fwtbRna746WVvfaBIUA/5jCg9JsnkhV14j6g=;
	b=Ka7aCoAKLCbqaVlv34WEfU8W1w7yEhMXfrqq2W32KWeny2aiuKTfQvIwghioUGEGN1iG7I
	bxcMjmP/Y7IqPKc2tCvds7+A50DoMo9JG/zcYWQ3PPLYAUt5805HU4NdkGlLji5aFdXHBY
	vG6eLinLjcxRL6I8oxtJPujAs+dIKwE6dyF3YPwKEmOJj41s3zaYFQvmDa/VlD4eNIq4Vc
	BsHBJoBucMZDV0l90YFzh1GdukiobC/tbcuPakKshtXNnKhbBX1e+EJWQA9dtN0ilqiv9D
	vn9eBKusecSVIb+WrT3EW0tnJZ0FS/qK+dd4AgGAZsBkZc5/G6LkjZMRLYxExw==
From: michael.opdenacker@rootcommit.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] riscv: dts: spacemit: add eMMC to OrangePi R2S
Message-ID: <20251109222858.3085488-5-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251109222858.3085488-1-michael.opdenacker@rootcommit.com>
References: <20251109222858.3085488-1-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Sun,  9 Nov 2025 22:30:12 +0000 (UTC)
X-CM-Envelope: MS4xfD5Vag569iRn3Dn/qa/KjZSC9Jo7uCZs5mTseVkPlVTkngz3CQXvKqXlsYn5pjKCzZCwPJoExbN+YU7sMPia1EQEXoNVddWBTGip162qrvBGcKcvY8nb aeWBNcfwL6rr6WlyFJCI0w42ltN1BrWeFHPdtPPsBZWm0zRVcvgnQdjLQAPiN+CmnY59/MxuiagguNUgJ8Zon8qxlIsc30lifVfE6ipgVL3URwpp31CvwDPf BK3R+cqE9x/DEELKPxNn+H7Yyc8+Kq0lVm93jphferuQcAKDJMXNsEykyW9XF/xq9zg5cF3MQQfzxznk4p/jYM2pgJCn8c5e0T3368hwwLjtPx25ZFC4tCX4 j1BweXHSfhTK4CPthi6nAt8JvV0YhwnW7AwGDvZJJaCFt/IaP/C4amt4iTFo1ITrWcoEVYOkGvPWh9GwupJpo7zKmAsOMmsHWtXZqyRxYO1fxfWl4jcq/R8h RCt15ilAzQbbDSZFQBgX1fEGi/qxGZn4tbvqSapmBqCTllmJdtuZMTxCm9QFjz+zpV7+e0y5EemspkPzZHZU8KCV8AL09Wy/0QfQlnrZN+voVxTN+UPdbqj1 YppxSA6mIZccFErOUfN7savFpCoswc5J872XJOd4lIn447A7H1+019IyNewnAC+uksR6gNT6R+HHx0TJ9+4HcCCn0voJqdoKbH3nMcHlp53eQg==
X-CM-Analysis: v=2.4 cv=Lflu6Sfi c=1 sm=1 tr=0 ts=691115f4 a=9hvhlO9olek7/vweJUpOAg==:617 a=xqWC_Br6kY4A:10 a=d70CFdQeAAAA:8 a=-18oh36_rWcDSRoscU8A:9 a=6GXZlH8O99NGPdPthH_S:22 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

The OrangePi R2S board includes a 8 GB eMMC chip for storage.

It works fine with the same description as on the BananaPi F3 board DTS.

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>

---

Read tests
----------

hdparm -t --direct /dev/mmcblk0

/dev/mmcblk0:
Timing O_DIRECT disk reads: 846 MB in 3.01 seconds = 281.52 MB/sec

Write tests
-----------

dd if=/dev/zero of=/dev/mmcblk0p2 bs=4M oflag=direct status=progress
7600078848 bytes (7.6 GB, 7.1 GiB) copied, 127 s, 59.8 MB/s
dd: error writing '/dev/mmcblk0p2': No space left on device
1825+0 records in
1824+0 records out
7650410496 bytes (7.7 GB, 7.1 GiB) copied, 127.866 s, 59.8 MB/s
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts
index a4007a7a1656..58098c4a2aab 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts
@@ -23,6 +23,16 @@ chosen {
 	};
 };
 
+&emmc {
+	bus-width = <8>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
 &eth0 {
 	phy-handle = <&rgmii0>;
 	phy-mode = "rgmii-id";

