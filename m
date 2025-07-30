Return-Path: <linux-kernel+bounces-750920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3073B162D4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129EE16B93C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9832C3265;
	Wed, 30 Jul 2025 14:30:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E829AB1E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885849; cv=none; b=rs/oEt82Rg8MANLA4XahOFsSDxdtkWxN/67a97mP0U/8oJMy2HPUAD4L8Ui7R7tw4caZrpUXSFK4yH4KCFOInRodVCdfrrQXe7vSr4K5nh3NG9bbDwDKByar0kCtjNBX6KbTrOMwjj8UDm1bo3RzEScdfexO2wkqun6B80mlwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885849; c=relaxed/simple;
	bh=EhawSziS2wxEvzCETzJpIjQJY5ka8JyXHiI3H68ebRE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uvs5tnJHQJlzGnJssW59BZCbwc/qhf2j8S1tUL9yqeFByN3SdwTvr6KEfhY6TXoZLXKNpFYfTRR1tGc9FzZIg6pHgEu/0TqhsqGFJQfQI+WeWxHDpRfzTNIe039EQnD7SnZL0zf8ycsLodBMeQ5tzG6rJZQPVtqvqNK1Q8/bex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1uh7pE-0006Et-41; Wed, 30 Jul 2025 16:30:36 +0200
Message-ID: <e58546c244fcea7d418879edf8d899393f6bd5bb.camel@pengutronix.de>
Subject: Re: [PATCH v2] drm/etnaviv: Fix flush sequence logic
From: Lucas Stach <l.stach@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>, Tomeu Vizoso
	 <tomeu@tomeuvizoso.net>
Cc: linux-kernel@vger.kernel.org, Russell King
 <linux+etnaviv@armlinux.org.uk>,  David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>,  Guido
 =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 etnaviv@lists.freedesktop.org,  dri-devel@lists.freedesktop.org
Date: Wed, 30 Jul 2025 16:30:34 +0200
In-Reply-To: <CAH9NwWfMCYKFF6Z+XiV9=4BANeyPk6bgNV_8FYM0cGwXuyDSxw@mail.gmail.com>
References: <20250507112131.3686966-1-tomeu@tomeuvizoso.net>
	 <20250508145624.4154317-1-tomeu@tomeuvizoso.net>
	 <a18f214ab0487a1c562f9e2f7f66ab1345925177.camel@pengutronix.de>
	 <CAAObsKDwVB7w0mK3qkJJ-x3sOVxbcM5pbjxJk-106baaiwM=dg@mail.gmail.com>
	 <CAH9NwWfMCYKFF6Z+XiV9=4BANeyPk6bgNV_8FYM0cGwXuyDSxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Christian,

Am Montag, dem 28.07.2025 um 00:28 +0200 schrieb Christian Gmeiner:
> Hi Lucas,
>=20
> > > > We should be comparing the last submitted sequence number with that=
 of
> > > > the address space we may be switching to.
> > > >=20
> > > This isn't the relevant change here though: if we switch the address
> > > space, the comparison is moot, as we do a full flush on AS switch
> > > anyway. The relevant change is that with the old code we would record
> > > the flush sequence of the AS we switch away from as the current flush
> > > sequence, so we might miss a necessary flush on the next submission i=
f
> > > that one doesn't require a AS switch, but would only flush based on
> > > sequence mismatch.
> >=20
> > Ah, you are right.
> >=20
> > > Mind if I rewrite the commit message along those lines while applying=
?
> >=20
>=20
> Now that v6.16 has been tagged, I was wondering why this patch didn=E2=80=
=99t make
> it into this release. From the timeline, it seemed like there was
> enough time for it
> to be included, so I=E2=80=99m just trying to understand if it was overlo=
oked
> or deferred for a reason.
>=20
That's 100% on me. I've applied the patch with the reworded commit
message into my repo, but then didn't push it out as I was planning on
batching this with some other patches. This didn't happen due to other
tasks pushing this down in my priority list.

> I also haven=E2=80=99t seen any recent activity at
> https://git.pengutronix.de/cgit/lst/linux/, which
> made me unsure about the current status of patch queue handling.
>=20
Yea, the current workflow of funneling things through this repository
doesn't work too well for the occasional small fix/patch. It works okay
as long as there are some more patches queued, but small patches tend
to get deferred for too long.
I'm pondering the idea of applying small fixes directly into drm-misc
to get them on a more predictable schedule to upstream. This will
require some changes to my workflow and I'll probably announce this via
a appropriate change to MAINTAINERS, as soon as I'm ready to make the
switch.

Regards,
Lucas

