Return-Path: <linux-kernel+bounces-889553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C01BC3DE59
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C84A74E820C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300B51EB9FA;
	Thu,  6 Nov 2025 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="uzzDyMLN"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE130E859
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473144; cv=none; b=egYy0NKBO0pSyxSwHy/ebcti8RlrtuFdwopndGHvBG9CyhG7Yjq2L/sQiqvk2U+Z/uL88oOMlxv262wD7o05de9iLpTlXKcyYaRLHfldOxXa/1+4vY8fUT1GryZag0CCc6+HH4PwzUrx/mvXWehu6E1+OXr6mQDgXdYrP2iVcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473144; c=relaxed/simple;
	bh=REeBbwuqMyRpGW1LVwOJH95osbdw/G+SMx+T9V2nnLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgmqU8w7fayymNmZRvbL8CPBHphpmWimRN5cs9PxlFpoQo8pfejivvxtkTiHMpspIoQb0QRCdjKSTtXHfOqOZRkVfqMZ3WrTBunv+LIGn6tMQWZE4wj0ubB7tA8WODnhQ5zwjYln5gVDAaJnTaHolL4mxK2ybjq2DTlCSQUwQrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=uzzDyMLN; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762473140;
	bh=Uj/LmHFOhg7xXjmPkxbK+BugCECzjfx/qf44oxYtmlg=;
	h=From:Subject:Date:Message-ID;
	b=uzzDyMLNFceDnZgezsQ0r1FkNNgREtjDu+h52She9+1eenY7NmCwmdshtjd85VAt3
	 cj/dvl3Rcf0cHTUkcTPhJFetnkHoDKSr8VzOiKEoBiXkGyUbsuUDI2iYkVf4sYmoU7
	 g0/8ctkZ7X5b6L0sSIp68wC8enuS0nuD8qPGVwv8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.250])
	by sina.com (10.54.253.34) with ESMTP
	id 690D348A00003EB3; Thu, 7 Nov 2025 07:51:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5022686291998
X-SMAIL-UIID: 14C3562B3435487784262071662882EF-20251107-075141-1
From: Hillf Danton <hdanton@sina.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lizhi Xu <lizhi.xu@windriver.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	perex@perex.cz,
	syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [PATCH] ALSA: usb-audio: Prevent urb from writing out of bounds
Date: Fri,  7 Nov 2025 07:51:26 +0800
Message-ID: <20251106235128.8908-1-hdanton@sina.com>
In-Reply-To: <87h5v7ru58.wl-tiwai@suse.de>
References: <87v7jnfkio.wl-tiwai@suse.de> <20251106143506.720545-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 06 Nov 2025 17:41:07 +0100 Takashi Iwai wrote:
> OK, then a fix like below would work?

Test Takashi's fix.

#syz test

--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1362,6 +1362,11 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 	ep->sample_rem = ep->cur_rate % ep->pps;
 	ep->packsize[0] = ep->cur_rate / ep->pps;
 	ep->packsize[1] = (ep->cur_rate + (ep->pps - 1)) / ep->pps;
+	if (ep->packsize[1] > ep->maxpacksize) {
+		usb_audio_dbg(chip, "Too small maxpacksize %u for rate %u / pps %u\n",
+			      ep->maxpacksize, ep->cur_rate, ep->pps);
+		return -EINVAL;
+	}
 
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;
--

