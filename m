Return-Path: <linux-kernel+bounces-874435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C182C16580
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFD13B4F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEED34B419;
	Tue, 28 Oct 2025 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzTG1Xwh"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F79332E15F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674111; cv=none; b=YFmtvEaF7oCr2fJ1hKHTMdKMSkCUub92Tc9vSkM2UcR2xf5LJTClki2FwNTpmDE6E6Db4sdoQMJUDrO3uWv/ZnRqq8aaopes85RieppDRDXrnYTrPRQE8M156/5lM1EJTfuOGXWn6e/CPDxnZ75uGE9rJRSsu1Pf150r0hb2/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674111; c=relaxed/simple;
	bh=LrD+gAr3mCgHeWBY88F2wCwcSzYu6Edc8zM+jYWIbmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQ49cqgrgc9a/Pc/gRgRrlZDEJAmHvFeWz/b6NKehW71d92gefsTlH6GrLI0F3bfBKEhHXwiO7oQT5JaTu7NUnaf9W3fKALh6wgFq6k2pfrR9oriYxWAZX5Uu5oSfqtWAvQAkNea/OS1ZfyFbesiFU/cuocq7DFnCfa1eFnBeOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzTG1Xwh; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b556284db11so5230852a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761674109; x=1762278909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U3u8+wKy/5HlGM6RI2a/NOE11yu9QrpXYgXF/5BbefI=;
        b=jzTG1XwhLBubrVZzl8LweX80MS4knRJDQfKVlw28659CzZfqtMe5jR3Ia2uugPFd5E
         sWvWukCerKrixlAgvDq77u7J/SC0YqCtpXsSUEIkU0iIyUc+PUnXqMgOxCCBciIWHUOI
         N5qECQxRytukb8R/DY3IIep1sYEXwfg+XI1gpmTuS/NbB+ZO03IiDU2ZPT041I8sXRPO
         tlaJV1utaoLwsjqgK9Qm5hkm5zN5aXGn2euTN+wJxXSK0FWnYkW/pRkgpB7idKjBXTDk
         1Ap9i5PKiesyx/fFaGk5gPa9f+mcIUTrNg81kmdWlTsOZAvLmACmK1dUM4fXKPVsRCj+
         ah4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674109; x=1762278909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3u8+wKy/5HlGM6RI2a/NOE11yu9QrpXYgXF/5BbefI=;
        b=lQ2I99SPrm/ehFU90vf/Xu46lMuEqQESEeGCw4iE7UeoKp3NCorxQVTeoLCcPzah6M
         6bin7KDXmNcS2U2S7pqmrMrD8lz6IWNYEeKm1zhYv1+QIYZpj/GO3+Vfd9X/T7dvk+fX
         S1RH+vOyZs7rWVVlOR3ntSMjQRINNQl81s39bFWGx98ingJh7uObbDiUhZv1PJKdd2Oh
         RvFuHXDmr6GYuJe60ELPd16TC8jDwRv/EX5F/vKk75BcsmYhmWeQHWbRymsAzN2nTnhf
         5nrb70zEucBLVnU1KHohnMb6RmlYdOaHvEKVvRm4MxZL9Cgu3DrlfnaQItVmiUFz7KFw
         e/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3V1yoXgCy/JOgD3vIF1wAGKYbEmygrqfiTva+dOkZ+Dym4JT4MIWKXUaVDgMGmdeL5Ypo+7phRkXseIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3MmGgjTwlL5bZi+akmVoOAmRUP4tqk97kJhSC/IVzb+LBzjtU
	wNUKiIFnenqlEF/oUuLDimIdS+Lj4PS0SQs2DDRxZHG6jg1yjD8oCjV4BrZo2cvz
X-Gm-Gg: ASbGncug2DcIiuXwq7VxMd6npQS2Bew7aJS5Pik69Qg1L4n4n0yXk2075CyxnHYJDC/
	C3XE5PNC5SN0z2hCsfjYNZ9aydTjT0d393QCZXY5OVuBQlayWNvLzhRV4yIDbZF3eRCtN2UuuMb
	oEI6dzaQZIVMHuq+DJMZS5tKqUMtMt33pcYKQ8gFiOpPHutsY9I8eFb9uowZNPuARg/n0ytwK/D
	kXyt+E1Yp2y6B83/PIa0WI3c5BUvXKcqF+zflqv1aGIwjrCwEMVphMrwCwSQr3YUFGa/qrgxsd5
	Bo54dtUdMa/hFXK8ABIltq+ZECkeV9AYw95S8khju5GbFF+CbDhN8Is1qunTW8xo+QSa8NXoTBk
	uzxO6/jVTwOY7qxMcgGxVMTNu0jyL5HAq1Ok+4wRjvI2EepLLIUvuFsRE7QYRWnvSKywrt571/X
	7Vh8NthIG2RI5wEp9gzUM1Ww==
X-Google-Smtp-Source: AGHT+IFdrN3NlZEyOHMW3wOhl282yM2u3nvY3T0pgfmj9KMkSCzKHyo+WjcYtvifuJB56KT1V7Nv/g==
X-Received: by 2002:a17:902:e78c:b0:252:5220:46b4 with SMTP id d9443c01a7336-294dee991damr529485ad.37.1761674109274;
        Tue, 28 Oct 2025 10:55:09 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:77f0:168f:479e:bf92:ce93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3410sm125713005ad.8.2025.10.28.10.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:55:08 -0700 (PDT)
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
Subject: [PATCH v2 0/5] Enable Ethernet support for RZ/T2H and RZ/N2H SoCs
Date: Tue, 28 Oct 2025 17:54:53 +0000
Message-ID: <20251028175458.1037397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This series of patches adds support for Ethernet on the RZ/T2H (R9A09G077)
and RZ/N2H (R9A09G087) SoCs. It includes the addition of the MII Converter
(ETHSS) node, GMAC nodes, and enables Ethernet support in the
RZ/T2H-N2H-EVK board DTS.

v1->v2 changes:
 - Dropped *skew-psec properties which are not needed for
   VSC8541 PHYs.

v1: https://lore.kernel.org/all/20251016202129.157614-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (5):
  arm64: dts: renesas: r9a09g077: Add ETHSS node
  arm64: dts: renesas: r9a09g087: Add ETHSS node
  arm64: dts: renesas: r9a09g077: Add GMAC nodes
  arm64: dts: renesas: r9a09g087: Add GMAC nodes
  arm64: dts: renesas: rzt2h-n2h-evk: Enable Ethernet support

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    | 482 +++++++++++++++++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  70 +++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    | 485 ++++++++++++++++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  79 +++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |  70 +++
 5 files changed, 1186 insertions(+)

-- 
2.43.0


