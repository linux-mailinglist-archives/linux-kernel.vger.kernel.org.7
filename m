Return-Path: <linux-kernel+bounces-868404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE4CC05167
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE301188A850
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBC43090C9;
	Fri, 24 Oct 2025 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ufl6mLk8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4EE306B0D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295023; cv=none; b=o7JDwpC/rraYnDMmNx9AZz2dGcdpBJp+5sejbm8Ci5FRz9p8cUWlaStq/oTksUWReqvWZWV4vpoLzGEEzlQVxyVN+KpV4razso4zlnx4ctll3D9wodM4zG+pT1cx1iSHk5uZqK5rO3AIZF0TjY3vlhEiucqAzlLMLrYxdbjmcng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295023; c=relaxed/simple;
	bh=GwdorghP7pkx6jrL0xNhcOjrQ7rW+RmSi107hDe95KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSkgAN20pYYsyRu3WKg1LelQnWZjv29HiNjGaLgQPAcU/His08gaEndmCQWU+y7p1TDzYyqCk+0WGzouwQeOhbG4W24ItcNXNpie3HhIuSq8qFhgop3FlU+zHudL4AY3obEh50qHgd/fi+NoYNcsA4Deqec7nfTk3Q4PbMK21iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ufl6mLk8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761295020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyZc7IIr5uPHqqlmg8fs1xLiepRwuPem5qvpkm3Ay88=;
	b=Ufl6mLk8HeRuWd65rYtwsud5axCTlR+cbT34VYkLazp1Ik8UUeVNg4fsbqCVzAKGeSufA/
	qLZty6wJAwREvIHAei+BgwoWRYOo+/+FdylDn2RbjjmbTUaTfIPQchgKnfF8IBs6MquRpJ
	ttP9eFRBQcbx68zHW9rVNKllu8ucby4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-Yv-cIkhOPZ6prKNyLwGS-A-1; Fri, 24 Oct 2025 04:36:59 -0400
X-MC-Unique: Yv-cIkhOPZ6prKNyLwGS-A-1
X-Mimecast-MFC-AGG-ID: Yv-cIkhOPZ6prKNyLwGS-A_1761295018
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-426feed0016so569789f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295018; x=1761899818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyZc7IIr5uPHqqlmg8fs1xLiepRwuPem5qvpkm3Ay88=;
        b=NvTYjNRyhX1wo+GiL8lVAhscHRBDs5V6tmX7cUrLsBi9KqeEguHWegXCFRx81V+PRR
         /3IUFnLlFiudbjfxA++7Co0TshIwrw7/EzSA47QAwaGohnmTPUUmCC9ZZeeleQvPE+ca
         0ldskoY2foP0+JhUYaBQtPfTtBsW7el3wOVtZnWAIuwXIGMPAunwhDdQ/UF1FuutJmTI
         A4CX6gUEA8thAF25NNPhhHOpLL5OiU4Z+fKWEB4+h1E+n1mlPf+rnR3cegzc/T9Sb6hn
         hjE79sUj5NSU/HcVTBs6gqZ/8k56yVXnfFKlkkMMiYdKADj+xjWmSBeXLafOnzFzHGj9
         fuxg==
X-Forwarded-Encrypted: i=1; AJvYcCU29AHEYVPY9DIPYG1PumT/qqBOk85f6zatuBg0/exxvvVOiFzwDhmNBc+Zpvc5z8iWfdCqUqBcazBoIPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8MfV4d89Obhte21e1TShuJT0moJLDkO8SA3VVvU1ADZXnu2V
	IdYlDIaJqqWJFPKa0+hPoxnFvfRAam87UKyzmyMwXqCXwvqIlmEJKZpuWdGzXiRlhsvZQU7n4m3
	VOHf/L0itkwE8M8L8CzfVgRUJwOonplOKmi7dFcXm6JNbJ63CIV23r5+PP09oylM4FQ==
X-Gm-Gg: ASbGncvCFtKWOmIZyIOU19NJ/MNMMspnIysMdx2Nimz6eGeyVspn/MFqoddH+OIIfmN
	JyaIkot5G+nyszpqXV9EKzvsYYx6fUrvJrP9AkVuoZHCdTVaC3M43wIMGXYbG2pHCMU/rjzomx5
	e0kO5Q7RxGW3BksC3B45q8ICo8GGOj65cjri+jhNYSE3gK11ko7MVX9qqzzGJc9U+WGRZQMevqm
	L3U7raCb0UfctHZz0u/YAIgwtk5MOM4HDKMvn092JpqFGIoqr4I1kAQ8d9uGLVK1Pqt3OM645jY
	hq7OvAHP64ol1zTaU83mXDDU/beYV5gAVfGfcI1xv5pCC0jEKylPVfZpLIzRt8bv1SFtMYF2Jgy
	qaunWnDkb
X-Received: by 2002:a05:6000:420c:b0:429:8a71:d63 with SMTP id ffacd0b85a97d-4298a711381mr3025034f8f.37.1761295017851;
        Fri, 24 Oct 2025 01:36:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnbrpFOQzLgO88uWFT7Gj4PKWUmuhiIJyW/x5PkRHgKL2dskBgGMAezA2xHjRvsFnb6Zht+g==
X-Received: by 2002:a05:6000:420c:b0:429:8a71:d63 with SMTP id ffacd0b85a97d-4298a711381mr3025017f8f.37.1761295017487;
        Fri, 24 Oct 2025 01:36:57 -0700 (PDT)
Received: from holism.lzampier.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e77dasm8111636f8f.2.2025.10.24.01.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:36:57 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: devicetree@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vivian Wang <dramforever@live.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] dt-bindings: vendor-prefixes: add UltraRISC
Date: Fri, 24 Oct 2025 09:36:40 +0100
Message-ID: <20251024083647.475239-2-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024083647.475239-1-lzampier@redhat.com>
References: <20251024083647.475239-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for UltraRISC Technology Co., Ltd.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ec8947dfcad..887bcb792284 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1642,6 +1642,8 @@ patternProperties:
     description: Universal Scientific Industrial Co., Ltd.
   "^usr,.*":
     description: U.S. Robotics Corporation
+  "^ultrarisc,.*":
+    description: UltraRISC Technology Co., Ltd.
   "^ultratronik,.*":
     description: Ultratronik GmbH
   "^utoo,.*":
-- 
2.51.0


