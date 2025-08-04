Return-Path: <linux-kernel+bounces-754941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC679B19EE3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5B33BA6B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC862459F3;
	Mon,  4 Aug 2025 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="bePZBDa3"
Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE824418F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300471; cv=none; b=HoxilYoyh4ZiPP+Y4mdaDsLeotjR80CSPOW2cvhkJtYjDcqwYesT8DgXCk/G7CUL7DO9mx6ZHD9f+bQbscPrw/eVRyUjuz75zXGR4xrJ/4fNIC4C+o5MdZDw37krQ4RSH+bha8v0BbpthkzG0gp2H+LPeStwYK0q+5uz8QjWlEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300471; c=relaxed/simple;
	bh=plKyJBj3mtQKgRao7b68LOeuzCMGdCs8YTyQyXVbp8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwDUraMv5Q8QqntqzAzJVQv1cZhhPMHjJwOTCSNl96fWSe5y1bS37CmOEIvVbauzv7Cr7MXQi3S4wsQ7dO5rVzctVbRFtt68oTh0fqHokd2wt0Z50xzobFb5xg8KiVVysWB/Y3ZD2jRj8ItZ0nmR+OV4/BsIpA2DE9ItP+9oklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=bePZBDa3; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754300462;
	bh=/NMiWYArdixCnIV8qsR+BFCKpefIojulmRxT9MNKplE=;
	h=From:Subject:Date:Message-ID;
	b=bePZBDa3aDZuKzTOum+Khrx4ctRN9BvgcGssfdTTXLJu/d7nbYnp7cE/PJ2yJeIkh
	 qa9ofgQlTMyHSgafolC2/wpVzCmt8bEQ9/m4JAMky0excct23Clv5fiuOY46htF+MH
	 djvX2OgM4EFf2Q2dq22Q8sFVSqpgOl0fB7+L/3V0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 689080280000239F; Mon, 4 Aug 2025 17:40:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8558406291946
X-SMAIL-UIID: E994DBE1263645139F2664FF7472ED70-20250804-174057-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2a0d2af125c01db73079@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] [ntfs3?] kernel BUG in set_page_refcounted
Date: Mon,  4 Aug 2025 17:40:45 +0800
Message-ID: <20250804094046.3872-1-hdanton@sina.com>
In-Reply-To: <688cfb9d.050a0220.f0410.012f.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 01.08.25 19:38, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    260f6f4fda93 Merge tag 'drm-next-2025-07-30' of https://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15c31834580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7581d3fb1bb0d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=2a0d2af125c01db73079
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149062a2580000

#syz test upstream master

--- x/mm/page_alloc.c
+++ y/mm/page_alloc.c
@@ -2974,6 +2974,8 @@ void free_unref_folios(struct folio_batc
 		unsigned int order = (unsigned long)folio->private;
 		int migratetype;
 
+		if (!free_pages_prepare(&folio->page, order))
+			continue;
 		folio->private = NULL;
 		migratetype = get_pfnblock_migratetype(&folio->page, pfn);
 
--

