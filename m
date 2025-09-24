Return-Path: <linux-kernel+bounces-831294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36169B9C4B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0B6382371
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D323D288537;
	Wed, 24 Sep 2025 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gpvaMTzE"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C915D1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758750296; cv=none; b=t8ymEbSl7twqzhfdY/I0DpsowKmsBfZq9NNn5p4QX4ekFSNdK/Kzh9F/VLXAa2fR3/EWZy7P44x9qIpEgN6JoAi6B6FnlL8Lqs50Bqt5dkaZ4zoIESPUc5o8s5arNSW/lz8MFtLrEcU9r1TmGIH8xzYV0nQ5dt2QRocRHtIrk7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758750296; c=relaxed/simple;
	bh=PzqRSymdVzt1Og9H2m/pVZgy34E6YLnOoomg2VWITJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1s5YlWYqNErlCm/+fDQrHF/PN3HmziaAoFP2km90QPf1L02s8pZjTjLUyuEoddYMql47VMrxFeqI53J53TO3vOZC0QB5h7SDsc1wllIPXMrmFq15WHK1eUEM1XOHbc3UEeclBWhd2ugVoLZsvOIv0nnslPHk/skpUvrARnBhWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gpvaMTzE; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so503629a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758750292; x=1759355092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=38X5IFenUzwUhQGVC0bd120a5LFhgoZi9a0z5DrCvfg=;
        b=gpvaMTzECxo9tYItWL8VaHkOTQFEmuAjhUKojozeoWFDAle4CMUllQvEAoPiMS0JWP
         qc1Gqd6SgJqN239aGs5b8AJDnDrd5AS1L07XWQZk52Z3ZpoqOdg/+bhWj9yfwM+Al+ZX
         6PU6Ksh6AIL0jEMJkCGgOafJr0+fSZJ4Z+toc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758750292; x=1759355092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38X5IFenUzwUhQGVC0bd120a5LFhgoZi9a0z5DrCvfg=;
        b=Niq6US1pyHS8337xLO3kkPF5k+LAC9qct1flFTJmWYYVUSvJAW4h5LHJuT7+elDS7r
         4YpKYTXF8P/khVPA0R1w7xHkOSKkTJnojmRwH54rtOkXpKkfhDLklplwrXu+NRQQyNeX
         oGr//2PsISkahGojkW2bzGiftUP8uhmfrXyc1PzHZ6+1Lwa1SG9hyeKHEo705zcWZHxR
         FgqJWFrpej5XUpdzYGUdU9qk9p6UT+ndAhSmo7PCYXx6NvMOUNIan5Vjyak/1RumRsqY
         xjzUTgoAgOntaC7jB1CeMHkae3mLZISRRXpjpJSc4OMTvupLd4qHzT7q9WXa/iIuF0Q0
         LyoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXspJ5llJgxJ2B04INtJ30C97biMui0+448Jz5dylcTGOTjIa3fmuo5UsyKK1pNmVit/QVAUn+YYNolvTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoN/neDEFfIDwhOhPPckfxNgBJzHjyptAGFJA03+fVKbvvprC2
	aFIpIx78a6XayC25GsSpzspMp7N7WaBSov6Lg0HbGQ6lGGMuIV4WgU45fP6PCNgp0Acc3Yjfb32
	obQ6L6xs=
X-Gm-Gg: ASbGncuvXlLCZ9dqo/75Cdq8C8G6G61TQqgdVM48r/Apqc3ETE4hxyXSymqPsG/kqBe
	2JRRsFMJZ99pQp8vfapZqBtze+KX7BaKumSE6/67XpDw34LuDBwHwFzLY2s5LCn9xtmXJJpP1nM
	nf4ffxaLB482acIsETS+bjKbsICFSPYalPne1KjtDnUD9D95gRMzVzrSTivJflTYoMQ8QoZmUHL
	iTa/I1KkW5lvH3xPG5aI8kv+ciZ/Mdh5cjuf7YuFE2M2jXBG8CCrYai/zh4n+XXOd+3SLVpa3HL
	peMTZnmdSw7sTfAZI9HRTVdlQmwwk1HlT1fM1Zko/COuzvXbHB48osKuLbapXMjSNMxLST4lokD
	8wfDbIdDg3ghuMkoAOJafceTUssfWXAKMcbtH7HpFSeg604XuepyHXJcfHzbnOcQ5fBpkhkrt
X-Google-Smtp-Source: AGHT+IF3EcKb/oW0cGipHl6/NS8m3HeVoUmoUjh4nfU7gV5Ry/CcyXAwF7aWO0gZxBS3aU3tCMXUIw==
X-Received: by 2002:a05:6402:26d2:b0:62f:c6c8:e6c5 with SMTP id 4fb4d7f45d1cf-6349fa7e6a1mr758957a12.20.1758750291953;
        Wed, 24 Sep 2025 14:44:51 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b0582bsm106859a12.50.2025.09.24.14.44.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 14:44:51 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b33d785de7cso50499966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:44:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTjPugSFvUa2irKJFseVFOyO6nRzDq8I9EWOLuvYz6m/lJhdRjgcfrBJEHpJXRnera8wBOiNeyI+eQBFU=@vger.kernel.org
X-Received: by 2002:a17:907:3d9e:b0:b2d:830a:8c17 with SMTP id
 a640c23a62f3a-b34bd068ecdmr129037066b.56.1758750290992; Wed, 24 Sep 2025
 14:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924201822.9138-1-ebiggers@kernel.org>
In-Reply-To: <20250924201822.9138-1-ebiggers@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Sep 2025 14:44:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivFdqXAytf0Hv4GQ9FgD1hGBMutrrbicgSZirX5qYR_A@mail.gmail.com>
X-Gm-Features: AS18NWBx1VupiFgf0uY-dl7iFrU4oMoZkrOXQfLP0z514sSYRpKr3DVixUA0aJI
Message-ID: <CAHk-=wivFdqXAytf0Hv4GQ9FgD1hGBMutrrbicgSZirX5qYR_A@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: af_alg - Fix incorrect boolean values in af_alg_ctx
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 13:19, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Fix this by restoring the bool type.

Applied directly since the end is nigh.

          Linus

