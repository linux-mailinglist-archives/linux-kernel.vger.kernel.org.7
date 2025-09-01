Return-Path: <linux-kernel+bounces-794227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE3B3DE9C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0AF3A2E4F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA96F248F66;
	Mon,  1 Sep 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NmRDpvo/"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6484F30AAD3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719167; cv=none; b=EqT77qSl9rY5081ulpfZ39Pqk8PEHhz1APnemVFaHRCAaAnj/zGbp+YPxcDxELVYhm2eDqHfn2Fr/dwJuorRQrH9deXydDMIudSAHHTwCOdjnk47jJzvyzOAyTMRRjDze4ClTR9eIByh3/8mKhtgth1Jg7H3zhz4GXCkk4VkP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719167; c=relaxed/simple;
	bh=VV4eXZuKo8t6qNdv2fkZtFqu84pgWpX3hYQh/oEEeRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2MfIr/fmDfWKQXEXWiAFmWjwCdmUoh09V5FIKhytum0VLFIilPYslwqdk7nJLUJkmTiYfySIngp8k6WE7vtH/VpoS2Y7i7w25KKHZl7SG4ZMFc21QH/g04klkQkH2b6kmQz7R6xwrsXDLLtWuwIN/JYBGaYU24GnECi+Xt2TA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NmRDpvo/; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cFk6J3zggz9t94;
	Mon,  1 Sep 2025 11:27:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756718824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlucI1qXn/i28lahrLwdrBh1MDGe5BAq5K43ycGpETQ=;
	b=NmRDpvo/0m7bAPfBrB74HPBPJq08mK4ak2E2irt06CUbo72lHvLLJ4hLu5/eQlr8nfKvsv
	/SVbyH8qYm7Se58M8V/WEzqNd333tgpFwaT9uXlraRllKvYTwdvhK0sOu/qvvcgkSYIh19
	uFPsMl8RjWXt+OespQuYtNH/8wGqJgiX5VezFY5UDk2FYPLDyCKfHhJo1ims2D3gxAmTrM
	ZLqdr/pQfHoSWSK3UBLln2E2/GWGpr5lytjrdXF1e/dO08sXZkWdNDhdnqJZ5xXQMq7n0P
	wYsy3BaxsFyXXq5ANj1ft/xY51u0iQ57/ql8cKWJoiA1uKwDRdfJVuXGP4CEXA==
Message-ID: <51ae551b-6708-4fcd-84f9-fc1400f02427@mailbox.org>
Date: Mon, 1 Sep 2025 11:27:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: evergreen_packet3_check:... radeon 0000:1d:00.0: vbo resource
 seems too big for the bo
To: Borislav Petkov <bp@alien8.de>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250829171655.GBaLHgh3VOvuM1UfJg@fat_crate.local>
 <CADnq5_Oqonrth+5T-83dnFBZ67GvykkPt-9aUepJd+fUMwnupw@mail.gmail.com>
 <20250829194044.GCaLICPKJcGJRYdSfO@fat_crate.local>
 <20250829204840.GEaLISKGTwuScnDF8Y@fat_crate.local>
 <CADnq5_MbpYmC2PSyOr0gQk7F8mVz0-LG3dZtUZS2HhV8LTgDww@mail.gmail.com>
 <20250830174810.GAaLM5WkiFc2BtQ6kW@fat_crate.local>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20250830174810.GAaLM5WkiFc2BtQ6kW@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fbb9b5b97304bf83e9d
X-MBO-RS-META: p8bwh9jm4mqhjxsrb7dwcebcgr53kora

On 30.08.25 19:48, Borislav Petkov wrote:
> 
> diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
> index a46613283393..6285ff1b1bff 100644
> --- a/drivers/gpu/drm/radeon/evergreen_cs.c
> +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
> @@ -2418,7 +2418,7 @@ static int evergreen_packet3_check(struct radeon_cs_parser *p,
>  				size = radeon_get_ib_value(p, idx+1+(i*8)+1);
>  				if (p->rdev && (size + offset) > radeon_bo_size(reloc->robj)) {
>  					/* force size to size of the buffer */
> -					dev_warn_ratelimited(p->dev, "vbo resource seems too big for the bo\n");
> +					dev_warn_once(p->dev, "vbo resource seems too big for the bo\n");
>  					ib[idx+1+(i*8)+1] = radeon_bo_size(reloc->robj) - offset;
>  				}
>  

Like all scenarios which can be triggered by user space, this should rather use some kind of debug output API which doesn't hit dmesg by default (can be a non-once variant instead, that's more useful for user-space developers).


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

