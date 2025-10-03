Return-Path: <linux-kernel+bounces-841595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEBABB7C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79A619E7E02
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235302DC335;
	Fri,  3 Oct 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrlGpn9Z"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB582DBF47
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513197; cv=none; b=AidED1jVnecSAJmRr1CVpEGaF7ORkBqWk+Y88FNBlvUNWs6vM+h6HMOiP7xFB71yQxfgC1+prPOIbLqvlQGJYHCQdHs0LeGV7usdWw8YWqPTpcTRoPVCMSjfpah5Di3b1il75q5cQyN5lSPx4Ryutns1q3luRwWvXG0LW4gEkjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513197; c=relaxed/simple;
	bh=K9MnDj8zru19z4WabVyc96zz7IXhP2QKMqGlIBk5Aw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKrcMaFFuTi8DKPN4yIAN4sS9RRzZc+DcaiXZkVSfhUfe8uW//COrwbjCbshXgJH55/mZ9eKYsjHt0jU9iJfY7BpvYLjulSjRyGgevIbcbUjnUTIEOqLXpetfwctqE5NOimY+XjeCWeFb1RLqZG8EEp3BsR94k8pKXBeNKkNg8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrlGpn9Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-271067d66fbso24176685ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759513195; x=1760117995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McKrphvnyhX4IqUDStO+Mgag88IPYLvjzv/054SeX0U=;
        b=GrlGpn9Zngig282ddCeVNdxUgcvY0Q8oBLwm34JfNQOC9AN7ktOJgJU1XtoJoUqs0+
         RpbLg0OchZB6hwgC+6cM1kd/FIhyGei7quVs6KCte6A/m6wH6ENc+lSvZ9oOCqfoJVVN
         GBJGtCO4vprQcullXTrb/Dhp4JX9JCGX/8kjRx35vVu5xTEmTeTZSAVWi3CmQz2YnuEb
         KzlrHNRpqm3jz//WQRqBtcKaL9qjA8NhjHMiEilD3k0QZj1vfzzE7LvWwLXpjAzIS6Gn
         ZFfTvKx0A+jd30S8izz6Pri7VmQZqTU5emDwCxVjKCKBFg5grGQqoipInr1lPZkN+pM8
         m+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759513195; x=1760117995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McKrphvnyhX4IqUDStO+Mgag88IPYLvjzv/054SeX0U=;
        b=Bp5K2Dh3D0kPyMr3wRx6xJebF0pSJ3b7FqF9cR0jeyuJ13VrwBzWmcT+EvRZmbd+qr
         h1GiJTaVv159KzuX/2B9Waq2iLUMEDXY23alQ3l1sHZJcd6+k+i9QKHW0ogplM/W6QCF
         SrnRrd0+vu8N8c8PAZbxUd6RLdWezwav/mwzGFakundFJq2kDRempeamg06R5s/UZ+Gw
         y4eFZYkuXzuWltkS0p5PUyCWK1XHcLsvt5eztp/mlEbI7VDoZXwyDqTAj5EaH/MhYFk6
         BKB9By5uQkGapiowv2enz1QlFzzs7vH28PPg+qCGRHzw+lDHBc8j2uexAzyDRGHB2WSA
         dliQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdHWrqd2o5DFb6ygRqaGmOJflSKtYOkwoO19ItX3bIH5WW5LCrclfnhvmoqP9CSV+jwOXtcUiZe7ykJIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVACQw0KtcT3zfoosKKRV4MO/LpaHxBSrbmfVsWe7IAEl6KvUg
	cYozRS+/pKoB8RiWxMgAaB1rrZxs93yvex91w5LrwCskprASa+x4Pdsj
X-Gm-Gg: ASbGncutw9Sxwlg1HPyHd4IpYWNe3l80GVj7muL/gjK1qBvWb7YSlwPg3hSx0NFEF7u
	ZZ2pI1CBQMcKU+cFgzGXNwWjomB08NhOsDpuXcfQEsHYSLbvOk7jF4Fo4FqYXC+6mHTdIkHY5RK
	yAonxHVWJPF45+f7bZHGfH3OwlTurajyJNuir9I6IqGR0oO2hjE9prmtKcUcEih0uKeEdv53ksj
	xwCmN1R5u+Ao0O9aYIYsOpNriPO0u7tnM6RZSb1v5L2899Ki9GOn8WGxeCFt5UhazI5CUnS9mu/
	d3OMAxSK19Ey4Oq/zk8he+xuUhWcRhoG9A8L5otH2ciyHvi14PrSoEFlch2IIIRRrDL+5Upsc2d
	ZYDmcz1zD2izL78SX6veNJT6DGkh8Ya4G4/mInC9VB2w/WFXvapAvDHMLJRDuLR7YGA==
X-Google-Smtp-Source: AGHT+IFxK5aSMu30u6TJURWj06wmVP4JpzEOP1enPdk3/3t/y0sloBrTIpKjewn/xJuh0/y63HSRMg==
X-Received: by 2002:a17:902:f68f:b0:26b:da03:60db with SMTP id d9443c01a7336-28e9a5ea070mr54639985ad.13.1759513195403;
        Fri, 03 Oct 2025 10:39:55 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1261edsm56267635ad.34.2025.10.03.10.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:39:54 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	dzm91@hust.edu.cn,
	corbet@lwn.net,
	zhanjie9@hisilicon.com,
	viresh.kumar@linaro.org,
	rafael.j.wysocki@intel.com,
	superm1@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: [PATCH v2 1/2] docs/zh_CN: Fix malformed table
Date: Fri,  3 Oct 2025 23:05:59 +0530
Message-ID: <20251003173926.10048-2-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003173926.10048-1-krishnagopi487@gmail.com>
References: <20251003162626.6737-3-krishnagopi487@gmail.com>
 <20251003173926.10048-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Running "make htmldocs" generates the following build error
in zh_CN/cpu-freq/cpu-drivers.rst:

Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst:109: ERROR: Malformed table.

Fix the table formatting to resolve the error.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changelog:
- Adding missing TOs to the relevant maintainers.

 Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
index 8238f4c6e4f5..2d5e84d8e58d 100644
--- a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
@@ -112,7 +112,7 @@ CPUfreq核心层注册一个cpufreq_driver结构体。
 |                                   |                                      |
 +-----------------------------------+--------------------------------------+
 |policy->cpuinfo.transition_latency | CPU在两个频率之间切换所需的时间，以  |
-|                                   | 纳秒为单位                    |
+|                                   | 纳秒为单位                           |
 |                                   |                                      |
 +-----------------------------------+--------------------------------------+
 |policy->cur                        | 该CPU当前的工作频率(如适用)          |
-- 
2.43.0


