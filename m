Return-Path: <linux-kernel+bounces-794036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3A1B3DBE2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F62189CAA3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092FF2EE272;
	Mon,  1 Sep 2025 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aCTGUFsX"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35822E091B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713969; cv=none; b=RGd964gnJyhGD5aokhyWQ1VKRScps2Kdq0jWpG+zFUzt0DO9IHTQklBl+lSl8iZVVWII/8V3cCNViDWb9xfNKq9c2pGIBsvI270MLi/Xp4UUdeCgQXRD+hDyWhO3ulvHSBoOiXIxHRdYXBxG60flRqyo/DibVz4GCt12lm4LiYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713969; c=relaxed/simple;
	bh=qAL+Ft8jZKINEz5jqSKOTaXOoS9hZhZen+9WCiONySg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4DTWhjr2meWgU2973hKZ6voA/5uJp8uM1iaK8xxvwgHT2IEFTewQiVqzRtShRhbTjWfvY9x2TMVOHDLYpPClx+2GLu0CTg6gZJuKYbdr8VXd7vYsGBdBY/W21i8i9A7+R7YTLZdntGFnS79XzRQWmBb1Z3zeTxHkug+dEtJ3DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aCTGUFsX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7a16441so624751466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756713965; x=1757318765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAL+Ft8jZKINEz5jqSKOTaXOoS9hZhZen+9WCiONySg=;
        b=aCTGUFsXp+rQl2HG/PLevcug8U4r+2TqlUlXaqIyiOoX7s6o3wlsv260YN2HekNAo6
         qXgmXgjIQNDegsAbHwI5lKmB/kbSkWAHcx3ZtCl/XPynNtLjjrWUClDoQ+0ZtsXGD1pq
         QfoyM6Y6GwCrUk5MncPIfI0+OGsLy3UlX0xAkQ3unls1RgT8Ex41SRX6pt918ayRqmwo
         RxgKCOQcmZUmfyHOA3qN46bxYoJIOc0iC9M6mTwDIqt2HoX87+JTmGsc/Zu8cp2O8HVB
         8MQMtHCeS7I2s5jxrLwNMFSA8wYnw6AOMCB9U7gpnqAWFWtlHVp0ZQV/cVUr56ADYrzh
         Jrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756713965; x=1757318765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAL+Ft8jZKINEz5jqSKOTaXOoS9hZhZen+9WCiONySg=;
        b=dXouuh3duMBhsdABzyyeiXp9ThJHl/ObAiJQLmyp+ajCBIAqL4E88QRTeCB8NBFinA
         e0iTOxmppgeRWdkr01GgNPrwH41gk/iNCNZ47wAta8OhHJ+V0XrFqpsRhDrkHo10AJtb
         K9sXDObY7JcGcXGSc7JU6ZHuMUAFnOSXmoUtvD2OUbS0Na2JoZ+zq1FJEiOyFtH6turl
         Ddw/FFuKpqJUKarN6RYjyol7U9zaFmv0UfF1hYBKmB0D186xkMS7r3/pz/ZYHtgGq4Dm
         M/rmRmM8EwadQReZw86GJ6LWxcvcTynmKdNxlSHg4DkFO5D+F03j070a5siScBKi7wWC
         fAjw==
X-Forwarded-Encrypted: i=1; AJvYcCXRbRWkUdjwdZt9cJAUTa1jeQ3oz+ZU7KVkJyAvZTuTxZBbEPws6dPLUGwLGH7FSx2NBpsFPIN9J82jdoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBWDmh7yIEd1KfW8ebAO96x4+r+RcUKmEDWAOCNAwoN+c/bYFv
	1AUuBy0gHOz4iYagTduDTrvMG/q8DFv2opoP2q0P1nwAlptoo+6lUKTxKmR0PYln8kfLlvQyEjT
	vbCRqnwNKyb8BV4X4doMD4Ighy5iMvmUYCO8oxC/7eQ==
X-Gm-Gg: ASbGncvyDvqp0vVt/kCons81X02YNpi7Qq1k533sgd3yL909CCEktCHvJDlu8Rg55Ch
	OvZr7wOOKpKfGG0AkMJC7/EvrLPF09kcZk9QgtmRckpEYRIb3gsdbbdRadFA+TuX8iIS1oJA5uC
	ys/ZdB95KwpbysECTGDDL7tUvKuncy/boX7L9RoaPNFjokmMdT8O5h2tuRaR04/1/ZY/UFL0FTi
	JFx43HW42VoyH/kYKAuQOm1V3USXznFzsSgTR3XulpsoA==
X-Google-Smtp-Source: AGHT+IFK/vpnhnC8MFCfb2PlngGVphNQ4y6sY8x+yQGgbEfQ7yDgJFs09MGa/LJUiNzBGyccnGU+5pXcPn0H2ulkhFc=
X-Received: by 2002:a17:907:7f89:b0:afe:d62a:f053 with SMTP id
 a640c23a62f3a-b01d8a322c4mr662439666b.10.1756713963933; Mon, 01 Sep 2025
 01:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com> <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
In-Reply-To: <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 10:05:53 +0200
X-Gm-Features: Ac12FXxX58JRZPaOdEl4T5aT3e1fpiWibxYF7xAAx6MHZtWjPDWsooQ_zsQAR-Y
Message-ID: <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer parameters
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:33=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.nam=
e> wrote:
>
> On Sun, Aug 31, 2025 at 11:39:07AM +0200, Max Kellermann wrote:
> > For improved const-correctness.
>
> It is not a proper commit message.

I believe it is proper for something as trivial as this. I think
adding more text would just be noise, only wasting the time of people
reading it. But that is a matter of perspective: I expect every
competent C developer to know the concept of const-correctness.

Do you believe the commit message of 29cfe7556bfd ("mm: constify more
page/folio tests") is "proper"?

