Return-Path: <linux-kernel+bounces-866259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9CABFF503
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80C618C6703
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB8280A20;
	Thu, 23 Oct 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="MI3EbTcY"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62242327A3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761200168; cv=none; b=HRO0PDVpapWLL1On+/zjq+6qNU85Q0Qpt4FYZJumWiES4f4FAgAlSPCVLNR8TnYqQw9uiTj8yRWmXAEqdJJVI+6z+hnfAujjnxhjs3jcDfwo0vBY54b3tcWrZ03cu83ukJjf6NAgalhrP/8sHWb94CccmIPgb6QxMJFaV/ubPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761200168; c=relaxed/simple;
	bh=tVfi/wUdQdQqbygmlLXSvRZ+CKWhpqaADyz8XoPUEIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWU3NhCeD0gyLhBMlRdzFKNT4sdS6RRbtFU4d0cXUHOQg2GQaKiu5lrIfkQBZHXO5PVQtcPzoof3Eo+sjpHsWXOYEJEcJXiSeOog29Gr0BZfmvcE81X60fn5UWj5o2A5yJ56Y0UaIIIhwWu9HIAiWmcaj1n5qtKGPCxfzXqRMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=pass smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=MI3EbTcY; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jookia.org
Date: Thu, 23 Oct 2025 17:11:18 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1761200160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OaSLgSDNZ5V/tZyuc4ElhbmLojmIUJ+b33N9cozmVbc=;
	b=MI3EbTcYJCv3U3L6qyQC2/BvBNHhVDD66j3MSni8vN+0xjwo/J+edDMA7VVnC/zaBF8kT/
	kcGDKjFQVWLNVLqAdC47Ri9u609HG3Pr0ZnTmkldmR9RlQpjtbW4HJRgsKmG36h0bxXnAz
	+I5SF0E0HRahsLxQZHGGoTLyr2SM6a8y4hdB7s3P/ic35RjE2ddLb5dHsn0RV9KKbT9Tsy
	mo0TXLmUPtayKBsL0Q8wpe6hNVCrAn97VvAG69W/kmQCxQ1sfxZNVZVz881vzV53iejaWG
	Tb0H71AwhaehE96pwd0D0LxPutiQ2pBdYfqdS9ZtDtIFDx1rr6BrTJz1RJoiUw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Priit Laes <plaes@plaes.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Ryan Walklin <ryan@testtoast.com>,
	Christophe Branchereau <cbranchereau@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: nv3052c: Reduce duplication of init sequences
Message-ID: <aPnHBpyhYhMFumPO@titan>
References: <20250619132211.556027-1-plaes@plaes.org>
 <a6d1e281-2ba4-4b47-86b6-5bf57fa0b71a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6d1e281-2ba4-4b47-86b6-5bf57fa0b71a@linaro.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 30, 2025 at 05:32:04PM +0200, Neil Armstrong wrote:
> Hi,
> 
> On 19/06/2025 15:22, Priit Laes wrote:
> > Although there are various small changes between the init
> > sequences, the second half is common for all 3 currently
> > supported displays.
> > 
> > Note that this is only compile-tested.
> > 
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> 
> If you can find someone to test this patchset, I'll apply it because it looks good!
> 
> Thanks,
> Neil

Hi there,

Sorry for the very long wait.
I finally got around to reviewing and testing this on the FS035VG158 panel.
The code looks good and works on the panel. I don't see why it won't work on other panels.

Tested-by: John Watts <contact@jookia.org>
Reviewed-by: John Watts <contact@jookia.org>

John.

