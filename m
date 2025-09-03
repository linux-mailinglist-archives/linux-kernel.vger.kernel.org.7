Return-Path: <linux-kernel+bounces-799184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAF8B4281B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B547B2739
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C8233438A;
	Wed,  3 Sep 2025 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MLpmBGTQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3162D3ECA;
	Wed,  3 Sep 2025 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921123; cv=none; b=inT39sQ0LErbu4Ui9ucFRhelGigR0B1t30tLhBeXz81RJWEtbSlkgxmJoqV9I8OYgRHsG+cnHxCTiBywtjDB68qQB5nsSdIBneimsJAlFzMvvJZ37zO3qfUgpvDJzHA69Wbe9n18bP7+EtH5T1IBH67tRWEL/kTI52rWCjbR9L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921123; c=relaxed/simple;
	bh=sDtez26JtHmXj+HkncRjK6RMlpBQeh6/CLfdJ2yVa6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpLAjrK0S9hgAq5CGAawpRC+vSSzq55Cnai2rGG680sNi5hsBtfEEZnlT02MJEOmYUFE8CwDFgwS9A4BrJCeoeYgaWTklqVuJWW+tJROPFtE2oU5EtRPOKgQcPyPE2IsAOvPAB4q0dXNiGOa/C+lKhfVoAOLWfNoWNODx7GI93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MLpmBGTQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TkMyOEDRjY78DNgrgZNzSqvfgAP1GRrfp0tpaFEmIjE=; b=MLpmBGTQ+D7nUUcAIQLIrHGEZK
	MlEGb+L/+rIntnWR3QLhHfep9Bj9JtMtHnoefOIWGWuX7wAZ+/wBcgSJheyV5POdiNLTOSr/YIGc2
	dvsHmZ+/KDZyWdO/A2pC7HPehtNs1I6gVV/VNXl8CcvzPSaPune9GCi1D2bhcIpZO7WhbW0B4tyaZ
	IskBniZBP1BPEf9Jb9pmGnnYQwj5uxYRuvLZyJy4Cq+f1o9LfaHxMB37UxB8xsgwdiEns1hpCPFI8
	CsXGeQq61IWdteEhPbb3y3BHoOrP0DGJWSP8A1cneJaWA5M57TnS7eIG8Vsc3rmhp7C7wRYdI1d4Q
	5Cdzkkwg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utrRN-00000005ycx-24hl;
	Wed, 03 Sep 2025 17:38:37 +0000
Date: Wed, 3 Sep 2025 18:38:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tools/docs: sphinx-* break documentation bulds on
 openSUSE
Message-ID: <aLh9HVd8_S9LvSgv@casper.infradead.org>
References: <cover.1756916565.git.mchehab+huawei@kernel.org>
 <29135db8c8094006f256e1fa0b64663c735737e7.1756916565.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29135db8c8094006f256e1fa0b64663c735737e7.1756916565.git.mchehab+huawei@kernel.org>

On Wed, Sep 03, 2025 at 06:24:16PM +0200, Mauro Carvalho Chehab wrote:
> Before this patch, building htmldocs on opensuseLEAP works
> fine:
> 
>     # make htmldocs
>     Available Python versions:
>       /usr/bin/python3.11
> 
>     Python 3.6.15 not supported. Changing to /usr/bin/python3.11
>     Python 3.6.15 not supported. Changing to /usr/bin/python3.11

[...]

> 1. after this change, sphinx-pre-install needs to be called
>    by hand:
> 
>     $ /usr/bin/python3.11 tools/docs/sphinx-pre-install
>     Detected OS: openSUSE Leap 15.6.
>     Sphinx version: 7.2.6

I thought the preferred option was to be able to specify:

PYTHON=/usr/bin/python3.11 make htmldocs

or even make htmldocs PYTHON=/usr/bin/python3.11

like being able to specify CC, LD or AWK.

