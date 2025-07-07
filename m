Return-Path: <linux-kernel+bounces-719713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F326AFB1B1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 12:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B8B4A1581
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CE6293C50;
	Mon,  7 Jul 2025 10:54:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15A22874E4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885658; cv=none; b=oWZta2dapNljcX4MA8b2iVJ4Ndsgqcey96E2PlTrtj4ryPfCt9mQ9wwMlJrk7dcZ/AgsBS7bnf8kQWwWu3M9UXnRW+vZM2E3/aTGcteOQx2JQ0ct74qYuRgtGd8sm9Mwy4xBGhhr6h+N+I/DZB6ZbRGVoyHLXKcsDrm5vSHVbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885658; c=relaxed/simple;
	bh=o4b92mV0aqyLoJq1px801w38uYxi3WAQMdxMFN3o8vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgABXGrayPd4ByCPfuGeAqWTyQoUMvvfhcSG1UdHGjjcbVr/Syxz2vSpoM6BLowF5GDtSGJ55+sHSjgiPLu2kuVoxxsz3mW/+C5KEtsT/FKnyCIJercnjxtY/6t0wefJsp1RlFOTGtpuKtm9urKj/ZHK7h9IuGO30YKvYfrPFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F1AD1595;
	Mon,  7 Jul 2025 03:54:03 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8A7F3F694;
	Mon,  7 Jul 2025 03:54:14 -0700 (PDT)
Date: Mon, 7 Jul 2025 11:54:08 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 10/23] m68k: ptrace: Use USER_REGSET_NOTE_TYPE() to
 specify regset note names
Message-ID: <aGunUMZ+X7pT9Dqj@e133380.arm.com>
References: <20250701135616.29630-1-Dave.Martin@arm.com>
 <20250701135616.29630-11-Dave.Martin@arm.com>
 <CAMuHMdWwN7iMvMeC66SFD19s-xX6d=hDYZpvzBqEXSZ4_fPuuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWwN7iMvMeC66SFD19s-xX6d=hDYZpvzBqEXSZ4_fPuuQ@mail.gmail.com>

On Sun, Jul 06, 2025 at 11:25:21AM +0200, Geert Uytterhoeven wrote:
> On Tue, 1 Jul 2025 at 15:56, Dave Martin <Dave.Martin@arm.com> wrote:
> > Instead of having the core code guess the note name for each regset,
> > use USER_REGSET_NOTE_TYPE() to pick the correct name from elf.h.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert

[...]

Thanks!

---Dave

