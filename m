Return-Path: <linux-kernel+bounces-863985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED752BF9A77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9AB18918CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C430B20CCCC;
	Wed, 22 Oct 2025 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEckUI7k"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9111FE47C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097989; cv=none; b=GrH1ZmEj+zh1fPHPZhr8AhyPRhbjGEEokXUWgaMsg4sRDBBMT0LCQQfvV75dayAnEwAIh3C7QnHY5G8kSfOkLOcJ62EvtSP/Y1xQZWYPT59NhDbxwiaiWtqsTgWDLumeX/UuDW7QX/0e8XcLL10XnSWMoRQWAg2n4ZMUtFafalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097989; c=relaxed/simple;
	bh=YmooPlppYzD8AJ6B+UA5wt7s7kf3vmhiMoFB0E590M8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWgzAD1/jZdOQD9SEnu2RPc7pRMWV4NkN0gvMVSMYID7sZZdXsM/PqJYkqbihsUIuRCPeAF/FJb0oUrXjUbutqNCHSXI+jhSdP8mNskEMR/tpxGhnN2/YI6JqAWOvD8NBPgX8kiyowuC7VZysIhp+BC335ViyTLLJookyZSy+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEckUI7k; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso46116925e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761097986; x=1761702786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5zU9EhD8Vfp36ASaBqsSl4/OEXrV7y8KWJuIts6MOg=;
        b=QEckUI7kcefCCXmku+IzGYs6uB2HocYONB3s9PAZvh3QFR1tcuhE91n883z7FXGT5l
         iLqn9+mFpZHkpwX97gJof7cZeNpcn/F9216RanU78BAEoNY/t82Qf4hLmwlhL21PVCoO
         fhn8LJYQR2vpyMb+zaJLZj1Y9DlY0avnyQAm/AW37vI6aEYqVq4fMyu6UQr+JDdHitsw
         LOAoKJ1kvVAQXwnpPbGJYTOrYUOnNqXPs/5RcfHdD5PDYWNDCy+jdTyaiDH3vPyG3c4o
         +XG43Jtl09KcQ/q4hXmORtxyp7uQc2A3Ne78JNmncWwDnJfgwDZrOumhVzmTqNwC90EC
         2tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761097986; x=1761702786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5zU9EhD8Vfp36ASaBqsSl4/OEXrV7y8KWJuIts6MOg=;
        b=dqwpnYYavgivQ4FeOgyuAXP2Cdfbl9+vxsC4dQtuBTBT7gktCQyAA/QvaIbizryYGu
         PP4w8S9kOzin2zOSOCZIHuIqlxbE1Lw6K9OdIg1/tb1yUJOJeDndwIj8F025Iliblxsi
         NMDOFsXW7MyUba9ajTThNeeue9/38wVTj+9pZ1fst4LBquGjgebSU2yoXlwH0tCYcRhD
         F8lmHfv1g8YJ+x4YMIJ5v/ZVszav7O5jWMC48guYemJbxvm7+Kycoikg81s4J8CtX6ty
         kHwpkV0lfZJcgNzlayeU//rYv4Xl0X2F67nCw8krdOPico7O+DpJ3reB/pNCQboIK8kB
         YRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3DNEWSVEUl/hGGvozexhSA9J16gyXWIqNcg/83DSvnKmz0RD0KJ+xCjqIw+gQtZNfraQqNie2P+Ey0OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHus5Fg+pDmKqeWW8ccREbjzSMyiEcQh+sHi9Wqn95DnPUd+6x
	DHb2D/eA3xC2STJa8C1iYmzxjGtuz+XcLQm+AoUfiNgLxZlj4qhFT20D
X-Gm-Gg: ASbGncsS6kfqyxJhkdNuY0pzVHwZZq5jUO02OmtyVeO4ZhIEzvIlAMAymNYHz6amPpD
	rGcLqUINlA8p8v/hjRFAEYWZQOp7gsQPGrKGoKZrYPPXsccmLSGNIWsSJ7qTKPDWOp1t2e7ZNoZ
	53zYkQlpTUTU/BZytTGHEQg4snG9rTnTJ0UOAubmxBgO8N2WuUzaEvhW8F9Z/jex5ZxWJ0z0Ptr
	3UFed5xPX45eK7CJADTY2xYB8/bZ13aLiqjDZ/JEcUjo1/2qI2PI8mCm1BnY++Cjh2OkML7dX+7
	lRGFeszBs7R6tH26OTGDy78/cqmqc1UzhouUBaC2v3wehMEIonaXSKvPfZlLV0KDhuHUJxXYgyq
	ZeNGnNC26eilwwwK930SE8u9SULWFL2bRrf3hNUJCSIFl3E8VLwdK8qZuGz3T3SBQQNqqzFCUAb
	d+4aEOk3qJ3eDoYMEUkf6Ua5nedQ==
X-Google-Smtp-Source: AGHT+IHoJtC1b/1vgTj/lC2EI1r/fL9qZK/cWaeVa7X2QqiHD66axbu7lEcZJouBLxxjRX1xoFF9Hg==
X-Received: by 2002:a05:600c:3145:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-4711791e7a4mr164600665e9.34.1761097985548;
        Tue, 21 Oct 2025 18:53:05 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428dafesm18557345e9.6.2025.10.21.18.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 18:53:05 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v8 0/1] Improve usage of 'ret' variable
Date: Wed, 22 Oct 2025 04:52:12 +0300
Message-ID: <20251022015213.6988-1-chiru.cezar.89@gmail.com>
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

Change Requests v7->v8:
 -Move 'ret' variable inside for loop of pcf_xfer() function.
 -remove initialization of 'ret' variable inside for loop of pcf_xfer() as
 it is not needed

PATCH 1/1: i2c: pcf8584: Move 'ret' variable inside for loop, break if ret
< 0.
This patch add spaces around binary operators as reported by checkpatch.pl
Move 'ret' variable inside for loop of pcf_xfer() function.

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
   *No PCF8584 Hardware was available.



Cezar Chiru (1):
  i2c: pcf8584: Move 'ret' variable inside for loop, break if ret < 0.

 drivers/i2c/algos/i2c-algo-pcf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--
2.43.0


