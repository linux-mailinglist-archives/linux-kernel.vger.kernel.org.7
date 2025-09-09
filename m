Return-Path: <linux-kernel+bounces-808613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65810B5024D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2083B2E5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471FD34321F;
	Tue,  9 Sep 2025 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="U3yFXHhf"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA733439E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434624; cv=none; b=gZPp5M5sYMe8pqS6m07Mtep13DNOzdCQPxI138uu4T4BeKIeXodoypccQU9cYzSOcw5wqWm9iqScpJrhoyI4SIaLhnj92x+J0vZndC1k/lAPhseb+1f4wmxHxShL0/2rEKJtYFd2WRGdg8UTBUM5lqI0hOB8Ndhtrdaf3LzhnTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434624; c=relaxed/simple;
	bh=Pv+NUm2Yq7/Fnf7Tbo8lbkcRT+ztuvTquXtP+ue42as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHRsTYocKQUf9NuKxL23cHuGo0vCEGC2kqd0QDo9HdkNMS5uSZo/tN+e1h1kYw85xqlt6x7/K683ChDP7C7MQse5MycHYHQ58Uv7EhRWnJPOU7MB10yr0CYfxUx4fWuf+ZZu5AedHB0Cj/9sECshhPJ78fa90srL66ruTxPefYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=U3yFXHhf reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AB49640E015C;
	Tue,  9 Sep 2025 16:17:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XFR4KzW_jHyg; Tue,  9 Sep 2025 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757434616; bh=x4dPDHXH93CXwiqXNStX9rNKikfuL4oUurJG+Gt3QVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U3yFXHhf00V5di1be5Y7C4fiMWhHWk9fqL/Skwc9UogxdvaNawJ2Q8eaX3JFNNp2j
	 CYiQUDvL/NIoYhdm0E0Tlii+8GehWjMRdDepaE3EFRnc0Zi/Rn+zSaMmhl2gKxmmmi
	 1fzdrNDKhNcph88xhh7lu34DDAQzyaUq5yVojBOWz0C7HG8Eekud32YHSz/fSIChWv
	 XwZcseAZ6Izb9r2w5oS7a+8SxlKMt+YEjNOA5IgijZpAaT2+uoTOT9aLvoCC8Io6vp
	 qvWVhw0KfkDALhaR9hnh03bqBi7MKcQJhZoVar9cgUxixjZ80RHiU+x81RjkRKc2wL
	 60ErDY369Rqm8sSrybtoSDWgzlt/v1iNPmAaIbTR3qSe/Gptm1S7mHL6p4ZDxNkUEf
	 VQB3me9iBjoeGPZhTFSv9M1z+2IfOSEOzpKbQnpzsZwGWGEEOU6AIERa0egKabwqvP
	 KTjy6Lxd2A9B4kO5SgZCdr4A1hwxayduic9n4IrIJNPCKEuqcCOUZpJylvQC8UW/p6
	 f2EpDUpLVNwLh35WWsfY+WquoqmTnji/+exOPzmOg2zaWVmVS6SOEgU+rfXYekmhK/
	 YjC+1hZztxC0+pAxM3IimvQOLc8sGJRbZeJaogLcLd3TLkc+3/8khkrJFU22jWbFA2
	 K+FdAvt8gyP8uRToKtnOtvpo=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9854840E015F;
	Tue,  9 Sep 2025 16:16:49 +0000 (UTC)
Date: Tue, 9 Sep 2025 18:16:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: evergreen_packet3_check:... radeon 0000:1d:00.0: vbo resource
 seems too big for the bo
Message-ID: <20250909161648.GAaMBS8ERsvv3NbJoF@fat_crate.local>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63b7c020-e589-4644-887e-3922af939009@mailbox.org>
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 10:43:47AM +0200, Michel D=C3=A4nzer wrote:
> Then the developer needs to tell the user how to enable the debugging o=
utput
> and get it to them. That's pretty standard.

*IF* the user even notices anything. As said earlier, it didn't cause any
anomalies on my machine besides flooding dmesg. Which I look at for obvio=
us
reasons but users probably don't.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

