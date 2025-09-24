Return-Path: <linux-kernel+bounces-830198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92EB9908C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE3A19C430C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994D42D592A;
	Wed, 24 Sep 2025 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HXyajomZ"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F9285050
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704832; cv=none; b=XOWdargGAXtWGky5cBbNP7v2fx0tIyxDQm2SAYACoq8MY1GBVlP6UeNgbwa/8pvEzkhNPaW39qwA2ucVsm4CQxcKxwBwYAgnTeO87y9P5oH0QJjvkw0xp9YXCTjJMZWFASRvk3Na/vfAp6AxAs+y553DJe/uGtiMfkXrHfDvsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704832; c=relaxed/simple;
	bh=bQ0Y5BJrBIMtqOf4nS8BxFJArA/uaB3e3WHg0W76xAc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Bd8gORbaONAdVTj5fNeozVqEdA/B2wZbZ6hS0KCuajx2cNnA7LonK8U4mAtqjzaFOf5ZnTRGzhFMjaMCs6B5ea/M2qIkPaR5Ax5zbtJk3vtZQVdJiVsKAKqxNCXOuNdiJKaN18Drb/N7nCh3UTPaLXtEutC+c4C3ypeMpmBQytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HXyajomZ; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758704823; bh=xAeeEVs4WChmaF+32tw8knZOFXiVYx5VdP7Qx6Dy/Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HXyajomZOI6tKoOAcsa+qrrtQSdOxliglEP6VQm951WiGo5J4hupk5a36THU8Aj0p
	 Wd0cDwzoQBXS2/6EszU5e9bsryMaGT3CorVICN5j8fy1AoP8LvaBFEjWFR1k5W7cNj
	 4340aZWcTMrX2BeW7wHL7sYCWcJNVcM+hLr+a0yA=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id 16E17291; Wed, 24 Sep 2025 17:05:46 +0800
X-QQ-mid: xmsmtpt1758704746tdvx7p767
Message-ID: <tencent_364B6C75BD77B966CC3C1337A0968C36A609@qq.com>
X-QQ-XMAILINFO: Ms5xyImz3IR/JpVpeFrcgs3oeukw3yrIOPh1HeK1fjW/nu5DrhomlK2blG4zZt
	 5Xzik7ywEoYrZUmE+BGzyMiMtfjmeS6yJkOP3EMYIS1FnssF7bzdYs8IIBYdxiku7oxZEWArsh74
	 +IbZ3Hna3F1Rj0uErhoioMITyzcBkk7Uc2ikbrcdytGzeuO08QLGbBsEjEYM/hKtlrsRXKxxGOB4
	 KfQOUM6Q6mgCzRYHndNbd+99joLfSSx9l6eTwleqC+u87uKIg4DqKii3T9JZUkfnzgx1aqjGSH7P
	 cKJ9Ax82qMJfGm706i5T3CBhENkAOMbXxCC/BHnBpDGEOJLTM8YR2Mdz5tuT1IpRMm64uSALvJxZ
	 myA3cZl9oS7Uo/a+7MojD3oe/STHYZ77XBE24LGYsMZyNApx4HB4jdMQiHq5r2K9HAGZd+5hTUTA
	 7O+L+MccWt5OL4h4Ae5aN7pzPYkL0KZC+hIfsjusODTOyt+esAJKtESNcW+wGx8YguyqorjCSypx
	 WBXseVSiOTfjmSZLv/2G1VvVC6C3wEj7yZC+Ytbc51RO7t0ZyqasK0oxIf+v+tykGXK+fLMXinLs
	 Age/9J2l7kIgPBv+ez0EPTB2Nr32QV2t5jSRYgU6lCjmTmG6MdbbdKu0chl5C02+C0jfp4rX8bb5
	 4KRn30zGswK+aYmLgpcahA0DSdHpKTCK8VWU25IgZY2BdK/Xx/RW7FcR+I66KZaXr18OURJ8/GJA
	 vRoyXx5wim22eJ7e0LErrYFSAw1HB4etqgwaM8Lfd1Rs+3PmlcnamuSxrmY6+e4cyQuUikkT5zcD
	 6aLpTry+wI1immdOVr1leqSTosA/Bp5eNWu7B+KmALBMn0t9YStCF8PrqquqI5S/mtpXrq3JyNQZ
	 PE/Kr+zeYL1/dsiEpwKh5sC/bp71MolG1Kg/FR2L+kIWAMpHwAzmBmDAcpBCbpW9Zfno/EH70MSg
	 2d9GdYmd0rngbXRvS0LQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING: bad unlock balance in namespace_unlock
Date: Wed, 24 Sep 2025 17:05:45 +0800
X-OQ-MSGID: <20250924090544.1419047-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68d3a9d3.a70a0220.4f78.0017.GAE@google.com>
References: <68d3a9d3.a70a0220.4f78.0017.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/namespace.c b/fs/namespace.c
index ac1aedafe05e..c22febeda1ac 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4134,7 +4134,6 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		emptied_ns = new_ns;
-		namespace_unlock();
 		return ERR_CAST(new);
 	}
 	if (user_ns != ns->user_ns) {


