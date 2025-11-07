Return-Path: <linux-kernel+bounces-890516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A529C403D6
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 128884F2632
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915DD31E0E1;
	Fri,  7 Nov 2025 13:59:18 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753B1FF7C8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523958; cv=none; b=Brl6P1Kd7bjRayw60Uk5UMByz5Qfa/3bi4OCIwS8dhVR3FSVGsnkFgYZx4pITJ2/vkyTwk1C4sFqUVTj3X+pIUaA4K6nkL9FNTax6naMnidE+KPTRnyKokKFwvKlwUxn/ydLkcIKkBAqZzgh9XY/W8+VUqX2esnnhmLHmdJeD80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523958; c=relaxed/simple;
	bh=8JxOVPMisbF56oYxS5Y+sDye3oJBmOCWA+veCsBSQt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKJwhO0qgJUmprMg2Hw+XBZN21AGwDRv15t2WJR5viC42I9ijqTuqmpyF/KIObjnjHaDyc4d5uDW2XH5ZlAsAeolRcZv++PmhrpNMLWUkzq/ZZ5ctsSxHhCmV5mIoojx8uQRxeUuQ4j9L24XNIo+pYJDhQDS8TFLUjSZyh7Aw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso1246509a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523954; x=1763128754;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJVwwG9Ykxrpv2wC8GWxsRY2S8SK8LdQYPdOrnHuv/4=;
        b=tQRbd3m62hpLyF8w9SR4l+C3rPKV3F5ronjiwFBhiidl408Ps6KjRfGO6kyIPlZctu
         V2ZR3k3ii4K/w90AdohKX7AnI7Q6jrCxeAWuVFEN5xFBld0P0oxk0XhOxBhucO9ALl8j
         5HLrx5r4O0crbL/3lMArbwjKfPWBx2H/7Y7TMp1JpJhyq0miWgNGNYuN4QrinKaEFXZs
         D+BLhlwJjDirh6y+yeaExAF41wqjtAbfq7RQHduN4ynhTiP3AK8nUAxbC8D9Sw/Zd4YX
         ggGTwiLLUyRFOokbCOkFzinI0IQwfq7dr7UJG1JX1UeCLj0+//yJ7RG/9VehR+SITqfN
         SrYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/75p9jzOOS75Ism441VHIMHbxjOXOb9hTY9vveChtMDf7n+NinA8jDyYb331eICXvT02JvL+3CsNDvoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfvBY8yiZ6iLrKnnNJjT87I6QnryQus/pWolTVPbfXgSjpbRqE
	TM6ZRLSJypoluMSu5rxTQ4g5c9nUCjn50WICEWbhUw7ceGbFPVayZKo/
X-Gm-Gg: ASbGncub+LlK6plnL1GId3gS5CcCdP5DtYsBIfxxe52EbQS0JDBDUlDxOvkom3BpcgO
	0F3+bt9n0yC93gMFLYkPP3igaoWbbXtl3HhTdkdhVxT7qr18VAZHMy21Mn5CA0HD68zDdbWrfXX
	BCzg6bKZk+cIazcRMXV3ADphmaPALH7Uj1W6gB1mvvDNnpGx7bMookDQMIXzrBpDhF/wkabzf9h
	UrzebjVomZRu6GMxhLFqtYeIOuiLOKYhew+DTMlbEzSyE5UfjBHisZtw6U0OK8X6H+f5afND1RD
	asA8v0Rj+89YOrmjnC1X7dWw7fvJBpGIxc4s5ZVF7guNxdd+bp7fmKYY0YV9OmCxzDzTu73xmkD
	faOyagOTdMIsKL6Kb1WjgN1pDzS2SSwXA0qUEAgI/xjOFwpW/MPbTF2SJE+0tSwLPWpXnVGCIre
	X1
X-Google-Smtp-Source: AGHT+IEnql9f6VQXY9z+xJPuqmV/UVO/NZG7OfzcZVuiSrpqgNziJ9vCyEN3HJ1eqE7qwBWjWJ2N/A==
X-Received: by 2002:a17:907:3f99:b0:b6d:f416:2f3 with SMTP id a640c23a62f3a-b72d0ad0b7amr205260966b.19.1762523953394;
        Fri, 07 Nov 2025 05:59:13 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc214sm261464466b.52.2025.11.07.05.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:59:13 -0800 (PST)
Date: Fri, 7 Nov 2025 05:59:10 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next] tg3: extract GRXRINGS from .get_rxnfc
Message-ID: <pj3m2f53zs47z2i6se4qaqs6izwfsgssnslna7ik7t2my3lpcr@7jyvaialnjxq>
References: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
 <CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com>
 <4abcq7mgx5soziyo55cdrubbr44xrscuqp7gmr2lys5eilxfcs@u4gy5bsoxvrt>
 <CACKFLinyjqWRue89WDzyNXUM2gWPbKRO8k9wzN=JjRqdrHz_fA@mail.gmail.com>
 <aQ3SNvSigJwffoQK@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ3SNvSigJwffoQK@horms.kernel.org>

On Fri, Nov 07, 2025 at 11:04:22AM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 10:45:21AM -0800, Michael Chan wrote:
> > On Thu, Nov 6, 2025 at 9:06 AM Breno Leitao <leitao@debian.org> wrote:
> > >     tg3: Fix num of RX queues being reported by ethtool
> > >
> > >     Using num_online_cpus() to report number of queues is actually not
> > >     correct, as reported by Michael[1].
> > >
> > >     netif_get_num_default_rss_queues() was used to replace num_online_cpus()
> > >     in the past, but tg3 ethtool callbacks didn't get converted. Doing it
> > >     now.
> > >
> > >     Link: https://lore.kernel.org/all/CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com/#t [1]
> > >
> > >     Signed-off-by: Breno Leitao <leitao@debian.org>
> > >     Suggested-by: Michael Chan <michael.chan@broadcom.com>
> > >
> > > diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> > > index fa58c3ffceb06..5fdaee7ef9d7a 100644
> > > --- a/drivers/net/ethernet/broadcom/tg3.c
> > > +++ b/drivers/net/ethernet/broadcom/tg3.c
> > > @@ -12729,7 +12729,7 @@ static u32 tg3_get_rx_ring_count(struct net_device *dev)
> > >         if (netif_running(tp->dev))
> > >                 return tp->rxq_cnt;
> > >
> > > -       return min(num_online_cpus(), TG3_RSS_MAX_NUM_QS);
> > > +       return min((u32) netif_get_num_default_rss_queues(), tp->rxq_max);
> > 
> > Isn't it better to use min_t()?
> 
> FWIIW, umin() seems appropriate to me.
> 
> Commit 80fcac55385c ("minmax: add umin(a, b) and umax(a, b)")
> includes quite a long explanation of why it exists.
> And that does seem to match this case.

I've send the patch using `min_t` in [1] before this reply, and if
I don't hear any concern about replacing min_t by umin(), I will update
that patch with umin().

Link: https://lore.kernel.org/all/20251107-tg3_counts-v1-1-337fe5c8ccb7@debian.org/ [1]

