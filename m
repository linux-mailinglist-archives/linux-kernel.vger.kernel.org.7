Return-Path: <linux-kernel+bounces-876262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A78C1B28C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADBB585F74
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4A3559FA;
	Wed, 29 Oct 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wj0LysYF"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF1357A39
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745362; cv=none; b=ch5CiRb8eo4VAZEKbX53f4Jd4oPbM+mj9n/kArbPyVepeLuqOU2TAwT5FccBxOwpGjDBhqW0ea/8WbOCIdtX0nDoDAfJUE57jNu/guRE0YWO4cmPnLE7Ra2oOVbaxzDwUfCSGIwxz1eJYY+aff/JsWCocnlM+fWfGO1AVgvdsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745362; c=relaxed/simple;
	bh=eqmbZ6C+/pzZCLCfiQmSe/VNbkn9pwD4O5gf0205jdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snnFNBczzFXH3YQGb6PP4/28dIlLTRLNhYeDK8ZwEN2Rsiu4vfaanPGJ9AcODUsI2gnKdAY0i5ariN3a7KzrV24YweZnarfKqHZttILRL9BiZ+AWa4IOzR7nMd+d/K+IH6LB4OkCc6kq5HRvkSIvls/3qW/PEUKEBsH6m8yC4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wj0LysYF; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ecfafb92bcso314931cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761745359; x=1762350159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwK1ndFtoZIlgGj7bI2/GfCsVHplI6VuQ2X/63o4ayg=;
        b=Wj0LysYFHZWoefmZYI0Wnmwh0LLMSciSlQGXINtm/+R3BVfZCQgwJdNJISA9RDmTHN
         CNdCsaSbPD3bPlULXqVdA1vBl+xQIys6xM9SyceIfzPbryNksHyWPdouEKaARMd13wYl
         z7IcYSXExTMMdJxMlwtAYyBAu2ASVR1JLlXenURthOtp1Fa3dGu0CtefA6ygeYeOcCFB
         Dd3I1GbNqglW/vQXewP2coy/5h4krJzAn3wY0gk/bkELNTCbJDfmO3u30jSzMb/pUBh1
         xxvwZB1tePG+YT9DvCOnhBXAnOSN3e8f1NwVfWiPKRx6/4a06Nwe5uKjTzDuGwTx8vjc
         E1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745359; x=1762350159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwK1ndFtoZIlgGj7bI2/GfCsVHplI6VuQ2X/63o4ayg=;
        b=oB9/Y3kVW0340Ia1wghQwXJlfb8LTeTuk2ydfy2a6tIIo3b049UdsOW9qjpqIS4rl7
         eqbSqXIlwDSTyzelv6y+XRt/MRRr3L+tLqGtamPrJ2HAySE3ZGaWngfeZPI4oNILvcVJ
         ei3bUxtCtVxiuRfd/vT0RGWjm6QBk/z5mbeXkxhuFHzQmvRr5HpvrGd1vGFUvFgOVSaS
         c2EAJxHeCPBKEn+sWULJn7L6GUvdoFB8aLJUO7rc8q6mZt9kt6/dCraCIlaIPYnt0rp8
         2n+sBaY4s9YjZM1zbd7YsIFQ+p8x7xdUdMeDAtye5x3k0LA+wzpF7252+WP1l+YZNg1D
         Y+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCU8Df55rvuK0ArJUxt8dzGEMUbDM9Nl78DEaqc7dKq8AlwfG0KhhZO7VCktnnCyeUSaCj6ATxFD7XIP+jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy79fqhR1Fw9s//ve+e8EoKhp1JiWR3XyQLEed/cNaSjLGET7L/
	DadsISWXsJ26VuEefaRQliYwH6JwTpLyHHlUMWl6Yy716l8HaQ0hyOrZBi+XVGxNso8WHFNwqIJ
	eoiGSZNr6ZtonqK/u/BESpdzHy3AGagEpVZXmgOe+
X-Gm-Gg: ASbGncsTitx7CQ6PEfF7TsUjHiWnlWXx4j47vCWTjQw7dvOFvLKHEZBfIK93jYYbWNn
	uQNmd5XWSc/Lml6z5kvbfoe62JqR4m1TcsQJYMrg8Ae+halOGiotjPkuXgzh41WT75extpEugfd
	KWOn9iAK9znbh0bbMdVjw6EkJjVSbI7WhxTqY72YmbtaJfxEQU7qd6GFwYIDyOPglonJ6gmqMQn
	/e3mU+cC5BMwMz2SXi1Bbf+224cfj33GR7r/TmLAi35qaCe8Kkewh6qBcS0L6oSj3Zd871MixNt
	X0wTmdH323yrSrtAXvpVlcwSBRDyXiOI88e7zTUCJFRPR0StlYjAr8T+PM2u
X-Google-Smtp-Source: AGHT+IGtHWfovXqfvSbcFy+Pt5rl32fTWV0d/1Y/CsEeBRhTrAlUP7rTGJeLhXDltf8/Z2wATZXHrUKI/n/m8N95X/E=
X-Received: by 2002:a05:622a:1b20:b0:4eb:7681:d90 with SMTP id
 d75a77b69052e-4ed158ac668mr7989031cf.16.1761745359037; Wed, 29 Oct 2025
 06:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org> <20251028-net-tcp-recv-autotune-v3-3-74b43ba4c84c@kernel.org>
In-Reply-To: <20251028-net-tcp-recv-autotune-v3-3-74b43ba4c84c@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 29 Oct 2025 09:42:21 -0400
X-Gm-Features: AWmQ_bmkO50WQoFAT_CZV9_dPllZDeiEg5XeCFHugo6EvwnaCcAy-NspHcjqfqc
Message-ID: <CADVnQyna1BX8y8Gw4=+4dJ_VYn=O8JMzSqh2y1i+ZH5NpfPsfA@mail.gmail.com>
Subject: Re: [PATCH net v3 3/4] tcp: add newval parameter to tcp_rcvbuf_grow()
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:58=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> This patch has no functional change, and prepares the following one.
>
> tcp_rcvbuf_grow() will need to have access to tp->rcvq_space.space
> old and new values.
>
> Change mptcp_rcvbuf_grow() in a similar way.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> [ Moved 'oldval' declaration to the next patch to avoid warnings at
>  build time. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric and Matthieu!

neal

