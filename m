Return-Path: <linux-kernel+bounces-889955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6876BC3EEA6
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E78C34ED3D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EFF30F7F6;
	Fri,  7 Nov 2025 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9MrxBue"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102326F46F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503384; cv=none; b=guVRl3s59TFOUYDfPG+cKkVxPulYZcc6ii68oWv3Fkmgft6Ax2g1ESAyK/it3KBeVIv4B/OSRpNEE4EFMBSPEBySJPKxrzI7iqygTArOnetX10u+3nClSRBU1p70XzZ7RuuIx58nyORoGGYrKewrYp4SA31MMGlB4mQZG4mhM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503384; c=relaxed/simple;
	bh=6fu4Rw4bj7XVmwOpfJbywUk5eKU3qQ9m26JubATgidk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PKFmpFA9uCzjaXxk2IYOU8uTtqaEqia3oP8tVIv57UBXchYQSjy9+wB06KlbzcjFTyFn/34zRXMCdhesc+f9NsEPZfu/BO2X3JmoiHXO2tvlUCHlAF40MTk5RX3F2FvGVEc3Qo23wytcsLQL6z4SmEBk13fFAqanFeRIpZ7aJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w9MrxBue; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429b6e25316so66169f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762503379; x=1763108179; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uELcMz95SDx5Naos81L9lhwHxN3ut3w9N0e/c+w86TE=;
        b=w9MrxBueCBM4058UIIdQmaGCIm6z/usxYFyQfiveopYwMQl5l2T/sii1cLydF1n1rd
         KCCtyFgnk/+7kW8V2hl1/2OQ5erIiFsN7EjwqrOMe3h3CcW4W+9uo3h72F6GNoINRAap
         S1HiN7Fbz6ILK57JQOYKQOI1IcDdabvMoEuGFkAcNkWKZIVJTurNaUETWJJxTKp/+6Om
         Ag0sRgLET8obMG2ZUwcJ+jnJ7W1ATWbLZLKQvV/S5ZBVKsttEvC90jV/0S246mT1fIpm
         DH4bm16Z8qRssmJ6Epax5MSjVdQLksYnLQrDqsIHIxTbgtHzAYNnAFOTxJKEuLrWy5MR
         B6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503379; x=1763108179;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uELcMz95SDx5Naos81L9lhwHxN3ut3w9N0e/c+w86TE=;
        b=ticrFE6B7fWKLsBMhkcOZzwAflfwYuW0TT9WTRA0AiIc9KJ7c/oAjkIJqFv4SIhnli
         GAOQLHOc+wl/vdomZOiXHzaIP0WB2l4u+mDLe5anbEjkeNcV1nBEJLgItscyF9XOAHbV
         6tdweU4s0j27G2RZR3+nxTu4JITVQS5zQ4ITLmAe9fLCDczyOygAOho/JzBHi3HbelAU
         0/JG0WP0LWyq6sjbTXpoElu3YD9j1YgzXFiDRveh1Sm99GEt3x7b7wlqJZ6VdLku+YX9
         nFJyMKuS5iX62y0POJirwDoEySUbYGg4nPbudnbDXcCyAfhi78Xd9c7IQgpHrf9bqISd
         dnsg==
X-Forwarded-Encrypted: i=1; AJvYcCUZyq7HXp73zBQlU8oIqUbGNamlGDhpzWOl4Lms1Fo+A4ysDi30DAdRolejjzOxziFmKD18rqWcDtmKZ/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyli0i9PSA9GWH7Jtixw8HAIY0jj6osYdLB0oEtxSc4etaJkjGY
	FDH2j6w0mAbhaOGpHQccg7DAYxxfATPvw85ihFmzcvVQJ6jt582gEQ075THt6x+NK1Y=
X-Gm-Gg: ASbGncv1JCNkmpDNgH7hCudAS+6lhfu/wW834mAC17gibyKn00oGNV5mwcTsi2hlQkW
	OAWoAQjklx15NBYpZvNPO3Q/sT2AkiTgisIA+RA9NLxwZMWV/x5x55PEktme+aDOWULuxpwYk8w
	i0r2aD90YE8Q1UAgo33U0BjKPwX3cMHemuYuYE6GL+W0T2ZDs99jd7mAyQwoL8B7NsBM2x2WqLt
	bqtiqaP+vubRH/0MEE3CJ17PpOUj2rm/KUSCdcFIcjTVCN7j72rPjpjzZuBaPPgagQoLOoIGxJ+
	B2PtzZVeReJHHjP6wzpvB0VM5XrNcTjqh85lcMbf76ZmYDSxPIJ8XZoRM6nk534xDTtV8rcMkTt
	bIwlsoo+1cqj9+ObzViCgG9pmQxkHJC1y9jP5iYtRgZdrtgtSxBvkMZzEstd0UV7zDmmthT4djH
	+dT2N6k+QKn8hVe6Zv
X-Google-Smtp-Source: AGHT+IEmTubZGMZAqxPOzEDTzxTbWpyiPD1tGLIDI4W0EDrlhrNtXRyln+2uhSIlbuv3XI4ne4/N1A==
X-Received: by 2002:a05:6000:1ac9:b0:429:8b56:34ef with SMTP id ffacd0b85a97d-42adc6779e2mr960634f8f.1.1762503379288;
        Fri, 07 Nov 2025 00:16:19 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679d544sm4058381f8f.46.2025.11.07.00.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:16:18 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/6] crypto/hwrng: Simplify with
 of_device_get_match_data()
Date: Fri, 07 Nov 2025 09:15:47 +0100
Message-Id: <20251107-crypto-of-match-v2-0-a0ea93e24d2a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALOqDWkC/3WNQQqDMBBFryKz7pRkrCl01XuIC42JGWiNTCRUx
 Ls3dd/le/Df3yE5YZfgUe0gLnPiOBegSwU29PPkkMfCQIoarZVBK9uyRowe3/1qAxLdyXg/khp
 uUFaLOM+fs9h2hQOnNcp2HmT9s/9bWaPC2gxk7Fg31vvni+de4jXKBN1xHF8uZyb+rwAAAA==
X-Change-ID: 20251106-crypto-of-match-22726ffd20b4
To: Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
 Srujana Challa <schalla@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>
Cc: linux-crypto@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@axis.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=6fu4Rw4bj7XVmwOpfJbywUk5eKU3qQ9m26JubATgidk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDarIPqzE8gYmyIPgpBoYUentmTYujrqLdqMxg
 nfDq2usrU+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQ2qyAAKCRDBN2bmhouD
 12KCEACUfEnZdBiPrZ7Cu0XbGMjd8WCKirw6LS0rhqjmqk4qgMZn0fMly/hwblto4whWYMhRsBZ
 ys3Tb/UbcQQMbinVZgziLOqbInfBHaFUecVyeF521+hCZItEPfWpDAsVFfWwhPHE5iKNWiGMmkt
 8oXBzKjseiW7GVG05X3aP1viMQSp0gFmVHh3S5bBCvzdq9z/KYnXRzB2LFWtHiLszD9vPiL7pqs
 0mdHHniffE7yFArO80ordACeBVz3NmtZf3gzpn47xISAsUWYbq5HySBwmDrNkwU7v1g8xPhT/mE
 gGqatN8oWz4hF3OsNKaJTn87WflOP6+9kZAL20E1/71jqCjqp0pKtUqFFSIQcCtfg+eu3hoZQfm
 ktxHq2mYJpPt8X541b1RpXnhH2rMm5DnCe8WECuzryGWwKLQTGUb6dlDGa3VxxzThrXvAzUBjLV
 RCVP4k1Qo8FRkMfC59x4mx1IZ49TtkVeaWPG4jY0ynHsoLhWgwQjLV8Ze09GotwIUFnAXynrzxS
 PDF7qzP3whKs36GWIqdKEjcBDC27swLKyQUk2J3dhqdsM6ur7hNd4h0sl3IryAsKuVjYxp+n+yS
 x8l9qUc/8+duaze+NQtnrdbnNQVfuQ6B5x6QcOhErB7qXAtgpLHlOz4pF8QwCdKYveStDDlpY9W
 ww6MQooeLXVn50g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- crypto: artpec6: Add missing (enum artpec6_crypto_variant) cast (to
  fix 32-bit builds)
- Add Acks/Rb tags.
- Link to v1: https://patch.msgid.link/20251106-crypto-of-match-v1-0-36b26cd35cff@linaro.org

Few simple cleanups, not tested on the hardware.

Care has to be taken when converting of_match_data() into
of_device_get_match_data(), because first can check arbitrary
device_node and the latter checks device's node.  Cases here should be
safe because of_match_data() uses 'dev.of_node'.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (6):
      hwrng: bcm2835 - Move MODULE_DEVICE_TABLE() to table definition
      hwrng: bcm2835 - Simplify with of_device_get_match_data()
      crypto: artpec6 - Simplify with of_device_get_match_data()
      crypto: ccp - Constify 'dev_vdata' member
      crypto: ccp - Simplify with of_device_get_match_data()
      crypto: cesa - Simplify with of_device_get_match_data()

 drivers/char/hw_random/bcm2835-rng.c | 11 +++--------
 drivers/crypto/axis/artpec6_crypto.c |  9 +++------
 drivers/crypto/ccp/sp-dev.h          |  2 +-
 drivers/crypto/ccp/sp-platform.c     | 17 +++--------------
 drivers/crypto/marvell/cesa/cesa.c   |  7 ++-----
 5 files changed, 12 insertions(+), 34 deletions(-)
---
base-commit: cec65c58b74636b6410fc766be1ca89247fbc68e
change-id: 20251106-crypto-of-match-22726ffd20b4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


