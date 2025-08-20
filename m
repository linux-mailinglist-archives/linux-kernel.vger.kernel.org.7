Return-Path: <linux-kernel+bounces-778382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4CCB2E4CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D38F5C22F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499562749EA;
	Wed, 20 Aug 2025 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+dNMrzK"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C03A21B196
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713866; cv=none; b=ZNkfZBDcQGXydJNukYN2j7dCr2PseBRpzs6l9eEx+RmUC6LS6IjpZVC1yJNaHL1fCLz3eT+PiBtUDxTYyANpEbAgEX0YGQquP/UjRsXMu50sVBoQyjjsbZ+G5KScCTmvO2WNpq7wHI6cETAZ6cyFW6Nqu89bxCuu87VMrG+erfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713866; c=relaxed/simple;
	bh=N5Bk5OxkSMuiaobpiDeJJlqEjFgZoPv4eljrayG064o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UM4tlusU1JZ8L8pnYFlN2TIgTsUVWUHyHIa991XZ1dUnk4XGg4BeISI+Q6BFWdvX+aOI6M9za8dFUF+Jqg5t0waNdqABIsv3h8jcnNhJnkdPaj3mycMYjIafAhfFh4KNT1hkG2MStanEvBsRCMOhjHt89orex85kzOWJn1vqBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+dNMrzK; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-435de5b2f29so84828b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755713864; x=1756318664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5Bk5OxkSMuiaobpiDeJJlqEjFgZoPv4eljrayG064o=;
        b=g+dNMrzK0FpE8nQSBhCTyYQlpdelii7vsrmECodzkKYH5FEtc4Bn5ncnfej+bziYMr
         DiBD4KVGpA8x9NVvh3iFR79RjS/FLL2KnSzukaQ5WL3cWnX+ILLsOcu1tHVYvaKCOTlH
         7sIqmoc8+xrHrGcqPtcF3VltwE+1McxFHl+opKiSVbN5I9B6HyftTxkNkFEkpw2wtc37
         +jHJr8DTUBR3qhrq0SlJD99CdXn+bctPhHBimJQ6sa5npuTNLFzQQyRUoAlYsEY86zMX
         DdrOfdiy1tQ+RTgdUHgCxamSGuC3/UbEMW/dJxdXXDhRgJzDtF1LkPbz8npP1NMvR4nH
         8fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713864; x=1756318664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5Bk5OxkSMuiaobpiDeJJlqEjFgZoPv4eljrayG064o=;
        b=DHqe/52m/SgX+I2qNo/GVCcbTGbVleen1J+HsdGstx0vXkKQmZMa9zY10B0LonDF35
         wRFg1OuCHsh8fS22bzrjEgUjyS/nue0mNzqtgW2h+vdUXjZRnqisTGPlch30d79i7xCs
         ceVMdjzs8gZTm2sjf/x05Iv0r4RvGhzClODlwvpYn1W8SvGCnOUHkNUcrV5RJ9I/2X8S
         4WCA/wxzbU4jHeXCQp0XbRnBdnlM1HrJr4j8RA8+zD9W7ObIXmt49r3gU468Ku88pjXe
         U5KEWMnnAU7REPsXzUELsBKopwdBK47IRT4WuY3Kj2CFxB4/eRHtj87RquxWBlFYHwjk
         Frrw==
X-Forwarded-Encrypted: i=1; AJvYcCWtvYRsVAF6scTMd8fs2CyVXHrMo7f1bYJk7AcaMNY7UuE1dlatpdGw9oqgw+fAYYWqdz8nJXvre733NNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyohdZsNDKSM0iD7qvJq6uECvXWXpnGMEy66aYhaiLD7jDK/0af
	IcdaNVvyvaip1hmKlp53I92BM9KjH0sOc3FN30utFSaSVwowyS1KMciKntKyD2zOm1A/f/mlZH8
	nleDxy4EC+S59m30MXJJCU4NR/H5KAbGFG903
X-Gm-Gg: ASbGncs6onpCRBWHAl7zziHrkDSgvVW6+2fIGW8mcBmY1RZGYxbvSpefg/ZCLMETAMM
	sj+utdjwqqqVATFScovjZ4fIyUp/tJmzvJaeJiclN0MgJ2mtgObP9wRcquRRVU0TxNmpP0aRAVU
	TClyljkWWQdau4b/Kwf/D2tmb8uVVWKZm42JNnYq0SctmXh9wibz/WuigJmLVtCNmwOIKXn/HTz
	Jwe
X-Google-Smtp-Source: AGHT+IEH/Svh5byZgF0lg0UtvV4QpwF3FhMZi3CbAiWHOFHIihgLFfGRk4aTulk8olNPXy/a7SRMpJ9JzsFf3U1sEoo=
X-Received: by 2002:a05:6808:8019:b0:437:761b:dd0 with SMTP id
 5614622812f47-437761b1229mr662154b6e.47.1755713864303; Wed, 20 Aug 2025
 11:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820181547.3794167-1-nphamcs@gmail.com>
In-Reply-To: <20250820181547.3794167-1-nphamcs@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 20 Aug 2025 11:17:33 -0700
X-Gm-Features: Ac12FXwSq2-tyJGkbLsieRu6fWZxzHdU51wsdwtJjSvt8fXzTPagLi-PWpP_Nhg
Message-ID: <CAKEwX=Mq=EtxhnKhNQ7ZdK18wU9hPEarLR1NhsgB3hm6G-GRkw@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: reduce the size of the compression buffer to a
 single page
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, yosry.ahmed@linux.dev, chengming.zhou@linux.dev, 
	herbert@gondor.apana.org.au, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:15=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> Reduce the compression buffer size from 2 * PAGE_SIZE to only one page,
> as the compression output (in the success case) should not exceed the
> length of the input.
>
> In the past, Chengming tried to reduce the compression buffer size, but
> ran into issues with the LZO algorithm (see [2]). Herbert Xu reported
> that the issue has been fixed (see [3]). Now we should have the
> guarantee that compressors' output should not exceed one page in the
> success case, and the algorithm will just report failure otherwise.
>
> With this patch, we save one page per cpu (per compression algorithm).
>
> [1]: https://lore.kernel.org/linux-mm/20231213-zswap-dstmem-v4-1-f228b059=
dd89@bytedance.com/
> [2]: https://lore.kernel.org/lkml/0000000000000b05cd060d6b5511@google.com=
/
> [3]: https://lore.kernel.org/linux-mm/aKUmyl5gUFCdXGn-@gondor.apana.org.a=
u/
>
> Co-developed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>

The syntax changes very slightly, but this is functionally the same
patch as Chengming's. So I'm keeping all of his credit - please let me
know if I miss any proper accreditations. :)

