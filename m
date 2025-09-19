Return-Path: <linux-kernel+bounces-824579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCE3B89979
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2D01C86C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E1C23B62A;
	Fri, 19 Sep 2025 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SKM1GNEb"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D0226D02
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287200; cv=none; b=B4yGTt24sR5OqqplhbTsL+qnHtG7bX6a3l0Dblb6Zy53Zfc6rpwHp4XNEXrqC/wh/jZBL6dbS0ihLpCVORtLnE6MHfsbjnx8vk14Fl4Vd7uqpiVc+0OQ6oNIq/6aHzVaFjk/rI9/Z4OTYLu629zgj6L7cCpLQNW+HnXmiZlGlpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287200; c=relaxed/simple;
	bh=I1KnJytDI98uzyU9VR0CMYknvs4wi7QfemM11ZziiWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wc3s1Tu9cxcyulqu5gr7aE2wsu6NIdXZTkmIBkJiQ3jky1Q1qRFdEpY0m8FOA0a4jPGqvCPre71shfON3hWoi/Wi/ZZCMrY/X+IkSwDQ8snZSOrJDdKiJEYOtjoXyFgn304odcEGT7v00EhSko8N++XktwbTHbDTwLnA5wi5slA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SKM1GNEb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b550eff972eso1022808a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287198; x=1758891998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXrNbcwSvagaIiS5O7F6FLpYe+f/n3DenUIqxElurVQ=;
        b=SKM1GNEbSN8kmER8148BHQswjuTRp1VL7EwXAy6KuyRuXuFZNUtKDH2+1F4bEjm2aG
         Cr+KM3nfDR0z+T0sNxlMaoVsnq6KJvvVET/BUdun01b5RG1UFf1jiepkl/WaE3QmIlOT
         gBs9bt/dxwcuJTY24YjeXcDL9NlWHhBmAHZgGv9K5eB/1St0qorKDyua3gfDGk+0RASd
         n+xtg2ZugwVqhlneoCH7VwPl0P/Tked6ExjjaPy7lVl6hABI+f5BI7lb+1x6KgItmSvL
         FLs1T6AbP1jBZ1s04VJMHoT/aYlipTmRtjJJK/rlCjBT5nrhmMGXxDHymRnO/QdboWib
         /z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287198; x=1758891998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXrNbcwSvagaIiS5O7F6FLpYe+f/n3DenUIqxElurVQ=;
        b=dAD63rxv3zNfVMw4QqUA8r+cxgJpsathgmCsJuJDSaHdcK71vsYa8Vdgyaw2Ujd4+J
         L5qDVjTgpupCvaVWuU08i4GyYlKkyCCtyhx/0GCSR+gnfvv1QRYKuKEnKTQzk13WyJo9
         itcfHGlvz2FnLS0lyA3cYrFUbP8xFVqkQhNXUkKVHujidgGtDTM9N/rrqCdBkI5XT4eS
         pz8dYtQwgts/K6hGdR76ZoT+Ni82aFV/6OoOO/A6UaAZHuFu7ukCVy31K7IogQ+cI/Ma
         H8KXgqVycblGXUXx4tONFH6GoVhxnmoQgxgVkMKbCi8M5B6tdi0cdgCRI/fHyxhNW3Kk
         /H2A==
X-Gm-Message-State: AOJu0YyVFUDUIhOChaz6AU/hpA+6g/i2UMqY3TVciZxMc0MvErqgdoCU
	crkFE9ZcAo3cNnNnuOZaIrAoJiTgPowhVRT3EVdyHsh1HbgHQzYOFL3QnL10AOXKwC4=
X-Gm-Gg: ASbGnctpJDz6S4LnSWMWZqOb4JhF/aWZ2xpxrRuSTpvKxmIwBqy8wX9qRk+PgS+yNWk
	W5psfGheYpq0ghBX9wecVWxyV3wWTRWlWlk8DI6Syigpe/F8Xr5go0coNhFrtXTOnSmRQg/hZrK
	CCOPmoikpoqzD0abM0HIwepLyGgi7cZijZ3iFdewhVM1duFxYBmi9aAKnAYnHkUn2LrgIBIzx78
	sfz840pLp445gkJMkSUMZmJ28VuUwVVjhrq3SvkJ7NtBXMq/qY3L34m4A/4b3P4oftVVpnHGcGB
	rbRzDrivWOUa/GgomvZyGPd5s7lcFdSlZjxIX/6aD0lp+uj/h7wxRXsir4VG9rWNR5MDwEmAW13
	/mNq3us5jMHCP2N2i0e4eMkOd9T+j95GWti4aEIz4/lwWoMc=
X-Google-Smtp-Source: AGHT+IGjrAZ4ana6L1lfOx9cqydZTbCutC99XQcIBsreys2Dh65escr5oEpaYr4mKrnWMUardvltDQ==
X-Received: by 2002:a17:903:290:b0:26a:8171:daf7 with SMTP id d9443c01a7336-26a8171dbcamr33445425ad.16.1758287197311;
        Fri, 19 Sep 2025 06:06:37 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:36 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	libo.gcs85@bytedance.com,
	Yongting Lin <linyongting@bytedance.com>
Subject: [PATCH V2 2/8] mshare: selftests: Adding config fragments
Date: Fri, 19 Sep 2025 21:06:15 +0800
Message-Id: <20250919130620.56518-3-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250919130620.56518-1-linyongting@bytedance.com>
References: <20250919130620.56518-1-linyongting@bytedance.com>
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


