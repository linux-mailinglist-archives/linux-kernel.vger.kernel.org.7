Return-Path: <linux-kernel+bounces-766264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02870B24475
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF5726F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8061E2EFD9B;
	Wed, 13 Aug 2025 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QyTyUXf9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rY0Tt0EG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QyTyUXf9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rY0Tt0EG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DAF2D4B44
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074065; cv=none; b=ft88c6xNBLhtA9boXueDwwXVnlMlCm6rEejmuaM7fSAfoP0rz9tVKwiuw32TItS4nCO5eJhCufb6O6Oe+g63MnNPKKn03bfr7D2FxnEE4VqtntTA33tyNoJKDUjr7uphtyZAjUVmSb8RUiYOUbxcgvX3bcQP41Rcjuulq2e0S40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074065; c=relaxed/simple;
	bh=E3DyaByQxUkfiHJ9NRXB7OEkdMFebQGZn0UQMeb245g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urglgDHgxzrgG4VyKbvMXM6wNocnXSGVoPm/aoZX5oL6S0pr8UrvpFyC3huCPh4fyiqNzgfYDHiWfhzFa53I/GHzZH27MYTzGUYukaPb0L84saotncuQrOTt2YLjFFW8RFpawJWaXJ70EJoR0XrJ4kWYlb2b/i5s2AiTKswJKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QyTyUXf9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rY0Tt0EG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QyTyUXf9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rY0Tt0EG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 677461F750;
	Wed, 13 Aug 2025 08:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755074062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1GaT5iq3ZrSTTTxJZ495pxMS40ajV1V9kU9eIqF88s=;
	b=QyTyUXf9lI0ITST2C0sVGsmS0jeDuJmeWhUGjgJwFrtV6mSOH9GFMkCedUycQh5mIPXYF7
	xanHv44NdFdHurbN5+L+9N4REXauCdZrHFjb/NL5WwM3PWvMIsDEQgCaBBtPtmnP6v3H0b
	DxEN9a8XDJEkAYgQh8BbEq+6E8bVQs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755074062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1GaT5iq3ZrSTTTxJZ495pxMS40ajV1V9kU9eIqF88s=;
	b=rY0Tt0EG6/+68+ZiMvs4t69aRNgWMGqVXtr74eUbNMEhxwOXotXjwCASVE7510iAitVaG0
	+o6oqr3UtQDOm+AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755074062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1GaT5iq3ZrSTTTxJZ495pxMS40ajV1V9kU9eIqF88s=;
	b=QyTyUXf9lI0ITST2C0sVGsmS0jeDuJmeWhUGjgJwFrtV6mSOH9GFMkCedUycQh5mIPXYF7
	xanHv44NdFdHurbN5+L+9N4REXauCdZrHFjb/NL5WwM3PWvMIsDEQgCaBBtPtmnP6v3H0b
	DxEN9a8XDJEkAYgQh8BbEq+6E8bVQs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755074062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1GaT5iq3ZrSTTTxJZ495pxMS40ajV1V9kU9eIqF88s=;
	b=rY0Tt0EG6/+68+ZiMvs4t69aRNgWMGqVXtr74eUbNMEhxwOXotXjwCASVE7510iAitVaG0
	+o6oqr3UtQDOm+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FA0B13479;
	Wed, 13 Aug 2025 08:34:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xB5YDg5OnGj/CwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 13 Aug 2025 08:34:22 +0000
Date: Wed, 13 Aug 2025 10:34:21 +0200
Message-ID: <87ldnny60i.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 1/7] ALSA: usb-audio: Add initial driver for TASCAM US-144MKII
In-Reply-To: <20250812132209.83728-2-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
	<20250812132209.83728-1-ramiserifpersia@gmail.com>
	<20250812132209.83728-2-ramiserifpersia@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Tue, 12 Aug 2025 15:22:03 +0200,
©erif Rami wrote:
> 
> diff --git a/sound/usb/usx2y/us144mkii.h b/sound/usb/usx2y/us144mkii.h
> new file mode 100644
> index 000000000000..38731a1285ea
> --- /dev/null
> +++ b/sound/usb/usx2y/us144mkii.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +// Copyright (c) 2025 ©erif Rami <ramiserifpersia@gmail.com>
> +
> + #ifndef __US144MKII_H
> + #define __US144MKII_H
> +
> + #include <linux/usb.h>
> + #include <sound/core.h>
> + #include <sound/initval.h>
> +
> + #define DRIVER_NAME "us144mkii"
> +
> +/* --- USB Device Identification --- */
> + #define USB_VID_TASCAM 0x0644
> + #define USB_PID_TASCAM_US144 0x800f
> + #define USB_PID_TASCAM_US144MKII 0x8020
> +
> +/* --- USB Control Message Protocol --- */
> + #define RT_D2H_VENDOR_DEV (USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_DEVICE)
> + #define VENDOR_REQ_MODE_CONTROL 0x49
> + #define MODE_VAL_HANDSHAKE_READ 0x0000
> + #define USB_CTRL_TIMEOUT_MS 1000

Drop a space at the beginning of lines here (which will be corrected
in later patches).


thanks,

Takashi

