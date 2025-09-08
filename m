Return-Path: <linux-kernel+bounces-806414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63009B4967D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071483B16D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77F23115B1;
	Mon,  8 Sep 2025 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eezS7r1T"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66B3115A7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351136; cv=none; b=uve4n492bgIDsFmIyCs9lilFuDDi+9ceac6Ysoeg3oN1O9sww+5QQBn5K+HD+mST9KYBlksX9YYNj43ssmUY50jLKeHEiOR+/wnW54qu22WyipVzu5cd8YlNRl8rd7fFuqzo1H13ibsKYNowqkBeQyOkbsfZdO9OzEDqRtYtf04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351136; c=relaxed/simple;
	bh=GtjzbWLqf22Hy5EcQyT1GFYbtS/RNix0V6CZO5Xf2MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/aOoHmN36U/zwZUjRccn/q2UB7pitU5rc+PaNydYGhPECoxSs799X41dyBK760YnbArDfb/w073kGGAWp/FbaLK9cpTRrgUsKcD4FtlXy2VK10MuPt2glyVtdAZQqeSvgNdu9I2/zmtUayI4Wy6exSXuapPXYy8QwZxkKCu18U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eezS7r1T; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cLCxw5bDjz9tHG;
	Mon,  8 Sep 2025 19:05:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757351124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4nGyVlamX2EE0TinZz3gA/op6zky2srhucm+tgjcQM=;
	b=eezS7r1T7PDGqAn4aSGdOOyvTCevAyh2aPjHJMJiwdK3/K+0p55eqPUwhTQ3naczIGieJ8
	tZNtgynmF8BmGh+NdhX09SxcydzTFv6KNyGmGXOj/CX8qUKQEu7I9jaX+sRNVadrWg2nQL
	aJQ6DOEpG8mgLWxxt9LkOwW+1zYqWjp0pS7Cg81tr39q/kYYqhcHtSVM5+MC6tDUP8lWkD
	O6KdFmy6ROc93CHft/0GAhMFps+NqmaK01ubjdGLCLbUSO2qKqwknpz4AldhMcPloPDupN
	8GfshxSQlKAiY+eNxRLgrjWny7pqLiZnlLGoyK8INQ8h80vS56+XmZK8uoBI/A==
Message-ID: <2764782f-d411-4142-aa56-f1af0968ecd5@mailbox.org>
Date: Mon, 8 Sep 2025 19:05:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: evergreen_packet3_check:... radeon 0000:1d:00.0: vbo resource
 seems too big for the bo
To: Borislav Petkov <bp@alien8.de>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250829171655.GBaLHgh3VOvuM1UfJg@fat_crate.local>
 <CADnq5_Oqonrth+5T-83dnFBZ67GvykkPt-9aUepJd+fUMwnupw@mail.gmail.com>
 <20250829194044.GCaLICPKJcGJRYdSfO@fat_crate.local>
 <20250829204840.GEaLISKGTwuScnDF8Y@fat_crate.local>
 <CADnq5_MbpYmC2PSyOr0gQk7F8mVz0-LG3dZtUZS2HhV8LTgDww@mail.gmail.com>
 <20250830174810.GAaLM5WkiFc2BtQ6kW@fat_crate.local>
 <51ae551b-6708-4fcd-84f9-fc1400f02427@mailbox.org>
 <20250901101011.GAaLVxA_Ax0R-Wy2IX@fat_crate.local>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20250901101011.GAaLVxA_Ax0R-Wy2IX@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: da7f573e369603a1316
X-MBO-RS-META: wtpeb1ieommtoi1qaank9ug6rrqq7sfg

On 01.09.25 12:10, Borislav Petkov wrote:
> On Mon, Sep 01, 2025 at 11:27:01AM +0200, Michel Dänzer wrote:
>> use some kind of debug output API which doesn't hit dmesg by default
> 
> You still want to be enabled by default so that normal users can see it and
> actually report it.

These messages are primarily intended for developers, not users (which will notice and report the corresponding user-space issues instead).


>> (can be a non-once variant instead, that's more useful for user-space
>> developers).
> 
> I don't see how a non-once variant can tell you anything new - it is repeating
> one cryptic message to most users so what's the point of parroting it more
> than once?

The once variant means user-space developers need to reboot after hitting it once.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

