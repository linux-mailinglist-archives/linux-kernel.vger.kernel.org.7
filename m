Return-Path: <linux-kernel+bounces-723618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D4BAFE923
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05E63ADF27
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED0C2D9EFE;
	Wed,  9 Jul 2025 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVjbk3YR"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68AD2D8372
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064883; cv=none; b=vD8M+yiO3ZqN/DLmN6As1PTE7zFYIWfHdXl721l7odSWFanywRub3PD7pmo/qIj+84UOuIbnrz5THgPtH8fSNJleUvj47mGMG7irLRHucB/krA7vJ2yhWYxEWKt18wLkAE+zKjrNMseScy8XGSM6oV4XgfzmRjr0lKvrPHbaPZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064883; c=relaxed/simple;
	bh=J1xDgOe5cYpweMlyooTsldVxb9cU83NUKvesI7+klJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEihc7ze+6VvBNtVXZU3Pg/Zg6jJLTe4D71cqSzRT+h2AgeY9UmQAmvGgvrC/qiN8CAQJ5sedNLczxfBbDmcqa7/fezd3aFx9jYbS++n7o7oppwG5XJ5WXXZ7jgKiHPopJbqFfL5A+enjFokBTB51rMXpp+dH99eD/v1NJCvYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVjbk3YR; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a52d82adcaso81830101cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752064881; x=1752669681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1xDgOe5cYpweMlyooTsldVxb9cU83NUKvesI7+klJo=;
        b=mVjbk3YRt2p3pvSPcOVy9xSOO19GO7bMl0ByNKqKNU8wAYVgaU0GjiXIBr4C7JwxNt
         yXvnQrPWY64OyR1d+DimuEgNwcjJutztmQnf4MKeISJxEHwzsM045tM7eiuZgajVB3fR
         q+DaiOR2a0Dkz1K44eaVe2etEH50I67skaBB8WAyZ0djgpJbER4SQf/WlAaCTmBgZEwY
         IbQcyk5pzqxZcB0LMaT/Gj4+GuIWrrC1s+8Fi1dEPCY/rk+Vk1HDJmFctAfyhiKK/eWG
         xwnvwEIc1UkKcDKAaUJHRm2GaNdKWe1FwQdw2CPY2ETZmxNLOoWaCk2C0nsXf08Wa5Jd
         AVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752064881; x=1752669681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1xDgOe5cYpweMlyooTsldVxb9cU83NUKvesI7+klJo=;
        b=K9cUM7Muev9wb1p4nyJnquD/w/c2esAKCdlRIlmOQX6aod2iFunPxkAqmC78fHVjh6
         PADkfk6gx/m+xT/ehG+EN3n8j90ThbdCQY2rsSJycPYJBVz+DJ7wjUoA7O94w+u5u0Q4
         pex7Yl8aiyYgAO9woN/hocFFKq7FUCScOLXGvAuRA5H+DuCRhLi00IDhaBO0vEJzlm7i
         4ZFiYelkmL2NQq9RVSms9I7mu5bvKyBtS1PiX6H4gzOyRAm5SpdAe35O7Wbhp6sE1Wy/
         zCwfLzAejq7HPkl/rsPPSxTSSow6TMTlL2Y7FACLHb+8rfLZRiSJUp03ASR6SjTyNuXh
         6ndA==
X-Forwarded-Encrypted: i=1; AJvYcCUzF9gEfdt8hqYmmUDPT7myF36zjODHYckzB4+IM0ECB33N6+Y+crAv9xCjrkk/8Q7Y5Q3VbqcdWI06zGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1LktwkHyEW+/2IKk/3+Co93Gyc58Vu1RWIwxdOFFEkQQTb8r
	EfX1Y/u4MYT78rsBlI9SAgNM6XutqxszjbWztPazocwqhGE29xf8CL450DGF0bnnByLuFETSx5d
	vmU8jC/j3nCCFD1Y9gGpO8sr9bkGou8SL0t/tJTOv
X-Gm-Gg: ASbGncvwnXXu5SengMtMHQX85AED7s4Jis2+jDuUACOUW/xe7+AEe8GNLOrqG+xq1t4
	cOuKPA9/l3Fnbhp8jM16lZDsQKqHXPCF3dsRQMWlT6DrkzT8+qb/abL+9kDgLqxNbIn2CNqO+qH
	jawWQJ7czOJ39alEIoO2LYn8m3xG7u3EqK4c1gZqk+dgq/JIv2pZby
X-Google-Smtp-Source: AGHT+IEWxNPG7dp+DjzJRns6J6sHSmisi7D5RqiV/oaoXwu34B9UVWumWvBNs5RbIYibvouSj9c4f2Zog+T9LOGljY0=
X-Received: by 2002:a05:622a:a906:b0:4a4:4bdc:8b1 with SMTP id
 d75a77b69052e-4a9df26cd0emr26277301cf.19.1752064880392; Wed, 09 Jul 2025
 05:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709095653.62469-1-luyun_611@163.com> <20250709095653.62469-2-luyun_611@163.com>
In-Reply-To: <20250709095653.62469-2-luyun_611@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Jul 2025 05:41:09 -0700
X-Gm-Features: Ac12FXyV_uF0R0COhdOT8k3hZSKG1IgtD3WPDSc04tanY9Xn82wNw8OZjX-_CRU
Message-ID: <CANn89i+sZZM6aRC6-yCRSEZV1UBiaDhvsKnm4+JJibW-xwRwrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] af_packet: fix the SO_SNDTIMEO constraint not
 effective on tpacked_snd()
To: Yun Lu <luyun_611@163.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 2:57=E2=80=AFAM Yun Lu <luyun_611@163.com> wrote:
>
> From: Yun Lu <luyun@kylinos.cn>
>
> Due to the changes in commit 581073f626e3 ("af_packet: do not call
> packet_read_pending() from tpacket_destruct_skb()"), every time
> tpacket_destruct_skb() is executed, the skb_completion is marked as
> completed. When wait_for_completion_interruptible_timeout() returns
> completed, the pending_refcnt has not yet been reduced to zero.
> Therefore, when ph is NULL, the wait function may need to be called
> multiple times untill packet_read_pending() finally returns zero.
>
> We should call sock_sndtimeo() only once, otherwise the SO_SNDTIMEO
> constraint could be way off.
>
> Fixes: 581073f626e3 ("af_packet: do not call packet_read_pending() from t=
packet_destruct_skb()")
> Cc: stable@kernel.org
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>

Reviewed-by: Eric Dumazet <edumazet@google.com>

