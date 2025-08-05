Return-Path: <linux-kernel+bounces-756610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C37B1B6AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233E43A781F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEC827817A;
	Tue,  5 Aug 2025 14:39:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2023AB8E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404765; cv=none; b=ojAf8k9t8HH1EPzxJOYuvJCTK21RC6ZQHmdPqOZmaB9GXv29IcUh/0VX1b6cX7VQHPvp7xqaepC6u+wzKouQ9rjNCOKG5Zkxhs2040TkclgHRv95cg/jGxbfzIdbKi/ZCQy5iI1CwTea5aRwe2fLdsVc0cY37qNvo7VjfCeFOcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404765; c=relaxed/simple;
	bh=U5eTuVE6fNkIPrpKT788ELmfmNfZJfkcMAxo3FMzxdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKvm0r6Vk784q4+/H9QcR/4SRsXWs3zhtll0K65rcnuD5FyxTCcQbFrIecrbXz3rcVOzB+iQhH2RYbVrVM6ESGJqJx6si8u+xJ6kBZl71Xc4zBusD/odOVt9NCxXpildmBsjl9H/RwIrd3LbJ6bEXL+LGltFwoIByFh62HAF8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED10C4CEF0;
	Tue,  5 Aug 2025 14:39:23 +0000 (UTC)
Date: Tue, 5 Aug 2025 15:39:20 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
	akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
	dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 0/4] arm64: support FEAT_BBM level 2 and large
 block mapping when rodata=full
Message-ID: <aJIXmIgCGlWlHDNK@arm.com>
References: <20250805081350.3854670-1-ryan.roberts@arm.com>
 <985f9d53-ea5e-4da0-9427-106a58be7f26@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985f9d53-ea5e-4da0-9427-106a58be7f26@arm.com>

On Tue, Aug 05, 2025 at 09:16:31AM +0100, Ryan Roberts wrote:
> On 05/08/2025 09:13, Ryan Roberts wrote:
> > This is a new version built on top of Yang Shi's work at [1]. Yang and I have
> > been discussing (disagreeing?) about the best way to implement the last 2
> > patches. So I've reworked them and am posting as RFC to illustrate how I think
> > this feature should be implemented, but I've retained Yang as primary author
> > since it is all based on his work. I'd appreciate feedback from Catalin and/or
> > Will on whether this is the right approach, so that hopefully we can get this
> > into shape for 6.18.
> 
> I forgot to mention that it applies on Linus's current master (it depends upon
> mm and arm64 changes that will first appear in v6.17-rc1 and are already merged
> in master). I'm using 89748acdf226 as the base.

It's fine as an RFC but, for upstream, please rebase on top of -rc1
rather than a random commit in the middle of the merging window. Also
note that many maintainers ignore new series posted during the merging
window.

-- 
Catalin

