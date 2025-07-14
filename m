Return-Path: <linux-kernel+bounces-729302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7669B034A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B8C3ABC3D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB3816FF44;
	Mon, 14 Jul 2025 02:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="suzSgaN1"
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F63278F52
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752461364; cv=none; b=QNI7IrH6cvC9Bqly0NkMVFkIrcu4zYrITjRF4IzkaKnDgR8j52g/yS4f1FgQjxQsIxiwE3sWavu5fzT0TcK0CchTnKKe3ubyvXyGIw009FXUnyuaBDsIGbXVO6MMHlXb7Z6SU/Qs/I8Sv21ltYwEY6GCyn2dy2eQlj+QopZ5+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752461364; c=relaxed/simple;
	bh=VSVbUMc6mDbmJjYAY/5z0TMIdVhDUf4VoxFheGf6NwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u70vw0xZ96K15OuAV+cw0HiQoiU15NdC0b/odzgmzG44boQzwCf51DjhTAHf6Ee6eRmoTdH5i5OhpbzoawcChPz9/aBMJv0+iCah/ycsrNRc3Xu7EUEBkmeeAeOmxHMhkXBF60s03I3uyTL2huFS+buIJHTxbhB20ITlGWXGWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=suzSgaN1; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752461358;
	bh=GMaWGcV4ODZf5yVjbrXFE/lU/1m+YQcTbnacYAlAafo=;
	h=From:Subject:Date:Message-ID;
	b=suzSgaN1tb7AdUOjnEjZ38dUsXdCPeUZBetxWwqWaywdK47ivmmgN/2symn9rfS2/
	 SIt7r40qwaFFcTHrc0x8OjD38pnmmMmogi+UjGcDHBbJNOb84XxhOQrMnfIphZKfP2
	 5kHRU0JkG0ByJwOyOKRCdfYJFE9RRD+ahd2pBXdU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 687470280000305A; Mon, 14 Jul 2025 10:49:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9860704457077
X-SMAIL-UIID: E295B15E201B46BDB669C3E5CB240984-20250714-104913-1
From: Hillf Danton <hdanton@sina.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	syzbot <syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbhid_raw_request
Date: Mon, 14 Jul 2025 10:49:00 +0800
Message-ID: <20250714024903.3965-1-hdanton@sina.com>
In-Reply-To: <e8fe21fa-9a2f-4def-b659-063d55a40f3d@rowland.harvard.edu>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 13 Jul 2025 15:19:34 -0400 Alan Stern wrote:
> 
> Try again, but with Benjamin Tissoires's recent patches.
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/hid c2ca42f190b6
>
#syz test:   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git  c2ca42f190b6

