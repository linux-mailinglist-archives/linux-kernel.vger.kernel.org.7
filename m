Return-Path: <linux-kernel+bounces-881215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533C1C27BBB
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 11:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4BF1A213F7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 10:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2411B2D130C;
	Sat,  1 Nov 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTJ3CWKQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D012D0C7E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761993612; cv=none; b=jIuMKz8hD8KvHIQ9eT0vxE7hIlq6pEuKSyC5qcL75SOG7B5rA1oyyLwWfgPXVMm9+lTTAXg9TICcADt/mBrAvCMyPfcTVOEwP2b91BpGrq9ibxoredatTl8OQJAtxbtHZi1zILfKVvgRky2Q41xPNQs+VmtjDtHeEpAxDY1vbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761993612; c=relaxed/simple;
	bh=rMXiFLvpQUT4YjMhrcIXAAgicUEHEVbOsokr63okOGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qT3GcBEGOU7ZA7wiEP4uCqGbRgpx4GRtbBRZI+S5FeoLyo1xfi6qZrjyl3fVyV+TGRMpcOkNtV3s+rdYP62S/cWDvDgjE26u/urup08O261OrkhkwvB+OFNYRHkQl9zJRx5n9TTfC29p2/zY62yl5e8bSFYVIuajaMzufr8jDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTJ3CWKQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso6243547a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761993608; x=1762598408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HSPS4XoS5xGMUr7hcQifmzLnmdxVPw1IDCXF3+FoJP0=;
        b=XTJ3CWKQ7FOaVfOLvcNf/LZzFXiyLajrCQEH/LC10bHQ/RfNFcSlEHaKitZ2ZIbaF8
         FDVJlqQUtZNpd7h78wM/uVoXEcNZgnjhovkeOYAJgt1IMZ765ZcbqWHVmejLqQQkupo3
         6TPOfbhDZcSmQLxSnSBlG7xVSP2Hh5qSIT5P/vTXHopUMQmiDj23rV9RJCIKhtiKiGMq
         SqCzGWJ4rwEOu3wd/WnygPHWENff+vQkpVn6xJLpon9FPG7IJRn4XYSsid/gQ55LZahn
         Ju8JD+OOOdsUH9+rMz6G5Aw6Le6j2W5uH0EbJ3dg19OatL4dQ2IrzWMkY4crmuKqnijp
         gV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761993608; x=1762598408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSPS4XoS5xGMUr7hcQifmzLnmdxVPw1IDCXF3+FoJP0=;
        b=XJfvOiWgn6spAn5JmF16Ycmyp/oP3HPL91nESO91xmZAGoN4eUG4Us7m7L8A1wsKdf
         +jlY9O77VqciSWie2rzMNm4ubOmIxBsykrheWcaPlo1yrlkZ2Vy2g8D4uuVr1AK+24s6
         rvoFMS2d6oamRWu6SROdAy2JQQiRJNI7Zn5DyZtW6PLNxc4fKjLHf+9lrOKABgF6WF/w
         XlksosQ68uM0TfrENFItbO3Gc1pteYlHdq7LYr/JGQsTwQp8+qZewesTt2wbf5cnUsCq
         gZovooL42RojAaEG9JNarrKg14pusCc+lOlnhSrIPiRio2/QwbYKiRTOd+LVrPwj6mdb
         C0Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUxdZsWozePb8gpGPyOUzvKnnrF18RL16FDLnSUguJCmYZ1KYaM2ENynxVCV/d6KNClpt9yKREH9WIsV9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsTWJZFRzHQK8AnsbAZvMkCm8/HC2VvD5K0y9kKHD+lppYYFQ9
	R5o0MmOyIdhsiQ2/2bXjuEJDrnt7m9gBXVZpw5dGEpZ0hVz+jYdWY/3C
X-Gm-Gg: ASbGncvwuT44pVTO+n4ECq/YnX21CfKpOPN6WHhDpUTP4kO763kqk9Qe6UKVloyoEe/
	CmMvgAYIgWToICnwk10V1vIybz2wZKa7y17Q1jr8JxvuPY43EedjACZSQ3ffnZafeanQ1Ry5vnU
	roPUHmmbKLQDy1QMp0/4Hyv3lFmt9IZBiX8beFdGCFRO3NOi9qd/DSWtCAN6Lh2thsILsiwVVV7
	FYq+NWNVFwV/Y2GsfB1/w0OXJTaljkwrVyDLuhLSgdqs5VbgZCsG0Dyr21PQTAJs2Gpd8oXlCBc
	EPSEjEGEY6uFtkJsMF34yWf3yaDYYnyFWWKEz9zvVKK0fDsQAmTanxsdGE3ZyJNsw6+10IQgBHH
	OB19kSI8M5+3rdzIgiEMs2W/0O4hlmv8Qi3gdtGoBt1jfpxWIIYNCexY6UORQ/YzteOalyVKOO+
	ReAE2W7NyrVHFMWoP5cKwc//R6NDSq+g1cYGZrZzFBmdhZ2aPs95UCJ8Zl
X-Google-Smtp-Source: AGHT+IFSQkmcG1L4146AF/e/lAuoEsq/7sNCYg5IR+3oTzTE+KGBv3Cj0TZ6j67yGbbsHvpaOiZ4MQ==
X-Received: by 2002:a05:6402:2350:b0:640:7529:b8c7 with SMTP id 4fb4d7f45d1cf-64076f710cbmr5615546a12.1.1761993607870;
        Sat, 01 Nov 2025 03:40:07 -0700 (PDT)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b438b05sm3751508a12.27.2025.11.01.03.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 03:40:07 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] MAINTAINERS: add brcm tag driver to b53
Date: Sat,  1 Nov 2025 11:39:54 +0100
Message-ID: <20251101103954.29816-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The b53 entry was missing the brcm tag driver, so add it.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20251029181216.3f35f8ba@kernel.org/
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0518f1f4f3b5..92e9cd1a363b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4818,6 +4818,7 @@ F:	drivers/net/dsa/b53/*
 F:	drivers/net/dsa/bcm_sf2*
 F:	include/linux/dsa/brcm.h
 F:	include/linux/platform_data/b53.h
+F:	net/dsa/tag_brcm.c
 
 BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
 M:	Florian Fainelli <florian.fainelli@broadcom.com>

base-commit: d7d2fcf7ae31471b4e08b7e448b8fd0ec2e06a1b
-- 
2.43.0


