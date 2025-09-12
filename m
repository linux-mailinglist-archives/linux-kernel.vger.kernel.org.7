Return-Path: <linux-kernel+bounces-813300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E58AB5434B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6813F1896FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F2F2874F2;
	Fri, 12 Sep 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpNfUPyh"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59C287259
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659932; cv=none; b=Mw5rdutSuLAM85Wx2xQD5S1zq5v71DvDS/cyb4s/9sJ+20woOZ4dGCPkC8MyRuJQlyimpQbCtUGWRSi3UIZR6m0USYt9sMHcsUofCs6F32dLyLq8pkfEFtc7UAjCuGxzAYnoeCJGwLeBD5BprCyS9vn9WKPgKZqy8Lj4JxnU0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659932; c=relaxed/simple;
	bh=4jsSkRx+IjEMBxPTsR02v2orYmAPSIB2nNu/YIBdHao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKwvNaUge2uf+DbgvGDIyHxc6QH03MrXqwD9NVsdix+swYr6cmwEV0c5RS6aV1DwxSbvOd7GinpR1sbo/RG6+usgUufCey8qbj+MSjl8IhBspA4zLaGFtiL6RkIsez9ZhoWedQtjsq8vBXS3qLvJEf73RrQ7AxHafC9GZQPOWxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpNfUPyh; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-352323389cdso1406141fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757659928; x=1758264728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BTTBebWWhXN3M2UYO9CY59G3Xi/GF94b78s/3/RA3Mg=;
        b=CpNfUPyhhyanYu4ycDhEVbUrnsOVmbilCx4r++UUMg4Wzm/MkaCPiD5M+kcZ7QvME9
         31y5R3rgMi27zgT2qCik+Dyq6+lAPKCBTMrqlA0yw/6Z0lUdtQRhJr6X5PByV7AtJoA+
         3Wc5iFJhAXi2ipPSA5/OuG4/U7CsO4uZKf0aKI/o5WR/jHQ9pwwH3WFl43EN7oJhRHdo
         Py0BFrZBaRKuWE5etJuyKl7ROAcDdjGIGW8m/+6TysKf22pMB2HUrfrXwqtOK/Zkp7Sy
         WLBsmrXZoTOqWv/J5UANZ2Dm44WcbS8WXq9nmnCfGMj+nc3Zg9xiWoPR0chAGe6hZLM4
         lZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659928; x=1758264728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTTBebWWhXN3M2UYO9CY59G3Xi/GF94b78s/3/RA3Mg=;
        b=tAr+UCmjoBAyL9LjuyWXqMxvu8EuyLE//d9zNCdQp1GG77oUoxvOseCEPZrK4kX6ED
         VAxnlbD/v+LyLt3/3Qjn3eI0ut/SPWTdpToqCluACflcvsrS0yXNObCXGbD/EG9nf6RY
         yjqnDz9fCH8Bo4JIX314xQzyU3efxxIQoxqZYmRD97E0CmSOQH0bqxYM+iXkUlDKvF42
         YGa6U4cdHvhMKzlUl4a7ejzf4akunvDv+kJnQHHGbaCbssP7xjZwK0ia0IO4G1UYmmI4
         XN+thGG9QOkeU3+B9YQH3ev8j8th/IUI9F2lat3EpVvDOf+Ua9JzBI0D+WDuWcxlZpao
         +CnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSEG8x8yYtpf8RembBb0QbcZ+8LWA5E/sJRon9H0ZNRmRRe3+mWvVtkAiDKrJ8Eyn46IIZ/6Ik1zz3aSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhFtgOcPurj+3fEZ9f+jt0vz9D0GC3GmvFRPTy483P/B7TZunf
	l6KSIh0QFfvdQSB5RIwnmOiamq0lQQrjfES+o6gdNFwHMjjSDWFZdW2Y
X-Gm-Gg: ASbGnctEHATuUbqNSxlNEOfZ9nFetX9IlN5tZWeAK13rke5yrTCVl7HS0Ghb6kCI1oT
	I2mH/L1AO/ImejqChxGVB70z6J9s/VMB2mka/lNVqVr8vORv8NEBpXAIr7BE2sD9x/cVIodgXKn
	xNp8pzWbkUFiki8ZjIrSDLeAwbcmBaxrWBDF3Ypk7BDSY9lwE5Dh+BX+Ev/v3JqUs20XoxyR9hx
	S1LJa0t2HalqeQ8JXnB0HvFeX90CttclI/NZMS1OqAnR1gzh4vtJ6sawrC1mgi7LNDFahU1kers
	qpna8UfyCpSTbINTe6tQLXYy2fnNh5Pt2tyEhb//Pm+o/aPXV8WG/BuLigA2CgJFYCcWE9Fl3kB
	l8E1IMWPpspC/vQ==
X-Google-Smtp-Source: AGHT+IHbStwX8UvTaaxauHpx4VlCk3zXqkxaVM6ehQuMNCkmsiivpfkznPcjNjP44Z0KKwun2cLt5w==
X-Received: by 2002:a05:651c:3543:20b0:336:6c93:9726 with SMTP id 38308e7fff4ca-35138cfbec6mr3457941fa.4.1757659928149;
        Thu, 11 Sep 2025 23:52:08 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1c5d5a49sm7180351fa.66.2025.09.11.23.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:52:07 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] dt-bindings: power: supply: bq24190: document charge enable pin
Date: Fri, 12 Sep 2025 09:51:45 +0300
Message-ID: <20250912065146.28059-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document active low Charge Enable pin. Battery charging is enabled when
REG01[5:4] = 01 and CE pin = Low. CE pin must be pulled high or low.

Svyatoslav Ryhel (1):
  dt-bindings: power: supply: bq24190: document charge enable pin

 Documentation/devicetree/bindings/power/supply/bq24190.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.48.1


