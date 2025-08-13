Return-Path: <linux-kernel+bounces-766226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB03B2440D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EA8582622
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1D62D060C;
	Wed, 13 Aug 2025 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="iML7KfC+"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5CA22425B;
	Wed, 13 Aug 2025 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073074; cv=pass; b=kwAIqhxLoTGCDHmhSFkQV/pNgHyckatXLmVQCpU6rW0CjkNUpn7hSGL9hFVl8jPVVDymqub76FQtUxs3lf1Zz6+qn1WHjcS54XvnSFrUD43eR3Dm4uHXtrebEUH7v9OMJOh1I2iYkYF7MeyY7YsYw/vNeCy0OqlgjnzjevDI8z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073074; c=relaxed/simple;
	bh=fbnIz5WqvIslNpuNx243zLlNppaPSRl20XGKIkRZa8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dapJz7BfRsLXqKKEhHVb4uF59GbSATuYWEjs/Qt4293H6hEsWft1i3qSZcivddkZzZYhRuqUc3kHo8LPIDCVl8Sa38FDYkF9IuopxAXuQMmQAIZm314qqjLIu6Wl1tJGGXDIqsIH1iwWQ1Oq67dPelwzmdza8TyZz+nAMs5ST4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=iML7KfC+; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755073053; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mEL0yh+bEfgqikWWXY9mC8WYz2uRK84v9xsmZs/PXsJdzW3S7UDHRkWOkfiWltPNjsgCuAi6xX/+wRUBdZchyvTmAaEwm5wXPgZjDdHk5PyJik5TITWgEJe+VEwQpYST7qDH2PVloHJWqTWFuwwi55pa3H64If6fryCOoQzciqI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755073053; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1WswQYdXHZ0BCocJhmpFSpiydZ4q8u4ZkyEkExktUjQ=; 
	b=b5J4lCmOa1pJxnEi3AhfBBrigszbXDS64PRitU+yfQ+zVPiGR53rbzEo3mtwBi1q+IMw/zJw9PckxY9aRK676t73OBFHiDIl2k2R5HJanFPchesr9rpvmgk6SxHPzC1apw7DHNfM2N5cFpecX0Pasj7jc65trUZkelilM2mey3g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755073053;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1WswQYdXHZ0BCocJhmpFSpiydZ4q8u4ZkyEkExktUjQ=;
	b=iML7KfC+47Z7J9ajIZhKyEAZfozxfPT8wvbXyrkSFdSt1IKwIk0o80Nb+YPUd9ib
	KhA5EkqX6mw3wFAWtP9mpV/OYvwmhI26irpwCfL6GRe/1IaQtDn45KIVQcVuDCS3vMt
	JNmJvYqApJooZvEy/nf2MDa5nJG77XfGOef1R5wOwpcvrjx4Obouj3jr+xhymEs7Dxl
	P3tAwyJmvs9ihFx7inM8O/ECQYcH0s737hI6venN5NHEhT+bWoPsPiN4Xzr0me0WLSF
	3sjHDofIXQ9c5ShF5hx7A1z2Rs3af5wZzENb4K4gZJ+Qh0WHkfsr6k1uRa6/oDW/5ig
	0StLx1nIeg==
Received: by mx.zohomail.com with SMTPS id 175507305115343.15769947711442;
	Wed, 13 Aug 2025 01:17:31 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>,
	Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 0/2] reset: th1520: add VOSYS resets for DPU/HDMI/DSI
Date: Wed, 13 Aug 2025 16:17:14 +0800
Message-ID: <20250813081716.2181843-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The VOSYS subsystem of T-Head TH1520 SoC contains a set of display
pipeline in addition to the GPU. The display pipeline contains a DPU
(display controller), a HDMI controller and 2 DSI controllers.

This patchset adds reset controls for these devices.

Icenowy Zheng (2):
  dt-bindings: reset: thead,th1520-reset: add more VOSYS resets
  reset: th1520: add resets for display pipeline

 drivers/reset/reset-th1520.c                  | 40 ++++++++++++++++++-
 .../dt-bindings/reset/thead,th1520-reset.h    |  7 ++++
 2 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.50.1


