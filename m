Return-Path: <linux-kernel+bounces-848745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD464BCE7BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF8319A7D51
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E934A30215B;
	Fri, 10 Oct 2025 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2Yd2yj5"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36DA26B77D
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760127768; cv=none; b=r+6rZRSROt28Y6P4n63KhmiEzrt6g7uT9ilmtSFHQKTCcY5U/WrhNfAxzpgwHra2JKg7m+kvarqS+cHmMQBtgb6OA0WVRKZM1fCY4KiBmfYy8RWe2/mJsmPz3RJzcVSdnpZt0oYSvSYbgZqiT2QPDuTg2wnF+qJuh8cwNIBBLMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760127768; c=relaxed/simple;
	bh=69dlhuqjfYccfLsFOtQihdblncrUKfMyb3+GJQuyxPQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jvrvcj7v/wSL5p6Ofsq8eiYeWkjdlWYUfQBdV6y5JeDuM6inj7hHLMRgO6isSBt6g2ZKQwDROajlWTAST/ci5UVMnwSSKLLcT2eAjOYN0NTSQi/lAChWjnPCewpW9DXTCXSmQ5eTEp9jMP/VbnVEmGaptyVDP6TtAqu27vV4XWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2Yd2yj5; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7970e8d1cfeso34101006d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760127766; x=1760732566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kOlXU3CUoKeK/3MB4H/Hutp9m6wXAv/MJRLCHZaC5v4=;
        b=X2Yd2yj5XX0u86e8UXSvHgjGn6XMr0bfXVP8NR+hU6rmTJU3SIEhB5nLjp7B+6erMH
         4EFsIDNyeTvVsdL5iLKTWaWnbyLz4fNYGO72UEI2MKxxUw2YNo5/HLVIX5GcG9evyLmM
         iuBP0Yq5bmhQSWF8z6F+rizEANrbL0JbKthgSGdfHqjmf+r1b2S3k5EvKCaxmcMbB5Sl
         JRqZQFiYw+PeD5pNLL+ErojxZGPKwrRu9e0hOt6+w4yAVwMlzldCTZmIrBC9z+UImut+
         Rh+Hu4sQjinXVNjrSDTNgPQD77x1l3kF4bPb7AIVlU/H0BwV4VNbtky5cq9fT0xa1Qvt
         je0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760127766; x=1760732566;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOlXU3CUoKeK/3MB4H/Hutp9m6wXAv/MJRLCHZaC5v4=;
        b=S82Rj+3lOo5EikppvmFMzNS+PdQdIoBf3PRe7kMWaqrrzcn+1u6wDrUiVwZUWbuSyH
         scV/7gS2mHy8xHOVczJqhKZbRVXl0U9JcCmt2Grq/HiNTOugm9OiNSj8Yxx0CcWtFtAs
         hu160SABCvhremCm6Nfxuh9HCXA2Tq++DATot+bdcNbJ2bgq5PaW8mtVRWfn76ujJqx1
         gRfCZQmruRL3o5nIKNDB8wowmrnsz2bvn8RKHcnDHuO93t5kIpi7U2wxUqF76VE793Y6
         EMxJ4eqw0WIBVrqNF5BnxL98QXc53Ev4NEpSj8/q3nGSnaNKhwfCnrG8nmgFZII+29h9
         cYjw==
X-Forwarded-Encrypted: i=1; AJvYcCWsT39LDUuxc0aqV1iDAvlgfaLyD4hA+kktqbDZD2+q+CX3a78Es6ttPGxLbZh8WsMiZVF23piubkQ8QH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHBofIcKwDMF6FI85TQAvrv2TzVH6GDL0VZaBNbQ4FZRpxf2Nr
	J7VFS46bQCI8VnCMhPRQpawCw4Ab18igX2eIuB4KRAUz1BRCGikHtBk/Lj5vVjeenu4GxozGC07
	J8YnVPQB7OzlIf32Y3IS4Qknn8PyTtIE=
X-Gm-Gg: ASbGncu/pQkktGlzZPVI7IEne6rhRR+je7c6yVtdRENH6398RL0u3UnmrdPgs9m45IX
	7utfFaPIa44x1SoNfGeBQ7e2jb+zsyVXn6XV1lUK0SBhrUzeshxmLApQwJgX9o2M7jZFKbVZpI5
	WY170ny/0Pp6NW1Po+ZHx3UYMFm44qnSkyUDJPK9ZAZEeLAmqT+th4wNMaWB7dsrpj1QYXtRoXC
	JuFDKyunUZdF1JHEcDHMhXzEwvAMHH0Ks0liKa4yehJyg==
X-Google-Smtp-Source: AGHT+IFRBVsqFinOd4zTYiRWveXS359GwGwHzVPRkzgxnHxzaIBwEyLo8p0XGX9557suH3OnFdez/xvaECXYxImIuAE=
X-Received: by 2002:a05:6214:27e9:b0:803:3b8e:e9a5 with SMTP id
 6a1803df08f44-87b2efc2c78mr178005776d6.36.1760127765447; Fri, 10 Oct 2025
 13:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 11 Oct 2025 06:22:34 +1000
X-Gm-Features: AS18NWAVMCkrlDV90Tmk-ZHzHs4WJK4jFJRa3qb-mFFk11CtCG6cKQIhbqS-TcI
Message-ID: <CAPM=9tx8Hiozxaf+0WkOH3GrXKhCr_ccqVtd1v7WkP_V9DmeJQ@mail.gmail.com>
Subject: [git pull] drm fixes for 6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Some fixes leftover from our fixes branch, just nouveau and vmwgfx.

Thanks,
Dave.

drm-fixes-2025-10-11:
drm fixes for 6.18-rc1

nouveau:
- Return errno code from TTM move helper

vmwgfx:
- Fix null-ptr access in cursor code
- Fix UAF in validation
- Use correct iterator in validation
The following changes since commit e5f0a698b34ed76002dc5cff3804a61c80233a7a:

  Linux 6.17 (2025-09-28 14:39:22 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-10-11

for you to fetch changes up to 5ca5f00a167cdd28bcfeeae6ddd370b13ac00a2a:

  Merge tag 'drm-misc-fixes-2025-10-09' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2025-10-11 06:17:13 +1000)

----------------------------------------------------------------
drm fixes for 6.18-rc1

nouveau:
- Return errno code from TTM move helper

vmwgfx:
- Fix null-ptr access in cursor code
- Fix UAF in validation
- Use correct iterator in validation

----------------------------------------------------------------
Dave Airlie (1):
      Merge tag 'drm-misc-fixes-2025-10-09' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Ian Forbes (2):
      drm/vmwgfx: Fix Use-after-free in validation
      drm/vmwgfx: Fix copy-paste typo in validation

Shuhao Fu (1):
      drm/nouveau: fix bad ret code in nouveau_bo_move_prep

Zack Rusin (1):
      drm/vmwgfx: Fix a null-ptr access in the cursor snooper

 drivers/gpu/drm/nouveau/nouveau_bo.c       |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c    | 17 ++++++++++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c |  6 ++++--
 3 files changed, 17 insertions(+), 8 deletions(-)

