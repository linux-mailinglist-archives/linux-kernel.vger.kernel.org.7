Return-Path: <linux-kernel+bounces-756513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06A6B1B54B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7ED3A9C7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2916E272E5E;
	Tue,  5 Aug 2025 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dbZ8n/qr"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9B2472B7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401923; cv=none; b=WS1jn/fie+bUs2bfZAyVeEkx6QADCwOsgwWzaFV1X9zObpKZNyA3xDl49AzlFyUf56cUtV9BqY/E9m1hAL8kkQOONFIRKnlb/TTH2Q9Fdq+3q9sekRywn1WB8Uk11H+2+4b8vQbmXoxRy+kiWbZQfzV5WNbolkdygwXrKrnVzjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401923; c=relaxed/simple;
	bh=BAZlAyuhsxBPeTusmuo9QTFmObbBL2HmaRovu4+mPcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeXPC2Idh1x11l+TNmpXuGljCpPAIsKgwWADPPNtLfpT8ViwuQYiFgsbxQORDxO8P7a4UjD9V7XErvrQGrb9c4AyKfcEZZXf/6GiGyZeawZGaitI2Ndmbpft6RcES3tKxXCf2asPyjS3H1WhxlljwvI65yiA4tNPw70UTAudg1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dbZ8n/qr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af949bdf36cso563823466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754401920; x=1755006720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hyqP3wgPlxttWz/Mpuh+X6Lo5NUqiC58jKjpmMLgf3c=;
        b=dbZ8n/qrIDsZC1rnwrfH5dvyNOVBPoeaEr9swEaEVfb2CKR8iniTtM9dRdwUodjx8G
         je6QnoQeAZdh6FkHrqZrCE+wGdl6+SRzk/HMTogtkXnh60X5AIeEyb8aIXJ4wKGaRsTj
         oTf87ue6/pAF0DLeae0XVTq3aZj0ZuoQ9zdoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754401920; x=1755006720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyqP3wgPlxttWz/Mpuh+X6Lo5NUqiC58jKjpmMLgf3c=;
        b=TOnrwe9l0bhcJ2OEp3jTd3zFrOYqV50FUuSV7Xjf/T7toOzatgDukLe9q/tOt3+Cvs
         wDqAPrh4qUTtJblNftg1MleG6e95zSoe+FVoJu36HP2zpZtRZeF70Va9WtgWjiJDHi8S
         3JYVr+nu8uhIUwZ1zqko3wOMPoxiJMJhmTgXpqAIWoAntFQ3Q5+tbsGwBtqgYVeXUhWp
         lsVOCFJkWOMFC+jHGDr5fFYODP4wovo9G8Xxe0zAkFvz1UV2NICCJDpCh9dDuMhP6T7P
         t9NMC34iArTgxjHeKhBIsO7/H8A7phcuILL4lQ2P2ukFqxsWSWw1O2d8ifltymVSSt+M
         WB+A==
X-Forwarded-Encrypted: i=1; AJvYcCXwGTFx5zOEujyX1ZJyQcIyKcWQ1zxgZ1B5PcFha+RJPn5CLLYJMlI9Rbw5J3XB/4pAcUSuINZRTM4R9T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwP99aNsSJ7iAHCvfi5QZtpFc8Hx3J0kX/MmoUpfsP9Bos8sUO
	9vyqiCyOWVBM0DH1Wi4rPzpraTPEnlUZAI2/157s/Ud3xrbc+ZIC6i/5WUTwCgHJ41bT9oJjxiX
	eYNPW2KaawQ==
X-Gm-Gg: ASbGncuREnIIrxZt+t6lQJIvKpLJQsO5g38twyfCnBtaRnS9PnAaWhZRwekaVJkGBs2
	9wy5Cw2qimhzix0WxLWCjMgBod6o9GSgL5yvCsRGWrRO3Tx2I31PvNMsTIqotFwzU8WAO2fMfC7
	k6IrCyiW3FgpdmQXhiaDcElFG/or+KvHQHO1n0nCOnkC64I50q++64knn8qFD3mNBujW6RQLZZK
	VePgDH2IhMT2GJyJBY2NCBJNtUvkc6S2Vq3sLwwgmOJwiMTBjbvawHvccDqICGOrJUWRoCBvAFN
	eNGnXaZnnBG8E0OK26/SIw0R1KBx5MmHbvWdbpOSUWXNFSSsIqCBRfAGyhGhw/meUXmXRpNpVCx
	7IFV2oOmFfh2TzNAvyFfmodUBhxy729LTiw7Y9satdGSs/1ATpSWtvvuRU3qfn1XH8yHlSjK0zl
	tG5ieWL2U=
X-Google-Smtp-Source: AGHT+IGOTmCsCBc4ys4uDRpZeCKXERCHJD/Zbym3hRoGpPtsNMJ0PRCMq0jHjdlTVEj2ObHaql6+7Q==
X-Received: by 2002:a17:907:970a:b0:ae0:afb7:6060 with SMTP id a640c23a62f3a-af940017713mr1335935166b.19.1754401919868;
        Tue, 05 Aug 2025 06:51:59 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0771ebsm928019066b.6.2025.08.05.06.51.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:51:59 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so6094312a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:51:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjU1ldqrfPkgAUig9xVI7V5Y9FoA1cBVeuYoOmrr+MVcAFWcbVTZhaWxd5GJF+7TXz6fvTX3jqPNSwOsc=@vger.kernel.org
X-Received: by 2002:a05:6402:518d:b0:615:a2d9:61f4 with SMTP id
 4fb4d7f45d1cf-615e6ef6947mr12970613a12.15.1754401918593; Tue, 05 Aug 2025
 06:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804162201.66d196ad.alex.williamson@redhat.com>
 <CAHk-=whhYRMS7Xc9k_JBdrGvp++JLmU0T2xXEgn046hWrj7q8Q@mail.gmail.com>
 <20250804185306.6b048e7c.alex.williamson@redhat.com> <0a2e8593-47c6-4a17-b7b0-d4cb718b8f88@redhat.com>
 <CAHk-=wiCYfNp4AJLBORU-c7ZyRBUp66W2-Et6cdQ4REx-GyQ_A@mail.gmail.com>
 <20250805132558.GA365447@nvidia.com> <CAHk-=wg75QKYCCCAtbro5F7rnrwq4xYuKmKeg4hUwuedcPXuGw@mail.gmail.com>
 <4c68eb5d-1e0e-47f3-a1fc-1e063dd1fd47@redhat.com>
In-Reply-To: <4c68eb5d-1e0e-47f3-a1fc-1e063dd1fd47@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Aug 2025 16:51:41 +0300
X-Gmail-Original-Message-ID: <CAHk-=whoh31th2awzO02zA3=cv4QNTFjdYr73=eSDDFfW2OdOw@mail.gmail.com>
X-Gm-Features: Ac12FXyonuJzUBEmqvEEu6_0efeGmMOSkKZb1tbtO-JL66T9C00AtXnVqesiMVQ
Message-ID: <CAHk-=whoh31th2awzO02zA3=cv4QNTFjdYr73=eSDDFfW2OdOw@mail.gmail.com>
Subject: Re: [GIT PULL] VFIO updates for v6.17-rc1
To: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lizhe.67@bytedance.com" <lizhe.67@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 16:47, David Hildenbrand <david@redhat.com> wrote:
>
> arch/x86/Kconfig:       select SPARSEMEM_VMEMMAP_ENABLE if X86_64
>
> But SPARSEMEM_VMEMMAP is still user-selectable.

I think you missed this confusion on x86:

        select SPARSEMEM_VMEMMAP if X86_64

IOW, that SPARSEMEM_VMEMMAP_ENABLE is entirely historical, I think,
and it's unconditional these days.

             Linus

