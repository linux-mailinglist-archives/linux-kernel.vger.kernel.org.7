Return-Path: <linux-kernel+bounces-785026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B950DB344DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7873B8D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECF33009F2;
	Mon, 25 Aug 2025 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fDqzC7VD"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7EA3002C2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133890; cv=none; b=h76iDOhS+FkeRCS9kYVfGPVzZUB8CUji1M4zSpsg0YuwdcMcCrSeEArTFIZycAd8/Xwnkk3Us3pi7t3rIBydGdKPXU1pYaGJRG+yie5+XPrByaoJFXfRy4hFMr3Lf/4u+MdH/YwaYfuu2TgiWzRRzXAxWxsFstoUCMjbJ2bfyVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133890; c=relaxed/simple;
	bh=I1KnJytDI98uzyU9VR0CMYknvs4wi7QfemM11ZziiWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sgm0C36SsLJT8Lg/jMof2tqYAGeUhUL6B9IeTPpuQ19akceqBQfhn/KUvgfTaEK0s4Rqo9ijsr407f3vwPIWUarxF/Beemlbc7JHKxX32yAEGJDmIbXXOG1FM4Xq2dP75w2zoMroz4r4evnterclve5Ur7nDXFXVFcnsLYLeL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fDqzC7VD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-770522b34d1so1277279b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133888; x=1756738688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXrNbcwSvagaIiS5O7F6FLpYe+f/n3DenUIqxElurVQ=;
        b=fDqzC7VDzSzJoucuPfUfalYyuBmv1F0hBzk1vBwhsdPTjfH3zgh3uPp5VWBY3NiFDS
         PIIyWuFi0rZGeNfP3CD+K1sKhCv4B+g3ruGwpyKnXJ5Vybaoe5oduwqjd8DoDWO6RpLO
         EWQ2POtI14bmm0Zncb9hcWlI5SDDDbxbLMHOiaEihF9fadnGLQwEoulGfUX5CFEYMbby
         EzDIHZvJglyBKrWz+Bk1VX5WiVEyQc4bmKDZgYrP1axQswQ6mhbgIaeyyOJblzgCKsx7
         n0udJvHnuXGJ/ht0YIr4/ipioggvBrWOXV5wGlNE/PL9O5nTeOA3ExWq0nUMG4NEs38y
         tvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133888; x=1756738688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXrNbcwSvagaIiS5O7F6FLpYe+f/n3DenUIqxElurVQ=;
        b=FFyhCiIz3cWdcvT+nEbc3lE7/pMdvlynbA7U9TEIqNZLq5uwdXmIDiCgYZD8rAACBH
         ywIkbzXXBrv35wyOBQSz1CWgPOvZ1vQcnvD/T6tjrFJJv1aNRVkVgN7r/24fjSEZvLnh
         X8b03Kr1Mu8jQmT7AqXS8zCuW7DUyDILaap7izvFs1ml8WgOTE5Q1p4miHIVI4xkutus
         S0/bx22QtMiHApG7X6oZsSe7txaxlwKIJ5XwNDTNMHDPW/ZTSNgds9zdsXv601Nkuv9j
         7QjYr6MRS6dKBquTk0YWK9n2WYATEcsZFCilLJwqxvsEGxgtPd7DxcRsnxudpmx5F2g/
         V3ww==
X-Gm-Message-State: AOJu0YxRk8bPWKarDOA5Ukg7bly9nNOUkdWQpF5lqClEmcTMXLchUrTx
	v0T/N/yCxUm/kEpEwcM0r2zD+a4fo6eT2ocCuzQrGqkKdthgpJ4w0bIWFxSVPoJmuStRkJFUuF6
	dnRFNazw=
X-Gm-Gg: ASbGncsnQ9lSMC+oCMd11XjWA/hJ2Zwm5MIPWpEuWVX9hdmIwxJVz1E5vroxJBrlef1
	xbSnYx/HhZfGOS83aJuuCQckbkVIb12lpkbWu8x2MzNPgwpam6ZOjZHGl4uBoZg7M2gd2maFFla
	nven69TYbTuK4v+Mb2TW/zmNgFUhhT8RltKUuyOl2rkgdQD9uL4RMfPUKeHUoTQRbinDk1yVwL1
	sS4td5kyxH4EaxSv7w2awONMaV8TZNW10SGDxfULB5QeAF2mCeTywh4KmstoUmCC6sfuuI+dBXP
	Nxe2u9uJOyxTtNjfvIH9EMB66PEcY9rfiY4fj+tAJkN/cXAuBgdx2IXZyfp11i8XtNlG3RrXNsw
	YYYj33+WijR4aqXCQnf/TSr0rpq0biwc8JBXYKpLsH9jSNzCC/USd4nP12Lcd7ipegNwfTVI=
X-Google-Smtp-Source: AGHT+IGrjnb45Fa7DHzuc6Ch7rwJg1bCnvoGJ7/OuXRvlJDXrJ/ha9DOEb+cFlOakG8+pSYCIswgXw==
X-Received: by 2002:a05:6a20:a106:b0:220:1843:3b7b with SMTP id adf61e73a8af0-24340b58322mr18480454637.4.1756133888059;
        Mon, 25 Aug 2025 07:58:08 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.58.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:58:07 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 2/8] mshare: selftests: Adding config fragment
Date: Mon, 25 Aug 2025 22:57:13 +0800
Message-Id: <20250825145719.29455-11-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mshare test cases need pre-required kernel configs for the test
to get pass.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/mshare/config

diff --git a/tools/testing/selftests/mshare/config b/tools/testing/selftests/mshare/config
new file mode 100644
index 000000000000..16fd9a3ca12a
--- /dev/null
+++ b/tools/testing/selftests/mshare/config
@@ -0,0 +1 @@
+CONFIG_MSHARE=y
-- 
2.20.1


