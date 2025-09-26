Return-Path: <linux-kernel+bounces-834016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D902FBA39AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B241C0290B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87182ECD01;
	Fri, 26 Sep 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX5oblO/"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F52243370
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889573; cv=none; b=GGyHq0XW5EHcMMRBuyhejokQalZaZFaNFJigTt1IYTcc3VzkwCALGHYsnKNpUfadbmhKsluXC5LKGd3MOjANo8QvCIlW8lb+Zca7FfEf98ZmtQfRlF6APY4vSKb2aJLf+TWjWlJVjX2R85gzuugKiNuSgGMiWmX0Ile5VokCb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889573; c=relaxed/simple;
	bh=t2+UAvCr4XcZ0OnnZKKa2yux1QRJHla1KR4kjND7Qv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PURJ702GBaU0XeTvn+YZhHxugM9yJRY3p8NW3ZRur6TUVkCRwNqbNOkzJmoWtsX67BGokE1t21g1yE7pCk3nRwKdvPQBW4ijboeeu/tfgJEqfOJibJSOCroB94z+wLurJjJlYlTeujQunnTDyFiN/VUUQrbuvsANh1wvHkf6VWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aX5oblO/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so2459448a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758889571; x=1759494371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLHkKF18lMe3OS222CIEqifXITXK3HwcUajzIjkMKH8=;
        b=aX5oblO/6DOE1cKyM0anqBA/rHkeTPzlqffWeZDTaC5+iBwl2IkfZHvjK871kW/ZgU
         xMGCctTOjpLHK7CWkkFIWVHn1xwt7/XTWqr+n2Rcn7q8pBQu3lE2DjirMFsvWBHyrN1D
         os7bEFhREGt4U2RkmqMSM6wc85OzKE/SNA27cPKTAZUBi/UKtm2h8DVo7fb9dBFPNcvC
         lf7MONqirov1ozZjidlvDYIW+KVIYSvAn8OcswePshwNFKVWX2Wq5c2HsW1P7Wl3Zq0h
         ti5E8BnIEynK+oP5YG8GRtIMG65skNKDaaqchd3N4UJgKrO4wJ3o7hk3B2DtqOfYFONt
         Aimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758889571; x=1759494371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLHkKF18lMe3OS222CIEqifXITXK3HwcUajzIjkMKH8=;
        b=Gd95nflb8YRMZCcA++rck8kt07KHy1CLS7w65mNGBzm3qz15waP3vrM6ebHOsMkoeJ
         uC9JgTaChpd3jtC5X0Z4XgBetZTig7J7wVx+q8CceJSMiiIuEgRMlRAvaS6oizNBCDjw
         /SgfWmcqL8dUEUV/e+JDkjZkXTigMpd+xSmPO4b1tEsq7PbiGVLu39BI9EVE+o8ahchU
         4qbUAd/jDqFhwLbqiWAoSq+iZO0lEUVy4x0CDe9XmD3FgrwZdmFRXD24dqiTX3tTB30b
         ib6fqnJqRP7eqPgT0qEGuEHKhKlMs+GcBSeTxJ6T3zN5KPOyXqhsy0ZGq56KUJATkYmm
         OGLA==
X-Forwarded-Encrypted: i=1; AJvYcCXdQo2dw2iA+sxgMsY8+fvuAIAxrlepdmH37t2zViIP3p0C8Pj6NHJo6hUdaeDjMGsK67YdlYVQs+grPyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyauvI4qAd8lNtmJzYfjzC2meOvO1+bkNDK+P8FsqMrctHEff0w
	D8+RgIOX6YJ8/ZnH8Trtjb9qoqK7FUW9wD9LtjS1Gp88wY9GPi8f3z/Msg0f2GBEeh+uvCd8bLy
	n1PrmNwotHgUgsxtRQBOOJH4a6kOyz90=
X-Gm-Gg: ASbGncsDYpjVC+y0oimrVDeINjiJ9A7/k2c4JP7kFGUq8WeCTq0b9XBY0ANzPWK8SlH
	sCBv/3cHBXfLQjwAq3zg+NTUr8CfccfeLRbIKN68dvLONLDgUPRK4wQpE/hz4b8gbcwPSHZmBOr
	PeFFfABGcoiZskmalWSkYKCbE8feLjvwszDrka2Rr4T6omNPqwR99+wZ2m67Hy3TIkczOB3Qebq
	wKkYiE=
X-Google-Smtp-Source: AGHT+IEWys8J0C72NETqC55vyqmXxW6+QIWxx+Seey07j/4IIo8icZ+/rlQ6ghZ1ziJpIUdGrAfANpZbVc4TQKrQDlw=
X-Received: by 2002:a17:90b:1c04:b0:32e:d600:4fe9 with SMTP id
 98e67ed59e1d1-3342a20be0emr8158451a91.4.1758889571403; Fri, 26 Sep 2025
 05:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758859391.git.zhanghongru@xiaomi.com> <000bce8f11d06684f70a29705dfd417747475b1a.1758859391.git.zhanghongru@xiaomi.com>
In-Reply-To: <000bce8f11d06684f70a29705dfd417747475b1a.1758859391.git.zhanghongru@xiaomi.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 26 Sep 2025 08:26:00 -0400
X-Gm-Features: AS18NWDVkDtCF6-U2g1H_ZHnjJmLvgakys0oOfyAF7DD3QET6slT2Rpk4YbTFw8
Message-ID: <CAEjxPJ7CgZT2r9bMYnyhHD=WfG5T-vT21x0ZYKp0Gz9TJo_nEQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selinux: improve bucket distribution uniformity of avc_hash()
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 2:23=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
>
> From: Hongru Zhang <zhanghongru@xiaomi.com>
>
> Under heavy stress testing (on an 8-core system sustaining over 50,000
> authentication events per second), sample once per second and take the
> mean of 1800 samples:
>
> 1. Bucket utilization rate and length of longest chain
> +--------------------------+-----------------------------------------+
> |                          | bucket utilization rate / longest chain |
> |                          +--------------------+--------------------+
> |                          |      no-patch      |     with-patch     |
> +--------------------------+--------------------+--------------------+
> |  512 nodes,  512 buckets |      52.5%/7.5     |     58.2%/6.2      |
> +--------------------------+--------------------+--------------------+
> | 1024 nodes,  512 buckets |      68.9%/12.1    |     82.4%/8.9      |
> +--------------------------+--------------------+--------------------+
> | 2048 nodes,  512 buckets |      83.7%/19.4    |     94.8%/15.2     |
> +--------------------------+--------------------+--------------------+
> | 8192 nodes, 8192 buckets |      49.5%/11.4    |     61.9%/6.6      |
> +--------------------------+--------------------+--------------------+
>
> 2. avc_search_node latency (total latency of hash operation and table
> lookup)
> +--------------------------+-----------------------------------------+
> |                          |   latency of function avc_search_node   |
> |                          +--------------------+--------------------+
> |                          |      no-patch      |     with-patch     |
> +--------------------------+--------------------+--------------------+
> |  512 nodes,  512 buckets |        87ns        |        79ns        |
> +--------------------------+--------------------+--------------------+
> | 1024 nodes,  512 buckets |        97ns        |        91ns        |
> +--------------------------+--------------------+--------------------+
> | 2048 nodes,  512 buckets |       118ns        |       110ns        |
> +--------------------------+--------------------+--------------------+
> | 8192 nodes, 8192 buckets |       106ns        |        94ns        |
> +--------------------------+--------------------+--------------------+
>
> Although the multiplication in the new hash algorithm has higher overhead
> than the bitwise operations in the original algorithm, the data shows
> that the new algorithm achieves better distribution, reducing average
> lookup time. Consequently, the total latency of hashing and table lookup
> is lower than before.
>
> Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>

One minor nit below but you can wait and see what Paul says.
Otherwise,
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/avc.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 7a7f88012865..fc631d1097bc 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -146,9 +146,24 @@ static struct kmem_cache *avc_xperms_data_cachep __r=
o_after_init;
>  static struct kmem_cache *avc_xperms_decision_cachep __ro_after_init;
>  static struct kmem_cache *avc_xperms_cachep __ro_after_init;
>
> +/*
> + * Advantages of this hash design:
> + *     - Minimized collisions: Different inputs won't produce similar
> + *       contributions
> + *     - Bit diffusion: Each constant effectively scrambles input bits
> + *     - Mathematical guarantee: These constants are theoretically analy=
zed
> + *       and empirically validated
> + *     - Complementarity: Three constants complement each other at the
> + *       binary level
> + */
> +#define C1 0x9E3779B9  /* 2^32 multiplied by Golden Ratio, classic const=
ant
> +                        * for Knuth's multiplicative hashing
> +                        */

Personally, I would put this comment on lines above the #define rather
than alongside it since it is a multi-line comment. But you can wait
and see what Paul prefers.

> +#define C2 0x85EBCA77  /* Large prime-like properties */
> +#define C3 0xC2B2AE35  /* Large prime-like properties, MurmurHash3 const=
ant */
>  static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
>  {
> -       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (avc_cache_slots - 1);
> +       return (ssid * C1 + tsid * C2 + tclass * C3) & (avc_cache_slots -=
 1);
>  }
>
>  /**
> --
> 2.43.0
>

