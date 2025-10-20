Return-Path: <linux-kernel+bounces-861482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DADBF2D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A6818C14F1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA20332EAB;
	Mon, 20 Oct 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDAJU26Z"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86023332EC7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983175; cv=none; b=Zq9C4mHbx1ZtuznvsXMwo7M0lgsBaPD6KgdqHGc0Oy3G6fwIyPKx2ltfrsonNAdzVmvazHQCoZURLih6BYCpdUhvtgzq72Yylm5Aar57mK33q8raVsXAdKfSgmsVZAm2owabpKA+YjIWaI6hhhiYR/qXMcnTDR3Udh7orqvnFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983175; c=relaxed/simple;
	bh=aUreeKtpN2WmnEqKckespxLIC5wGlm6WN8+84n04a2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkC3b3BuG+s+JdbSIkdW/suiE/+J4hM48jrtVnqK0zxm3mBN9vh4/1/RQk0b1iG4lxISrHzJR3aVZcq0gG9tfTT5xFlLuJyWW0tXxt8mUPhmpKvE/RWhjDSuRqDv4ujMEPngFor7HCLLzzQgNyUILJgiVTf+1+pdgyt5tn8sL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDAJU26Z; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42557c5cedcso2576099f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760983172; x=1761587972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUreeKtpN2WmnEqKckespxLIC5wGlm6WN8+84n04a2c=;
        b=TDAJU26Z1JCMKfmUGDyMgFDWfG/BKzVyeythVxkCiY1UImv2QpnNdy+eFtyd9iPHvV
         mAY9DNLERY5mNX/qTEjZT7JT9A3DEKVoJYEgpStEjf7nz4GPewjBhLLvbQZPxTrL3a2e
         WA4RCHzI4/bPWZyQxVm+PD5BM4VYrFOAz5xMKi3B+NIYMeY9tIF3gU7tTlaDb9HfY2ht
         Heqmi5HMQmlquHu+lpFmtBZfGTIggDmjpxl42gTzV4y50+jVxaQB91o1SAjcKZ/inJlz
         UHMxVqZlqZb5UnGZZp7alNSrnMTaDxuqSXH4kt8Mqcq9DKt4pyoD8wsgr3NQi44cduiR
         mE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983172; x=1761587972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUreeKtpN2WmnEqKckespxLIC5wGlm6WN8+84n04a2c=;
        b=QcjV0pGkUOm6E72tVg81sOOy2rp/mIuwqs1mDC4/pljgv/t8vgA2cD6fYKh7K2ObCu
         ZY2PUG8wyx3ViK9+w3xB2bQuCxD5ycsocKatHLeYK8UMPycLRVXrpSM7etv0IkImWHB0
         xdyxLiKIeUcNUPxC3EwvSTn8jGAqcO+iCqtKxvtyHs94SGcNf1w9o138NmeH7SWGG9fe
         Y1esOJCGoSv2aaPM5NZoPz00sUxlFlVIo+by06RLpgTMzPWEPWj0Fg57yCTVef18jtA3
         yg2ESH72dvWKH857RN8+YotmKzgYcIigxQNFmLDaCTmL7BJ2koKRsyB2kj2NhDjr7Ig1
         ki4w==
X-Forwarded-Encrypted: i=1; AJvYcCU1WTUTKam3vftZJmHZqKUgmygvQJCeyGiaBdMKjbZhYrybZKPV5h6j9AR4RxYwWy98G1gFrkqtnLftxOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsGiDdyrrFrejXGcIPwbXxJGIBZksmuAFhmYtZyDzwaCmJI7cM
	8AlbLCPrI9ls1gf51W5Ti9UZuiKjv3RG9QSQeQivXFHhfizMlpGjkExg
X-Gm-Gg: ASbGnctvBIdeT4gPj7PiWsTy5vPCRywHQ7Wnm5inLpFzqy/UntLTclVfr07ErSXYjxm
	5sCBp4r18gd9IHfrYFYDLzs8kNLm04KQsRm9fJ9QaliTqjYiJG+Vznc1DreqfrkmPyX/D7oo0Kq
	p6AC5G0WP2BSuQiMmveG+G1R9xZiXQf3F6lHhlcOTagegNHvTk2bRbhiq9eJDq6i4H2Ngp8IGfW
	G3T/1PCwhPe8S3Q/6u2f7JbQssFuZiIYBWGF+ru28BjaDgIpdL8NOgiTTS5LguBPZOdtx2ws74+
	OaKR+M9Q4YykQedBH6kA/+EGsfIv1VdPWQpu8RmFVY/HLjBeWJ9oXxZp8O6aj/0F/LBM3NfIXzv
	19cvhtiBvhYc/zB8pGI1MqDbJJaO9Neig71m3U26INjtl+TDENcIVyclwMY7FzfboBqWHCXhs1v
	uuvxynYfHS+9H2e91osKaMqEICgErh5JsRg2cfq7ZLvHRSQQWtFsbgtgDQ+Jl3I1ZC4cA=
X-Google-Smtp-Source: AGHT+IHtpDIuvy4/yF6LdQ4qVWSEOm8AetCbAHS/ajv9TB9bfuiRLOt0expo+wltP4XyjrMHK3544A==
X-Received: by 2002:a5d:64e4:0:b0:413:473f:5515 with SMTP id ffacd0b85a97d-42704da2b6bmr9352936f8f.48.1760983171751;
        Mon, 20 Oct 2025 10:59:31 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm16822163f8f.28.2025.10.20.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:59:31 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 09/11] arm64: dts: allwinner: a523: Add device nodes for I2S
 controllers
Date: Mon, 20 Oct 2025 19:59:30 +0200
Message-ID: <3906069.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20251020171059.2786070-10-wens@kernel.org>
References:
 <20251020171059.2786070-1-wens@kernel.org>
 <20251020171059.2786070-10-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 20. oktober 2025 ob 19:10:55 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> The A523 family of SoCs have four I2S controllers capable of both
> playback and capture. The user manual also implies that I2S2 also
> outputs to the eDP interface controller.
>=20
> Add device nodes for all of them.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



