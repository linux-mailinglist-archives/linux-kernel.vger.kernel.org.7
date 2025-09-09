Return-Path: <linux-kernel+bounces-807534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4A4B4A5B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B0A7B6D4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4346625784A;
	Tue,  9 Sep 2025 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cqKp2gZk"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A60257826
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407441; cv=none; b=AdXjCvfbqEzZ3MCacyt9zFwaKzz5i0bwjCcYbN8wanBe1OrcJ+gsiHkKiy5zCkcQt2Jn5PI1EoUBu8FrCMxNfxM8QDBNogFSpPKZ8s8OUNFQK9+e5Qpa6+J3kh3k6v6/RaWWHy+YLcCX0de1+lIBCPXkzsPO/cb2dNSCe4mdw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407441; c=relaxed/simple;
	bh=rWEqLim11O/21xmH/y2QR4VjNQ0ZGRt/WUpP10JAcC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzlpiVprWLVW0Ntth9zKbVVRMq0rNGUusiOTnqLaMhE+rUTy5nIAGkw7ot0cbThcsJRZemewmtS+6ZincZc3MpaOWPm+pWP3wOW9kh0uHV54+Ufb4RQXlxy/5mTA9LCxyfy631FKy790iwuVZ6UYo5tOcuDSXUvM3yQ0YuOQlpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cqKp2gZk; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cLcmk3Zybz9tPJ;
	Tue,  9 Sep 2025 10:43:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757407430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EaY/kealtZvFpNFt6fUyL37ikAIiwkIr3pKJQ+3EQjw=;
	b=cqKp2gZkoXmHMVfyuVUNbB1AnUsKy3A/wuZ2WhXODSwOWG6N9G4f6mkKpOv85ygyKE9NrA
	/NS0PXVwjLhSt4edvYJ3MReZ4DDY4rAEDiWLh/BY29CAYIfIc+uVBw2Yd1Y51dTSnhxqAA
	pOoa/Z/ZzV1QM1JE3kUepGo7DMGOqFOsmWC7asRWHDhFPmTdvnANIW87Enj23PwTV61l5q
	q7NyZzxDKybtulcgd7PhUXdg+eISlcSq9+a+kk3uXDKPU0M9DHf+k1UghZkAiIb+eXJYFK
	17ypjFLgS/vXLBakz2WRETspdDoaUDUzYNrUhVfmkGibk+G1rMtAcW5csVdURw==
Message-ID: <63b7c020-e589-4644-887e-3922af939009@mailbox.org>
Date: Tue, 9 Sep 2025 10:43:47 +0200
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
 <2764782f-d411-4142-aa56-f1af0968ecd5@mailbox.org>
 <20250908180022.GHaL8Zto-PsVsPa0e0@fat_crate.local>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20250908180022.GHaL8Zto-PsVsPa0e0@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f89cfc3521c7b81e5ef
X-MBO-RS-META: 3t8pstzkshjkqsm3uqswjhq43agsk8i9

On 08.09.25 20:00, Borislav Petkov wrote:
> On Mon, Sep 08, 2025 at 07:05:17PM +0200, Michel Dänzer wrote:
>> These messages are primarily intended for developers, not users
> 
> But everybody sees them! And they're flooding the console.

There's no question that dev_warn_ratelimited is wrong here, I'm just saying dev_warn_once isn't quite right either.


BTW, the same arguments apply to the other dev_warn calls in evergreen_cs.c. Their conditions can be controlled by user space, so they must not generate any dmesg output by default.


> And if those messages are only for developers, they better be not visible by
> default but behind a CONFIG_DEBUG or a similar switch.

Hence my suggestion to use a dbg variant, which isn't visible by default but can be enabled (and disabled again) at runtime.


> And developers don't have every hw to test on. So you need to rely on users to
> report issues to you. Because those messages probably don't fire on your hw
> but someone else would hit them. And the chances are high that someone else is
> a user.

Then the developer needs to tell the user how to enable the debugging output and get it to them. That's pretty standard.


>> (which will notice and report the corresponding user-space issues instead).
> 
> The case due to which we're having this conversation didn't manifest itself
> into anything - it was only flooding my dmesg.

The message is logged if the kernel needs to fix up invalid data passed in by user space. That may have had no noticeable effect in your case, it certainly could in other cases though.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

