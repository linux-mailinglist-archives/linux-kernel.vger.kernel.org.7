Return-Path: <linux-kernel+bounces-867798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 440F3C03849
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D987B4E729D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D06274B5A;
	Thu, 23 Oct 2025 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnsevFiF"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4C261B9C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254609; cv=none; b=TMgffbtXKhv4PMak2hGiO6ZrTy62H7M+0a7/T0qdjQ11OMAweSaIzf7DnlvUBrjZxjx6ORFR5cFtlki8J9Mdl2eJwSV6hbwtztJcbpfHutGCdHnGlBLfvJzGRBvVnISd4EP3yC0Vh/lqmmibmx7PWTolHGFtOrfQKUctr3XySRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254609; c=relaxed/simple;
	bh=yFthfjChABU9B3p7kO2QzRL1wEOgO5LPQX41KnTS8X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cj52YT7aFr9Xs/OpesltS6hPGwFmkGjTyhG3WYZcDrJUTpJAO4xWQIDdVXsqWIPtxs3xNlcBsClJTRUsTlklLZisJ1Ms5TBBgPRk8nB4uNVbunoLBi5ICdHITJq/3KP7ZOMHYUq9pkdici2I3LSwngJuQK2NcoRusYka4pH/W9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnsevFiF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78118e163e5so2358297b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761254607; x=1761859407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5by386MZx5aXAJgioDNPB9DUAiuf+2nw53TNdh/FOSg=;
        b=nnsevFiFJlr+C3e5N8IpY+Mc8MRKtEvJJP/oPD/qwkIN+MH+4gsMFq4Ar9U8qNvn6Q
         qb4xWVtcW3NHRqDCzEP4dQzWnWirEh+YNWOlG6e5vGMV9kpnMxG5SNkLbUJ6xb5P1B1i
         rYCfTF1Zq9EN0gft7BEP9PVYqLZnPQGKZYGuGwaA/oghxbh4YOqUDu4fdwwyFpIFbtAo
         /PfqE1swuQVVdyg6mnGPFcLEt7LnhZC1nvewz7nNuOoxe8sdTmYsLzEPF35rlpyygvdW
         IrN0SNS49bwijW86vXVa2oNnDIzxJBiaKY2xnCg6cxlazKM3G79+Lif88SigvaW0hcz7
         SM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761254607; x=1761859407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5by386MZx5aXAJgioDNPB9DUAiuf+2nw53TNdh/FOSg=;
        b=N1UWiRjr3Dg/Kwidq2Ad0ME6i5jWEAzldJ4GJkJPWNHL9HcSGZ2bSuvj1wjwvsqsH0
         fKvM7ymE7PdMTsZ3KQHQnx3L2QXIjQKLhvgzarXqFbKte2iJuK7XZRz6DZK+Lo3r9M2C
         ZbsqBVaYINwlxIf4bSj0EPoEACecF3ajwCKW0SxbQVk2E6niB+C2vKAnkDNlATnB7QYf
         jROEiEO5w8eqRcx9Q2/mIuS6zFv7id9y6HhaVzhIYD1dcL24M6sbxbogmfPOw6BYYkxj
         xSLhQlHtwf1R2JZuNLOS+hFIgGuvI05K2aa02qD0QXs2FFR7DlOGHzjwOtEzieX3NHBQ
         l2mw==
X-Forwarded-Encrypted: i=1; AJvYcCUhL3L8pN1dlbHmYKzB26iuYcjVmmSTBkelMT1PPlnjhNmg8OaT1pNdHqhrz9f/WKRdh/R/1Pcpd8Eg4K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGOvdTkie3SOfrR7dDhdpyCRwSJulrLjFmLJ+HfqUkIYw4GlLp
	Uuq1empM3mVQWX4XmG5eEyK3O/YeyhJbJHiycng7KsQVpuJ4SaP7egCR
X-Gm-Gg: ASbGncs2ONzwqgqCjhBn6aADxoXUN5U9CavysIOE5hdPXKHpza2TyIN5RtfSN9xYCzn
	15wW8lLUoIzMIBAQm7vVcF6+pwCAZVtob2eHu28a7BumT9zQsoy2uaT5u0V7Nrr0vl/0c28CzVv
	EPxXUSEWsPaDhCpDFtk04dDK+PmUAnZUOKHskMpAW/QEj0oScZEOs+hjZrxG3NG0D6xYC5pprFC
	Ooj1hV590grQwY7Wq+iIeBX80mRvDXPfStoLHryhCjLFlH03uprlg+YMcwnVfLDFtMYguGSq0RP
	a8W6BW1MiCRrWwgU+K5Y8bgcTee1l9xZqfowpjVt3G/34h6EkyIke7f0VyJFPq1bfXfCS3NUnBW
	Me333CDEV5OcRTFqqZvS8CC2Fz7+OqV9Nzzhzjv8FcN9KOtf/398vAVErtGVfc9Nr6eQxynh00Z
	YA9xFPukI+qXUZZ/Q8opU=
X-Google-Smtp-Source: AGHT+IHGl0olTWLF8OaNJ/L8hBPnlgauLfY1yN9znwKhvU+1nASIFWBG/XX1hymKLG4TJ2s+SNOl1Q==
X-Received: by 2002:a17:903:2f89:b0:24b:270e:56d4 with SMTP id d9443c01a7336-29489db6d09mr3834145ad.4.1761254606662;
        Thu, 23 Oct 2025 14:23:26 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:ef2:36b5:9454:6fa:e888])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda7949sm34306965ad.3.2025.10.23.14.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:23:25 -0700 (PDT)
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
Subject: [PATCH 0/3] Add display unit (DU) and MIPI DSI support for RZ/V2H(P) SoC and EVK
Date: Thu, 23 Oct 2025 22:23:11 +0100
Message-ID: <20251023212314.679303-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
controller in Renesas RZ/V2H(P) SoC. The first two patches add the
DU and DSI nodes to the SoC DTSI file, while the third patch enables
these components on the RZ/V2H Evaluation Kit (EVK) DTS file, along
with the ADV7535 HDMI encoder.

Cheers,
Prabhakar

Lad Prabhakar (3):
  arm64: dts: renesas: r9a09g057: Add FCPV and VSPD nodes
  arm64: dts: renesas: r9a09g057: Add DU and DSI nodes
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable DU and DSI

 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 89 +++++++++++++++++++
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 71 +++++++++++++++
 2 files changed, 160 insertions(+)

-- 
2.43.0


