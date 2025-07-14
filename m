Return-Path: <linux-kernel+bounces-730164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 681EEB040E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8431883D32
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469BF254874;
	Mon, 14 Jul 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="RA+LIWrj"
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3CD1FDA94;
	Mon, 14 Jul 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501797; cv=none; b=bS4/HV645GbSBzBmTbbFyZr5KysRubDHGx1VWMK2lrrIb9ImC1WOkv24fyd+zxznSOzC6hiRWGxwpGuof2f98iovru42U+mutRnItZJDz+bgCSC+ZhXWYAM8aBAv6T7/OIKTwFu4ZZljGWqoEeKENbXr/c3xUjF5nc1jRcUP/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501797; c=relaxed/simple;
	bh=A7WlxUnNpImSsGbjOxRFg3xdaaOHXi5Txv+vIAdoa4w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=egXZQgPGL9B6rhAHVKq/ZD3YPQF6/n1XfohKZUzmoRbfBU8HzZOT5EelyztkHLjx49nnqzEndQDRIF2JZJgRU/HxU1kaS0QWAPfTvjkDaRbaaVQXSBBHsecT4mQTKaTn85/fGu4TObsZd+Cx3sMp3kbHxQh6dKQYB/Lke9HxHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RA+LIWrj; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=q4CbpbmpjajkKumLluX7ElNNQCOsTWVd86WNCYP+jzU=; b=RA+LIWrj5gK1iIfxmZJnx6LQAo
	6L4MeokPWC2pjpUOsMQ3bK55HP+OEXG/F2vc3ONWO//UItrUwSaSuTxXSKcZnGQrcYTxE55eDzZvV
	9DLKnrrDEP/aMb0hGW+8I55CH1NU/+NuWcYnKeq3cODqIP34sSZG0z8/Rp+lpmitJtCc5ySjKe5/I
	QV6mulaccXqQWMVvlg/7LOC1XCpX9MZ3IOuwcgM/60rmtTKjHXnhoFRES4QDdQ/VkwJLet5F208Mu
	NS31bpatkhYKkgfkyVC+/9HmkvjJhR37kXyKC4jXmTki2EVccYq51hY77nixR9OXxMOsYBO3fvybO
	EfahUn5w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <weepingclown@debian.org>)
	id 1ubJlx-00173W-Mm; Mon, 14 Jul 2025 14:03:13 +0000
Date: Mon, 14 Jul 2025 19:33:10 +0530
From: Ananthu C V <weepingclown@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht, koike@igalia.com,
	weepingclown@debian.org
Cc: ~lkcamp/patches@lists.sr.ht, koike@igalia.com,
	Ananthu C V <weepingclown@debian.org>
Subject: [PATCH] staging: rtl8723bs: remove unncessary multiple blank lines
Message-ID: <20250714140307.51506-1-weepingclown@debian.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht, koike@igalia.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.39.5
Organization: The Debian Project
X-Debian-User: weepingclown

fix "CHECK: Please don't use multiple blank lines" in
drivers/staging/rtl8723bs/os_dep/os_intfs.c:102

Signed-off-by: Ananthu C V <weepingclown@debian.org>
---
Hello! This is my first patch, any feedback is very much
appreciated!
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index d4dc169e19d7..7b53a32094bc 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -99,8 +99,6 @@ MODULE_PARM_DESC(rtw_ant_num, "Antenna number setting");
 static int rtw_antdiv_cfg = 1; /*  0:OFF , 1:ON, 2:decide by Efuse config */
 static int rtw_antdiv_type; /* 0:decide by efuse  1: for 88EE, 1Tx and 1RxCG are diversity.(2 Ant with SPDT), 2:  for 88EE, 1Tx and 2Rx are diversity.(2 Ant, Tx and RxCG are both on aux port, RxCS is on main port), 3: for 88EE, 1Tx and 1RxCG are fixed.(1Ant, Tx and RxCG are both on aux port) */
 
-
-
 static int rtw_hw_wps_pbc;
 
 int rtw_mc2u_disable;
-- 
2.39.5


