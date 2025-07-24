Return-Path: <linux-kernel+bounces-744397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EA0B10C57
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193E75831AA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781142E2F1C;
	Thu, 24 Jul 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NnjTYfIk"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3D62DC325
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365389; cv=none; b=DmZ5RQstPLZ7zRKXb4h+rbI9s6KwbO+xeNC8362qbZohLJ/pd0rqiMCRNsgVKRGbhAQJFNSMcwZvwza9q2QeqtWXVk5L3pxWebSS4TFw+rWd8ZlRtPiM/t1aixh6Np8ttPwKe+yq/95iBTO1qW64Kp6Ows65LyqLp9u8EIeKNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365389; c=relaxed/simple;
	bh=I45+7S3jIU0dNMjyY0XWrWua5DCAvAPB8OAPs7f8VDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZarstr3a1Nu5W19HIHSZN7FXNAb9r2sOpAgf1w1RswTHUqbRCCVP99f17TGlx5DRtxR8Kba+MyUu/1pQHYCLkwL2YZXVzMh/QLgKWnYS/qJWkT/Oa9nyY7fizkXeexj1JnaxhWYb3MeXuQF21clK0zG2tjgyFKj7co4jRQNhys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NnjTYfIk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso10991205e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365385; x=1753970185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6vaDGqz93WFfpGOQ4UOrak1EBQhkmEoatVxlVsxTPs=;
        b=NnjTYfIkoofWBpyRAUQVrPINFMHx6ciLZrAV3551c/s6Bj1eu732dX5Sw4jJritVva
         fnALdGP4ixmhlSo2YP+i2J5UVqKiq4Z/HvlNvym7QH1ERjo6JRMClZDHb2+uCVkKv6qA
         SSgQ/q3VMTU/BUyiKphTinzhE987stIVuRh59Nv/roytHJcP8ZDeI5/sX1+TRYO94HbO
         zkCevDJTtJIdsndC2GstqBIpVfeDvKB35SSg28H7MZ0nxa7MNiJzIka4YGQvxums+hZA
         uLxS0NOrEzL1WroNaPvAzx7yd1q0ilyUzo8DK6if+U60oMf010Icukd9OPspDyfp1CPG
         Zp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365385; x=1753970185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6vaDGqz93WFfpGOQ4UOrak1EBQhkmEoatVxlVsxTPs=;
        b=Ma3EUWUU0mtztKzjnQQXeDjbZYt5vAdOx/fwIv1dz5En9m+9RO+3yDO75lnuKLnO40
         /MSAydD6oeE1ljyFAe6p8HjGce7af/BVM4Ij7CZoNh0KQauRSphUNn3MrLzQxIkXbYhd
         35AE5OAtP9vxoMizyqgeVwa+FrhvtdMHQEvz+7pVN8NaRKQkOtIz3eSuHmUc6KZvZZEg
         mYDu7Yqckuco9dZDg3osur056uUupKGY9hIYctrHmN8hTb3R/HuQ9mpy0dmto/q9EfLq
         TiQNB+e1oxQQtFNKQvTCKXMRj/xBHyv26n2f3842t3sadQ04FqvF4cQbP/DSKJb+cS6F
         6Eog==
X-Gm-Message-State: AOJu0YwmsuVHTOR5W1U5sEKYgGXxudFFGx0TcWmC3DA8rGpg1EdAA++3
	/uy4SiJAbTV3Qm2vh0v60fjL6rIY8DLfQhyDq2iIIXRdVIZAx3UzMu7tsA7P7jkRI1xzd/Uk62w
	XQZ4osH8=
X-Gm-Gg: ASbGnctHgAUnQPt8M9ionpdqOxu8kQpNpV1eYBDzjM9/GR762sOlgG0Qilmx9b4vQwc
	OZJQxiTlpupZ7UhjNzzXVKAok0SAdpoeRiaDNlvCIQKM+1AweBJMR30KfUFogBmbqawRfZFYozQ
	00jwUHRpn1kYa2oBY3gZ/youGNjuteHlnhpWEtD1xK3mR6fDDjqYbGklEw2Ye0zIYGZwC7DMiCR
	JnJEHQqG4U5NNaYyAHZPDO/mugEQfTP5MmrrUmWL6oNRPiXfjDORVBX+te7FOWnBn4csV8zloi7
	BF+7tPeKbDv9ay250r2MhNJvDp3QXVBNuJcTew462jMbNfWNgax//dafZEZG9qQkpRJhlGMjHcZ
	E3iV3qHLPrRAzWXhS7w0D1Jrmgy5W+NCh/GBINMXvNb+lfuHN5fNRG3g8C+l6eYqfleCxbZ1CB/
	v4jq+UZaPMltdp
X-Google-Smtp-Source: AGHT+IHYnD8d7A8aBh+5tnrqY0LYzarTFZbBZJYJd44Ilh6yiLc/UVbK9j+FmYRR9VqOWZQpLWbc7Q==
X-Received: by 2002:a05:600c:500d:b0:441:a715:664a with SMTP id 5b1f17b1804b1-45868d3289cmr52540145e9.20.1753365385393;
        Thu, 24 Jul 2025 06:56:25 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:25 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 04/29] Documentation: kmemdump: add section for coreimage ELF
Date: Thu, 24 Jul 2025 16:54:47 +0300
Message-ID: <20250724135512.518487-5-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add section describing the utility of coreimage ELF generation for
kmemdump.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 Documentation/debug/kmemdump.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/debug/kmemdump.rst b/Documentation/debug/kmemdump.rst
index 3301abcaed7e..9c2c23911242 100644
--- a/Documentation/debug/kmemdump.rst
+++ b/Documentation/debug/kmemdump.rst
@@ -17,6 +17,12 @@ kmemdump allows a backend to be connected, this backend interfaces a
 specific hardware that can debug or dump the memory registered into
 kmemdump.
 
+kmemdump can also prepare specific regions of the kernel that can be
+put together to form a minimal core image file. To achieve this, the first
+region is an ELF header with program headers for each region, and specific
+ELF NOTE section with vmcoreinfo. To enable this feature, use
+`CONFIG_KMEMDUMP_COREIMAGE`.
+
 kmemdump Internals
 =============
 
-- 
2.43.0


