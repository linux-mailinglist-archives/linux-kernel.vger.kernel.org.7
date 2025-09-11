Return-Path: <linux-kernel+bounces-811466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926A1B52976
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E56A68254A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB569266EEA;
	Thu, 11 Sep 2025 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qVHYzEIx"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD125DB1A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757574017; cv=none; b=FujsiQROqjgRG1abBAcTd7bxaPEzrXVFFYSI9d2muUC2wW9OLM5eX62Fij7DXidPojT5FswH8nZJj9YetFqcr1oLOdijpODM+8Ud4KcuxZdlWRL26f6JdjGullV7qFlhepHVOrGqbSfVtFsk17wAC9aHuvBmGIN5V84cG87zXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757574017; c=relaxed/simple;
	bh=HdnqPYodhpR04ucnmjP64RcI7avQd7r4ewcWEUbKzTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TizBO1INRfw+v+pjKnYz2McAiHIyOzVqAO2YvuzuCo3Wb5cgSEw3/9YW+3YUZQ1GA40vE67s+bVIJcvNqwTVsG4EDWCe4JG5m8VJ4lIXkREzo8za3+M7P29n1NxzLsa+NOo3xQAg/8KJIHq2JjqYFttYt/p7QrnVDyUQdQCrIOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qVHYzEIx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HdnqPYodhpR04ucnmjP64RcI7avQd7r4ewcWEUbKzTs=;
	t=1757574006; x=1758783606; b=qVHYzEIxJzOU75po5L7Zq0HBpahgJorBeX1BCIV4O2q6tPx
	lZUtIs/jzpedTne/QhOCDU9PbdTQbXVt490PCcj6bco12RlyZ5Q5tKyzWDbq3nqXzVK96JbfJz6hV
	1EFcQWdF8wLcqGNnYVBCFZiU9b2YpvAxkOLeyGqz79GeQ06LXzdoHJUrrNnvRVaI4SOlurdOU6zV2
	7rhE1TdNRdS8F3+0rZwtOufkfc8uepScGvEHJmEC6tSPkdWyEPFa8yfBLaaf2RPnGRcXtv4eX/scF
	9QhEJOfejRZ3tuQh8Sx+/cxQVmRyb7ywG+SoeJNfT+IkexVID/FInlIvMM6OWJRg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwbHi-0000000Enrr-2rRz;
	Thu, 11 Sep 2025 08:59:58 +0200
Message-ID: <579899d18d5aa4422f970d28e19dc363c9ed218a.camel@sipsolutions.net>
Subject: Re: [PATCH v2 05/10] um: Determine sleep based on need_resched()
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
 benjamin@sipsolutions.net, 	arnd@arndb.de, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 08:59:57 +0200
In-Reply-To: <20250911043918.2950727-1-tiwei.bie@linux.dev>
References: 
	<55cace5b8e1078bd04b4a1acb5df9faa6a83b6e8.camel@sipsolutions.net>
	 <20250911043918.2950727-1-tiwei.bie@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-09-11 at 12:39 +0800, Tiwei Bie wrote:
> On Wed, 10 Sep 2025 14:10:37 +0200, Johannes Berg wrote:
> > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > >=20
> > > With SMP and NO_HZ enabled, the CPU may still need to sleep even
> > > if the timer is disarmed. Switch to deciding whether to sleep based
> > > on pending resched. This is a preparation for adding SMP support.
> >=20
> > What's the rationale for need_resched()? Is that somehow defined for
> > this? Is it what other architectures use? I guess I'm just not entirely
> > sure what it means.
>=20
> Here is a relevant document:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/scheduler/sched-arch.rst?h=3Dv6.17-rc5#n37
>=20
> There is a similar check on x86:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/x86/kernel/process.c?h=3Dv6.17-rc5#n916

Ah cool, thanks for the pointers. Though "1." part there is a bit
confusing, I guess I'll send a patch to reword it :)

FWIW I already applied a few patches, but I'll take another look,
hopefully today.

johannes

