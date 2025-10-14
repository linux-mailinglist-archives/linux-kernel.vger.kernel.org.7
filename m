Return-Path: <linux-kernel+bounces-851758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B14D3BD730D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5D8D4F7146
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE313074A7;
	Tue, 14 Oct 2025 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="edP/0Snr"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2982334BA2D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760413018; cv=none; b=UyW9VUrwHwwqw1muuvfFAKELV17VvjI70qmiI1lAK5JpfVXVyggzCLIC0CVZAn9W9iIvakeTJ6P+Seoh0mHIxSeRlV+nElUHBN6PeXKJNfPpU44jXr5jUsv5guiwc6Me8qNjv7fNT2ww+u5CcjY9f41gGltn5w3WV/n3fOaOOxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760413018; c=relaxed/simple;
	bh=B0rIQE7llTcZDp43jHi31hACOl6LA9PS+tzpJ8GfEKM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=asqyCqqS6KmwfPH3WCVOCNsg0a35QStjgKziJYmmy1lvSAg5ipf11r47WO1fj+uwsEYKPFEij1RieUSjONV2BalvkfitNJ/s+arkkeMlAM9G4oI6q8wksarlooC2Wxvnp/dkk+SATp2d13zG28Nb0uRRkfZu7jlRm8Vn9jKDwKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=edP/0Snr; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760413012; bh=h9YVIEH/p2m4HKPSlDARTdajctS7WXTUie/SA/ALRB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=edP/0SnrFGxaUWEpVa8CDQkpc4M7Hj8RiFdxlYbg00Vig4X+sydNOPLbslr8BmyXs
	 9pvThuErPfQ9ZGN8uWZrl9SiCQCU4TKLOTx0EWPS4P34uuKLfds2CVhADe1O4JGa6u
	 Udcl8nUXdDEAr3e9cyw0AigpM9wIPwK/whZ+XgLI=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 932A52F7; Tue, 14 Oct 2025 11:36:50 +0800
X-QQ-mid: xmsmtpt1760413010t5o7jwcjw
Message-ID: <tencent_5962EC9ACC0878E66EC82C456C109494EA0A@qq.com>
X-QQ-XMAILINFO: NuGpsYW8pZ+ARlRAfUYwvDgzRxoJ8dzp4l0lYLuCAUpw5m7xL39FfFyi8X5l1f
	 yJ/Y1gmBeGB1ZKsqhbYBdrhu7IUXJX+IbXT7RfTUAfzetYTMtDed0oT+rHettbyJ5igJ2N2RXlNu
	 ZZcgIUiDgXHd/Nor3cT3sTJThkOCE7RImuCsMeEuMJjlHujqxnESCyHeiBZqsHEfrCfp5WaFQSJI
	 q2pkbnWU8pdiJpIfskf+C4S7+r45KJ6Q3lAIH4+lTYStTgUaiftBrHTBl4vnENC766/t0G+moUul
	 8V2Lbw/tPAJb2XUpFtPeHUVmcTuN51ZJn+eCmMck7YS0OIBPbx+tQD43zdZzNhLGSpEZzlFjm9I2
	 ibWkez9OeCbEFlm6ylkjfEgGOCxL7B0h2VHakYbJ/7ormAFHfuPLYfEPiYK6w3X8XS5thoO25ilV
	 8FEAXXPY4fSSdQvVJ3SKPwj2jtdtKyuRYBQr2BIXazTayXnYrDqwNoOWfXWR6HSvMtpBCBXP+ees
	 VCQOKK1IhYCY1/oXo6ls56N0inEO2RWDPaoz9BvBCVNeRzyZ250dNX9RIgeJfcdQ8TlZ0Q4uxhJx
	 giiy+BCSfurwsWAfd9wZSr7wSoMyYPzIIzadAFvaam6Dy/u+bKIPpJCEdAS66CWQ6S0QR8kdQL7l
	 IPDD5C4kayiHnPAebkvFa1tJyDoegtxyXcSiMCgEFzIUN8uH2iadvTlT0N7P5hG3WK3pIltZu/Ym
	 LGfgUqMAS+DKwWO8liV7m9pXCRTyxKrxHD7w2ffdPXP6iBxbdquRkxQWD5nH6JVmGF/VzOqbIc55
	 VPijYR/xZyhGopCzAIXR7/Y1G3wdcOZMUoowJimVt7W9gCSIpd2V5ysFsyw4RcZAfnQ5A6sj6QUW
	 qLS//fqXGYoOm0PimasGzg788JmyMEbaToCeuuIZU5YFZ5fL62HI6Vc0kz+0pDyoo1YODNKkLMwS
	 LwteRluFtuzsxHDKntuSRf9JqeXdazNYpsrn4oi6gN08Q3PkkOsA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+29934710e7fb9cb71f33@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] KASAN: stack-out-of-bounds Read in exfat_nls_to_ucs2
Date: Tue, 14 Oct 2025 11:36:51 +0800
X-OQ-MSGID: <20251014033650.4168319-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68ed75c7.050a0220.91a22.01ee.GAE@google.com>
References: <68ed75c7.050a0220.91a22.01ee.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index f246cf439588..c4001e1c289d 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -509,8 +509,8 @@ static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned long ar
 static int exfat_ioctl_set_volume_label(struct super_block *sb,
 					unsigned long arg)
 {
-	int ret = 0, lossy;
-	char label[FSLABEL_MAX];
+	int ret = 0, lossy, len;
+	char label[FSLABEL_MAX] = {0};
 	struct exfat_uni_name uniname;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -519,9 +519,10 @@ static int exfat_ioctl_set_volume_label(struct super_block *sb,
 	if (copy_from_user(label, (char __user *)arg, FSLABEL_MAX))
 		return -EFAULT;
 
+	len = strnlen(label, FSLABEL_MAX);
 	memset(&uniname, 0, sizeof(uniname));
 	if (label[0]) {
-		ret = exfat_nls_to_utf16(sb, label, FSLABEL_MAX,
+		ret = exfat_nls_to_utf16(sb, label, len,
 					 &uniname, &lossy);
 		if (ret < 0)
 			return ret;


