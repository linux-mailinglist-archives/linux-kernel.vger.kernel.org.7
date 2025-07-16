Return-Path: <linux-kernel+bounces-733893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58254B07A47
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F913164BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228A62F5C5D;
	Wed, 16 Jul 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCnaHrpM"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1BA2F2C54;
	Wed, 16 Jul 2025 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680900; cv=none; b=G1eeBx1MweWsWybEK5FVaylXaWCe+8Sht9wnBj+yEkWWUUWmqgJg6qg/U3nTvW8IqBYK6UOlpxHRS7xy+GNXY/wZv+MMHk3ZoN6BtEHSDukCCumzBDEKedLFMAqE7oj1oFd1SzkdHyG0JznH+wfrEKFhyqZ35awEamP6XI1MI3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680900; c=relaxed/simple;
	bh=D9hK6aCg1zp32zCrrbFTJLWW5r7AZGwUreSAc0MrHXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLHeCvd92TyuS97/6Vlb1c++s2UNBCCtvcThA3EOuWC8ZKSMN0TJui3pJwV2T92AgbahvznIp9lUyXXXtuVjf+bvG/uFjAxN/QkDYA1iYw9GOTNnpXOt1yhalBSwOdqD/5UUAK/eFIe4R1rZ8LrHjFIJ9BnSXbJXd7HwR7k643w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCnaHrpM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso12796366b.0;
        Wed, 16 Jul 2025 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752680897; x=1753285697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfEbSpxuj6iCO3S7ehFSQfszMAGt5vRbG8XfTrlB69o=;
        b=YCnaHrpMsL/AOQziD4KA/FnFwoukf9aoZQpytAypTksA+rB4wZve525gO3jej62E7I
         wTpmmCDa1ec5CM5x3KyPShz/rDtu5N7aozoP/b2PdaSx8i+gE61A9ALy0pMvQcNtFU8k
         N/nMO4S9fAWMBQmpM/jKyqRR1w3Z4aBwy1dho08o5kFHAF0yPfS6SA2JV76QGk6+MxCd
         N+n7fNrauicpnnBEY1fD6N2WiTRaRTVY1HmSQB1snvvcMRtbiLCZfHcTs50hTxcvapWn
         VKZ378OKH6+Y/KtzNGhZmrnt7YnJ734asIB0RQds6Z/5F4ylnGItK31GLmXjXRxhF7Oq
         NTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680897; x=1753285697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfEbSpxuj6iCO3S7ehFSQfszMAGt5vRbG8XfTrlB69o=;
        b=AOKaERrwxK6WOWdEfeBJcMZfOimktrbM48C9Sker4Vdd7sCSbR/YMk6wsArKIh/Rhg
         lUgy8eWIkZXci8PFQUywmw1+6bJlqJ85Y8pIaPPnyFDWHX71F+JvMyHFWeLP8COzs2xj
         O1FZdkkvZzmM5PDFi3kReh7wR/nei1rBwTCE/vcGriW7fGh304u120JA381VvnL86Ri/
         TUzyWZ5LniM2JWyeRYenyW9WdsPOtbddzMwLGNo456OBGoromjjvzfXjY3uJVcAn0nQX
         B3x7Q6JwkwUTdlzH9ljkEve9cQagbEq5x0akfHJdvPkplpeA/D/i8zRC1MWPi7golPYd
         gwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkrHSQviPFtg0Eghc+fOuOZrPtBjHkgxnWDrhKZisG/8464iQLJMDNc4hxEre8t28IM3MR4L3+86Ur@vger.kernel.org, AJvYcCXxX05Imbkg9G50LGIT+fafIQBeiqcZPIapYZia8Btp/4bB7OokeuNuWycrGQBcuEgL4x2NPQDSZv1WqNoM@vger.kernel.org
X-Gm-Message-State: AOJu0YzxzHxL7x0n7b8oH5pg+oXSwArZvurbl+JBS30Pm2tf1aOr/Jhc
	YCaanLyE/pjeLanAPKnrTSQZiyXxMV7o62OThNBu2Gp5/pddOaqTRWY2
X-Gm-Gg: ASbGnctMr1pPEn7g3GhuLNzOcfIz06TyDEJU7DhEw8MH0AVlmMYaTu8EOdCvsbYVUdF
	d/Qv4F6CmBoEAThVfzIZijWqJYdZPp4B3+V34xp3kk6Oi2PjZIOJ6fSZb8CVlYsdRZ9XRDb9nh+
	ZMMSVsWvN+HVa3ZY0E4CVs8oc4jsAuNDabHAnM5YZNI+WHpV641dhZR3qV8UdiqAnFbtUmrkOsi
	/0cyC7oibxvB1nQ2xtHOVPo6At1zYXnXcosr+GQMeJGU4b3KH2t6Fi3v5XhpOW6qAqdFRnLyfnM
	XaZLpOcvO1193CRpDxCr6ck1EbOnR34gCOtKy9lpGXfBwdBYUw5WvYY1O5SmQPySVw43WXSp/m4
	UEmR/q0hK/P0remkeRCEc6wD96G1dOCm4BTOL
X-Google-Smtp-Source: AGHT+IEtMqgd0cERI8zRb+TGkoaqjZkaTKRBSNcMuZ1lo/YTkdU8esv903psbEZ+S5JSVNmNrcYOCQ==
X-Received: by 2002:a17:907:c88d:b0:ae0:d409:5f19 with SMTP id a640c23a62f3a-aec4cdfd503mr8257666b.2.1752680896987;
        Wed, 16 Jul 2025 08:48:16 -0700 (PDT)
Received: from wslxew242.. ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8293fe7sm1196705266b.123.2025.07.16.08.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:48:16 -0700 (PDT)
From: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>
To: Frank.li@nxp.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	boerge.struempfel@gmail.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>,
	kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: arm: imx8mp: Add Ultratronik Ultra-MACH SBC
Date: Wed, 16 Jul 2025 17:48:05 +0200
Message-ID: <20250716154808.335138-3-goran.radni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716154808.335138-1-goran.radni@gmail.com>
References: <20250716154808.335138-1-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document the Ultratronik Ultra-MACH SBC, based on the NXP i.MX8MP SoC.

This board is manufactured by Ultratronik GmbH and uses the compatible
string "ux,imx8mp-ultra-mach-sbc".

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Goran Rađenović <goran.radni@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d3b5e6923e41..9cf2ab3b12db 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1101,6 +1101,7 @@ properties:
               - skov,imx8mp-skov-revb-mi1010ait-1cp1 # SKOV i.MX8MP climate control with 10.1" panel
               - skov,imx8mp-skov-revc-bd500 # SKOV i.MX8MP climate control with LED frontplate
               - skov,imx8mp-skov-revc-tian-g07017 # SKOV i.MX8MP climate control with 7" panel
+              - ultratronik,imx8mp-ultra-mach-sbc # Ultratronik SBC i.MX8MP based board
               - ysoft,imx8mp-iota2-lumpy  # Y Soft i.MX8MP IOTA2 Lumpy Board
           - const: fsl,imx8mp
 
-- 
2.43.0


