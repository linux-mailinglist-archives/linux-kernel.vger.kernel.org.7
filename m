Return-Path: <linux-kernel+bounces-844223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7950BBC1551
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97163AC101
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641602DE6F7;
	Tue,  7 Oct 2025 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpDTyQu9"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1457E55A
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839337; cv=none; b=eujJbtoGiGIFzTi12pYUj0/fUpdN/10yzwZvHXqVTXvG5WeLv9iz8bXXm3yoVWX6Nrdw5Blf2bCclrsuJSMYPZLQD2SBE6cXXsjIjsoC50werasWS1AbBQwB+Al23W/bCJ2kia07eHfowEntqgWTke03jVCVeSFUiaQybsW2lsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839337; c=relaxed/simple;
	bh=o5Vm8gv/dWeltWLOsORUwUcohSNsrHZokwCLzeCB6FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXjhkZ0RIhsaamUkWfKwufGtk2GMtX/6YmXjOihM2oHX7TIQxDqP6DPS2FzK//ojI+IFk1QMh82bA4LtLVAzctiukRNK3Uwaz9cgDqf09D5gckJihpB3wAvvZBC/liSAtTs69PuxQbhIZLH7JzL3avyfR/KQsz4mAEhbiGGNdK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpDTyQu9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so1027929f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839334; x=1760444134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIGcPIO4pwJ20cio+6iwr0NsYTVXlvXAH4qCjEgK5s8=;
        b=VpDTyQu99fTTtxRrOKBXxBU6JkeZecg6qCflknFXz+4xjKxdysLy1sl1ZmcjETrKnT
         rkYd8f6SXydfjw/XHlKgCFtdrhCMhrBAlW6ctOnGhry3iYths05MORWatLl9d8UZPebW
         Y95u4DF9bVIi22EHZmSA/QhVs5Q2akD+CACH9TJ1xuGF76OqDqABfH3+yTgntemeRmRJ
         poU3HuytyvNc5cdQAL6vxQBdkmqQVgaNeKAADVh75hgSiMxNiqRQuz18NwvtvG9I57kI
         Tt4sEEWfWly5kLtgpg2q3vvUh3Q+IXR2IBBlHvr8kgPTJltckWwGFxP+C3BhklHec8GU
         Uj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839334; x=1760444134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIGcPIO4pwJ20cio+6iwr0NsYTVXlvXAH4qCjEgK5s8=;
        b=ZPTTcYP3FpUFJZNV3NY8bkTkiOwXD42NC9d0TIRUMmr5bU2OKqLIfFjRX6AZYsLxqa
         NivaUv7GshKII1oxss8lcJBULVJtcv9NJdvPT87q51PcSuA+t8Mfco/90awDETQHmAi7
         aUsamEshTbh0GZhO+KmbS6RLAnxn+59xN4/MZBVg1yragQdAKJ3XCyDbGf398fEoccou
         toM/6rN7L4ltsHKfMopkFhyCVjuD7KJ0YqMnswiEbXFfhTQ7RtIbzXhDPsxc9uu7sIcr
         cor38+QdczsCFlrcVKAROwlBC4QyunQCQfGW/S2Cz0FlUspZ3xFjtIK9BAAaHEU7qCJh
         klgw==
X-Forwarded-Encrypted: i=1; AJvYcCXJJNOS80UZStAGmkdaV+5yY5LCDcX0H2+0LKs8eI9RdfiLY/9kRBnze492BlJA+w/LbZaeClCoSG+sjKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/fmZppJkHoLn1+Aw5DuzXng056cP5htSJSdT3YpnudtoSbso
	OKA+f4mqXW6b6XSHrNvG4/ZkWZGDu9uataEIoNfFpQV1VS0qayqFORUe
X-Gm-Gg: ASbGncuITVprb28H4kjyeD3DCiwDnOFa/D5ejPupi3Fol2mbV+J2aupA1logSM8JQVg
	TfIec+HmKk0oWuqWOqTNMDayuy7TuHGXtkqLZb8BJ1KTGmuZxDWU/JI/9KYe5Rpn/rxaQ0fuV5W
	jJZOsNCwvPhY21o6I6hWNA6PKmjwyr3Wfs7xq0FtNrDT2bVwT8VokdfAPLGlNexJIss22SDYRMT
	cTUCK/7VjFFAwypjMYN9FAK4Yu34t1y/uE08xiMMl3EXpX7qPiZB1oTdW6C/mZBZnwQXspIbLSE
	kidNMCI2JemQuwWRhHN2nX3PP72qFgh6wBWNo18zGEvNXwWuv5gI89hMFwlhntxeKvhEylYWHRT
	bkVNGryAL6jdMNgFTQphMPVkRAG1nRZOp86Yf1P8q6uTb1+W6SYNMvjur396JrKLv/KAKAUfW6B
	XW59of
X-Google-Smtp-Source: AGHT+IF2LSiQFvLIeEfaTgaJIYpO93EW0f1AR022pw4muAjwpr+/8fuU227Foup3a7Fps8cCIR+d8Q==
X-Received: by 2002:a05:6000:4305:b0:3e8:9e32:38f8 with SMTP id ffacd0b85a97d-425671512f5mr11397546f8f.14.1759839334129;
        Tue, 07 Oct 2025 05:15:34 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:9667:4f0f:586a:20c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6e1bsm25590167f8f.8.2025.10.07.05.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:15:33 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/4] arm64: dts: renesas: r9a09g057: Add Cortex-A55 PMU node
Date: Tue,  7 Oct 2025 13:15:05 +0100
Message-ID: <20251007121508.1595889-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007121508.1595889-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251007121508.1595889-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable the performance monitor unit for the Cortex-A55 cores on the
RZ/V2H(P) (R9A09G057) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 267fe91b31d9..40b15f1db930 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -135,6 +135,11 @@ opp-19687500 {
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
-- 
2.51.0


