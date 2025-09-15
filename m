Return-Path: <linux-kernel+bounces-816341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57239B5729F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1123A8489
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267752EAD05;
	Mon, 15 Sep 2025 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fLEzUF3S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WhForuUw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fLEzUF3S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WhForuUw"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18E426CE23
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924097; cv=none; b=f07EF4QEMWsaOZFbaLiFn/1rpErXYh4tRbvLq/HoQD/FRKYV/BlofCbCshPKpmqdGsu7324m2c9m9kgNBugMi0xELzp3j/XK3mLQ/YG9+qQNi6hQ/my8pTqmTt21wUd85/dT6qOT/S9GljMDbf/UQqb4HL3LG+tI5ghETrLM4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924097; c=relaxed/simple;
	bh=deJY1b9TWxN7bxAyrceEcgEUmvcwqV8/tbUprds4akI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpHdFu81aaWncQOKq5r+zTUD+I9JypKRwgwNKfRrnQg88kb6MwZPvth0R05LfTLQ2Pz8YmUFvWWA+n1rEthgBf6m6rZ90aeMk6ObpEXuVJ9zudTe0FOZ+KV44anE6++5s3HIVRGyNGqlGxhyJ9x2MlSWMVs3LVeNM12jglvg1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fLEzUF3S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WhForuUw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fLEzUF3S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WhForuUw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 332221F821;
	Mon, 15 Sep 2025 08:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757924093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGy0rfdSRjLJPpgGFILAlv/48JaKsrMZ18rxppBWgPo=;
	b=fLEzUF3SFRbMwOfmLkqeV9pe8sbX3A3lB39Yo3RrSdU8Blv/NV+2QNUXJDhaKXZzKXJ5e5
	I5DEzPgwNLBChq1/q/fD86GnecXfmroRe8a6Hmhz6KXbEOafs4WMfXVKB8V328N0Pqh866
	VwW/E6rPVWqYo0K/PYcvEquZuLFE0i0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757924093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGy0rfdSRjLJPpgGFILAlv/48JaKsrMZ18rxppBWgPo=;
	b=WhForuUwl8lPZHxbv1oL3ag44IUcWYWhDOlIy08GdKLHBEswynXn3YI+vkQAis+hwyODat
	yBEoRnN7bkE3rYCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757924093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGy0rfdSRjLJPpgGFILAlv/48JaKsrMZ18rxppBWgPo=;
	b=fLEzUF3SFRbMwOfmLkqeV9pe8sbX3A3lB39Yo3RrSdU8Blv/NV+2QNUXJDhaKXZzKXJ5e5
	I5DEzPgwNLBChq1/q/fD86GnecXfmroRe8a6Hmhz6KXbEOafs4WMfXVKB8V328N0Pqh866
	VwW/E6rPVWqYo0K/PYcvEquZuLFE0i0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757924093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGy0rfdSRjLJPpgGFILAlv/48JaKsrMZ18rxppBWgPo=;
	b=WhForuUwl8lPZHxbv1oL3ag44IUcWYWhDOlIy08GdKLHBEswynXn3YI+vkQAis+hwyODat
	yBEoRnN7bkE3rYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06AFA1368D;
	Mon, 15 Sep 2025 08:14:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BQ+ELPnKx2hKYwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 15 Sep 2025 08:14:49 +0000
Date: Mon, 15 Sep 2025 18:14:40 +1000
From: David Disseldorp <ddiss@suse.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Andrew Morton <akpm@linux-foundation.org>, Martin Wilck
 <mwilck@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Askar Safin
 <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: INITRAMFS_PRESERVE_MTIME should depend on
 BLK_DEV_INITRD
Message-ID: <20250915181440.1e52a824.ddiss@suse.de>
In-Reply-To: <9a65128514408dc7de64cf4fea75c1a8342263ea.1757920006.git.geert+renesas@glider.be>
References: <9a65128514408dc7de64cf4fea75c1a8342263ea.1757920006.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,suse.com,zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.80

On Mon, 15 Sep 2025 09:11:05 +0200, Geert Uytterhoeven wrote:

> INITRAMFS_PRESERVE_MTIME is only used in init/initramfs.c and
> init/initramfs_test.c.  Hence add a dependency on BLK_DEV_INITRD, to
> prevent asking the user about this feature when configuring a kernel
> without initramfs support.
> 
> Fixes: 1274aea127b2e8c9 ("initramfs: add INITRAMFS_PRESERVE_MTIME Kconfig option")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Makes sense, thanks.

Reviewed-by: David Disseldorp <ddiss@suse.de>

