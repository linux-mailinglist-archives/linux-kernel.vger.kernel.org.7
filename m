Return-Path: <linux-kernel+bounces-809693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7E0B510DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A5B7AD99F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D8030F945;
	Wed, 10 Sep 2025 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bMYmS2Kd"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5F2BF3CC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491945; cv=none; b=ESTDjtGeWYrpT7h1+XjvT04BtZjYh1n5JbZUrWxzfROJ/XLb6xujRT861bkMrbPCPg2JSATCoOXIEKqMnJUW29i4Y4vcnniVq3/TohHzHIeS6iaZ6Fyfx/LtqemuQaHaLNiE+WmDRJfn//Xfcm62Z4MVyx91z068MfeCfQt+LUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491945; c=relaxed/simple;
	bh=6h6EU7B2+POZjjT76XlpAJVIBagh9oufAKAnNfJpPnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4rtWLDWoliwexW7dKEuYVA6We1mDygSg/4OaAnVTcfPb4P2SlOsbO49ZxHRE8c3mdrE4+NcnkPULexYpGai81qjSvM2qOn9S26MT5avNGWiDyCElOaOiKaUpQX43y/ay+DHJtDRfGbB2WUWPlgvYM5qC83zlXjornk6bnRD0TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bMYmS2Kd; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cMD1v1kJfz9t4r;
	Wed, 10 Sep 2025 10:12:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757491939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPU1gnuOMTGg9FkDyjniyY5pLjGLZv6fX6GCHXIwK70=;
	b=bMYmS2Kdr2emLC7seKLyBbqkP++utFB7nXCzcbvNeVLNBxZvNbFK0S0LotGPzGI7fL5J2q
	kV0rq6MHv92XcKeFdwPt8dsO+FJw7eozHOYkrosHCl343cLCDY5s8dWnqLR+gceb4ff9CA
	EQwj/lVntuXPvPKJtgSCSIudfZzzz+wMO3wr/w/acwgllc09J9chSok4t7pCuJFp6kR3pL
	Eq7y/G1EIDbZHZyPUh4SQSD32Zkyo9Xj57YNk1LXtxl2TbRQops/aRXPWaljrM1GdWyMsR
	YBUg32Rr1Gi6EDf+hSvrq6BqMpGJVUvjNnsPGyD5QWxmo0Ys1euUIcoG3+b8aw==
Message-ID: <0671680b-842f-4771-ade5-2485c9a91356@mailbox.org>
Date: Wed, 10 Sep 2025 10:12:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: evergreen_packet3_check:... radeon 0000:1d:00.0: vbo resource
 seems too big for the bo
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Borislav Petkov <bp@alien8.de>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <CADnq5_Oqonrth+5T-83dnFBZ67GvykkPt-9aUepJd+fUMwnupw@mail.gmail.com>
 <20250829194044.GCaLICPKJcGJRYdSfO@fat_crate.local>
 <20250829204840.GEaLISKGTwuScnDF8Y@fat_crate.local>
 <CADnq5_MbpYmC2PSyOr0gQk7F8mVz0-LG3dZtUZS2HhV8LTgDww@mail.gmail.com>
 <20250830174810.GAaLM5WkiFc2BtQ6kW@fat_crate.local>
 <51ae551b-6708-4fcd-84f9-fc1400f02427@mailbox.org>
 <20250901101011.GAaLVxA_Ax0R-Wy2IX@fat_crate.local>
 <2764782f-d411-4142-aa56-f1af0968ecd5@mailbox.org>
 <20250908180022.GHaL8Zto-PsVsPa0e0@fat_crate.local>
 <63b7c020-e589-4644-887e-3922af939009@mailbox.org>
 <20250909161648.GAaMBS8ERsvv3NbJoF@fat_crate.local>
 <CADnq5_MOazXJ4tUNa5uMdkWY7ZCu70M49yG00JsNHB-FO7XNvA@mail.gmail.com>
 <45c973ea-22b5-4df2-8b34-a64d48cdecb2@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <45c973ea-22b5-4df2-8b34-a64d48cdecb2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e72a39f9b2a02435d57
X-MBO-RS-META: fnhwu5eyhh1rqp7fb9izdhffnppc7xe4

On 10.09.25 10:02, Christian König wrote:
> On 09.09.25 18:21, Alex Deucher wrote:
>> On Tue, Sep 9, 2025 at 12:17 PM Borislav Petkov <bp@alien8.de> wrote:
>>>
>>> On Tue, Sep 09, 2025 at 10:43:47AM +0200, Michel Dänzer wrote:
>>>> Then the developer needs to tell the user how to enable the debugging output
>>>> and get it to them. That's pretty standard.
>>>
>>> *IF* the user even notices anything. As said earlier, it didn't cause any
>>> anomalies on my machine besides flooding dmesg. Which I look at for obvious
>>> reasons but users probably don't.
>>
>> Right.  I think there needs to be something otherwise no one will notice at all.
> 
> Well doesn't the cause of the warning result in corrupted rendering?

Per https://gitlab.freedesktop.org/mesa/mesa/-/issues/13838#note_3088335 it would result in one dropped vertex, which might be hard to notice. That's why I agree that in this specific case, not logging anything by default might have resulted in the issue taking much longer to be discovered (if ever).

(A potential counter argument being: If it's not noticeable, does the kernel need to log anything about it by default?)


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

