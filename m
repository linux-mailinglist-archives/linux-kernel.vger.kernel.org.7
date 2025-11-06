Return-Path: <linux-kernel+bounces-889015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47C8C3C818
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFDE0189C3DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55D3324B31;
	Thu,  6 Nov 2025 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcSPAJgk"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BA6261B65
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446728; cv=none; b=O0qg5/dBO9GEDHKSABvdSbyPkQd/IgzzwerjBt2e7P24IWMTlTbMNOH/vguvj5IMDmyGwio+D1nYGE8s4GI+aOpr2nrOyXgLa6zrA8Fy41XJ9VI4YteFILKuODNVLXDDlDMVXcci2MOEvxn1aqnci4XQ5j9q3ex3Mqx5qwUDKr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446728; c=relaxed/simple;
	bh=baW5v4LiXQ29IowCK0UwIQQ6FO1aSTxQN7dB9lPn4Ww=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qh/uI8E1jyduSNDkFOxZtIlMv/w3Yi3cBcdfKEuK/Y3nhGy+CSb787eAnNJfFmGIEspa+ZeVg9HcmbzI2WFiD/VfTV31E7LhrKtiQlsS7GjRsng8/hnCohyK688WKJMaGiWQ/Y/azgGboIGoTzkJMhTkBJGQl1arb8h3WTpRyqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DcSPAJgk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7270b7b767so15549466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762446723; x=1763051523; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQBlUaV8mHeTuGtQUKejSKsUaDFp0QHBYZs9jo/l+EU=;
        b=DcSPAJgkTQZomOdwGVfcEd0skzoXGvsG40MGdPUld487Q4IJE8X1F3tIGE5cshExa8
         SQzsw5ApffOpnUYa58LVl2iIEjsAFnFLKepUNTLjz2XaKRZszPwtmsBZpphT2WByKlqN
         2IiaDxhwDplVH2Jvr1T7WOqgUzjjAGAiv3Mn7oHhtfcvQdMpx2Qej1Zrjj5GoQd8FLwy
         kZ67bhggU6Ju4QwPUFTz3JncBvL98S7tBSYpdZEgd4V8TUXflNiRwLKw09xh6wUmUBGT
         TGmSQQ2uEuE2AlwTHELXZIAOwbZbR6dz43o0o9pjzgEiH07J3OBX9UHB0XQUxkx0870F
         i00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446723; x=1763051523;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQBlUaV8mHeTuGtQUKejSKsUaDFp0QHBYZs9jo/l+EU=;
        b=b1O4dLhuvWbzTslOWl0JYL1w3+jTJYkp5sDQDeN6sZ7od/6W+dwEofY+SVW0Obupqk
         tBiC0kLqJZc73tWFCzMpRET26SEi96tgw1erQ8pG552PpndRYDqVZRFktVBSs6I29O3A
         i5hxjB2Hq9rcIy8/tIjjDp95R6RI6VAo3bLeam1xqn85U/DdFyG2bP9afK2ynK9gy6Mp
         SQX6HyFSq0BnknJc7uwPmxjhTb+aq4LKz6XmW7GICJm5wKIeajrTvQ5JoFjVSMG1qB1U
         GR77K0zrIJrHQMSz7KlLd3jBuyhTm1butxEgm0+4PEeHECs64rEgSMUps89r2t4ENm5n
         6zxA==
X-Forwarded-Encrypted: i=1; AJvYcCVU09Ughy51Dso6czrmiNkak3mrpleezEAUFsfZ/XzdIbQfdrqhmajVDrCaNN9qu7iXuv4YIPwwnLT5NZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSMCdP8ey+Rufe8vRFz7SLRJomlPrP/mAu66bPEpMlvb9IsDKf
	GxtCmtv/b6doJZntXzb2wgEE4Pg+fR8c1c0QDml+xjkB/bc6OwT4vINfxCVrPlXx5CTc3PYRvyr
	MM5yA
X-Gm-Gg: ASbGnctiqz8hTi6dzLosh3Mt9Wu1sdLMpV+B8jCIfCvAN7U4UfjIUG/uZ2rfaHk9tUZ
	gHEtBKhrtFWZRik4M10Wb3JtdHYOEu4ZqixP45rdODIv3o9pGI4hQoSPofnNMJUAMw/0RQl85dn
	lOZ44SuAt7fRK7R+skX1QJZz0IOpUhzcQpWk/FLtJy61uJKhePlOlgfo5iVtWxmV8T7HYFylLzk
	Q0OsifH+seDX2KUd8bDrtB/uSS5g9pxx/5ApVVNvPA2aGIqLRD9AP72wNYV9JCjjUJPGO4OPlU/
	XqP27HMe3sUvIPYRFpufSeaM1GfdMu4VnQcfvsHI4ujT9qL6JfYioHcZWpBZofdAg+j+ToCOdez
	0hXj/mqz2k15pj35RpLmfkbQNxXHtrqvea1lS5FcpgPeS6aDioMOxFdpHxHki50MPJwg7T2Oqoa
	EdS1bl/NCspKWeinDsCMw3IlsfpLo=
X-Google-Smtp-Source: AGHT+IFaJFGgKtpOfjyJyZjnu6imsT7N583yoy9FXtJIdPh3n6YTMEucNPOZE8ZpXrIC8xcqZHTMPA==
X-Received: by 2002:a17:906:f34e:b0:b72:6762:f76c with SMTP id a640c23a62f3a-b726762f87amr306427566b.5.1762446722811;
        Thu, 06 Nov 2025 08:32:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289682544sm249625566b.53.2025.11.06.08.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:32:02 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/6] crypto/hwrng: Simplify with of_device_get_match_data()
Date: Thu, 06 Nov 2025 17:31:52 +0100
Message-Id: <20251106-crypto-of-match-v1-0-36b26cd35cff@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHjNDGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMz3eSiyoKSfN38NN3cxJLkDF0jI3Mjs7S0FCODJBMloK6CotS0zAq
 widGxtbUA/Gvy/WEAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=baW5v4LiXQ29IowCK0UwIQQ6FO1aSTxQN7dB9lPn4Ww=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGkMzXqhz9TLDI3aAR+DBM6TzDg9T7YbMFtedDKOWlzXoGLMP
 okCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJpDM16AAoJEME3ZuaGi4PX/DsP/ikj
 8d5AdXEKvQqdeiixME5VLLoqQzb1CpAY1z5OBRhAsVBqHCJbeV6UZ5TtBUk4TeBMb1O3TLsCOk2
 hCeA95G51Irgo3wFG9H19uFb9K9SgUOXexFuv013deXvqjF9MXv+Lqjz+ahaRge0mWDhpqJVTnz
 yabl4NqWMTzzu3JeP0MvnDhN4/65fmtGaSv8nnYezNSb8GuscDH74rO5erp1DS7KdTXB8/Cbvyw
 /QQ86RtXYbiYkN6EwolAI7YqWHGXQg7eKhp0Wska/sYwh7qh39XHgASx3R8Zrf2qgyJUXTSUGsX
 QYaiOT3t0gjzStMjPMv6XVPN9IIIOW+mkTRDa6ICEuvyHrLrC9Hzsex815WCQQ1JiplUM6810Fu
 4b829gs6JhbUHqbQptqPPMSbffsyf8HyAC2SQGbXuF/yKpPh5fkzR+xnsIYypsJ6aNynObVOozg
 gUG0thCuhQju5aPPXDRU7IEuQOgWrYUoekn9Dx4HfoctPvtw/JMo/pYEvkPJ4zSXDZ9ZGKfkvz0
 dia4w8SHW5bBRpSbVlb6anR9NTfLvlcZrH6socpQ/TzZMby86F6IN8ECn8awltWzE3MGzsD3toq
 gb0+rlWSAR/Fv2lLwnnKNDbtbNPOW9A8+DQJ7RhK70U3dMQMYSsbG6yvyEu0Fpk57pSSqprfj5I
 nqnpy
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

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
base-commit: 8297f2f148634bfa98b0faec66bab14942801d95
change-id: 20251106-crypto-of-match-22726ffd20b4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


