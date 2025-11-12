Return-Path: <linux-kernel+bounces-896806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAFEC51426
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28CFE4F2821
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68F82FE042;
	Wed, 12 Nov 2025 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAAe2lRk"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB832FD7DA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938023; cv=none; b=U6Vu+bPK901qeCI3RvHZxWfnpDSnwVogyUBrcjyprEsjl8lzGvnD//D2KvXd9zrQ8y/aimLH7gS/TRR+3o0zM3GT/hFXGTgYw5r8MajbhxV3ZFQIGgOJjOTXxR3RR7o1AZEExVZ/JPc9kXZKhkRrg39I/BZoelOgxBnBk8DiH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938023; c=relaxed/simple;
	bh=v/Krp1Ed64Q4lcPqqFr5goeJ3YqOL6srgIYEriymza4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdAfdZM/oNZAYJxQiUWlAKapSyp/EsIWQnv+8RsaAlWFTVvMUT29we3A4jy6bpFbXBvOnU0PllVSTQ0lFOTENOHPys83EsX8+LKUiUtdzanY/L+z23cJEi3SCGdiygVH21/n/W9JW8m+T9K+0qSMqFZDueju44D+kbjgfBhUKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAAe2lRk; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed9d230e6dso8364601cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762938020; x=1763542820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/Krp1Ed64Q4lcPqqFr5goeJ3YqOL6srgIYEriymza4=;
        b=AAAe2lRkFqxOg2bTtykVWUzUmNzwc7iUqQq62/g3bpVBJE2xcTNhFzoyethPS4vLO3
         fC5X0Eo/h2+cmwYmdCtpBiQPcxHX7ByNwGfCKKaV5o3VgLGRPVJARtNoTwLPynLHk9Ol
         CAjx00vQyqu5cLkvx3C3nRYJjh1/4TFysAj0xm3l0qffTlqfpo66EMvKUwUSTW5KAEFS
         HOMxGyae3ZvwNoxdfEokjDVWsII2Dhukf79z7Ix8uiEvFiMu0evg/iwngrj5jD/6LbF7
         n4oLYEuSSeImF3scQI/EUs2G9j4HBptgKyTl92+rwbXvNKGqTTAuzH0Gmmjs/Xb+kTln
         nC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762938020; x=1763542820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/Krp1Ed64Q4lcPqqFr5goeJ3YqOL6srgIYEriymza4=;
        b=lUCi+nyLKSoZZ3WhZcA2kCuAaB0olxpe40lrLNSUkeLEGusMQT6pEPp0Lvx59RBm86
         jEKwKGK2DUvIuMb2+waupHhzVLnHm654sHRBni1B73rVOAl3RQ+jsEFoMbhykRprvsxK
         9ehgHwYITRlNatY8tRpzQK96LyFuxvJARhDNv0qSWuFvxOdA6GN/uUw8jCn7iH8AU9Pb
         eOi9RqxDQ2Jign/PHWvOfwKPZNwqhhoYZ4G20Cwd77VJ3tHpVOHth9gmkGOQdbCNVnSn
         U3vvg5eeSnx5vG5TcaPrIIudbu5BepxOICNme63fERTtoG3h16yV8e5XpCDKhG8xBxWW
         tIDw==
X-Forwarded-Encrypted: i=1; AJvYcCVUCuzduQDcQ5c1wZaipleK/zUnoG1yOo7ckUh17oJVbnKtsix6jr133nOZwqlDF76XkvEcgiiUrdX7Fww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJxw+oncVZGTp+tiFqeTxjAOfbRiXXizsAF4GaH6IEcV1QldCH
	hSmWv+30CsMlIv8M2Teln1J6xfK6irM92qm8kd1nWOME77vbWuM6oPz2BtgIN/mCJIngBK+CBb7
	NftHC8hZwo+dMs8YYPmeh4L1qdhKt79kEyX/oYl19
X-Gm-Gg: ASbGnctTZ0g/YTnLUJxs3OG36rMXdlb9xriTvxwsbcWMl891BcRDM2qXvaCd/WOsVzu
	qORvEwUfaHhm5IzRYAdVg74coSwJt35+WoKGxzUcjAQdmQAJNLtOHoF05SiXnNKK/jRNmq51gQS
	LGLv7nw2UjngWUb7a7qq8akmCsZg7jXU4P3jBk35UQWyFTHTPnsmXuywhVxSsdJNN+iRCZqTVXh
	qPZ88ZE5JcalehvVA8Ux3szPjZthSK+VYquX8OPbRKbqg7iLSgO/450X4XFJtTE5DPGKhr0fHN1
	Uxq84V0=
X-Google-Smtp-Source: AGHT+IEzCQ3YNHW4UtVKvqkX2yjhSogviPzmTzb9PXWyqz3RlNdC+8kFSE+KOjdjnU93CyVP7UU5sqx6RahkBBvzCq0=
X-Received: by 2002:a05:622a:d0:b0:4ed:b8d6:e0e8 with SMTP id
 d75a77b69052e-4eddbc9aab1mr30299041cf.22.1762938018726; Wed, 12 Nov 2025
 01:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111064328.24440-1-nashuiliang@gmail.com> <aRQ3NYERGcHJ4rZP@shredder>
In-Reply-To: <aRQ3NYERGcHJ4rZP@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Nov 2025 01:00:07 -0800
X-Gm-Features: AWmQ_blEvxDrUtRwU9ZZmEwZxbCjv9hVvyWPhviWRL9cCYxauIr8WxQDUJlUNqg
Message-ID: <CANn89iKjuRZjeLbZ9v0TcCUEqah3pQbq0-tBPJveavwK=G1ziw@mail.gmail.com>
Subject: Re: [PATCH net v1] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
To: Ido Schimmel <idosch@idosch.org>
Cc: Chuang Wang <nashuiliang@gmail.com>, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 11:28=E2=80=AFPM Ido Schimmel <idosch@idosch.org> w=
rote:
>
> On Tue, Nov 11, 2025 at 02:43:24PM +0800, Chuang Wang wrote:
> > The sit driver's packet transmission path calls: sit_tunnel_xmit() ->
> > update_or_create_fnhe(), which lead to fnhe_remove_oldest() being calle=
d
> > to delete entries exceeding FNHE_RECLAIM_DEPTH+random.
...
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>

