Return-Path: <linux-kernel+bounces-886334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C4FC3542A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 377483483FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B8830C350;
	Wed,  5 Nov 2025 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZxPgpXg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvatTV13"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820452652A2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340349; cv=none; b=a7BBI0xK0Yb31jgZlaxgiK7PAKHNY8nEziunuzmKRLYHwJYZR/B0tfxyGNWjvHzvBJWZswJc1NeCqk7D6qsaJaiwDF5yqW/d0G0yEqRKd7KP7U8cvDHphyPq2NciO0k0KuBJ4hXeiZ9bXIXiN+C6F2g0JMoOw6j3KX0btnc8rs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340349; c=relaxed/simple;
	bh=mDYPQoa9g7C/yEpqbRIi6ESdyE1WLl8zUuyXg+ubNy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HkHOur/USDue/1ifgUQ/MH8y9WaSh0JraLCnu5OUnywoGjNNGjrk1bzD7GHMPfoJKgTu9daoj7jPAyoGxcCly6LlT/7zJaFtHN6kzn+eXumwyTJNs7Cj9Nc8xNNn2tOdD7vx2A9leU4jKd+Ubd8tMtBxGu+Ymrin+VEecATXwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZxPgpXg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvatTV13; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762340346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fi6lMVZB+GdSzEqZmyJtwxQVO8YBPh6HS+ZyxPLOlA0=;
	b=QZxPgpXgK3LSIynb1WLcLHTv+ElxDDXG+TEM40KDhHiVqZH5auezuyd8ysZxWRF1mcVNmH
	b6COqa5TJyYHglsf8k35OJ3BTpvMKGu7eu1PRIxPkRbhyjlxZ/hrsxRphaR+j4mUyFeKqP
	d0VS+290s20Eu7Mn2TvhwcluytAmOK0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-Hz_zIDrKPTm0vUcAY8pOMQ-1; Wed, 05 Nov 2025 05:59:05 -0500
X-MC-Unique: Hz_zIDrKPTm0vUcAY8pOMQ-1
X-Mimecast-MFC-AGG-ID: Hz_zIDrKPTm0vUcAY8pOMQ_1762340344
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so5536345e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762340344; x=1762945144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fi6lMVZB+GdSzEqZmyJtwxQVO8YBPh6HS+ZyxPLOlA0=;
        b=LvatTV13nKsR7HuD2OBSVSCbKiUnsb/3nZT3pBVig03ZtUzIoyWbQ5l+MNvlfzJLdu
         TllfZa51xrADveEhpvutdRd4q0clarkcAoQYBtJMdlJaagffDhpMPFEIIDmo747cLi0P
         3qCZ2OehMcrUl8vpuD/N+WJarCfesqkW9Xq/9oeWO4tLLJb06YnMEGBo0M/GQgTbR45O
         0KVL1bC/ZPnNEKd/wspgrLe4wdW8UrB1mzKuNnGHNcItX/Opn9+2DIeZAw6zmyGEEiRj
         EZIodFfJC/4CXfhkYjpqvegQJX5apkoWmmAE1wXlEAJRLBb3ov8sjBUbAgJI1Tnw9MXQ
         s1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762340344; x=1762945144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fi6lMVZB+GdSzEqZmyJtwxQVO8YBPh6HS+ZyxPLOlA0=;
        b=H5IIqP/5ouNo2IBBMMKUPPbgANEgYE/qE8kXTeCNjmAAT9rD1HGowyZTJKWYtYqpdh
         06PjJ+vv4pfznxUIgtc6ivfmSAJJOvcqgnDSAXxgpTCtgIxwmFFLI3ffQIVk1H2DG/id
         ZbE8F6SOwQbE1Pil/y2xViHx1RHDYuy2QVUOu/V3ztzMbGmXU2iiChjHySWVWRc+gxxQ
         B4j3NW0F0LpXqFtqJ+IlCk8rJCIxAxEXEoKauWXU5/SBJzLEJF+vcACWdVrOgzfnBix9
         46V4PNs8hC2G7ZR12Ot2CTwhvaMC2lOIb0UGNDW1ol51dnPnJ7j7JxhT96IiAe7OzTh9
         DEAg==
X-Forwarded-Encrypted: i=1; AJvYcCUELAFWM1nrrQXeTaqt6rQtmIOMggTqXfpN3uz5mwI+s6MCP9MJkTeLcNpV9I6jn31SsXVR2dFSmfqciBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW6msZdikqxt3YTR78SvXxzbxviG3hQXyfjZv3ortp0Xw2bZoP
	4iOOQzIxxTX0wzH+N10DZ4soxAajUcbk73sBvmm3FtHRC87oMZszl1YLQnxm8+5/cY+Hd+ZuY/5
	Ji/3zN2uOCjyZQMjiC10k+8qRwZk2U4HADksaQwXVgokLdFhbj4hoihKHzEgjjT3qUQ==
X-Gm-Gg: ASbGncvaAgjY6Ri0bcYhI8YYfbp17yv1f79eGaqMlVt0uAPfwBcHEiSgn47KpXHHzoz
	uh7fEHpIih0Xt8i2a7j/PSn5y37+ZzExhkMFiZmLZ880v6HKd9Dw4jxGT4ZQKk6dQOnNu6VzkF3
	0sjKNFqvZA3E1nn+GDVx05l2IQPq2UkaDYdsEe4vo+hWy4zL4RQON7p/pUi1dJJJgrafeC/G21k
	v/VUs/aOQDsJsru9bRqHPMRJEQ5OvY7Ne55AxhWs6Mr06ulViB5awTHAUH10qAIxEKbeQ7Mk6vH
	4X51wWkRIztlpOVS81m82wl5IfewjlKAupB02Fi44Kz2BDfkFC6dQWaiuc4+3NWwEpaCWMjNYWs
	ewwfRk3hYddrOq2anOiR/lF5NXWxBO547jn4M2RfCzD9qg64w
X-Received: by 2002:a05:600c:a00a:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-4775cdbf0bfmr23847035e9.10.1762340343914;
        Wed, 05 Nov 2025 02:59:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGMcjTBOz+Nu6wkEk+5mmod0huDiyH5V1WOUYLCdKWa9YhZHNUKUTSo1PqiQsOwaH+WwN8Vg==
X-Received: by 2002:a05:600c:a00a:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-4775cdbf0bfmr23846845e9.10.1762340343543;
        Wed, 05 Nov 2025 02:59:03 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c4edasm39000785e9.5.2025.11.05.02.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:59:02 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: add idr core-api doc file to XARRAY
Date: Wed,  5 Nov 2025 11:58:57 +0100
Message-ID: <20251105105857.156950-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

The files in Documentation/core-api/ are by virtue of their top-level
directory part of the Documentation section in MAINTAINERS. Each file in
Documentation/core-api/ should however also have a further section in
MAINTAINERS it belongs to, which fits to the technical area of the
documented API in that file.

The idr.rst provides some explanation to the ID allocation API defined in
lib/idr.c, which itself is part of the XARRAY section.

Add this core-api document to XARRAY.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b5f86dcf898..01e1668cac02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28010,6 +28010,7 @@ M:	Matthew Wilcox <willy@infradead.org>
 L:	linux-fsdevel@vger.kernel.org
 L:	linux-mm@kvack.org
 S:	Supported
+F:	Documentation/core-api/idr.rst
 F:	Documentation/core-api/xarray.rst
 F:	include/linux/idr.h
 F:	include/linux/xarray.h
-- 
2.51.1


