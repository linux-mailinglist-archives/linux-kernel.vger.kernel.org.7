Return-Path: <linux-kernel+bounces-889271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 195BAC3D202
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26AC61892FF0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEDE34F481;
	Thu,  6 Nov 2025 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzz5XuWL"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498224468C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455598; cv=none; b=ovPjhdWEXO8GE+dPPyWxV2PN3/4PtANKvbLSL8Gwn0kIqtystm/lcfoHG2V+nQxULnzDryuSsSMHIAy/DFIhx24AGXkgtuVAw/L7jnugA0pRMkQ33fz6SB279gQHTcbb49QvDsdtMr0fr3qO97FJGI2KudP+KGQYmQdWExqMu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455598; c=relaxed/simple;
	bh=Qs4c0IHdK7+7fNnVbHGQSNhi6VNHQB3GEJ9toAaE/nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOU/zEONr7M/GcUSa9H150j/ffPP0H8hI3wGKg5HyriSfTqE4/HDxWkL/1tyGtPZlMt6ODgE/RK0LnYNHDi4cTEktZsmL36+gAQujRWKpi8TBnRFzlZ5cuvuRRKFDdUPN4V+al5jNDgU2yfvbSVoL7ixhiZpA+yWLbU8+dJLN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yzz5XuWL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso979263a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762455596; x=1763060396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+laK8JPFZtn61TIS/0OUyeq5YLMySrw9tZvjURq/X4=;
        b=Yzz5XuWL88S+cfVpsh1zbsd0pIYhw8VpkSiZYKGKB12+HkPAYeU7mdz0cSPOtgLq1T
         zD2/5YK6oVEQs0SlSS9PmcmvGgHEZUyc/czSO/ZW9n8B7yT8D1vAmZecKI04f6ZWKmjQ
         AAn79ngD/sbMli47uba8IgMoKsgSqhVs21gDNRSL26uc+Ipb+OP06OSvBEl5vAMSMcef
         A5BOc3/+8ZhBk/kSDyCvRIGlSi/ll1c5J2OXmUwNa5YwOM4eVRE5wNGWrueMBXApkxfd
         gbiuNpaB1aJHU8OQuiJ+Ed6fiKRgGyt8I2XlST6QvL8lnjiPExbk/BDFfQ6OfpHkiYvS
         0DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762455596; x=1763060396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+laK8JPFZtn61TIS/0OUyeq5YLMySrw9tZvjURq/X4=;
        b=isGwP3GLPrtmwZp1kwAj6K5/G6IoBQhQUEzngUoMrropwCNqUcC6Q3D2uK6fVoKmZ+
         GNdx/3SBJrwcBBsGnzYig0wwAcq7M0CHUpoQ98nEvX2lfe/jVI2G5HAT7jNgaPjzMdIL
         fAUThFEu8OdFSxrm2DKfTod0D/OpzDTkcs/o2XgERgfLsVPKvKH16i5rJlLaUQF4L+mc
         rV8hJV5FMWvMscBOUtEtlyNrnoZ7jRKtJemTdm39vxBCka0sn3ys1ZAjLADtQa/0joGV
         OyC6y/SORlag/vrZHys4JUVXzvpava/9R3a05lqt8JgaxQ6dIGBDunqSB5vOTgARvy1G
         w+mA==
X-Forwarded-Encrypted: i=1; AJvYcCWHo6Ak7X69RLSTnSL+RsCoLpg+V7Z+0gOa4T9XCZ/kPEBBR8ZhXftOHMoqdTjd2rccrz53vzxLwg/Psgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxx2f6viVB37GX+EcHl3ugDmzJLV9THZTTxIihWRMrfUXur6dh
	dE8ccw1BXbqMIzx0W2Tml17u+tmmCaVJD0lfPatbsdKNpOsW5VvSWtXc
X-Gm-Gg: ASbGncvXPupNgxE7CjgvXEMPWznd+Kxh4iGL3BG+vfwcE4jaF5eaWsnPapfbDQIkiCj
	AHoXhPLpvf844U5/ZAImiyCjZ3YEN8bPUUr92QUytFtcljAFOPAPzofJH9zHg221aVJtdH6iHlF
	1N7SseTP8Ck2oIxF8Qn7cMhpcu1BssJgAZTl9AVwSHBRp/n7z9g+/s06Ee0JJA7S1L1YxL/TLMX
	9nTFEDyK8v/zUa2OWIBb24cCK5zzNGyLoxCZtrsIf/rWGlHZJpmqTJfHkRRhvRS1qYNOtM/G+OS
	xfzZYK791Y6f2A4MrHfG8ZG97sAb7TQZTjhrBAEy8B8nUPOsDiu4aSrQ/xADiiOol+UBMSBVIfO
	lJDQinM8OCguu42DXpqQffP9CPLWsR3avOqylR/32j3FAn1SWf0NcHTGmoA==
X-Google-Smtp-Source: AGHT+IHA7g1UwRV+KPwcTwM5NuDpzrq5b4/opgo8G8g11xTavCb0XSmSeOczIqUjxewxtaGpQOXhSA==
X-Received: by 2002:a17:903:234d:b0:295:2276:6704 with SMTP id d9443c01a7336-297c047bd88mr5747925ad.51.1762455595980;
        Thu, 06 Nov 2025 10:59:55 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c92cddsm36647815ad.83.2025.11.06.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:59:55 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] fpga: stratix10-soc: fix compilation + COMPILE_TEST
Date: Thu,  6 Nov 2025 10:59:36 -0800
Message-ID: <20251106185938.6419-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing header and add COMPILE_TEST to prevent future build
failures.

Rosen Penev (2):
  fpga: stratix10-soc: add missing header
  fpga: stratix10-soc: add COMPILE_TEST support

 drivers/fpga/Kconfig         | 2 +-
 drivers/fpga/stratix10-soc.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--
2.51.2


