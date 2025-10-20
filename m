Return-Path: <linux-kernel+bounces-860441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFDABF0219
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC983BE061
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADE92E9EB8;
	Mon, 20 Oct 2025 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS2FDPKc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFD233987
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951894; cv=none; b=uqswFNhbpYXsCJ+pXKov4j2X4D2cfR9VJahYEyGJN5kXNoliJ58RGPsywji1I+dH20VVmEndvVIpL/t5+XhlC+59h7uH1jtynRSOgCpv6W21e2ZvXdSl99I/+B+un9hJvuOlrzXd9JBMqwdAiJ0ROxyOajAuwrosJlS1ZF66URc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951894; c=relaxed/simple;
	bh=9hWV3tQD515DOMi/P0T7F8Fbww3uIzWpB+Gco+m9IqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ql6RT9aeFzo95BZsqv10lUtum/LxwmP+ce0IT5NiW6dOTE6Q3vr9VszHHKQnqjTxYbdRGpB/4URhKfRQJlwy583J/TU1muHKXNdQVSCkvXTDlYYq0NpoLKKEqC1efJkYwK7gWwQW6X2Yumdd+gmN8YJpQS0POzgMBCqvem4XhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS2FDPKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB313C4CEF9;
	Mon, 20 Oct 2025 09:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760951891;
	bh=9hWV3tQD515DOMi/P0T7F8Fbww3uIzWpB+Gco+m9IqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bS2FDPKcFY/SpT5JssQrifykT4c6G0XMcC0RQ/Rp552UHKHx1KzvrmuAakbloN+pB
	 PTbUp8WVjGfqbrIjpQNU8fAAwker1lecJ6BKjAghABX68pTjiqZ9tW2wQI66UN8u95
	 ApzIMVDA/i0BPk0OPtfSTCPVGIj1SBLoxtsZAEcOPr80CQB67S2VU8t4RghCVPRVmW
	 EUZCso+gYiE+sZk+zblePAYO83kss23RLYeR4P/uYzBz4r1x/F0RfOLT373/LXlTT7
	 ZRWvzrDk9NVI5QP+9bbyx1RoH46IS5JDNbRF4crpUYoethn91BZG5BUfApiJS+6YoI
	 GVBzKM9g94S8w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAm1w-000000005uB-2lHy;
	Mon, 20 Oct 2025 11:18:16 +0200
Date: Mon, 20 Oct 2025 11:18:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/qcom-irq-combiner: Rename driver structure
Message-ID: <aPX-WBsUUXXmpqdg@hovoldconsulting.com>
References: <20251017055226.7525-1-johan@kernel.org>
 <87sefhzn18.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sefhzn18.ffs@tglx>

On Fri, Oct 17, 2025 at 03:16:19PM +0200, Thomas Gleixner wrote:
> On Fri, Oct 17 2025 at 07:52, Johan Hovold wrote:
> > The "_probe" suffix of the driver structure name prevents modpost from
> > warning about section mismatches so replace it to catch any future
> > issues like the recently fixed probe function being incorrectly marked
> > as __init.
> 
> I take this grudgingly, but not without pointing out again that this is
> just a horrible hack. Why can't this stuff be properly annotated and
> recorded in a throwaway section so that modpost can act on reliable data
> instead of using string matching on arbitrary function names?

This apparently dates back to 2006, but some of these magic patterns
were at least dropped a few years ago with commit e1dc1bfe5b27
("modpost: remove more symbol patterns from the section check
whitelist").

With the irqchip driver fixed and soon hopefully the stm clocksource
driver [1], we can retire also the special handling of the "_probe"
suffix. I've just sent a patch. [2]

Johan


[1] https://lore.kernel.org/lkml/20251017054943.7195-1-johan@kernel.org/
[2] https://lore.kernel.org/lkml/20251020091613.22562-1-johan@kernel.org/

