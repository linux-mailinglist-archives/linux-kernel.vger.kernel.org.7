Return-Path: <linux-kernel+bounces-740405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7507EB0D3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1BDAA05A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC72C2C08C8;
	Tue, 22 Jul 2025 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf3S3zp1"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01521C178
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170088; cv=none; b=l68vpj4yuGelq4TAzAmAnC5oc/Ah+FFjei5VqqpXAnrf+Vym59EM7zAMqbyBS9z6EwpNM51SrP1jShepUpc3zinByL7I8rLtOHW/GTrfB9wwye+oS4qQeR1qOONQp92OcrQEB+Q3Mn0vFpRoEYYQ0yl8zrAcynhdSeJWiIcFzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170088; c=relaxed/simple;
	bh=DbbZYKcIpuLXiyjkFSGf91A2eOs0AFWoLz0cFNMYfPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jb+s0EZneBHjMkwbDRAd6vKcwXcJqpgydM4B8sKTn078pFBe/IAYDmCyvV1LU1JaYvwGannO6JMHWzQQ8N2ghuH8Cq4lfi2HjgCpEvyRRNScg0F/D+s9JJe0hNpGas4bOf46KSANmCU4geA1oQRiVji4WQS3DniWq1wD0RKCEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf3S3zp1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso9074168a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753170085; x=1753774885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iEcp76xt+rnAHv6VkJ8kkXSE29MAgy59gpxqA0MqfLA=;
        b=jf3S3zp1dN8AdAFeE9GIcaEXK45csj66Xma96xs57jgFqvcoNsl6zsT2yB1s+NqqTL
         Q+/0MtKThoWT6shQbodSTdfq85Nhk8kYLadDglw1Ad2+o9st7NTYM8nZ5ei6PuptvCqa
         elkZppwgBjo2Rl13gxjOmFt0bkIRsvP6SPlskG6Gt3IILICoB2pX+a+JYh4FSLJM10Ab
         R59eCIXSvn85HfhhOBTr5DRBYFpt4b//8UPMEB8ilTb6VdkIG1UVsr397EtSMMmqyWKx
         ERYgRvQergc2eSEW2Y2j/sBwcug8c3rcV3hYfCw6WRUEDcHemd4eBXgNLFeq5o27IdeV
         h/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753170085; x=1753774885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEcp76xt+rnAHv6VkJ8kkXSE29MAgy59gpxqA0MqfLA=;
        b=ETf318TctyG+ptZUDbwpR9jx1l86c6GxmbtrCR2AY9BJTt+N60c+l0JgqbB1JjEU4E
         EKWix/4WWkYuZd03LNpDHAes4yKtIntcxgIyZTHbkLO5bT4zEFd65ws4vMGhq/Z6V0PY
         z9yV5zoflIe36724ClUHVLWG9IbLGeDjZjLnO5dYSSVcc7c+vp82nqwK1inWdNX+rXUI
         XXH54t/HaxfxhNhoSNFPuGzdT4KQx/36jBX9o/X2RdatEG+A1Our6vtYSsI0ScP3+s65
         +avxUGTniKjmFkDyaNatSMrOUlb0ZnqvGOHtWNHwxjsFydGNHUD4fofTPoMyhX03K1NN
         ZzBw==
X-Forwarded-Encrypted: i=1; AJvYcCU2vNIyNIqkii5PzN1GpNYJTW6qyjeFL3iuIEOOezUawDBwP6L8AWn/JuP+EdE+xhDdOwpxnR6YYRyjooQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVq9FWDMsdvNSyLaWAmNOzyZdww0rtOZJgeVUqsjLHdURrOrb
	OXqCfW65GnZllnkliSsjb0iUkJ++uozNkSX2YgsRWo9dBwTttmYXJV74
X-Gm-Gg: ASbGncsT5L5G/4mbvcddD9v/bn/GV3ZxF9/88MDaDDP2zHkoHIsB6ZG5yPl89PUyHVU
	b8/TRcDMu544SdfAi9OvZwuIgneUDCi1AjUUPU8dQWBmzhKcEHC8/up6xc86h2ltU7C7tQE98X1
	ZMYmlvX1ws0CbiGw932iImT+IKz/PAX0Ww+l1/Fm6bx3M2g0oR+IlY3RQ33/xEevn9M3Vun9zHP
	xgcCkt0KPHi+YH1SEzDeItWe+18oMP4RppUwUBMEwNhzFFdx0FSWjTyLmUkufRodghaZWqlTO7D
	1SB74RFtPR/0o/y6ohhOFOjm23fq+z30LubZB2rCy0QuSeMTaiib2ILBGFe+04dDveow3xnDay2
	49RzD5otNBAakFmD4qRVA+Cs=
X-Google-Smtp-Source: AGHT+IHDQyw9NYvdFCCGeAnM2fJtVuptzMXio+lp0jLaNFeZl1ERXmLnJ572m2qsqzoLB3bKbbHU+A==
X-Received: by 2002:a17:907:7ba9:b0:ae3:b371:e7d3 with SMTP id a640c23a62f3a-ae9cddfe62dmr2150317566b.22.1753170084343;
        Tue, 22 Jul 2025 00:41:24 -0700 (PDT)
Received: from tumbleweed ([95.90.185.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79d6c6sm821224666b.32.2025.07.22.00.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:41:23 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/7] staging: rtl8723bs: remove empty functions
Date: Tue, 22 Jul 2025 09:41:08 +0200
Message-ID: <20250722074115.35044-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes some empty functions from the driver code.
The patches have been compile-tested only.

Michael Straube (7):
  staging: rtl8723bs: CheckFwRsvdPageContent is empty
  staging: rtl8723bs: rtl8723b_set_FwAoacRsvdPage_cmd is empty
  staging: rtl8723bs: rtw_get_encrypt_decrypt_from_registrypriv is empty
  staging: rtl8723bs: _InitOtherVariable is empty
  staging: rtl8723bs: hw_var_port_switch is empty
  staging: rtl8723bs: dm_CheckStatistics is empty
  staging: rtl8723bs: DoIQK_8723B is empty

 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  6 ------
 drivers/staging/rtl8723bs/hal/HalPhyRf.h      |  2 --
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    | 10 ---------
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.h    |  7 -------
 drivers/staging/rtl8723bs/hal/hal_com.c       |  7 -------
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 21 ++-----------------
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |  7 -------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  2 --
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  5 -----
 drivers/staging/rtl8723bs/include/hal_com.h   |  2 --
 .../staging/rtl8723bs/include/rtl8723b_cmd.h  |  2 --
 drivers/staging/rtl8723bs/include/rtw_mlme.h  |  2 --
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  1 -
 13 files changed, 2 insertions(+), 72 deletions(-)

-- 
2.50.1


