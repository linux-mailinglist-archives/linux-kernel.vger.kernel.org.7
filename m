Return-Path: <linux-kernel+bounces-829047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD91B96288
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBCB189C10C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC122AE5D;
	Tue, 23 Sep 2025 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ePyuwXCa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W1IgXTQ1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ePyuwXCa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W1IgXTQ1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3AF2C18A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636753; cv=none; b=EiWzlOf0eh4Tlw1pNc++NJk8eiDDF2GenHnbSdrOz/bHYugdOrW8OnJSXNGW2p7khvnyHL+P2k+4DaagoQtU+1qj/nrjpQbcUfO9DRuKdKhzskUKAdzyUGmdf5HawNbcgqlBGw07+4efrhWEH4ZbzzBpm3v0Vk3fz0RTkRCNuxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636753; c=relaxed/simple;
	bh=5oiLnXwvYshk3SuVqUieIDTzEaVZzka/NXa7elvWnKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIkPq4Ptl/32HrNCtusxWaJ879gnYs+jH0XeDkICMJRzPmIHXRr4nP6ImMtb1X08SVdmfUfHUT6df6C0VAhuj0jZPrNOAr4KtreS4v5JfhuB+T8Yby6f+GCyrrqEMXvpUZAAtGdMRoi1aP7EFxMd/9RYwKdFkTs+WR4/RDX/lMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ePyuwXCa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W1IgXTQ1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ePyuwXCa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W1IgXTQ1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6AB1C1F816;
	Tue, 23 Sep 2025 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758636749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9XK9zZEU0jq4iKtoPtCtzX8XakuPTywSB8s16iGNXw=;
	b=ePyuwXCa0v1I/rlBKzDmcvbGnqXtpoxZsdar1sBILVKFQqP4Zd9t1AxCfi2KfGelkyvtvB
	V+9ed1BulX0/j9PR6706dnSauxU/V7Sp0F/9HRHpdwkiVyhkNdONYWXcB6815UG4nOwYgw
	AWTW72pHkfZ2xYnHMrgIZ3GPyCaew/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758636749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9XK9zZEU0jq4iKtoPtCtzX8XakuPTywSB8s16iGNXw=;
	b=W1IgXTQ1ipPSsWzhEB+GGwsGdKgW8V0iB94B35HMqWt5f2+VJYVLJmhs0g76YU9byXToHv
	hq/Fwf52sZWDLmCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ePyuwXCa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=W1IgXTQ1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758636749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9XK9zZEU0jq4iKtoPtCtzX8XakuPTywSB8s16iGNXw=;
	b=ePyuwXCa0v1I/rlBKzDmcvbGnqXtpoxZsdar1sBILVKFQqP4Zd9t1AxCfi2KfGelkyvtvB
	V+9ed1BulX0/j9PR6706dnSauxU/V7Sp0F/9HRHpdwkiVyhkNdONYWXcB6815UG4nOwYgw
	AWTW72pHkfZ2xYnHMrgIZ3GPyCaew/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758636749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9XK9zZEU0jq4iKtoPtCtzX8XakuPTywSB8s16iGNXw=;
	b=W1IgXTQ1ipPSsWzhEB+GGwsGdKgW8V0iB94B35HMqWt5f2+VJYVLJmhs0g76YU9byXToHv
	hq/Fwf52sZWDLmCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2D94132C9;
	Tue, 23 Sep 2025 14:12:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s/ElKsyq0mi5PgAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Tue, 23 Sep 2025 14:12:28 +0000
Date: Tue, 23 Sep 2025 11:12:18 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: Henrique Carvalho <henrique.carvalho@suse.com>, 
	rajasimandalos@gmail.com, linux-cifs@vger.kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	linux-kernel@vger.kernel.org, Rajasi Mandal <rajasimandal@microsoft.com>
Subject: Re: [PATCH 1/2] cifs: client: force multichannel=off when
 max_channels=1
Message-ID: <t4t6ofbhgr2a7hn4a7eboqw2xwniwj6ed2ipg42bymj24iwctw@7j7pjni23wx7>
References: <20250922082417.816331-1-rajasimandalos@gmail.com>
 <da3e2b5a-a5da-4526-9884-8789990ebf95@suse.com>
 <qmf3xwqq4hqj4issgci2g76eghytaqxihnrp236ithh2istkkf@n4s54vp3hblr>
 <CANT5p=qH9aXGpQzcCwFZ81MGrKFYiGBHxejdy-oRAa_QN=k=Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANT5p=qH9aXGpQzcCwFZ81MGrKFYiGBHxejdy-oRAa_QN=k=Yw@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org,samba.org,manguebit.org,microsoft.com,talpey.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 6AB1C1F816
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On 09/23, Shyam Prasad N wrote:
>On Mon, Sep 22, 2025 at 8:29=E2=80=AFPM Enzo Matsumiya <ematsumiya@suse.de=
> wrote:
>>
>> On 09/22, Henrique Carvalho wrote:
>> >Hi Rajasi,
>> >
>> >On 9/22/25 5:24 AM, rajasimandalos@gmail.com wrote:
>> >> From: Rajasi Mandal <rajasimandal@microsoft.com>
>> >>
>> >> Previously, specifying both multichannel and max_channels=3D1 as mount
>> >> options would leave multichannel enabled, even though it is not
>> >> meaningful when only one channel is allowed. This led to confusion and
>> >> inconsistent behavior, as the client would advertise multichannel
>> >> capability but never establish secondary channels.
>> >>
>> >> Fix this by forcing multichannel to false whenever max_channels=3D1,
>> >> ensuring the mount configuration is consistent and matches user inten=
t.
>> >> This prevents the client from advertising or attempting multichannel
>> >> support when it is not possible.
>> >>
>> >> Signed-off-by: Rajasi Mandal <rajasimandal@microsoft.com>
>> >> ---
>> >>  fs/smb/client/fs_context.c | 7 +++++++
>> >>  1 file changed, 7 insertions(+)
>> >>
>> >> diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
>> >> index 072383899e81..43552b44f613 100644
>> >> --- a/fs/smb/client/fs_context.c
>> >> +++ b/fs/smb/client/fs_context.c
>> >> @@ -1820,6 +1820,13 @@ static int smb3_fs_context_parse_param(struct =
fs_context *fc,
>> >>              goto cifs_parse_mount_err;
>> >>      }
>> >>
>> >> +    /*
>> >> +     * Multichannel is not meaningful if max_channels is 1.
>> >> +     * Force multichannel to false to ensure consistent configuratio=
n.
>> >> +     */
>> >> +    if (ctx->multichannel && ctx->max_channels =3D=3D 1)
>> >> +            ctx->multichannel =3D false;
>> >> +
>> >>      return 0;
>> >>
>> >>   cifs_parse_mount_err:
>> >
>> >Do we even need ->multichannel flag at all? Maybe we could replace
>> >->multichannel for a function that checks for max_channels > 1?
>>
>> I agree with Henrique.
>>
>> I'd actually like to propose going even further and having the whole
>> module behaving as if multichannel was always on, even with
>> max_channels=3D1 -- the only difference being the need to run the
>> query_interfaces worker.
>>
>> This is probably work for another patch/series though.
>>
>>
>> Cheers,
>>
>> Enzo
>>
>
>Although I agree with this line of thought, I'd want to do it slightly
>differently.
>max_channels should be a configurable option for users to tune the
>number of max channels, even if the actual channel count is lower.
>multichannel mount option should be kept to maintain backward
>compatibility, but always be interpreted based on max_channels value.
>
>In the future, we should make max_channels=3D16 the default, thereby
>enabling multichannel by default. Users optionally can set
>max_channels to a lower value.

Have you seen the PoC patch I put here?
https://lore.kernel.org/linux-cifs/byjdlepkzmhm6j4ap5eyzdcusl7dgq3iuhkduf3s=
5h4mrayj32@lzwe2rksc4ei/

It's an attempt to remove confusion for the user-facing mount options.

As for behaviour, I think we all agree on it in general, it's just that
the implementation (dev perspective, having too many ways to check for
the same thing) is confusing and error prone cf. my comment about
query_interfaces worker running even if the user never requested
multichannel -- regardless if it runs every Xmin, it's 100% unnecessary.


Cheers,

Enzo

