Return-Path: <linux-kernel+bounces-840906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1932FBB5AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABE404E4066
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425B91ADFFB;
	Fri,  3 Oct 2025 00:52:46 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED68EDF72
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759452765; cv=none; b=CIQHhLfTtz/Iz0kN5BOHbvTODLGM19T0zj7rabOKUkJpjczpCC3hk2+LmU8djxBPwgnGD01/Eh9FsO0sbWM7S0BB9YmgG26FmETtiXmKNaE3CV/3wWsRsw8S4e2Bzou0dbSQGdXMcTiwwJyNt70If+oYMbU+SKeRmdCPlwzlgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759452765; c=relaxed/simple;
	bh=x3K+T54pQmuKD7sU1shs/LBsxeAFFKSumqDzX1Xb7qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY/viO6A0WS7ufXOPV6vAlfRJ1sEUh8i1+6EZ4KLRE3esAOU7N/55YTtBZ/VdZ/0NasjikaIkwtUqDsE3+fI870PtfjjjyQmWpg7DzSW30FJP30iWne7t0QV9wY4XIxQHwoYdItvgBDUiX1uCYj8/GiAVNUS9uQhGB9PRNrbV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-70-68df1e53a707
Date: Fri, 3 Oct 2025 09:52:30 +0900
From: Byungchul Park <byungchul@sk.com>
To: Hillf Danton <hdanton@sina.com>, ysk@kzalloc.com
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com
Subject: Re: [RFC] mm/migrate: make sure folio_unlock() before
 folio_wait_writeback()
Message-ID: <20251003005230.GB75385@system.software.com>
References: <20251002081612.53281-1-byungchul@sk.com>
 <20251002220211.8009-1-hdanton@sina.com>
 <20251003004828.GA75385@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003004828.GA75385@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsXC9ZZnkW6w3P0Mg697zS3mrF/DZvF1/S9m
	iwM/n7NYXN41h83i3pr/rBZfVq9ic2Dz2PRpErvHwt8vmD1OzPjN4vF+31U2j0kv3D0+b5IL
	YIvisklJzcksSy3St0vgyjgxbTJ7QRdrxbbGLvYGxh/MXYycHBICJhIHvvxggrEv93SC2SwC
	KhIrdu5lBLHZBNQlbtz4CVYvAlTzZcsxMJtZYBKjxM71hSC2sEC4xPT2cywgNq+AhcTsA1eB
	5nBxCAn0M0p8+rKaFSIhKHFy5hMWiGYtiRv/XgIVcQDZ0hLL/3GAhDkFLCUm/7sHtldUQFni
	wLbjYHMkBFawSczfeQHqaEmJgytusExgFJiFZOwsJGNnIYxdwMi8ilEoM68sNzEzx0QvozIv
	s0IvOT93EyMwtJfV/onewfjpQvAhRgEORiUeXo+CexlCrIllxZW5hxglOJiVRHgTVtzJEOJN
	SaysSi3Kjy8qzUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cAYd+MIo534pZ3B
	G094393dYcSg+tS55uWk71lP+14lG34SzeM3FH+78NEOt3pVm9NXon7FZwV6RU//936LWvhi
	pu1SdoLr2ew//pb2c9D8w1wRvbFEqmHyvy7BLx/FNnxN8lzAkpVQxH1UU+9Bz8H8oLWLGLeZ
	WodZ/LtmsWLi+9q4uvep2iuUWIozEg21mIuKEwGGbsp0aQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsXC5WfdrBssdz/DYN9aLYs569ewWXxd/4vZ
	4sDP5ywWh+eeZLW4vGsOm8W9Nf9ZLb6sXsXmwO6x6dMkdo+Fv18we5yY8ZvF4/2+q2wek164
	eyx+8YHJ4/MmuQD2KC6blNSczLLUIn27BK6ME9Mmsxd0sVZsa+xib2D8wdzFyMkhIWAicbmn
	kwnEZhFQkVixcy8jiM0moC5x48ZPsBoRoJovW46B2cwCkxgldq4vBLGFBcIlprefYwGxeQUs
	JGYfuAo0h4tDSKCfUeLTl9WsEAlBiZMzn7BANGtJ3Pj3EqiIA8iWllj+jwMkzClgKTH53z2w
	vaICyhIHth1nmsDIOwtJ9ywk3bMQuhcwMq9iFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIDNRl
	tX8m7mD8ctn9EKMAB6MSD69Hwb0MIdbEsuLK3EOMEhzMSiK8CSvuZAjxpiRWVqUW5ccXleak
	Fh9ilOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwLlt+hmt5wvG2r0HfFMOt2m6r5Ua3
	RoXFNUzhDFkpnTRbin3id03hrb9WH1c8dILZMvLh8aKdn8zyqmfv39PS2LR+XzDnk7+n2uad
	vnwqVmFas1aC6FnPsmcbinpv8N+fHJ/M8HuedobfdqWnwStCovgrZi4xO5ZYXKE7y/Ts49nr
	V0R/+dDrqMRSnJFoqMVcVJwIAHatfuZQAgAA
X-CFilter-Loop: Reflected

On Fri, Oct 03, 2025 at 09:48:28AM +0900, Byungchul Park wrote:
> On Fri, Oct 03, 2025 at 06:02:10AM +0800, Hillf Danton wrote:
> > On Thu, 2 Oct 2025 13:38:59 +0200 David Hildenbrand wrote:
> > >
> > > If it's a real issue, I wonder if a trylock on the writeback path could
> > > be an option.
> > >
> > Given Thanks to Yunseong for reporting the issue, testing, and confirming if
> > this patch can resolve the issue, could you share your reproducer with
> > reviewers Byungchul?
> 
> Sure.  Yunseong told me it's 100% reproducable.  Yunseong, can you help
> him reproduce the issue, please?

+to ysk@kzalloc.com

> 
> 	Byungchul

