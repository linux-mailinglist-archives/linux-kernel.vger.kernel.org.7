Return-Path: <linux-kernel+bounces-783759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52224B33209
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEC13BE83E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F0221265;
	Sun, 24 Aug 2025 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fADDy/Ju"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E041DF248
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756059848; cv=none; b=pKIrsIrDffI4GuyhJg445mkhJFWpZyZ1hudKNqL2FJC9pVPwKwQR2fHc+uztbneoYqqXUdqn/5TRgreJsvEW1cffKMq3KOdTnmuPVYkr4FT2ljkhMXC8+pWiCVbBbCVW/kv0ri9hnVWwbMsRcREiHo9gp1m8oTa+yI32e8Fq1aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756059848; c=relaxed/simple;
	bh=YjIPrR366orKDQ+N68H9GcqO5AWSNLsVjpuWk6n1Q7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jjADjwWEmnycH4bX7WU8TObCTZSVuWsICL0HsJEQWIlnyaN0aEZLMOEXTNhBUaEtmJOWyGmz23t34SUsD6SURpiQpokltKgpYuF6AJ2OTPLy/WA/DNix2xeeZPpD6wrZWtPo9sTPiXf18lcNpmMkt2M/42yunzq7xHk/LYgiD10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fADDy/Ju; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2469325d158so5522895ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756059846; x=1756664646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=td123reH3egVHtGN6w8XXKv8wCXzpkQcOkeYMze3oQM=;
        b=fADDy/JuwZt057Cph9KQ8qBvV07dqxL2UoPGrzQ4Qx/HtH74YuMQn21agzgz5/7n8N
         eOV96AIboaFMxVTsRf7AWHpwfBGozpDuItbD0B4lnWB0GnwOx6Trw0KhxCpuCFnsRtBq
         XqSx5k3JMRHCDkIqAyiEKWDw6Yn8ShmAoiXEc4fJjm7gyDvhI1eu3T+WSkrvPNfp9Yl3
         7vhcbndS+TOSIIBAP0i1TNP4e8fMX/y63pJtG2EFOlp3zjrCCYzMTWegy7ElAOkzPBcl
         JtNMvnxprb4wwvEk9jC11HsIOvbd6Vmbj8dcVd3D0zbKw9pGQJIDV5m8Jq/bidZ6CVvW
         2NJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756059846; x=1756664646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=td123reH3egVHtGN6w8XXKv8wCXzpkQcOkeYMze3oQM=;
        b=HS/2Zy6bytluU1AwBjXlZp/z4lNfvRcAKJyHxD4xvZmVFPpjJSwWQTUzJBMwruBTne
         RIK8/O+GUrogpo+LSwbzADw7RS1uT2ROo/6NJePz5m+//1pWqgJCo5mVJWTxhMeMUQOt
         q72XPLd8SnEpAmtx9YYyttHq9nFK2UXHzPqGeMb6Lcml9KRpOKB43lMMUB3gE4clVeHz
         CVSgI2gZ2bkv24Lygx89YzNm0Vhm9/z2xVDRmiSuxyekc9v/UMmQ3+FvXpxaivUw46HE
         GU5BY26nP19HRn+s1khv1I4/4PzJAFoEf8V03juChQHytM/hrZVXV6EGB4nBqFMs2yzz
         RLhg==
X-Forwarded-Encrypted: i=1; AJvYcCXRF7jYpST+5i6bXELQHgvJg1hHxKcPj53Lpi8kIa/aOT+u/muRzEMZO1qkmgMJpt6kiCdxGR/qpTlzzfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sQLj/+QBgiyLs92zemnxRvnms1K4LVyogglKDq3IA4Cc4p+7
	GoiAkKZUXDTFg3FhsIjZxBSTNAUvdBg4xzqV8QiGrRjZaRHcFiKzSWpabEbAqU2F
X-Gm-Gg: ASbGncsZIUYPVrGqyGvBhx+JHisPM0q/X8Ba00InqFqs0y95CiNBaMlTQcaMZBJebKC
	IPGRKc5x+FUQnKxPifysj6X+pLa/e7XiH7h4tkAHBrWLrwMeM2Q8nVS57I8uOk1YzBvZRmZ/8eZ
	9iJp8vrAEbhdvAsIAGy6oV+1XcGyrdvddwgcw77UPTzRjMj41Kzl44ts9W18sA18xulnJ6hcpgA
	KhLYFwA3KdzqdKPiKte3Ba/r5M89ZI804NU5dFk24Xv4B8Q4br2Ta9VaavZmN/s1zIA8FhQG02k
	xNP8Aole7S5qL7C9ZxGxC/NW8gBkmLG4Ln0/vy9fbf3ILCZwieWhu5VnxDAyYbnyntedy2lLxcm
	UyrlIHB/76g1jaYxZWi8tZHuAc0vB39FGXk+gdyvXMO017BqaWk4sRCSiXKDrvlo=
X-Google-Smtp-Source: AGHT+IGT9tBLlZCE78lYvNE3BTz1JDfjZS14F9uHZP0BGeAleCnnJriFbG3R36j7yBUN0dX+0YEYag==
X-Received: by 2002:a17:902:c94c:b0:245:f0d8:6ee2 with SMTP id d9443c01a7336-2462efade2amr123629945ad.52.1756059846481;
        Sun, 24 Aug 2025 11:24:06 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889f11esm47903635ad.150.2025.08.24.11.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 11:24:06 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: austin.zheng@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: zaeem.mohamed@amd.com,
	wenjing.liu@amd.com,
	chiahsuan.chung@amd.com,
	Natanel.Roizenman@amd.com,
	Daniel.Sa@amd.com,
	jserv@ccns.ncku.edu.tw,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/2] drm/amd/display: optimize reserved time candidates handling
Date: Mon, 25 Aug 2025 02:23:57 +0800
Message-Id: <20250824182359.142050-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize the handling of reserved time candidates by replacing the
custom bubble sort with the kernel's standard sort() and rewriting
duplicate removal with a linear-time fast/slow pointer method. The
changes improve sorting from O(N^2) to O(N log N) and duplicate removal
from O(N^2) to O(N), reducing computational overhead and eliminating
hand-rolled implementations, while correctness has been verified with
simple unit tests.

Kuan-Wei Chiu (2):
  drm/amd/display: Optimize reserved time candidates sorting using
    standard sort()
  drm/amd/display: Optimize remove_duplicates() from O(N^2) to O(N)

 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   | 41 ++++++++++---------
 1 file changed, 21 insertions(+), 20 deletions(-)

-- 
2.34.1


