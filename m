Return-Path: <linux-kernel+bounces-810150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C875B5169E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7284B1C81042
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F6B286D55;
	Wed, 10 Sep 2025 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gPGNSrOr"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D358248B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506536; cv=none; b=ojaqcubc5gbIMY9KDH23ccmJAMmW8CwCHDfo14VsJDyd0sIzOMfMHhdvaRApk7DidW0wxpszDeMpFI2ptpR9wI3tm892GuXw3n+okx+bYSRLLS4PVJrxVeM62koNeWv9zVzaXL4ELacqRrXvZosKGjsLFjmdIsi2fZHx1YVxrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506536; c=relaxed/simple;
	bh=CPMluIxzYTxyo+SE1q9wxQ767RFtvJEbmf1nP5T/LRk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mio3YbxEhE5YNtBqNB3X8Ckfm/iOlLUbXfILZtDUHcpR9XKTDJgrisgrnKjlSqUxyGUTZvdmBjpD9FJPRT/OPJofGtaR6j5aQi0lJ6qs1Xv02ji4FiE3BfQCgBWPB953iZnXGUpnhbuZbR+JlbporqCeTjf/7wss7T3N1NLXlbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gPGNSrOr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CPMluIxzYTxyo+SE1q9wxQ767RFtvJEbmf1nP5T/LRk=;
	t=1757506534; x=1758716134; b=gPGNSrOrgpEUhdtrw093CMEpPcrZdTW17diExXmt2cs9BH/
	KrTmNgsWGj7QKBfKBF5xdutUHw1X6fhusG9iUrQdM+9V7dcHe5+D9MuH6ds+EoZkrrDGbi1WDG/gH
	QCQNp2S/MYpjq5ND9DoeXxgqQ+OE6HiOb43p5sndXscu/K76WlmPmOtQyCKbTrXUqNZuZJvBDalVj
	LfeBc5NyMRgUsd3oxx1l36N2ghiLC2tOHNiKJJgKu4advehHHPMeTYP5UaLYiMvDw7MWlrKYefyK8
	jHDPfAbgbyob+eRR5DbKI03Ujs184sioBbIkDs+z6Wd3iHsRLGrE0KWirDpVxZuQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwJjV-0000000Colo-2YFT;
	Wed, 10 Sep 2025 14:15:29 +0200
Message-ID: <f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com
Date: Wed, 10 Sep 2025 14:15:28 +0200
In-Reply-To: <20250810055136.897712-5-tiwei.bie@linux.dev> (sfid-20250810_075242_713590_DCDE368B)
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
	 <20250810055136.897712-5-tiwei.bie@linux.dev>
	 (sfid-20250810_075242_713590_DCDE368B)
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

On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
>=20
> Turn signals_enabled, signals_pending and signals_active into
> thread-local variables. This enables us to control and track
> signals independently on each CPU thread. This is a preparation
> for adding SMP support.

[...]

> +static __thread int signals_enabled;

How much glibc infrastructure does __thread rely on? More specifically:
Some time ago we had a discussion about building UML as a nolibc binary,
what would that mean for the __thread usage here?

johannes

