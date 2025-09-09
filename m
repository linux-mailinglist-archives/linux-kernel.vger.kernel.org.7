Return-Path: <linux-kernel+bounces-808939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAA2B506B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184E01BC3E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B691304BBA;
	Tue,  9 Sep 2025 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JFPGY/Pf"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A81D799D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448540; cv=none; b=BDCczKc+6dt1yUf5Tl11+ya49TaZaWT65tkRtGh0eKiX7CZcIth4sQWVb2nyehhS9eBp/sczcfE3DOmBB73aOMzxgJVUViAnYtCD23jlDD04CNLklgLkwDmAS9y+XGPSsc97lS3ZP5e34zbH7t2NgfX6DrbNS5ZwfzKdrn+vsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448540; c=relaxed/simple;
	bh=+F/GB9tMq/hxCpkmrv63SuNDyZYB5Z2nZLwJOyUFF/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGyhT0JRn7l8n/B3NQkcBXUqqR0bFJxIcFexV3EvyhmJsufWR+cnnVEy8oZeiTBh4cOVrQ5ORLtV+cL6tpCMCAsS7syJ0m3hQD5AxVela7QpXCh28ouqhZtf70e9od5Sk1B0YNZWkNDOSJZIhN0QVs1x1CAMcQVTmTnj0oNuzXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JFPGY/Pf; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 20:08:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757448536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=onphwuquionzzJcm9VbxKLWllVFJmEFE04yOUJ+NAjE=;
	b=JFPGY/PfIAFsR12C4a6aZ4MYme3pv5mVUxvMoVTXTJhn28IOFKPF5bST4EpX5+v8Bg3pi7
	x6EAH+QoZgli+A00jukw4toi7mtpIFyfQbC3acrU+/P97joe/gtoGvk8x2JFZpo48n86eM
	pvqV5S12DrWp6KpoM8Gn0NrRVPhPkTY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: zpdesc: minor naming and comment corrections
Message-ID: <3hd64ocpeiw7q7eb2nvb4bofhr6pwerqesnya6mceua4nmux2o@cxnmm6avhxom>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-4-hannes@cmpxchg.org>
 <mgt4ejjyz64ehnyskv24nzjllxxie4jvxb6i2dzlq43yev5dtu@sfltngevykts>
 <20250909151113.GD1474@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909151113.GD1474@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 04:11:13PM +0100, Johannes Weiner wrote:
> On Fri, Sep 05, 2025 at 07:05:22PM +0000, Yosry Ahmed wrote:
> > On Fri, Aug 29, 2025 at 05:15:28PM +0100, Johannes Weiner wrote:
> > > zpdesc is the page descriptor used by the zsmalloc backend allocator,
> > > which in turn is used by zswap and zram. The zpool layer is gone.
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > ---
> > 
> > Why not rename zpdesc to zsdesc or zdesc while we're at it? It's a lot
> > of noise but it's just this file and zsmalloc.c IIUC. Up to you.
> 
> I'm kind of fine with zpdesc and not sure the other names are this
> much better to warrant the churn. So if you don't mind, I'd just leave
> it alone for now.

I undestand there's churn involved, I am fine either way.

> 
> > If it's just the comment changes I would squash it into the second
> > patch, but not a big deal. Either way:
> > 
> > Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> 
> Thanks for your review!

