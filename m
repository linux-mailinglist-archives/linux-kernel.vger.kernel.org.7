Return-Path: <linux-kernel+bounces-883651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACA2C2DF9B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BE734E98DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B99299922;
	Mon,  3 Nov 2025 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktjiQB88"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BAE28D84F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200265; cv=none; b=QfJaCNTBNrRl/Tlw1Wzx9UQFxwnXlWLv7KcwfIcADc5QmcOPcNQBB+s3rus/qVZASTeUI0GwrizSZClVbAcc5/I3nkyP42jKSVVNYhpyoOwa3ElFqLlySSIytx+Z/ujlBqpMhuL2diOJOaTjL96g0V77gsZgVhlZWb4l2HwBBLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200265; c=relaxed/simple;
	bh=ln6i411kQ6CJHX3AEbJla0cNUW37Yxjo8v/tjCWbTrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKG62fb7niyDs9LhGQ46gyWHrYOShQHVQ8FlgzAClcHv1NOPygcHHiRZNAezCM3TrueW0dD8CLU/BjRIqKex0fPPiR3xAMWtmxfuK33MKD88QzAfNUDCTpc0XbQIwKG1FUV9ojl6Krl0RVEzStV3nX5UBys1QJ5UYxV9Q4ufcKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktjiQB88; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso4384817a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 12:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762200262; x=1762805062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9PlQ6g0ZlyemXXjDDNmNoclmHr0fzKsjRa3xohO47M=;
        b=ktjiQB88mmnaknuCsG9RA9Ht01yuNbk/fd37aU0J+Rq2Cxnd9SgXMXVSs0NadS+O3x
         o3BwaSEUALHosZN0y28Ohes/+TKj1uScz4fvCdfk1pJwrfZq1xz/wlZhFowLYGU4A8Au
         FE1eTaamk+bpfS6Jg0rCfdjxOzwejHIbCYpm+FVJG29IrqdCDE09DxnBJdxD6AifQzj3
         XrgIYkK73YUOhndUmqi+Qo0ZZBIFbKA+u5uQkFhiQ/QSOhRj+LgBh631mQiCkdpdc9iT
         /+unyFuJqgdwyS4XBqtddSrdHd4mO/wvHRlVDlW/bbEZm3SK2+as5e6+VzE/qFzcfDih
         3wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762200262; x=1762805062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9PlQ6g0ZlyemXXjDDNmNoclmHr0fzKsjRa3xohO47M=;
        b=wppHMg7mgNoH1QSQ7bkmGwSUYgeEcE2OhtRaJ2BIHMbZzF4ZlMfWWxMe4XLccvAsFf
         rGeL5G3CYVfcmOprkxKJ1T23WuW5H6FvvgDTtUSPz6sg83MmSixUiIXpaIR7CQJG5JJc
         RJwGLdRKaJi6fk0k6I7N98INA8mmU055139djrzOR02A43LbHdY2d8V08Z3Aag+tnywb
         aOv+7buQ1+up8xsehiUZs+hxWUQz8HRE+C/qaPnym2Em0y3xznXQ6kuT9WVU72DzyZgX
         +BTzd0O9YkrzDWn0oM9oNcRsfK6XKY7SliXdIqnbksKaCUrNIjJAhn7FY9e2byw/U3ps
         CiJA==
X-Forwarded-Encrypted: i=1; AJvYcCVsu0xvsANeGYcTWxJ6rmxFpUrB9Gw01urkiVGKuXkZwLIzNqsS08/e5xdZu+81uBGqM5fDQWZKBU8SNzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOmbtlKWDn61vnFhKI4v1/B3kuYtuLbkLVkCD2myavOlaal20
	PtOoaKLxdYi0JxY5Ez7Z7XNjzPXRPtmMz/HkS7FfJ7hbFYnL0AJzu1/r
X-Gm-Gg: ASbGncto0+0et+7JMy7MhtARP0W9hz8GFHbh1DNAaSZXoYFcU/+3ioMSiKCFwxJp8QL
	Qty8yRoSdkeUklaTrLVasEFI67sWqjyd5qqrUNcrQdzFKmr++ZKi4dqqfd+vpfkVRW/McuLudtl
	8E8P0ikEjEg6p5iKP7GWXXSxMW9nZIOS6TFQ+QXTPb0M8wPYDj3ClPU0SvCypLmN75ou8jK11J8
	9PTuEYUUjSQviyhhO3+6UI7DsIuljKOwuax60wsMWinfvLeJNHa0iUrvMUgx4862AxCQikfxsPQ
	Ts2IKqVZC3Cndtdy8B3vZ06kaTsGC3/k2TFM/l2UxyBR008E2pPz2Q061yTPutEj9Rn66nzDRXt
	ymLPL1BF1NByjIVRRzeqB6t4AtDmPBFc7xENjxWssfnRm1XIOg0S61fkWyTSE/fgQO+9wqLpI4h
	sbNKh3jEtzLs/x/CQBHjlXMvvT2lIAxwM=
X-Google-Smtp-Source: AGHT+IHBzT0XgLzw90Yol8EUTMiqYk30dZ78H4h4McimJjXV0e24kxaiYrqwXf7YsQugI70u2j9xaQ==
X-Received: by 2002:a17:902:e74e:b0:295:8db9:3059 with SMTP id d9443c01a7336-2958db9335emr91532855ad.38.1762200262262;
        Mon, 03 Nov 2025 12:04:22 -0800 (PST)
Received: from iku.. ([2401:4900:1c06:600d:df45:8e1:7a61:1482])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952774570bsm127494895ad.99.2025.11.03.12.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 12:04:21 -0800 (PST)
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
Subject: [PATCH 0/3] Add display unit (DU) and MIPI DSI support for RZ/V2N SoC and EVK
Date: Mon,  3 Nov 2025 20:03:46 +0000
Message-ID: <20251103200349.62087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This patch series adds support for Display Unit (DU) and MIPI DSI
controller in Renesas RZ/V2N SoC. The first two patches add the
FCP/VSP/DU and DSI nodes to the SoC DTSI file, while the third patch
enables these components on the RZ/V2N Evaluation Kit (EVK) DTS file,
along with the ADV7535 HDMI encoder.

Note,
- The DT binding patch for DU is yet to be merged [1].
- There is a fixes patch for FCP binding that is pending review [2].

[1] https://lore.kernel.org/all/20251023213350.681602-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[2] https://lore.kernel.org/all/20251103194554.54313-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (3):
  arm64: dts: renesas: r9a09g056: Add FCPV and VSPD nodes
  arm64: dts: renesas: r9a09g056: Add DU and DSI nodes
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable DU and DSI

 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 89 +++++++++++++++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 69 ++++++++++++++
 2 files changed, 158 insertions(+)

-- 
2.43.0


