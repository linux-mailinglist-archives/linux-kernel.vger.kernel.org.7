Return-Path: <linux-kernel+bounces-737346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84887B0AB2F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5F97B2E93
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE95321C19E;
	Fri, 18 Jul 2025 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk66aEtO"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A891990A7
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752871708; cv=none; b=OMiizeaeb4i/L3ytE1vxxtQ1KBxncFBIchlljDlPvlcrjGlkgqwEwFEALYSvo7NOiCnoV31KS2poe7Fgzf7AMh9y2tNP0xmZzMFNdWJD4UUXLIcPjAX+hdpjzG3zQGdiAjOKWq3sh/RCgAGWqOSygAZ8IG9CU4uTyhgeSfyw+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752871708; c=relaxed/simple;
	bh=E938gfSru+guvf0sXkbNi6ybcJ95VMcvY+J4V1M/20Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ohfTkhp80fVJF1A5hzIhbmneZ2ITMaII+a2WlCgRUEAz6hYI79EC1B5JofJljwECzXvJyuDMg15mBMH17Rf7G44urxrbUHsaYd8gx9J1pj1y3hxac5vS1foYdzkIC46WSa6FWTrvuEAhEvMKkfFdkrCzL/SW4f+zQWq6R4bnysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk66aEtO; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-615a80bb75cso738621eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752871706; x=1753476506; darn=vger.kernel.org;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9oIVrVDDd270NCSeXL22MIJ9Y/QmfkZjZzqk8mfVCgM=;
        b=Hk66aEtO2DxY/gU2nmvbUMao/QY8vK4cea7BzpRJgbHAMQJr1jqHx8kaw0EfkzcYMY
         25doQI72Mfi0ISmPXOYmpG+fuSp94GqJxQHnStHJ658sF8oQhlFykJnuDPxdT+52yGCr
         vn9lRM/FvsaTnmgLCbCNFkj+S7vf8MMQX1y8qIeApzim6JNTrl6vIx27paoPWM90Q5MO
         5YC8FVWeuvPR87VlxICz7pRrj4mdqET11DoZ1yfXEZ5tzoRcSleBCnsjiJiRdm6fB6LX
         Yi/g0vI2LI9Jt3i+xJ+7DlfV5A1VINn3HhOMh7rYHysbfbqshZtcIPGNyxC7hSjnq7HH
         ttmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752871706; x=1753476506;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9oIVrVDDd270NCSeXL22MIJ9Y/QmfkZjZzqk8mfVCgM=;
        b=mchlKDHkFmxJB3sm2Cj33WBu9ncmHOoCs/8oxAyBDb/uMyStcScwrL0kFrD+NR/u+L
         zzBe3TJUrjPOYRGjNjoDOIwpWrtzko+4/ZOna7HFbPXNcfi762NZnWa9q+EopOBt3R3X
         SFpaL2Pvv4/Avtzhi0/5GSclqQLscHKa2L/Vbb8HtHufXOEbZbfjtmlvwuLCFQN1UslT
         R1/Cjh5qRseTNWeT7dOruiq+9QTphprC8plmkqteULxOxrQ7hl31T8mcQFnohhOQFm4R
         yzuSGdU68BwUHRx+uzgDZ4+bMjPnKCwqYCh9gGNNqoNfxUT3lSGBBRSMC07KZQVWWY6L
         wIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcM6bN739ZnHl/88x5ULp5BmchdkoO+/HKPHETrNCegodYn7wyREmep8fS+xuKTquC+HBknrPhEPyelUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPaPwS0h+36pHsRXgLzbI1xI3DQifLdZAa75tbjVKOby1L5SzM
	0Q00EkjyeaGMDJmBGZufXWKcsNBpx2jwlZn6paDqSoxOHRBgbOr9S4OhlobYMZIBzcY=
X-Gm-Gg: ASbGnct84nUsXe2GFjnKebsnaljyDlX33P0exzRhYBtaj/FU/i8O9ckuPKXz4e6w2dX
	xeHNTOxF7009CeayYkgpS1WQCW+mQ1Yfq0OJYFlwHDGYfBREAYVjqjlK+2wi6KaVdRNKtDp6aJw
	KmI3jRnleVxiSBal+GN2wLLc0Q9lD08G8fokcWJeeVTJOt7FGuRe3sRYhpsozfbMdCqG3xyFd+c
	3jeBZFcSTbr6uKdJmBhwKRNCR7jQMJhp5WWCKene0IYt2xOvfWF+Vcrd75o3v36Rhxo+NI8GtWb
	YD+xl2x0wrBEQ/Vvfr2KjNpYbC2FGwjwpHz5tMq3C01Bg+ZjkFczoS6jd/D4k+a8SngcepA947E
	iJGSGLMG2Gg/tJ+ETNxKTp506Xc+du2NdKYsfKK/zT8ANRgP3zA0KFs4+j5xBsQ==
X-Google-Smtp-Source: AGHT+IGdmIPKvJ3cwCYg1hwJE7y2soAfHO512/2kvqH54mi4z8iHRVaBPxk26jyH7Nwi/zKBe6S2zw==
X-Received: by 2002:a05:6820:2010:b0:615:ae24:916c with SMTP id 006d021491bc7-615bbc0563dmr2656824eaf.4.1752871705970;
        Fri, 18 Jul 2025 13:48:25 -0700 (PDT)
Received: from MacBook-Pro-de-Ignacio.local ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-615bcc8c2dbsm528180eaf.20.2025.07.18.13.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 13:48:25 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:48:22 -0400
From: Ignacio =?utf-8?B?UGXDsWE=?= <ignacio.pena87@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3] staging: sm750fb: make fixId array static const char *
 const
Message-ID: <aHqzFn6CfgWLNa0A@MacBook-Pro-de-Ignacio.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.x.x (Linux)

Fix checkpatch warning for the fixId array only:
"WARNING: static const char * array should probably be
 static const char * const"

The g_fbmode array cannot be made const as it is modified at runtime
in lynxfb_setup() and lynx_alloc().

Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
---
v3: Apologies for the confusion. v2 accidentally included changes to 
    g_fbmode which breaks the build. This version ONLY changes fixId
    which is never modified.

v2: Only change fixId array. The g_fbmode array is modified at
    runtime (lines 786, 788, 949, 953) and cannot be const.

 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 039e6875c894..c237a8f8eb59 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -730,7 +730,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		"kernel HELPERS prepared vesa_modes",
 	};
 
-	static const char *fixId[2] = {
+	static const char * const fixId[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
-- 
2.39.5 (Apple Git-154)

