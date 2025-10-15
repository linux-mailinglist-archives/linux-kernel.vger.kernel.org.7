Return-Path: <linux-kernel+bounces-855092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E47BE0348
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5A21885BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B84298CC0;
	Wed, 15 Oct 2025 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5JpU+IM"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102EA3254AF
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553369; cv=none; b=b4AkDpMztyusYuqRm7nWWjtXBEiNqmQCVW15GaBIAvfEzQ0NnyXeInWygpVctV1zGnlCviwvw5Xo5SdobWIEJrNiJH35Qh17fNk6/uGlcELMNWsGAdvk7+IYRsfoQczlOp9A13MbUyEKJfTHMf3QTXNTEQOsYEwqUkvg0VDjctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553369; c=relaxed/simple;
	bh=SmF3D/xPAHHTJEmyJroTr7AuP1k7/7uiMAUqeODvgg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YxoxXXTO2MOhRV4iUjUZkNTSqKYDGOaLJpppTKJ9hkfpQ4Ehcb/dNCsKOKJCbGD0gCgc3w+JapqXZU4c0kuLIREvKppRf+IFtU1+LKRplwvAFnKX7bJCc60I5kFzn1soM7KZepdNoTfWVs0GkphG8Gj2Nk+NoV5Fw5U8K2fTdk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5JpU+IM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7833765433cso9134166b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760553365; x=1761158165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JJWMwls+LAtfP4tAZlyMoRyCGxEoib6nFV8vy2YJhYU=;
        b=b5JpU+IMY9B/n7gtdw3r7x5vUBvXC0xjcsa5uPTgYIrKJq97DhKAI/o/o2/IEfGWaK
         LYXFm3IYj0Y2j3JV5Pxt12UgQmzISgia8Ox5OCr1Kpn+DAB3qh4gBn0z4dnWQloi5T6e
         fqIITLYS1BKUJlwA2cRvvfWqW3KJxRpOKbSeksHYNbHIJt++++4fAElqF5LANKqAGTkN
         JwBxHPqRu0S6XRBx0RnC22rfco/HFu0knztdy+Z7khD+42D+SSdl8QeWpnoFI5e7RciE
         QYteANWCZ/i/FRIAClAy/jNBzBZS060uEnI9zUSUY2x3yTQa9n53J2ftLSE0SovW3E+C
         yp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553365; x=1761158165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJWMwls+LAtfP4tAZlyMoRyCGxEoib6nFV8vy2YJhYU=;
        b=BI+uXutewcN6ff8NFRqmg9O5KaaFqjRRckl/OFW7GDhfTib1Eoa3geN07Pr6Q4QhOp
         J1EpKKaErhfocQAuDgT3jJp5SkKtphxaGqpTrsJMGuVeM5cu56PwY3hAJM6au88YXYhA
         P2GszeobNzMyySMqAOlCE1hL6hlV4QZu4WP8P8VTHBfmApKxTJSpzYvIbLAPRD02Jpm8
         WINBcaxzBDss4Oc30ACBqR5Emb4mZAj9NaShitV/2Su0bCZF3YnCqbmgtUR0EBBkQdN2
         bMbz5lqSQew9II/mvT+8SPTQZHcGK5462AEfgt/CWkvm0d0o63egTjsqvPPZT0H0bXiR
         lfiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm6ejM9+/3N6JfXW1XnqPxkMyleWA+B787IRo4EIAbcnmwdqIUoZKYnzYsjXrvTRujZUvzuy98EfQWkLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7qEUy/iMHD0uSdXwYugB9+eo4VxreqQT2aOY2UROQAfijpH9q
	0OxXOeSw6zo/XHgiz6xyNfJ11YVCe/jzwy+j2R5B6tvqHzxAuTPMZSop
X-Gm-Gg: ASbGncupG75ayEwHNn03EXKgCgV+hinNTvhAhQnssszzboRtj2vJ/dLUC9V7cgLxxtC
	YEJ6foxzkIJI2VKrZqhIg0mspEzSQyJ1t3jmncEbpN/6Z0CW/O9pyRQnsu/fvfsI+rtQw3PaBlM
	KMD11q68E6t6/9NwgGap7nENwRss8gh2p1uog/68tUOW6ijminby+4o2g3S2M2gW5pqblZ0Xt4f
	I/ONtc7tC874j8ypftscjmr92MFZCgSvczCeYmP+s1J26B3diuti2RPKSRZKyYQT6CZeQ/IkES7
	YUA9ONft9yDjgWs1DZSFLOock5B4SIj55zG2bRExw4OAwN7jdOViSGy4TZs5o0JFJvKDFWF9xYK
	d/G518aadsbqoJaTgXDPVh3EpVhCnuRDCKkcrGd9Tr84ehT5Y7aXMG5rJUZAkornttlzNcw==
X-Google-Smtp-Source: AGHT+IFlyCa56i9R5oJazvL2hNHkiDW7KJ+UW8SY3pz99LslbXWkSaiSVgZEMdYa4bSHd+QjdapDNg==
X-Received: by 2002:a05:6a20:3d82:b0:334:97a6:17f2 with SMTP id adf61e73a8af0-33497a6182bmr1030221637.14.1760553365032;
        Wed, 15 Oct 2025 11:36:05 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22b9c315sm298122a12.29.2025.10.15.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:36:04 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com,
	jstultz@google.com,
	tjmercier@google.com,
	corbet@lwn.net
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] htmldocs: userspace-api/dma-buf-heaps.rst: fix block quote warning
Date: Wed, 15 Oct 2025 18:34:02 +0000
Message-Id: <20251015183402.1649988-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following warning encountered when running `make htmldocs`:

  Documentation/userspace-api/dma-buf-heaps.rst:29: WARNING: Block quote ends without a blank line; unexpected unindent

Added a blank line before the "Naming Convention" heading to comply with reST

Fixes: 1fdbb3ff1233 ("Add linux-next specific files for 20251015")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 Documentation/userspace-api/dma-buf-heaps.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentation/userspace-api/dma-buf-heaps.rst
index a0979440d2a4..c0035dc257e0 100644
--- a/Documentation/userspace-api/dma-buf-heaps.rst
+++ b/Documentation/userspace-api/dma-buf-heaps.rst
@@ -26,6 +26,7 @@ following heaps:
    ``DMABUF_HEAPS_CMA_LEGACY`` Kconfig option is set, a duplicate node is
    created following legacy naming conventions; the legacy name might be
    ``reserved``, ``linux,cma``, or ``default-pool``.
+
 Naming Convention
 =================
 
-- 
2.34.1


