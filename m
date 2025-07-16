Return-Path: <linux-kernel+bounces-733258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED1AB07233
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECDC1C2139E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8357A2F2341;
	Wed, 16 Jul 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wwF8lHON";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3eWALn6I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB451D79BE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659586; cv=none; b=rT5ZgGgc2Qw+YMclxilAP/KuGq3kFfky3QnWwiznvg/ZOCDZbMZrOTgrhJlmZrTNVN0xY895HLqsRTOY43qAS296gaeyJEUdCNbTxGL3lJazBuSM8KOuqYJmgHZW7pYfB02fkzkAR3aHKY/RiHfjGvfVvXT2fTcF6ljZ2tOz2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659586; c=relaxed/simple;
	bh=htq/y5LDVi8WvxV6B1yYtF/+yzz9ZOSygQgZN/cQKtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOWIt0qXRMars8a4XKdxjkFhL+xXye0BI0ymu/NPLgau82NPBt95K9Kz+D0e5D0O215eDHUpwTuThwW3Bt2rpmydm2vGTPy6sm0ICKueF2KWHV8+wM7f7Z4J1pX+BFSIgD0G4ksJW14Di3Iz3xCkOWNcxNdjcXLZqYa8IQeSoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wwF8lHON; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3eWALn6I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 11:42:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752658976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htq/y5LDVi8WvxV6B1yYtF/+yzz9ZOSygQgZN/cQKtk=;
	b=wwF8lHON0+SEODeAYAVrwIhSdSfLg7v2MW+ipMgP0qGz0XMnO22GoDWBJZXvnHfR50k+d7
	wFj7Q68/YeScWYfma0ndAxGU4vibTdRwn8mMbtEg02ZOrnBSx52hCoxwcXwYKb/bnZksIi
	FZHofy2lxwHt2YWJY69RKISoEVNE7vDMHl4hZBoBLoJxgUmBUBkaSTC05QUrpIy/jovwD2
	lQd7bgSMM1y2WH7Rqj6Kj6Ymo5aJRfo3d8xgZudIult/60+O20juHmmJGfrXnhdn1tHSNU
	yAYGXiK+wFz1YmED/didVIuIGrS8BI1TI+/7DYDATOiZHgNIwMckFrBfICayuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752658976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htq/y5LDVi8WvxV6B1yYtF/+yzz9ZOSygQgZN/cQKtk=;
	b=3eWALn6IGnUzABSPcuccXGYdAoaeB6fHQXIf9Pxf5E2XVqwxjAuiLy5NFU3PUx8OFACod1
	wG5qyHCg/l7xyJCA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 00/17] rv: Add monitors to validate task switch
Message-ID: <20250716094255.G8jDFxdw@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715071434.22508-1-gmonaco@redhat.com>

On Tue, Jul 15, 2025 at 09:14:17AM +0200, Gabriele Monaco wrote:
> This series adds three monitors to the sched collection, extends and
> replaces previously existing monitors:

I looked at the patches that I understand. For the others, I lack the
background knowledge to review them, sorry.

I gave the series a test run, and beside the opid's errors, everything else
looks fine.

Looking forward to v4.

Nam

