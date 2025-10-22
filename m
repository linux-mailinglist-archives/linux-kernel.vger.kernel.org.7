Return-Path: <linux-kernel+bounces-864637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F84BFB3D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFF77356444
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE85298CC0;
	Wed, 22 Oct 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENB1m3/v"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4017332C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126919; cv=none; b=PsVDpjdko+Rlk38mYkyet+1S12bCDyzq93wbiXMvKobZmrmCXgNURCBUOx9d480C5aB0as/jiSUCuifPZSGfROx2Ivn9fUCPQ5psa6OfApdWdH2SbydxwmRRsdfvkRHUrOIua6KxemXgvoN1jpJ6uuEFoS7HPoOTrkneJe6FJiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126919; c=relaxed/simple;
	bh=XeYB2JwtpQj2Btzo7f+DaLITlP5o8s5RO60AJri+k1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QT/AHBxiNrdV2kjh0JNrlPz8LIjN2NLyA3xgIp2vIfPzDMp5gMLjeh6NHChRXo16qIheYelImEfSGaAIgyCnxZwKV2+SVu8uFnJDpIDFeT8xX5r4GMonUABkjN2xb6d7+I5qhvk8IqQDs2lKXgH4qh/JwObTDIdAFUPWbOkE6Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENB1m3/v; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-890deb84f95so723228185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761126917; x=1761731717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTt8+FqwI8Ns9wpiK4xWzSI+WicFqajXJHIJZoU9cx8=;
        b=ENB1m3/ve4gRk0jgbD0Lix0ihJyOhF8ta1lBXt+MeuDoxJ3TL1HNSqcAsykN6koBnA
         jF/zlXnzIjkwXWMIbZwaxVV4G6Va89oSFaCUBH9TMeAkXqXhm/qi4YBwB2sTh7vurar0
         /WoJK9LulqWCACYjgE/Jouknp2UlnqFRIt+wQLVV3ucNFSnpMkuf2KPCESeUlXWNhvFa
         aDXqetPtnmB0mn5fZMDuz1Up8s2bsJZ+d/jS+vv17LKah/JkvOJIenSISN4IZfW05esi
         WltaVauRx5+NHJKinJ3GO5jwrjBNmT7+nGLr9+EAEimX3sK/4Vw7i66pReY3Y/4Y9SEY
         MEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761126917; x=1761731717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTt8+FqwI8Ns9wpiK4xWzSI+WicFqajXJHIJZoU9cx8=;
        b=VsLpR3HZYwyb3MBpgG6CFQ36gazeTNCpU4NwUb9rSGQkyqfcLjwe8mbkVlSWSjhDgq
         ajcGmM42WHtxupF5h10460pTCyd0UshI/xYznWCDqOKTLGcs6leD2+IQcdgYLbsFIAlE
         UGV3qkxZAHBm+PCyyOKRrH33IkR8sfXX+Y8+gJOrjBEJb0SRp7Dlsm9BzPpMKd+k7WZj
         Tj5zxl5deWH86JvXo5kQDKzmOg+saXhJpbouLWzZ3EBIsbea2Wsm4/fWe/4llkvs9zPJ
         da89nby+esP4YABSUbsQTOTcvQ9Zo4QKgGTcLgcvyRWqjGX1lD38Fl50AIgAjRXS0W30
         Jg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWul9tj57e7twFtOWlvj3PHxyfZDHkiijncLfjh/WfCwoLToC+WW97VEO4RIBpX8brVUTUNjwh4P3Gne7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7s3S4WOPhMnDun/XrylfcQe42Y8QioWQLkwSOho5JHs0XdERR
	7oBesaou+/+c4Med5w2ZvM8OIGwGKJLBPyLKo27QSSH5IaLuJEHpOqA4ldSOV7Kh2JvnZzY3GSL
	ABZZU9GbLDln7MhMqK6W4If5TgtEZA8Q=
X-Gm-Gg: ASbGnctUdS7HuFHEm4e5c5EzHnCdV2jn5XxO51Xd+6XptZdSNa0vrzBKutoi6vkhlGG
	mU6LEyJOpVCnxwXCLGIGXkyAxLRXD7iheXTU8fwJMajyKZf/h0NRD8mbV8xCsFMoXxLxY3oZfMP
	IRdlO6Px9li4HsmxVmyEGCz89PI8iOmaX+xTnYOcMQQd9OBjNpf1JeBBzNdcNxa2V7rr5wMxNzh
	3Qx7mHc3lLdnIOJh3nwtkHuuM0d+Eezz7GdUbb3+/bv8eA4ByMjRiNtDb82GL7dNWpbd9lXfocy
	0si4cOq3+JIJ7YCB3iJU9S5ysKg=
X-Google-Smtp-Source: AGHT+IFyP3YEd3jiEXUOevWyPggxevKHk8IGuxzG+Kc4aIoWgx3n9rH56kmrDHtPes/bm55BDKJ06bfA1HQys3hLS2I=
X-Received: by 2002:a05:620a:1aa2:b0:84b:97c2:4f27 with SMTP id
 af79cd13be357-8906dfded57mr1887986085a.4.1761126916473; Wed, 22 Oct 2025
 02:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
 <20251013092038.6963-3-ying.huang@linux.alibaba.com> <CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
 <87a51jfl44.fsf@DESKTOP-5N7EMDA> <CAGsJ_4zPH0fwBOLQwh1y6jG3tCXHLGRCTyVVSCWb+NfLCEMV0Q@mail.gmail.com>
 <871pmv9unr.fsf@DESKTOP-5N7EMDA> <CAGsJ_4zW6ogVdi=t9JCuvGD9N21mA_ORXRCakw4Av68d9n+DDw@mail.gmail.com>
 <875xc78es0.fsf@DESKTOP-5N7EMDA> <CAGsJ_4zKGS-Xd-58ufXGoyRfaZWd8wTgv0b6ibHJ2aS14mQqtw@mail.gmail.com>
 <87a51j6zg7.fsf@DESKTOP-5N7EMDA>
In-Reply-To: <87a51j6zg7.fsf@DESKTOP-5N7EMDA>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 22 Oct 2025 22:55:05 +1300
X-Gm-Features: AS18NWC0tC5R_nmZzildYKBiK0mP4MFijg1oZBWOAHCcOJkrnfuDN46LvjeO47c
Message-ID: <CAGsJ_4y32i3aNYPum=8J3_Kt6vOSisr_jg6btB-YG1uQBqHG7Q@mail.gmail.com>
Subject: Re: [PATCH -v2 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Yang Shi <yang@os.amperecomputing.com>, "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Yin Fengwei <fengwei_yin@linux.alibaba.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 10:46=E2=80=AFPM Huang, Ying
<ying.huang@linux.alibaba.com> wrote:

> >
> > I agree. Yet the ish barrier can still avoid the page faults during CPU=
0's PTL.
>
> IIUC, you think that dsb(ish) compared with dsb(nsh) can accelerate
> memory writing (visible to other CPUs).  TBH, I suspect that this is the
> case.

Why? In any case, nsh is not a smp domain.

I believe a dmb(ishst) is sufficient to ensure that the new PTE writes
are visible
to other CPUs. I=E2=80=99m not quite sure why the current flush code uses d=
sb(ish);
it seems like overkill.

Thanks
Barry

