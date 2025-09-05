Return-Path: <linux-kernel+bounces-802512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60801B4530C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB803A29C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1641E307494;
	Fri,  5 Sep 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ElP1XsUJ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FE32D3236
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063873; cv=none; b=uVUBfXgQiazugqUTZJq3XwWj68chJAK68/YKkG4YvSLyNTbVO1JRnd2EzYdW0Ezyl1ukdGv8JHMcy5XqNmnuNiyMxNYluDzXjOhd9+wO2645aB3NA2wC/f0LwCDhLHVxEIHLSHzQrjl7eqIP7olnGMNwtOqhKd0SQ3ojHMQpzII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063873; c=relaxed/simple;
	bh=HtCixh7So8A8SMkZfbaqBqooWI8/h+PC2ysjtTjTdHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZhOLTVoCI8EMMfOB4YcUheNiFuiF3vB/VY1ZLace284P2V81I94wUICPpYWs/s6EkRlJoeYfMA9pbm5NtyGc6VKVXvpBoDro42mMWMkgkp7Iqw4shGzJaFL3Jok0GaNEcZ8EEaFHOal7AtHSp/UsTOllEcQgkxQJuOa50+4uto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ElP1XsUJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-249406d5878so19176105ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757063871; x=1757668671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hImylEF8kRxc0pZCmefapOdNIdI9K4EzdImQ0P7qUyc=;
        b=ElP1XsUJF91WNBUDleqgVI+uuR7WzOBEIVoKx0IP/+mbpQrrgCF+2bfTkkea7HBBzB
         DddQ8GQwvdkTJVAj9pIEEVcWzo15/h/UksavVYJc9JnHrRaz0bxE9Mw0lMUzWPJP43P1
         z7gVnMnVB1k0cS6fLUl04vIdF3v6ppMzLQHlDKzqIEQ0Oj+BpHQvyjTajI91P6eBHKHx
         U6tZDXOGq0rNMzeYqNpFNiRgKoDeIFgsyciiGYt+0v6xAlJSzKrf2+A3PyxNRRwOstlJ
         C5N/sQePaiHBvSmLxJxFNvNOo7NeMWhg2Lx40tve0R5z58i9F0s7yh66mD8byEaSfxLd
         u/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063871; x=1757668671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hImylEF8kRxc0pZCmefapOdNIdI9K4EzdImQ0P7qUyc=;
        b=k083v/Vy2O54Ija+SPpMtTjkUQovXl7vnrSxrqnGSljT30oDzOIr/N5dlDXLSa6GZF
         T7e1Y4OI9rpY8m6aZHVQVeOW9bp1AjQfJQ8/MgIaWT9D1Z63zBg+uB5+xJ52/dH4y5P9
         5FdRoYUcQV4mhT8YJp+uiRsbYpXRsAgTCd69ElsjsICTvQfr2A0wINI4z5rCbxJHbbbN
         MOO3/tGzUS70fLAXbzGGgcFzF+3ZaPwftZoixUJE3+UyTRyJJsFdC+5DrvVpzWldgpfJ
         hNdBxCpeN12Up8VGbpQ9OeBbkvIk8VjJMXXbvlYKdObADd0sOE4gtvP2Mw5AToTfkPiC
         3GKA==
X-Forwarded-Encrypted: i=1; AJvYcCWcoyXCc+FwE2p/lqO8oNZKa9++b3NwHo0/JLxnisc25XS8QX2c5JgBHUmKxssKrdWuIlKH0E9EnRHC5VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZlS1LTnk0Cc0cGuzrJxBk3k2DgfdJt5XmmJGS3461a54wNA3
	DKhOYpgxeH+r8iwJrH4TQ+qMqKd7/UzbbgPfSfzg04IwXb1WS/j81Fj6alkF12kRcg+jwhjgCPh
	aqCM0dI2Q1IO26znAOKePCJq7IX3whWxqcCPV653n
X-Gm-Gg: ASbGncvdBIDtBqkL2r0sTntesZIDi4DNqP0IEN/GbsPdJTSNJY5esuIJgWDNGPawDjs
	i94V1bia4W533Gc2IdLJMnRHfLyEG6BBIxPcF56lvpVoJMl5bc6JzWLtFCG8fH3cqPOhiaSI9Dl
	QghfNaIRfoTQUB+G0Xk5UWDiYomZEsTtC8axmdsXgYqEY8wF53bLPThCTfzAqLqaxqelI/rIxgf
	e4hTeONi6f45KvxURwS1Wk8RGEaU/a6VKJiAn7GFrSRKc5pobTsn7kTZQ==
X-Google-Smtp-Source: AGHT+IF9S6iUUusneiZYRAF8ubXHonr/3eNJ3dxl0xbw7JyDRWMcPsctZ7caRsOI3KB+wShmBqhQXJYDFiofBVvADxw=
X-Received: by 2002:a17:903:3d0f:b0:24c:c8d1:2bec with SMTP id
 d9443c01a7336-24cc8d12d26mr73181375ad.40.1757063871035; Fri, 05 Sep 2025
 02:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801092720.1845282-1-verhaegen@google.com>
 <20250801092720.1845282-3-verhaegen@google.com> <aJGM2zXS6hOLDFm1@vaman>
 <87h5ym1f75.wl-tiwai@suse.de> <aKMzGRzeRqkOwTNS@opensource.cirrus.com>
 <aKQGuPgwXE-Unzeq@vaman> <87bjo96t2k.wl-tiwai@suse.de>
In-Reply-To: <87bjo96t2k.wl-tiwai@suse.de>
From: George Verhaegen <verhaegen@google.com>
Date: Fri, 5 Sep 2025 10:17:24 +0100
X-Gm-Features: Ac12FXyMMz2kHiEopHVWkiVekeij32ZuBn5pZ91dcPOnuZoD_YGrtaq5a00yJT4
Message-ID: <CAAntYmLGiqfZDKi2ndB7vk1GGZ7=FdozFvUFtMsKhVf0AxdsCw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] ALSA: compress_offload: Add SNDRV_COMPRESS_TSTAMP64
 ioctl
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vkoul@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Cezary Rojewski <cezary.rojewski@intel.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Srinivas Kandagatla <srini@kernel.org>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-arm-msm@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-arm-kernel@lists.infradead.org, Miller Liang <millerliang@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 08:18, Takashi Iwai <tiwai@suse.de> wrote:
> OK, Joris, could you submit v5 with correction of what Vinod
> suggested in reviews?

Submitted v5 with revert of the alignment change. I think that was the
only remaining open item.

Thanks,
  George (Joris)

