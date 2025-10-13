Return-Path: <linux-kernel+bounces-850237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DFDBD251B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6B33AABF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ADD2FE076;
	Mon, 13 Oct 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UpVspcs4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821CB2FE053;
	Mon, 13 Oct 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348115; cv=none; b=RwaqR/eZt/NgXn9Sjj1L4OEm0eczoSi69Gk8VDGtUOeeCVvjKGByjAlShMrwDkdYqOHrc1MgtQ4133qsfSdmuSibOKC0vLLNOUTf+oggOzzRQG33ZazBQawCXAutQ3na7ceoTYuN0m6O8gdIVBlsI7EpY+uRstfoGn15xQqJGos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348115; c=relaxed/simple;
	bh=bfL1IYH8BibJ2nPO35tm/brwL9jRYOHCupbnViHgTC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j426tNI7m0T/njaIzRUYSKV3IhurRPY5xEvbGKwSNSpjRRvVYSPwm6fys1EJkA3Se81y4k0na2vVyCieMCk21sxipmO5NQOOWDQeHZAipUiXX+rm///rS4mxasJYih9lTz9jSEzIxlkABEbC5DL+S2cRCab/t21cphfMwkKyZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UpVspcs4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760348111;
	bh=bfL1IYH8BibJ2nPO35tm/brwL9jRYOHCupbnViHgTC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UpVspcs4NU8hEVtlvhlE1NG6P7p/g37hclIOwLocxIHsvonh58l/41Rf5XG4DsIhG
	 oLa2EFnlFn1Hw4vaJ7w3X4vlcBB5FEMa6fVOC3YIgkKvAL/U2U+7P7L4EB6Eai44+b
	 FOnWTzFFGqU6LoeW+lJsWd+aOT4U232HRCWtj0QhuIHI56D0imH0XLxBQMmnoH+vrC
	 LS+ESbNd06VYGmO3i6D4fe/BDJ5zCU1FLIhW9zci8vpoMHnXFUfoDF03r25PpU8atR
	 qCdhXhPE8Je+zjbdARsXceQqtcwoEI3IVX3mIBt4iq3wufVYEt0vmK2sHZXaAcO6Hq
	 LBWkVCGCmcUkA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 00B3E17E0523;
	Mon, 13 Oct 2025 11:35:10 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, daniel@makrotopia.org, 
 Bryan Hinton <bryan@bryanhinton.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20250922035828.2941327-1-bryan@bryanhinton.com>
References: <20250922035828.2941327-1-bryan@bryanhinton.com>
Subject: Re: [PATCH v3 0/2] arm64: dts: mt7981/openwrt-one: UART labels and
 console
Message-Id: <176034811095.21265.12249221887009507081.b4-ty@collabora.com>
Date: Mon, 13 Oct 2025 11:35:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Sun, 21 Sep 2025 22:58:08 -0500, Bryan Hinton wrote:
> This series makes two small updates for MT7981:
> 
> - Patch 1/2: Add stable labels (uart0, uart1, uart2) in the SoC dtsi so
>   that board dts files can reference them directly.
> - Patch 2/2: Update the OpenWrt One board dts to define serial0 alias,
>   set chosen stdout-path, and enable uart0.
> 
> [...]

Applied to v6.18-next/dts64, thanks!

[1/2] arm64: dts: mediatek: mt7981b: add labels for UART0/1/2 nodes
      commit: c0a824edb6bf694a2d5a9eede29e1628f093cb22
[2/2] arm64: dts: mediatek: mt7981b: OpenWrt One: set console UART to 115200
      commit: 36712c5cf980980139bd8f7b84b1b6daec068857

Cheers,
Angelo



