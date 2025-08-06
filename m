Return-Path: <linux-kernel+bounces-757923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79636B1C85A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65D53A4AC5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB781DF261;
	Wed,  6 Aug 2025 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="scYpNwRr"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFE142AA5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493023; cv=none; b=tVBJ3WRZNTzs2AY5IRXsTeLhi4+J9n1MAtVk1mUbZgxAswA4MwdVxinEDH8TupRxCPmLYzTbxFFIxM3Kwl89GDyBlNx851uu+mSvzMRYfoOTj7Gff84Ts8hBdBxQsOHgUnsXz2UPyu/hmL/SV5Vca26+M5WTzUzgYX8sifZuW4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493023; c=relaxed/simple;
	bh=XJj/+Ii9ne9FVPI/eszO2aSskv5085eVs2yaTGWarcc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iYgL4aed0qesWyWvYWsiE4A7OYGciSLiwwNav1M7ifyS5Gi2kDgKm22zVbGq6GEQteFr/u3KzrEqgO7+quydIcEJzFyGW5Bnt8B1JwGVnYmqzGEk6x0FMHtQ7cl5q0Pnykjc+14wERg9GsjYGI7oWqjPA9AQfP3l7FZhRgHQ1CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=scYpNwRr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af66d49daffso1006135766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1754493020; x=1755097820; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lXNDxz+vD1qrumGSjygzCNxB/cloZERXqd/svDy5PxU=;
        b=scYpNwRrI3m+cydN9NbfpAbpYxG2Gj3p6jVHu06y7Nm/h3ip44dvKfkup8WIZwV0ha
         i8W4j9YL5zDbEPXK1qVpFvG7R+yRBnGpLFaydGKOVXwPldkrm7gG3SCHKVvZby7dBMTk
         qfMP5rwcehqi24w900h5To/Tym9bv5pbKxaqO5mOzbxXMvSFWqGyITVhE+A6o+I++GME
         1aip0poL4zqErGbZDPKGyAW8v99U9gDYmaGGnZEFeNfCom5p2tgSgmHio1XstCzoS/2C
         mBmosHeVLSL3q60+iB4vaiRPG7SnRv50xbXCdD7cz4OpWbuE5FQdkVUhFKwAfZtBKqyz
         RaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754493020; x=1755097820;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXNDxz+vD1qrumGSjygzCNxB/cloZERXqd/svDy5PxU=;
        b=ak/kh0l5a0m5P0eNH4et5yb4wJM4JGBh32g73SjmVEhQ9LqfYtyMlWO+eY8yQds7z3
         werfEcfN3LCgNZprjJq2vSyGiS2/hjztTcN7ACWV8XXRN1+HTJAMgkHkljQogZ0NNWn+
         BRqTqEbPkxZPeE7j7esXws6P0beORcuGqRRqoS3hh7lItVuc9uIbqjxdJJzT2TglPh72
         1EMVut+/4WkTFfGSWQBqTgP6FuF1jGMKaxty8BnHxtMeRGW0g6V/4mtfhi1navoDUwIE
         U0WkugUbZocPmsfZ7RrsHiTrNeERQEEySTvZaKztNZYhA4iCzhzuGjpBRgyRViD//jBK
         gB2A==
X-Forwarded-Encrypted: i=1; AJvYcCUuSWGbVl9Gge+iUY/9inmGQym0jqG8Jpy45BWKCPJvuvTovjsQRQmyB4No6wZVXB07HBzGeD9sWSOQ7nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdyZmUVa+G6F1AC+ojhrzFcYzc+JI71zXMBVO6mZXIjzG6PzQr
	7ae+jKsd9PrjhCd49or9gkW+MWaSBNqmLG5QELuMD2JUHAJrLyn3NyPQd8maEyFyJJk=
X-Gm-Gg: ASbGncva50HcNTBdPCjxTsDA7FRGfe94o/pYlseEitTwFG6Ab8aqSFvGbfCeWyOlseO
	198rY9Z0l4VUMjiNScCXx5GCB2jpohIHqGe2LCbD8VNXSHm+Rab2LTLRTw30zj0iSG0gISTWLAO
	rUUQzMUq7gW9rT0Cj1MW0LuNYpBBOfDRjpneRzlPScrQ+u89jgltNK1e+0eTi/hofxmenZelfn+
	4Ov1yfQn1sijBkcVAsOkPrpvfb3fbpS+t3j5tSy00DZRpUQLxtlfbuP4wMQcfHgJl4SvXf2ugdM
	KnOFAKXkqh2MYvVuw5DYUuGA5IzZnxpUOE4wZPkZD8cLI6JX8ZU/wkuKtn0V6gNwCMQJiAyhmjM
	vyuz+z00125xnzET7ZKpASF9zoYTJfUP8HxqHV5NhKLeHyXXBrx+vPyY0ugF25PiQS10N+QFGAN
	usmPhA6RTxXrEo9A==
X-Google-Smtp-Source: AGHT+IFGxksQxksr9gdwZChs5Q7bTY2ry/u6i3uopbyTI4KkbR/QSULpJPg3RPcCg7fhSoD/RX3RLw==
X-Received: by 2002:a17:907:7f18:b0:af9:2502:7772 with SMTP id a640c23a62f3a-af992bc37femr303160166b.54.1754493020271;
        Wed, 06 Aug 2025 08:10:20 -0700 (PDT)
Received: from [172.16.220.71] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b77sm1120100666b.51.2025.08.06.08.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 08:10:19 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH 0/3] Add support for Awinic AW86927 haptic driver
Date: Wed, 06 Aug 2025 17:10:07 +0200
Message-Id: <20250806-aw86927-v1-0-23d8a6d0f2b2@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE9wk2gC/3XMTQ6CMBCG4auQrq3pz1DAlfcwLsZhKl0IpBjUE
 O5ucaNRXH6Ted5JDBwDD2KXTSLyGIbQtWnoTSaowfbMMtRpC6NMrkoFEm+lq0whq7quyRpPyCT
 Sdx/Zh/urdDim3YTh2sXHKzzq5frbGLVU0hnUTLrwHmHvMcS+6VreUncRS2c0nzZ/W7PYwvkUd
 ApOtGbtp3Vva5MFAMITFInimoU/FpKlXClrqhKt5m87z/MTH5SnElYBAAA=
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754493019; l=1235;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=XJj/+Ii9ne9FVPI/eszO2aSskv5085eVs2yaTGWarcc=;
 b=bdtHg4oKQcgns5dedD3nEjg/wB17OzGg5zzZbVVTORzPqFBn4Q/wt7aXuBTPE7Pq0fa0CN+CN
 XlnMIvCr7uSBsuHZZZUpFgzhBW7tuaWKKIMZykbrRCv3BKVqL0J6pe+
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add devicetree bindings and a driver for the AW86927 haptic driver, and
add it to the devicetree for the Fairphone 5 smartphone.

This driver does not enable all capabilities of the AW86927, features
such as f0 detection, rtp mode, and cont mode are not included.

Note: This is my first driver I have ever worked on so if there is
anything I can do to improve it please let me know!

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
Griffin Kroah-Hartman (3):
      dt-bindings: input: Add bindings for Awinic AW86927
      Input: aw86927 - add driver for Awinic AW86927
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add vibrator support

 .../devicetree/bindings/input/awinic,aw86927.yaml  |  48 ++
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |  18 +-
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/aw86927.c                       | 841 +++++++++++++++++++++
 5 files changed, 918 insertions(+), 1 deletion(-)
---
base-commit: 3624e9a34b36d64a7037946eda28ae9599363a3b
change-id: 20250804-aw86927-9dddc32fcaec

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>


