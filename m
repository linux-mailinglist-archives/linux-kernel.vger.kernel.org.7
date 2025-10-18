Return-Path: <linux-kernel+bounces-859030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165ACBEC83E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 07:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85EE42713C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56F7261B99;
	Sat, 18 Oct 2025 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="lYwyveBH"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961161F418D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760766300; cv=none; b=XDuqpo8jFN/4DMQ1VIV70kRTZ/CrqZQSyd/ovpTrcohfdRF/kwhJaE2DwUgJS0WrD59Z1UAPoTcVUgLu+rqqHIPrWMNAK+3KVUCS5oNjR9VJ7EhSK1QQI5CSSk0E2siXYnw6TKqYcBgV5zKBFaqLUEg1v+MTlr5SS4ahrVijAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760766300; c=relaxed/simple;
	bh=rVEc3vaup6uNKVaKbccA2Jq5ARaE2EQ/UBrlOhIYgxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GFAof48TjTAEyScuokvLSNKt2drnuV5sB0ojQAfU/EINW4dRJgXuAXvetC8cs3CvQGBUuFlahmY9rr1MvZCK13qkyIOF98zVx10E0eNxjNySQNtZuo7ZDRswajK38+MhmHWSQl5aVgAqBQPQ9OsvnrM7mzrswmmbNM3KpUazS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=lYwyveBH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26d0fbe238bso19788095ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1760766298; x=1761371098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6J7CTQVzJTdpSsBpyYymkd2d5jUSp6/gZICW09ccYI=;
        b=lYwyveBH8sVSwniXfJCTbX7+LhmUx0v7hGeSSSUk2zvSHiPlJkUQj2rcCixyXdx7n6
         Pt/uwnuvyimysi9dCMdRsuneBrf6aJRZ3gOdiAka+t2+voXG+nHcWf/6zbXYOOEaZ/O3
         etJuyrAZwkGbRiFwccXMlHGH95UOWyqR/gjvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760766298; x=1761371098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6J7CTQVzJTdpSsBpyYymkd2d5jUSp6/gZICW09ccYI=;
        b=jH6nXIeyb/ArhaR+VqBphphNdtWvl+a6+Ifc5BSB1LO35cM5wC3uvfXu/gF369xXFg
         SPOGfcdhXxBcWeyJ8ozcztMYbLjWxxAExja4XCEaVqpEN1yodKxCLODJ31grd1XBKhCf
         deZ1uw70b2hqN7rPbWI/cpXERxYUHY+kdyv1E2iAXCL/xiZCzhppgup7rnaoye+v7A5T
         qii88Tl2pL1NGkX/lmaZVCGwxvW6rE6TiTlMjEe/TC2K/I2d1eU8CGm43L+abLtETEsm
         sh/wmkfgTnbAXhOHsTxVcdgvR677TyPvpQdCIInDNOKY71lyUIsEhLn0T2j/Kq4gq/Up
         Qo9w==
X-Forwarded-Encrypted: i=1; AJvYcCXEIjThRllbgWLKXxrPbTrNsx+thNWdHAMJGmQMhyu5cd1WDBPYwZfpk7RuoQLiPUKDjB4f3I+J3nbIf7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMHRff3t9f8rOwhG1uraBQikq3i+WnHXhdqRTtKCVQBREF9uU9
	LHkXyAREKpYVx1cZ4wsbZjnJ0ldq0oAZhUzWHOJZWnU8O73AAdi3WyCW7OStbRf/q0g=
X-Gm-Gg: ASbGncsaULdV7/GDWA3ilzyeClh3jQzunEoeVFADWVapaxOO+3I/FWa/ACP6dqOvIf4
	pUbV3I7kWk8Hz2A89sRmp/foPJ9MUjabZk9Tz5Yt6nregVvO+JHMNX6KbKBPd7MDCRIijmJ0ZRB
	0JTUIT4S2IrJeu19y+bc5CGDti2FEnGqUZfRthmz9lEua2o545fx+W4OA13V3yf8Gs2ZtuZHJud
	BwNvyssFMstGQrtK9JLuN80RfVaIv4UzGBof9EwHc1Lgifel5DgpY1n0FlmKo1gdoxzqgyBr6kk
	1of/8sIvPxZyNwp/38Wv5AlhJNgG5Bb2j/NAK+2o1DKO48rG+VdZpU4niuBLxHPjLg8HftmmJf5
	uSU+cQW21wWqur2MB+70+AeA9k4L9d6PO+SkmLz0yizNKI/LWNIrf53pVoQoYVe/nz3QUBrqlxo
	71Ab9I7AmNJFNinXgEGXYtRMPicmbHDk16DVjRNecfPXiZ6DAD3kg=
X-Google-Smtp-Source: AGHT+IHf1Q2t9Le+gs9UNqzy+mF5hSF6zqhbbRPGceW+0BhDH7PF/VO1zXANTCABMZI3hDYV10XUbQ==
X-Received: by 2002:a17:902:f642:b0:28a:5b8b:1f6b with SMTP id d9443c01a7336-290c9cbbd49mr82013025ad.21.1760766297848;
        Fri, 17 Oct 2025 22:44:57 -0700 (PDT)
Received: from shiro (p1391188-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.222.3.188])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b6a76645c61sm1657222a12.3.2025.10.17.22.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 22:44:57 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	wuhoipok@gmail.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/3] drm/radeon: fix up some badness when probe fails
Date: Sat, 18 Oct 2025 14:44:48 +0900
Message-ID: <20251018054451.259432-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have been trying to get a Radeon 9250 running on an Amiga 4000[0].

On that setup it fails to find the BIOS and the probe fails which is
expected but then a bunch of WARN_ON()s etc are triggered.

I though maybe this is "m68k problems" so I bought an old x86 board and
there if I have a different primary VGA card the BIOS part of the
probe fails in the same way and the same scary messages[1] are showing
up in the console.

It seems like the probe failure path wasn't tested when some previous
cleaning up happened.

I'll fix the issues with not finding the BIOS if the card wasn't
initialised in the normal x86 way later.

0 - https://lore.kernel.org/lkml/20251007092313.755856-1-daniel@thingy.jp/
1 - https://gist.github.com/fifteenhex/b971bd62c49383a0558395c62c05ce3b

Daniel Palmer (3):
  drm/radeon: Clean up pdev->dev instances in probe
  drm/radeon: Do not kfree() devres managed rdev
  drm/radeon: Remove calls to drm_put_dev()

 drivers/gpu/drm/radeon/radeon_drv.c | 34 ++++++++---------------------
 drivers/gpu/drm/radeon/radeon_kms.c |  1 -
 2 files changed, 9 insertions(+), 26 deletions(-)

-- 
2.51.0


