Return-Path: <linux-kernel+bounces-830324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ACAB99664
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5D7322ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D6D2DCF73;
	Wed, 24 Sep 2025 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ghscz7Eb"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F792DBF69
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709170; cv=none; b=mBF5PsJsQST1of2FNJ8wRx6Ky5dl0iTJRoc9vrczQ4ydySptAEhzX6BMCAC3g0o4sSUMqDLHQcUmFoDg9Z0puEqnDB//n0Bre5Ez1V9v5tW0vmghEablLnARWzzgoGRnfrh+e0OuDkQjn3OA+n0DmLjdqOiMkZCvZzLsQ7iTTSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709170; c=relaxed/simple;
	bh=aLD11utVK0Afx84XbSCjZ0XlW7eTV1MmaHA5baYQatY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHyjA5mWOabo9ZW3EybZPhlmeHhF7sLWQkHROVZJXVASlK/KyRFYR/d98bfvRYKQ819AvrdxyhbTpeIRYIJhs5EYr2SBHqNsflYM4PJhGjUWZojqUASnF0j1y61HyYNnFdxlqm6qiZgrQATsFoVAuXz2riLyfoapNLzpTsYbx1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ghscz7Eb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GULcH47ok0t2Xg1AsPuO/xZ9L5b873EalUMP2bFcLlI=; b=ghscz7EbRGtLH1MmbPPyDhnW79
	i34aaxsIGMOF8oTjJLF6YWsL0xBWTNDLNVGopbLzPWv+mvKmVe5+A96sWdXpwar9ZZlgDwbJDrIlk
	w1qqMcJecnXC6XDbbvE1qPZIQgq42AlxmH9Y3s8iS5n+Y7l47sZi1vPrzMg6G3ClkR/s+UNKZNlYA
	mdfhN4GRDIN18mML9GUsegyTlOY/OV7/jyPf4xoQOymLhywsB92kaFm46/GXv1ReZsgP3F6uApyc7
	N2GIO1xSmIkDkTgLFOOhD6LIu3n8/0wwQqu7cecmG3nIylreSm8WrIWeBq97Rl4mbtfGMjK51S7pW
	TcMo6b3w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1MSN-00000008ijs-3vh8;
	Wed, 24 Sep 2025 10:10:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF70C3001F0; Wed, 24 Sep 2025 12:10:38 +0200 (CEST)
Date: Wed, 24 Sep 2025 12:10:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
Message-ID: <20250924101038.GZ4068168@noisy.programming.kicks-ass.net>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250924073649.GT4067720@noisy.programming.kicks-ass.net>
 <20250924074206.GW4068168@noisy.programming.kicks-ass.net>
 <20250924100847.GY4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924100847.GY4068168@noisy.programming.kicks-ass.net>

On Wed, Sep 24, 2025 at 12:08:47PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 24, 2025 at 09:42:06AM +0200, Peter Zijlstra wrote:
> 
> > > >   d051:  perf_get_x86_pmu_capability+0x51    | xchg   %ax,%ax                                          
> 
> That libopcode is 'funny', isn't that typically spelled "nop" ?

Ooh, I see, it is "osp nop" and yeah binutils also seems to do that as
"xchg %ax,%ax".

