Return-Path: <linux-kernel+bounces-745081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC87FB114A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC1C5A553D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69873245014;
	Thu, 24 Jul 2025 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="psN8mrVG"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08060242D7B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400098; cv=none; b=kwL2X8yTYJRurrxT8YYwMJLe+iYyDvzmdFbLC9yyDB9U5C97j3d/DS+5xh6Rk4kLmrEjDsdSMpzlr6BqTCVjGf6ZJ9sqmKN2jet3WQwAbrh22bkuYFhxwQAQXHkzZRO8sTM3JansC9wHs+CHNJjhxFp4jb7X1bzDIMa9odavJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400098; c=relaxed/simple;
	bh=r5iDeXVBofXl3jblBzbwHU7uSfLCxFrOszepvi0wXFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxw4RNQzu/lvEvC5KfzKXUDm5lEz/jqwDkwwQliyRsyNnqwylZiNTMqA/nc/vlPuSV1DN+6yIkTAYyJKN8D6ypxoTIDH88ieUkZXVALfcVailMJcE5KJFiJC0sbshbDpak1lnb2kD7oDl357mZdtWw6FbZ9v9Ho+w5f5C9al6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=psN8mrVG; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753400094;
	bh=zvPgaFhEDpJ2NrBZOcIsVuijWKECpXTf7PKxoKscdcw=;
	h=From:Subject:Date:Message-ID;
	b=psN8mrVGvDwvMLCEnEcimURIntx6ZAVGL0rH8YSNhdB7dJvF1IcKTSrx05OBP6+vr
	 kdFJeyk1Q/aulzlnj2reUZb2lBUZsHXx6fjCzfYosWHiASzWEc0lEQU3Q035IR0R6s
	 WUbuRht10V5/V5+wGpF7hdLMrLee01iZXPjp1i5U=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 6882C319000001B7; Thu, 25 Jul 2025 07:34:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6737824456929
X-SMAIL-UIID: CF20D8093D9C4CA2A12DA519AE7D8452-20250725-073450-1
From: Hillf Danton <hdanton@sina.com>
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in simple_recursive_removal (5)
Date: Fri, 25 Jul 2025 07:34:36 +0800
Message-ID: <20250724233438.3119-1-hdanton@sina.com>
In-Reply-To: <CAF3JpA6FguWASZM98DWsvEasOAHH2WVkSmcY0D-V6V=-DFjoJQ@mail.gmail.com>
References: <20250724064051.431879-2-moonhee.lee.ca@gmail.com> <20250724155832.GU2580412@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 24 Jul 2025 10:29:47 -0700 Moon Hee Lee wrote:
> On Thu, Jul 24, 2025 at 8:58 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > It might paper over the specific reproducer, but that's not a fix...
> > I'm not familiar with that code; will check the details, but in
> > this form it is obviously still racy.
> 
> Thanks for the feedback, Al.
> 
> Agreed, this only papers over the issue. I'm tracing the
> sta_info_destroy() path to confirm the race and will follow up with a
> proper fix if confirmed.
>
A look at net/mac80211/debugfs_netdev.c:1021 [1] helps to prepare a proper fix.

[1] https://lore.kernel.org/lkml/6881aed3.a00a0220.2f88df.000b.GAE@google.com/

