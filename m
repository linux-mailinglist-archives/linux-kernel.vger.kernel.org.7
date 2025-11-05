Return-Path: <linux-kernel+bounces-887448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDA2C3845B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3803A3472
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B432D7DDE;
	Wed,  5 Nov 2025 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByyxT8Ln"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1A02D0631
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383415; cv=none; b=kjKqBSg7J1O8JLQ0TlTJKDrApsPbb+X5zl52FZ6OtAkET+miOS1BKIDZcOc5tmArV0sl+qriI2WTwWoNVJYChus6vb+sC1ot6B10QEk0SjKTt3RHbL8eSAVDg90E76qKsxs1XwXnrwKVIeBEj/U2VjqE0pwWJadTfJAHyhg9Pqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383415; c=relaxed/simple;
	bh=FTXZ5vO74QZiowktk12TLrnqOYri08BSx/eGcuuJfys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZDah8pCeOQKIViYOb5YKB1JMDQcykNlqDZnxHd4XgcgGbZc9dm/SyGHxmvmmQRi/qH5xndEjKlPXejx7xhtUUiWkdBjlm3+L9TO6KTmk9FDdpGOZY0LiduoAuLHII2RgeFS7IipXLpEBIuUXrZcWx6KQA+Q96OwfDBMKa3Bp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByyxT8Ln; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59434b28624so1307e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762383411; x=1762988211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d38bnEq+1o+YEmK6XU9ce+0ywAuUlel3clbqJSBWsEI=;
        b=ByyxT8LnU/ScdARqRGyLuooRxswKk5qWDA7/HI8soU4jR6zuj4lg8w0TaxODrb0gR+
         gdr7khoNlIbmGO0ovayt7wlHvM9XXsT2RShbUjo+WR+7k+S67AO70J0LWcgsh1OvX0WQ
         K15EemdRHCzbrvkPtD4Cm/oTcAjIKfVhCF8hUWaDCeePh+Hwqfo89PWBwkeeQHx+lS8u
         BrrkgoWdxXfbYlxiVC3ADDzyhza90GTVYuDCRux2rWS1W9WGzUXs1ygjNuEjgtKbRrSh
         Mj3GtRsv6gqCOcWlBrk2jnlqiD1J3BPLpsUkne2S2fZ6Zu9Lb90BisT+ih4mEsMzzcXt
         bHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383411; x=1762988211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d38bnEq+1o+YEmK6XU9ce+0ywAuUlel3clbqJSBWsEI=;
        b=tE9B3rZsPRZOXxk3XLqGk6CixPusiha1pWnKYh7l2KjKA+A2GyqQ/pgox+E670pQ/C
         2S4Bqsc7DcJf91B17JA/XID2CZ3i/5d7GbjtB/dmB65Z+H9DwJnn3ERszuuwwgUp7Wnh
         YPUiBmYy5cWhiJE6xUfYahhGn1XLPq9GjdkFbL9Y/S8gyukMV9c6CwV5eDFvKULJR672
         pe4PmcxQ3uSo1d027jGH6JWM9MVAz29WWYlqgmdQWl/vEB+Xc7zoTtdkYFWNZDZq3L7l
         jGjko5ZyY65bjOpobDyuc+NoyrzigJnM9XhJjmIm+vErSlsvC04i2ceScls+mG7gqS0P
         +Dpg==
X-Forwarded-Encrypted: i=1; AJvYcCXUGCdTExBEHn3jgNcr4A/GSYBICnPdFszf2rYXZWEdA10y2nR0EY5gcGJ4du402Rnfu7e38B7X6pBjnMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10HXUe66WlSSK9z/9aJlGpMqaSLP49IwsYWmPJqbtIez2LPQj
	2wHzzIVvkQPWFbnpduAJzCO5TZgwFSc6qlLsM16Q7/t+wYKyJpxR7pChTx4AOvr4UXdIuN2M7hR
	3DyfO5vgxDDRcql7jWPWjAY1eh+LZlYY2LRJ1dsdq
X-Gm-Gg: ASbGnctq1E/ZDM5CoHbdRDmLtdH0CApZC8wSfas9mF/YfqiTMw70wcOKo3UjjHWkTyp
	no/rSsAlv2bJkiKrrlKjUi3vv+b5WLdLj5JOrxhM+ma5doItOp6CIpv/PBHa6FnqLA7ybZtJtMP
	8LQNUS2RHOkPX5kkWZ8UnoKhBbpdv2HDVhE1o3KIym/G6DF28PPvHOsMBMqQYt4IeQQgfGru31I
	aaVlgCRHwgVPUiQOWb6F2iNsMkO+UiCPKH2ElS8NWXNO4XZoCyCdGJyx9skea44h5tYpuTmZp6O
	CiUAV1vDf9GDVsk=
X-Google-Smtp-Source: AGHT+IELG+HICsMAz5WYIIataT/mL9Fv7C1S8sUPq6saB0SfJBmqQbRUMs7vinFwj3opyitCVZtQCnjbw4I926TKdPY=
X-Received: by 2002:a05:6512:64:b0:594:4116:8dcb with SMTP id
 2adb3069b0e04-5944c81d104mr38713e87.3.1762383411288; Wed, 05 Nov 2025
 14:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com> <1a07e27f-69de-4a38-884a-5ad078e7acf5@kernel.org>
In-Reply-To: <1a07e27f-69de-4a38-884a-5ad078e7acf5@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Nov 2025 14:56:39 -0800
X-Gm-Features: AWmQ_blqlcUxGwWGO3wIa-GDL3sDQYUwtR_l1Dra-FSHUPTxILlqtmtqPNFP9n8
Message-ID: <CAHS8izM+sPsaB7iVbNu7DEu9qH-89c_XDdMM=SpWFT3Ywq6k3g@mail.gmail.com>
Subject: Re: [PATCH net v1 1/2] page_pool: expose max page pool ring size
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 1:56=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
> > diff --git a/include/net/page_pool/types.h b/include/net/page_pool/type=
s.h
> > index 1509a536cb85..5edba3122b10 100644
> > --- a/include/net/page_pool/types.h
> > +++ b/include/net/page_pool/types.h
> > @@ -58,6 +58,8 @@ struct pp_alloc_cache {
> >       netmem_ref cache[PP_ALLOC_CACHE_SIZE];
> >   };
> >
> > +#define PAGE_POOL_MAX_RING_SIZE 16384
> > +
>
> IIRC this was recently reduced to 16384 (from 32K), do you have a
> use-case for higher limits?
>

Yes, I noticed that. Increasing to 16384 resolved my issue, so I did
not feel the need to revert back to 32K.

We're expanding testing more and more and I may run into another issue
that asks that I re-increase the limit (maybe with a check that it's
indeed a ZC configuration, so no extra memory will be pinned), but for
now I did not find a justification for that.

--=20
Thanks,
Mina

