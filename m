Return-Path: <linux-kernel+bounces-793579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB419B3D585
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93AC17A51B6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AF92264A8;
	Sun, 31 Aug 2025 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="D18jqfNI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F37FC0A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756678128; cv=none; b=uSFoKh/mtbAGSaCvnGDCTcrXMEN5aLos/wCX55gOUhBeR5E6xNrQwMGGl2yysdFA3X/aZMU8mlhpJmsIx/fMCYhttrVlb70kh2Ow3Rk/WJSVrxCpC0gQ2P0foSrvpAaIoPeQaxb791cqT4VjExCdwApisrp8f4/j79ix/uU2Bxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756678128; c=relaxed/simple;
	bh=yBB+ZE9C4DwbiRTu0IE7CZmsNqF0/C/i8kYnF0xKuZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYU9rt6/jfo9xBMFmi/i84HnM8vyZWDaO07ffE1Vq7GYgGsAlI3ynn55LAxsBZPSrf6VsKOueSsLXji5xeR1igw3ABDvODbF0M5hjLaEG/1N2CYj0lOfyfIjdDwQVhpdpPbsEBqRgE20xffNfmQmqFaT68RHXdE2X/fRWYZy9Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=D18jqfNI reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ADE2340E019F;
	Sun, 31 Aug 2025 22:08:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nNbAu0BZcfiG; Sun, 31 Aug 2025 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756678112; bh=tiRBeG26VGbVwOLERdCjKW0AA0MtyuJ+1bOG0TitQLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D18jqfNIYMO+v7UR7aKQ8jRt+I6TULrwXW3DQAVAsZ8FTPMZDFg1XLLElgpT5eWOC
	 G01zkIx9t/NuxKJEotKuRC60YcOE5tIHioO6OMQb7Ux9R9fXeD8RwpsSyI2YqfdNTX
	 MvYV92CsSlR+WNsYa3L0c2VUHukM/LXy05eqKfySmztdXzBbCykCpwWWKH7FNVI6ZC
	 tk1AeLao3OcInmdpqMiYt4ol9EIgaFuIIpLjYtJSjQaE49Qz47mZnrZFR8B1VfNvtI
	 OGzRNZMpjsvVWPWove077dSIH0dnKe2eCzcZ5KqLpOBvpGcIdLHhSIt11xkrKtrf2B
	 DQCVof6dUEPvR0makOxrX/xuXpcyQbOdZ1a2aPScAMu2+xlCOTvjlAK/vJOg6PwiaY
	 VEg+p7XjiwnePCgB6muO+yyYMNaPyHQ+DEB+AzcIkr50yiMIoRjXGkZzmARkjtuoDl
	 oXNJVhJVYNQGs3pxXf2ByExMEvvp5rddupaB9H3KBBdCZe6GXeT74OGA4Saql1KcWU
	 AH8U+cj7HzS2TuB5LWIqjJhMu87SN/KugLzyCmzkM+a/25DIrGvoH8gOvg+Z93m3er
	 zieoyDaQtKk4CsE9wbIGvphVXm5vY0VSB+0lQ0F0KuskQAM7XU4XQz4Z3p1Oy9vMO0
	 IMbRIehcJG2MCNOYyHWQXWVo=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0413440E0174;
	Sun, 31 Aug 2025 22:08:24 +0000 (UTC)
Date: Mon, 1 Sep 2025 00:08:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: evergreen_packet3_check:... radeon 0000:1d:00.0: vbo resource
 seems too big for the bo
Message-ID: <20250831220816.GDaLTH0JbO8t0qJMwe@fat_crate.local>
References: <20250829171655.GBaLHgh3VOvuM1UfJg@fat_crate.local>
 <CADnq5_Oqonrth+5T-83dnFBZ67GvykkPt-9aUepJd+fUMwnupw@mail.gmail.com>
 <20250829194044.GCaLICPKJcGJRYdSfO@fat_crate.local>
 <20250829204840.GEaLISKGTwuScnDF8Y@fat_crate.local>
 <CADnq5_MbpYmC2PSyOr0gQk7F8mVz0-LG3dZtUZS2HhV8LTgDww@mail.gmail.com>
 <20250830174810.GAaLM5WkiFc2BtQ6kW@fat_crate.local>
 <14a9ed202a304fe895719f406633e79fe16e8535.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14a9ed202a304fe895719f406633e79fe16e8535.camel@gmail.com>
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 11:42:19PM +0200, Timur Krist=C3=B3f wrote:
> Which Mesa version do you use exactly?
> Are you sure that version number is correct?
>=20
> Mesa 9.0.2 was released on January 22nd, 2013, more than 12 years ago.

How's that?

$ glxinfo | grep Mesa
client glx vendor string: Mesa Project and SGI
    Vendor: Mesa (0x1002)
OpenGL vendor string: Mesa
OpenGL core profile version string: 4.5 (Core Profile) Mesa 25.0.7-2
OpenGL version string: 4.5 (Compatibility Profile) Mesa 25.0.7-2
OpenGL ES profile version string: OpenGL ES 3.1 Mesa 25.0.7-2

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

