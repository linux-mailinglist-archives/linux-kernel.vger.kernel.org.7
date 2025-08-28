Return-Path: <linux-kernel+bounces-789164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D5BB391D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9E07AE131
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C098826773C;
	Thu, 28 Aug 2025 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cOfC1CjP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B326560A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349230; cv=none; b=NlD6xMyvznSxS/tmlVWltNJCE7rmNelwrEtDSqG1SB7VL4Ad66ZyJRdqpho7H3lY06r/9E6CkPTRhxQsoCduEE4A05tZllFMaG9oaUAupmZbCF+FXL5ad6bwKHkkW3qAGuiDZsRz+OBGOJiBO5dCkzDHfROx6bKn+uRJ/eA3Sa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349230; c=relaxed/simple;
	bh=HVAspzzIyXQO7ejlpQfZ3LLojc9WoAMq6Oq10fW25tg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n8cgBLZji5SshIkhNDQtQiOKdWlQDdFOdXu7lgz3IOeEHmWyhp/QtYEQ1NKgtStn6BGVAWeLEANuID/2ppu8UJQDWc5zdej6dYGmT3zEwK2FrpuKU78X29CfMGXlCdZOoveYrQ1xpW9A6sd/YYlC2E98D+RE/jBpFJEn7RFDSVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cOfC1CjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDC0C4CEF0;
	Thu, 28 Aug 2025 02:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756349229;
	bh=HVAspzzIyXQO7ejlpQfZ3LLojc9WoAMq6Oq10fW25tg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cOfC1CjPY1XGtl5QD0Ms8YHq3PrbKJ8MQ1aKaktqjL+o6lBig9vVsm/9DATHWYbJW
	 4qq4dLnxEwou4MXf9z76CFL8q3pzhn9Za8s51czlHSMP/zBhAw/AObUXPYHrPQlLDY
	 /3CovCY2ev42W0eJDr1smcb0YOoIuippJ13c1C90=
Date: Wed, 27 Aug 2025 19:47:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, david@redhat.com,
 lorenzo.stoakes@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add `const` to lots of pointer parameters
Message-Id: <20250827194708.a6a87ecae6a992b4c92b6451@linux-foundation.org>
In-Reply-To: <wmxlcvxqx5qmkzpk6x5fducmmv7giget2nwsvspw3uouufngvs@kxoyppwsyxrv>
References: <20250827192233.447920-1-max.kellermann@ionos.com>
	<20250827144832.87d2f1692fe61325628710f4@linux-foundation.org>
	<wmxlcvxqx5qmkzpk6x5fducmmv7giget2nwsvspw3uouufngvs@kxoyppwsyxrv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 21:48:21 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> > I'd actually be in favor of making all incoming args const (C should
> > have made this the default).
> > 
> > Because modifying an incoming arg is just obnoxious.  That value should
> > be viewed as part of the calling environment and should not be altered.
> > 
> > Try modifying a lengthy function and wanting to get at an incoming arg
> > only to find that something in the preceding 100 lines has gone and
> > messed with it.  Or forget to check fr this and get a nasty surprise when
> > testing.
> > 
> > Not that I'm suggesting that someone go in and make this change.
> > 
> > On the other hand, it would be neat if gcc had an option to warn when
> > someone does this.  I bet it would be simple to add.
> 
> But what of the lazy programmer that just uses the variable at hand
> instead of declaring another one?

Sure, I'd say that's OK for a small function (home-made strcpy) but for
a larger function, expecting other developers to read back through
everything to make sure that Nobody Did That is way unacceptable.  It's
laying a trap.

> I also wonder how this would affect inlining choices?

I'd be surprised if the compiler didn't trivially optimize through such
things.

