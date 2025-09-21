Return-Path: <linux-kernel+bounces-826354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9832B8E491
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95179179142
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED0621883E;
	Sun, 21 Sep 2025 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="o93W3Wql"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C761A5B8D
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758484846; cv=none; b=ZpNmnAwl3O2hwr4KmIk+obbra/aZFvTWdrg4arpSIl1L6E2sVwCft9A1LBCNutOuc+uyOxhe+NmjYvAdF6OEWb62/SycAvKd9nbHDHHWlNA2fdoQyT2WaTkET0tMmLjg8SZZVHi7Yfvno/Q0Xqlm27fY7QAfMSb7VH9EBOtEgyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758484846; c=relaxed/simple;
	bh=WMCOeDIKrlJVUUux6y2tkqoyhVNipRT1bzBjnTbdAwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJ1HD/zgoyvIuSnOpmXv2m/heN1h2EAjLDhPvH8bOoRLzgbRn5WV6ceFO/JmPm1xM951hpQgcSJoRMvjYlYu4N5sWx5596qllIqW5/d6QFo3JqZNiHK/+VKiPR/zZg90rxUEq8TJsMxDFLWC10i+tlV9RffvNGmHY67QdXeNhMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=o93W3Wql; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758484841;
	bh=WMCOeDIKrlJVUUux6y2tkqoyhVNipRT1bzBjnTbdAwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o93W3Wql+RRMWUfu3qFSLeT/pQNT3Uo2J00nLzyeV/pdKyH8/UcQVpEVqsXSus2mp
	 YaPM2gT1StDbWDmvDzLWCV8+4aAeYn5fGvBb71Db9MMGZXY75KQ1y+a3HRCkqVck1P
	 ulzjW+7cXIREH1UPAB24dkTXy9YDG6IsQGVeURek=
Date: Sun, 21 Sep 2025 22:00:41 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Message-ID: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
 <20250810055136.897712-4-tiwei.bie@linux.dev>
 <d28c9690341715fff04fbc01fd80723a30195f23.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28c9690341715fff04fbc01fd80723a30195f23.camel@sipsolutions.net>

On 2025-09-10 13:59:02+0200, Johannes Berg wrote:
> On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > 
> > We are going to support SMP in UML, so we can not hard code
> > the CPU and NUMA node in __vdso_getcpu() anymore.
> 
> Correct. But does that mean we actually have to implement it via syscall
> in the VDSO? That seems a bit odd? ARM doesn't seem to have getcpu in
> the VDSO at all, for example, so could we do the same and just remove
> it?

It is my understanding that the UM VDSO exists to cope with old versions
of glibc which would fall back to the old vsyscall mechanism if no VDSO
was present. That could fall through to the host kernels vsyscalls.
See commit f1c2bb8b9964 ("um: implement a x86_64 vDSO").

If this is not necessary anymore, the whole VDSO on UM can probably go
away.


Thomas

