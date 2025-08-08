Return-Path: <linux-kernel+bounces-760122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F0CB1E6CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77519564141
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21512248BA;
	Fri,  8 Aug 2025 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXEbIhIa"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5C2517B9;
	Fri,  8 Aug 2025 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754650225; cv=none; b=SknRe97FhwaefGNWjzKQ1kgKO3Icqd5+AWAuDyqhl/V4WICltjB3nHLH/+Ic//MhwUQCUQ8/aCPKRg/ne1XB0CcWLYhXtijGq4yviO6FSauvxf/kOgNvw7L9m2z2wOfI+xkOPT6Z6zSIY9Ifn+2REYZWoJSfaSaQzXKL0PcPIZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754650225; c=relaxed/simple;
	bh=EoN3kO7fVy3vEd4SHR4Fx9t2iMWtCk8xE+8jgDc+268=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WclWzx8q+F/AzyGLUaNCx3chxVX8aRX5+1VeMEJvipmRz+RIZUuHWKVlO0yQd8Y7qYUxq5/41iqB2tWq9sQyP/Tg8pZerWdfeSyPnNzqN5Su9XqgJsvlXTBvh0roEgxFU8DGpBFed4C9Q3O5NC1RRXseXKXxd/9mCO+Qr1HLEtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXEbIhIa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459ddf9019cso7172595e9.0;
        Fri, 08 Aug 2025 03:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754650222; x=1755255022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYNOgvNe5IUkFxn9KdzMZHHgW5dfYZKYrJHgIYaTBZY=;
        b=eXEbIhIaNtnaoivfzleKStb4yRxmc6wvCbKCuBk8a/SgxfJhMbetZepfPh6zX/Y24Z
         dUpdQrvHU6JotGHJVUNj0vAjfRH2OIUGaJMzUunVsvQjjULTC4tfYyw7Tu1/vMRenb5S
         DDGyVegWccVM3N4g15PY+KLopIwqN3DHbTIdXgD5G0S2fuFzIFCe7qrHMgkRyqut2Mjv
         vghr0elYgyhVBwDTETGlNFnuHbzklpKqQYdRxe1cZmtYh3WN0ycdBO+husbCX1YmMlZB
         Nv4D6MpOgj7hJZksgiXTfIE6K3JmrxYlBy6QS7cXw0LIW24IDgnOwR9hIknVoR/JUpvk
         SdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754650222; x=1755255022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYNOgvNe5IUkFxn9KdzMZHHgW5dfYZKYrJHgIYaTBZY=;
        b=WrZPxOryhZLg+49+wPj2RluAnT8JeOvOdi2KfKyH/gLfToHQNCL+UTKRGPl8Rey97u
         58ArDv7R67Icv3R9wxZLOq3Y02CaduE8GN8VEahbMDGzOzZAIa0wQV3KFkpHE810541f
         lKddhadtA3K/NDEyUhR9tPebFnksZ2dx7CnJTZQ6+5469dbwVWEYWmV0hcBzxdLccgwF
         B7ZoS0TkWTVa0dbEctI+euXfnpoVl9dwQBIhPF3frHpLUGKMLx+hTLP+gj03LQ+E5W9I
         DqpEMK2+hjTbD3OnXEKG8iq3WM33kBfrrB7PSsHJJDs7Q6rbDlzXlYkUyhw3GSZj/XhH
         ZT6g==
X-Forwarded-Encrypted: i=1; AJvYcCUhDDYWa3LOWkMrtFShCSHKslTmsAuteJXjZ35jVMICP3WCiUlNKX8qsEzH036cFnsyXcLlz9T3qSRe5eQ=@vger.kernel.org, AJvYcCUiHcUfUiSXx7O6O8xeAus3ilnmJOPqA2QSacZ/cVl59ZXH+EuIkWvEMJeC2ZgwWtb+bSCQ+sEtwY2RQY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQJjO+2PxHFC7pa7x6mrlLVbmMZZpwCUhDATW5miLhCB4v4DW
	iM+PByF25w+LE043xq18KGcgG75kvmuUUNetFmyX0kA1Ghfrm9nXWTTV
X-Gm-Gg: ASbGncumY823i1fsL7/izV6aUHSC2hGHW9HZ3RwzOHth8B/O2BH1ndU5WTwlIxdsMvO
	Md7+4dktAyjdTjaVI4K3QXofM0mMu4QGydckBe2DmQP013RcRmSl/+1LEnfDQUOBNxc3goAC2me
	DVeqn3li/LCw5Bu5PaVUpko8DXlHNFOntFwqDJd5Im/vtuTlt6KnAkqF9/AkwalaQsyzzQgluK7
	pjxeu+cKvdiudJuBwCXTZdnYvtvpb2YRZxtJ7XmhW66ZvhXoyXqjZ63jJ1vva3UOfBjrHWhWY7k
	hVuRcum/KA+k1PYs6JfgD2YQxaFKXI8kH2VokBdkXGm1Gp6NaobIpevuyVJ3wmgtCbXza1Zm/E2
	wfZI8tC8kUJESKxfO8Tjv
X-Google-Smtp-Source: AGHT+IFwRoGv1Ll/KfaPYKbADDMdH0G7m16y+moNJlRZirN3cYiwDmmegeTfTwl3GBg6z4JjhBEHdg==
X-Received: by 2002:a05:600c:3111:b0:458:bfe1:4a8a with SMTP id 5b1f17b1804b1-459f4eb5d3amr24790665e9.14.1754650221362;
        Fri, 08 Aug 2025 03:50:21 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458b4f9e952sm270900175e9.9.2025.08.08.03.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 03:50:21 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: tas2781: Fix spelling mistake "dismatch" -> "mismatch"
Date: Fri,  8 Aug 2025 11:49:43 +0100
Message-ID: <20250808104943.829668-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake (or neologism of dis and match) in a
dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/tas2781-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 9f4d965a1335..8e7e45c046b8 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -1480,7 +1480,7 @@ static ssize_t acoustic_ctl_write(struct file *file,
 		return PTR_ERR(src);
 
 	if (src[0] > max_pkg_len && src[0] != count) {
-		dev_err(priv->dev, "pkg(%u), max(%u), count(%u) dismatch.\n",
+		dev_err(priv->dev, "pkg(%u), max(%u), count(%u) mismatch.\n",
 			src[0], max_pkg_len, (unsigned int)count);
 		ret = 0;
 		goto exit;
-- 
2.50.1


