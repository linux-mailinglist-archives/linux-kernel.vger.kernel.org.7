Return-Path: <linux-kernel+bounces-886496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F2C35C18
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47AE94FC6AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477AE314B79;
	Wed,  5 Nov 2025 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zAT8hCeT"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A8D531
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347710; cv=none; b=iHDksEH525qr1OYkkY4wRqcjNNn+9rBsU376jmWcawb0w8gpBBuVEiPv4SlpEYOIliQYLVs46mvD8Dx87xncVQhK86nbOecJuS1gPHKkQcuutMi+9LzYCJxZLHbNO/HrQrfrkH6crfBrTElLBBH+dsaWBb/vLQAufgFwIoZArWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347710; c=relaxed/simple;
	bh=GuKbF2tGqHqc/LzKPMiopljz78rkMbJvC20daXRv560=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNDD20xK6Kcils5vsEkXv9gqpCdXV+kaHhpd1AckWjWPqfj0zS/BL1KweIA7XqqrDr3LrZGQbDV87c6dmxq2HDqDfPzGtLZdgcQBpukCIpK0ng9rPQ3ZqTgr4Ox0d52oGeRnnNtnEUhKE+c9dUHyaTVAG4LwFa1t/RHlRVtK6J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zAT8hCeT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0SkAnIknvk3SMCKddWqAjNfzOP9dD1Hs+521Sl/DWOM=; b=zAT8hCeTjD81JATA0JMkbyvouX
	UDyZm3PipgbUvbWNSm5VXbe7bcr3bi8t4zpX6c0EL+2naSLVK8YkaVQbcPsAAxRQCdMdNilWsD0S0
	xR2OzktZotO/6q9ZcaNxkTEkcXGsHzGY5ZdL3RyCciHliF7lmnM3cVrCoip7Zqfq9MjEhIGo9K+wd
	k5TcOgtZg6X8xkzG66VOCH6uYAG0DuUhfOYY8PlkZqjm8g0mTQFdk+8qZ6EX984LQri/vlfxY5VdT
	f7MveOZcT13YMjWyF6gamlGxsg1T3iiAvnNHsM5r0THapZVdHDHIvnehQD1Lxp53flOf1XwBWLTxn
	YTv/tHGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGd90-0000000Dj75-2GIv;
	Wed, 05 Nov 2025 13:01:46 +0000
Date: Wed, 5 Nov 2025 05:01:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Joe Perches <joe@perches.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] checkpatch: Deprecate container_of() in favour of
 container_of_const()
Message-ID: <aQtKul7TSt-UVsIl@infradead.org>
References: <20250811085731.2117377-1-sakari.ailus@linux.intel.com>
 <aQsF9tuTWRn3tfS_@valkosipuli.retiisi.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQsF9tuTWRn3tfS_@valkosipuli.retiisi.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Well, if container_of_const is a drop-in replacement for all uses of
container_of, just fix the implementation?  If it is an almost but not
complete replacement, find a different name for the few uses.  And if
it's not anywhere near drop in, just using container_of make a lot more
sense.

Just in case it wasn't clear:  We really should keep the shorter nice
name as the default if at all possible.  Both because it reads better
and because it avoids churn.


