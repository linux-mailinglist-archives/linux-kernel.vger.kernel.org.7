Return-Path: <linux-kernel+bounces-747427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2606CB133B8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE5F18964D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0432153D3;
	Mon, 28 Jul 2025 04:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj2+sKOo"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C81586C8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 04:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753677086; cv=none; b=kngVK+9TGBOF38A8N0u4Yqr4m9wU1cd8EeDI+8poqQ44ZAP8VWzlTKr56eeHH0icyh4uR11z8Fxt/2QN2itMcXkHG46N6oFjCvYNNDzXIcwgln17EoZLeLWWOd6XfgZxW0ZAKzXKszDIVCoSOlVQ37LKStaL3q2ve9MPcT/6YDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753677086; c=relaxed/simple;
	bh=tDWQTnaOByEBiSkO3FvdLGPrQKPyATsUtvQ/bjuirZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nos9Az+C6Gn75RwMm2ffdLMCwIwRXInXgeKIF67J42zahgubi03BP6exW7cWmYwk5T/XA4vNm+KCPZPHfnabcuucb4WSQvAJLbXdc3DavOYXwu4m6msDKZaSim8ycTYxlM8jA+g5Vq0CyCIevACQoO9rP6M8v1mIdAOjaPzlsJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cj2+sKOo; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab3802455eso50430071cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 21:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753677084; x=1754281884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vXztVcGyYhcXEUuh9ymdxD2mjy3D+/Xbd03h6w6BTCI=;
        b=cj2+sKOoB59+8UR5gHLWYEwq/N6TTkSk8SwY//2tvBMrKsQk1KiCsd5xl0I/5NKZ/6
         PFM2Ou9I7iLijgrlZH6MDPIEF8DjnuFUTmSDQzxDz26QyLyVeWubTE93SONAd0wwZlPj
         zk8Ee4IiOLnn7kJHQVXB8Jqbo5o7lCoCPvjtYrFOQPyARiX70r9wZ8o+hxuFzTwOqfpp
         vo+v3Ws3vO2P1gVnrRkQWSE5yk4XPmo/URzAa/yOr0oOoLElgRg2ZRh8JuI5PphcYzDa
         qrY3desD3fmHGxH7n+NCQK2JqtCNhfyrZQNMjG2YAb9Wfsrpyhszs/RfNj/GbUvQ1YuB
         crtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753677084; x=1754281884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXztVcGyYhcXEUuh9ymdxD2mjy3D+/Xbd03h6w6BTCI=;
        b=qYvZuPK6VuZx0b6ledSbvjoud/Vxj+E+Gyoefn36C39fkcBjX3vSUp5Ov8CoiJsi0h
         R3u8ytwBLbaGhnsdvQ4rJ9euWq1sjsNXj8WSACH4lrjJ/G1Hq4yEmDCUOkK1j39tSU8S
         d5rBS10ARvmWCFBPVc5gwq/2BXYMi035vTd5757eef3LSvSJwMbiqGT69uswwD7pgV9o
         QKy4tCeHF9STfrcHxiFxgjRIh22dmqvTnIIRnVVRmoGVXf5aYuWgLHAud8N+VVz3VNF6
         AI7va7y7Rt5amg6E/5iurlOv8vTpVdu7nBy4M+8ZO+g3BpOj0SOlPIeXgREkWV0ylOI+
         UOUg==
X-Forwarded-Encrypted: i=1; AJvYcCUBQ+JG7kk8jM8pSlqeaDSEZMkXixxWDSYgdNEE1f7QNZ74g8EVN+pdBQHDiHyChaxpkzJ1NnMcp9TZ4bY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8v0oatMrTkQvbC+FQYbGuvAteLoIIqa2UxNeT/AW99u+e47VB
	MJxPT96mhToe9X8x7IwzOWYJjQxmtMPJceKyrL3CinZ+wnWqWAnMsqM1
X-Gm-Gg: ASbGnctH/90Vccxe2fnnuIIBHOdrQ2tpFibgocyDzehMBOn05anfQg7epMbiAF/YQUN
	m5Kfoodid/r8j+fYxu/Mj6dBJ0yVOQdw5hm0BUIKss3IVLN85wzyzU1qpl5YQ0YnL6jP7kjAovb
	wfsUl8nivFbtR9malrFdDYXV3dU5nknreiTWk7SXeM5fChVF7F6CT0qwqM1XZblRZyhGMkx8G/E
	OkJGT3hEzpF3Q//aWepZ6IcbugkUZX9E7B+ch99ZVPkB0St/RvmnP02wnUS+sKPb41CGAJLxYft
	i7yMTOrMC1Zrv9bWvt7jL+lCuoRWLvztn111ol0wZTxrQcrjCUo0ubo57M3KWzp4e35YM7IcEIm
	yssQpOCjPu7L2JZ7LhmKcgYYvqsjpIXlflbwzglLh6G9RPYW0pAo=
X-Google-Smtp-Source: AGHT+IEuaj/hPi4fHDRk7jCauFbtFmTNDcAzE+XKZj1VAfzLfZ0YnCWDMLexJ4CVO8K3LbusoaxMXQ==
X-Received: by 2002:ac8:5ac2:0:b0:4ab:83e5:f2a5 with SMTP id d75a77b69052e-4ae8ee0ee5bmr124885601cf.6.1753677083436;
        Sun, 27 Jul 2025 21:31:23 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9963b704sm29720841cf.34.2025.07.27.21.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 21:31:23 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v1 03/20] staging: rtl8723bs: add blank line between rtw_roaming() and _rtw_roaming()
Date: Mon, 28 Jul 2025 04:30:55 +0000
Message-Id: <20250728043055.421820-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a blank line after the definition of rtw_roaming() to separate it from
the following function (_rtw_roaming()), improving readability and matching
kernel coding style guidelines.

No functional changes.

Identified using checkpatch.pl.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>

v1: Addressed review comments from Markus Elfring on changing the 
    description of the patch regarding readability and separation between 
    function definitions.
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 24e505111f1f..b1a427a655ef 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2449,6 +2449,7 @@ void rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	_rtw_roaming(padapter, tgt_network);
 	spin_unlock_bh(&pmlmepriv->lock);
 }
+
 void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.39.5


