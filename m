Return-Path: <linux-kernel+bounces-779592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166CDB2F622
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B17167330
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6F30C359;
	Thu, 21 Aug 2025 11:11:07 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCB1DF271;
	Thu, 21 Aug 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774666; cv=none; b=Klqi2pMpCiXppy0iiFFhLo0QElKTYzz4lFS4y+0AnNQ++UmMKuhjouY9tougv76PqcBD2HOjXpagen5W0gxyhUskBmE3U50GpTWOUluFIo4lwgcDRFa77ztMKAI5CaMRPUzjHuspG9oG32TXrqzDw3Ki0PxZU94476B5VOVUEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774666; c=relaxed/simple;
	bh=5nX/zcVXQAgMnVKqSFbkHKigVcgU4LM3Apz8U7h+GIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YE8gM8VzyQMdMUoZa+ql3NiHLHoWpiIUDt5tHIhkRoUQNOVYtyuSiutT5mzbA4aXrC0NqYgoJSP5qXDdk6xLQSN4GGfE0Cvu54nirKZqs0vJgj9tyjG4+1mE7ktM6hjiZ2zPPbWD9WUF4MjFPDJ7VsrQQ9h5AYpEYIa20oey0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn; spf=pass smtp.mailfrom=chainsx.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chainsx.cn
X-QQ-mid: zesmtpip2t1755774589t73dceb9d
X-QQ-Originating-IP: MKW7FV7OJTG4N2Nkof6plwcSoT2xUJFMGQvmD+IFAqo=
Received: from chainsx-ubuntu-server.lan ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 19:09:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8973447282876745434
EX-QQ-RecipientCnt: 16
From: Hsun Lai <i@chainsx.cn>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: i@chainsx.cn,
	heiko@sntech.de,
	andrew@lunn.ch,
	inindev@gmail.com,
	quentin.schulz@cherry.de,
	jonas@kwiboo.se,
	sfr@canb.auug.org.au,
	nicolas.frattaroli@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v1 0/2] Add support for 100ASK DShanPi A1
Date: Thu, 21 Aug 2025 19:09:40 +0800
Message-Id: <20250821110942.172150-1-i@chainsx.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:chainsx.cn:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: M182XWJxg1fqOo2MLb5Y51CQLe7R6WopGMf3DLzStRbwUsJyMMqOAvnt
	pEsDAqK2FXl+JueHkhtig3r18JgSrl4KY8L12FH95ZbsY9Kyu59OCmGtaCj1n5g6eaGa1mc
	UJ7FML8AExgu+9r2MMXBdjVELNTJHEzHjeRzYNIGXMm1mYixcGs39ORDS2FfhOlsp/GNOIr
	biU4OER9qx+KM5XwsLfF/EKHgxygS54bNg0llNMpNbep8VkmYQvfsWES7sID9+cF4HUOtdg
	EyQdvr3l9SZp7PrD0jnpAHW+Gydv6+mWv72TH2qof/1Wuq15/NO2XvrUg5GwYnGUDgPLsGp
	25lVxXQWsAnYqKQBEWl49j6QePc4rv4HixRMHHlYiNm1lrDRsd/WgTNV947lNETUxv5ejx4
	Gtr99oyY1uoQMMlhMDLajM9Oixwg/Ofm/EG5EOpfukp2HNA08jqHzBpBrR1HppT5UJ0gKyo
	TIoAryqb48R5k+YrMTznL7+woZ72ej46Z9GY/bq0PbADIcAPMxzCdyW4lQaSR7kM0vpeDnV
	5w5hg/uvDUBKVdBwH1U90VMyEyKt4tdVTIX1LM3D4JCmiYGg0q3JcVIfonAt+h6AWCTK6ed
	g0jK4QFymfzU+Qidz4uF2pzIIjF64/sBfvwEmDXLzkRWYsWtKeIGrNH8/Acs2GUBaozCN+m
	nVPTv045mucfLfA2I3V7pJKKT+O6Fy0KRjcgDdsDsa5GxF0OIrCPVDiailXmBEror9fvBX8
	bfZHuSKyCGNOUfpjcQblDqUfnGe4Set/qv5u+vf8qwNXPahWFGsIXCqqYXtwrKugHOebLKZ
	pb54gXRzcHtEW8c/k/O0XZMW42RfinXLnzV6z+CS4unC9mUnxPx9DouCPAxM2MGS2pGT7lU
	efL8YXaE2oaTqPHNJu45q6A+/YlTqTD2JmAPeRFvb/8C36//lfY5hRcTZyniqZQ202WV6EJ
	xDlxA4QCBhZm6d/R+NTUnB2wea10z2bDsXQEMkrRV6GV0pCdyGcQoFIKntLWy7qea8Y0aZ/
	Vs2xvA3Q==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

This series add support for 100ASK DShanPi A1.

Info of device can be found at:
https://wiki.dshanpi.org/en/docs/DshanPi-A1/intro/

Changes in v1:
- Add support for 100ASK DShanPi A1

Hsun Lai (2):
  dt-bindings: arm: rockchip: Add 100ASK DShanPi A1
  arm64: dts: rockchip: add DTs for 100ASK DShanPi A1

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3576-100ask-dshanpi-a1.dts | 841 ++++++++++++++++++
 3 files changed, 847 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts

-- 
2.34.1


