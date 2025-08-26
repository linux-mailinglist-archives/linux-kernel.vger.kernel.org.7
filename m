Return-Path: <linux-kernel+bounces-786582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06A0B35EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E50D363042
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED592D6E6B;
	Tue, 26 Aug 2025 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N8EKcFLA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162F200112;
	Tue, 26 Aug 2025 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209247; cv=none; b=VFQqiA/aDzYf9ybVweJYsereueEnS3QbJg17pU1miYGiir9egiXrBjPnl3jtxXP2H7xElBE9Ix+eTYm78vYkvCQCo/knMZRCcSCoVACbkhXadeNTlti06eqypnzXUpP+FZ1Ku87eUz9QqaCH1aCxwkTYLEJWXQmT0rYyRoImsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209247; c=relaxed/simple;
	bh=2B4yHPH7Vo7JbHpzUDwUPKSJdKMzSwpR5S4HlfmoPPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+ikQaSW32gIZCGxBLOIAhUypJBIKMnaVi4QhutItpuT0RjetLzE+EomR9IZB4F+v0Oj/FHNB/jzU3bB2TETXWJZOVBRDpeGMttjICtzB3soqm11FoNfnJ4dZqYRoEG5mwO5n2CvZIeIpZe+maQdwGspQXpT6RjaFZyU62JkEaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N8EKcFLA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5esHAsLkkoPbV+6reyt7D51aut7U5O+KcBeLXiCH7GE=; b=N8EKcFLAY5oEGaDpHKnlm50DEu
	0+ZvLdlhTIYq4Jmb3E4wz1ElYMI7SemE+rnwG7VvE+OuITO5JPQeslX3xQf1zb0/D875SfcLIHWTk
	IV6TwHd1Q78xRfeiMJo/7xXCnTAX890J8h7a+0MoJl3dBCml5uSQ/YvbQXurw7firhNYRtV3gRzs2
	Hqxa55oJdRRe3CID7s5r8jGGjj/EhV+rQvXXBz5zFLdA97g4hHXO6BZyzqBJnz48GwdH0S4ffWDPy
	CMHA3jXQ2OvLd9tzqrAKOsqhWq52O8wA7pyOcivxL4b1YhGKErEpZ4AMGxD3+3XyuO3JJTc61EsyH
	TcVMUxKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqsFS-00000000yzv-1zXT;
	Tue, 26 Aug 2025 11:53:59 +0000
Date: Tue, 26 Aug 2025 12:53:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Fox Foster <fox@tardis.ed.ac.uk>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: management-style: Correct "know" past
 participle
Message-ID: <aK2gVrt2RpRSQCos@casper.infradead.org>
References: <20250826003437.7695-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826003437.7695-2-bagasdotme@gmail.com>

On Tue, Aug 26, 2025 at 07:34:38AM +0700, Bagas Sanjaya wrote:
> Correct the verb form.

No, this is wrong.  I don't know the linguistic terms, but as a native
English speaker, I know this is wrong.

> -manage had better know the details better than you, so if they come to
> +manage had better known the details than you, so if they come to

