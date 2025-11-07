Return-Path: <linux-kernel+bounces-890334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA65C3FD28
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4663B73E4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFD02D879F;
	Fri,  7 Nov 2025 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcNsv8tr"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6C21CFF6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516416; cv=none; b=d1+vmLR6I2You/g31gXq2tSAX4mCqfB5VdTz365dYLNfw1ZcCLC4c6vNi3mJ01lH0nFYviy2z1tgk/hyemM54yzW3MhDOwjHclY3mpvs3744DJ7AKpv4YFBQXltKywEhPJ0rtgl/L99Qz6xMyKYjywyYeNlbCLdr6/42drsSXPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516416; c=relaxed/simple;
	bh=1uPytD9cNXILOzbFqyP1ntfxFWFE3K2vK34d+qbZFkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqMffSAVeyLp0D5AcahWZnRsSfzZLkWEtqUvl9TGrK8iv2eaqMCfgSbDP/tTmZVkVRkBNG6PP383ssHiemNSLZaBOSeelucEno4S+sKOn1JypUd6caDqL99JfF4NrovABh7iYbtMXoO07xNTPYBj9L17BuoyAvm7XdR5QAaWJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcNsv8tr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso3277585e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762516412; x=1763121212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8r8f1qu/iMBIK0e1tyUt5/U+CjeN6Py2r6FC9iGdjx0=;
        b=gcNsv8trIUJRibDmpOgB9/n7filrQilafkOW859fBiALJ0aQy2ay2WYFDk/kEJ/S5p
         j96Td3VjLBMgEv0RbI7D70GfL4aujklLqxzjmoJMe7Jgp0FL5uAdjhZckZrkG7LKODN6
         04aIL33CWytKHns3b+jWGqVOz+8zHagEX2MLQH77pqMbb17kStbDflbPGuSZfFefM1f7
         K20hoI1ZqTSHa3zN6t9B1GJDqeXNXJ07XCdWu+E7679uyJ/QFG7qw/WA/9WJjsEF9CF4
         l30MuUUbx8dAxj/L+igA6IxDklBzJjDqef+o9uqGCb3r13PrCMuUZsQz6JF/FcYCWcKh
         +VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762516412; x=1763121212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8r8f1qu/iMBIK0e1tyUt5/U+CjeN6Py2r6FC9iGdjx0=;
        b=ohKpv8EimxSgHLuszf396J7UoHl6rtuzEB1x6Vz6kyBaYaCKoRR6TLG4YXzYMp9SyV
         zIcAwviDfTBA4zIQYZ651rrGza17lKshFg57ix+xwPPKEQGrmbAOdEd9jtm8EdNxNc/z
         P/wJrkI3hQIStAv5PFlG0JhdfAX4FsqK5RVSdpNgri6rNK/oXgyKmm0N1vewPHltFSJl
         RSzbJuVBSjlb4pdceRXx9/fbg18vn4Y2ZQUwgQo1MjKlRZHY1niXBDte35TLnt+oHq0a
         4c3E9v/N/1P6wnb9ndAEy14WGRdzgZhFP2bzLomUGHsOxEK0pv0M8K8+wXNUqnCZ+ZP4
         STyg==
X-Forwarded-Encrypted: i=1; AJvYcCVLfC/SCF/Gi8lGiA5LnmX60ZJSLpCRGzKs/IZ8qV0rcpuRHZqPsR5MoQchbDpQXt2rqUWTEFNhYLBfrdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZLd16FcdqaOv8jE9OOOdQwqPdrLNaieSXUeDKKWVwsm/MQuup
	C/cY6cEAUF0McbsUtwKCx3r0L5/4yCkFyzt5+W3MMnpTnlsd/wviUXqO
X-Gm-Gg: ASbGncujeLfa20wVH0VbJuEHrvEMNmSdVCbswqT1oS7U2yNXmoaXTzXyER21vN3CxTU
	yIS8AK44MT/K6u/zZTog2BSdvp714n5PKXP+g913/uTt79kdNQsbUMxH7RocFwekB+qNGiHSvA1
	zaBIwkRODT4wfp0XmvVKvw6ZNkqhQAgXdejlipmDhsaqm1dM9WrvHDpZF7yCliwQu+OWUBi5OY3
	zukaFRnW+4yZ731JLoTg7zpYQnNDu42Sm3JiyT90Dtq2ZbyRMsbbsn37kP3bcgtuK0gD9ooHB2I
	LuhvBz0zNh9fgG2sW40+JUj79AwnCrLEnqqaqrBCYt4jSPkx9ZkppSPxKQfisThEQCQvdVYN9ek
	Vm4fdf7fMcY9QGuAuwltxtNM/1U6S9WWgmu112E3zoevY3o3tkneI4aLejhb68F9yslBc9zrktq
	YTTFC+r2QR61X4ByaT8vlGdlula/hD938b44vDTSV1fTkkEkm/
X-Google-Smtp-Source: AGHT+IFWKADxiyQRK8XMw8urX99fnaTBXKiKvDJ4GU3ZZiNzGs554m++E5HS9HHRIqK6ssi0vxgiwQ==
X-Received: by 2002:a05:600c:1f94:b0:477:632c:5b91 with SMTP id 5b1f17b1804b1-4776bca7bf0mr21320125e9.16.1762516411907;
        Fri, 07 Nov 2025 03:53:31 -0800 (PST)
Received: from cachyos-x8664 (202.red-80-28-106.staticip.rima-tde.net. [80.28.106.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47767749916sm81206805e9.4.2025.11.07.03.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:53:31 -0800 (PST)
From: Marcos Vega <marcosmola2@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcos Vega <marcosmola2@gmail.com>
Subject: [PATCH v3] platform/x86: hp-wmi: Moved Omen MAX 16-ah0xx board name
Date: Fri,  7 Nov 2025 12:48:53 +0100
Message-ID: <20251107114853.80838-1-marcosmola2@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <f89e0a02-91a2-e98c-d06a-6b7060bb2848@linux.intel.com>
References: <f89e0a02-91a2-e98c-d06a-6b7060bb2848@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed placement of board 8D41 so its categorized adequately in victus_s_thermal_profile_boards.
Rebased to review-ilpo-fixes as pointed out by maintainer.

Signed-off-by: Marcos Vega <marcosmola2@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index e10c75d91f24..47989f6a1753 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -96,6 +96,7 @@ static const char * const victus_thermal_profile_boards[] = {
 static const char * const victus_s_thermal_profile_boards[] = {
 	"8BBE", "8BD4", "8BD5",
 	"8C78", "8C99", "8C9C",
+	"8D41"
 };
 
 enum hp_wmi_radio {
-- 
2.51.2

