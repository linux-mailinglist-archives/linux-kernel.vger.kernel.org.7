Return-Path: <linux-kernel+bounces-866885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ED4C00F10
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56CC04FEC30
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C87128726D;
	Thu, 23 Oct 2025 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drOJuOUf"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF467306B10
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220861; cv=none; b=OwNjgjMNVTcIOSDq++e82Ec1X/zvlj+Zu+1t3meuundX2WUXYVYhzTObRrLU3gZFFeA6jwAL5bQFn7jcdKSzzZn66lllEGFDTPveCjfbwexnK39F62eGUKs3zod5kIl3wmYSyZv/IE+WtsvgcSD9B3DxcW81rp9yAKV2R3j9chk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220861; c=relaxed/simple;
	bh=yuHlcBvMU39XZw+RlZWu9sOz8ZVcjnOe56nu//g1X+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fz+mK5YS2//ElllzSAFCo9DyRsOmAvyGWQYVH136TnPk5ECwfMabItniTBy3/LBakD5wvNVLahYpUXyTBSb367Ocz7TE3hW75KKIDfnW96/YQc37lVrjpV5gahVN0y0QjjW89iAXjvOUbjmvvTOqaQAPvCrEYBZGDuY0I0zc0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drOJuOUf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so4137535e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761220858; x=1761825658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zhlXGYq2HGvqmjv/3QsUATN1M3pTJKS77k0qTGaV5fA=;
        b=drOJuOUfReoojLGiXZsOawgnom1jHH8RJhvgZ1NmuXXzgjzQ5w1FgiRgMJ8ayd5cQ+
         jKQ9zKIxMpY2fWLsvKso3zfoWt8O1lzFiyvUrvMkHsVYc4F5MJgCQXRHRL8p+eR7oMvw
         nIV4Z+T039uP7Zuue10lMm8XmvfwTFBsxGrlO6WSQVg0fKgWlSMLQo/GaYHyl7biwajV
         Xz1tJZvUUygzia3sGCH+ApXg0hSUc+qA22a/9XiDL4SqB9q4yodF0PNxiJ2qXe2u3CUN
         JL9e+hbNREBAczHENGFZ7728GYv5O7RxWARW0bEhylThJlEG1eLzCEXg0iZpjoMXFCe4
         lMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220858; x=1761825658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhlXGYq2HGvqmjv/3QsUATN1M3pTJKS77k0qTGaV5fA=;
        b=b5acOBbWnRF71b79J1nlEpwFqxcII6ekLHkRWGbEn3sCYuhd0XdhicW7PIR2zT5wyS
         rZb0YGJ8NHSS07RZpZkivBZ1+LGPrSo5nesL4IbpcnzzwCKcQ0eQ7UyqU5ChERdUX0Av
         4eSDsCB2xei9PZIEkh7grFKY4XrdozeHMb6KBDGMtSX8VTP5vLtVrGKHjKakLh8G8CIr
         ODsOewfpaHBtV6EuKUdUA+p7xOlgwtOaJ88cNe7sXArps90OuKmSrFH9Eg/zPpgWnC0x
         ssaSveBeI59m8jeTBpRpBTfgM5K+dIw/xPzy1usKWN4kcrq+c6p6t0n64q4AnsPr/YIJ
         X6nw==
X-Forwarded-Encrypted: i=1; AJvYcCVoaqDUYP4blPZaKdURQE8KFOKhjaJwiGM7Xaf/2MV/TAEvcLXqJrb6zyy7rrVhsW3B0mxcq8RfkVxudiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXWMG8Ayg+VQqO4aJ+0uBhp+lf7hxvxMfkG31QLrWpOFFxL1fp
	OrsqTncL0zfJUQKE2aPdDp893orIjmSyz13JB4fXORRAAFSn5hT9U5tT
X-Gm-Gg: ASbGnctRw7W8f4WbMbwmpANvK41BYLoGEssB8x2iH/tw/+/azmfNJdaMDr4Y99kqjRJ
	A+qhRA52SeHpI+lD3wy5XuUM0UWR27zUrOQ/4k+c9KrIudl/8wBZXZPJ1/xPQcIKbmuFpogtJfx
	PDm1haIUIkyhMNh+BsVDeTWbIvVmk38wJjBnR687NVLV0g7Uctuzua7JIAL6RPpz9KsPbgyi+VK
	Au9cNkpsnem1dCKZlDKaud5/8jFupcigBoqE852YN0OaIjxPwCYOlnlOo2WgF58HZmW4qlzgOmp
	lruiIbus9ET1YYtJxTyFqJiv1t4f842Or4rumQDrJ6Jl2Vu0KArc2hGAxTuaVs1jvPwnScIOTPr
	q7L4h7Ryaax0Jjj7MXnF0MdyV1H3vNpPkxQOX/yR+PW2iCzPzMPe/fGqsg0Gtf/bxb7YKthHHTu
	0c+yo01uk3M1tPSOU=
X-Google-Smtp-Source: AGHT+IFMx+Pkya8XqVebTsjHsurSRMujmDLqw3GL1L2QyXDmCmrTsLd7PCMaI/thM/LSWD0nJkY+QA==
X-Received: by 2002:a05:600c:548a:b0:471:ff3:7514 with SMTP id 5b1f17b1804b1-47117877736mr184545915e9.12.1761220858287;
        Thu, 23 Oct 2025 05:00:58 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c43900e1sm109604435e9.17.2025.10.23.05.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:00:57 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v9 0/3] Improve usage of 'ret' variable and make pcf_doAdress() void
Date: Thu, 23 Oct 2025 15:00:40 +0300
Message-ID: <20251023120043.8661-1-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers,
This patch series is a response to Change Requests made by Andi Shyti on
[PATCH v7 0/3] i2c: pcf8584: Fix errors and warnings reported by checkpatch
and more specific on PATCH: i2c: pcf8584: Move 'ret' variable inside for
loop, break if ret < 0.
Also a comment from Andy Shevchenko on "[PATCH v8 1/1] i2c: pcf8584: Move
'ret' variable inside for loop, break if ret < 0." about using 'goto out;'
instead of break since the goto out; was used in other error path branches
so it makes sense to be consistent.

2 new patches have been introduced into this patch series and they are
dependent on each other that's why the need for a new patch series v9.

Change Requests:
 -remove initialization of 'ret' variable inside for loop of pcf_xfer() as
 it is not needed
 -change pcf_doAddress() function type from int to void as it always
 returns 0.
 -change if (ret < 0) break; with if (ret < 0) goto out; to be consistent
 -change pcf_doAddress() function name to pcf_send_address()

Testing:
 *built kernel and modules with I2C_ALGOPCF=m and my 3 patches applied on
 top of 6.18.0-rc1.
 *installed kernel and external modules generated by build on my laptop
 *rebooted and loaded i2c-algo-pcf.ko without i2c_debug parameter.
 *when loading the .ko with i2c_debug parameter an error is seen in dmesg
 and this is expected as the parameter was removed.
 *No success message related to i2c_algo_pcf was seen in dmesg but also
 no failures.
 *Module loading and unloading successful.
 *No PCF8584 Hardware was available

Cezar Chiru (3):
  i2c: pcf8584: Move 'ret' variable inside for loop, goto out if ret <
    0.
  i2c: pcf8584: Make pcf_doAddress() function void
  i2c: pcf8584: Change pcf_doAdress() to pcf_send_address()

 drivers/i2c/algos/i2c-algo-pcf.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--
2.43.0


