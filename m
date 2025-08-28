Return-Path: <linux-kernel+bounces-790694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1482B3ABD2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFE2567E78
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752D3288515;
	Thu, 28 Aug 2025 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oASrOklJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1C27B330;
	Thu, 28 Aug 2025 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413639; cv=none; b=GQlUxA0LyKK1EOgL+l0odWvCX50zaxL254gDEOLXW1a+i01q5K6Ggbofn0VuBQZVgv1Fm5lsD9k8DF8QcgS1s1TZJuehvwCKMZCFLVcyEgkxwyDw153uMekN7EAP7ipee+NBF3c7JnRkYfRzuzd+DEtQ2PxpKd4I0UnZFEpFf04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413639; c=relaxed/simple;
	bh=kSd9yQ5EINKYpwqi6yUYFPe1ps+5gMFanto3kxgPNGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMnTj9/bBScEmTdGXewe5WC4ZFUCXKJVK28lmJJr1LLs/YVxQH6Zw96YoHppLfNeuzeBCgQkATEcpLnI+YvIg36eITpb8kXVJLbvwEcTbZUIFtBAm4iwJINFSpY4loSb0m5YuRZBbMj/YPPRlNDlgGQspdfCS6mWVv7oREzIy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oASrOklJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26505C4CEEB;
	Thu, 28 Aug 2025 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756413639;
	bh=kSd9yQ5EINKYpwqi6yUYFPe1ps+5gMFanto3kxgPNGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oASrOklJJgORMInU8rbv3sn1bDbUqM6i2oWdWH98H3IhdGeV4J2N8s9jgiNE/6OJf
	 OMf2QTGYEy/SlmGfj7yZDVFvrO08c6tAzz8z7immjy23IeA3DmLPULA9szb6QsIYAl
	 mgZbGbSRfNwua09FnixrpxWRzzDqOin2FVHZ4kaA=
Date: Thu, 28 Aug 2025 16:40:38 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Brian Masney <bmasney@redhat.com>
Cc: Ryan Wanner <ryan.wanner@microchip.com>, mturquette@baylibre.com, 
	sboyd@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, varshini.rajendran@microchip.com, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v3 00/32] clk: at91: add support for parent_data and
Message-ID: <20250828-spectacular-lion-of-reward-3afda3@lemur>
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <aLB7CJY9nMLoS1or@x1>
 <08dd4d82-8ac4-43a3-8d01-f293db6302e2@microchip.com>
 <aLCIcWIJ4Nfqt7oi@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLCIcWIJ4Nfqt7oi@x1>

On Thu, Aug 28, 2025 at 12:48:49PM -0400, Brian Masney wrote:
> > This was developed on 6.16 but when I bumped this thread I checked and
> > they all apply cleanly on the v6.17-rc3 tag. I also just tested on
> > next-20250828 tag and this set applies cleanly as well.
> 
> I initially used
> 'b4 mbox af762c93-c9d0-485e-a0d1-7792e6e37c09@microchip.com' to download
> the series, and tried to apply it with 'git am', and that's when only 12
> of the 32 patches apply cleanly. I expected to have to 'git am --skip'
> on the cover letter.

`b4 mbox` downloads the entire thread, including followups, and isn't really
intended to be passed directly to git -- it's more aimed at people who want to
read a whole thread in their preferred email agent.

> However, if I download the series with
> 'b4 am af762c93-c9d0-485e-a0d1-7792e6e37c09@microchip.com', then all of
> the patches apply cleanly.

This is because `b4 am` will make sure they are in the right order, etc. This
is, in fact, the command that is intended for this purpose.

Hope this helps.

-K

