Return-Path: <linux-kernel+bounces-858088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2350ABE8D79
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED396E2C16
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67BD350D66;
	Fri, 17 Oct 2025 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p7FlZSQc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0oOt3xZi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B4350D4B;
	Fri, 17 Oct 2025 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707745; cv=none; b=iSKhbVlxBu7rri7GU7vkOG33l51OcniR0QZw5NAxwuKjzerlNzDYO1IRiMkoRFa7gWxegQ010BNP/ICgK/sDmj33T4XEsiMhCSRbGGlmvHrbFPB6VTVd2s8qchnRq8oLXkIwGiGuhd+RxkW2ElqZZshGZOmINBCt46VcrCMxi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707745; c=relaxed/simple;
	bh=FCb6l5ObniXxTIJOJBll3JU9Fu/sYJFKIcRGtHY6frc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nx1Gz8cKwFfl1iAxk71sCSOu5HYDSB2xhAYYIuMK89j5bN527l2HJ65ctPkzZ02LG93zlFhoREz3UTOipxjPyepWecwmwSOv/1Qbuj7vPDS18PuxGxm3tp21OhSRoXn8ADFzi/cOMIptNVV2HwU2BFplJGALrhDg+J7mjbqzplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p7FlZSQc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0oOt3xZi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760707740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCb6l5ObniXxTIJOJBll3JU9Fu/sYJFKIcRGtHY6frc=;
	b=p7FlZSQcAvWYom6XD4RC1BVusPQNBd77BuXglxpg+DCDbQRSihlZad8s8KkFq8GzZ5iZIe
	2HrVaHGAht83q1/fXEHKj72H9MFP1752bzcQKbS3B/bO6sZlyWs8G+h895amFBLurzAry5
	0QxOLP6shaQDSAdcons0opzYr3pnqDtXzimvuHl5c5f3b9wAj0eg8TArIxrwc4vnbIw8YH
	1nwqaBQyHsT92OTeqb0azRGz05XF3UNvI9Rqzjeu7rrGY1rDd8y0/ZhnVQPjTGLHkHJi8N
	7PX/F07JCYIFyWiBOOYu2u8+piT2Iw6UkCct//Ed9ip/LG5WMAokADy2EDPvEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760707740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCb6l5ObniXxTIJOJBll3JU9Fu/sYJFKIcRGtHY6frc=;
	b=0oOt3xZiIZOnwlVFS3EqsCKSMb5+HZD9ZLIItx6umf2eU145EyuqLUWvc0JOH6XIQPhxLJ
	5ZcJL149p74D26DA==
To: Charles Mirabile <cmirabil@redhat.com>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, cmirabil@redhat.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, dramforever@live.com,
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, lzampier@redhat.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, samuel.holland@sifive.com,
 zhangxincheng@ultrarisc.com
Subject: Re: [PATCH v5 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
In-Reply-To: <20251016195902.338629-1-cmirabil@redhat.com>
References: <87h5vy20o9.ffs@tglx> <20251016195902.338629-1-cmirabil@redhat.com>
Date: Fri, 17 Oct 2025 15:28:59 +0200
Message-ID: <87plalzmg4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 16 2025 at 15:58, Charles Mirabile wrote:
> On Thu, Oct 16, 2025 at 07:53:26PM +0200, Thomas Gleixner wrote:
> What do you think about the attached patch (it should be not corrupt :^)
> I think I adressed your concerns, and I ran it through clang-format too.
>
> I folded everything into one diff for ease of review, but when we send it
> officially there will be a separate patch for the caching refactor.

Looks about right and it's a net win for everyone due to the suspend
path cleanup.

