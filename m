Return-Path: <linux-kernel+bounces-871042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 605BBC0C4CB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C1619A0BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091392E7BC0;
	Mon, 27 Oct 2025 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4QvJwc1v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mch9C4D3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1499C29BDB4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553730; cv=none; b=Od61RtB9PIU/DaZ4JwOjm+HvSqk8d3sDe+6rvaCgRCez5zaQfg0wJDSLro1wZI1wThI/uCriZ5N63WhW9Uohcnqc+v36kO8pM5FJaVQK5boSxpZdqX4Vtgm3RWbiGNjyRR9x2uT7WaXWV8fzIYDrvRKnUZiSHbvWFzhIdbMrUOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553730; c=relaxed/simple;
	bh=7sA11dhN/QVMOM1/j4TSFs+i5hJiDKoiXuEXLS2409Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eouOO03Ab3aM3wE6d8kk3442VgaEBF28moKKRYm9dNDvK03rUUXzY9Ssb9PHVOPfxxWB0gF9Nrt+wfFOPzChvHvMRO6HdzwkcxSELbT//Kib7ibg4kDU0G/LIVEQsP2uYlKjRHXr4g6q7iHojwWWUjfOCk++sS7O23Qxnw9mlUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4QvJwc1v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mch9C4D3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 09:28:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761553727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+cQBym5IDI+MTBFlqTmutPdJN4ZAvN79yTb6V09Skg=;
	b=4QvJwc1vJR4TlaRurnOL7d1yzzdmNgrCMyuj+3R2F12MHIjlKhN0w3TP6yEbdONr2Tn/lF
	9RESt3XL91FR3BsNJueLvjQIKmupaR/kWNMFj8/vNnuizQqn8sDiTzcg506qeEabbwb5ZV
	I1hyHb352NT97C9hbNbmBe4/20vgsc/H7mVR1Kr4cPAbsGTe6fnQR1hrvBGHHcQzpG9BJk
	dwTdzpZGqGaJ1P1JwYKszxOj4zx+je7i3ENiCuQ1RCU3b8KeQSWpArWnts0l0ZF6InJUdU
	CPkkl4KlwFVrfKWxJuZ0LfTgb9uzlqiIu2QdWuumaPgAQfFFDim/YDlxoOKflQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761553727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+cQBym5IDI+MTBFlqTmutPdJN4ZAvN79yTb6V09Skg=;
	b=mch9C4D3Uh8/8gKx7W/XrrVhH3qCVweb7j+Q3+CmLggpbELSNhBPlOTDUNJJuOrkJezHur
	75PcSiT704rwIvAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251027082846.rsqK_B-p@linutronix.de>
References: <20251022154115.GA22400@redhat.com>
 <20251026150726.GA23223@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251026150726.GA23223@redhat.com>

On 2025-10-26 16:07:26 [+0100], Oleg Nesterov wrote:
> printk_legacy_map is used to hide lock nesting violations caused by
> legacy drivers and is using the wrong override type. LD_WAIT_SLEEP is
> for always sleeping lock types such as mutex_t. LD_WAIT_CONFIG is for
> lock type which are sleeping while spinning on PREEMPT_RT such as
> spinlock_t.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

