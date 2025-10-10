Return-Path: <linux-kernel+bounces-847670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A49BCB639
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D3564F2C84
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8F624DCE6;
	Fri, 10 Oct 2025 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="L8Kaazt3"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B910225402;
	Fri, 10 Oct 2025 01:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760061432; cv=none; b=OapxWCNaCW9lZ/VuQzdBDs5L26dMCJsTWsMjYVB1gvZCEspqpnnlc6lk8d17xkbM/tRGIFkMOY+TcGYYR4+YVkbqnf8tK6cz1BZVFxKsmnqMlCapLzkqh03w6Qi21/7gZG+j8yNGq0GbjTPmrVFJ6DAt7D1aV3Mz4HX8H2Lo6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760061432; c=relaxed/simple;
	bh=0w9bve3SGLrlFd9z7MYtKQ6kWXHe697KHcshOSbgu0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZgMZ7fj7xkX5t6HxkjXJjaBJTG+rwKYLFiDlDdJ44i9jC29s3qx5liQmJu7dPjb6abQQAcB8x9v4b290jULXg+gKb9Yf+skF2VvXVG7bq1j2JqxgaUhis6Em8kWr9xvZ0xfMSohnhfPg7ymg34VfX4bDAMYhOo3uASp3olBeX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=L8Kaazt3; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760061418;
	bh=BNyJpZwzwt79VmZFwQ2hwN9MxGf/PzqwrerldyY4KOE=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=L8Kaazt34GHKBTbzG5+BwHuqV7qmNSGko9OiRZJr77kHd/4FOM5nJy+G2NZCo2KWj
	 R0xJusOwBoT3GQKbgMi35x+LeAHbMC5cJGThx71+oCdQmQi5JUPaFf7uz8xwhG4bh2
	 0N/Kk7EyocZ3KfUsLKqZLIn9EdJvjcp26Ec7jSmU=
X-QQ-mid: esmtpgz12t1760061412tc9346fb6
X-QQ-Originating-IP: CpqcOnv69DjnonDbcIVMVIhKDSAZiIgHiG/X3MhjUds=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Oct 2025 09:56:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4019892986896641376
EX-QQ-RecipientCnt: 14
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 10 Oct 2025 09:56:32 +0800
Subject: [PATCH v2 3/5] riscv: dts: spacemit: enable PDMA on MusePi Pro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-k1-musepi-pro-dts-v2-3-6e1b491f6f3e@linux.spacemit.com>
References: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
In-Reply-To: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760061399; l=740;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=0w9bve3SGLrlFd9z7MYtKQ6kWXHe697KHcshOSbgu0g=;
 b=/6He4zADj9M4UWVv+2hPg9GJvLBQedP1U3kNhiCdEPrJwZs2IJw9iN8ePNkuIMBwABwsAJBD1
 t7mM5Q/ZpZ7BhBmt1UahuGOuKG4jWo+gdag0UUoaOBEgJL6VvAGi09U
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MhbIMYBflAapKSaeoeJXmG3thbN7wD2mF8a2O3SYhkgHkoPzl1ySz6cs
	SO7FoanRsEqppEQ2h+rjQA1aJvCEKzJ/6F0FkqOJ/Hzl9JKbL9sXYKvG9qLgb0uPWkho85O
	4QWyYm9r6ifcC3HfKfN93BjoUtGiujHjrFyBUj27w+2njdbiXJwfQPvDJ6WWtGI2yr9Ds5B
	tsHebi6mQqkV6+u9VGp79XBf4SWoygbF5l+Feblz5a84UYHa7vxnMq3ydieBu7rGpLlfv5y
	oghQlktR+ww78+upKrCqSsCFls1AAG6jMn5pcc2jgFvFsYSkbPOhC4X8/dEjQLb4STBSYXJ
	vzGuYRxYyUm+lm6gtwsTbv2PjwlwSBb9x8wi6N7SJUCT/nD/IqbQUUMEFe1+hS9LE1QF4fM
	Go9+dYhwwb30/3Rnsps+GjhWcT9uI2dfQXguTPZ4NBrzrCnGV9P017DgYYgz3aObh6H8m5+
	6AdZ/wn3jVWtycT74bUrNYb7W2NMZfmN26a7f/RIRefYuBK7sYklWA/pd7s+uE7W3i9IgU3
	MdXGckauF0Naripty9s85f/M7087dK5kmRBsiSSRJEWT+i2aqxLxwqzWBEEQC3avzpwBcng
	Jhr6OtuuHQ/8eDagSsPohAYJzQ34yRzx4pmw/CaYFgSookrJWXJPN6EQOlSr4BVLrH1bzmL
	JqQEwCuE48jVBhS5K+/wZkn0sP+UKS4RD8cn9JTg9FUJ6ALVsf2N/g5cs06rXe8RaTX5k0U
	YFBk5t/AuafNqTmsXCkGEqpO1/gB+wHT2t0mMm7Qw4IABl+uFOcvT56lcIPh/HIi40Lsm+C
	rj5NVBsL9MxjIFpiASs0R5AWSk/rwsu4i33IcJii4ywWLV+erdZfgdNEqdt9gPRITC4KdSy
	mwGFpxgWwBFAbydoiAZCaMLfF9TznXpQXjLHcEgaIHiFcgoweQ3gQfvPh3dCWhyNryunqhV
	PjOWMhZSyYKHzF4Jxq52NIoIEfNu3l/+a5PU5z4ENoD03mwiJLd++v8pTo3P4Y1L0Ntlypf
	CFZ8vTEu8sfQLtbmuzf8aDErczhDvzARSISRv8l4UHaf1RgjGuhp3m8wkxvxxz+PV5TTCPU
	OG6XwrfuDgAArdLOqEZt+dHiy0J08XFM1CcIUVuMOVayC/ZbwmBStw=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Enable the PDMA on the SpacemiT K1-based MusePi Pro board
by setting its status to "okay".

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
index 49c41ce785cded31c9937d8244d9bc99dcd1e1da..7ca3375910a3da8eaeaf1a7d5398616d928aa875 100644
--- a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
@@ -33,6 +33,10 @@ led1 {
 	};
 };
 
+&pdma {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_2_cfg>;
 	pinctrl-names = "default";

-- 
2.51.0


