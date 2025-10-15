Return-Path: <linux-kernel+bounces-854238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34639BDDE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725E7189AEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC8B31B830;
	Wed, 15 Oct 2025 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="g7yloEFy"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C4931B817
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522179; cv=none; b=i0jK0QJRue3YwKYMmqDWfQPGGQ2CenTJst7+S+9XQSSXcKCIiSdEHQIrhByEwWQjA2D+GTCg+PgFzoNP0FZAYbtJ/6r0YIdbqmejb315YmCgIf5nF8aHnMhTxLzvUV3ZfLVcgi2N5oCDMLV4CiBaL5g6tNdAD0MsOCVSoTlX88Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522179; c=relaxed/simple;
	bh=fxyDDrcO9pn7olDxpiCTCopAZDBbeoYN93O3f6FW5aI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KOxhTywySgYIhRm6gFt8JMMBVhUunnkiX8yjDPc+2HeCNjlRi6N74MS/sFYTNP0oOnKcb12zJ4M5gacm4g7hWXl3r68lQyMnt/HjVFvn4A+hOZ0zqlSNDrLHyt/qycJWLT98i5W3HRmTXxNUyt3e476v5W8prD5wsMUaC1a1Lb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=g7yloEFy; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760521866; bh=aDg6c7MF5+O7R9/B0Dm+vyOLVIhppol81MSIoJJGZgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g7yloEFy+ZD4Q3hWPHjsLHdVVslGALwW7UDj0+WEEoWMEmjLx+gjRSvND/BXRFICA
	 VkVAsRZk9+hLpSjiiLFhlslWcgfDZ6hRtNxdkTDlStynGo6dunF4jQetjzYS1dxdCV
	 iVLBFuzxQrVljq/+AxAAiwP6KTCRq4Bl+RMWfUVk=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id CC38F877; Wed, 15 Oct 2025 17:51:03 +0800
X-QQ-mid: xmsmtpt1760521863tp4b83bdv
Message-ID: <tencent_9C66663DC537949618361A4B5E750576B309@qq.com>
X-QQ-XMAILINFO: Me8mHstNM5a8VrVNG3vb3lZZqRj3BHXIM/ZPK3ztls2DaRGLD52+upsObXV4c/
	 ugrZLYAoHBA/3TtzSOPHN9FrdvcQQRLV0YgqqtkpiTxO8yswkrvxdLozbjHr8eJ/7hVO93TcGJAz
	 S+Z66UP5fyouAOt78C1hxwgRtuGH7H3yRLtLuM+aoUCbI8Ins147CoVtHEB6mn1XtSzZ4i3joX5h
	 zXDKJEhdRiVXOxrc/rFTszkRPSM/G5heJBJDvncNgOx/cr4e2NfdP1IBxS/8w7bf6d/kXxU3io2G
	 wRIZZ8CtWbFgO17BkqHJyqM502Rdm9BTYmhYpUhKq6j5Y054sEJyNNbYqHlv35DIMAzxWiT2Kzcm
	 55xd3chQaFdMKBasInQUSfXENxPAONSLwSXHKHjY/KwV6JX2z3stBGE7ne4HjLCvJsnVJiV797I0
	 60siex2E4nfy9K8TD1dSG1I3IB17y1yEQ8WXzj+zlJrjBZbvKwwLGmLSbK15cIbw0qLmeT/PbBPD
	 xIPHqbD3iBGkH1UcCWyVJWx2Mrd4aquClHihOSzOKNa8/AeVhkOiVxavUKZEEOP7sKIfFkG7WRnb
	 pR4JTHFh3zpxCijjOV6i6uQKy4dIGSIbZcKel1S5RnOdtFEsGCMnOAwm3LAuHvj19KWKMGQ3gkdX
	 FsczoIgEOOJ2TjMAlp6eBfD0lIzpa3lphiCutwi2coflbZ5YXg06uc9bBCn1Z7g/MKVqMPLC264O
	 kFlWBp3Eeo7wOwU9sH33RsnlvhOj81yzEBGerI7nOAYXg1hOcK6xa0Uwnw8JwMpC9sEoIBvQa3EP
	 fNrvqqyj1Y0tAXKHBBnEYw5c3EWJD67iiYhce4H5Is7ZI/3shlEWi2i2ExRlvadRxld4ZMHy+5K7
	 U1hO8kt8wVbM0TtmVe2jBV7qB/IJ0n9yV6c4VRhAU+M//5UJhi8z0jAnQvZf7Ya11qQLlb/OmDTT
	 iVGOqXgJ5RDsNy2KFrz4uas3fsTcLNraAraYKWCGEAT847HvUku65Lq9XVq0w7
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6b156e132970e550194c@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] gfs2: Add sanity check for sd_jdesc
Date: Wed, 15 Oct 2025 17:51:04 +0800
X-OQ-MSGID: <20251015095103.1086226-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68ef030a.050a0220.91a22.022a.GAE@google.com>
References: <68ef030a.050a0220.91a22.022a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Asynchronous withdraw, when sd_withdraw_work is scheduled later than
put_super, will set sd_jdesc to NULL when clearing all journal index
information, triggering the syz report uaf.

Reported-by: syzbot+6b156e132970e550194c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6b156e132970e550194c
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
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


