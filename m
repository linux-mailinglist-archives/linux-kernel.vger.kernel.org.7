Return-Path: <linux-kernel+bounces-649874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D27AB8A40
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 17:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593DD16F015
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 15:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0805620C004;
	Thu, 15 May 2025 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uuXjy6nL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M+MwKNeB"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4C13E41A
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321551; cv=none; b=QVT0zp7t953SXv0UWuRTZMSWzK9wWkdeN95GuSoVzyAlbyWhrmQf3VGh4TfAJlRHBJ8j2rEaOxhvEq0UmOc42A8IQ4/9/hr5+hB1wnLVtidoAEG9bOAcKNU/Ls1EZU1lz/chaci4H8nTfce3IF3cfW8AsUZ5mNrmzXm1H3XLrBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321551; c=relaxed/simple;
	bh=8D7OlMDCA2M/nh6euFq106UQJpUJ1S0Yl6xP627hfCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=em4C8vYpSpzZ8y/yMhGGogKgwEAP4Wl9wxQo4lGLBAHGVme2uEiGBHqlYrmfQlxRONfTSZ84WW1wxB0YXKCGubiQMIW1+yuGQXvYhCNYTIhHkF+bWMADmPI9D/vD8V7188AYLl1wi1de/vbvG2JUWB5gSiqXWrPMKKl0XYnPFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uuXjy6nL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M+MwKNeB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D18FC1F7B7;
	Thu, 15 May 2025 15:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747321548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8D7OlMDCA2M/nh6euFq106UQJpUJ1S0Yl6xP627hfCA=;
	b=uuXjy6nLn4/IB9kBLplBXHo61XI3TQrx4GLZYyzoJp1u+ybbkMl5La8d8EQFuiIXXnAO77
	hGqYa79HAeDe37U497TfxpNBtz7BAYeH8EUdUXaV2XSt0buAfOxsp0+lDBMq/Rd74grbKD
	zQWQqEHUoD/vB7cF8BGjxeskdYRnS8Q=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=M+MwKNeB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747321547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8D7OlMDCA2M/nh6euFq106UQJpUJ1S0Yl6xP627hfCA=;
	b=M+MwKNeB1/2ssYtC0c7xr+YW7sh1RsyJ7MAzMkM1MvNqbeFHEI29hwDPuOaKdOuPf9yK9P
	BUH84OJfGKqgyjPR1DLnNkB8IxLyUKm3HCjtw9O6PgrOY1j/tGEok2L/GZqvHcjaHpMSSA
	R8FlbUQp1dc118X627hfINsbGf95K8E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CEA5139D0;
	Thu, 15 May 2025 15:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yp7dIMsCJmjwPgAAD6G6ig
	(envelope-from <mwilck@suse.com>); Thu, 15 May 2025 15:05:47 +0000
Message-ID: <603d15940074b2d4756dea613e834bf37ea1aafd.camel@suse.com>
Subject: Re: [PATCH 0/2] dm mpath: Interface for explicit probing of active
 paths
From: Martin Wilck <mwilck@suse.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Benjamin Marzinski
	 <bmarzins@redhat.com>, dm-devel@lists.linux.dev, hreitz@redhat.com, 
	mpatocka@redhat.com, snitzer@kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 May 2025 17:05:47 +0200
In-Reply-To: <aCW95f8RGpLJZwSA@redhat.com>
References: <20250429165018.112999-1-kwolf@redhat.com>
	 <47dd225b433b0df585a25084a2e793344eeda239.camel@suse.com>
	 <aCIRUwt5BueQmlMZ@redhat.com>
	 <d51d6f85b5728648fe9c584f9cb3acee12c4873f.camel@suse.com>
	 <cc2ec011cf286cb5d119f2378ecbd7b818e46769.camel@suse.com>
	 <aCW95f8RGpLJZwSA@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D18FC1F7B7
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action

On Thu, 2025-05-15 at 12:11 +0200, Kevin Wolf wrote:
> Am 14.05.2025 um 23:21 hat Martin Wilck geschrieben:

>=20
> > In the long term,=C2=A0we should evaluate alternatives. If my conjectur=
e
> > in
> > my previous post is correct we need only PRIN/PROUT commands, there
> > might be a better solution than scsi-block for our customers. Using
> > regular block IO should actually also improved performance.
>=20
> If you're talking about SG_IO in dm-mpath, then PRIN/PROUT commands
> are
> actually the one thing that we don't need. libmpathpersist sends the
> commands to the individual path devices, so dm-mpath will never see
> those. It's mostly about getting the full results on the SCSI level
> for
> normal I/O commands.

I know. I meant "need" from the PoV of the guest, in the sense "which
commands need to be passed from the guessed to the device (in some
reasonable way) except the normal READ and WRITE commands?".

Regards
Martin

