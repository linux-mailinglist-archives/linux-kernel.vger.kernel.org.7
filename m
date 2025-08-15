Return-Path: <linux-kernel+bounces-771052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B293B28228
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DC117985B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A5C2248B4;
	Fri, 15 Aug 2025 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GUl7cxHL"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA61E230E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268881; cv=none; b=Xsyey+K/SzEmkFhMoaGtxkWQnMgwfazoPZwTp1Qymv7aS24L1dWS4+xcLm0rCL+hKI6QQy/Gf/3XYE9jX4oBGs2PfnKO8GpfEznbYW/H6NIW+u5cXnVJqvCJFvhpqL0/HFAAQ4g+jQLSHw0XhZ3SI2O4MNbiPAeNKQACw7fKYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268881; c=relaxed/simple;
	bh=YPc2WkiuWNKrwt4/CCK+S9Lx2u3fgAqe1VQTLuurmgA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F2Yr5Ph0z+daP0ZWP+rjkSXRV41JM7iRP7akqwDRSotSTsb5cZIr3A0SlZuz60ebSYDTD51YvX9u5aOmNCwZjnNTP727EbgyGWEBoGb57Op2/gHb1yMGUYj4MEi5k4tp2vq7EY3vjEVXsmrcQ7V+nz84QzhhFYayMX7DG/yapHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GUl7cxHL; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755268877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvL37IC/92eRm8eEeLClw7EjlC7L2Hs69WqmVKW3jAU=;
	b=GUl7cxHLjG8yqf/4TtdlmME4eNJU5i9H34q91NXQvxnhtUcRZ/7WOyVIHWo8ZOQifwg6ye
	GBDybV3X00+IB6dsAPZr4x0I+qbmnfuxaooUz7DEw0zNhehC4QW9Bck+9o8GPZ/ZvBHQRm
	UR3bEIRmPDU2361vinmNf1OELTgkkh4=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3] kdb: Replace deprecated strcpy() with strscpy() and
 memcpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aJ9EPQNk2bcOMP1h@aspen.lan>
Date: Fri, 15 Aug 2025 16:40:56 +0200
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Nir Lichtman <nir@lichtman.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 linux-hardening@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <73C106D1-C7F8-415C-9BC2-89607C839265@linux.dev>
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
 <aJ72XZ0VkrCkKFNy@aspen.lan> <710CDE93-89CC-4B60-A582-5F9B2916ED72@linux.dev>
 <aJ8cyXzMaa9b7ppN@aspen.lan> <72F30E3D-2887-4494-B58C-2042AC880C1B@linux.dev>
 <aJ9EPQNk2bcOMP1h@aspen.lan>
To: Daniel Thompson <daniel@riscstar.com>
X-Migadu-Flow: FLOW_OUT

On 15. Aug 2025, at 16:29, Daniel Thompson wrote:
> 
> I like the extra diligence of checking the trailing quote but perhaps
> combine the two if statements (so we only chomp the quotes if there
> are two).

Ok.

Should I replace kdb_strdup() with kdb_strdup_dequote() because it also
handles unquoted strings or do we want to keep both versions? It's only
used in a few places where kdb_strdup_dequote() would also work.

Thanks,
Thorsten


