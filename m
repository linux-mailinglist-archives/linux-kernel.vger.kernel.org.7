Return-Path: <linux-kernel+bounces-776410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4E5B2CCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1690F1C243E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57932A3E4;
	Tue, 19 Aug 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2yvPoS8H"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CAD326D69
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631667; cv=none; b=XIQS+hMryHhl1q0wj0rpIPQ0+WoMQgOYAjZDL1oqSf0D+9ijyjqXOXFaxr6258oulXxbhItJAHW+Eu675FYnX/XiOtq9zNLPOVH+JLkPP2cq7tQHMmKrtYOFQ31FyIKRJJwrMv+gURpC0VGAX4g7bAbYZl2sMOBgxVvGTnkXLQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631667; c=relaxed/simple;
	bh=BlVzj2EUR10ubBzzoCWGCgBRnjT2tSR4AsN+B/Tx+uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4WfC7irlrHVwamQcJoAgPo/HKvb6keLj/FI18SwiEPo3T+q56dQCfSkZaR8d+43poJNUtGmKKDq9BHiqgaM83yxcpXGb1I6n1S6lQXtDPzXQROexPa6XcHM3ublPimJauwq/2wIuitqx5k8Ift6MpaPrhNH/4bzh+3iGJ3oJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2yvPoS8H; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b0bf08551cso97421cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755631665; x=1756236465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlVzj2EUR10ubBzzoCWGCgBRnjT2tSR4AsN+B/Tx+uE=;
        b=2yvPoS8HQWczeJaM7fx8jeCdrDaBiQmi4SbIn0siSypuiFDVh16Rl2L6b7paZZzsWu
         aQhddtinIru6QmgeVDzpB/rjT+OeRBQHG3pnwufmOcWe3Gmn78Qa5RnxvgUd6h9LR9nO
         srUzWuwWD20Ex6NB8g9qm47h8ybzzzwhRI3/MXMS5BgOSurLoWLhXjf2PXP2abvdtnVS
         qupbU5P7iamPH/DDFRWRlGvOi9wczfTDkJWX/Gf13CPTqK91oCmVFXXkrvrfzig1uo70
         Qaw04YlvGNy3ZluJ2AUhPNmCPmZdujB7/dg9gZoJF1DeLcKRQopTP7CulTrCrcBPQZYC
         lv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755631665; x=1756236465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlVzj2EUR10ubBzzoCWGCgBRnjT2tSR4AsN+B/Tx+uE=;
        b=I5sZ/geirw+mL2+86SthJiRTn8hwSFThSGMW3NxIALgN+XvHd4sVLwwKdHkgAxdEft
         DNFDk6U+1avBQVzvRKwetKNKuFjExI+zx5h1a2IPTUXBklwsl3wABNyX8h3IxmaWb0TX
         qXCGwX3f5GYXBcXl7+damuO4WWQ0yNPpPsRoMUImV11MTMMrDDbeRyJvuH3qzK90nMT7
         Nvyri083GQEWB+XwTxauG8Vqb1aeuGZ3Oit55sxRcMnsTso5ikyFAKowxZ81iOJrKUwa
         keWTX9bCk/h3DQpiOimX8Dpp4ujgflY011RdPUjaIV9YFSTCJLim/2/ArgX8oSB0nOhb
         Vb8A==
X-Forwarded-Encrypted: i=1; AJvYcCWwrAEPodkDn3azKM8eerP94NGim1BnGXHh896FFjJVZVjtu4elb1sqTiiIERb4XcKC3n6P+c8Az1rZIwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5UGD0zvw3/Q6x5kYmgCnsyZmwI64znaH6PxhmkWo7wEeAWCnI
	TpwGrFWodwSNTVSWr3YiQ9cuYojna1h7WHQCf94/6AYSGkfKlzUu91t5KtAuaJ0W4aeCpIJGLsO
	cths5YewkojXRRST8rgsANWhuQ7mWxPqldhsneYqX
X-Gm-Gg: ASbGnctSwM4YNQfWbW0enw5snTGkCCnnVR7t+JZ38wgppoAK3ggp1QXsMUgbPvO1IU1
	+YMYQQHJap/tItP+Yv+xlcPyUN74ZmdAl3vnAQx1pLWj2062W904xWSQItirrm+kj9ErrZ9IdST
	WFe7qKfJPPmOpDC4GNm4MKDxoCf0+flf8Kq++BHWo5easUHHXDBTqT8Z0f0oP8r/efNVVTPh7oy
	nLG7+qIk+sdtACwWYLbG72Y6w+m5rLSGda/d236FAHYPCrXG8DbXKY=
X-Google-Smtp-Source: AGHT+IEDWpSWU5ZzY/KJckLXK1MXb3iQFKIaTTR+UKAO1//noOtBrDSrcuDwJaJI6GftEm+TVmZKste1iti0T0BhbeY=
X-Received: by 2002:a05:622a:156:b0:4b0:8576:e036 with SMTP id
 d75a77b69052e-4b2916cdeffmr923341cf.0.1755631664504; Tue, 19 Aug 2025
 12:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <d36305d654e82045aff0547cb94521211245ed2c.1755499376.git.asml.silence@gmail.com>
 <CAHS8izO_ivHDO_i9oxKZh672i6GSWeDOjB=wzGGa00HjA7Zt7Q@mail.gmail.com> <ab60ab17-c398-492b-beb7-0635de4be8e6@gmail.com>
In-Reply-To: <ab60ab17-c398-492b-beb7-0635de4be8e6@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 12:27:27 -0700
X-Gm-Features: Ac12FXzollJPprpvLpQ4-IC38LVTaqJboHUEkHUZ0bfbl4-1_1fZtat3-UCqxVo
Message-ID: <CAHS8izPuZRsrBXaQoTNBPyisEo3w7J2aF0qyyOOnUAV=2-8o+w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 04/23] net: use zero value to restore
 rx_buf_len to default
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:51=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 8/19/25 01:07, Mina Almasry wrote:
> > On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> From: Jakub Kicinski <kuba@kernel.org>
> >>
> >> Distinguish between rx_buf_len being driver default vs user config.
> >> Use 0 as a special value meaning "unset" or "restore driver default".
> >> This will be necessary later on to configure it per-queue, but
> >> the ability to restore defaults may be useful in itself.
> >>
> >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >
> > I wonder if it should be extended to the other driver using
> > rx_buf_len, hns3. For that, I think the default buf size would be
> > HNS3_DEFAULT_RX_BUF_LEN.
>
> I'd rather avoid growing the series even more, let's follow up on
> that in a separate patch on top, that should be just fine. And
> thanks for the review
>
> > Other than that, seems fine to me,
> >
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
>
> With the said above, do you want me to retain the review tag?
>

I initially thought adding my reviewed-by would be fine, but on closer
look, doesn't this series break rx_buf_len setting for hns3? AFAICT so
far, in patch 3 you're adding a check to ethnl_set_rings where it'll
be an error if rx_buf_len > rx_buf_len_max, and i'm guessing if the
driver never sets rx_buf_len_max it'll be 0 initialized and that check
would always fail? Or did I miss something?

--=20
Thanks,
Mina

