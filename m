Return-Path: <linux-kernel+bounces-834385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6164BBA4972
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FCD3B2C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06443248F4E;
	Fri, 26 Sep 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbrtBm1b"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE52472B6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903499; cv=none; b=m8vqGcKzD5T483XylYv2yTrsxKr5eG7PDUkcTnWuU1kf52IRE7z5jj+ITYL2nhbIyiJ4/k9RQBt1SSk1lL4rOVWs+FAkA/VB8IIIwGTWZMs11NYGb+eXQaQQ0dphDdSwOq09AZtkwCZrirU7YuOe+WBV13AnPL5DLvF1bAYYTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903499; c=relaxed/simple;
	bh=S1GTduvaoLk6gEzu62VYZTVkf6MEF6lfNFpCGY60rSk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VLnnunENqokiZC15vpeJpXVoW3Qx9VaY4AGPgXzj0xUYJCfRESyzZYOsVPLvjL6mdwaqTWi4GTsm/nApbEkiw4DwWEqvqcpKxePIwNRp8Hs5ZyXwB2tPAZ/k0pI0KfOdyI34eH37LowWWvzf44PUpIrNkUhqnjyt1fh/vDRbZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbrtBm1b; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-71b9d805f2fso19075876d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758903496; x=1759508296; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7lEG3WGSz305Arms624ajjoShLogPxrkuH6t9XOTDc4=;
        b=QbrtBm1brKS+9OArHU+Wsh8VepzcFtQ/ilwrkVUP60dljLgbTFFRT5RRKFoknWMong
         TczeHXdXoiXoleoBemC4hIyjQENSxEPxeR2+BVu6P9MY0Vh7NXg6Ef3mCCPQ3DGfHHaK
         Clens2WdBHkuOXWdit6YySbUPbQ2oMAnBHpk83Xh6rjyKf+8ZJpJW0NFrfcf/sL0gCtQ
         nKv4XCAmjRA4LS0aEyHSj4cty1txOFJuRHBVzb//cfKzT8heX/y769yLE29am5kCccpv
         501SoN9+I9nZpbh9jLbG5EfkajR62pNXUIxsctjcdM4ecM2RWdy/Qbu3UjAonXWTFvhO
         /8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903496; x=1759508296;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lEG3WGSz305Arms624ajjoShLogPxrkuH6t9XOTDc4=;
        b=OX396QgSyy1iEixLkWnANJPu+MZzftvuwVnC157x6XX5IzNjvq1OQDWR/KtLOrSp98
         yFk45QzOo8HHcljVkmcXX3as4pnB3l7xVhdS4JiMYrf9NweBG3VBDyX/pW1NbyKBfyRq
         k0w2Rwfev3Vwg2ucJTvqa1L2XFJjOksVqNhxCG7D+HE6MR26/M5E14Y/OjbwUoOuLa2w
         pnKd4I138ArjdK1Q0ytZ7nytOJtePgzCaYPY6GaZeCMeApeHgGczJAr7Vdzd4I0zDIQH
         JieSD3dMVq6eu+8XP/NsAPKwY/0SyiYuZy5UxzcywfuYm+qyNPwrnQA4j/jEKi+VqfZG
         OtXA==
X-Gm-Message-State: AOJu0YzBtgflmeXIH/3ARL1hw/Q3SjTQuA89BK/MVZPMuB+6F9UVee+K
	JELO+rIRUY9MFt/MqSq+bD/7Rv1a45e6WKBFzfd2dXcWA/ooaBPakwqRfUnt/CXo3P3zfwBwa8z
	82o7zodPKrcSrH7WbFwd3sgD9Qw4rAsQ=
X-Gm-Gg: ASbGncsTU4QSwoFMjEk6PTewrwEkFFHbPSiGXezh7rnJJtx9HwoijUZMz/yK0j84vdv
	Hh/kuo+04Vwr7wKuNGvuvyNhLehzgednG6cYUZx0e3j6X4sXAx33n55RxtqshfHb6c8NgGC2csq
	E/fualcmGmh2WHtzsrW2IAhrzsbkgD20nL6LdZaq47X8geSLFUb7K7Lj5wH5gvWzQKsPrAqtAcL
	mX1jHB+K/PsD252zAyG30kCw2/3JKAzxLUtaWSLCNYR4+HU9cqiXyiPKUDdN4ntHWY3cnzxJQw0
	0t9hYPp5AIhELReYl7Rbu1M+cuOxvCIqD3RADgdZoG3Wz1vVummBp6JBvEHlET/HSSQp1ea0OhY
	bALn3uoeK6z7KZrxU1caaDj+RDKJW3cmWOjvHpjuoCp0=
X-Google-Smtp-Source: AGHT+IGC3tiqbCfTYRmntqx+NLKt+dWS84jJKMNkbhRWzPUBrzwjyNVDO2kCof/FXRFfnnm77JUQ8sQHe5MQkjONu3Q=
X-Received: by 2002:ad4:5dec:0:b0:7cd:91ff:6215 with SMTP id
 6a1803df08f44-7fc42fb6770mr92298746d6.61.1758903495323; Fri, 26 Sep 2025
 09:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 26 Sep 2025 11:18:04 -0500
X-Gm-Features: AS18NWAQHcShMAHSei_C5dFYvflhD2ibYmlqEQVJhJMuBjTPuMnePdqGeUk7MNI
Message-ID: <CAH2r5muDMKFMMtG1_rUK6-h6T34qM4miRUL+hCQh72r-TrNoow@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
07e27ad16399afcd693be20211b0dfae63e0615f:

  Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/v6.17rc7-smb3-client-fixes

for you to fetch changes up to fbe2dc6a9c7318f7263f5e4d50f6272b931c5756:

  smb: client: fix wrong index reference in smb2_compound_op()
(2025-09-26 09:45:16 -0500)

----------------------------------------------------------------
Two smb3 client fixes
- Fix unlink bug
- Fix potential out of bounds access in processing compound requests
----------------------------------------------------------------
Paulo Alcantara (1):
      smb: client: handle unlink(2) of files open by different clients

Sang-Heon Jeon (1):
      smb: client: fix wrong index reference in smb2_compound_op()

 fs/smb/client/smb2inode.c | 101
+++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 12 deletions(-)


-- 
Thanks,

Steve

