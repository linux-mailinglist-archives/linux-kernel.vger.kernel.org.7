Return-Path: <linux-kernel+bounces-889130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 230CFC3CC54
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD6D1889573
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5DB34EF04;
	Thu,  6 Nov 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CpxPn/1f"
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126EC2D8364
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449427; cv=none; b=PcCXGdvInIPe+lygIuL7KwBWE7XcYNCp7j6ep08OD4nlh/FqSj1zYgpN1ZN4F7oEzckWZ4agu0+RwP/1lvDfyVpgGuJ+7nxLg3nEXa3dSxG6yMXVHfnu74mutUSkoPIlTA0MQCigx8ojjZmJnz/A/KW7iG4Jt5PUr4KY6glJ8Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449427; c=relaxed/simple;
	bh=gt/p/EbEc6xZeA53Erqi17gRBSJxHFx+if2j/kTWoMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUu2wS0kl9WTOhn82shsr3nqc2Zg0BZOYu5EPGFptc98okHDbwUAvS98wuE11h9D+FjdjoAHhbAZPniKlzY3V6RfNfpkw9sDBQnRjhKblTjIx3r/B85sKBrFbqYmSdpRw3Oywa1vkNK6LmVAZjkhNWuC2NX8L6T+subaiksTy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CpxPn/1f; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-9484c3e2750so6377139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762449425; x=1763054225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NzzbeNT2m0LtL++SkTSwDyMSMA/3/EjGOUNEaInd5U0=;
        b=CpxPn/1fOyKR1gBFsqD2gw9RG8+4x6EuBLZpKUBOnJ96/oQ2+JO1JgKsaIG5zRQLKP
         yxEfW92LwZEfMu6i227krav1R7FNJGDcPFT5o9z7APUDOOkfq0JXf1oU5HxkPx1hC5cN
         rB1Twr8tdH0XedFXC6jZaXE1idR0yjAKizRkes1ddvOO5NM5ka2T2vK8NCfcSOFyMnF0
         vMc1ibO4hDpjimvsSXIrt9nzuI5KJYDL7C0txuULbCyT8EYRefVPVnELDQXF04LzbbK2
         wV7CWZrsCze9CFHeN99HuRY5JonskQJkDIg0iKm9u618iqi3Rm6qYnG02Dn6ltFVjnbN
         LTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449425; x=1763054225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzzbeNT2m0LtL++SkTSwDyMSMA/3/EjGOUNEaInd5U0=;
        b=pSu/AoVpLkCD+EadZVgd7C6scSHvwQxfjNe9QOQakgfp6AlpXiArVbOoVeFLr38v4j
         JRSLGpRf9Wi+t55DBXFHC7WArZimX5fmFwIfyuTVCnyLd9z9+iJiXQCgkKCro57QWzWf
         C8Y0NR/I6XhX29DTfjtl+5MAHzgUySQyCgutSZ5WUUYyVZr/DlZJTD/IAw2vWZwtCmGV
         1CXfqFjkoQmc0wONbdbzOvf5+y6gV2XW8qCY6m64ZlGfhuptSeAk4BXlGV9WYKJg6Uxr
         XqLf28n1SlKTBpdzogYbbx6eMD/43H/iK1dqwLox+qMXzY/jPozlujHUWi5H4Pde2WPv
         Yq4A==
X-Forwarded-Encrypted: i=1; AJvYcCX6ONLz0ySYgYIJhQCdNeMXwji97O1Oueq3B8rfO09Kv2VJ+KR7fVYGCHTzpEYvXtV7NrGEzJI2j7mFKeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc3G4R67740DjqLmOEVEF2xOA8QaO2t9WNU9SyjMo9h0TC6n4M
	wgzYHLOg9E5nJyB6jpsSAlzjyZskw78PSNxGdsaH9V6rY+UZdfeUxJkr4aU90pQlLDIsALcgPUD
	9yaJoM+0+mKjgJqNy/qokPMtARt0Q3q6HfVgai18FQ1YL/78oJVeS
X-Gm-Gg: ASbGncuqMuGT2B9rUWCHyiJ5y8Ds9ycb6nhVePyGbD6kRtzxXxeAVs6YDKjWFczcups
	N8hPU4gfeZlH+WLp3zAKzM3XGZBbMlR4ha3bvw63bR/Scl2oXDm3VtOHHtPVpaj9iYrhj/0IuFh
	8TeaMI/MRjhNaKS/cO2g5CLpEoWMKeIs7G0XaOc/ZbHRKAGL5L9Xfna09h6zDe+dBkWcAhhQrUX
	CbYAqrloFYiBSX5TTpPQoP8y/bZ44mWVW7BeD6b3qW0d0qSn+IBfHT7PVRZJMW+CDhV4gO7RSbf
	32NybliTOd4qZW/nHjdguaCYrjHTTt2A42Zt2f4bqmaeoLcjN2EMOJ/8GgRvWP54p/rcILBGFO+
	AsNw2smlngtIgYW/e
X-Google-Smtp-Source: AGHT+IEc27rJmKKtZGHZD2OrmvuLl/Cn20PXlrooe8EjSnRJECs5BhOtRCQQ/lkEA3RQJeSPJPMdrCxudQBR
X-Received: by 2002:a05:6e02:218f:b0:433:5c6b:4b86 with SMTP id e9e14a558f8ab-4335f4a07b2mr694235ab.5.1762449424536;
        Thu, 06 Nov 2025 09:17:04 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4334f45665fsm2389275ab.8.2025.11.06.09.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:17:04 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EC689340315;
	Thu,  6 Nov 2025 10:17:03 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E543EE401BC; Thu,  6 Nov 2025 10:17:03 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/2] ublk: simplify user copy
Date: Thu,  6 Nov 2025 10:16:45 -0700
Message-ID: <20251106171647.2590074-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use copy_page_{to,from}_user() and rq_for_each_segment() to simplify the
implementation of ublk_copy_user_pages(). Avoiding the page pinning and
unpinning saves expensive atomic increments and decrements of the page
reference counts. And copying via user virtual addresses avoids needing
to split the copy at user page boundaries. Ming reports a 40% throughput
improvement when issuing I/O to the selftests null ublk server with
zero-copy disabled.

v3:
- Use rq_for_each_segment() to avoid copying multi-page bvecs (Ming)
- Add Reviewed-by from Ming

v2:
- Use rq_for_each_bvec() to further simplify the code (Ming)
- Add performance measurements from Ming

Caleb Sander Mateos (2):
  ublk: use copy_{to,from}_iter() for user copy
  ublk: use rq_for_each_segment() for user copy

 drivers/block/ublk_drv.c | 114 +++++++++------------------------------
 1 file changed, 24 insertions(+), 90 deletions(-)

-- 
2.45.2


