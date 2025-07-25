Return-Path: <linux-kernel+bounces-746345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90334B125A6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C4477BD354
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E422266B67;
	Fri, 25 Jul 2025 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAPZoiw9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C725DD1E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475660; cv=none; b=EJlWAV9Oq9UqcTifVu2fKstOePYJyI5HpTSaovQbZBWRtr0jLOv27paQeN6Mkz6zWPv7YxsYSBaj8ZsloY4vif/XOcexhbRkhC55htK1OZ8VUA+pJf8khhNddVIyqIL4N1xD6EclHFfs9oQDbnb55Ht6DK2Y4/9wD3C+wJ+w4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475660; c=relaxed/simple;
	bh=v3dRc6gn7lynJJ8xeHW8GTHQpld+ulORhv4T4YMRbqo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LMLq2CQ5+ZmRWC0o7VteHKHDf6mu5z+8uSQmxRTDfuW9cNDNt277/hEVAjEFxS7+y87f468gE14QJ0920NKgU1omAmuyJLUZRgQeuG7WOXI7/uvo7RPXAJRfw0XJxMCzjaxUl9zOlWl1i9Nvl2dInb0dNoF934MEM1cDtEDusyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAPZoiw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14A2C4CEEF;
	Fri, 25 Jul 2025 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475660;
	bh=v3dRc6gn7lynJJ8xeHW8GTHQpld+ulORhv4T4YMRbqo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=fAPZoiw9iaD3nENTz5hl19Nx1sIBM0dhhzWUePsXIo70lo0Xtqypjw26G/Ceu0lVl
	 K6waiVKpcgnYBSGn0bE1UsxTnMIlg852zscpToBpiI7kF8Twbl9E6EV1ifNaCA6owI
	 /6Etchoh6ObQgVxXdavFWGm3PmpcgkSftLmKpvTSXXekMe3c+FZHYRm2hlL+h0Q91u
	 RQerX66Q/1FlclXGmj0s6htvGJ14ntOtiG67Q0oBrXiSvNkDeN4n3f3AQoOTRAj5ro
	 wR/cieIJF2+Z0QZhqJl744ElyQxumVDefH2D39OEJhqXrip4sDBAOAC1ECdzOZNzLz
	 XDy9FejB46SyQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7a-00000001QkL-3w2j;
	Fri, 25 Jul 2025 16:34:26 -0400
Message-ID: <20250725203426.791145358@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:14 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Nam Cao <namcao@linutronix.de>,
 Juri Lelli <jlelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 17/25] tools/rv: Stop gracefully also on SIGTERM
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

Currently the userspace RV tool starts a monitor and waits for the user
to press Ctrl-C (SIGINT) to terminate and stop the monitor.
This doesn't account for a scenario where a user starts RV in background
and simply kills it (SIGTERM unless the user specifies differently).
E.g.:
 # rv mon wip &
 # kill %

Would terminate RV without stopping the monitor and next RV executions
won't start correctly.

Register the signal handler used for SIGINT also to SIGTERM.

Cc: Nam Cao <namcao@linutronix.de>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Link: https://lore.kernel.org/20250723161240.194860-3-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/rv/src/rv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index 239de054d1e0..b8fe24a87d97 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -191,6 +191,7 @@ int main(int argc, char **argv)
 		 * and exit.
 		 */
 		signal(SIGINT, stop_rv);
+		signal(SIGTERM, stop_rv);
 
 		rv_mon(argc - 1, &argv[1]);
 	}
-- 
2.47.2



