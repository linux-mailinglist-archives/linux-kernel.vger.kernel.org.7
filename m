Return-Path: <linux-kernel+bounces-808975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6206CB5070A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EDD5E7F07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F833570DD;
	Tue,  9 Sep 2025 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHmleH+A"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA23375D0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449537; cv=none; b=hA6ejPjID/8hGoXrRa8yqAsSPashsxBkVP/ieM1L8IGtDyxkYMzfiSfLCmdcDdA+VM5owmdHf1rgGr2mlt5sbyOieHxD3MeZjXAVxCqWQiWgwphxTAChUiiJMvE1xbQ9oj3K6OFcFn3qMt0pjVPK0acosEM11+qxbw34QSioZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449537; c=relaxed/simple;
	bh=wxDkBYso8klg5m0O4f2q3Mp4Da5hR5830yShKQUo0VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaG3xGnNjoxz5YR8GMLmdK0w0dE6JLbEpi0zmMehk6X21ygLiu7lae1KuoYNktcipXVVKqIptd8FlNuxwnAksZL7H4E2IiLSjxb7cL2LKBuUqor0JIXMZjITV3JiK0sLQlGotoyuP6LJVdPej0V6X8E37MyUAh1/jTv2NS5GItc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHmleH+A; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3296a9d17d3so508166a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757449535; x=1758054335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxDkBYso8klg5m0O4f2q3Mp4Da5hR5830yShKQUo0VY=;
        b=XHmleH+AU72fWuR9+O0iF/qAe2iCZ0UBWRb+FVt0JdzulAKqKGZuvKV1sQNq+KErzG
         hzbdOqHa0Go+GjfrMDZ0/TN9KQr+ryUEv35vYGKbkt6m9e7ycUEkKLPziv5Ex+tWy0VG
         pjO+Ooe1/AQdb5M+91q81ZCrx3Fbs2i2rVcnHuZCfUlulv8k7dId+xg9XRiTRYfGN7Vl
         0+dQB4ZbloolRiD9FtDoFvhEoMgMDiJmGIyaEtS0RuxAPVIwg4WrBQAYW5HK9sBKBuGB
         eZc72Vm0o+7Qf+zMG4q+0aAU4d5IUlFJVBKEqtpgciVXYnbyJ2imxU7IhONcOtekYquQ
         UhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449535; x=1758054335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxDkBYso8klg5m0O4f2q3Mp4Da5hR5830yShKQUo0VY=;
        b=tPPNPUAU77YBVmUAA4G7VoIAr9r7rC9ZnMIszqk0upFlfCXWh5rLsc7WpfFDs6BUkS
         O6MTjkx7tsFftPW2UypaFJcGI/3BTtZb2kUchDqPbHHNg45SueR2svJjP0hiNS45TElF
         whfY+nfBzjZfv/oYb+hiqLhp2i3/Bz5X9m3cc2dNCYyhFBxHBvNOx2PnprFitrFwHQYd
         dP3gVGumyHIL9a0sfwRxkW4q7Xl/nk+IIs4KbRTPwRgeP2kGBFBtIAY90MpCUm58q8Sc
         sXxG34pKfAH4k/DnVUJnxjXZQzlgIifIS/m5B6Iyd1a/Jorw0tOfXuT2c82QEpn2iiz2
         KKMg==
X-Forwarded-Encrypted: i=1; AJvYcCWrcmyAj1K+SjpgXhDyrSYAphVBlu3ZxR4WFfx2bp1a8yKnDa2LmaCsIDUPqDFQx3XPLKyrpLcUK/5JqL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5eqcXHNzxRLyN74MRHGltBTh2WYgISHKencp1vWWg8C/eM0QY
	zxlF+B1pKuF2JxkKnXbahdPq7cvpAyNS/l2wyWVAAjRUoCaAiAPF1shMG7LvcHSVS2P3+RoyDSe
	iPJW24wsMoOiGo2Ye8hMBxY4UOdjX1uU=
X-Gm-Gg: ASbGncthV8OaN2ZsfmTMInNBrxXbXANVnetJHu3xdMGqBblWDL2Cqsgce5FTYyn2R7P
	iIREknRaBd/p1wpOEwnO7u3rzfqx4/4aDqn3TpFRAK/Do2sJvASJ2tpPrvaqMfg3ixPAHql58AV
	rK9TXCZTy1x1fpYqmboiR+K0R/5Y56PwvsiPviG7DkrwvUTP4xbCQgRvjaABzFWt6vZfAxheVTh
	F6WfJxIaemY6vj/oFUj8jQaoh401JhWWx6NUNgMLCqXte8NMaToQNyD822ZY4w6YLmKS5dnBwpD
	iw3y++CqsjJSFKFjgY914NVbyL2xqXdY7Zst
X-Google-Smtp-Source: AGHT+IHrPuSJF3/HVlVAKPSA02cYiEkxIc6cB43ReX8WFLs27T+peqgFv4ZntBDqLfeLPgMtU2IPc8i+zsxFpWH5p+M=
X-Received: by 2002:a17:90b:1d12:b0:329:7955:5caf with SMTP id
 98e67ed59e1d1-32d43e19c34mr9367597a91.0.1757449535379; Tue, 09 Sep 2025
 13:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909170013.16025-1-work@onurozkan.dev> <20250909170013.16025-2-work@onurozkan.dev>
 <CANiq72=kWpxpo23JUYTqxwpsY=E0uUvCHgotRuepZpL-qUqXqw@mail.gmail.com>
 <20250909204308.74ccedf4@nimda.home> <CANiq72=NrS1cFJec6sm7ZY-UPqrzxHKVvPu67Rze02Fg_xeWpQ@mail.gmail.com>
 <E64F356B-7EC5-4F46-9ADF-610CBF249651@collabora.com>
In-Reply-To: <E64F356B-7EC5-4F46-9ADF-610CBF249651@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 22:25:23 +0200
X-Gm-Features: AS18NWD-q1dZbe0B7ncsGX8Sj9K3t4jhyDGuBBU0miup4atDr7AbXn0cmcwNeLs
Message-ID: <CANiq72kN3C24OEpbppe+AoSPDH3FceDsUh7ErqHequOyRftE+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] rust: refactor to_result to return the original value
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel@sedlak.dev, dirk.behme@de.bosch.com, felipe_life@live.com, 
	tamird@gmail.com, dakr@kernel.org, tmgross@umich.edu, aliceryhl@google.com, 
	a.hindborg@kernel.org, lossin@kernel.org, bjorn3_gh@protonmail.com, 
	gary@garyguo.net, boqun.feng@gmail.com, alex.gaynor@gmail.com, 
	ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 10:12=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Merely rebasing on top of the rust tree will crate a conflict with his pr=
evious regulator patch.
>
> My suggestion is to just wait for rc1.

Yes, but note that conflicts may happen either way, i.e. for treewide
patches like this, one may get other code landing that may also need
changing. If what you want is to try to catch as many as those as
possible, then it may be best checking -next.

In any case, I would like to see this on top of the patch adding
documentation I linked, so that we can clearly discuss the intended
semantics, because this is changing them for bigger types.

Cheers,
Miguel

