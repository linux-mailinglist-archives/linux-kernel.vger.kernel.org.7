Return-Path: <linux-kernel+bounces-772301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8ABB29104
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 02:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B961B206A8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 00:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E8B78F20;
	Sun, 17 Aug 2025 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="A/+ENWGZ"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903513FEE
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755390666; cv=none; b=L2NKIhoIc7RCnEToG4NZ3c+90R1FEBh9flcWsjnfhUL2ujFSiU5QYABJh04+JdJ2Jh0MPfk/5lrKXT0ZHSkMdnfT+K89a4TT/s5ttWVk/IfB9O+DyyVCS8qtD4cjQW9zpnuDIOt/LwwTX/h8vEiKEZOfy6aHzOBQBB52gvsPCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755390666; c=relaxed/simple;
	bh=x5kKEdqAtqNqNebOaHqfVFdxNqQXrM4MCJceyaZ88dE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xq4yST3toKxaw2N1YOAzgzf3W7dMeBRvl2mSCwCY1ahHOjLarGx4u03k+3pm0B5lvDcafDV5+KNOsxS0QfmEE3vHPl2ZJUhmRIPiYUzTW5HCZAOBzoHBhHa9MuHStkYmVItX8KNFJOfpdRxRjNCcDVKrS3Zss/LWaqvwi+xnBG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=A/+ENWGZ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e870689dedso209293685a.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 17:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755390661; x=1755995461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jcl7rsZFszSewcnT88rggLmO7NWAsdqT18aHbHiVN6c=;
        b=A/+ENWGZurkND4Ms4qh7kHQbTAKPZ4HEBQq6sPC+DwBVY6CDJzORXyiMpiyjLcVtyU
         Wc21fKLElbgo//OlIsICg/J819S4cHtRcLCdDXpG7KU5I7EjphFDxdm3IWK9PFFxnggS
         zsFV2epWKA5Pc1Na3PPq9OF8ZL9zOAtjJH1m5uIWnHV/1C4VOsqvYxSlpu2i5BN2WXYR
         9Hfnaq4epyvsnEtg0/XkpOJwwCTGYctoeFA5an79IhkA/jEy/C/fiZ6euwqFzbLLVl+U
         /k8dD8/L4Rgb4CymoPt0sP6A4clqMtJ3+Sk2GvuMV1FYm/o5MizTNjIf7SoTFgj+rOrK
         dCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755390661; x=1755995461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jcl7rsZFszSewcnT88rggLmO7NWAsdqT18aHbHiVN6c=;
        b=kxPDvZadI2P3XBc5AWviiVKGkf3E1q8Srs/qU91E+0pvqo379aD0NWDl2VMV37WxqV
         /IfpRWNlbve51wiTuvZDJRmeCZ/IcyzpoEQCjInunB5c0rvs+AWdC9x8theEMEfv9VtD
         pVLMt4ueL9xescxa33KtPBUNYrJsXhGpV3O6Cf3MqGLjE52ykqtX5TBobwvzPvVHb8/E
         geJNVrGESenpopJDceM77aQp9EF7vRNRWvnZngLop+/MzXqWbvepDwWN42uHeEE8Iw6p
         Eh0pVeDnzAdYK7QbaEuiR322/ubqW504yBULits42XlBr7DH0K8kLF3ZsDJiaHAJsiBd
         AErA==
X-Forwarded-Encrypted: i=1; AJvYcCWjwxp/ZibwMrb5ce22ln2YrHoNTIrt11LxGQIO+fUkYa4TEvELkfDJ/0lvfxKONn2QxAGm9mMvg3qFASg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxettWNPM9syk/ljzeTKnD8arLmSyB4VCn3cOAUJdXQxI53dTgG
	f8VCMBoXS59aWq8wbns6fT6dSFR08DPDsI50Kfj/a86tgMmBMOMidzoy3Y6PRV8yR7E=
X-Gm-Gg: ASbGncslAJrBCWe+SIu7ckTrV3ceJHMEviPuEVDGQ0s5Aa8HwMqRRwoXpjCeSX9yd3E
	GqaAB8tGWDD0ck22BQmLydJtqmYS5AMMseHq04pBvGwE+Kzeg1Mkb0eGLIzvzUhzn1+uM32THy7
	G09IqrenyROsDaq37KM7XueIjTIk6jBkmBsfAdkIS5SW6vmrNx77IKfAmP5c/KFL2NPMhqyyDNi
	RawwRNTgdZTlYhZs+tc4O98uEKprSoUeyNXnAor78OTF9Nbb22/KbAxfY0d9LccxTrUniTzNHTZ
	7mkkRmcGT1wSRxU4X9PjvEogqUjjrztQAtRj4nEiNI7xgjeeOcNpEnUncFR7Sfvh2+I3c8BDxbo
	sgxo+w9jcAMENq0y94SFu768o7VjjH0BgF85UpEfmA+ASZuql
X-Google-Smtp-Source: AGHT+IEEAXUblqUo1pTCJqPCUcZNM3yyVVRue/pei3fvPjMKqyyO3FGgVdLsySEbi7BC0g+mx86jqA==
X-Received: by 2002:a05:620a:4515:b0:7e8:3fed:a09a with SMTP id af79cd13be357-7e87df4b3a2mr835441485a.9.1755390661307;
        Sat, 16 Aug 2025 17:31:01 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c42e5sm342402885a.65.2025.08.16.17.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 17:31:00 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v2 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Sat, 16 Aug 2025 20:30:45 -0400
Message-Id: <20250817003046.313497-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading / writing to the exfat volume label from the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.

Implemented in similar ways to other fs drivers, namely btrfs and ext4,
where the ioctls are performed on file inodes.

v2:
Fix endianness conversion as reported by kernel test robot
v1:
Link: https://lore.kernel.org/all/20250815171056.103751-1-ethan.ferguson@zetier.com/

Ethan Ferguson (1):
  exfat: Add support for FS_IOC_{GET,SET}FSLABEL
  exfat: Fix endian conversion

 fs/exfat/exfat_fs.h  |  2 +
 fs/exfat/exfat_raw.h |  6 +++
 fs/exfat/file.c      | 56 +++++++++++++++++++++++++
 fs/exfat/super.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)

-- 
2.50.1


