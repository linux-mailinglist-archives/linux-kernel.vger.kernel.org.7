Return-Path: <linux-kernel+bounces-782852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4A0B32609
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F4F688FCC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7577B13EFE3;
	Sat, 23 Aug 2025 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aqPvsGjg"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7A2DF68
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755910444; cv=none; b=IIi4gnPANb6cntIOJEtvUsl6PGYvbjKJt8ndFUux/GbCeVqcoEw7J5BgEcUq9SdLitU9q5aDlwRYOAH9W+KwuwUkSlAEoE3kUHE1mSWTEU/SumZp0cEE2qPHXJM+tDbn2BGM9/6Gb4TBOjcyaBPUVUmLVl/ZzNAObUrzeKcCKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755910444; c=relaxed/simple;
	bh=lovTvfo7AG4MLzQzwwRpAlgVo+bEghoWziyvz0qc58Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QGG021kJ4ywd5GjBODkd3VL4HC6BRRWDkUrStq99UD7bk+A00JRfvZoPsPpc1M3AGgF4xQeziSSk/R6oBnAgyoXIAyc8/icE/d5fCGC+kpgxiJdi0byggESA6b3cEc7fMfOfWpdwe+NJWHh/dgr6t+jBava0fpq0lEO6OlYb9ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aqPvsGjg; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755910438; bh=vH5IURM0DMtsJBGcbVf7Cjs7RVT2vu+dky6ZeaLAMXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aqPvsGjglBRDAytLeXs9LXOsvtcerIwi400ix/rONRGiPkyTFrBf9vcQJdWvBVAgB
	 TU31/14rXvy/orrVgRMBnGF2H0pyBfJ68K37QtXXdbLI5Y7807gxf+w9KG3ltRgV8X
	 Ne9/IaXfdzq2ZV2XiJzPULqLqa8kMb5O9wid52Yw=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id D77B1072; Sat, 23 Aug 2025 08:53:55 +0800
X-QQ-mid: xmsmtpt1755910435tuv4mku00
Message-ID: <tencent_2BECEECECC7B926C782CC96EB897BCE8DE0A@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GPuPwqF7rm7S9HiLwk49AWa06qpoXh86nHBf5MDzTMx9twUuZtg
	 mQz5gcuQqQipU+BttVQKIJhwwKR/jhwBBNy04DW1VsNlhXzIxPOELcUXXmNj1RPhD6p26rcLP3JV
	 KBDRyWapHDZ0acI8Nkw6AkhEqMI7OYC+TWjXcLFNLYwr+mugBN2Ke+gzlllbTydNjJFXq+YO6eQJ
	 QhAfmdHezaQep8RVNre59iHZ5+f0jbxefZq1J3J9exkufPyhSjjgPXYF/4UWUysjWKSb0LTNbwLc
	 wakET1is/BDYDOGQMF8g4WASlLRzdQxSWflqCZHw1P4N7g04nq+6WnU7Tyjrhgh45D3O7SNryTAq
	 Keg85pf+6bQHHjTWSIknKrsSXWFKkRR1A+Qnda1gsJ8jKSMB5PPsuHCtS0/LjyQzaChJRRerVZMW
	 xNpXeOTBITN6CH1auhHP5leWwlhu9NWRF37mZhXtHG+YSJqUmqssp/w9cgx+Gfe06ezPA4c5xqKl
	 uJPfWVQxp0u6lSugswcM28QjYT3UEeM1csdjyXtEGBkjkVlWComWiQHaAedqEtxA+rH/SK/WZNrO
	 yvtbGzPMMK4KmWTcu7Oc/+qmPe+ErZPXxBgKU16/dO/hK1/DHWHRJD4Oyo1oczWlfyx4dyNCO+EF
	 YBYLR+hMy3wk3IvMZs47dtUZPpmW7CCcTRgJk7Qx+a7ZemeOdjY85CZnbKWo1pLPlp6CIYoAKRMm
	 NKF/5fa9Z+16cJr101wCU1exQud0tlZRYkma0FwE6Ya9W3oHRg5b3SDxF/edMptS7fqAIl8+EvPG
	 5PArDBttSsKv8HCyqTORQYjpQPLeCtlno1xRJiH8KYjdxidS/bvqF7WxN7lKV+0tEwqr6USP4x/y
	 3Vsw2ecn1jImDDi6KSyTNrsFL0o06ln7370D+6950Wu5Rbx25VYkfnZ1zOANItWyDLk2/+PkLHTg
	 iQcY7qYCurI5X/hk1QxHE6qiyV1B1aF10QqAeFov9Zq6jKv4pFQ40dfExahReE
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in z_erofs_decompress_queue
Date: Sat, 23 Aug 2025 08:53:53 +0800
X-OQ-MSGID: <20250823005353.2602746-2-eadavis@qq.com>
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
index 2d73297003d2..11f59bc2db8e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -752,6 +752,10 @@ static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 
 	lockref_init(&pcl->lockref); /* one ref for this request */
 	pcl->algorithmformat = map->m_algorithmformat;
+	if (pcl->algorithmformat >= Z_EROFS_COMPRESSION_MAX) {
+		err = -EINVAL;
+		goto out;
+	}
 	pcl->pclustersize = map->m_plen;
 	pcl->length = 0;
 	pcl->partial = true;
@@ -796,6 +800,7 @@ static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 
 err_out:
 	mutex_unlock(&pcl->lock);
+out:
 	z_erofs_free_pcluster(pcl);
 	return err;
 }


