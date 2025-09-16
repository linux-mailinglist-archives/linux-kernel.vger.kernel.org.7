Return-Path: <linux-kernel+bounces-819400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 431D2B5A00D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040A9581531
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D4532D5BE;
	Tue, 16 Sep 2025 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFXckyTF"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E15D265CA8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045867; cv=none; b=s/R1tMkWixuEUsHLQw2ueEEu+XrzfPoUviOOGsSxp+acWTVO5nzNm9wH/KcMBtJknve6Yf2OT+lsiKgS9F7MKEMVQrIKXTJ/U4araUN5tPOvE8xqCwM5hUVCBlSLY1dWAyNq7D6u/9a+ycCI6SXDSYHodqSQVBg0DfobFwrgqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045867; c=relaxed/simple;
	bh=PzcSQ8s7GfmxH7lt4N94QWfy7MnO8OSH0HGrI/uXssY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N4WPlxau/+yXwHRS0jveFbhRCXlY134g5/Et9l+R5tLgFfAazaDqLGBA1X6ZpT9m3uOIw/4h4yrO9xJz4E2LZGiYHJ/xrJ33otKQyjdwNXROSDKOm9n4uc3/Ddlx2K75knnK/N1M1p6GoRgx1kqEJqUhzXyLEV04Hh5bHmW4hg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFXckyTF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77796ad4c13so1885734b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758045865; x=1758650665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KlMD9Q0JVitdbzhKoBVG9BxngG7xfjv+ACgNnBWgBr8=;
        b=jFXckyTF2Joss6ICkOWP/E4pJDdtXhIA/G2BlkW5sPdHs2K/wVYIUM8GiaE/YM/fX8
         YavV4Mw/Pa6HFFACKsgSyQQpKkDdy+XOpzsEtic8TPyDzH/TzGRAcyWp9g5HMnMaGMYn
         IVMjJ07k6L1kzaBgY5YoUXqR6O3OfvcMb1CYLp1rWcMioDFlfbkOKMyZ2oKV4kZ+EVW9
         IsJpYCszn98zDsQPacpdeK519NFOoxHq5kVr0PpENic3iMIpkPvrxe4IkcmVC821Br/8
         5s0ttX5k2ctUNeSKESMvoSNY+1FzkLIOgbsm71CWRpgwPBFwoMhkSqivAkuQ8cCUuwbN
         RF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758045865; x=1758650665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlMD9Q0JVitdbzhKoBVG9BxngG7xfjv+ACgNnBWgBr8=;
        b=bsfH0HT7Ut2wISPsYV9fAc8vZLTLPhSg85WXXq1rKqmaLQ1ym8maUzC5yQCqJ3+U1A
         21nnxml21mwPWD0q3r87VzAy4tNbNlM1tAvJGM9G8JW3DI5MH3KRetYiLd2XpftCmWxO
         wJ83RjAYVG6sxC2PAFCUmudReaf7u5l/Xs20sXAzgWNc1NQs3Vf7fUKMy0jGkjxZbBqt
         QsXlWzL6Y0VbKUk9iZR1woVsPGkFVO4KW23IxFjKNNIcevRnydoe9vtWJPSeNT+Xs/t1
         hb8m6oA43nD0hLsXFsFZSM6yJDqVFX/QS9bZUoGvtXwG8tq7tisOiptyiiIP6nOrUXQB
         QfeA==
X-Forwarded-Encrypted: i=1; AJvYcCVm8/L1fzp0crOIyYyY+dKVMyHW3aZwu/yCofO/6ifY9nfNq9ex72eAlCBeDypy2Z2TXkRmLW7h87xvLv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9/xCgy4EYoaishFFALAzTNCg1OrxEhdD0B2VMpBE7dkTBENb
	ef0dL6fIXs6aSgvufjmOvLm2vbDGv/Q3xrpD7opA71LNKvrGb5pVg5M2
X-Gm-Gg: ASbGncuO8ucRpLQxMrafd0tHJYfW17Z2elDweuJNTT9b42XIRTqaw+DtfoLWJ62EeTz
	9ZEAncHA1dPCfpkdiDY7CWT2E7E8NcARNV70OzPbwPZGqfAXYJ3lmEHjuXsJ8Y9uxQSoRZPdoYq
	B2xKD54GwYtgBptzQZ5JAJiMFNJY6CUeA45Hr6qr80nL4qesnGAMQIZ042qG4tCE+/g+nVmdFZc
	kc/9RsYYPh0JWBQvNaIFN/bAf8zRqxAaTOirR3qTnHtSNWKRtpLAqkRcmo7FiR9b6rN9mGz9qeM
	7FIZKYkE5YuwD1hWZcJMsO6N9o1FU5w5C+uvEFKgf2Wiqx0dTDXILxlBCrvTouHpMHt2skbmZyu
	sVTmuidUUHqg2FeF+ww+M0YKIVHvrCA==
X-Google-Smtp-Source: AGHT+IE64vEQGGYu0FHbritPemhJAwVBgkK+MK3Escq6TQXLMCHhie2Kq66Y/kds7nMxdc8J5lT6NA==
X-Received: by 2002:a05:6a21:99a8:b0:243:d052:9833 with SMTP id adf61e73a8af0-2602aa809d1mr21763638637.25.1758045865256;
        Tue, 16 Sep 2025 11:04:25 -0700 (PDT)
Received: from archlinux ([152.245.61.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760944a9a9sm16329819b3a.78.2025.09.16.11.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:04:23 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: qcom: sort sm8450 boards
Date: Tue, 16 Sep 2025 18:04:08 +0000
Message-ID: <20250916180409.157115-1-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The bindings had samsung,r0q before sony,pdx*, which is out of
alphabetical order, solve this issue by moving samsung,r0q before
the pdx boards.

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 4f254922069e..640fae56f6ac 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1097,9 +1097,9 @@ properties:
           - enum:
               - qcom,sm8450-hdk
               - qcom,sm8450-qrd
+              - samsung,r0q
               - sony,pdx223
               - sony,pdx224
-              - samsung,r0q
           - const: qcom,sm8450
 
       - items:
-- 
2.51.0


