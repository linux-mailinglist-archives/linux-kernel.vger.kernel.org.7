Return-Path: <linux-kernel+bounces-840677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E3BB4F43
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 206977B2941
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808A4260590;
	Thu,  2 Oct 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHS37qy1"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5F13AF2
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431627; cv=none; b=akB0K0fS8HSn/PxITGsWn3deDRAKxtCKaQJ9jE1nfzdw8b+TiDS83jlU4ms2jBZHjdU4JjIjgrY5BozXXoN4bH2heyNYup0a+RV2DO/Pc5jQ9ldhYh2KTFul4Vzd7oTSOVA6VNboS0ds4/c9pytZwrS/nLSVV3FThH9j/Ft2fME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431627; c=relaxed/simple;
	bh=UCBfoH033dkExzACQj33bCiDcdj2i6mdytlYwbQ2tO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwcEHPUngcWkw2WsQ5Zg30rWEip6FqEjTO/QdTPSmTynNJustSLXeliFHb/siEl+BDVoJNkJCBRlIg+ZLEbbAQRghu6NxSisvgsp2NRInBm2RY5ABdQv60p8mAkT8vweeYg3l1/3Xi7h60pUa0H8Pv6Ff2XdHcFHutUDTSJyr14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHS37qy1; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-33ca74c62acso12016471fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759431624; x=1760036424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCBfoH033dkExzACQj33bCiDcdj2i6mdytlYwbQ2tO8=;
        b=fHS37qy1xu9GPt2QWUzjcHCw8QRL7y0iKHuis69FAxoMJwDWrT5OjuLY0bqAkHgzaJ
         /CVUr28sHNDI5l1CxK3LRTiRCqkO2DgBfblCKpzZ5H543HPcNH4LZnpexMHaD+1QYvCY
         nnpNnY0of3PGpeh1bEjotzbq4F48uGTdmOzKOvBNaFMxNW7cBrh/iQK9LH0bPqjnl9bM
         gSFTvY3Fgn1dgGxBN+veY1fJtqr3nHMy+s4aa6obpXCLrhlN3gDwcHpIezm5gcHyvjUn
         Na8DheWVBeC3/2svy8PVIWwuu20sPAmdvfHdwbinmTlTcYhfSOYOFwthrajQ1hgdlShI
         aObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759431624; x=1760036424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCBfoH033dkExzACQj33bCiDcdj2i6mdytlYwbQ2tO8=;
        b=F+ykBuRk/agndBSuyWsRNy2lWHqKmZdAIlw21OFvCqVwLQ4RiZkheml8pWudaGkxZw
         s/CE/110OhIEbTijPdNVG/+FIKNVQorsBbDlI1lBplULV+o3ugF5K95CjDu5eWTTeOWK
         jV9kz9bn9sMoRDZugFxfJ3narDRrONyuRUY6thNdCwzeEkqru8dYCrm/9D1dfQqbLC4L
         Bs2nQe1vOtGJxNaz45W9mpguG7poyr12UgrtySld2VR6VbkybkuiMwjV3fQwbee+CmXP
         6qOj/HjQ0v+AQlKYWKikzXQUVfcgA9NMs61R8uINknuuRAdzAaybeegHggvJ3ykmgpYv
         Twtw==
X-Forwarded-Encrypted: i=1; AJvYcCV+sByQC71hH6D1TePTU5EQwvl5zmpqr+QfFljuRJ/bGnxYWNAAnCsS7o5gYoJaq/7VqJwstG3lxfhdOys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJ9N/gUw8cN3ianQYp82jajQ3PjZJzWVko4u7ruMqvU8JoOYS
	zjGf6o5Lawktyjj2weCBUATKM0Jubql93rW1VXqCMOhSsFVcnl8jigtocx5E5GryGsJr/ysJ7Bu
	ansrI1mWxTpNFAkePi2CjWW5noTEqbsc=
X-Gm-Gg: ASbGncvnloLs9ETM4e4mFc3eBFJYRWysXBIkcmjWuAqSprmCdl8MAciXGZMSXbT+lrj
	dVN0KFBhd94Klo6ypU/oQGKC2t3xGbtOl54HLh9e9IrNeV7KGvFop7yTHgB3bXgiNDjPzIfrNPP
	iJZFjqbyTo6nPmy96D6LblUVftqVE2hFTU7tJmRmQeqEKWyPWBbxfwjZiKqZvFOX2Q2qxbq/afw
	TW+dMt6Yi8ox1ZJ1omPGz/rlrVJfxA=
X-Google-Smtp-Source: AGHT+IEFy3spR+Xmh0KAYNSf79zP8xGVDJIcPWOBgSoq7g0trRMmfKJ4pLF1+fnRfVG2Q7DM3gCOItzEvPFdIfJTjA0=
X-Received: by 2002:a2e:b887:0:b0:372:9ae0:ff11 with SMTP id
 38308e7fff4ca-374c38be094mr619931fa.41.1759431624066; Thu, 02 Oct 2025
 12:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925170942.259314-1-akshayaj.lkd@gmail.com> <20250928104420.72e1978a@jic23-huawei>
In-Reply-To: <20250928104420.72e1978a@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Fri, 3 Oct 2025 00:30:12 +0530
X-Gm-Features: AS18NWCli2B5kkf-OWtioaz1FA_F3BJvy9qr6R_0vAdyjeB5ABfqYwyGa-zrFeY
Message-ID: <CAE3SzaSAowNnKKeitkEh7s0ZkZtTLwmth9g6=9wSh+HSgUFvyg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: bma400: Refactor generic interrupt configuration
To: Jonathan Cameron <jic23@kernel.org>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 3:14=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> Hi Akshay,
> I appreciate I replied probably after you sent this, but the request
> to split the renames out as a precursor that Nuno made is still valid.
> They add noise to the patch and make it harder to review.
>
> In general I'd like to see this broken into several steps/patches.
>
> I've mentioned some things to break out inline but it'll be something lik=
e
> * Field renames.
> * Documentation and explicit field definitions for initial values.
> * activity_event_en() rename
> * Change in how register addresses are obtained.
> * White space changes if you want to make them.
> Ordering is largely up to you to figure out.
>
> So I think at least 4 separate patches doing much smaller things.
> That should make it much easier to see what is going on in each.
>
> Various specific comments inline.

Hi Jonathan,
Thank you for your valuable feedback on the patch.
Have floated a v3. As you suggested above, it is a patch series consisting
of 5 logically separable changes. Also addressed your comments mentioned
inline.

Thanks,
Akshay.

