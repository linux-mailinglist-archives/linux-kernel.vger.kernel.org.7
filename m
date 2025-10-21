Return-Path: <linux-kernel+bounces-863317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79705BF7888
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7AF5502BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1DF343D63;
	Tue, 21 Oct 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPdf5EBr"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522FF355057
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062271; cv=none; b=JUFHGksZ5lwgBPDkv4eOEag7h8kkc5bYGdr8sAxlqGqIBYlI7a6p3jl2Jnv1oyluFKQIwbd4n9aFM29uDf+Ek0oxa/ArU75EGCcem3fZfvQ91g/ydynbhdyDCD53M5UufmGxekQ52SiqFa21rH44uaNvcbulEt2MqgdXNlHmWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062271; c=relaxed/simple;
	bh=Z/1v14ONw8upvjPlG+HxTxWPgwSB262WBk6X08dAu7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OoqzpHngwxALkNAm5KNZ0RbYrkJ9t0kPQHRSLHnA1G2nSueafuRw+4R5RKY9mYyVZklDTtup/FqgMgn/iBkBKYbUSoDb3VFllBeMrJOFdikUGPow+3yF6a/CDzA6IUGqoJQnNxR4qmxOwmpA51vDEZtHOEJjiZkyJN9p5jN5HFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPdf5EBr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-28a5b8b12a1so58253335ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761062270; x=1761667070; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z/1v14ONw8upvjPlG+HxTxWPgwSB262WBk6X08dAu7w=;
        b=mPdf5EBrUvWOeXPNFd66GJnMEzEmnOeFfmjuAue0bwrFqgaMLzrDqZjhrtrdETgVqq
         FYNed/jN+rzXiLrsARpmm5eGvJhiX23am5HbW8WcGWuP3lo9ww0I/y77N0aq8rTZV/9O
         GcGk81C8FfqGMVYCr5k6XoQJONgxK6eYXEGuKp1pG+fzWAv47JKW4DxO4IcAobYFCa+m
         AKVoR84coBb4Pj6pPedyUFQNKZPKmrOFwsxn4DJkX/99JhUTNLncHp+nENesw2/VVxkS
         703sLnt8MmZAmODoSlT7ItNUIVWsP2mmTlonhNPceHKGU2cotHzl6cUzDhRpBdTEw6ls
         0aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062270; x=1761667070;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/1v14ONw8upvjPlG+HxTxWPgwSB262WBk6X08dAu7w=;
        b=HuBNKPh9Ie7TVDFvUlwlETyBA6fmXxN6fDQsny6ywEDp7ujqLyGMOidmq3HYX0xWlb
         so+fHJxdpDg0TD2eNOKTahtjKrKMkOV9x58KdjHSYv7YIoUBPEGWyktDI4rK8lSLZqki
         XKF0fLMyR1crr/ES95yU0tAaCGOD9H6Kf1ykc9Aaz8FvalssM5tGfzZrbWbKADrKKDAg
         Gy0BnywGcmgVSVzM8zxTBwV9LkUOee8mjHLcbn+a0QSD62aVJNEmhEL/lRvWLMihw4yW
         B/M3senINzzgbU0R8UgHF4y9Gk0YYudCve+89SmrqZNNmXtUMCY1+HOkcPwczyzHwl+6
         /xXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnq2JT32M8rdoqI9J4selxiePq2HsC+d3PcFuh/EY1T5Br/3002h/ButTROP90HkjIP0ICXAMMe+4DidU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy6qK9RxpdQE2UEEtgoGoys6exuTNswwmT2ruV8KD5ZSyxT915
	HPKSlwezwUdjUFBDGl72LfEJdv36lIXH1S2Kh1xIvv5MQdeI8OqebOzvFKwa4UA8
X-Gm-Gg: ASbGncsOfpW2FVnwg3eRT9Rm3+P7dtNNKNeJqrnjs2uFj1ivw1YiYUzm7ymEDEGJ3Wu
	wB32jYopja11vVp51Egkeao7b9Si0lMTRfll6w89ssOIq7QENj9Fld6gfl8ru16ezCOD+YbfVak
	QOiOykklqKZsV0eQ9irt7KpjmgiL6IKxWzoLddP3mKrMcflIW+pJvSWF2/PAqE1P2naQpaAyI1H
	YHJ9kMMdAz70oeguvWKU18L8Fc37JXtDE7itugjBSRytnX0SNasQe2S34Pi6m8UJPWVSC/jtUBi
	lHThsoEpSrTneBNNtlntUkAkyLTQfoYIbQYGSx19eLbJkJZW1ZSvBg54pupzmnsGwkqJoi2VOqJ
	RJXB68uAGJlByMysZpwJcPPdjguUPBvgkDmLUAaDuWUAyE7TsvHTpvMpUaYjnJDMFaFvdRbiThT
	H5fua+BADkKJ6kfDXQioXEKGHL0gDmpxZTSaNm
X-Google-Smtp-Source: AGHT+IFXBM54S/3IPHg/YLriqEWWdSNp+qID7b3KPyfagGS3obpL3xkYxPk+L7+SiGexSO69U2KtUw==
X-Received: by 2002:a17:903:244e:b0:290:56e7:8ca9 with SMTP id d9443c01a7336-290ccaba092mr197957345ad.52.1761062269488;
        Tue, 21 Oct 2025 08:57:49 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5f45:f3d3:dde4:d0ab? ([2620:10d:c090:500::6:82c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffef8esm112694575ad.51.2025.10.21.08.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:57:49 -0700 (PDT)
Message-ID: <e2716ad9963403dd0dea37c85d106267659e52bd.camel@gmail.com>
Subject: Re: [PATCH v3 bpf] bpf: liveness: clarify get_outer_instance()
 handling in propagate_to_outer_instance()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, open list	
 <linux-kernel@vger.kernel.org>
Date: Tue, 21 Oct 2025 08:57:47 -0700
In-Reply-To: <20251021080849.860072-1-shardulsb08@gmail.com>
References: <20251021080849.860072-1-shardulsb08@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 13:38 +0530, Shardul Bankar wrote:
> propagate_to_outer_instance() calls get_outer_instance() and uses the
> returned pointer to reset and commit stack write marks. Under normal
> conditions, update_instance() guarantees that an outer instance exists,
> so get_outer_instance() cannot return an ERR_PTR.
>=20
> However, explicitly checking for IS_ERR(outer_instance) makes this code
> more robust and self-documenting. It reduces cognitive load when reading
> the control flow and silences potential false-positive reports from
> static analysis or automated tooling.
>=20
> No functional change intended.
>=20
> Reported-by: kernel-patches-review-bot (https://github.com/kernel-patches=
/bpf/pull/10006#issuecomment-3409419240)
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

