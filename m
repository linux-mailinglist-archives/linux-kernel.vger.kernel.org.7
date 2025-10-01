Return-Path: <linux-kernel+bounces-838416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8456BAF236
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 07:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BDD189DA30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 05:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848A724DFF9;
	Wed,  1 Oct 2025 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpY5bZi0"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A70556B81
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 05:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759295891; cv=none; b=LJ6r0XmiK6wADyoyP1YcxQx8rzOH3lfZ5yHcGy2KA/ojGik55rLaBY0oSOlELFT0ginecTuK/XTa7IPs3hG6OGTil+nWa9TrpMn9noDxSzFUdiRaDOLKVpBBAkoTRhJhG7IGBV03ICETZx44XTzCNK2viycwMu+JFvzKXeXelO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759295891; c=relaxed/simple;
	bh=oNjTJ0dIWTXRyJd9FpOyJ8FwljWhSqEk2bfEpn7IAGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D82WJuuG8Op0QX2yYi+Url3jCkCyfUmsC6aEWYK7uSf+8RRoa0n6i2zPdYT7tUf7H96nSGb3nTNAI4VGKTGJkrZXTYZ0+hMqrtfdGYq4ZVE/pEBohp+khQAHU3qhM6QELftzlYwWQFwHsYzy9cI97/O14mwJecG9bpFz11yTHik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpY5bZi0; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4e4a24228c4so926501cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 22:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759295889; x=1759900689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BxqunAE1voP0JsaJfBRf99gtBd6a1o1QCraMtaviFTI=;
        b=OpY5bZi0X6yXfXeaLrG8IzFtq6kGOUD2pz+u0BCI1grs3GCRbmC+OHFJNxRZ4ihSq1
         w0krw9QxXeKvIXcGg57ChKAKX6kLXFoCaKx8otuBG8m0o+TU61Z8q28EZXg5VKt1sDDG
         v7lQAp03AoEFXnV4kX+wQEs5+O9v+4VixRyGHxtNdnqFeQuZ/CF9kb4+ltrjruMO4zwC
         T1ju5ZUZoFEss/2lafyDa4uQC3nP+E6ddFCv0rWUbgmibCFrCK9FvRnxlCXF6RQGfiTy
         wnaNiEGkPNN4wBLJqCUS9I4NJ9TSzOui7F1nWcJ9AFiR6PKNom6U5dMO8+ALEhA/nCnx
         FEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759295889; x=1759900689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxqunAE1voP0JsaJfBRf99gtBd6a1o1QCraMtaviFTI=;
        b=fPmjeQGi28StiiG6hg1Jqj6ZGDhaRXvApyk1+MwYLQj9G2ijjP1qniYQXyK4doOz27
         t8cP7G62mBqkHkAa1Hf2DeW29MUCleChRxJr4ErG0QHxdSHLdlg7ccAzcfU/MM98R1v4
         U+02pCjCrYlts5pjfB8xp0aT/HSoyUZsq4Q3j7az38Q3K/A2FN+cBVaPHRofejuQgk/k
         P4oLKiXaNCLa9zFUejtwONHOalvmWRjEcawjMF1b7cMmCDnJPUbUST5mO/TEjYotkIrM
         YSif6Glr4ytApxSk4sOFRkyRYHIt2XB+ByTNs5Tfn7TFROWbqW/UaYXZiMj2ziC/UqRl
         WazA==
X-Forwarded-Encrypted: i=1; AJvYcCWl/8sJWWkv/O3kQaeF1vS0ysw84tdFa00lKwA7GB9nnDya/hD5ikBPF3XRwyKh748sk80aXx+Hs8ctRL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweIlAP9bthPIpV43QqAowBliVKeAxUL5nLAh85uK9LVTgMCg79
	gkbz3LnXYI3ItkfTbo0uMTlDfftT7f+8RZHH73SJlZ9A4EALkOMXwbKz
X-Gm-Gg: ASbGncu58++p59OtE8GkHUPYhLRe387xMNx193ffOz8cwOjReNv2YuPQN6WdCSmTE1r
	uq9TCuNhL2uc6MrncVPb0+UrEFY2CwwQpC66dCYc2aRjdGtP0jt1ifGPIVL8OIGY4wm3/7weBAs
	SaYLvPlIgIMeN133lZNG2nJ0jQOAulxUeMrCxKjZ/yC7BKW4rrSafUcKF4o/M5mYcHe1i9DeRcm
	3jtCR3pNuDuqOZGHNGBHTDQ2U7HFuVcjLUqMOEJzwCqgWjYps3a9D1l13MBaKXSslBX49zt6+UH
	WBM+BmlSYmq+IYy5HIh+PmxD3HUwrS5noEP+fRCHYwCH/v/ACQdnLVo15UHEVLdgDgzDTZBHwB8
	kiEn2W6NIJZoqnA7IRrFbZCRncd1rNh7j5Kw+go9hf6Qj4oB+p1marR4=
X-Google-Smtp-Source: AGHT+IHb6/fEglczrr3Ev9cuKvc8X8A1IQEUBdNXQFgNrBT3lBV6ALB1q2Du0bnDnnCCY3ZJvaDJlw==
X-Received: by 2002:a05:622a:98b:b0:4b0:8890:105e with SMTP id d75a77b69052e-4e41c544bc3mr31695191cf.2.1759295889040;
        Tue, 30 Sep 2025 22:18:09 -0700 (PDT)
Received: from localhost.localdomain ([23.162.8.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b56fe22sm107656811cf.20.2025.09.30.22.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 22:18:08 -0700 (PDT)
From: Forest Crossman <cyrozap@gmail.com>
To: mchehab@kernel.org,
	linux-media@vger.kernel.org
Cc: Forest Crossman <cyrozap@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Add support for Geniatech/MyGica A681B and PT682C USB ATSC/QAM TV tuners
Date: Wed,  1 Oct 2025 00:15:25 -0500
Message-ID: <20251001051534.925714-1-cyrozap@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, all,

This patch series adds support for the Geniatech/MyGica A681B and
PT682C, which are USB TV tuners that support ATSC/QAM. These devices
both use the MxL692 combo tuner+demodulator IC, so adding support for
them only required adding the USB IDs and modifying the existing MxL692
driver to take some configuration parameters from the drivers that use
it.

I've sent this series as an RFC for now because I wasn't really sure how
best to pass the clock and MPEG parameters from the USB device drivers
to the MxL692 driver. I ended up just adding some extra members to the
structs and copying the parameters to the MxL692 configuration on probe,
but this feels like the wrong approach. The only other ways I could
think of to do this were:

1. Making the mxl692 module aware of the TV tuners that use it by
   storing the configurations for each TV tuner in the module and
   selecting between them with an enum.
2. Including mxl692_defs.h in the TV tuner drivers that use the module
   and initializing the xtal and mpeg structs directly.

But I wasn't sure which option would be best, or if there was another
way that I hadn't though of. If anyone has any suggestions on how best
to handle this, I'd be happy to hear them!

This is the first change I've made to a driver that's more than just a
handful of lines adding some device IDs, so I'd appreciate any advice I
can get. And if you have any questions, please let me know!

Thanks,
Forest

P.S.: I couldn't find the MxL692 firmware image anywhere, so I wrote a
script to extract it from the driver for Windows and have posted that
script here[1]. Also, for the sake of completeness there is a newer
firmware image embedded in the Geniatech/MyGica drivers for Ubuntu
20.04, but that firmware image didn't work with the mainline driver so I
haven't bothered to publish a script to extract it.

[1]: https://gist.github.com/cyrozap/f07a8b9803d2e9e3d0ee7acf54843ab0


Forest Crossman (2):
  media: mxl692: Add configurable crystal and MPEG settings
  media: dvb-usb-v2: Add support for Geniatech/MyGica A681B and PT682C

 drivers/media/dvb-frontends/mxl692.c  | 38 ++++++++++-----
 drivers/media/dvb-frontends/mxl692.h  | 19 ++++++++
 drivers/media/usb/dvb-usb-v2/Kconfig  |  1 +
 drivers/media/usb/dvb-usb-v2/dvbsky.c | 69 +++++++++++++++++++++++++++
 drivers/media/usb/em28xx/em28xx-dvb.c |  9 ++++
 include/media/dvb-usb-ids.h           |  2 +
 6 files changed, 126 insertions(+), 12 deletions(-)

-- 
2.51.0


