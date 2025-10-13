Return-Path: <linux-kernel+bounces-850257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D05BD25C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CDC44EFB2E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463962EAB80;
	Mon, 13 Oct 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QMtTVT32"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1C199BC;
	Mon, 13 Oct 2025 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348845; cv=none; b=Q85UdeZBNlqOWMyfOzhaHfVVEn6VzLzdMkcl8a7mhaxAt1zzUEpf/e7r33tKwwBNgJTUnhwgt9dOcZHl3ghMvpl1RHr65nxoRRp3D2wsC3PWT1I8OAmt7tMbFQakcaUd4tYmV4odHAsuVZjdB0MfsW8DL4P8Tnjx9+ru510pnvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348845; c=relaxed/simple;
	bh=yyzWwMTNAcACtaKwTd+Hy6q4Ei9iZX7sevim4Y9MBwQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pZ0ZtmStOvpg3Oq/BD0ppn51BvrI6zD5KUajeFqkHDcFbDudzlbwe4NliWWRUfBv9PttQrvqlbcH0nHmD/aERsK9RUv7/DenqSPpISOuZjPO9xuq0oVOmyB9q+8X9Rle8AaBsqixJEEnZ9Jyy5zJB04G6KpLs8Lz2oF63oFF854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QMtTVT32; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760348842;
	bh=yyzWwMTNAcACtaKwTd+Hy6q4Ei9iZX7sevim4Y9MBwQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QMtTVT32or9zRYbwMlw5rv+zn4LgwybdfZUUMR5Mq4w4ULIvbGqHh58Kh1A+1449T
	 4NBk84QL3LzzZMy3aJoKoLNLO2AAlBwKgKZKRrZ0NKrtT0v+V4JRBWmwFALc1HWuPI
	 yrXDSaa2vSUhTlIEGln7vUPtwe0qa+ok6Iidn/bf+Rqb7GlZf7TzKH+fl24mAaD5Ik
	 OOVHwvhQgBV58RBOcmViOitrOYWCcFuuY67vmIcxPWBiEFXimiQQmjRwQG5nc5M/Tf
	 hWWAkOlvEUIMkfmTl8lp0Twl1oxe1uShMgdSdMGshpB/QNDZ6gOfr52etu4ET69aME
	 3G5iTa8sGT5Yg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9E40417E1292;
	Mon, 13 Oct 2025 11:47:19 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
 Cristian Cozzolino <cristian_ci@protonmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org
In-Reply-To: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
References: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
Subject: Re: (subset) [PATCH 00/10] ARM: Add support for yarisxl mt6582
 board
Message-Id: <176034883956.23045.13247529000134209670.b4-ty@collabora.com>
Date: Mon, 13 Oct 2025 11:47:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Sat, 20 Sep 2025 20:23:25 +0200, Cristian Cozzolino wrote:
> This series adds support for Alcatel Pop C7 (OT-7041D) smartphone
> board, named yarisxl, based on MT6582 SoC. It also includes some
> preliminary patches. More in detail:
> - patches 1 and 2 add support for mt6582 to platform code
>   (verified by looking at generic mt6582 downstream source code)
> - patches 3-6 do some maintenance work to mt6582.dtsi
>   (I was unsure if squashing timer node patches into one)
> - patches 7 and 8 add devicetree and dt-bindings support for yarisxl
> 
> [...]

Applied to v6.18-next/arm32, thanks!

[01/10] ARM: mediatek: add board_dt_compat entry for the MT6582 SoC
        commit: a9ad357fb2104cc07a64d7e642f6c35b72b16405
[02/10] ARM: mediatek: add MT6582 smp bring up code
        commit: 7f637d718752f1b821f90170bf841c4d924b382b

Cheers,
Angelo



