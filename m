Return-Path: <linux-kernel+bounces-778309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7E3B2E405
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0015A3A82CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650AB23D7E9;
	Wed, 20 Aug 2025 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a17nh+g0"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD4218AAB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711185; cv=none; b=QDIobP9sebEWbHZjLm/ymXrJA7WvDFpRw6Ohi/OqbrBzP0EJk48dsdYp6hzzW1T7agG+l799WPOdpVFTnv5bEC28boT3utbOFYWNxMxz8UzGhH6Tx7TUokVkjIaJ2ZT/83YZObdONCJa8F3ItJPPHdGfaAaPt0mvt8L/lImxgCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711185; c=relaxed/simple;
	bh=ThfuItRzO5dAi8yX67yobCtdK1/gMRrLN7ssTg7iVaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWtIxA24708za7tEz7HTshv73daLx4O5pYQjjCxwxmYogsJoWBAkpeRGhO9KyZcduP3/gsBDbkSUoymGUSflXR/kiOn7Gp8HDryY2+FTU0ZkPt4RQmw/iR9ITqzOYRoSEK2mWkeqV6ioHG8ZPOx+Cpyg6Ru1Iz8kK2oGyP55P6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a17nh+g0; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88432d8fdd6so1761939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755711183; x=1756315983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThfuItRzO5dAi8yX67yobCtdK1/gMRrLN7ssTg7iVaw=;
        b=a17nh+g0W098tjiUnLpvthQBFt922wEAnQFbPQeu+vdzCFjwR8m6jNNJvyG7x3aG1U
         7jIYcFUhSV2r+VbzrcHZdgk1ADr8bGlRqTUU+6kalj3uO7e53wBgbahru5PAr5Ur9VlR
         zJWZtOA6XUlptXr/YnKD1LtZCoQ/H4+fAgmm6cbyheqi8yjPEVu+QNSB6etn0hbw8wea
         yO7P3dVOL85FRcPgd1PZKx3Leul1fGgZC81DOgaYtvvxmXPlMxYorAQZUCvGFB844tNA
         k7yIWcez/zqHBRHr2Nh52cfB6fatMNlC/Ud/Yk9jhTAZfdtPShj7KhjyQN65X9QrRqCH
         tWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755711183; x=1756315983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThfuItRzO5dAi8yX67yobCtdK1/gMRrLN7ssTg7iVaw=;
        b=iHTQDZ7r8nOuyXzwVKEEuif5py2T4jX2H08RJHuRCa28+VB1N3OTFoXtlQ6+dpigON
         FK4oqRNSY7lJjKG6mV1jA3QLzNcViLIbrpITVCrE/3+QUIbqm2g7jiPZFOkemn099Lr2
         7dKrG+W5mjVr8KDaXgAY2VPUnlrz/wD1QGDwts+QTWQNHLnpsfr6O8eF4NI0xcJhl3De
         Mo+BpfIyTaon300QlstW3rDtcphwvBNVB46IEBaiCweGwKTknRsOfbvdp/djxI9LwWrm
         De9ryPJZId316VDK0y0cEdT/6DxQ+hRV9U7m8kP2hrP8A2XGGJpImHge2hmXCeIHRDSE
         oORg==
X-Forwarded-Encrypted: i=1; AJvYcCWNBfMOmRFNKS3rcJM58MHgdJd0hAVxURWw1JpvsRNfmEj2gBOh5/k9Sj4XdY6g84b4XjEbdGdWTXpKrR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ04rqz/Mj16+ajWgciQlTc5QMn3YPv+qD4SG/7U1vMi/56gvY
	Ks3fYRvRuoU2KwC2m7wX0eXW+hFycXGQmTH0WVveql9Ez58cXS68ndAjkHcMApx6+zU1/HokOqZ
	qzV/NLnMVp7M/iOUxTajwwT0XPM2yfIY=
X-Gm-Gg: ASbGncuMQQfBqgCCkTYIB6/8whswUjKf4qflE0thYMpnRE3H0RykbT1cUCTbrbEj4GR
	wtrHumDe8Ay7v41EL5hLVt068TdvYPq2GQV/EtAq8MQCy0h2eWMP6F0FNyPqC9P/POFjQfWsIof
	kdWhhW5vyESlSdJN8vztauPmiwzR6BBOlAwEqeuEMw/BNMQUjeNRb/iidaxuPhoM3GERbMD2g35
	7P3
X-Google-Smtp-Source: AGHT+IHo3KxAA012zFqs6RhvbLPpLx+6J7o9tijiKGSWLorPFqpg2/Omsh8aBWipT8mtpeYGOMKEzTXUFSLSaOXuzxQ=
X-Received: by 2002:a05:6e02:380b:b0:3e6:7981:1fdc with SMTP id
 e9e14a558f8ab-3e67ca4983emr72265165ab.21.1755711183165; Wed, 20 Aug 2025
 10:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819193404.46680-1-sj@kernel.org> <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
 <aKUi7hvcaK0h0oMg@gondor.apana.org.au> <CAGsJ_4z6YvQULrEmNjFjLNrJ4RK6w0+d9uF2-7v06gOYirrYRw@mail.gmail.com>
 <aKUmyl5gUFCdXGn-@gondor.apana.org.au>
In-Reply-To: <aKUmyl5gUFCdXGn-@gondor.apana.org.au>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 20 Aug 2025 10:32:51 -0700
X-Gm-Features: Ac12FXwLFWidn2lw5_reaDVdpK_8xLH_KQmd5o4JTROLVpqWQ-9XKmGxaOyFOcM
Message-ID: <CAKEwX=P9T315JcOBOBGK21Zk8XyDruMTv_XEPa0CuD=oAN2QYQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Barry Song <21cnbao@gmail.com>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>, David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 6:37=E2=80=AFPM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Wed, Aug 20, 2025 at 01:34:01PM +1200, Barry Song wrote:
> >
> > We might want to revisit the old thread to check whether it is now safe=
 for us
> > to move to PAGE_SIZE in zswap now.
>
> It's perfectly safe as LZO was fixed months ago.

Perfect. Then I'll revive Chengming's patch (see [1]) to reduce the
compression buffer :)

[1]: https://lore.kernel.org/linux-mm/20231213-zswap-dstmem-v4-1-f228b059dd=
89@bytedance.com/

>
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

