Return-Path: <linux-kernel+bounces-761928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFCDB1FFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898BA16667A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B311B2D948E;
	Mon, 11 Aug 2025 07:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aiGG4bCR"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B113AC1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754896267; cv=none; b=sfm1yVHfsGrM/0EuU93fdgxV7bs8b20R0QvenF0bvY6pS81Yg9wQjD1jWGEJVykMRWcxJav0+vg9Mv9YolwaKkOh4CNqvm0LgoO2Ddz3cH7rem2R1zHBgOcSM8RIOZoE7tM/uPRTrbcXLLKlHVTBwgr0CQerJKQxwlVmVJSdwn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754896267; c=relaxed/simple;
	bh=tB/gqdCF6EzsFjXXwaRDV/pGeOQa0F5FLdXW4OQTyEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jq/rdyvsAihhpDYzdoVG31tLDSL1C98qsh3A8Gldd27gLuiWKWHqIBGsERl4ffK4hjYe9H1O2QFjTqcVvUyvhNACIxNtz/c4eYgjXeFQcnl4rcFTcIMSM8gBfeVH5cVfiefD2S9ChXPHw8TkjLxbkgP+6VdzaEQuGpTmsbW4Dvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aiGG4bCR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af949891d3aso537454966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754896263; x=1755501063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+tkggMO6AT5LolMfVDkxblD5g/qWfLNlR97dm1yJTPs=;
        b=aiGG4bCRN8uTntvJY8QLE+UdquE8Wr93l0CqtGxTOtBCux5AAyxfsqT7JMw3np+Sf/
         43x6Klh3weHz4Ut3Zch2DCWRI8naxLUhduRI+bror4NONOPfPuQYbPvBeRZkA+Bvwby0
         9ZzxmBxtUeSo1dH8l8KCjDc2yCojJxxHdv92g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754896263; x=1755501063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tkggMO6AT5LolMfVDkxblD5g/qWfLNlR97dm1yJTPs=;
        b=UNxKYoM7FBNd6LoaIO39VR9Af9979dWPV0Gl5KnFDjvacUPcTcSbiThipXQXAlhbk9
         4ChvnEh6mFADSPWulSojSslTgt6XhcuaPANxGt59Hdl2VKh73ZRv4ytzhRBK2w3EGLpr
         7VFoddPkDM8BpNkfMB3Wi0+wUBAs45UxZe5FnG9R1ygEVLKRPYG6S1xVLnQRFjXPVN+U
         Fkz6m3xlcpUmzdu0P5uXdOWn1jSEi1dLZ9vh9JuODgj2BX5DVibVdS3MXTC8vyfPWvLv
         l6nb2aeR4EosSHUWX0iQGg3BYKX3tgkZMvWMbhS5LkKxny56XxGv7FKObrBMGD3QFeGo
         /QOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs+Wx8KImRjBdajIwm+HmgHa0OAxwtGCARBlqB6pHXEj/BRlxfBlQCtGolGXa8FZuQX7kSnfNzVylVWX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBpRRZPJsWM/d1LtAFDEXouNPZLEJcOwwKUqvJ//pi+jftMbdv
	aCMyYoY0CiH4Hn/iKcKIU8Segn3Gb+13TZuKFg/ClE6h69ZnFSQJ+39Isyd2TjMXORn8spqWOgU
	fESxPV12vPg==
X-Gm-Gg: ASbGncuNa0CV3vPsAr59MD6AHTZt+4wwP86zV7A5SgMoaQsK/yq0Yl6xA5Y2CIJRsKa
	KA6IPiP7GJUCWXfeR8pOMdFTAhU/t/hdWC9w1odrBQ6wHSnammqBG43QiyjdHL+CIdNqEbHNH9t
	vrKlFC9ViD1/QTj6daDtH/xJ0pU17UJsvS39+FqgL2m6b3JCXA1YXWhZcvhBXZg/gz1NtqKIQoI
	2FOUdMc7mS6L8s4l7n2Sa1b+QzYFwdtrJJWq5qEJTVoK8elop8X+KVT+4ckCo3yd4o/opTM4mJu
	GZ6BqFJa3lAVbEfhm619Yfy7oSUBm0skwpFcbx8vtAlMRKu46aVFAkpL7Xxg8cSO54nrkfKHfGB
	HM+XNbnjMaLg6leHn31q9gElbyWBkqAexMTYyvCN9hjSz33MJ73z+6dG9Jd7dEjKq3QVTyG6v
X-Google-Smtp-Source: AGHT+IFBffoGudczbPuGRaMZGmlNNXa92SlJZR9Kubxam382VJUDUxz4szVYEbe4h5OdnX+JUc7fiQ==
X-Received: by 2002:a17:907:6ea5:b0:af6:3194:f024 with SMTP id a640c23a62f3a-af9c6370cc3mr1077953266b.13.1754896262740;
        Mon, 11 Aug 2025 00:11:02 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b6csm1973854066b.48.2025.08.11.00.11.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 00:11:01 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so4701073a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:11:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkFkJBcpOIJW8WvwuHMO46l65SehPNovVD3HrN1VGC77Ydz65EkTyO81zRybDEWRoyS1Fv7om0qSuoTbc=@vger.kernel.org
X-Received: by 2002:a05:6402:2106:b0:617:b28c:e134 with SMTP id
 4fb4d7f45d1cf-617e288cb4cmr9911954a12.0.1754896261462; Mon, 11 Aug 2025
 00:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJWOH9GgXhoJsHp6@gondor.apana.org.au> <CAHk-=wgE=tX+Bv5y0nWwLKLjrmUTx4NrMs4Qx84Y78YpNqFGBA@mail.gmail.com>
 <72186af9-50c4-461a-bf61-f659935106cc@oracle.com> <CAHk-=wjn5AtuNixX36qDGWumG4LiSDuuqfbaGH2RZu2ThXzV-A@mail.gmail.com>
 <aJl1EIoSHnZRIQNO@gondor.apana.org.au>
In-Reply-To: <aJl1EIoSHnZRIQNO@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Aug 2025 10:10:44 +0300
X-Gmail-Original-Message-ID: <CAHk-=wg1okLMc41jaxS+WRXigw7Fu+OUc6QsnL+BbvYAGTdZYA@mail.gmail.com>
X-Gm-Features: Ac12FXxbcSB6uQKYwcexAGQP5Eo2dNnigj0KMH9nSHSa5SpTRmBr-egHpRbH9DM
Message-ID: <CAHk-=wg1okLMc41jaxS+WRXigw7Fu+OUc6QsnL+BbvYAGTdZYA@mail.gmail.com>
Subject: Re: [PATCH] crypto: hash - Make HASH_MAX_DESCSIZE a bit more obvious
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Aug 2025 at 07:44, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> The patch below should make the constant a bit more obvious.

Indeed.

It would be good to maybe minimize the on-stack max-sized allocations,
but that's a separate issue. Several hundred bytes is a noticeable
part of the stack, and it's not always clear that it's a shallow stack
with not a lot else going on..

(I just randomly picked the btrfs csum hash to look at, which can
apparently be one of crc32c / xxhash64 / sha256 or blake2b, and which
is then used at bio submission time, and I wouldn't be surprised if it
probably has a pretty deep stack at that point already).

Oh well.

          Linus

