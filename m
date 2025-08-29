Return-Path: <linux-kernel+bounces-792390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD76B3C33B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991911882C51
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402A521D3E8;
	Fri, 29 Aug 2025 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a6U/cPfe"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7315E5D4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496469; cv=none; b=TqMTbiGbs8nEoVAGg2Dq2BSnsIyccCfe/+6r73qDg2JtezgyZNIh7cDD1+qfErFGncHTzaK8kNcja618bpHGhvewkNd1t81nmXs8r3FClleCBCUS8v/oMjV/tBd4iE3Bq2JGzC6gDiUrh7KW5qVi3mTVlOtzgEUS+aY4L4MsXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496469; c=relaxed/simple;
	bh=2I77nCgGWyro+lAdnALFXn3HmvGjCvEaC70WNQcn41o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vc7PKGylpQtqhsS8VpYvMMhwjtvHzWoJbNy3uAiqT01etzD1z9NzbZnfpjALqkAYsIjJ56NxAdanyBg5CzbWlmpB2an0xL7WkYAV4sRYui9TGRe9AoSlInVEZfl3j95APMyIfQRDSwuh3RmhsjmIKuMuezcl2MTrJDg2mU4Q9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a6U/cPfe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A8B540E019E;
	Fri, 29 Aug 2025 19:41:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id H_fRXRhCsNV9; Fri, 29 Aug 2025 19:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756496458; bh=NZ3r/e9Y9tjrwTvdKgfqZPem1vLEEwZE3p2wXChCOCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6U/cPfeL0g6q5ldGJ2+VXZkGVR2CfKu2sElVhuSINyoz9ID9lX7EPeHlaXKudGb4
	 vpKeUA+Wojhq1SQd4wf5LTNaoTvB0cIrJtoF+Df5j21gny9YCxB8XFC9z2nciFU+lv
	 awzrjlVNFRwUFvRqWHMO78+m2+efM+jRYs2NbAWwKw1IJUme3zMqT46tRS9IWNPKlh
	 Ke5fg5s55ExyKyy+aKEd52GaP/7x40TSisxL3yGPEFG71xr3MOsj1Eh/FJMRuULYpD
	 BafO+A1PNQwamVg/80/P75k/mCEEUeTojyrMYi1NfhJ5O7iDoxTwOkBUKLkcZzGwbS
	 0oYYwCeXbQjifAOcpHQdQshBQVz6dqcf9qocYg/jwnMk13BXlyb+gjgxdxpTEEcILb
	 NreiGrH7RrFzvCXuzsHIkNyiZHG5g4PlrhQ4eyQxkgIUyPak7PFPR4NKCWkfS+3Dan
	 3ygJa22S3klIGLjYZWW/7uMpvcezmgU/Mq/iYB4OjKgTcLo5P482LUxeM5NEp1KKmu
	 dvJnyqe/awODZUdEVZsxA3BHkPTh4CXzTp90QzNpYuuvyqBTZ1JKZ93ABWFnmY4Tfo
	 a+g7trkJ2X6l1WHEooHJVOqMNIeTeCz3HT1wI5GMkRuSAEd9//QY68SQSeO+Tuim6P
	 XefDlCMzXdSBB1ToRo9vZuRU=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6DA3740E019C;
	Fri, 29 Aug 2025 19:40:52 +0000 (UTC)
Date: Fri, 29 Aug 2025 21:40:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: evergreen_packet3_check:... radeon 0000:1d:00.0: vbo resource
 seems too big for the bo
Message-ID: <20250829194044.GCaLICPKJcGJRYdSfO@fat_crate.local>
References: <20250829171655.GBaLHgh3VOvuM1UfJg@fat_crate.local>
 <CADnq5_Oqonrth+5T-83dnFBZ67GvykkPt-9aUepJd+fUMwnupw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_Oqonrth+5T-83dnFBZ67GvykkPt-9aUepJd+fUMwnupw@mail.gmail.com>

On Fri, Aug 29, 2025 at 02:26:50PM -0400, Alex Deucher wrote:
> Have you updated mesa?  Looks like a userspace change.

Yeah, I did a long overdue OS upgrade today:

$ grep -i mesa /var/log/dpkg.log

2025-08-29 17:50:32 install mesa-libgallium:amd64 <none> 25.0.7-2
2025-08-29 17:50:32 status half-installed mesa-libgallium:amd64 25.0.7-2
2025-08-29 17:50:33 status unpacked mesa-libgallium:amd64 25.0.7-2
2025-08-29 17:50:33 upgrade libegl-mesa0:amd64 21.3.8-1 25.0.7-2
2025-08-29 17:50:33 status half-configured libegl-mesa0:amd64 21.3.8-1
2025-08-29 17:50:33 status unpacked libegl-mesa0:amd64 21.3.8-1
2025-08-29 17:50:33 status half-installed libegl-mesa0:amd64 21.3.8-1
2025-08-29 17:50:33 status unpacked libegl-mesa0:amd64 25.0.7-2
2025-08-29 17:50:34 upgrade libgl1-mesa-dri:amd64 21.3.8-1 25.0.7-2
2025-08-29 17:50:34 status half-configured libgl1-mesa-dri:amd64 21.3.8-1
2025-08-29 17:50:34 status unpacked libgl1-mesa-dri:amd64 21.3.8-1
2025-08-29 17:50:34 status half-installed libgl1-mesa-dri:amd64 21.3.8-1
2025-08-29 17:50:34 status unpacked libgl1-mesa-dri:amd64 25.0.7-2
2025-08-29 17:50:34 upgrade libglx-mesa0:amd64 21.3.8-1 25.0.7-2
2025-08-29 17:50:34 status half-configured libglx-mesa0:amd64 21.3.8-1
2025-08-29 17:50:34 status unpacked libglx-mesa0:amd64 21.3.8-1
2025-08-29 17:50:34 status half-installed libglx-mesa0:amd64 21.3.8-1
2025-08-29 17:50:34 status unpacked libglx-mesa0:amd64 25.0.7-2
2025-08-29 17:50:45 upgrade libegl1-mesa-dev:amd64 21.3.8-1 25.0.7-2
2025-08-29 17:50:45 status half-configured libegl1-mesa-dev:amd64 21.3.8-1
2025-08-29 17:50:45 status unpacked libegl1-mesa-dev:amd64 21.3.8-1
2025-08-29 17:50:45 status half-installed libegl1-mesa-dev:amd64 21.3.8-1
2025-08-29 17:50:45 status unpacked libegl1-mesa-dev:amd64 25.0.7-2
2025-08-29 17:51:47 upgrade libglu1-mesa-dev:amd64 9.0.2-1 9.0.2-1.1+b3
2025-08-29 17:51:47 status half-configured libglu1-mesa-dev:amd64 9.0.2-1
2025-08-29 17:51:47 status unpacked libglu1-mesa-dev:amd64 9.0.2-1
2025-08-29 17:51:47 status half-installed libglu1-mesa-dev:amd64 9.0.2-1
2025-08-29 17:51:47 status unpacked libglu1-mesa-dev:amd64 9.0.2-1.1+b3
2025-08-29 17:51:47 upgrade libglu1-mesa:amd64 9.0.2-1 9.0.2-1.1+b3
2025-08-29 17:51:47 status half-configured libglu1-mesa:amd64 9.0.2-1
2025-08-29 17:51:47 status unpacked libglu1-mesa:amd64 9.0.2-1
2025-08-29 17:51:47 status half-installed libglu1-mesa:amd64 9.0.2-1
2025-08-29 17:51:47 status unpacked libglu1-mesa:amd64 9.0.2-1.1+b3
2025-08-29 17:57:11 upgrade mesa-va-drivers:amd64 21.3.8-1 25.0.7-2
2025-08-29 17:57:11 status half-configured mesa-va-drivers:amd64 21.3.8-1
2025-08-29 17:57:11 status unpacked mesa-va-drivers:amd64 21.3.8-1
2025-08-29 17:57:11 status half-installed mesa-va-drivers:amd64 21.3.8-1
2025-08-29 17:57:12 status unpacked mesa-va-drivers:amd64 25.0.7-2
2025-08-29 17:57:12 upgrade mesa-vdpau-drivers:amd64 21.3.8-1 25.0.7-2
2025-08-29 17:57:12 status half-configured mesa-vdpau-drivers:amd64 21.3.8-1
2025-08-29 17:57:12 status unpacked mesa-vdpau-drivers:amd64 21.3.8-1
2025-08-29 17:57:12 status half-installed mesa-vdpau-drivers:amd64 21.3.8-1
2025-08-29 17:57:12 status unpacked mesa-vdpau-drivers:amd64 25.0.7-2
2025-08-29 17:57:12 upgrade mesa-vulkan-drivers:amd64 21.3.8-1 25.0.7-2
2025-08-29 17:57:12 status half-configured mesa-vulkan-drivers:amd64 21.3.8-1
2025-08-29 17:57:12 status unpacked mesa-vulkan-drivers:amd64 21.3.8-1
2025-08-29 17:57:12 status half-installed mesa-vulkan-drivers:amd64 21.3.8-1
2025-08-29 17:57:12 status unpacked mesa-vulkan-drivers:amd64 25.0.7-2
2025-08-29 18:00:32 configure libglu1-mesa:amd64 9.0.2-1.1+b3 <none>
2025-08-29 18:00:32 status unpacked libglu1-mesa:amd64 9.0.2-1.1+b3
2025-08-29 18:00:32 status half-configured libglu1-mesa:amd64 9.0.2-1.1+b3
2025-08-29 18:00:32 status installed libglu1-mesa:amd64 9.0.2-1.1+b3
2025-08-29 18:09:41 configure mesa-vulkan-drivers:amd64 25.0.7-2 <none>
2025-08-29 18:09:41 status unpacked mesa-vulkan-drivers:amd64 25.0.7-2
2025-08-29 18:09:41 status half-configured mesa-vulkan-drivers:amd64 25.0.7-2
2025-08-29 18:09:41 status installed mesa-vulkan-drivers:amd64 25.0.7-2
2025-08-29 18:09:41 configure mesa-vdpau-drivers:amd64 25.0.7-2 <none>
2025-08-29 18:09:41 status unpacked mesa-vdpau-drivers:amd64 25.0.7-2
2025-08-29 18:09:41 status half-configured mesa-vdpau-drivers:amd64 25.0.7-2
2025-08-29 18:09:41 status installed mesa-vdpau-drivers:amd64 25.0.7-2
2025-08-29 18:11:26 configure mesa-libgallium:amd64 25.0.7-2 <none>
2025-08-29 18:11:26 status unpacked mesa-libgallium:amd64 25.0.7-2
2025-08-29 18:11:26 status half-configured mesa-libgallium:amd64 25.0.7-2
2025-08-29 18:11:26 status installed mesa-libgallium:amd64 25.0.7-2
2025-08-29 18:11:27 configure libgl1-mesa-dri:amd64 25.0.7-2 <none>
2025-08-29 18:11:27 status unpacked libgl1-mesa-dri:amd64 25.0.7-2
2025-08-29 18:11:27 status half-configured libgl1-mesa-dri:amd64 25.0.7-2
2025-08-29 18:11:27 status installed libgl1-mesa-dri:amd64 25.0.7-2
2025-08-29 18:11:28 configure libegl-mesa0:amd64 25.0.7-2 <none>
2025-08-29 18:11:28 status unpacked libegl-mesa0:amd64 25.0.7-2
2025-08-29 18:11:28 status half-configured libegl-mesa0:amd64 25.0.7-2
2025-08-29 18:11:28 status installed libegl-mesa0:amd64 25.0.7-2
2025-08-29 18:11:29 configure mesa-va-drivers:amd64 25.0.7-2 <none>
2025-08-29 18:11:29 status unpacked mesa-va-drivers:amd64 25.0.7-2
2025-08-29 18:11:29 status half-configured mesa-va-drivers:amd64 25.0.7-2
2025-08-29 18:11:29 status installed mesa-va-drivers:amd64 25.0.7-2
2025-08-29 18:11:29 configure libglx-mesa0:amd64 25.0.7-2 <none>
2025-08-29 18:11:29 status unpacked libglx-mesa0:amd64 25.0.7-2
2025-08-29 18:11:29 status half-configured libglx-mesa0:amd64 25.0.7-2
2025-08-29 18:11:29 status installed libglx-mesa0:amd64 25.0.7-2
2025-08-29 18:11:31 configure libglu1-mesa-dev:amd64 9.0.2-1.1+b3 <none>
2025-08-29 18:11:31 status unpacked libglu1-mesa-dev:amd64 9.0.2-1.1+b3
2025-08-29 18:11:31 status half-configured libglu1-mesa-dev:amd64 9.0.2-1.1+b3
2025-08-29 18:11:31 status installed libglu1-mesa-dev:amd64 9.0.2-1.1+b3
2025-08-29 18:11:32 configure libegl1-mesa-dev:amd64 25.0.7-2 <none>
2025-08-29 18:11:32 status unpacked libegl1-mesa-dev:amd64 25.0.7-2
2025-08-29 18:11:32 status half-configured libegl1-mesa-dev:amd64 25.0.7-2
2025-08-29 18:11:32 status installed libegl1-mesa-dev:amd64 25.0.7-2
2025-08-29 18:14:28 status installed libglapi-mesa:amd64 21.3.8-1
2025-08-29 18:14:28 remove libglapi-mesa:amd64 21.3.8-1 <none>
2025-08-29 18:14:28 status half-configured libglapi-mesa:amd64 21.3.8-1
2025-08-29 18:14:28 status half-installed libglapi-mesa:amd64 21.3.8-1
2025-08-29 18:14:28 status config-files libglapi-mesa:amd64 21.3.8-1
2025-08-29 18:14:28 status not-installed libglapi-mesa:amd64 <none>
2025-08-29 18:14:28 status installed libglu1-mesa-dev:amd64 9.0.2-1.1+b3
2025-08-29 18:14:28 remove libglu1-mesa-dev:amd64 9.0.2-1.1+b3 <none>
2025-08-29 18:14:28 status half-configured libglu1-mesa-dev:amd64 9.0.2-1.1+b3
2025-08-29 18:14:28 status half-installed libglu1-mesa-dev:amd64 9.0.2-1.1+b3
2025-08-29 18:14:28 status config-files libglu1-mesa-dev:amd64 9.0.2-1.1+b3
2025-08-29 18:14:28 status not-installed libglu1-mesa-dev:amd64 <none>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

