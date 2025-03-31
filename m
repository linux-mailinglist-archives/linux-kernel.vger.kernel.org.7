Return-Path: <linux-kernel+bounces-582233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85362A76AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 17:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1193516E4D9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6495222591;
	Mon, 31 Mar 2025 15:21:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AA22172A;
	Mon, 31 Mar 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743434467; cv=none; b=ad0QQOCKZCofJCzLSejQXdwWtJ2LiTiZfFbI5FCzfqJ2CkIN6Oadd+iYdc8ystgGTs5tqcJMX5lu1ttWTxR+C8Dplww8dRopeTwtIEoKegLgEDg0IeCarlSrJu3uH71I+liMP6gOqjFzEDJ1yXcWdv0rPlwdkA0nCYO0/hZux7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743434467; c=relaxed/simple;
	bh=+QNHGxfNVdKLK5yaXKMG1YUgHOsaBPMQeDScjaMOx8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sa2cUwKM3u4OhSZpB1EPHrNa1xulrGAT7YBNJid7e9w6fVjVQm4DHnIp9dQ+7XRhpQKquRseorgja+LNO0CDQ2zXZqA6O1arGyDLtWvl8ruwJp/l7Iu47Via3RUS98DKV+vxDRZSygUsCOa8IAPCvoe+RMXkfPDfsGgOzjnOi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5899CC4CEE3;
	Mon, 31 Mar 2025 15:21:05 +0000 (UTC)
Date: Mon, 31 Mar 2025 11:22:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev
Subject: Re: kernel/trace/rv/rv.c:812:2-8: preceding lock on line 790 (fwd)
Message-ID: <20250331112203.3fe7e6ff@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.22.394.2503302037080.23941@hadrien>
References: <alpine.DEB.2.22.394.2503302037080.23941@hadrien>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Mar 2025 20:37:59 +0200 (CEST)
Julia Lawall <julia.lawall@inria.fr> wrote:

> Please check on whether line 812 needs an unlock.

Yes it does. Thanks!

-- Steve

