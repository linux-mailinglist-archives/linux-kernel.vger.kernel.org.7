Return-Path: <linux-kernel+bounces-729055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAD9B03124
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81551748F1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C5427877B;
	Sun, 13 Jul 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwU4XCYf"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D122FAFD;
	Sun, 13 Jul 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752413303; cv=none; b=n4vH36qPUxC718G5iioos/APOH4UEx3cRh4d7FTjJVkF/4dMobS87xu/JuiipbJly0eb2DzHOdYtFgi+nRl4KTESLeJKspoBhGHofuXuOZUa/vbK9+VAtunJq+d+ycBawlmXc1/dp+9HWCjd6bYWzihLoOsLcP2rRiAYfj8WmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752413303; c=relaxed/simple;
	bh=RK0JVUrTFe6QafY5lJlDHH3DxsifRIzU9YPxeSRbzQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V04ZQ4mYwKQ0lZcsCgFM6cFRx5YkNY/fK8zEDtaouwHHqGsKABDAeuqRPYSf++p8bxjFNvjdD0/AmrcIhXveo8t/bVxQ9Am+6aYpcgkXumTp9mabbuUQdC66L33lc77VHiorPO/2Mj/ipZ3sFhBqebVOUzPWo9I80zVw5gwWpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwU4XCYf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a54690d369so3147930f8f.3;
        Sun, 13 Jul 2025 06:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752413300; x=1753018100; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7jORbIueyPIb6P/w2OASxcewnEp80SmMswdiqTs/zA=;
        b=CwU4XCYfnS8NQz2ZcSYs80ZIu1deTyuquWhJ3tsfa1YKFjW01ofOTRJVszWnwtonEE
         pd66oIXuwOj5GVNXqvFFy87hSGb8f0H2cDhQxw+etlFaCU3HH+O/4EtfpUIM5eiGYsb8
         MThmELXhbf6rmLDFb3Un0nYToug9ztPwVkvJqcGRhwJO3zjG/z9ROkx0xFWqgDsJrhod
         JqWTLEyTpvpSZDkjN0aFQU/zvW7jA6SDs/Su/55CfnoQ2ePr9lcQdxpIuLDx9jxZOAYC
         4+0wq4sitp7LEMFz0TyH/7shkNv6x9HV5qIKRcFFAVEeRSKNZb7dLH6/qc/DHUGt2rTO
         Pr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752413300; x=1753018100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7jORbIueyPIb6P/w2OASxcewnEp80SmMswdiqTs/zA=;
        b=h6oJ2qDeP9KxbnvsePYSzVdTaVPpmwQVTlPJIpyHmJk8J+rvYFOFR0mAMmQsSGdV6s
         U9FuojR94troRsmSz5GUAn/kNUQpChfv2p0P0TIJku4SEQrmKIqJkk2l7GzeWRxISP35
         4yY/709+D5R/IsSpXebfcLUYYYv0UCuZCiT7nXH6PzZiiF/QhaUy5DVCSlmAEpp+4spU
         0u8WTdIC7UbZrYL/+kspqLAg02o9NryT/ytbIIkkfFDOFpg4hgmMWZh9GJlnOvmWlMXB
         aYv/GJUcQ1ddKhgzUnS0ghp6m4X5YHvoAwMmUVWGH/RDDmE2o/U6b27mJEk3mYWmo69W
         iz7w==
X-Forwarded-Encrypted: i=1; AJvYcCW0QWSl+KhPjlQDOiIA3tobjfV3l1SHg7T9AE0sOIDeFlvE6IPzZZOr0maO6xe13MAPke+65ACPUSUZ7W4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/K35//3AbnTx+uvhI8y4wMa5uGSr/DvDJGlY97f+seY6wEAa8
	WItEa/rfbmLJWqrSVnS00Oul4f/ERa857lEH/fbphz5b2kXVpNSNTT7JgRbUIQ==
X-Gm-Gg: ASbGncu07gLyHWtDH0zUfyWvlAAeHPEAjF4lYGlMjEUtiXnqLyvbqIMt4svM5ehlc2U
	hIvTKboMeHyqNJcAObOnIcJDDaBwc/y9HnKfheifsLHG/wRwaqLOqwH1Jgp1wHR9pdXEK1CzLzk
	sTySY2YwAhlDNObVg4aXqbtmqqFtG1lwhnpvegP7ZGWJfyTrHaMoiUSjlu3ZirdQyvC8hauYyI5
	tgX9w4MFlIqwJ2ku7Z5/FjTR2KQehaHYB6L+iC2ZjHqQipuL+Q4+A41q37e9VtjHofZEGwcAu6S
	fi0uK4EfKC4rIUT8Yi2yXn9CCqpjoXilESyfPKmtDuWtT8JcAGLbuCf3gNlxf5/OsdzbW3IMFoo
	A7J38siFJRRe84zASADLXvQ==
X-Google-Smtp-Source: AGHT+IG/isp/+F+EMDVBOgXHpFpGEyNOHJ4lSuJEljVjZygZXcw4Si/+IZOv9cUpilTVsp23fcjb5w==
X-Received: by 2002:a05:6000:1ac8:b0:3a5:21c8:af31 with SMTP id ffacd0b85a97d-3b5f2dc2178mr7549692f8f.16.1752413299626;
        Sun, 13 Jul 2025 06:28:19 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8dc91e3sm9675321f8f.43.2025.07.13.06.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 06:28:19 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sun, 13 Jul 2025 15:27:28 +0200
Subject: [PATCH 1/3] dt-bindings: arm: sti: drop B2120 board support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sti-rework-v1-1-6716a09e538d@gmail.com>
References: <20250713-sti-rework-v1-0-6716a09e538d@gmail.com>
In-Reply-To: <20250713-sti-rework-v1-0-6716a09e538d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=RK0JVUrTFe6QafY5lJlDHH3DxsifRIzU9YPxeSRbzQ0=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBoc7RxJv58Vyo6mm9ZDyB8hIwNrQrJV1bkcFgWU
 0Dbln56RKGJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaHO0cQAKCRDnIYpo1BLC
 teUFEACOFmkruLOIg/Y7ihznC/BTFhzPpjSv6zwPE0K2BUQQ5AzUEQvCvvVNC1k/uc/XBTwx2g5
 b5L6ufz32SQYF4hWzi8TknveSmfjOatXaSKgtOPMM/A8YjfrmfbC2ILL2pNOLK6cHn+C2zkv1zZ
 SNhPNicebQW3C/Tj0rnvd8diYzPgUSFvzEVagypx3GbnhSWvC64y6F/QD8YbNj4xXC5sZ9Vy8Gz
 AGR1nV6feOlsGW6lfIIr4Kdao/qZfESNaQkf8spfCbx7jNSzVhuQbRQLcz/6orxb49QPycA6vFz
 ZpQ7jxnQ3SlpbI1o944eXsMefGDKoC/2Owg2HRMIw8sSg3LHNzO6drKKYVTiHC8Ui11KIAX82P8
 9aHdz0OeHblpB611X5Q5zoIRqNW9lK++5xJ93pXWd78jMH9wAKfkxG7L8LQlzhgEgwi6y6n7YaJ
 H8LSYyPxbRfNt1tgjWLSSZR6azuYuIu6zzmLpgpI7i23Hq6vHMxFau7+pCsmdKvM9EYKX8wfHw6
 kSezz05dCGeHg87zFsLoqz/rLjj4Bc1HTIv8jV5Hk3xCDxwBU5+pxKxYsy6oxcs9gSuVyqR0S7k
 9Jj9aHd+3zDCSxqM8scNvXu8r/Wnropgqv73POVDnOq7hDhRRbzCJbIixuTDSIbPi4KSqfl9GXI
 NI+GKecY89gf/dg==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

B2120 boards are internal boards which never were commercialised.

Remove them from bindings.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 Documentation/devicetree/bindings/arm/sti.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sti.yaml b/Documentation/devicetree/bindings/arm/sti.yaml
index 842def3e3f2bce470763d3665c7603b9058b1e4e..177358895fe1c9f80f8c825142cf015d04286ce8 100644
--- a/Documentation/devicetree/bindings/arm/sti.yaml
+++ b/Documentation/devicetree/bindings/arm/sti.yaml
@@ -14,12 +14,8 @@ properties:
     const: '/'
   compatible:
     oneOf:
-      - items:
-          - const: st,stih407-b2120
-          - const: st,stih407
       - items:
           - enum:
-              - st,stih410-b2120
               - st,stih410-b2260
           - const: st,stih410
       - items:

-- 
2.50.1


