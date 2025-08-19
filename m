Return-Path: <linux-kernel+bounces-776312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 261E4B2CBAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB931BC73D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A6B30EF90;
	Tue, 19 Aug 2025 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWJPyUzO"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E2B13D51E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627023; cv=none; b=fh+X+RDp5R4GWGUwXrwnhKdwur5sXCJ7k6UzvH5VnAIqzdMfhu24PFtxxJXi1rJHiOnEaLecoBiiNRWLZXRCzWmRPaJbbeRs+t9PMTn9CGGJ4yqYnZq93eXnIYO6kVaaxXUVjqx6uWsv67Qjcj2NcOHz8gNTkqgJiy8saCpgX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627023; c=relaxed/simple;
	bh=kuNJRvnuN/bVFQuEWuPFIuTLDNlARqPrsmYpt8pxIJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4R+IxqxyZXY69gdZ4LtGuo8DPNPoKzThxvbeJx3RXnv8dJ/unOczNypau7c6CtKSWoo40/2xe70JiwpmhBryRA40l68U+nt6uQ9/8BbeGl/DJ0X7UfpEw7Yy05qUvKzzt+gxsj79i4/3N+rhr84YhjB0tTkQO01Ko37faUj4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oWJPyUzO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so34776385e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755627020; x=1756231820; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VJE8lHJlZMiSJCzhASu/N+ZwF8MaTnDzUgcRp3P7wNk=;
        b=oWJPyUzOlN4HAeOwmaqkJbQbwd1cG8EUf7RdN+LXwvwxGXpUUtANQTlPglqvScBSYW
         liRUXJRRLFQJ+iLmrPhUQTRw3IxcWzRJqa4zs+FvrkPTyXp+/DXY765tQJlJEk6n7ILA
         wBxouiTbwjY0z8t4N4iWYt0fM+bxrXZEEnL6By1BkbV3PmWmsOBil66k9QHI82QyYDTh
         NnxUf64xxam79FXXyg2JMpzcisgAfxVPAA/c+Yyvgeh3DXjEDa44pfyI4Ma825tVgHY0
         PI8liOB1rmGqlzh40Oq0+WLtLPjBrLk/pEWmFTwacmps/ohxLNnK6L0f8XfVy4BKapaF
         RA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755627020; x=1756231820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJE8lHJlZMiSJCzhASu/N+ZwF8MaTnDzUgcRp3P7wNk=;
        b=A1RAwq0roi29NQIemhnIUKOeqC1OKcATBYry0UVQTumr/iZNIKZ+j7cPKj18CCY//2
         4plxobFcnWewbfDmpie88tnsMrcoflC6vV1BDcLebNxpY+qDqO1tXV6jwosypSkzD0qR
         WV5tKp4ZpHmWYWwnM31GfVi66bmEi1EXfCAf1hzg4buGf2eClhO5WqLkxbQAyqQFdl0e
         RubwFynlsySN3uyy+D/rI9RCx5rqIP8NWE3nQjvqyqu+Hi86uk5BhdhiHNhZe4cUI8FF
         hP6kLhOABoUrKOnRMz3ooSLX427d1sySGNBwmmvcoZ6evkP1XFJhuD0tY9GcMZHylWs0
         HMOw==
X-Forwarded-Encrypted: i=1; AJvYcCUW8KXzwJLQCPFi+R2oIRULienIz4C126tsusBTOhJKYi0oTT9+LZwC0YmtDzXT0KKJ9DC1lD3N+xfWTmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3lX12/Q22W1TLs8R4gSMx1tZYqvbeZrR3eGN/iyrEV8DYPgK
	9zsz5iGu8t9g1GtUcWbYhfunrkq/pdZVruO1orjXhJdQ/ezdMYq3Y/GGs4rZQsuyJNYybCoofBz
	GbcN/
X-Gm-Gg: ASbGncsKuywXmD1p7u46UNc8Mb0sQRz2ykMdEXeltDQRrUfwhrgjb/LoKjFKCJVLENZ
	eeVp5EhMKVVwPN+Ua9W8dElcFKecwyIcXbW7UObA2S/TtTjeZ1HaAgKW8dqDV2AE4t2qHn8w9JC
	qJrX5CkpUn0QY+SXMB9tgpsB59ZoKFh/8KFFoR2GXmoAt9xIzKypu8v4LRS2oO9iXq8Biv5pMj3
	UdZXM9GLzzG72NAruStqEgTRmIZFDehEemEgQ0cnT6/KA8m6o4nK5gm7AdH1edHqJqbj3kG32RF
	plYGSSDqwuejxNnztpYMLHjPVimEuds3PA9mzj2uE9p5ZIjKhqxPTThMxWvDOH4g6Y7ejriYNzw
	7em/roFQiIXBruANZSy0U3snG6xXqjj9XWhToSg==
X-Google-Smtp-Source: AGHT+IFyHk8mmEI+TpEqA6cIWlRXNslVPoQY2NmHYpNY6v+LH4dZYi3eOnQH9PMTCE1vn0vVN+xiVA==
X-Received: by 2002:a05:600c:468d:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-45b43e0bbbdmr32598415e9.29.1755627019687;
        Tue, 19 Aug 2025 11:10:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b42a771d1sm47286665e9.7.2025.08.19.11.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:10:19 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:10:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?utf-8?B?xaBlcmlm?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	"open list:SOUND" <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ALSA: usb-audio: us144mkii: Fix null-deref in
 tascam_midi_in_urb_complete()
Message-ID: <aKS-B6O8ZEAN_X7x@stanley.mountain>
References: <20250819173831.30818-1-ramiserifpersia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819173831.30818-1-ramiserifpersia@gmail.com>

On Tue, Aug 19, 2025 at 07:38:30PM +0200, Šerif Rami wrote:
> The smatch tool reported a potential null pointer dereference in
> tascam_midi_in_urb_complete(). The 'tascam' variable, derived from
> 'urb->context', was checked for nullity in one place, but dereferenced
> without a check in several other places.
> 
> This patch fixes the issue by adding a null check at the beginning of
> the function. If 'tascam' is null, the function now safely exits.
> This prevents any potential crashes from null pointer dereferences.
> 
> It also fixes a latent bug where 'usb_put_urb()' could
> be called twice for the same URB on submission failure, which would
> lead to a use-after-free error.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202508192109.lcMrINK1-lkp@intel.com/
> Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
> ---
>  sound/usb/usx2y/us144mkii_midi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/usb/usx2y/us144mkii_midi.c b/sound/usb/usx2y/us144mkii_midi.c
> index 5759f6010..1aca38f38 100644
> --- a/sound/usb/usx2y/us144mkii_midi.c
> +++ b/sound/usb/usx2y/us144mkii_midi.c
> @@ -41,6 +41,9 @@ void tascam_midi_in_urb_complete(struct urb *urb)
>  	struct tascam_card *tascam = urb->context;
>  	int ret;
>  
> +	if (!tascam)
> +		goto out;
> +
>  	if (urb->status) {
>  		if (urb->status != -ENOENT && urb->status != -ECONNRESET &&
>  		    urb->status != -ESHUTDOWN && urb->status != -EPROTO) {
> @@ -51,7 +54,7 @@ void tascam_midi_in_urb_complete(struct urb *urb)
>  		goto out;
>  	}
>  
> -	if (tascam && atomic_read(&tascam->midi_in_active) &&
> +	if (atomic_read(&tascam->midi_in_active) &&
>  	    urb->actual_length > 0) {
>  		kfifo_in_spinlocked(&tascam->midi_in_fifo, urb->transfer_buffer,
>  				    urb->actual_length, &tascam->midi_in_lock);
> @@ -66,11 +69,14 @@ void tascam_midi_in_urb_complete(struct urb *urb)
>  			"Failed to resubmit MIDI IN URB: error %d\n", ret);
>  		usb_unanchor_urb(urb);
>  		usb_put_urb(urb);

usb_put_urb() is still called twice, though?

> +		goto out;
>  	}
> +
>  out:
>  	usb_put_urb(urb);
>  }
>  
> +

You accidentally added a double blank line here.

>  /**
>   * tascam_midi_in_open() - Opens the MIDI input substream.
>   * @substream: The ALSA rawmidi substream to open.

regards,
dan carpenter

