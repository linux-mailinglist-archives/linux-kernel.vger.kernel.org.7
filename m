Return-Path: <linux-kernel+bounces-743809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B8BB10387
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989BA3B51F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204B274B59;
	Thu, 24 Jul 2025 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="TS91u/+W"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFF274B49
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345810; cv=none; b=Zp1Vlxfsnvwzae9Ekwn+Z19ETIt9EYZa9Ir/Et0vDN/Am76xhBAXLT8QYuVmHI140tVcvLwWU6Y7iEICNRWmfFtmEiFDiHHp27eUxwSJ747hOs9q3Y4zcLg9TeMMHsk+/8Qvb/3W9GR7RLoFuQ9B/demJdvidtWUyn9fuSmGens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345810; c=relaxed/simple;
	bh=RhsgSAQGQFtDIfvSyeWQbNoGbCtBEUjX9d2Qx45JhyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cVA3IQY3sq+UEbVnIGiqFRMPT6pioc2Le1fDOD4jy1n9pyFB64uhiBeB7uOBfEx3sEMsNa2Da7cNYGss8hmBdUKZO7PrcQkafSIz+2l/ld2YoSmwzQ9aYSW4oxozbUgjTD4m9SSXcTB5DaFqR0A9MK4ErUYJOlrH+cPMJcu7dsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=TS91u/+W; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23649faf69fso5353975ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753345807; x=1753950607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKf0o1pd46V8fmDIDERJDbcmOFQ8i5tGGSMH4OBumaM=;
        b=TS91u/+WQz0kY9sGJ/uROtWtCz2tVlUyRTsz4Q8n9vu0/b80+yLZF/EN8ekFKk1xIy
         zDwCN5btT/TMGkouqEUVV/0TKomK2hmOXN6kzaoLOj395cEPQD++aeww+5oYwF+u2M5Y
         MPwqzD2QJjCGUEJOuUOm1r8PYJBTlhiwUQ6CwjpnHJ6qRMFUWwT29r9IMZSvxsyfHM/Y
         On/2dgWFVoaeDqSQtbxz0ETh7TcZ1CTjFiUfSCDAUsDWFgLp79eqNg2F2Kj4OwhFxswT
         MJayGKpqr9qxON4fb81DOxftq7dG4QxG+lV5di2KVmsFiR+2TEDLPUW7kgTeerhcVDAi
         XaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345807; x=1753950607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKf0o1pd46V8fmDIDERJDbcmOFQ8i5tGGSMH4OBumaM=;
        b=fSWSRELZTjhH9IrAusA75No3ZkO2QpALyECYVyIu7yJ0uLvm/WBYQ9F/eXr3iG6Zlm
         EuHZuzfB3PDAQxBgK2XGzhyLTraXc8Rf2sMpU1oENpJvejRZv+CwvLlMOcP5at2Z/Kom
         K+LcZkszT0txfds8W5Fl4YiLKmHvR8Cd8IZkfvxbXmxKfJDfO7GDw8HcjW5VWXgDQNoT
         dzns9K/2Bvay+EN2AFIzpOz0rzYkaWoJ+Ojf9S+yabTe66qGOcd1nznutv1P65BTWjP0
         qNp7UaUjS8Y8kOaCMXPh0+GwDi4239etE1PUugBysm9rkj6G161AaNaFbGY/KSQTca+g
         XxLg==
X-Forwarded-Encrypted: i=1; AJvYcCWKrFQuHk+8Izgs1m9dADyMqMVEaX9j0Vd50XbqAcTwVuIgXJQ+R1IwtDrNr9JIAGlHTndaH6vZdvm9qxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOH16yVE1moh8WNvKFb9HCKSCGnD9fIud72TavWza7rrqM9h+/
	ex1MkqDaAJMwhBPB0lpwqBZLpWkhVE9Hi3YkMRi9/JhbV1Ia6TjqyJlqbukzdAbznrk=
X-Gm-Gg: ASbGncuV1hL/9oVyBtDHtlEkLcusonbDSBiEPlggacbPm0Wk2/ZtCqgDIAP0yfUikon
	4s19B7cA/Ap30Qxqi7ToqGql/GZFMVch5c0F4vxUoUN/lj4ll+TTV055/bldAWw5Y+cAxEH48zM
	Cr03kqeFon2Bi1WBs8F6lvVKn1d5+qMbqGp5MxTq+7tVlnVGbZk3I3PuWkMRWBHuvC22DqAWKRM
	MVCiSRrzmZRBbeyIuwV8koHBPzQJlxs90pyZO/xSc1XmKdl6DeMxnFlfTk18NgioIDnH5jHIKnk
	LwxQZIv8U/fuh3UF5rsxNpfst+Sf2G3BqruNBBWFKsDCvZ109CV4UIcElpxRcgUB8ZqCqCI9nPQ
	KRA6KLAs=
X-Google-Smtp-Source: AGHT+IEc7yW4IcBvIpaJfOqUvH/v+MMuyxoDj3ESBPn2WDNOIekRHFtW9rwogcRsweMGOMT9KTHARw==
X-Received: by 2002:a17:903:94b:b0:237:d486:706a with SMTP id d9443c01a7336-23f981e5ec7mr88899825ad.48.1753345807258;
        Thu, 24 Jul 2025 01:30:07 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa490683fsm10037115ad.195.2025.07.24.01.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:30:06 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH 0/3] Optimize wbt and update its comments and doc
Date: Thu, 24 Jul 2025 16:29:58 +0800
Message-Id: <20250724083001.362882-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Some minor optimizations and updates of comments and doc for wbt.

Tang Yizhou (3):
  blk-wbt: Optimize wbt_done() for non-throttled writes
  blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
  blk-wbt: doc: Update the doc of the wbt_lat_usec interface

 Documentation/ABI/stable/sysfs-block | 10 +++++-----
 block/blk-wbt.c                      | 15 ++++++++-------
 2 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.25.1


