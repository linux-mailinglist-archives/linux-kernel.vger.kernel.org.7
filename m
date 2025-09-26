Return-Path: <linux-kernel+bounces-833585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F1EBA2587
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42762A4EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0070262FF6;
	Fri, 26 Sep 2025 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t2MRf4dd"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78424A066
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758858133; cv=none; b=W95WM1XVvsMYPkPomSAf188cJttka6/37zbSpv6o8wlJFFVr5HopVnRaWuRr2jag487KA7Hh7V1SeW9R5mpGr+Y5MCEzp5fz0F7Xk6Y2ZsggICX2+h83cE9+E7ZF2+c8NG/lRQOR0L+orbYjgWkdGNRL//uWw/FqD5w+n9DsW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758858133; c=relaxed/simple;
	bh=LBRawg10XyIgSEgHUccoCSns2ceVoJnkcHzrcF0yX+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhwOXfRAdO02Rk7XrrseS3pfFeJj+E7I/AGxUMZUepjvTOXlINsI98q9uayNhfoOXY8Uld4dqUeL/V7hGJLzyxXzCfHsUf+AqvQLEq/pgPTkku7fF6hEnW8jTfLlTtnkkf0jS1yaw/joIhLbwXYT0YJKy0/zbYtc/Yn9ZDyTKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t2MRf4dd; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Sep 2025 23:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758858128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BB3egd0C+LpwzwNTJp/ZFLG0iDJbaS+ezLeL3Yrhhp4=;
	b=t2MRf4ddknvLHpE7QfUVZqiLP+8abckyy4i+xW+AzYlHZglejPBrn7b+9o1uP7D5nS5zX9
	QxMjN8JVhZMx+FM2cmTKzS9uFvZPzbXjDmHaZtwh3l7B5LJ83QefFVGKmXTK0oMUDzLcWc
	eRNEAHh9ndOEAW1dnKW0CHh4qojtC08=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 3/3] bcachefs: Move the link counting check to the VFS
 layer
Message-ID: <frs3oa3te2yznm2yttqfm2pjqdwlecwkad6y6o5dymyvk2jh4p@7zncp5imxdjp>
References: <20250926022150.493115-1-youling.tang@linux.dev>
 <20250926022150.493115-4-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926022150.493115-4-youling.tang@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 26, 2025 at 10:21:50AM +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> Currently bcachefs only performs link count checks during link operations,
> during rename and mkdir operations, the link count should also be checked.
> 
> This patch moves the checks to the vfs_{link,rename,mkdir} functions when
> sb->s_max_links is set, eliminating the need for filesystem-specific checks.
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>

I applied the other two patches, but not this one. We can't rely on the
VFS for checks like this, there's lots of routes to modifying the
filesystem that don't go through the VFS.

