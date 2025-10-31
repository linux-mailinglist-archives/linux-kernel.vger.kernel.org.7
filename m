Return-Path: <linux-kernel+bounces-879940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 893C3C246FD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A48C64F380A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0264233F8BC;
	Fri, 31 Oct 2025 10:23:28 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E156B334372
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906207; cv=none; b=nxUsHUyzZdz2yHVxwfJCiGXxyYfbmauEEGclJzHyRkNuejqQIraUzC4AHvvmW8zNPnH54EwYpZUcIeTDSWQYVQ1pIiboU43akQw3bAenV6kAgzEJWJ2jP/5dHFvyDCJfk86d+U3oWkhBilmgg6DJQ3J8vOhkG+9s19aNTTGbaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906207; c=relaxed/simple;
	bh=rV78AJulqgBe/69BwJDzf+lU1/rnZMFS0t4vOpTfaU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNqMRG64T9VZq7eNHS4eFnLpWcDGIVrlRMUGlV7PUD35WbL0lymlBnIWlBirIcwapgPkfIKJ/k4OzIKooktLgR8v8QhsLSBM9X7jBjQxn1/oBlRqbRQv/48Rs51heKeNRtGQVVKtLxaCXWUPIgg3tUh7/jYRPrI0bfOhW1QDnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.96)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1vEmHa-0067HP-1L;
	Fri, 31 Oct 2025 11:22:58 +0100
Date: Fri, 31 Oct 2025 11:22:58 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: fix tracepoint string pointers
Message-ID: <aQSOAkBbFkBfYxPs@akranes.kaiser.cx>
References: <20251030155537.87972-1-martin@kaiser.cx>
 <20251030193206.22bb773e697b6cc385d5aa67@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030193206.22bb773e697b6cc385d5aa67@linux-foundation.org>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Thus wrote Andrew Morton (akpm@linux-foundation.org):

> > -	trace_ma_op(__func__, mas);
> > +	trace_ma_op(TP_FCT, mas);


> What could cause the storage for __func__ to disappear as you suggest?

I see your point. For __func__, the compiler generates a local symbol in
.rodata that should always be accessible by its address.

One case that doesn't work without my patch would be trace-cmd record to save
the binary ringbuffer and trace-cmd report to parse it in userspace. The
address of __func__ can't be dereferenced from userspace but tracepoint_string
will add an entry to /sys/kernel/tracing/printk_formats

Best regards,
Martin

