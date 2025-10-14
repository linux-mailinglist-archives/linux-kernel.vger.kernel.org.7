Return-Path: <linux-kernel+bounces-852518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70296BD931F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B26C4036AF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEE031065B;
	Tue, 14 Oct 2025 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yyz2y6Wk"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47712FE053
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443354; cv=none; b=rZzxEmMTSADRKd7yL9wB8geRYCVyrXiuVQGz8WOX0kMhi5cf8PdRHzndP+YWXTb46D1vrlfnVyWkciROxztPbAKSRNykZ+18MS0XTo2fbYeSVGdcLKlY1gvyD/FHUUhzEh9xcRT94ts9WyC4O5qpil81B3N2+A+cP1JqtdTEfZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443354; c=relaxed/simple;
	bh=uN3j84qVqwGAIGTb9j/2yqr2sDVtx6YN0tEWF9Jvojk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g9WeytgEUnyZMwjvhsFVLeZSEfPj99C7kqgUeHLP1POcXxb661/NHM2a9nE65ULetFWcrbcuy47qKjJGiRnVVSGdEgqfgZwzkN8wk4c/8Dafb2qlFkZpHBw3Tz1TiPtyEg9kFeLSf1jWWjUIaUGY1Tjqm2zp6MilTPeWRM4Bm0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yyz2y6Wk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so5066716b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760443352; x=1761048152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfQvU/Mw0ZJ9zXdFjFYOYgKDAzyRq42k4wpeXF58tTM=;
        b=Yyz2y6WkUisS1FglFUS2w4LGJKOckdS69kkSQKvFVoaJhIggn9HYWDyK7HZFLoRY2N
         LngQbLPBZUzucnKo3AeHenk4s85c7seV/NeF12ssi6njgcD9P9bHkD+CIWcP/5BPnLLx
         Exc9mw2VBuevG6/kiJkJHRfhF7ccR7h8MdYmB4gnFdF9X2bbVrqHKrAhYdSZeYjEHL4x
         fe2BEQMxxBAPZKnZOpOGCR3qJi82VAyQk61Yd8ib/4SwktWr622qgahOJ9RlM4QNAMrE
         WZgsOdP9zMmd/CX2RO0MleVMF9bqgl15lFWzveP/DykPQlV8Gy5WPEFzD8nT00Ks/zkF
         TELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760443352; x=1761048152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfQvU/Mw0ZJ9zXdFjFYOYgKDAzyRq42k4wpeXF58tTM=;
        b=d6cbM4HMSUG3lyAE0Pu93ngoIUiAl/Xzm/PBYJuPT8iKbYVgWqmmCmbA44t/Ih3gye
         TWFfb0OWaFoQCWZ1wgAAX42LXjwQoQhT/nQR0ksp0VJXsnixIW6h+LfttIu6x3MhcOAp
         EJ7wD0uSwf15dWQ8TU3EJ9KRHq43Bfa0w9zvvTJXw9SobonNjQ8gvVVhewz2sob7sYIm
         NFrqCVb2ZPFAijNq8xdcKkr5Wt6Azk2PMZnG9YbApkMffSVE58Vym2HycpM4MPHVyKk9
         Dc0PQ+MLc6mHsuhc2h5tGSuink7pIdqewa9vnoZhY9guXI8LQ28P057K/KETQfeWrhoN
         VGYA==
X-Forwarded-Encrypted: i=1; AJvYcCW5YfScygyvhQLFf8sLe7yBEy890u5AQXQzEpechj/UL8VXYsoqG/le3htYGafqG9ra/zh6im89UHzo2+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGf/Uhllqp7cTGsLMVam724Bdnj74Tqjmc7Rzfy1+mtxLE8Q/g
	EjklfNkXWqqWpvsxspBKqvG7ANR39Jl5uldJhvBqz0KVg4Ucv5ZGze1c
X-Gm-Gg: ASbGnct1Cg58Kca5TDRFxyf+wDMMm8bHzaiBt/7yL2B5HPb1X3px4NH5JFWoxdPxqmv
	+Vsjt4aBfX1YdB9OwrLjkiWfbvofJHiRfey6zub7lwC2+KPlACPA0g0iu6iF5QtNjDf1QzAxtZU
	OvXc79dr2q93Gqnk1/tKI73NIBCq4me2smrmU+91OgaxTGrwtnwwLWaPwpauN5+Mczpr10HShWV
	P77aFanfUWi0eEM/M+c1ZA4n1JWKTNGzHohnqD4cJvPHOtk9hefCSgLAKoO70YF92gbQQ7jOMFp
	5Jj45/eVUTh4rcZvhxOWRUk84dfzdQ9IbSQ2Uv+5JM2/4289c8GsGv94O//U7L13o53r248L4Yl
	ZNFzRDIlizkiHNtj754Be2yexQIy0LW5rAv739RLhf797Zx8e98yDu6kjTFnNu95lStz5zTNrQ/
	Pszw==
X-Google-Smtp-Source: AGHT+IGxnJZuqD7D8HRrQsKpq2YeyVBl1nCR/ZYNgjF/OZAth0ma7f0ryzIGkzZOdXOx788KjLPmyA==
X-Received: by 2002:a17:902:f641:b0:269:8ace:cd63 with SMTP id d9443c01a7336-29027f43af0mr304373745ad.30.1760443351952;
        Tue, 14 Oct 2025 05:02:31 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f941a5sm162808455ad.127.2025.10.14.05.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:02:31 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andersson@kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tessolveupstream@gmail.com
Subject: [PATCH v3 0/2] arm64: dts: qcom: Add support for QCS615 Talos EVK platform
Date: Tue, 14 Oct 2025 17:32:21 +0530
Message-Id: <20251014120223.1914790-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This patch series adds initial device tree and binding support for the
QCS615-based Talos EVK SMARC platform.

The Talos EVK is based on the QCS615 SoC and follows the SMARC
standard, consisting of a SoM and a carrier board. The SoM integrates
the SoC, PMIC, and GPIO interfaces, while the carrier board provides
peripherals such as UART, USB, and CAN for evaluation and development.

---

### Changes in v3:
 - Addressed comments from Dmitry regarding USB1 `dr_mode` and added a DTS comment.
 - No functional change in bindings file.

### Changes in v2:
 - Renamed compatible to "qcom,talos-evk" (suggested by Dmitry/Bjorn)
 - Merged enum entry with existing `qcs615-ride` block (suggested by Krzysztof)
 - Fixed subject and commit message to use imperative mood.

---

### Patch summary:
1. **dt-bindings: arm: qcom: Add Talos EVK SMARC platform**
2. **arm64: dts: qcom: Add support for QCS615 Talos EVK board**

---

Best regards,  
Sudarshan Shetty  
Tessolve  

---

**[PATCH v3 1/2]** — `dt-bindings: arm: qcom: Add Talos EVK SMARC platform`  
**[PATCH v3 2/2]** — `arm64: dts: qcom: Add support for QCS615 Talos EVK board`


