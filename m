Return-Path: <linux-kernel+bounces-820974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7126B7FEC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B53618991D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EC32E1EFF;
	Wed, 17 Sep 2025 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oh+CJCHe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8D2E0926
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118072; cv=none; b=AZ6XkJDX0l/AEiomDTiPI4u3fpsR9H6yA1i92SFMRGUexeXxMsRCzTsdffOwObjIN+Z6WlqzoWBVM1ORMKwZIIL4vntzzVVGzGwAKmKBB/n6BdsTyaCsmL0X2+3ZlCXR4k2ec/OEsEe8xDAruFmPJ9qO6p6BKc89B902e+cIhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118072; c=relaxed/simple;
	bh=6zOh4sinXosIoKWFI9VsVS8BRJBsHrpLMDRZFthCN9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clVbUAOBhlZDq5Y8VddmftbuwkAsU1u2HH0pNuay84thfbJtgvf+2RcaCdc91QWmMpDK3XkAQvp0TSw93kuVEW5RrTjOnRRvI41N4xWP7mAP3SoJ+TXqcq1ZiL0kjp8WWQ4qRr0xsuK+0zufHJOh0HTuuhGYsf5okmwWk370G3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oh+CJCHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDECC4CEF5;
	Wed, 17 Sep 2025 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758118071;
	bh=6zOh4sinXosIoKWFI9VsVS8BRJBsHrpLMDRZFthCN9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oh+CJCHeW9+Fy5a5DWVYNBd3hXEespitYxTccvFvbFAQ7/CZ2Fw84BrM/14NzQLtl
	 U9uUTXf6QSta69Chhe0FM8yIY/0ZedE+QLkKLb4ex+KL2KD4xT9td0I1UxcQzPWsq0
	 8B38PJ6R2+blsf43BGRy6sbBCz0yXEYlf13hbd3E=
Date: Wed, 17 Sep 2025 10:07:47 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Petr Mladek <pmladek@suse.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v4 1/5] printk: nbcon: Export console_is_usable
Message-ID: <20250917-imaginary-vigorous-condor-fccdc1@lemur>
References: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
 <20250915-nbcon-kgdboc-v4-1-e2b6753bb566@suse.com>
 <aMp4BrEpqXOW9nam@pathway.suse.cz>
 <dad15813cfdc3b7c77ba71266e38a137d0015bcd.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dad15813cfdc3b7c77ba71266e38a137d0015bcd.camel@suse.com>

On Wed, Sep 17, 2025 at 09:21:48AM -0300, Marcos Paulo de Souza wrote:
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > 
> > It means that Macros developed a patch and Petr reviewed it.
> > The patch was not longer modified.

That's not entirely correct. The signed-off trailer is used as the boundary
indicating who was the person responsible for collecting the trailers. When
the trailers are collected by the original author as part of their iteration
cycles, their signed-off-by trailer goes below any trailers they have
received.

When the trailers are collected by the maintainer, any trailers they retrieve
will go below the original author's S-o-b, but above their own.

> > 
> > Note the Reviewed-by tag might be preserved even when Marcos
> > later did some cosmetic changes, e.g. fixed a typo, formatting,
> > or rebased.
> 
> Got it. I used b4 prep --update-trailers, and it added the Reviewed-by
> before my Sign-off. But still, this patch didn't change since the last
> submission, so I thought that it would be ok.

That is the correct behaviour.

-K

