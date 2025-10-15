Return-Path: <linux-kernel+bounces-853834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B30C3BDCB46
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A70794F39CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633AE3101BC;
	Wed, 15 Oct 2025 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yJ57L2gO"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C344F30F93D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509401; cv=none; b=aEeNrJKECsd4Hr2M/Fu9zH09FJJz8iO2GLzkw2Au/egB4g0h+V8IOs1cn/oHLTP7MzGM+5Gcl5/n+60hhU8nFyPLx9V3EuKP8p+rr7HJM3IxueAYg4qDI27NqRJ4DE5qUbj01U8z6e0tqBPX73AbpeBmaQFV4WomYoSSMDPe7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509401; c=relaxed/simple;
	bh=3TbXyEjbB5x4IoiU+lyj/IH290GMBCHYGGlmj4kiUZI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=R3rvR1MDUATYtPMf281YInxbdbbQ/hvL4TtPreY/0m/YDCTlgdX0iuR+Ol3fQsGyTiOVzkhZNnp4++OCxuX4Sao93QbUhR/ct8hdjYUniz2lp4kiPN0C8cBwaNnP7U0tq0eQy8x/P46nlY+N60Qboz9J814kM0sb8ACrNBIfEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yJ57L2gO; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760509084; bh=uTmxsU4FCYCxUxnqtxzx1iTBk4dc74XIANCYzN6ezh4=;
	h=From:To:Cc:Subject:Date;
	b=yJ57L2gOkJJ3EQbnmOgskVK0ZwRW9a0RZBCAwp7zK+86PTvOOIrv3xXjoT2LFjYK0
	 P//ogs5Xem5SuzA877f9TbvyMa29xAGA3FjNQv89umB6V9MYepgm3PaMFC8CnN2Qqt
	 mVtebu9HxI90nN9xKYRVPGiGfc7P+MN/C01z3fYk=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 4822B211; Wed, 15 Oct 2025 14:18:02 +0800
X-QQ-mid: xmsmtpt1760509082tmod51s2c
Message-ID: <tencent_2376993D9FC06A3616A4F981B3DE1C599607@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznB6TulpLGANsC5apCVrnCYoz7eHxXOi3H4mBnnewlVjXxDLPhF6
	 /xENGm+3hwSHpS4m7mRwS8s3GPhV4lkc6SOp3xPGedvyv3dtQQTbB22wKnQ35zUyRe3LPiGZWqQU
	 0ccxZjz354Lfb+Qh+rTz0xQBYsIxGmoIXKHOGGTKR580ahDTwDMZlnP4lowScQHdoumRfEUHUGXx
	 td1f+2fl/WhI9u+UsJ1GlJ4wd8qHjLuUrXhPqqyPZ3ybbFbGoWO0JFlAkuJ415ZXe29/toJNZdF9
	 SADPOMiGgw13xGoEmpFc1tUmk0vDKP2aH+Jhb+0ZkNiQ4nJnVBFaztc6iKsJckj5wRIa3vzdTFyY
	 CmRJT6lXuM6Judn3nvCehYbIa+W9nCFCcZqStkK6+vv2J0YrlgVWWwv0eFAaNlKCduYZuKeLFOXf
	 mf7ugPAvu3Bz9CezHse0WeQMzOgW6xW4rGBKQMgcET02FfjrAwevS8gte3Kn97dnArGwxYjqKc6N
	 akjTYe8ulUbLElxzoCgwiQmRajDsgiJJXhTpZKlJfYsejEXBqbcfbCCT49eKbT3+FbRCvZfMBLR7
	 BliQMZ+5nue2C/xpSVAAL/EAFn2XbURwSoq1/BA6Cq+Eg2IFWUdR7Msg248aFH6w4hWZNnqqgAJ7
	 lbdMXlJHLJnOlEteF5sWHs8tpLr3l5yMR4yrXgD2c3Jre5GEovxaNvlqObx0C70YO9qi7Art8wH+
	 IGmRGTtqF6WW63LKzh7U+e3+GnfV0hiIBSx4U+nzyJBv6wFYblXwDr91TkmUzwdeIisj4mBcud8s
	 VKf9d/3/WmwWPQywLODBFMX7GpEbrTjqmQm0RsDlK5lvMZ3Gnqh9+go0A7msaCt358xL6sDxb1EJ
	 CjlgTOYmmL49UsvCqx8K/Khaxt2IGpinnjKYLF39+JZQ19UC5b+P8NIOYemPvmvHClwacif77SFa
	 0S0r6VLz6kn6LEKod1F2pVcPZBfnVCTcT5s3R8iqVKdwNSyhjL1Av+7aigDPM+zx0mR0IKWEIwRp
	 cass4Mac2RMIgrXkF/qc5Zv++6NtBzgDglQlNguxGIfERWkI2i61PqOYKslTM=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Haofeng Li <920484857@qq.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Haofeng Li <13266079573@163.com>,
	Haofeng Li <lihaofeng@kylinos.cn>
Subject: [PATCH] time: fix aux clocks sysfs initialization loop bound
Date: Wed, 15 Oct 2025 14:17:53 +0800
X-OQ-MSGID: <20251015061753.2006741-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haofeng Li <lihaofeng@kylinos.cn>

The loop in tk_aux_sysfs_init() uses `i <= MAX_AUX_CLOCKS` as the
termination condition, which results in 9 iterations (i=0 to 8)
when MAX_AUX_CLOCKS is defined as 8. However, the kernel is designed
to support only up to 8 auxiliary clocks.

This off-by-one error causes the creation of a 9th sysfs entry
that exceeds the intended auxiliary clock range.

Fix the loop bound to use `i < MAX_AUX_CLOCKS` to ensure exactly
8 auxiliary clock entries are created, matching the design
specification.

Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b6974fce800c..3a4d3b2e3f74 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -3070,7 +3070,7 @@ static int __init tk_aux_sysfs_init(void)
 		return -ENOMEM;
 	}
 
-	for (int i = 0; i <= MAX_AUX_CLOCKS; i++) {
+	for (int i = 0; i < MAX_AUX_CLOCKS; i++) {
 		char id[2] = { [0] = '0' + i, };
 		struct kobject *clk = kobject_create_and_add(id, auxo);
 
-- 
2.25.1


