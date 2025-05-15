Return-Path: <linux-kernel+bounces-649864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6818DAB8A28
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 17:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4024C3B1740
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07A920F09A;
	Thu, 15 May 2025 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AR1x3qDW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AR1x3qDW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C6A211A0D
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321247; cv=none; b=sPznhd4IY0vyP63PKh5hNDJr6MZ+F4nhBMSfKy7qenuI7JPaHNYg0iiShxy6u2wsMCNkbhQbUTHih13B3gzqLl6nIK7oLQihMK3qtpQhVAaSK04U/HJ8fMm0Pd9UE1sdBPGze1L7miWKrf6lfOhFwCHzD7tE3rX1BOzAXJ1xQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321247; c=relaxed/simple;
	bh=6zLV7/Flv0Q6ihpP1MvipdkgtA9z8ybqScItcI7FQTg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FZ72bRaZXyXmLz9uvpyiA9FJjviAYvX6yVMRZlz7XXCJymqqTgHKX4+gMN5tmqzxtRDcPnN8Jdax1ZzvOVreMRV/R/e4JjaHIteQb4boeCz6wmO2rdKlZuYFmDCwPjTnLEUpiV9lFkGnuRRaRxUo9+5YvIbWEdQbqE/AGlkmay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AR1x3qDW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AR1x3qDW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D58FA2123D;
	Thu, 15 May 2025 15:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747321242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zLV7/Flv0Q6ihpP1MvipdkgtA9z8ybqScItcI7FQTg=;
	b=AR1x3qDWJNA249aVvWbj16f+1cRCKJIQe5FZbqJVQkErDOn84tA/dzv6uI4OxD1OibfOrt
	MG5q7QwBr037qPI7EEogvADCHMDc/V0R0bcvy1VruAZ90a2bMH9d69YlCzNb+u0hdUL7I7
	m8JSYjtwG84xCu9RE3uRkhfJ9NxY8aQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747321242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zLV7/Flv0Q6ihpP1MvipdkgtA9z8ybqScItcI7FQTg=;
	b=AR1x3qDWJNA249aVvWbj16f+1cRCKJIQe5FZbqJVQkErDOn84tA/dzv6uI4OxD1OibfOrt
	MG5q7QwBr037qPI7EEogvADCHMDc/V0R0bcvy1VruAZ90a2bMH9d69YlCzNb+u0hdUL7I7
	m8JSYjtwG84xCu9RE3uRkhfJ9NxY8aQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 787FB139D0;
	Thu, 15 May 2025 15:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6ELUG5oBJmhWPQAAD6G6ig
	(envelope-from <mwilck@suse.com>); Thu, 15 May 2025 15:00:42 +0000
Message-ID: <5911e91974db637d4a3395e60244c2c52b27b4b4.camel@suse.com>
Subject: Re: [PATCH 0/2] dm mpath: Interface for explicit probing of active
 paths
From: Martin Wilck <mwilck@suse.com>
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig
 <hch@infradead.org>,  Kevin Wolf <kwolf@redhat.com>,
 dm-devel@lists.linux.dev, Hanna Czenczek <hreitz@redhat.com>, Mikulas
 Patocka <mpatocka@redhat.com>, snitzer@kernel.org, "Kernel Mailing List,
 Linux"	 <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.com>
Date: Thu, 15 May 2025 17:00:41 +0200
In-Reply-To: <aCX6Ys9mOc441ydA@redhat.com>
References: <20250429165018.112999-1-kwolf@redhat.com>
	 <47dd225b433b0df585a25084a2e793344eeda239.camel@suse.com>
	 <aCIRUwt5BueQmlMZ@redhat.com> <aCLe5UT2kfzI96TQ@infradead.org>
	 <aCMQ5S-gI6vZJxmq@redhat.com> <aCQiz88HksKg791Z@infradead.org>
	 <aCTDiHMuMncwdp_X@redhat.com>
	 <50beb356b4dc000446fd186ab754c87f386eaeae.camel@suse.com>
	 <CABgObfaEiMN=YANk02EWini+jAXU1MxSvo8_jYWaMiu3ds7hgQ@mail.gmail.com>
	 <2f0fc8ef7d04c590893bd6d54a6c0c842c4b21d7.camel@suse.com>
	 <aCX6Ys9mOc441ydA@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid]

On Thu, 2025-05-15 at 10:29 -0400, Benjamin Marzinski wrote:
> On Thu, May 15, 2025 at 12:34:13PM +0200, Martin Wilck wrote:
> >=20
> > However, I suppose that depends on the permissions with which the
> > qemu
> > process is started, no? Wouldn't qemu need CAP_SYS_RAWIO for PCI
> > passthrough as well?=20
> >=20
> > I admit that I'm confused by the many indirections in qemu's scsi-
> > block
> > code flow. AFAICS qemu forwards everything except PRIN/PROUT to the
> > kernel block device in "scsi-block" mode. Correct me if I'm wrong.
> >=20
> > Anwyway, let's not forget that we're talking about the kernel here.
> > While qemu is the main target application for this feature is
> > created,
> > any application can use it, and it may or may not run with
> > CAP_SYS_RAWIO.
>=20
> Maybe I'm missing your issue, but QEMU is just using DM's existing
> ioctl
> forwarding code, which was already designed for general use, and I
> don't
> see any capability issues with this patchset itself.

I didn't mean it this way. I was rather musing about the question
whether doing SG_IO on multipath devices by forwarding them to the
current path makes sense.

Sorry for the confusing post.

Regards
Martin

