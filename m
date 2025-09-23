Return-Path: <linux-kernel+bounces-828140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC9B94069
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E662A7809
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E12741BC;
	Tue, 23 Sep 2025 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="hvblbB1a"
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15547270572
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758595220; cv=none; b=lW8GXpRSaz85x0+xh66X7gHTEo5exktzGZOR/a07kB7LYMVubcQa2uWmJ0b0wwnH2oxlfycCeV5FHAcMBe/0tVV+BH7X8lFqKncw4qUDVSeh10/d/2/H4mTP8n5PDXEhbfbRHgdCYJZWG+U0CaP9lvz7L5gOS7CPfoijOHNEDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758595220; c=relaxed/simple;
	bh=vfDfTsyYfO/BqRmTkPgyem+KWINdSwj36PIiWxhUsjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czNz/FG9tFMM9T3+GJOCXZeV81opy19S3TgxOcn6aM529yFBO+niX28czsGgsvXwxeqkX7Kth7/L2d9cxd8CDlqUvFnT3qYWT5TA0SzVSXKQe68VPOMtrHfdOCblyLq9KneHGHDOZj/B0DGdcKuwCWA/vO2b+nyAa4/D4u/ixyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=hvblbB1a; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-7900952fb89so41604606d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1758595217; x=1759200017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vUgX58DsyU0+b3vhwK7OifvnksHmZK93Xb99v2Xcmk=;
        b=hvblbB1aHbYpfkTioQWGBNaezDoFfL78O+2hNuAM7fgTAqQ9p0liDGsgLSE5f6pxDf
         lrQePrdDX7KNAuKlvFa2LmDXfcWn9uTNfbCCV8tbDOOdcpy/7YBc5r0JeOSFn3/x405e
         +PAENKI5W1ZAe9C3YD6/TRBU5J/mgz3dNAOXJoS4EHTrqgkxUV7T1qazl1B0XzJ8xANM
         +9lB7J2tWovOX3SGTnojZmIfbKcjviDOPcJvNf48kQXMmJEBdBnXNYOvOfIpcDAkUVIu
         5gZw6WQ6tMHMyYMLTGl10UBFxu6XnatTeZnWKGfO2PqEJotoDn13FuPuT2Sq99HHGc7d
         xg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758595217; x=1759200017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vUgX58DsyU0+b3vhwK7OifvnksHmZK93Xb99v2Xcmk=;
        b=lKo6ZA9VY0q7LawBxENpfAwSdbSbYHFxywcRKt7FgXQsfUf1VRWPJkV4Vz1XaFNg51
         a1y87mKkw2g2RHDp0ZpKnTxD/pw0nJyE9FbKrnS0Zhem9a4NcOf7XWOgQKgB5ZLTyeRK
         vd3YYNIW0lHpAl/tU7BuUYKJa2LtcjCKQttux2xMPQH9NbG3KLgm4ISW8YZFcXpOCnAK
         SVlMW1P0sfBu5fiZyXd5EwqntrTqU22p1teObPgK7chqLpoGcxZ2ya0VGl3EtGZ5GWbt
         cDXvU7PXtQAjbyyPe/ZWLiyLkmrGx94Hk9Bx++JJOcQ82yd4atkIZ3XRQ21+t8giMaCA
         rszQ==
X-Forwarded-Encrypted: i=1; AJvYcCU72EGYm+VkIB/ST9W7ZVTBP8pOT6YUffPWz6KSMblBHpAwNm5325IBP0T8X4RUfwJlXZD4NzQheGmuWU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+9/TfHafnpMDyBonEWHCOYeOommn7N/j6WRcvDSGjZFbHZJp
	xyUilwG2gwElJHn0PFYZ87HZ3+KYks8iuAj4pY21bseQTAqqm/mYzs3Cszo6Q1/PCw==
X-Gm-Gg: ASbGnctZHFGBiENrk2NEGCZtJEfXIFu4Tb+obimx7miwdeEptpmwqHP0O9YLRLmfoDo
	XY59Fbvyz1sB0AUEecnK+2jzvnWp1GQp/7MAaLiXlW+XNVgnkdveaLvUR6KhofMbx357yQzvj7k
	RnOAC4v12tCJOJL2eyj0lAXYUNGgZdPlrcyI2+YD6r8zp/Iejf7JIV+IlTIYXRRZAGC5vmqh9GG
	+AVUljNIWVPdeHzCUqA48Yj7Ig1gKYYqg95fyT3R7LWyM15wSzXdMietsGd6JIaeKzgcwh81FrL
	4mZdQsKNNdnig8J/KbjFY+2YKcEPauEOpVzGOEgZpWjyfsn3r5SrVzkeXtdzl8ccX7VFjAeLr4B
	mDcoTRSciDCRGOZxfuSNUwLx3
X-Google-Smtp-Source: AGHT+IE73YLWqjqtgU0vcQHw7OetClT9gbbbQMHH5iy0VtyUCNnwXencpMLyHRicslxwC75Z7qt/Ug==
X-Received: by 2002:a05:6214:20c1:b0:790:3b37:8ec6 with SMTP id 6a1803df08f44-7e6ffea2284mr11149416d6.13.1758595216848;
        Mon, 22 Sep 2025 19:40:16 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::5082])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-849c03c1531sm304190185a.29.2025.09.22.19.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 19:40:15 -0700 (PDT)
Date: Mon, 22 Sep 2025 22:40:13 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Brahmajit Das <listout@listout.xyz>
Cc: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com,
	clemens@ladisch.de, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
	perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Subject: Re: [PATCH 1/1] ALSA: usb-audio: Avoid NULL dereference in
 snd_usbmidi_do_output()
Message-ID: <43ab3d0e-4b56-4292-aa51-2473e766dca5@rowland.harvard.edu>
References: <68d17f44.050a0220.13cd81.05b7.GAE@google.com>
 <20250922231720.3603805-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922231720.3603805-1-listout@listout.xyz>

On Tue, Sep 23, 2025 at 04:47:20AM +0530, Brahmajit Das wrote:
> Syzkaller reported a general protection fault in snd_usbmidi_do_output(),
> caused by dereferencing a NULL URB pointer when accessing
> ep->urbs[urb_index].urb.
> 
> This can happen in rare race conditions where the URB was not initialized
> or was already freed (e.g. during disconnect or after errors), and the
> output timer or other path tries to reuse it.
> 
> Fix this by checking if the URB is NULL before accessing it, and skipping
> the current slot if it is.
> 
> Reported-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947
> 
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  sound/usb/midi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> index acb3bf92857c..7919a39decb4 100644
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -307,6 +307,10 @@ static void snd_usbmidi_do_output(struct snd_usb_midi_out_endpoint *ep)
>  	for (;;) {
>  		if (!(ep->active_urbs & (1 << urb_index))) {
>  			urb = ep->urbs[urb_index].urb;
> +			if (!urb) {
> +				// Skip this urb
> +				goto next_urb;
> +			}

What prevents the URB from being freed right here?  If this happens, 
the code below would access memory that was deallocated.

To prevent races, you have to use some sort of lock or other 
synchronization mechanism.  A simple test won't work.

Alan Stern

>  			urb->transfer_buffer_length = 0;
>  			ep->umidi->usb_protocol_ops->output(ep, urb);
>  			if (urb->transfer_buffer_length == 0)
> @@ -319,6 +323,7 @@ static void snd_usbmidi_do_output(struct snd_usb_midi_out_endpoint *ep)
>  				break;
>  			ep->active_urbs |= 1 << urb_index;
>  		}
> +next_urb:
>  		if (++urb_index >= OUTPUT_URBS)
>  			urb_index = 0;
>  		if (urb_index == ep->next_urb)
> -- 
> 2.51.0

