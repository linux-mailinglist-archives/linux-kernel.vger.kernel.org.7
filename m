Return-Path: <linux-kernel+bounces-768079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98860B25CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CFA8838FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3AC25DB06;
	Thu, 14 Aug 2025 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="HrOlw9ew"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6C25C816;
	Thu, 14 Aug 2025 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155350; cv=pass; b=kOLTgDxno61SVoxtJXQvUvAaftLQScqc55GPI9iHrFah+RZshIKffGqx2d6e6NS8Bzi0dWQx/VG4ans4rjDstzp+dSJJfn18+FTEZwlfLgooeXtRbOVFNx5ZGwVEKUBE+R3yM31HHBGlpUFBJjPPzvfhlil/zhY02eOan3xo5UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155350; c=relaxed/simple;
	bh=l4A5+l0zqFI3oqSg8PWPxscJngjzxC0M6NvkzedayMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfBJlpWCwUgcPER2E3FnMy0vCWA0z7HpdthqEtynAqvAAqR0nH5GxeLXbcHFHthKh82ud46HM+q1lPkifi7/Ah+qsTETNGSsCdFx5G8z10GP2QuOn41c5f5mjiMQhoQFSR/nc+uW7BVD4kU+uTYkXc9jFnT0HBkK/tFagcLrINM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=HrOlw9ew; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755155335; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LWEDSFKbpMaUCdImQ1DRsFbnXyu06Lg9fu7akWCg7onqXewQ74/9DgaxASt5PQOaPoHOIMToe4LJNbRfOzUbxVQQJ70yHNrJoY7FD3q8CH1DPctJC9W6ZyPV4baMUpBLX2KnjXh1RJmae2Q5cuJ9wfHo1bbVfJ+P3v9X1kuphbU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755155335; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=g+6aGbgSqL+o5xd1mrzWWr83B6zwR2FugBnE+jwf0eY=; 
	b=hPQeqbPtBFIRsufu23wPmwVKIbxWupzgMcD71F+m73sxMjZoI7RUISRwCnVivIN/+3zzEs1yEY7CJ4yIZjfj9emYWiRm4tzIITzTYEA5p33LF262Te0+CZdOwlzitl7AiiAdqIKXEULucNeSf7YMBL/4W1mIJmDbQpFWi5URPEA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755155335;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=g+6aGbgSqL+o5xd1mrzWWr83B6zwR2FugBnE+jwf0eY=;
	b=HrOlw9ewXqzttP/pB71sOsPTXyeLNo7vOpmtR3/E4IVtQVa/qswS3x7tmVmXl5/M
	l05fAP2hlCWYY1q5xgNqqIUhVcrgtWgLvNmr1xzSYcA/MJDbNPkABNcQpXD045YQ/Ko
	2Hxg4jDuJ+XGon2GypSGayZNv2SwR9J5MU6NshyNXftR1vqm2QGZdfL8aNBQn/ouXuo
	ynRAtoYJKCZ4IWxkjvDukmFzj/9sDMS5GX5d5qfyy/sNDV0eD/7Y8BS6FE3N6erRo87
	pqbMZyvcyVCP0wUlQEn0NTVIeF5vK5xXhfwbERbZWHkfpMdV5/2kua5D7/fZha5nYGE
	niSiFGRtfw==
Received: by mx.zohomail.com with SMTPS id 1755155332438337.2232936507686;
	Thu, 14 Aug 2025 00:08:52 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH 3/4] riscv: dts: thead: th1520: add reserved node for C910R mailbox
Date: Thu, 14 Aug 2025 15:07:56 +0800
Message-ID: <20250814070757.2267325-4-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814070757.2267325-1-uwu@icenowy.me>
References: <20250814070757.2267325-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The OpenSBI firmware might want to communicate to E902 CPU too. As we
have two mailboxes assigned to the C910 CPU, declare the other C910
mailbox as a "reserved" device for OpenSBI to use.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 42724bf7e90e0..136ebe210b876 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -565,6 +565,22 @@ timer3: timer@ffefc3203c {
 			status = "disabled";
 		};
 
+		mbox_910r: mbox@ffefc53000 {
+			compatible = "thead,th1520-mbox";
+			reg = <0xff 0xefc50000 0x0 0x6000>,
+			      <0xff 0xefc48000 0x0 0x6000>,
+			      <0xff 0xefc3e000 0x0 0x2000>,
+			      <0xff 0xefc46000 0x0 0x2000>;
+			reg-names = "local", "remote-icu0", "remote-icu1", "remote-icu2";
+			clocks = <&clk CLK_MBOX3>, <&clk CLK_MBOX2>, <&clk CLK_MBOX0>,
+				 <&clk CLK_MBOX1>;
+			clock-names = "clk-local", "clk-remote-icu0", "clk-remote-icu1",
+				      "clk-remote-icu2";
+			thead,mbox-id = <3>;
+			#mbox-cells = <1>;
+			status = "reserved";
+		};
+
 		uart4: serial@fff7f08000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xf7f08000 0x0 0x4000>;
-- 
2.50.1


