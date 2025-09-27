Return-Path: <linux-kernel+bounces-834954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0F8BA5E83
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630702A14EA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5332DF715;
	Sat, 27 Sep 2025 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv6/hsqh"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3D28935C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758973806; cv=none; b=NUzw2O4DjW4nfz6163GUhLWNcHbq7BDjKmQHGEnkqIIT4KHXf8leAs65SPpd3EeV6Ei7pHphkyGMNWr6q6akQwhLjWby9sejRKu/rM0pZv2QHQGj3RJ/nmyeWlRfIWUidrKPVgFxJp8zgp8gkoU6braz3rxbXsLON6mHmxEHuEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758973806; c=relaxed/simple;
	bh=FmkW6fv9RvYho7jnssoOwnojufdPnMJ7bpOkOZiiS6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS4xc6vQxofosAa6JtAlTQncZmdksK7Szd6GekTyrSNieDTaFEHjdVQAaMPu1/54Jfm+Px7tSiTqVg8siEmQQatp2IFWtY9Kpj2orH04XTQhvyOkEOUqqa6KoNMxuVn7xJj5KjyM6oWWrGLwLf1z5144ykI7FNSPR1AGWegqJ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv6/hsqh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so1126346b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 04:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758973804; x=1759578604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7M1fiQxbluyhtXAEzIDiPynOcFnwYfQj1hrp68Zys4=;
        b=Mv6/hsqhdT6Nu1dqWfChlCBxV0fVLSz/ZAqVL1Nx3LloPk4pB2lGZl5Ys1e7SVSfnb
         3ZbKNj0f7XGYwFXmW3FspDEPlnVM++6Gm0Y3mn+agVCBLw2Q68gEhbqNvkrN9doxrB9a
         QXa9MxiqNxpSqeuWiBsw5JreobuTVz8RGNS9+tEbpIJ/LlIR55vPKR2A2Aik4/b4ERg0
         B4AZgNOuy8QKbSCqDvZOQ593Qx34vFlRTiIbNynUr4Cjm4wh+KAuxA4oH3ydd+2BQOFd
         Pe8IYNhiDUTwip0VHsiCmQq1axzXGAItS++P3EUQshcHslWk8Zrkbx36GP9iyCe0HaPX
         x2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758973804; x=1759578604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7M1fiQxbluyhtXAEzIDiPynOcFnwYfQj1hrp68Zys4=;
        b=Mos1tSok2j8+HgUEkh7uYQc23MHEUjQer30VvSSlNasSfm19btrZgnh/jA6fvhtqjX
         biw1x7TniycSlT8xUds4+laZsxvwgLrzAY8q+LK6p+D+YY853MroJQRRCJgBJImiLB6f
         +N3yu5G629yN49lSNRuxMCW/+Lnvq7qze8E+A3dtrNNXXuAd5XytmHjkip93U4oM4y5s
         p6dzxJRPeCf+S75G/tOWPBUTaUhI+lPQoEhGjHoV3ZQRmrx7bx3aJ/0s71KeWqn2H902
         Nm2uECmOLYmEIXPhjnoMkhwlZQ56x9wEF25tmL/Sym3f3NGgT5gTApnk+k1nAz0kqOBJ
         OpLw==
X-Forwarded-Encrypted: i=1; AJvYcCVo9L9kbiMn4Hr/snIvcXK1D6DerGAHqZsKYa4JkN5T+4nmzbVV0ISk3AEGz7hXHkz/1iYLjjJ2/M2ypD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEIpqRXoIfcUb/vkWwD0nKfUHAVxguEhWkDWR7OQq7gH38feNR
	9tlsXxAxKMqmkpBF1Eslns4GuwIyOnYoh6Ir7xVthLtBFXfu0ZvaL/mHD2G6v2hY
X-Gm-Gg: ASbGncvwiMtnKrPkzPWjxY55UdfDzex9Nr+PNdNzWeifUCecIYQDC147dqkJlWZ/izK
	DJU/p1YFmUDOAmsBVKZeo6S7Sm8IGFODDu7I81Wsn4oFxZzTahR7VLukOkNJivgtbgZKnGc14rc
	vAesqdFNBgTwzJzN3zMjIHLierROca7BK5JT4P9IOojKwDGB9c7jdn2mEXerHCxunlebOxgQ6lc
	ARxoO0V3xZktcTZj7ZOLZWGP5g/zl68JOtPHDnLpb2/wZnBJ74EMvYXRaxMVCQTpFX9HZtDybvz
	+MIOTHrq2XYmO1kizN1sFPdjIRsfxc8q0jp+JkMqluKU/HqJoGH5Z7S+F5sgOOR8H/NmuQHg44l
	bBnjERDYG5AhcP3di6OzpMUeYVxqRr8Nnh+vs
X-Google-Smtp-Source: AGHT+IGFQQkVyfRAsja2DHyE7zdSWxG/uinaLDtYMUS0qEz0ZEbGJbyQ57SNOzxvZ0pMKKDRNkNKFw==
X-Received: by 2002:a05:6a21:9998:b0:249:18e4:52a9 with SMTP id adf61e73a8af0-2e9a37cf926mr10870653637.9.1758973804185;
        Sat, 27 Sep 2025 04:50:04 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239596dsm6489628b3a.9.2025.09.27.04.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 04:50:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A37464220596; Sat, 27 Sep 2025 18:50:00 +0700 (WIB)
Date: Sat, 27 Sep 2025 18:50:00 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: sound: describe 'chan_map' member in snd_dec_opus
Message-ID: <aNfPaO12834FMIBv@archie.me>
References: <20250926162658.989479-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250926162658.989479-1-kriish.sharma2006@gmail.com>

On Fri, Sep 26, 2025 at 04:26:58PM +0000, Kriish Sharma wrote:
> diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
> index faf4fa911f7f..e90e2f40732a 100644
> --- a/include/uapi/sound/compress_params.h
> +++ b/include/uapi/sound/compress_params.h
> @@ -336,16 +336,14 @@ struct snd_dec_ape {
>   * @mapping_family: Order and meaning of output channels. Only values 0 and 1
>   * are expected; values 2..255 are not recommended for playback.
>   *
> - * Optional channel mapping table. Describes mapping of opus streams to decoded
> - * channels.
> - * @struct snd_dec_opus_ch_map
> - *	@stream_count: Number of streams encoded in each Ogg packet.
> - *	@coupled_count: Number of streams whose decoders are used for two
> - *		channels.
> - *	@channel_map: describes which decoded channel to be used for each one.
> - *		See RFC doc for details.
> - *		This supports only mapping families 0 and 1, therefore max
> - *		number of channels is 8.
> + * @chan_map: Optional channel mapping table. Describes mapping of opus streams
> + *            to decoded channels. Fields:
> + *              - @stream_count: Number of streams encoded in each Ogg packet.
> + *              - @coupled_count: Number of streams whose decoders are used
> + *                                for two channels.
> + *              - @channel_map: Which decoded channel to be used for each one.
> + *                              Supports only mapping families 0 and 1,
> + *                              max number of channels is 8.
>   *
>   * These options were extracted from RFC7845 Section 5.
>   */
 
kernel-doc also supports documenting nested structs in this case:

---- >8 ----
diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index e90e2f40732a0d..6398a253add5fb 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -337,13 +337,13 @@ struct snd_dec_ape {
  * are expected; values 2..255 are not recommended for playback.
  *
  * @chan_map: Optional channel mapping table. Describes mapping of opus streams
- *            to decoded channels. Fields:
- *              - @stream_count: Number of streams encoded in each Ogg packet.
- *              - @coupled_count: Number of streams whose decoders are used
- *                                for two channels.
- *              - @channel_map: Which decoded channel to be used for each one.
- *                              Supports only mapping families 0 and 1,
- *                              max number of channels is 8.
+ *            to decoded channels.
+ * @chan_map.stream_count: Number of streams encoded in each Ogg packet.
+ * @chan_map.coupled_count: Number of streams whose decoders are used
+ *                          for two channels.
+ * @chan_map.channel_map: Which decoded channel to be used for each one.
+ *                        Supports only mapping families 0 and 1,
+ *                        max number of channels is 8.
  *
  * These options were extracted from RFC7845 Section 5.
  */

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

