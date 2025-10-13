Return-Path: <linux-kernel+bounces-850247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE6DBD257F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BA71899E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD1A2FE06D;
	Mon, 13 Oct 2025 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nKvUsihU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E82FA0D3;
	Mon, 13 Oct 2025 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348555; cv=none; b=n2Zx7Bg0tx1oEyiPA2D+sSWGsXUIm2Xms1NzqzG4TtTQe62Itni/h85PQVUMSWjGAgMc3lnqIeyHVR7ptZK+vWVUE09SIpmiN6fyVsuRMfzvWGzdQA3mZ7CsUltBRTQ0O79/MUdd9cYny1lXLZe2crgPa8cPePivQ6LoRZ0nmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348555; c=relaxed/simple;
	bh=214Dajmg0oakMhmrau+WfKp7HaFOxspiih+ll6xoZrc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oSrjqoLTDxFW38LJJvH9vsgz+tpq1mlP25lOOa8oBcfXuqbsgI1uT+LE21zsZJ8XcuXo49WQ9HmL8bRHI2v9RHbFsveYcPJcrgMwKNP9G2VeNB4XSvDwlIhGkvYM51mSbVssi6Hy6KtbA/wJe3337WlRTzf6GpoDV+PYQBzaxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nKvUsihU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760348550;
	bh=214Dajmg0oakMhmrau+WfKp7HaFOxspiih+ll6xoZrc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nKvUsihUlsIWIIjyXxJAOXoWsrzMF35QZuvwR07iQeSv69v52O6YB52TbWKkw2ZXt
	 Ov4R5KZZZsKu45giPfjxhV22BWSHIApNOaC/oLTf45HPbGzwHYbW75NYgW07vqsdR/
	 SYGWI0ikLX5dRgOGSccZFdqC7D6eoun2daBExvc0UtwonRcWITN2DNJGRQC+oGOazV
	 Vs4AM+uvVyWIkkbWfZJjXLAxmXYVq3fyPsmTflP/R6PmtQO9KdiY+7zvgFt0S7gmbm
	 dLO4TDou+ddabf5pn740qYlkdfItQrmcDGWXYxXJHdaOT1TUWvWStumBfOfNavm2Al
	 QALo5F5dkMKnw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1BE1017E0523;
	Mon, 13 Oct 2025 11:42:29 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Frank Wunderlich <frank-w@public-files.de>
In-Reply-To: <20250930021656.1394942-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930021656.1394942-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH RESEND v4] arm64: dts: mediatek: mt7986-bpi-r3: Change
 fan PWM value for mid speed
Message-Id: <176034854901.22371.15796783278122302723.b4-ty@collabora.com>
Date: Mon, 13 Oct 2025 11:42:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Tue, 30 Sep 2025 05:16:56 +0300, Mikhail Kshevetskiy wrote:
> Popular cheap PWM fans for this machine, like the ones coming in
> heatsink+fan combos will not work properly at the currently defined
> medium speed. Trying different pwm setting using a command
> 
>   echo $value > /sys/devices/platform/pwm-fan/hwmon/hwmon1/pwm1
> 
> I found:
> 
> [...]

Applied to v6.18-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt7986-bpi-r3: Change fan PWM value for mid speed
      commit: 8365a3e1fdc3e9a69114165877e0ca281ffdc8de

Cheers,
Angelo



