Return-Path: <linux-kernel+bounces-726142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637C5B008B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36167544A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8D12F235C;
	Thu, 10 Jul 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMgIUdOg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538E2F1FEE;
	Thu, 10 Jul 2025 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164887; cv=none; b=pcBJrND6MTE03vz3Kl+iB620Q/D4UdDgxKo0a7gyqVjM2JDshW28UvBxq0MslC/E/bQha8sI06LM0ra2GMfw/I+/OZDUkbmRwZWcQquSzoFHtJFxZ3wWY1d6Hun++tdpU83qhdDIFkDjao9NE6+XMLnGcj3J5TVeAxPy/7u/7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164887; c=relaxed/simple;
	bh=r2RRpFlqlX/IDtA8e5dURu4lBt4Y4olJ+/XKCPLkUPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ORISIOutwKVzLEyE+e/dbkihG2G07XtZxInCzQI25W7Z3eP8TWDmb7aaVwXPH6EyO4xTszqwCAM1Y78/1sLvzHsc6z62V1V0+LsEiibzdZcWQJ8Q1IuvL0dj8M3t383bN0yFfz8vqjJg1TEiH0BO5heiK5MEJB/HtfMXkxySOl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMgIUdOg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b45edf2303so1167788f8f.2;
        Thu, 10 Jul 2025 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752164884; x=1752769684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QqgJo74r0WlqLYuhJtnv7gtY0TWn0mA5ZdqgU3JWC3s=;
        b=ZMgIUdOg/y5qb9qMIC9xdkGu3WkYzCOKd8KANXcZSw2t3TN59yaCr3P163lt3A/UMO
         q5XknPU8fqema96JIbAD1spJANA4iUxc6pIAzDaOihFOK14m5k7Shxb5qYfmRDEjmQ8m
         +bbi0mnBmMHmlJMtTAeD4EBCpgxyZ62VfEYOElniM0tCF8sPv/YoIz/A2j06KC5t9Olk
         ogwhKRIMZXF/TzQ7xiGTajOOz13QP5mPELQgjIDBwrvZA38H3QC4za2Xv3fQ3dAsG24X
         MEJoio+gBxRtErqoge41+dbadG73ft122DEF/jZX7BEzkp1nMj5qN2KfN8HK94rBZxpd
         O3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164884; x=1752769684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqgJo74r0WlqLYuhJtnv7gtY0TWn0mA5ZdqgU3JWC3s=;
        b=v62rFgN4meTl0vEdtL/wNOacGmSIVFWtbCPHHVYBJdOTBdv0FurYLQRgy4gRHqT06p
         Wd1fvQ1Ou8Qijuvk3w86yc6X3Pw08rKsVdTQPMvulxkHmsEuLiryM+ZhTzVLcUHQR+bw
         7jelZb2X+OU5RDmyPmcKhMoRiGR45wPAH40+3r9WT/a1l7gv5D6yioe1ZwOthwwZM6lK
         Y4iW3HW+aa5QoV1FUKumDa0u3qyW/co3n1UqdZZcpkHZrp4iqabHLtQOZXogHaqIBJ1H
         CMgmOODREypedgxb/HhNC/2I/mNhPdWQmEsgGfDn8N9LxzUPgiywFAv/DHwuAF3iax18
         KGRw==
X-Forwarded-Encrypted: i=1; AJvYcCXe2vfIJ5d+Gub3xn08gAIMM80gN446SHfe+w9z89ZpV8ccqa2+fQ5EsSCaodGFJEPENfrWEyALL8YK4/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLxZ6v87cTzm5zHGX6qNoHYkpBE3tC8rrt9fnUEt8txgLPG+sT
	RoeSW2QmtaFdUO4SAgWQbhpVVEV/wAE8Eobb361VHFlqUJ3beYp9CxD5x5ZsSJSJ
X-Gm-Gg: ASbGncsaX3sSZZfn9LWevC9gepfijtoHFVH7ppcIkneK42kEcJ+xtXmMrJ3EQVMbuBG
	asPX8OCA4146LOFAtlzV+SyBAlYEv6MNGA0/egl9rlN9PPyb1HGWJp4MA8qiX9tAP9hlyxg2N1n
	1Bb2HFCynyi0g0ya2PvJIrq6Ise1bQ/FQVmKi3N3U4E3VA6dSQKdylvrUgjDuDjbvK9u3coEmEs
	4H++QnO0+YcrOGeXZezh7Lr0Jerl2yIWddrSaCLZdJRGpTtZAAlsDLd677OO7GrHm1UahD+Cgb6
	0nJ+15UV7eeprbE9BLGhDTlU5iVBEkXkAW/C7iTXRenxRlxh0Ox2HbP6SY5Jtga6xIbs7FwR/Df
	Udbi5Q3X5nnSKVfmRS8lz1yyZ5yhV+Ads27K+mvikrvTAG5GdMFrqZIgN
X-Google-Smtp-Source: AGHT+IHrtN2JJU7KZ/wvcGRYLftLYCliwG5hu54F4E+Tiy0PBPMifAGYKDrE8/6gfN/VqdB9UfZ4sA==
X-Received: by 2002:a5d:648c:0:b0:3a6:ec41:b9df with SMTP id ffacd0b85a97d-3b5f18a8282mr144662f8f.49.1752164883400;
        Thu, 10 Jul 2025 09:28:03 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50df125sm60871005e9.19.2025.07.10.09.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:28:03 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/3] Add support for Variscite VAR-SOM-AM62P5 and Symphony board
Date: Thu, 10 Jul 2025 18:27:25 +0200
Message-ID: <20250710162737.49679-1-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the Variscite VAR-SOM-AM62P system on module
and the Symphony carrier board.

The VAR-SOM-AM62P is a compact SOM based on the TI AM62P Sitara processor,
featuring up to 8GB DDR4 memory, eMMC storage, Gigabit Ethernet, and various
peripheral interfaces. The Symphony board is a feature-rich carrier board that
showcases the SOM capabilities.

The series includes:
- Device tree bindings documentation
- SOM device tree with common peripherals
- Symphony carrier board device tree with board-specific features

The implementation follows the standard SOM + carrier board pattern where the
SOM dtsi contains only peripherals mounted on the module, while carrier-specific
interfaces are enabled in the board dts.

Tested on VAR-SOM-AM62P with Symphony carrier board.

Stefano Radaelli (3):
  dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
  arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P
  arm64: dts: ti: var-som-am62p: Add support for Variscite Symphony
    Board

 .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../dts/ti/k3-am62p5-var-som-symphony.dts     | 562 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 370 ++++++++++++
 4 files changed, 939 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi


base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
prerequisite-patch-id: 7e8493f8ed01ee319f827119ffdac7531afbbc4d
-- 
2.43.0


