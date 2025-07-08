Return-Path: <linux-kernel+bounces-722034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2216AFD2FC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541F81886CAA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B345A2E49AF;
	Tue,  8 Jul 2025 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpIElFVS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F498F5E;
	Tue,  8 Jul 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993342; cv=none; b=YZbCVAX7CD+60k57fii/VtiossAfhSuv30nbbGAvGoFL5fOSQF5H6mo6vgA+G8nvw0ZI8PicREWugl7YFsOO6k3/K75x4MXfwpqz8FdrGSbkUre05meL20BzPb9kExGkuA6aU7aNAKg92WLlLSQ/uGnWA1WYLpSLcItF490Oz5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993342; c=relaxed/simple;
	bh=1gNumA3r3GWXNuef/Bq7M1ZrVMdzEyVC3hw1XVZeZDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STN71nru13MMF66O9hdyMp+s5Z43SiaRC7wYddqXE/5ufnkc6+iP2xzA+OGqNBp/Ja9dQ2uudW2gMW9xXVjco76mu9u3w5fwp2qsQg+qvP8CNUgF/cEtZyQB+2f+J3/odbZh8XP7ulgPSd/ggUhnm9bcCdSxEgnRJlwhE9Glo4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpIElFVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B982C4CEED;
	Tue,  8 Jul 2025 16:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751993341;
	bh=1gNumA3r3GWXNuef/Bq7M1ZrVMdzEyVC3hw1XVZeZDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpIElFVScs7kdDepXVzX8Hv6HhgXfSaeW3ul7jauZjH0wFpF4ISjYG2QO629h5ORD
	 u05aagrOPyeQEv0Mx+0fc2b9smbT77zHZt6pya4otJmfAASAqq0GyowWAchlgvmwg3
	 h+pkeyXKTSTzxrlrBmozXOZmpJIJC8llzDkyLKK7KSLZ2YbfTbaZoAmttKehDfGROD
	 ivDQtLfH1MtnTIlZR7j7THSCQHLtI1j87+SAwTdYrw/J5hcobS4Ifo93c87mJy2O9J
	 Qc684oKClGQ5bG/NRHcgkKLy/6Ko9O9adnR1cyR+xKPP/K3ziQyuPrCNKnBDemhGZR
	 mSkJ/yl1yOomQ==
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Walker Chen <walker.chen@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: defconfig: Remove CONFIG_SND_SOC_STARFIVE=m
Date: Tue,  8 Jul 2025 17:48:27 +0100
Message-ID: <20250708-jubilant-abruptly-8ff77f7986ca@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To:  <0886d3eb81bffbc1d48e701cae21c42cad29fefe.1751988704.git.geert+renesas@glider.be>
References:  <0886d3eb81bffbc1d48e701cae21c42cad29fefe.1751988704.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=473; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=SWq9xtGH8SUIy+j6CnVjw/RxXXaBxMRnkvI45y+m/oM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDBm53rd1q5g8P3e4H25a/HPH/fVnG59f5uvZfnjxvLgfn x89keSu7ihlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEZq1h+CvutHh5+jY+DaG3 rzxOz/rm/+KU3bNT3uFW7LtubT35LEmakeG4Z07R3rWncmXj4yaLlar/vXZu9/qIE1++Hvm63O8 1y34GAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 08 Jul 2025 17:36:48 +0200, Geert Uytterhoeven wrote:
> The SND_SOC_STARFIVE Kconfig symbol was removed, but it is still enabled
> in the RISC-V defconfig.  Just remove it, as it is no longer needed.
> 
> 

As I mentioned to Palmer a few mins ago, I'll grab this along with a
couple other soc-related defconfig patches I have. (Apologies if this
goes out twice, I got a warning last time about a timeout, so ending again)

[1/1] riscv: defconfig: Remove CONFIG_SND_SOC_STARFIVE=m
      https://git.kernel.org/conor/c/493e9b085299

Thanks,
Conor.

