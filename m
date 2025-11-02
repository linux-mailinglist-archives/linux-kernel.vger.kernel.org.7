Return-Path: <linux-kernel+bounces-881843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B480C290D4
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 16:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 204C53465B1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F97321C16E;
	Sun,  2 Nov 2025 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="E016+jRE"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676B1C5D59
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762096113; cv=none; b=QYF/4urbC14twN3Zrin6b6phmdpqmU6KFS3A59H0zs2+pZs2jUph1lpj6Fhg1KGcBA5MNSAOPYUh1hLKjF+ZJNDDTAsGL+4lvnNDfed0xmTWJBaOYkVrriAaRFYqK8rAfIWHeMk9Jwbc6q/t0eCYBNQEmwQ9+bz6cRGnIKE7uK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762096113; c=relaxed/simple;
	bh=AKqCQhDjUshJCJqtE1SK0pSWGEuyvW0L1NbySwhbYso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaleTvyeOo/YP+GxiPN9vYPW5KIFbySsWX7As5RSODHT7xixqmJ3VUbBkxpu/Fuww73mMBchp63+RTCxBvkBIeUqNU7OrjH1GvWuaYjU0ETw+LJF+epN7DUg/P/E6h2UB0bWMKU1esdoqEJPZZPUonIwWc/GB9TdOMb4sYNvio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=E016+jRE; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762096108; bh=pu+1tA7/AXaZcXGdEmKIjWhntUC6sLACkAYiGrcTazQ=;
	h=From:Message-ID:From;
	b=E016+jREzjMAu1n/wSISrFqxCco8jOSPkKXSH/1Vig5++j3wSWqSuHzSNJSFAjKv9
	 E5g4deKwKATmYs3/4fZLA68z9mRoualyN6yjiLkxa5Qi5BQo6XrDwL6CkG/vSvFTD3
	 gFi0KcbqfhjkiI/dictqzifMkZkEpuTLaFKORtoA=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 768DFC06EE;
	Sun, 02 Nov 2025 16:08:28 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A2F8S1B017035;
	Sun, 2 Nov 2025 16:08:28 +0100
Date: Sun, 2 Nov 2025 16:08:28 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: clean up outdated comments in generic
 arch.h
Message-ID: <20251102150828.GA16950@1wt.eu>
References: <20251102142548.15482-1-w@1wt.eu>
 <ba29f952-eb42-4361-b0d8-6a70fc4be6ba@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba29f952-eb42-4361-b0d8-6a70fc4be6ba@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Nov 02, 2025 at 03:40:32PM +0100, Thomas Weißschuh wrote:
> On 2025-11-02 15:25:48+0100, Willy Tarreau wrote:
> > Along the code reorganizations, the file has been keeping the original
> > comments about argv and envp which are no longer relevant to this file
> > anymore. Let's just drop them.
> > ---
> >  tools/include/nolibc/arch.h | 9 ---------
> >  1 file changed, 9 deletions(-)
> 
> Thanks, applied.
> FYI it seems patch 2 never got sent.

Sorry, I now found how I messed up. There's indeed a single one (my
git format-patch command also took an experimental one that was on top
and not to be sent).

Thanks for picking them, that's always less patches in my local tree!
Willy

