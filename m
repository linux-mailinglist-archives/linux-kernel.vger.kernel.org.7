Return-Path: <linux-kernel+bounces-855582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80759BE1B20
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3D7544632
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0252D3EDE;
	Thu, 16 Oct 2025 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hL2P5MG+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+yOrGEpx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337CB2D2491;
	Thu, 16 Oct 2025 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595813; cv=none; b=VA/3rnGpYgmX7aPb11B/xg+hH/kMJT7bE9m2Z9C0vwAPQ/xPwRUAob6l9OBn0NusvDUGoUIArRWnL3FthaqJx66RzdSFZmFR7JmEj5W5zUFm3HSSBdKX0RqTiMWC2v/jtoc3Pr5QCkPgDaVRpkBWwBDTqa+Ufy5c4T6oihJPHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595813; c=relaxed/simple;
	bh=0CPpd3r2+JiXAV7iWaIoZm/0pockh1lbSeU1ktXZCmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGSDc9wfyl6JqnT7SihMFeFV62qYh7fNjpAOeF4MIu+ddn1u6kykY9uemuVBOeKsnZLabVZeRJLvk5VYu8D/hhC7vb9iMMED7lhIId9dqTicQBLsUa/fdrANEmVYmXV73659Tie6GoJY/1+BaCQlGiVSmPvMkvVpsElcohvkSUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hL2P5MG+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+yOrGEpx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 08:23:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760595810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0CPpd3r2+JiXAV7iWaIoZm/0pockh1lbSeU1ktXZCmM=;
	b=hL2P5MG+L/u5KnvpAk6L7Jc9fJ54PdIbXrUfglH83MbdFqPo+NqkZXxaOsc9tUd/Lu1zEv
	3Vd1bnycw9UIK16ZIF7h7WWHS5bxiBmKX0qyD84rx4Wxcj1k0ispdWDcJayxZHQWdJkWi/
	eKHN1O60N5SeREnRFN2EwC60MbEwF/5I29MShFs2zWulsGCv+sxrTVB1WMMp3Yvdb1o0JB
	NS+LsQCleHAl4MqsKeevL0/PMDguNqjpPjrQFepGT880/JpgIqhgNiSBjsrf66EoxiMjiz
	LhDAGPaWg+6LEen2+ww1JrzkSXqF6Ut9MIw296F6y63ABS7fFhjFEVMT2yD7dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760595810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0CPpd3r2+JiXAV7iWaIoZm/0pockh1lbSeU1ktXZCmM=;
	b=+yOrGEpx0SuF7nwBqB68SfpOyTuaiNoP9XFDZ//B2blRsef3WtqCaxvj4afpa8XA50wxpK
	4VyppyS4UTLR0rCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 1/5] man/man2/prctl.2, PR_FUTEX_HASH_SET_SLOTS.2const:
 Document PR_FUTEX_HASH_SET_SLOTS
Message-ID: <20251016062328.opEmh86n@linutronix.de>
References: <20250915141305.906440-1-bigeasy@linutronix.de>
 <20250915141305.906440-2-bigeasy@linutronix.de>
 <ueacsjksonhqg6pt6hvlav4uhfms2vrqttfez3ouryud5myhb6@uunect56gya2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ueacsjksonhqg6pt6hvlav4uhfms2vrqttfez3ouryud5myhb6@uunect56gya2>

On 2025-10-15 23:29:39 [+0200], Alejandro Colomar wrote:
> Hi Sebastian,

Hi Alejandro,

> Sorry for taking a month to reply.

No worries, thank you.

Sebastian

