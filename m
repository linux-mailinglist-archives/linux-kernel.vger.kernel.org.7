Return-Path: <linux-kernel+bounces-785767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329C9B350D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71852450FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E92295516;
	Tue, 26 Aug 2025 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNKnJBCu"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886928A705;
	Tue, 26 Aug 2025 01:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170603; cv=none; b=WWo4+cAjwOALURgfr5Jj4VTjtTUTmL8Jzks6dYRN65a01exmqCp2bUaCZS37OROZaVj6K4psQkUB2VJQNkvuOgED6eemlvwRfVdBWsn5l0nEUpFAiQmWw+DEadBPgiQyTGcYXDvsHm/20NuJ6GZQxylPq99Fa0EF6WgAf9l4CBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170603; c=relaxed/simple;
	bh=cnETHiuRSssaBEiTgdPtwlHAn/fBOMXmkTLrBzYJ84A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AUUmMj11+VS3mw8O/CBGC/Ku3AxmNfHLdp/xthLu1ODcSIzpn6T1xg9RRzvLTJgpi//MC4P3iBnT7NpP9coHslDjhHE9LeGoVwIECOtY+okIhC3fofTpmidlcWq1f1v+E+eei6cQ64dEOrsWTtOYtBNd5DvjFjkLA5HTDKJjze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNKnJBCu; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30cceb749d7so1631114fac.2;
        Mon, 25 Aug 2025 18:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756170601; x=1756775401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fr502dmQ4odPuahV9+jfQPzgPn5kXy7yEDTTv9ShcH0=;
        b=nNKnJBCuskjRWAdb1OnVc26dm9rsXqlz4wp9zPADNg2kGa1TKMkOoXjBIqLKZlnKq6
         Sajfy/Ci1+Mja12Cg5SwvBeFEpe4t0buhnv7imyHiFUuuqefoPLSiNTlXR8H5ALnuZKQ
         NYF11e+XR7TKB28C7oFVF9OESzb0enAsZGPUMf0gK+1zYMo4I/drWhijcmPyY7wQI1Jd
         pMHbg2psaotl5jqo4xplp6sya4m6ZOGHjISob/jwHkQ81fy1fehYoKw3fBpnEWpvQ4A1
         msGiORZSTL9zUtikWQckb07N2blsXuvtQyvmA1wim7/np89k+GwOji44Q0UrGJJXJIAc
         OEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756170601; x=1756775401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr502dmQ4odPuahV9+jfQPzgPn5kXy7yEDTTv9ShcH0=;
        b=lHo64Rb3fIRTdEo7qasc23MwfAjLtUe9HvS0e8aXAn2Ki6BLL6FQ7RQWAYeoBlaAsm
         2m8htGqklDEjjI8vcMF8ZEuVGH27QnVG0m1HhUDYec8DwvIE1XfNcUGMP7eNsdffYt70
         GjKTEcIJAFvfT7E5eBuvYmVJmuxe1pJZM+Eu73jqV0WFg+MT0dtQjc/Pz997CsQ2Dr3w
         6YX6nR33ck1lqQUzrQd/94Z7c/XkQcrj7oEAHuuY8pIgkGmv5G75syDyAW/cri8tKEgd
         b2+eJ1biv6Q1L0TYIRspQc6p5cG1AA/J3E6KAvX5nTlUAf6BgTO2SRhywbUTMr2s+LT0
         HNPA==
X-Forwarded-Encrypted: i=1; AJvYcCU0LVwDv+epEwNrOgwmZIdX5RocUWMK9fdhTf4M72e+dKxBmBRQiw6nMJlxOQzD2t4Jf1cI8JOL7tYjsIOl@vger.kernel.org, AJvYcCW+SizrF/4fE7HbxNVzFSfy2iX9oBDbn376Gu9Y8CAwPq7/8SvOUGgmS+530RAkE/6cR2YlonDKbcsA@vger.kernel.org
X-Gm-Message-State: AOJu0YyQqkmWudskBmns9K7lzDJRPFFYfRUote5BCMmtZyJY1jHYcR6W
	8muoEyv7gkGoF0yYxsw/8hmTEWao9/OFsgL/gA+vpkLsge6fD3/Ge1kH
X-Gm-Gg: ASbGncvdGk6AptA39sbrA2zzomvN/ZcDnuDNJYewg+xuIZmT3UtJdanrIuyDwdf4+PQ
	3RCS/PDIc8S1eJcxrteeFEkDilbGTno8kbDreJ7kkEMHhAnSkeOMbXO5EdTy8R2W0CvMWNiQzGK
	FaNYQGVpJZn5XDoM4N5Ulkx1wxg6hhadH+/GaIR+Z61dwlw2gvdM0B1I5jbuIEQKMbsyjk3wfzx
	5ILFl/Hyv0qdVeGyBTITJac3CYN/wSJaLIQzyF+mRiVBVALoofF3qvB4niqsg1jFYz2NUyPfu3n
	9uxdZZsVtJgTphwnfXWTgw7MzAgQTjSV2nG88zc4IK6EuIG7oL3MQ2KGRDKGfyb46OHMsP/JtXn
	bjbsDRvGfiLRoSo7EDT9M+44fHuGQa3jP
X-Google-Smtp-Source: AGHT+IEsQEcjW1z7CYizlWk5Kdag1/FnHr2VMtUprwv0c3Uuh19bv5SQ7f4+YOhBfQookgotMBtBBA==
X-Received: by 2002:a05:6870:35ce:b0:30b:b7e1:b3fc with SMTP id 586e51a60fabf-314dcda8715mr6397465fac.37.1756170600590;
        Mon, 25 Aug 2025 18:10:00 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-314f7dd474fsm2181363fac.34.2025.08.25.18.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 18:09:59 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	inochiama@gmail.com,
	krzk+dt@kernel.org,
	looong.bin@gmail.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev
Subject: [PATCH v2 2/3] riscv: sophgo: dts: sg2042: change msi irq type to IRQ_TYPE_EDGE_RISING
Date: Tue, 26 Aug 2025 09:09:52 +0800
Message-Id: <edafa432c80a328d80952fd40753d1c8cdd5364e.1756169460.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756169460.git.unicorn_wang@outlook.com>
References: <cover.1756169460.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

The latest MSI driver will read the DTS configuration to set the IRQ type,
so correct the IRQ type in the DTS to the correct value.

This field in the DTS was not used before.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index b3e4d3c18fdc..6430c6e25c00 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -190,7 +190,7 @@ msi: msi-controller@7030010304 {
 			reg-names = "clr", "doorbell";
 			msi-controller;
 			#msi-cells = <0>;
-			msi-ranges = <&intc 64 IRQ_TYPE_LEVEL_HIGH 32>;
+			msi-ranges = <&intc 64 IRQ_TYPE_EDGE_RISING 32>;
 		};
 
 		rpgate: clock-controller@7030010368 {
-- 
2.34.1


