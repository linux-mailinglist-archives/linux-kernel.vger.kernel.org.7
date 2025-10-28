Return-Path: <linux-kernel+bounces-874229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0CBC15D07
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA7F3BA66A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF608270542;
	Tue, 28 Oct 2025 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ldOj4Yzd"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C00A92E;
	Tue, 28 Oct 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668596; cv=none; b=CC6xJxCj+yvkJa1k6odsuUV3Npr9zB9doQWZJrVtmF5JIOJu5Ri3Gzp0+/jBCq8MbE43nEOH3tXEeLLGbNJ8HbatOTA1pw/lNsArBHXeGytrhIz0oL2CtFk8BHtxzCKwOWL3I0MYCPC2yPjfO2jYw6tlDtGDTooHRc87TjiPP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668596; c=relaxed/simple;
	bh=QgyPv8AyxMxEy78bNJxB/fdACx3L2Hi+FDtNBndD2NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urFlPzWHOYJy+qyFgql1bR2azXcRyxyPvhpVtUmnPETnbiZGcit7gL5ys3P5loi+HzZ4ZTbwmxvYSyj5KTZXh8INtSGaWEtDjY6poLDxr8n3BeXh0ef9QtTvN616MMVTd+uwJgXhfiFhW3Uxa15Rhec96WuG8Dh0frITF1IA/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ldOj4Yzd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CD5031A170E;
	Tue, 28 Oct 2025 16:23:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 958E4606AB;
	Tue, 28 Oct 2025 16:23:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D24BA117AC5D9;
	Tue, 28 Oct 2025 17:23:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761668590; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=39Q4QJAbuaHwdppokZlTMSHTUZpVg9kkFS9isAIE9G0=;
	b=ldOj4Yzdmox9S8RzQVtCR1Pl/eps9aaUcg+kOLQRCh6F0fGqutlY7MBEcwLDtqX2WSMAyn
	BWbNdnoXCq/KnEmVcfE0C2IJB8DaED/lNqryn8HTZ9rJDwg6212YWyqrHBczBgelTiSWE+
	JilJPeNXAYSCN59mw8RLo9MbNd/wgh8A1UDKzdBX7+vqOCnLQAOcjS+6stgVBMqJeKLUye
	VG3ow2UkTPfMF+/UCPxrY53QKtuHESI6Ggky06v2QvN13H2LQ+jnefQyi91tw2NZCb7hyD
	/Cl2bBeT8MaT9kEDLU63bN//W3k7IFey7jBOuiQC8yIUr+WkDYlqO0WOulL6Jg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Richard Genoud <richard.genoud@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Johan Hovold <johan@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Introduce Allwinner H6/H616 NAND controller support
Date: Tue, 28 Oct 2025 17:23:02 +0100
Message-ID: <176166832292.369296.13474664579564092602.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028073534.526992-1-richard.genoud@bootlin.com>
References: <20251028073534.526992-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 28 Oct 2025 08:34:53 +0100, Richard Genoud wrote:
> This patch series introduce H6/H616 NAND controller support (but not yet
> the DMA/MDMA part).
> 
> All the work was done on a H616 board with a Kioxia TC58NVG1S3HTA00 NAND
> chip.
> ECC is supported, as well as scrambling.
> 
> [...]

Applied to nand/next after fixing the Links:, thanks!

[01/16] dt-bindings: mtd: sunxi: Add H616 compatible
        commit: 7c99743a0b10d18abe6895c01843aa5d7f8a2a6f
[02/16] mtd: rawnand: sunxi: Remove superfluous register readings
        commit: deaa77ed66bf6ed1f7c06c183bd7a5bc0d931c62
[03/16] mtd: rawnand: sunxi: Replace hard coded value by a define
        commit: 1be7ac78b72f25e0e2ae2288944da31d08edc2f6
[04/16] mtd: rawnand: sunxi: move ECC strenghts in sunxi_nfc_caps
        commit: 94dc08adaf927b8a1d4de606055cf1a9c7256425
[05/16] mtd: rawnand: sunxi: introduce reg_ecc_err_cnt in sunxi_nfc_caps
        commit: 4a3a05681432c4a3bf9f7af3c813baf33bb143e8
[06/16] mtd: rawnand: sunxi: introduce reg_user_data in sunxi_nfc_caps
        commit: f53c74d0577426bcf604dd2f087da812812a6538
[07/16] mtd: rawnand: sunxi: rework pattern found registers
        commit: 6fc2619af1eb6f5994a27e8617ac0911cdba81b8
[08/16] mtd: rawnand: sunxi: add has_ecc_block_512 capability
        commit: 8c1b28ab3e4ec8d709c47928e1e6ecaee873d74b
[09/16] mtd: rawnand: sunxi: introduce ecc_mode_mask in sunxi_nfc_caps
        commit: d21b4338159ff7d796e0c809a29d3425b2864115
[10/16] mtd: rawnand: sunxi: introduce random en/dir in sunxi_nfc_caps
        commit: 1340fa872102cd7eebdcc358965381d5928803c0
[11/16] mtd: rawnand: sunxi: introduce reg_pat_id in sunxi_nfc_caps
        commit: ee61bba4ee7ca6a862ec8c8e76b2051606f25e97
[12/16] mtd: rawnand: sunxi: introduce reg_spare_area in sunxi_nfc_caps
        commit: 6208274d0a27b81ae5425c819810fcd7bf89636a
[13/16] mtd: rawnand: sunxi: introduce ecc_err_mask in sunxi_nfc_caps
        commit: 97d13bcea2306f47d5e54e5a347d5ca5817deb0d
[14/16] mtd: rawnand: sunxi: introduce sram_size in sunxi_nfc_caps
        commit: 5ddfbc68ec7ac92ff64d8420909b1258be3ca8a1
[15/16] mtd: rawnand: sunxi: Add support for H616 nand controller
        commit: 88fd4e4deae87fa66e0e00e2bf6a4c362d241215

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

