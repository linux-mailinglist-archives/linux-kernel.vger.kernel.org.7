Return-Path: <linux-kernel+bounces-867966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44366C04065
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1288D1A67F82
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710B19882B;
	Fri, 24 Oct 2025 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEweK6Qz"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377FB12D1F1
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761269743; cv=none; b=UDrb25FOqGOeT2JSWqhEi3YPpRUHpOwuAZcr3BYMyPi2Ee/KeSI4wfKJrwWGISNX1/35wWbjgtJxLDa3ING8HuPmbqxb36PfMi4tX7cNCub1C6LfhJH+lqNC09KlFaV4obDlvkprEmuo5cAYKHx3VYbwlOiA5flioj7S8sG2+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761269743; c=relaxed/simple;
	bh=OzHfrAInRSZ0eiTjgnP0ORLw+XKP0Fa49X/R0UcrD+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QWv5IR/D6cgLVu2qzXb9XXPUjttNm5oSmxcvuaPLaMySmktCaVMHcR1JjXZ9xSVdv8Sg55eNlM/Ec7YjZ/8spHm0Z8YxObz805JnheMDcpLoAa9UejKFZpC9j4/DFrCB/9yTmPihBxpLbZKI0ChvJ7OsEj0diMzernWOkw+cpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEweK6Qz; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33bbeec2ed7so1432052a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761269741; x=1761874541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EpEV8JmfPBi+9bjulCXf6+3xKX9GZ5AzBtR1kYyEQ9Y=;
        b=SEweK6QzHWqrOkV7DBTtCHKeYhpdFqRtFDPlQCBqr9FAXFp5BlPea0n0XVtWha+sqZ
         Qr/HvnOax2QuitL3qbcmVz01NFUfXf0C8phEOGPLCMKsJ8UJb1Lyc/YIjgzMuILsAI2f
         qsnufjKGPaCxF1JowKFxaK7tQed8UM5Z716+kCZNcPu0W7vhWXfsx4r75p46WozZitSK
         jM/umY/jmuLWk83SPWMl74LwQp0JHP+Vm8NDZxuoZP+aYo09UdtnbjdeR2JcIEDAP203
         6/yF9A9xAS8kd3IqvwfB0u7z40WR35KpFWSFkT6+zWiPdQjYZM8iVnAoo81zgvPay4pF
         2XQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761269741; x=1761874541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpEV8JmfPBi+9bjulCXf6+3xKX9GZ5AzBtR1kYyEQ9Y=;
        b=vFpSF/5F2TUmstb2+XyZkGwrAdZjzQjaC7siaoEjSn4gGAKW1kybHU7lLF6KtwVVje
         N7vXaIO57RF6/uKmGhCUFNePyp78SJxv+dL0exgnTWxTTZXDc0K2OeuOxBT3k+ILbkgC
         /PDro84YoZlSEmWDtXhMCs4rN+iANHL2mHJvYLHMBXcik1WPMwrFWb2GQn+LSK8G7ONA
         YnE7JjCrHpvxev82NyitE9/4o0hHRlC80KkThgxJufoQUTpj3cKMqqOG41y9Zju+D9pN
         i7W+dPajJdxoavmwfRwlM0oO7z3Git4Fa0EeZnaS4xTQ/D5bra7Ql7jUKen5/OvZ0ihx
         Dvrg==
X-Forwarded-Encrypted: i=1; AJvYcCW+aE+rAPnlkBqHWEkF56Lqt0Fck5tZigyRFvs+toIzLBWJAg1SVf019AuzITesH5MgekciHMk8npfH4cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKEjQ73ixJdi8tzs8BZj6fqt/bysaG9ZaWJCQFFsHc9Vw0UJiN
	0eerrtSk/K4sNi4HnMPp4VJDP+nyOb24ydE1sNRIX3TVfArHvluXfAPF
X-Gm-Gg: ASbGnctqoJwu9zK5cFiePddqe466fI9wF/2bShWo3qHi4Nayzq8N/lhoXSCuYt8Tsaz
	QFHnUS7PV883xRms+2zunL2W2++WtOXI0XvEED/w0H4eLGNEQnY9GVkoSlgEAsVsTQYy1cTsGOE
	lo13Bip9CKFd0jSPYxMFRCcD9O8n1HYOME8HWzqIvm6ssvfhb9yfTIpMknCd3lQT/gGw5yB7nlO
	rTpldxyG0mDwLBIr+PxzgvoS61YPR0KL1jF/yOpHOYD5HN2jbt+o5wJdGYy/YIAwu9+AqYBWGhY
	1DQLpnqFF0YJdHtUnRgSYRwAq5PxBINHJZXO/U7w/PG8gEBlbMqPx9jgOxB9IsUXPHsZE5CE1W/
	VHqWrhh4iNYeVmF/vFebJdJdUrFSUyTCJBN/X4MLs3dVn/BS/mRfVH/CDe7jBn4hAnAxn8LULFt
	bXCRC5TIBabfR2vKfl
X-Google-Smtp-Source: AGHT+IEUI+U7zUQV2UwzLZwu9TlJemEe0RPKx1uez2BTNfquWqRpSOjvCC8tYXJP0daruNmjhYuAZg==
X-Received: by 2002:a17:90b:164a:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-33fafbaabb4mr5709115a91.9.1761269741348;
        Thu, 23 Oct 2025 18:35:41 -0700 (PDT)
Received: from hilb.. ([170.254.111.1])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fb016f865sm3850014a91.11.2025.10.23.18.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 18:35:40 -0700 (PDT)
From: =?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>
To: 
Cc: =?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] soc/tegra: Resolve a spelling error in the tegra194-cbb.c
Date: Fri, 24 Oct 2025 01:35:14 +0000
Message-ID: <20251024013528.1542-1-brunofrancadevsec@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a typo spotted during code reading.

Signed-off-by: Bruno Sobreira França <brunofrancadevsec@gmail.com>
---
Changes in v3:
  - Improve commit message
Changes in v2:
  - Really fix the spelling error
---
 drivers/soc/tegra/cbb/tegra194-cbb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/cbb/tegra194-cbb.c b/drivers/soc/tegra/cbb/tegra194-cbb.c
index 846b17ffc2f9..e1deda188fdb 100644
--- a/drivers/soc/tegra/cbb/tegra194-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra194-cbb.c
@@ -1836,7 +1836,7 @@ print_errlog1_2(struct seq_file *file, struct tegra194_cbb *cbb,
 }
 
 /*
- * Print transcation type, error code and description from ErrLog0 for all
+ * Print transaction type, error code and description from ErrLog0 for all
  * errors. For NOC slave errors, all relevant error info is printed using
  * ErrLog0 only. But additional information is printed for errors from
  * APB slaves because for them:
-- 
2.43.0


