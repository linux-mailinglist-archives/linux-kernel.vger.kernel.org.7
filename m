Return-Path: <linux-kernel+bounces-897813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EA6C53C49
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81903505C72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B33343D76;
	Wed, 12 Nov 2025 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="jSImEvu1"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49D32ABDB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967951; cv=none; b=DYS518GO9qIfD+QeayoeYKcKW28uVYgda5yx5lWk7iu+l9q/3FdYM42FSOxt4n6zJlVMj+EbNuyRO7k1baYOI/Q9NvDwSvbF//yzWfJLiz5CiPaPB61dExBBcpKS4nifrZiwnXBLv5/FhkssDfSXxBL1J4+HZi9zKOxY618PZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967951; c=relaxed/simple;
	bh=UH00cLBOgn6XmQGO+qGldoVEAxQ8CjDrPyUc2vYa1vE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VzV/oUIx1exX1xELHBowHCgEpJQtoKrtFFOkF/4HcpoG1lTCbD5niNnsI7q0l+BujLS6zq4oXGOY7PkBCB+yrVcXQ+GQrtguHcunn5u3R7QfFBzx+ZWHPQf2MkztySwCNTTnzV4P3aI7on4swaxVoTtKnWPKtWZvQ7NWssmN0qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=jSImEvu1; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1762967462;
	bh=UH00cLBOgn6XmQGO+qGldoVEAxQ8CjDrPyUc2vYa1vE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jSImEvu1baT55TI/QIpvgq9TDLhb8ObaPYxF3D8AhV7cvnEKHAXjo6QZHuPknsZPz
	 UKZkydOyvmgakn6c9K7uIF3VxhsIpWRB+QT60jSgps2zyzCCX9q1GQ2mb3LjLNFkXM
	 cMOWOAGpJojODwN5tSKzpwkDjXw3OtyKBKsqEA/s=
Received: by gentwo.org (Postfix, from userid 1003)
	id 5E65C40251; Wed, 12 Nov 2025 09:11:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 5BF874010D;
	Wed, 12 Nov 2025 09:11:02 -0800 (PST)
Date: Wed, 12 Nov 2025 09:11:02 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ryan Roberts <ryan.roberts@arm.com>
cc: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com, 
    will@kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] arm64: mm: show direct mapping use in /proc/meminfo
In-Reply-To: <3af5d651-5363-47f7-b828-702d9a0c881c@arm.com>
Message-ID: <a6eec165-9c48-56aa-8b05-6bf73411e4bf@gentwo.org>
References: <20251023215210.501168-1-yang@os.amperecomputing.com> <3af5d651-5363-47f7-b828-702d9a0c881c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Nov 2025, Ryan Roberts wrote:

> I have a long-term aspiration to enable "per-process page size", where each user
> space process can use a different page size. The first step is to be able to
> emulate a page size to the process which is larger than the kernel's. For that
> reason, I really dislike introducing new ABI that exposes the geometry of the
> kernel page tables to user space. I'd really like to be clear on what use case
> benefits from this sort of information before we add it.

One is user space where you want to "emulate" other page sizes and the
other is kernel space.

The per process page size is likely going to end up
being a per VMA page size since these address spaces can be shared and the
VMA is already containing information about huge pages, memory policies
and other stuff relatd to memory layout. And yes it would be great to have
an accounting of the page sizes used in a VMA.


> nit: arm64 tends to use the term "linear map" not "direct map". I'm not sure why
> or what the history is. Given this is arch-specific should we be aligning on the
> architecture's terminology here? I don't know...

Other architectures are already exposing this data via the terminology
used here. The information is useful for seeing if there is an issue with
small pages that could be impacting kernel performance. It is surprising
coming from oter architectures that this information is not readily
available.


