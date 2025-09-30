Return-Path: <linux-kernel+bounces-837729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C61BAD0E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274541940A64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90732303C9E;
	Tue, 30 Sep 2025 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/DOm/ft"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD523507C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238850; cv=none; b=Jo8Zz40ZiXhGZOZeSd8X5IUg9GL1sSJCy2VODy1iIAIB1UoZriYj/4xPFhgNWx+GmfFQaKHezSDx1Uz1brofdvW6R8zVYkv/fOAgHMsEJbXwMge60UhOC3kyU/E/mTC6hSPTCeua/0KD7q75yRi8pcZ0USmnaqHGU2i9SyQsbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238850; c=relaxed/simple;
	bh=p280qPQj27zEghzXtASKe/5ZJm4NWAcJ5opk5rxq8ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiCDi5QRlK3aqFxfF2b+RlTy9/51b1RgHm442t/K/BKhRaGvsmAWJq5IfaGVXlk6Vewne4GkUy1gNleAXxldFTAL5LruSZ3XMsw54wW/fuGF5sB+gUQ53CMazoYaCJdmDiZnDNZcFK7IxnfWN0SxNIOqv3Yn5c1eqi3nUnIWIus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/DOm/ft; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so465853866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759238846; x=1759843646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpsQ648q3C0xKugj4mrt9FABQZLoyanw2vv+wH0Qsz0=;
        b=g/DOm/ftd7Mj7D+q5GPZ47BU5tOLnmY/ck72FUktAk8JpiKghPMqmLJIz0rRJfA81z
         rajwp1wcZ/X1BzTw2EVxRWx5jGM6/kH01th+DYTb2komLNSDQQNmlEd2FOtn2osljmMx
         CuKlWT0RI5C7Xsq6pFCKE//xChYbWvR0TvlQSKV2Mp906Uy/IJXlOlJNp/rz8QN8Uz+G
         9C5UxKLCVyC+irERiD8xWv8QMIle6h9li9nKkKuQ7AAvp6Sggbi8373izgrnWkxaiP6G
         FEVf9fJq7KUGrsB+gVnA/MiZEflRYzcCe+dVMaKDLbz/AtEw6SXJHJfZk20IiD5yG7Pu
         WcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238846; x=1759843646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpsQ648q3C0xKugj4mrt9FABQZLoyanw2vv+wH0Qsz0=;
        b=bSbA0JXoO6/XW5gfRN0OcCRbllfk8vuYE28SdX1Hs+wTTLRQY8ZzRMLIiYJjyP1kNA
         XbvUKbsQkuT/eNEgAOIORzinjwD8S98x9VADA5PC1nqcpGpHjlvQvsRXDqDieOqd0jZJ
         vR42tEQQZqEtBCltYiluSzlu5flIT1/4RwWcRdJ8pz6pf+5a94IKH582Vy8zw0eg61jM
         kabHzRqaLMH9zP9zHpLHxQZPpHcjJ1S+5fKior4Mm4Uqy6wLdmewCiVeJVjTFw0upQyl
         fntcGFgi4ougAAe8uLbSasnxQRh7xbjfP23arI1I424RKw3Y5Sfwlz1tjl+4xdH2/izf
         TPIg==
X-Forwarded-Encrypted: i=1; AJvYcCWKf/Aux9AbTOILgFJhOFvI1MLnumYQ9IPcAdz0yzCEJJwyh5pAO/tfGktekyyzDdQ7MN5mjJx/1iuhkIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4RDEH/FaFWTopgxF9z5qfT2RuIlsMRGrN2Dkfkj9/nDm10au
	Y31UpMBobjXLs9HnriIsFZ6tbkB/2yLTXhlpxzlUoTmfG2xTojQwhVAg
X-Gm-Gg: ASbGncs7lHXtzz+NO+qV7q1lt7NbK+BhPQIaYxS5MZYPhrZNmVGTdvIeLtZUGq9J9mK
	UVuMDwUSiauwMV3FuOQ7hhbthTZZGQ9f5io4FZ/BBwyv6s/IzbSoTUvehQSTFMOwhXUTvKfOlp0
	7AYYqqFwFOgo2o2o4rGeLzCNpvH4HA6vJWIpbUU1JTnKPe1DsXR/VWNgUt32mjN0vZ6Qi1XRAir
	lzVcoBwaNKS+Li6Rl2lCNNKQkIGpP68oUl8nDwfrkJFLP5cTqYb+m31hnw0r/oP3K00tmQLl55h
	C9dYxC/pVZxfTAP+U71nOvjlgkinwCMG9nkeIs4E5zXJKB04z59K9ZJff3mafZpsSAkIBOdsF07
	DqkUHzUstu6axZN0LR743lXy1UkmQnZYLHyUWMl3bA9dxSCR+DKqjWvhKKBX5KpzcrA==
X-Google-Smtp-Source: AGHT+IFqZj82HIUPV+dIzJvrTOxVkE1LRYZqyDhYctKIsl9P0BboCTyc7K3Z5HX1b2xDNVD5wraHXw==
X-Received: by 2002:a17:907:3f88:b0:b41:e675:95cd with SMTP id a640c23a62f3a-b41e675a6damr413544966b.13.1759238846374;
        Tue, 30 Sep 2025 06:27:26 -0700 (PDT)
Received: from crusty-box ([88.223.153.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa46b2sm1143934766b.24.2025.09.30.06.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 06:27:26 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Add Asus ZenFone 2 Laser/Selfie
Date: Tue, 30 Sep 2025 16:20:09 +0300
Message-ID: <20250930132556.266434-2-xerikasxx@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930132556.266434-1-xerikasxx@gmail.com>
References: <20250930132556.266434-1-xerikasxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for Asus ZenFone 2 Laser/Selfie (1080p)

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 18b5ed044f9f..1ad77a68fc11 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -88,6 +88,7 @@ properties:
 
       - items:
           - enum:
+              - asus,z00t
               - huawei,kiwi
               - longcheer,l9100
               - samsung,a7
-- 
2.51.0


