Return-Path: <linux-kernel+bounces-720680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E62AFBF2E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CC7171849
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F12F27713;
	Tue,  8 Jul 2025 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="FZCw2uZt"
Received: from smtp153-166.sina.com.cn (smtp153-166.sina.com.cn [61.135.153.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229B191
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933952; cv=none; b=LBwmL7rYttyUDS0YURtlGNGtY/Ob8/z9HGIQ5Sejo3uYclfC9exy1LzOZtVwhULRZ8rQ8E9p4/z6vrk+bhX0dJqOiA7LGdRO0NGT+mnp2SFg42JfTVZL/MRq4kv6w5cJiK72mxidXlHKxSE9ZpQ4B/oOSuSusUZd2FeSQvKc204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933952; c=relaxed/simple;
	bh=Q5/7b75vjuV8bEqfgE0riyVIQEz82/H/Uu34rZ0BkC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0c1QvNRPzaZArgPBUKIQwzsaQjHytnbLjNPB2WMiFwxnAp3uW/qRI26pPvk9TDYdtgW55iCtHCT052B6iAfz0YK7WxNpmVvjrVaQssInFpOinmBYGxObdg48lBpijhpoN1p3jnRb9vhnBXOCKJrFIpyMdiVrfU3C4KguBZJCnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=FZCw2uZt; arc=none smtp.client-ip=61.135.153.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1751933943;
	bh=DW4AhCBbeiArax0m21d22MWOoGbYI1cZ1thox4sliRs=;
	h=From:Subject:Date:Message-ID;
	b=FZCw2uZts0b4kVYG6lTMzmCJd0OMA6V8cv6oIiuyMG5z0R0MJ5hK8s6LO7JAeONsP
	 JqGnSG/whOUTtNevqWpSo9CkIsq5j6NotLahmrWKkNg4vVT6kand/Bh2jQ85VMob9X
	 X6arv9eR12cmlhUAWHwydmECSUr4TK2gJzMR2vOg=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 686C63F200003BF3; Tue, 8 Jul 2025 08:19:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1675456685312
X-SMAIL-UIID: C398EA41875643F785817AF7FB17703F-20250708-081900-1
From: Hillf Danton <hdanton@sina.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: axboe@kernel.dk,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	syzbot <syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	linux-kernel@vger.kernel.org,
	nbd@other.debian.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nbd?] possible deadlock in nbd_queue_rq
Date: Tue,  8 Jul 2025 08:18:47 +0800
Message-ID: <20250708001848.2775-1-hdanton@sina.com>
In-Reply-To: <f6909d1f-0a53-447c-b3d0-369574d2d721@acm.org>
References: <20250707005946.2669-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 7 Jul 2025 10:39:44 -0700 Bart Van Assche wrote:
> On 7/6/25 5:59 PM, Hillf Danton wrote:
> > and given the second one, the report is false positive.
> 
> Whether or not this report is a false positive, the root cause should be
> fixed because lockdep disables itself after the first circular locking
> complaint. From print_usage_bug() in kernel/locking/lockdep.c:
> 
> 	if (!debug_locks_off() || debug_locks_silent)
> 		return;
> 
The root cause could be walked around for example by trying not to init
nbd more than once.

--- x/drivers/block/nbd.c
+++ y/drivers/block/nbd.c
@@ -2620,8 +2620,12 @@ static void nbd_dead_link_work(struct wo
 
 static int __init nbd_init(void)
 {
+	static int inited = 0;
 	int i;
 
+	if (inited)
+		return 0;
+	inited++;
 	BUILD_BUG_ON(sizeof(struct nbd_request) != 28);
 
 	if (max_part < 0) {

