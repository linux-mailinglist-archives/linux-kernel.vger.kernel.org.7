Return-Path: <linux-kernel+bounces-854246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FE9BDDE80
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAAE34F75DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A77E31B817;
	Wed, 15 Oct 2025 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cKDk7vU6"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C03B31961C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522702; cv=none; b=Us9EUPwXSTlnLOOanHQIoY3GjotBOvqmMoXWUL3svQzrr4GVIoIJvYXgPvzVM8oeKeI8IQNAvEPk8/pBCvbA6233tfyNPrgYgaG5FeaTrm5qNGX9oCMbikVw9rJuxjpQgYhTnO2392CjYab8QhS7Jf9rxhwf4L9hWrwT4Kfyqgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522702; c=relaxed/simple;
	bh=u9b8lQWDWi4borJH07FOiSYt57nMAH9veqhXc/w4Q3w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Wn3ChHR5nIq/EfsgYYXTcYCM1Jp3nEYPkSTT+NfSmuuvuyau7FVH9LlKZV/meRZzDuFf3yLssia6iKqA9jqzR6Dm9NwGog8wVTFUj5fWocqNP1O6opytUyOw232iVny1FE5attMJ5xHZb2DsszQ7ENZ6y4JhfYMALP4P0DpPyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cKDk7vU6; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760522389; bh=N4lziAz0p8/npj+8XxDM6gQAxJFJVrwubEq800Q2rZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cKDk7vU6fBzdwlecVF+aGhoSinnzDeaQgdkLd7pxecks33/d8zdNxjJ21iC9nstbn
	 mNPYPUry2OGaNdG0h7KhcO/r1jzgDTv6pNkbMB1iD6e/J5BvKEcLbL3LVH7fi4kzI3
	 t7iEPGDFMhG/NJ2IOhtOEL8AMQloAKU+4cDFyn84=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id EEF09E46; Wed, 15 Oct 2025 17:59:47 +0800
X-QQ-mid: xmsmtpt1760522387tqr846sxi
Message-ID: <tencent_9FC786C5D2D3067449AEEED16EE6CC8BA706@qq.com>
X-QQ-XMAILINFO: MFZ9kh0LMtuHRtdv7MGfJoe/TmjeMUc1OD1hTSGeoObME/8KsPDRON2Z0sgLP6
	 nkCJHuHuuaoZpd8agk82gu0R8isGlQM+EiRWspWVG33u7hgQU5yf03HyrHSL0EwPUJDpPEy+6j9f
	 yHicbvRvlU2GVDCV1s9qitmHRm2CIAy63RX90WDP0YmMyZAL0M3EN4H9mLip+VnD2pNMCgn9FVyu
	 3J1oqGpyjFiJn/G6iQo09gFHo8e7vr5SzAgIOVJqXnkaJX0NVnN1kgCsbPQVfytBZwpfBd+lf0jm
	 QFmq0TcSxkQ9r+1otqZn8sV6CQJkH1INgAU3xE8wk0z752h7jMHbP4CUeUDq+iugDBgmMAuX58gU
	 4zt971z3iiBK9ATZsnDkSGstQ/hsleb61QZ1yPHzPpahhfErzc4XTwoFcpDljYmUS+64pusszbsQ
	 HrGwhfP74lnrTcdMJFbmJzgnp/YtGY/0KEXo5QdLFQIvCX4lodDz0iMaM2zZaHsVX7ckwUR5iTV5
	 hdTWipU/fg0hU37DdxykwnmVnsQoFH1RZtDnzzxeBhB0O2hB2pz4V77nO95GYhLb/Mw6/heuOxzF
	 yBXsNuv6GX0kfkBffwcXJVL+9vToHD59BuM130iAg3P86U5aDfvFIixIwii/FdocMFJ83bl/b7uM
	 6YaMC1wiP3dlUVQakvhDLb+f+NrsQbivC9187wyNAgFxq9rc7vI+UotReiLj3zIK7PLECnKyPUi/
	 y7vv+v84qbGdxAETSyZ626wS6E+X1HB3He6OmyJCmOqJzLkY4cThg6D/kI8Iyn4BGP1wxFyupL1x
	 GSDbkMJO0RD0jzUqTQLRDDxC9VNcAJF1pJ72in8o8pUB2PD/Y1SmT773Upb2mUF4thCBJqqhHetg
	 lfnkAyN4PdOrte1ewkzRKfbo5YnmOxgPVrPbayy6lGkikp83tJuvqa3+XsUBVWe5wtQ0C+bkOXOP
	 0+KXB6hRmxhdh9KEovP1LZHCvCpf2WveXtqoJl9G/IZ4W1XD1vwb587ETHo6NX6mEpmmWSeke+K2
	 T0uebggkzO1sVX1KKbcfRl9jua4p+J3YMA1CF08g==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+6b156e132970e550194c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next V2] gfs2: Add sanity check for sd_jdesc
Date: Wed, 15 Oct 2025 17:59:47 +0800
X-OQ-MSGID: <20251015095946.1091541-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <tencent_9C66663DC537949618361A4B5E750576B309@qq.com>
References: <tencent_9C66663DC537949618361A4B5E750576B309@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Asynchronous withdraw, when sd_withdraw_work is scheduled later than
put_super, will set sd_jdesc to NULL when clearing all journal index
information, triggering the syz report null-ptr-deref.

Reported-by: syzbot+6b156e132970e550194c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6b156e132970e550194c
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: Updated the issue reported in the comments

 fs/gfs2/log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 8312cd2cdae4..433a3a11a2f5 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -427,7 +427,8 @@ static void ail2_empty(struct gfs2_sbd *sdp, unsigned int new_tail)
  */
 
 bool gfs2_log_is_empty(struct gfs2_sbd *sdp) {
-	return atomic_read(&sdp->sd_log_blks_free) == sdp->sd_jdesc->jd_blocks;
+	return sdp->sd_jdesc &&
+	       atomic_read(&sdp->sd_log_blks_free) == sdp->sd_jdesc->jd_blocks;
 }
 
 static bool __gfs2_log_try_reserve_revokes(struct gfs2_sbd *sdp, unsigned int revokes)
-- 
2.43.0


