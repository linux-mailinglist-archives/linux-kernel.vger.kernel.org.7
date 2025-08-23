Return-Path: <linux-kernel+bounces-782871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5136B32631
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5B27BCBFD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271D81A9F94;
	Sat, 23 Aug 2025 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mCd9eTxX"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C419E81F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755912440; cv=none; b=OXOhDOxpsTQ/EjvWnPC7I4nlHzafqoPS5+bbLt28fiuqngHeLTLRt/emhUp28zfnuBJi3Qg47wFQeM9meyTVC05cVCMTy4bf3B1mTBA0Yk8zdoYaLBCAB1bCdgH1obVEk8DxtMdNFEXU2H1KI7l5IvuYhWIAvvPrp4SoaFcTU6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755912440; c=relaxed/simple;
	bh=ePS1z9Cg0u7BU5CgKH5niME0oZBleFqkAkEUWXcX2vk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ucrpaVOoWJSfJz2fO0YqNJg8T8llDRwf0a5YjEKDOCzQTg3wDmNQNE4akROXkIXBp2O3Hsp/LBDPBijEIZZL07b2awNxbobIEwr4uJ0jU7P90Y5KS4hvJrql6kspfY8gWO5vIsDiEfmNq/Oys9cr5r8LoTaktWFrWVtjfUOORKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mCd9eTxX; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755912135; bh=0/bIU6yybnhqndaHKGo7JyITC+t9yDHuF/Grq7MssR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mCd9eTxXQWZpQq40yAyUR+6xgyGgZOqigvS5uWOH3wT4Jkwsgf4qsJk7UfpslRbKS
	 DvKcJ4d7XKs836od43I3L186OKqbkJnH0SrU/EyamTOrznMk7rDEcpA6rix+l+58ds
	 YmcTeM/k4srtsRCf8wH0qoQvfY1aJkMvU8QhkHvk=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc13-1.qq.com (NewEsmtp) with SMTP
	id 58DA884F; Sat, 23 Aug 2025 09:22:13 +0800
X-QQ-mid: xmsmtpt1755912133tepz2c10d
Message-ID: <tencent_2FB36AA36D497403B5E44E9764F76BA6DC05@qq.com>
X-QQ-XMAILINFO: OPa5+/AT2oWtB2v0iGAqiDJBw8+8EWvtGCufOvaGwlzRJuMwmsffGo+BoqIGWH
	 b4J88GyoqEDFwSdnV/Xi1Qu7G1TpyUNDcbQQzaf+BZtYsSVQin0Zkk0CiTo+hYFwTDJ1IXL5ARDE
	 dY1QHDKSxerN40nNJflXHS9EZxUPXK0pLlp+VgCZrgF+X+LrhNEdNDr2Wj4/sgATDhFPpWMbwMfk
	 rCRhZSH+r4ltYzOLiNGKDIpTWSyG20mObwURpHH8qMPe9e2L5+sU2dN/5HxRogMEUD6s6C0SYOII
	 PTKLMJBBZ/WzceBJ8BzAfjPJUf+/YrKEPzXamdWbuI8zCf2PbbO0cjl+vYybloQxdx0q8dcsVrrm
	 Oezn9eJuSEKwMKfB3EaH5q9SHZggAhTQUPILHlCfaLPK0uClrmeVptiOnVnjUg01KxFfo1g1rHKF
	 1UOlsQQxotMcy0hg37mOdLpwLpi3O4spHXBsJDP8u7+BEccDcuYIqj9MpBP4chmgn/ck7Mkm7fl4
	 BkNszVQONZXR7JISkG0LLwwey/U5tKYPwbRg6+L/EgpZtrQw2PlXkA4SShQEO/pDNLfSaJCn4oL8
	 zW0OsSXdFpAKQCQsY2bmRiMqdCDauTeWDH/oOHEZy7flAocLRIx5XV/djKzALjoRSaeduW9qasw8
	 LBB2YpK5V4+bvzg543EQIqYDHmzhH+GP1ID7y5zBzwZHnaNOPlPuvfMbDguez77khBxz1ge8s7gf
	 lyhbZ8bQkmGMDh9iaMatdUsZNrr+xXtoFECcVkczva1fxeZqhPeCfRE/fnapzHtXn6KYoAuudLoK
	 zd5JvNkJWDM4sJtZbzNkSWTLkPWH9hHacsAMavoOLkiFDoi/qwwMyoabdIfC1yHJKEy9ipVbd/Sp
	 7H1J9G3N9eq24SEE2/GizV6y0GU/RvAQ3ZZVL98gr//T+XR2xr7uNR83C+qBPKpaZNffLL8Vpj9w
	 L1w65QPlm8Wpax7RFpwWEbWElfnFrJtuqFMg5Xi8DFnjqc+IKuCXUiHNQNdtpmU8adT55fRzs=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in z_erofs_decompress_queue
Date: Sat, 23 Aug 2025 09:22:11 +0800
X-OQ-MSGID: <20250823012211.2624793-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
References: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 2d73297003d2..085fa0685a57 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -762,6 +762,10 @@ static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 	pcl->from_meta = map->m_flags & EROFS_MAP_META;
 	fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 
+	if (pcl->algorithmformat >= Z_EROFS_COMPRESSION_MAX) {
+		err = -EINVAL;
+		goto out;
+	}
 	/*
 	 * lock all primary followed works before visible to others
 	 * and mutex_trylock *never* fails for a new pcluster.
@@ -796,6 +800,7 @@ static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 
 err_out:
 	mutex_unlock(&pcl->lock);
+out:
 	z_erofs_free_pcluster(pcl);
 	return err;
 }


