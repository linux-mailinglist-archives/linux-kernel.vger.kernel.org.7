Return-Path: <linux-kernel+bounces-782887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B930B32669
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 04:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D970B64DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2011FCD1F;
	Sat, 23 Aug 2025 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ironrobin.net header.i=@ironrobin.net header.b="Txovt1j8"
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50D1F8725
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755914998; cv=none; b=Gb55ukgyGwYXZXba9SIdOXqSxz0CJ2s+oLaaOVd+rtPr0kzWCd+7DHGaC+KJWz2PJiE0aYnzhVKTP4RCvRGNTW368v2LSrdtXCZDJyUotFlshl8YuWCeT4lAimo/g7x7exi8VndPeYBv2k1gY0wkRsUKpMUoOU2Bih8DjWgQi0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755914998; c=relaxed/simple;
	bh=7uyzeRQggc6oxgd0PY2L8gdeh5mdqNaDhpkqBh9myCA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JBTGzNv/bqx4XDlsyOQU+AU995U4QIKHVmufKrDh3qzx/pdYtQovzNvadjp+bnYUrCrdbSfQMYWz2HHSv3D7HsAF4O1n0vPRHKMohSy8StGClssjMc575NOStu6fFhh3hWpJEKCuXuX/BGKuBLDUxUaPAsV8lbrn7vgpToOPIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ironrobin.net; spf=pass smtp.mailfrom=ironrobin.net; dkim=pass (2048-bit key) header.d=ironrobin.net header.i=@ironrobin.net header.b=Txovt1j8; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ironrobin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ironrobin.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ironrobin.net;
	s=protonmail3; t=1755914987; x=1756174187;
	bh=7uyzeRQggc6oxgd0PY2L8gdeh5mdqNaDhpkqBh9myCA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Txovt1j8ozud0Fl9wUnCIPLjQ3vGhuZGrVCHDOGxYKJ89H0ZpJOpKLu2fiKFZqm+G
	 1kg6LjHoRhSbihBUeejCB+fckqcEsStN+doMMIl44drLq2sXPeEJgQMUkYDWnfysH+
	 gkMBb6EG4Dccp06a9HdUzVeXwTu0bc9LQk0GU905bwJWt74RF8I1PoEGYK7x+WoFVN
	 J6vRclyjG6SHa7ZK3zZAgO21irhpb4e2HiHSe6Z6hUkJ4JfH9GBkG7YiQRMQMSXBhY
	 ozZsqC3ps7Sr6+YWHwf+/9mAXXhEPSCp5Y4PCvSG3UPot/Pq0VXPshVWlHR0tdwAtG
	 BC+FmYtqyWyOQ==
Date: Sat, 23 Aug 2025 02:09:39 +0000
To: robin.clark@oss.qualcomm.com
From: Alex Robinson <alex@ironrobin.net>
Cc: lumag@kernel.org, abhinav.kumar@linux.dev, jessica.zhang@oss.qualcomm.com, sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, Alex Robinson <alex@ironrobin.net>
Subject: [PATCH] drm/msm: fix race in Adreno header generation
Message-ID: <20250823020919.9947-1-alex@ironrobin.net>
Feedback-ID: 54785507:user:proton
X-Pm-Message-ID: 34fe4442870d8e3fff6aaa4af76ca24c06fbe3f5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Builds can compile msm-y objects (e.g. msm_gpu_devfreq.o)
before adreno_common.xml.h is generated in trees that generate Adreno
headers at build time. Make msm-y depend on the generated headers,
removing the race.

Signed-off-by: Alex Robinson <alex@ironrobin.net>
---
 drivers/gpu/drm/msm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 0c0dfb25f01b..1a918d44ac48 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -221,6 +221,7 @@ DISPLAY_HEADERS =3D \
 =09generated/sfpb.xml.h
=20
 $(addprefix $(obj)/,$(adreno-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))
+$(addprefix $(obj)/,$(msm-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))
 $(addprefix $(obj)/,$(msm-display-y)): $(addprefix $(obj)/,$(DISPLAY_HEADE=
RS))
=20
 targets +=3D $(ADRENO_HEADERS) $(DISPLAY_HEADERS)
--=20
2.50.1



