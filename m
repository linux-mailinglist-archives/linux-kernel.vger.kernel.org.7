Return-Path: <linux-kernel+bounces-851717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9BDBD7204
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A283A17E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA13064B8;
	Tue, 14 Oct 2025 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzfWp0Q6"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413C258CDC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410223; cv=none; b=FtnNNXpTEBqvSpfsJIyvWTKvh9Y4nzeUvXc/zEqNvqsxbGp0NuuvrGCR+cxhtEA4UjlniFGTAKq9xu6/IaN+zOs7SoDmHLR7BA9d231Mw6T6HlbVXDXgFLfifTqE3wcyffbAvCT7Rq6fzNB7ejz6GWBTrpdya1z5YYbu0eViej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410223; c=relaxed/simple;
	bh=RrBAZIy0TteWe1rNbnE+vumd8Hb0TdY/5ho6tkbZS8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zksx6+56xsRl1dVduFim1WdtJm5HAfzFariql8rZAhzVJoPCTFJ3v5wHTaf0HMFwU7DHgzYg1/PZTsyyupoA2blAG2avTZdAEHHwUDphWOAkS0+/T6MWzJiNrap+YQ+vnWRoBaTgBN6ugyFZC9FZxySw0la5sBbIULToyBMUALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzfWp0Q6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so2816783f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760410220; x=1761015020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dsk3/CfBAO5ltJKDJvUsPAsJ58KzLDJtMB6cqf8BZM8=;
        b=NzfWp0Q6QxUZ5DHBA6xbTZturPACKrm8NGPXJ+4MGfLmQYgNG/WmQpnvNVjxejKQxF
         b80ozgGh01zu2aHDsJiWYUS6f2nLxUHmRwjcCoT3ch4CvV8MXStPlrkAsvDEOcCEzIIH
         1Zam2EqBEKMX9LEcKKlRksJcDGg2dxCQxYrRQdoC9Uu9FPNOAG9+uKcCMWIq3ISs4xnu
         E0rXuzZmBxBdIY2C0oTs/FB4PjUtlq5B0rmL2/bZoUS1Zj0coBwFkqxpFmgVwqVL/o/2
         jkukL+1rMk9emaOJ4DO0mYP1N/oXQItBfBphsCe/DfGb1jRFl0uhyQbRIMF1L7AHwGRv
         L1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760410220; x=1761015020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dsk3/CfBAO5ltJKDJvUsPAsJ58KzLDJtMB6cqf8BZM8=;
        b=qzv5CZCmB5kJRv9mEkUKlpetdod7RyOL/Ueo0PQ5h6pNYDk5tP2SKVOr/Yi/DXA2aQ
         Viz3VuRcpWWxo+p9u2KDGR9fvW34h9xbPdNlY8DaXQYpCe2aj8v5tDmnbZA25smtAUJI
         ouaFThmvZ3Qg2ztRz3f676f5gsJn/ZRLlfzeQ1YaeiCzpN0s8qDLSaviQJzlJ2/85V1r
         1ABJXdqHBEtkk3IJ1wQFId/5oAcTafCfKswsh1oe6mNy5vLdH1m4TmF8B2KRMkClZera
         QtYAKkxJI3Z5CjwqnQhPS3/iqxjlqpOBP0wthPOk7/KJ5fV8jDmWXeErUAzVCHd+0/Qe
         G1YA==
X-Forwarded-Encrypted: i=1; AJvYcCWcpdjL8KJcl9z7aZW5j2BLxZLXzcKUqTAczWgMdQFVDhrCQcI7MChls+xp/yxiBW46TYoRWR31pEn75dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8IFu/povw7z9yMe+XDnXrYiur+W6VnKPoUfeouHlHKurK5hu
	H3+TUUPpb7WIFt/3Ef3BYJWF67vmTAhEtWT/luBbYHAH7Z+UvTrA5FEPpDED3hrwNlpJbDerN3P
	0IlzqZBvdwyuDRz1DHZZMeZDujiCsp64=
X-Gm-Gg: ASbGncuLA29wlh0bT/jEhLcx2n/k9pmdKzT8ZRRGHYQybA2kA6QvesPfDyo+c7bpUaK
	7nDOwtaeag2YgsPry/haUeErZ990uhd859xQRycYPe35MuNGT+/X1eEXvEAJ+m7XpGs5/b4uZdq
	BuG9Kq34qdMm5B6vrmXDWxS8lNPSXY8FwUFukcKvwA12icUexkEwrcAuV3O+V4M4vhH73CTBzu6
	zqcMYCjqRQJdv3s0FL15V6qkO1UCML37RSMJK9CHXlgXRUpT1EWOxWicK30ZgtoRW4Odg==
X-Google-Smtp-Source: AGHT+IG9mJh8ykO/cRsI1p26T3hRTaGKLUk4Twtr59/y1RD7cuCR/M359pO3FDOyWU1KemQ7oMxv+1oAoHB6goCn2Uo=
X-Received: by 2002:a05:6000:2087:b0:3ee:1563:a78b with SMTP id
 ffacd0b85a97d-42667177dc7mr15344285f8f.20.1760410219591; Mon, 13 Oct 2025
 19:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014023450.1023-1-chuguangqing@inspur.com>
In-Reply-To: <20251014023450.1023-1-chuguangqing@inspur.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Oct 2025 19:50:08 -0700
X-Gm-Features: AS18NWDYezDAswt7t7gVgX0LbcpsbXLar9N7zvRnvMlP9Bm7rix-FersDRs5Vy8
Message-ID: <CAADnVQKMgbDV2poeHYmJg0=GD-F2zDTcjSxcUDZSO3Y5EwD17Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] Some spelling error fixes in samples directory
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kwankhede@nvidia.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 7:35=E2=80=AFPM Chu Guangqing <chuguangqing@inspur.=
com> wrote:
>
> Fixes for some spelling errors in samples directory
>
> Chu Guangqing (5):
>   samples/bpf: Fix a spelling typo in do_hbm_test.sh
>   samples: bpf: Fix a spelling typo in hbm.c
>   samples/bpf: Fix a spelling typo in tracex1.bpf.c
>   samples/bpf: Fix a spelling typo in tcp_cong_kern.c
>   vfio-mdev: Fix a spelling typo in mtty.c
>
>  samples/bpf/do_hbm_test.sh  | 2 +-
>  samples/bpf/hbm.c           | 4 ++--
>  samples/bpf/tcp_cong_kern.c | 2 +-
>  samples/bpf/tracex1.bpf.c   | 2 +-
>  samples/vfio-mdev/mtty.c    | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

Trying to improve your patches-in-the-kernel score?
Not going to happen. One patch for all typos pls.

pw-bot: cr

