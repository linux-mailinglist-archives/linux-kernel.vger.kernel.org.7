Return-Path: <linux-kernel+bounces-851830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B876BD763A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C30A4F127C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DAC2749C1;
	Tue, 14 Oct 2025 05:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="hNAbTWnQ"
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B22236FD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760418951; cv=none; b=rDTO8pQ0lBzqAMoXs7oFjjsE26SHOsL7au1XCYaIQ4jOgjAbtSebeXbWKbENqzUPnR0nIBDDR38SK6uWHqyGVvNXVBthTn1/anY2HW+HqPHseYpqgWZJsn6KGfKMsWG62Gd8xqCIgbajA5nyh4JU9Bd/FL2n7BlpYoVSUDyaTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760418951; c=relaxed/simple;
	bh=5fuV7sicUyCl/MZzw40vS1TCjZf9EDfg0MAcpiOoGrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vedu37JKp5Zpjj0mT7sxv/CKbkviUqr6xyouEsB+LwocobkHm+y0zV4dbJx2uMdzDzYIE0tpS4ZEmQVEL78RF1dGFSkaZ0NTKrRP00EghUREntyU3SuMzigwR4IeXkWuxHjaxZAQ5DDcB76qTQmizkTyza4cDQm+GmxkCk7qNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=hNAbTWnQ; arc=none smtp.client-ip=51.81.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 6EB6B223FD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:08:33 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id A12CC20112
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:08:24 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id BCA363EFE4;
	Tue, 14 Oct 2025 05:08:16 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id D8558400CD;
	Tue, 14 Oct 2025 05:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1760418495; bh=5fuV7sicUyCl/MZzw40vS1TCjZf9EDfg0MAcpiOoGrU=;
	h=From:To:Cc:Subject:Date:From;
	b=hNAbTWnQ2W8U13uuEGAQwAM5/KzRMSvv3QHmNy/R7KyZHTclo+B7OA3XGwrx3pOsZ
	 GFbh4lOAXtcFgMUG76yqy77p6YOZ8jOieRBAzKOyhGwRZ6wxbQAfKOHTp8zfyU4e1x
	 XYLdDSBGpQAwt1lv7nYoLS4tZPIERjSJsckt2djY=
Received: from avenger-ThinkPad-T14-Gen-4.. (unknown [39.144.78.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 5222C407F3;
	Tue, 14 Oct 2025 05:08:11 +0000 (UTC)
From: WangYuli <wangyuli@aosc.io>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	hverkuil@kernel.org,
	lumag@kernel.org,
	carlos.bilbao@kernel.org,
	sln@onemain.com,
	jarkko@kernel.org,
	WangYuli <wangyl5933@chinaunicom.cn>,
	WangYuli <wangyuli@aosc.io>
Subject: [PATCH] .mailmap: Add entry for WangYuli
Date: Tue, 14 Oct 2025 13:07:47 +0800
Message-ID: <20251014050747.527357-1-wangyuli@aosc.io>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[wangyuli.aosc.io:server fail,wangyl5933.chinaunicom.cn:server fail,liaoweixiong.allwinnertech.com:server fail,wgong.codeaurora.org:server fail,vdavydov.parallels.com:server fail,huweiwen.linux.alibaba.com:server fail,wangyuli.deepin.org:server fail,quic_wgong.quicinc.com:server fail,wangyuli.uniontech.com:server fail,vdavydov.virtuozzo.com:server fail,sehuww.mail.scut.edu.cn:server fail,vivien.didelot.savoirfairelinux.com:server fail,vlad.dogaru.intel.com:server fail];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D8558400CD

From: WangYuli <wangyl5933@chinaunicom.cn>

Map my old, obsolete work email address to my current email address.

My current work email may not be ideal for timely communication, as
it requires a secure network environment for access due to security
policies.

Therefore, associate both my previous and current work email addresses
with an email address provided to me by AOSC Linux community. During
work hours, my commits will likely still be authored using my company
email address.

Signed-off-by: WangYuli <wangyl5933@chinaunicom.cn>
Signed-off-by: WangYuli <wangyuli@aosc.io>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index d2edd256b19d..c7f1b6ae8f7e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -841,6 +841,9 @@ Vivien Didelot <vivien.didelot@gmail.com> <vivien.didelot@savoirfairelinux.com>
 Vlad Dogaru <ddvlad@gmail.com> <vlad.dogaru@intel.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@parallels.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@virtuozzo.com>
+WangYuli <wangyuli@aosc.io> <wangyl5933@chinaunicom.cn>
+WangYuli <wangyuli@aosc.io> <wangyuli@deepin.org>
+WangYuli <wangyuli@aosc.io> <wangyuli@uniontech.com>
 Weiwen Hu <huweiwen@linux.alibaba.com> <sehuww@mail.scut.edu.cn>
 WeiXiong Liao <gmpy.liaowx@gmail.com> <liaoweixiong@allwinnertech.com>
 Wen Gong <quic_wgong@quicinc.com> <wgong@codeaurora.org>
-- 
2.48.1


