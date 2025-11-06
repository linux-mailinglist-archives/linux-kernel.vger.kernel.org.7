Return-Path: <linux-kernel+bounces-887926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D4EC395D0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 137C035054F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9CC2DFA31;
	Thu,  6 Nov 2025 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YYtAtcrR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a20eB2rW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF962DEA86
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413379; cv=none; b=qLBk2t4tGHv7nz9cxy7v6sidgzE3DH3uthHJxUx/AaaS9lCaWxjTvB9sqde81q1HtEpqVstVjx1NRbh1jG7wSmlkksRdGJFhtOg4fUaI9yp6bM9pBdPzkRoMlWkAOkCe00kUaTdqI0evoijLXFW6igaALO9xpDe9RbV9HOkqpoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413379; c=relaxed/simple;
	bh=PYVe0YefHeOGwpJtyDaHQWLh3lxPJBIeu0lw3Am9uRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/1oJIwqoi5VRXeSRHJdjRnHKFvQwL68oCM+ozZhBByBrSflBBHLkT7SdKsbKBPBjO3AXF52Uc9Bsx3dSf4tlvHeJgv5PpMdhEjHGTYahqv5r8CBGtrsYh/rK/UuIVqXf8CkCdouesxZFj69b5ScqN1uWBPyA+GwOYczt/FFBjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YYtAtcrR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a20eB2rW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Nov 2025 08:16:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762413376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79qqpFdoph7V4G7CFQzW8+xT0niEy4TMYytCNaNsGsM=;
	b=YYtAtcrRbpgVNIyRfx0wH+ZfYtP/1Eg5PlZJiCUXmlsZPm3P6+W5i0Jg0LfntMgFJFyVFL
	fpSa3HVwf8PYsv4tvxbWyGAK80t35PcMct9Tj8mFvZuGFSWcR6HAXDy3ZDsf6hdi/fjmpL
	O4MPuo4/kCl8W278RCrtVB+ebqca1AyOtyOavkKv1xKe5V2uYMPe23rZGa6hAJm8swqlx7
	oS+jDWS25nm5Rt1WgpUqhX3hLRT9oTVZFPkIzrJCFhZRdiuYoqaOe5M4Xsa6h6R7Nmy/JV
	AgFWV9zWmLHPuf0fc5EASjfZpBBy0NiE8O6uNZcw5opFYejs/R/Mw89Kme0KdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762413376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79qqpFdoph7V4G7CFQzW8+xT0niEy4TMYytCNaNsGsM=;
	b=a20eB2rWBroHtc34xLKgCn9pZW7B9MmUoNBiQzbWqhdhHTUlVK0yT+Q6AozJQ4zJLISNhR
	+Ww8NKnm0RSwSfAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com, airlied@gmail.com, simona@ffwll.ch,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	daniele.ceraolospurio@intel.com, alexander.usyskin@intel.com,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	baoli.zhang@intel.com
Subject: Re: [PATCH] drm/me/gsc: mei interrupt top half should be in irq
 disabled context
Message-ID: <20251106071613.xi1ETeFG@linutronix.de>
References: <20251107033152.834960-1-junxiao.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251107033152.834960-1-junxiao.chang@intel.com>

On 2025-11-07 11:31:52 [+0800], Junxiao Chang wrote:
> MEI GSC interrupt comes from i915 or xe driver. It has top half and
> bottom half. Top half is called from i915/xe interrupt handler. It
> should be in irq disabled context.
> 
> With RT kernel(PREEMPT_RT enabled), by default IRQ handler is in
> threaded IRQ. MEI GSC top half might be in threaded IRQ context.
> generic_handle_irq_safe API could be called from either IRQ or
> process context, it disables local IRQ then calls MEI GSC interrupt
> top half.
> 
> This change fixes B580 GPU boot issue with RT enabled.
> 
> Fixes: e02cea83d32d ("drm/xe/gsc: add Battlemage support")
> Tested-by: Baoli Zhang <baoli.zhang@intel.com>
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>

Sounds reasonable.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

What about intel_lpe_audio_irq_handler() ?

Sebastian

