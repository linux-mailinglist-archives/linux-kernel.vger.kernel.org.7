Return-Path: <linux-kernel+bounces-819307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 735E6B59E74
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE1E323967
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE1831FEED;
	Tue, 16 Sep 2025 16:55:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3242FFFAA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041715; cv=none; b=VlWqpRTdWZdS4mLCu3aNOPD9L9xtAlNJwRFaCMROJITfsXaXaGrFpcHx3eWAFeU2qE/rRAT+Jimovp4WltN9PLyHdr0kzBbUwkqQlSOZUDC8kQl+Ee6/KNCEG6WyCEQLEgYu8Hsqpv75wa07aP5cEzWFVdjEmXIayYwuSD1vLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041715; c=relaxed/simple;
	bh=HAwKoN8QsI/yHsoc57qWTxwalilsPvpkhCdMhJPh3JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KohAQJEzQU9LK4L7kMNbxkDhcCA7fZy39+w6I/B26kqE98E4I6V6azX//IplnJyDraeboYYNFLzuHgrF0J+n4oxEm8/iKSGVBB8W4QuwbHQf/TeOX/BMPPu+qGgv+47Uz2vr1wgcxElBWEE+O5EHGhjlFKlnKJO82HCSpV/YbzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35FAB113E;
	Tue, 16 Sep 2025 09:55:04 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C3D13F694;
	Tue, 16 Sep 2025 09:55:11 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:55:10 +0100
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Linu Cherian <lcherian@marvell.com>, linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v3] coresight: Fix possible deadlock in coresight_panic_cb
Message-ID: <20250916165510.GN12516@e132581.arm.com>
References: <20250912151314.3761026-1-sean.anderson@linux.dev>
 <20250915095820.GH12516@e132581.arm.com>
 <3e618117-96bd-44f3-bede-7cadfe0264dd@linux.dev>
 <20250916160027.GK12516@e132581.arm.com>
 <6fbd24b2-3315-45e6-bff2-2c39e899e8f5@arm.com>
 <20250916163840.GL12516@e132581.arm.com>
 <8f426702-4897-4177-aeae-4fe2b7155fae@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f426702-4897-4177-aeae-4fe2b7155fae@arm.com>

On Tue, Sep 16, 2025 at 05:42:07PM +0100, Suzuki Kuruppassery Poulose wrote:

[...]

> > > Well, if you are going that far, why not register the notifier from
> > > coresight-core ?
> > 
> > I have thought this but gave up.
> > 
> > When register a panic's notifier, it does not provide an argument for
> > passing a private data. So the code below uses container_of() to convert
> > notifier block pointer to the TMC driver data, as a result, the code is
> > specific to TMC driver.
> 
> notifier_block in csdev ?

csdev is a common structure, some devices may never use the notifier.

This is the reason I thought it is fine to put notifier into TMC's
driver data, as this can meet current requirement perfectly.

Thanks,
Leo

