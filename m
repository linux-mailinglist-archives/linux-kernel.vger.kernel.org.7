Return-Path: <linux-kernel+bounces-802306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C20B450CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBAF17B82D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F7301029;
	Fri,  5 Sep 2025 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mrc+hBEi"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1B2FF677
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059343; cv=none; b=r+SzV4G51hCg056gURBfeyHw+NfrouSDZsjh/dT+gzLNqT3PdyyeRhphIwsiQYF92uBW8iHnXBZz7Rm8RH1cvfC80Gij71j3d7IvwM2T/YgG4Z0Dz5sfwHeR1jeVTye4EBS7oqBXDF48Me9lzRFRseFWlBdfEibINjOSrAjlFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059343; c=relaxed/simple;
	bh=tMuqMy9KNqQl8d8FLz0h9ghs2eY5SyYIDshjqoFiulg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MdGLrrv36Qy7ifRt6Lq9pg9bAAravwD29xRofV9Yc66lg+eFvC4GKQyqMWz618ZlQVd+pOQGQYeLoq+8Y97AzDTlJxm9lKxzffGRa8YaFk/1czyt22qfNbdcArwnOj8F6sZ38FvWVKW9VpTBGhx/MxA7xFtFPNLdEqlo3hfZsck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mrc+hBEi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso20762905e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757059338; x=1757664138; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o68AReBijMNMDf41J3JdN/+EDwW+zsISsfZcVm5zD3Y=;
        b=Mrc+hBEiG74vKaynjbz8krYMALHTRR60CijT/+LLbnr7QO/XrQ8LiLGjmXMc6PS2hT
         jmMkR6rc2gm5p8S/ZtIVZyFcb8UIT22QO4LK6l1iseybtCGpSc6FCeAAFkS1vP3U3t5n
         NGeaLl7jGqZHapKgTycAGx7m+baDVF5pZSLkjflaZ4JgqSDMOAyeN6A8VbOTbnEKhIKw
         615v5RXlb6yPl3hwtiKSFlDh8/OgTtgmCgZ00Htv591QlQw2Rn5FX7F+wOKtXa4eMmar
         H+l9/4z/YVJPpessGNH2kcuy+uJFZ1dMu8RstX8RxnLZhd22Q4IZLkSmTJyAJIHUfNcg
         6l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059338; x=1757664138;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o68AReBijMNMDf41J3JdN/+EDwW+zsISsfZcVm5zD3Y=;
        b=QNKw//i61wtg3kayluwXxwD1w0m1hA2zsptgFd09AJZyv128Jw5d4fKkrSmloGXFCF
         3fraCEhSK2C/dz6Pzi/9AGo4c/SisFEsERufu01B598ln/Hc5/5xrmf6C2iGzZmT8xD8
         4F8DzWpqseUHcg/NbD3o/HORhng/ZP7cKw22S+vSEkxjarQiP/9lCbxJtuysoK897C8R
         FE2IwXYXthyVn8kzc8Vc/zjGxkefGJ4nvWtF7G2N0tcvlbjMAl57f6LSxbvHm7S2AGPR
         kgDiik4RkRU+/+37eM0HC+jsyJZk8nlkr9Dfc++uJbP/FHSdVcBxwLnF2i4zguCa/lki
         gcew==
X-Forwarded-Encrypted: i=1; AJvYcCUU7n7HUd0s1lpqSShYejBNQrQiGZXH7XtiGTJ7cE3Wg72KB7dZ/z62tzs2clEbbdR9mQpHCNemsctMAs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaWgn8dId2zMBrM3MjdOjev1TyEzJQVyvkhmP4GwbD6IqL/Hex
	8llQWCBi0I6xnpRrZJe3YSWyKr9nAc1BSb1AyiR86khcufSBH8GUd0gR0SAVGwrcFcw=
X-Gm-Gg: ASbGncuEL0qEev3DIOys37QdHyF7HMgvxMmRKitN3mZ9sk9eGWHqfmDfViPpUYdTzyt
	P1Vmz9pxdFyN0o6I1EKXxwhZWAHiMRlIHvprH4Y+hijNiqki4DUTcCLmjgvd9Vgt6Ys5UvMoS5O
	DiToUAzzNIBDVVUq//aYYwtIDwYtbcVFboPMdOrb6mD8X5EG12Gj59hIiKV1AHtlXrP1rMDvMba
	F/dvWr6+lpbMjkoBpJqNv4iyjN08z1KzEQlcYTp4XT8XUig+d6okHQJPQB0C8il6phxvX0JQvsO
	7M1DE3wBwAXcposM8IjKAjudZ9KXpSk2pb+5u/2WA1j5ZFhBkjrm6CC5RPZlnKpTsTbMUT5l4d9
	caOUCZvUpqeVg46PazuDp4IUkdxrY1U7nDY9EIg==
X-Google-Smtp-Source: AGHT+IEUmVHJbjR7C3oIB7RSAsoVRqWkfah8MYKFJmKmkTEM7dD+VYHIgQjg9wCazj41X3C/wF8/tA==
X-Received: by 2002:a05:6000:4285:b0:3d4:13c4:af73 with SMTP id ffacd0b85a97d-3e301d1807bmr1931877f8f.12.1757059338196;
        Fri, 05 Sep 2025 01:02:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf34494776sm30331604f8f.61.2025.09.05.01.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:02:17 -0700 (PDT)
Date: Fri, 5 Sep 2025 11:02:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: mwifiex: fix double free in
 mwifiex_send_rgpower_table()
Message-ID: <aLqZBh5_dSHUb4AE@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "hostcmd" is freed using cleanup.h, so calling kfree() will lead to
a double free.  Delete the kfree().

Fixes: 7b6f16a25806 ("wifi: mwifiex: add rgpower table loading support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index 6d9e2af29a69..91d5098081e8 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -1521,10 +1521,8 @@ int mwifiex_send_rgpower_table(struct mwifiex_private *priv, const u8 *data,
 		return -ENOMEM;
 
 	_data = kmemdup(data, size, GFP_KERNEL);
-	if (!_data) {
-		kfree(hostcmd);
+	if (!_data)
 		return -ENOMEM;
-	}
 
 	pos = _data;
 	ptr = hostcmd->cmd;
-- 
2.47.2


