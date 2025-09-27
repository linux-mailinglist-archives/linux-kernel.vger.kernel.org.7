Return-Path: <linux-kernel+bounces-834749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CDBBA5698
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 02:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B395C7A68EF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8287A1DB127;
	Sat, 27 Sep 2025 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4rjcdoe"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2371D5150
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758932369; cv=none; b=kaqsf+Mmdzpd8zA92KBBdCvEDUu6kDRP++Ou1LrS6hcqp97hs9MgI8ChkRTrqE2WLIPpFteZNOwz56AUH02NXrQ6wFmD78R8Rs18I1vBu1REcCmNdIv8F6eYKIHFVV994XiAW8aTTbu7IwL8oSbhiDbNWVGKcIDn008/F7uBjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758932369; c=relaxed/simple;
	bh=OCMM1i+marxjh6pUkwTDhMRBuqlU+02sLHnJrahSSHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQxsuVOvV94VS0MYy3OL9HQe//fkRHGICIAoSEaIMjSAS7gbbVqeiHiJ6lets4fRwzrAK5GttejUpIQSAJXpJF5TzHLswyh7AONP23I822uSvfNYHzlLzl44XkwrgjkA4nEP29QZcRCuimYijwN/cVREb/7InkBdNPHxot8MCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4rjcdoe; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7811fa91774so826377b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758932367; x=1759537167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xoCdX6M4UpRUuPuNk8r9g0MkweOF1WQ1ahjsQ+1be2I=;
        b=S4rjcdoeIs9jU0BTqiLrlyb6a/8aqICebB31RSHLaiZRy03SFga1DOK5U/bMvY6U+G
         VLwVFGDTM43+zcEV3sczCU31T3QEAg6fjwU0PbkNWMi7utPrfZGV6RX7g1CM/F08C3PY
         QP4Gf5j0K/EJmJppZuYcUgUiB3KBmtC6wo1bD+4e7tvXNpx16kovq9/Mk0YKmsjjilTG
         m2BUmmySeUd1d3mMhQddIMJnDYt8DPyEcbsL3zNOA+rBBlLcya/r1stbTtdE2AYQtQCq
         2Wa68STwkT2auO/NFIPq5XXAT53WWXM4x2O2Pl9/WGhSZd0ohgYd0+rqkEQLSLwdkM2y
         Z/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758932367; x=1759537167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoCdX6M4UpRUuPuNk8r9g0MkweOF1WQ1ahjsQ+1be2I=;
        b=B8k2KuFAFZdxbQy9GhLqvzEEQk3t288utuJkF4kNgRa6dYg+4dLazbAbk0CGuArWa9
         aEQIoN83WunUNTRSI0yigbto2vERNNjqzx9pe65verIQkVbOiYFXgYMrSfUTBuwpNdbB
         X+PymdlTN6vF6+0sa9OiKM0OkbcFatKGUVXZbxJddUGWsxwcrqwrJkI4LkxO0acQ/ix4
         6vW9dMZUIbQ7fjtWEgrhKnGa3ns+lklZBvqxeOWtpu7Y16LQTPqG3UTq8Tz//6+TLyTP
         ClWuMWQQWi0wuJIEgOs97ePxTOcNZTZa5XlmYAv4k2Vnh83J3UwpjB1h+x1lQmUz7Mkp
         dVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnFr8TAwIyQRHot5qRnKnktbDB8C50EOr1HUqRRb7ZyrKPwAKpJ0GP24qrU5nA2371uANnWDxUihoo5ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQbEEwADEFpFCbNRH/8/R8hcmnUfwoLumJGZHix9NEfk/O8xRa
	afVtN628JgduXxdrbAnotRXeBX+J34YowDNpIcOVVaMNC2H7IGc0XbRg
X-Gm-Gg: ASbGncu+ngTT8yw5jRtJFa5vaEox+S4P7CB8GkgVRefmkHd4CPX2qCZ5kY2Ocajt1Rs
	0zTe/pBKvYOe0HjJ8uE0yo+VYTyyrbJB2t5V7mm4vHiNMhFrSB6L1WFkv89KlYJdNli8G3yMR4t
	8Ev266/2sAxvLLOaG3gHVfrRbqkFeXj+gCmokPfXTaxlOoB3zXb+vZuvjw0Zm4cWc+E9s4N1VB7
	vM3yW1KUOE/knKFPJjafJR28rZhdHEf4j87lyApwd07zfxd6xRNO2FTxOj77TC2ug1/+7MUQDXX
	hlSRLyQfb+PEIbAOUpi9tCyNsCM1QzHQamm/EtUGB8AkKgKMtEhA47k6hQH57i65/cHdeoB2vRg
	A7ImwpwM3bxT+ojjHSEInu4ndtRuZpJR79DLjctJhWaiSO0GesLtQtZQ6MDVJFPMoDOBK1R/huV
	5FPakoP8bLiZrF
X-Google-Smtp-Source: AGHT+IEGXz9nq0dyTCKbVTjjCxNnClX5GvwmdbGRHAf5pY+Z3ZHeyoRmROyP6uUGmVc5qJYOutyh/g==
X-Received: by 2002:a05:6a20:3d85:b0:2b6:3182:be22 with SMTP id adf61e73a8af0-2e7cf2bee47mr12013101637.31.1758932366792;
        Fri, 26 Sep 2025 17:19:26 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:9584:386:9d60:7b43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c26d4sm5454319b3a.37.2025.09.26.17.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 17:19:26 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: adilger.kernel@dilger.ca,
	tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Date: Sat, 27 Sep 2025 05:49:21 +0530
Message-ID: <20250927001921.16747-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andreas,

Thank you for the detailed analysis of the tradeoffs.

Looking at the syzbot report (https://syzkaller.appspot.com/bug?extid=fd3f70a4509fca8c265d), 
this WARNING appears 4 times, so while not frequent, it's a real issue that occurs 
under memory pressure conditions.

Your -EAGAIN suggestion makes sense. The approach would be:
1. During memory reclaim, use GFP_NOFS without __GFP_NOFAIL
2. If allocation fails, return -EAGAIN to let reclaim skip this inode
3. Preallocation cleanup happens later when memory is available

I understand this requires modifying the function signature and updating all call 
sites. I'm willing to do this work and properly test each caller's error handling. 

Questions on implementation:
- Should callers like ext4_clear_inode() ignore -EAGAIN (leave cleanup for later)?
- Should callers like ext4_truncate() retry or also defer?
- For the unused "int needed" parameter you mentioned - should I remove it in the 
  same patch or separately?

I'd like to implement this fix properly rather than leaving the WARNING unaddressed. 
Could you provide guidance on the preferred error handling for the different caller 
contexts?

Best regards,
Deepanshu

