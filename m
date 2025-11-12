Return-Path: <linux-kernel+bounces-897317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F78C5291D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6D9189B951
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF63923ED5B;
	Wed, 12 Nov 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig/ZbuSr"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2C23EA96
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955434; cv=none; b=HOrXRqzzhxTtZC5INkl2+yzAEBVX16pkOy8lYJluaRpQbO5O1wnJnHBaYUONFM5wwtP/IphFxwQb/Rf9D8fA2HOaP3Nn5MsmR9O2hr/ULSZZiqSuT7rjEzPM7RlLnplQp9kJI6VJRJsxhjv+ru39X5r9o44Tyj7slDpYH2ijZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955434; c=relaxed/simple;
	bh=q23PTFUGv3McLMSbUMXGzBKmTnxMWxQmminnmHICve8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0CyfCi6oCUMWWdXh5WQeG6Z0G6krzxizxH/a06bCz/9VseHLegnblFVqPfAm+p5CbXjW2cEIbi3oWwhzpdeb7H71FaJgVJDvUYVDNr//Uo3PCfwX7OEyznpD2Bp/M6QUVX8sffqhmNx0VOQwDbZuRFR18gx2VA0nC0asmfMq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig/ZbuSr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so745533f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762955431; x=1763560231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIU6mTVT/9hNLX+UgvB1zHOKbS0kmwHXqjF+H6qseTo=;
        b=ig/ZbuSrMSn5EqZ8J6RWicwah8ToOBdjqMorEEbK31FPeZs0m0uitGjhwD1OMLOofL
         pIiLgf5xbjNKbDrnKWOJIliAgqIDJBF7q6TQ7CQt6la/DDcahJaSpBmwhNrZKIGKOduY
         s02F/Wi8vOyNMiQRXlMQ09Pq+7VCubt7ewrInYwD1zNUbYQeRVjcFlIjlNUzcrOIO2Gd
         b8yJSseGZiVls7Z2SDAt4O4ZNtzZun0m6BZHGutz4t1xHWzUSEBo2FEfkz7g/5t3UNOX
         CL5mYVrGoVOp5p8eqXDtGno3cZYpKADgres0BZqTWFd1dOshNi0UKdQgH4NEtEcxs+PA
         OXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955431; x=1763560231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIU6mTVT/9hNLX+UgvB1zHOKbS0kmwHXqjF+H6qseTo=;
        b=w1Pmn1HmqNJoh1ywBtMWLItUMs2x/3cmN3RqtzuyTKWDythCZU0sn/er3VrsvO5ifL
         Cw/bPCUJ5zYds3gShWB6ilvni8lizBn6OnfUQ18EgRLfUaT7DhUw0Y4eq8EPILUTtH72
         o3m0Z4LyV3tv4KFozNK8Qz5ZSd43wtH+HCYurNmcDR5VjKYHXapOKva/mQMAhYuDbrRx
         eDokZ2U7SmRAV/lqTr8RDhi/dPk2PFkLG4wgSL7bA+EIG3T8nlXbddgJVyAf4m4cSx95
         uMkWIlYO5fbkZLooi4fnQV/6ZHf/Dsl8QjJuGew8oqRDRsWca4HDr9tzcW1IZ8Baolpf
         W55g==
X-Forwarded-Encrypted: i=1; AJvYcCXNRPOzvSZh+yXWUNZn9LWzsFepkDi571PtQbs3tVsX5z8mCQZ7w8+ZIm2fpk/fqbHM4dXVs/821ep1+zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy80ihdOTGTYz7trz7MLi6Jg8TcAQES02d4LJcO4WqbfZLbbVIs
	NWobGR4C6AXM4l4zRlp4VUZ8auWECrmowEK8q/Td1Txv1sJos+3au8fF
X-Gm-Gg: ASbGncsmTmlp/xYTEVM7gcVL4RgoCcv6nkIXhOmEY4X02IElnvhszLJjJ5AILN1ednF
	D0FnPZVyD8TGPdl0DDuN5AkRg+M0glUwNbKpy9duLLjcmEhgNrsltf9LRQpFk+HmEnD9xnA342e
	vK9vRjF8ADKnURXP0UrRE8ZwvYj1S5bzzfpsrX7bmpaFDiorHtoAGYiz5iCPnKmlhR9WDHrI81o
	iuRiJDBJGUoD3VJc8OqNb190mVxEkekp9GH31AyjtgQ+ssW+AWQN9+kWw2LKcB562aYuwlbAcVb
	8XKOBNI1U36BmJW1efUpLVxTeM+nVwsDZ3YNDEy1KeNGY6Rl4xmDbkraIVqZN+8SpG3PdszN6Ss
	VYBrMBDyMviZ7MbdbJAe+p+G+bSHT3m1hq+SZk+Zr6DMPKvylX0U7SdOCbiPhHPhjbYS5x8qFlx
	e1jdfBkpLeF8HhWGj5Mtrb7x09a8VSt7t/uMpZ582YxmQj/jq0cU4v
X-Google-Smtp-Source: AGHT+IFvzDC8q6K3eMX5NpCZe6iJ9ktlK/IQzxKcT7Sqmg87KhQwtu8BH5fJQ0IkmWi/CSJ5uD7Ofw==
X-Received: by 2002:a05:6000:4210:b0:429:dc9a:ed35 with SMTP id ffacd0b85a97d-42b4bdb308bmr2351768f8f.43.1762955430589;
        Wed, 12 Nov 2025 05:50:30 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679607esm33667757f8f.43.2025.11.12.05.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:50:30 -0800 (PST)
Date: Wed, 12 Nov 2025 13:50:28 +0000
From: David Laight <david.laight.linux@gmail.com>
To: hariconscious@gmail.com
Cc: cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 pierre-louis.bossart@linux.dev, broonie@kernel.org, perex@perex.cz,
 tiwai@suse.com, amadeuszx.slawinski@linux.intel.com,
 sakari.ailus@linux.intel.com, khalid@kernel.org, shuah@kernel.org,
 david.hunter.linux@gmail.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: avs: Replace snprintf() with scnprintf()
Message-ID: <20251112135028.18921229@pumpkin>
In-Reply-To: <20251112120235.54328-2-hariconscious@gmail.com>
References: <20251112120235.54328-2-hariconscious@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 17:32:35 +0530
hariconscious@gmail.com wrote:

> From: HariKrishna Sagala <hariconscious@gmail.com>
> 
> As per the C99 standard snprintf() returns the length of the data
> that *would have been* written if there were enough space for it.
> It's generally considered safer to use the scnprintf() variant.

Did you actually read the code?
In this case the code is actually rather buggy and can read beyond
the end of 'buf[]'.

Neither snprintf() nor scnprintf() ever return -1 on error.
So the existing code will attempt to write past the end of buf[]
if there are a lot of entries.
Fortunately there is a test for negative lengths - so nothing is
written past the end - but the read can return data off the end.

Changing to scnprintf() stops this happening, but the user will get
truncated data.

	David


> 
> Link: https://github.com/KSPP/linux/issues/105
> Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
> ---
> This patch replaces snprintf() varaint with scnprintf() in
> scenario to know the actual length of the data rather than *would
> have been* written data of snprintf().
> No functional changes intended.
> Reference Links:
> https://lwn.net/Articles/69419/
> https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.snprintf
> 
> Note:
> Compile & boot tested with necessary config parameters.
> Other areas of AVS uses scnprintf() variant.
> 
>  sound/soc/intel/avs/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/avs/debugfs.c b/sound/soc/intel/avs/debugfs.c
> index 3534de46f9e4..100b95bfcd78 100644
> --- a/sound/soc/intel/avs/debugfs.c
> +++ b/sound/soc/intel/avs/debugfs.c
> @@ -119,7 +119,7 @@ static ssize_t probe_points_read(struct file *file, char __user *to, size_t coun
>  	}
>  
>  	for (i = 0; i < num_desc; i++) {
> -		ret = snprintf(buf + len, PAGE_SIZE - len,
> +		ret = scnprintf(buf + len, PAGE_SIZE - len,
>  			       "Id: %#010x  Purpose: %d  Node id: %#x\n",
>  			       desc[i].id.value, desc[i].purpose, desc[i].node_id.val);
>  		if (ret < 0)
> 
> base-commit: 24172e0d79900908cf5ebf366600616d29c9b417


