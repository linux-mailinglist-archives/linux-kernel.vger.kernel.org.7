Return-Path: <linux-kernel+bounces-721667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A3FAFCC2F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9B31BC2B4A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ED52DECB4;
	Tue,  8 Jul 2025 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jr/wD7/3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IaMKETVw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F593EEA8;
	Tue,  8 Jul 2025 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981500; cv=none; b=j45nDQKbWkELbx0IfRGTLubUTWTWIOZi0XXxWQwlfG+wAQCAZZ6u9mc515c4k8vqNjD3RXIZByAUMcMSgUUStxNo4+dSjLui04RnLrvns7r132wxtpy+Qlm8yu72lBhqYNN+5vcd57J6NnWKhy/17KKYobDm8VmXAWX/6vhN+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981500; c=relaxed/simple;
	bh=CP0kEgZNJOllWaDHiOX/Qwki1+HvnDoA4dtbZzijyGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR0U8KAa4vxnvU0ihJVopKphqPBGQzBdkIYlYYOcsiy+qV9p7Q213cixEc9P5IklQw3AMrPq5JmUbeBGCH3CPVLFRDKg3GOafi2spxUtptNr6k75nNycRqlX6Nu+Vy4gXAIe9hUblTB9wmxMf5WUNYgpjnl/jC7BEfnPkkkWv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jr/wD7/3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IaMKETVw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Jul 2025 15:31:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751981496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2d7vS40rYvw8brUay1AuwTlIijasoRsP5SIdJYiBzWo=;
	b=Jr/wD7/3Psk+yzcDAp/4R5LG0ULE94i7AcVzyGSyff9Vy6+U5bmz1Ph9CQbD2aLOsQRP8V
	cIsUs5KFjqwCu4xnR8/8ndfXNv1FJpdMjyN3A/v/LpsJ3ly7MlhIkIgfvlJqSVtwymwOag
	qpFJhD45yZ6COedK6GXUQFeDoafS/JRH+CYcB/Eho5J92ZN/vmfIKbxLb2/tG8r2c9TCgB
	zH+OQUs6/yfP117naULj7vXDca+mLegJj+SZgMc248K+6Df7/uEZu/9aRHki2ckJZJDTGo
	56ZWV59F+IeVjOegfNpEDMKSNEs7mPquGl8vRxUCv/ndVw4fTlY65O6pkD8xAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751981496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2d7vS40rYvw8brUay1AuwTlIijasoRsP5SIdJYiBzWo=;
	b=IaMKETVwMomUmbk9fwh5BMVICT0FHlGDBDsmfq4p+vckNb38q9zA2Nv5Qf4d3xF6BtsR/Y
	VKWJgi8/6Y3fEhAw==
From: Nam Cao <namcao@linutronix.de>
To: Will Deacon <will@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 17/22] arm64: mm: Add page fault trace points
Message-ID: <20250708133135.afWClD2E@linutronix.de>
References: <cover.1747649899.git.namcao@linutronix.de>
 <61063f55e2c2df6db69cb63eac9d6653f38fbfbd.1747649899.git.namcao@linutronix.de>
 <aG0aIKzxApp9j7X0@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG0aIKzxApp9j7X0@willie-the-truck>

On Tue, Jul 08, 2025 at 02:16:16PM +0100, Will Deacon wrote:
> As per the discussion with Steve on v6, I still object to relying on the
> arch code to call all these different trace helpers (rv, kprobes, perf)
> in the right place and consistently with each other.
> 
> In:
> 
> https://lore.kernel.org/r/20250519120837.794f6738@batman.local.home
> 
> Steve suggested wrapping some of this up in a core function to help with
> that.

I have dropped this one from my latest version, so that the series can move
forward while we figure this part out.

Best regards,
Nam

