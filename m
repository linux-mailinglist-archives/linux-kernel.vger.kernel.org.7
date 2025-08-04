Return-Path: <linux-kernel+bounces-755702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A02B1AA93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439A9189DDF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E36E239E7F;
	Mon,  4 Aug 2025 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOGVYHlD"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D5226CF0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754344691; cv=none; b=P9ZANCCMV1B36W3E80q9uqzgqpQEkRFYDnGkkJZieJIolHWoW3UrT+0VYQKNkk4WznfAU1rEKPyUdjnZqXx0PjYCPiGEo+KIdVA1YGzuwyciFXy+rDGCpG76pl8d3WZxJ4NFvMHWZjp386Jy7zpXF7P474mz8R/P1AWUYuRB36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754344691; c=relaxed/simple;
	bh=phZmo8auP3zVfADAYrT3k9fDcseX1eOIimkL6q/sHz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G36GFB8USiM4JN7yIbP8KXKlT1znd3hu6D6rfK1knmDTImXuOmZMeHyHCMDabFm/ncpMc8N21j+fBZeTjwTmLHfWJ99Z7hZ18C0Zpk6uqqaqS88rV5C+3ZKaH7H3ImIojhWJTAKakvbDHzTqnoyJy6pL67w3Hn+7h2uPMlhYMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOGVYHlD; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-53945ba7f2aso2169041e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754344688; x=1754949488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phZmo8auP3zVfADAYrT3k9fDcseX1eOIimkL6q/sHz4=;
        b=jOGVYHlD+z7U8gmXZNI26vDydqCd9NYWIBCXodzQjekw+H9k61qUVst0whMJjwxmxM
         1JB6v+S4cEiWEFs0dVOzG1538shZ4jRZ6tTIsXgLdO6264TrEVr7f8+sE4f7vOxvfoWv
         n8YceXu/NMeUGIOY7x1ijiDh8PhAKB4XUTk7robaFCYcwMTGGiRoYzFlkQY2ToBw7Ntf
         Ptja7kPK5+bXjazgIEDz5pA3cKuCtnAQ9W0ytxi5zkjH08s7Ellnoc2IpkN0CcNyyrJE
         rDTbSM6mja81cwtVAQHeplsRUYNozVSMhiinidTlxi/Y+X0zNqPqK0uUzqdSEPb7Nz+5
         Ldeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754344688; x=1754949488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phZmo8auP3zVfADAYrT3k9fDcseX1eOIimkL6q/sHz4=;
        b=SoxJ1/1eOsK2wXd20E5EyoVaXYIB8BAhy3GbKhyD7eBblo/RO1X9TuA9q/AJvd58tN
         AavvkJIDklFfJtTmtWSu1lONUbpwC0HBXBoNAt2+1d0ywSNTrBsTiJepEMbeE7cgFUGo
         zry1Ypsse4sygfx57iOUuR+6B4AL4uc1LfX8KVeXf0QIA3l5/CbvTyEdeEwokwjp5sd5
         OAtmU7BwDq46F0FKvrCwbFdohXw3eqGOIrwsCcBfDiTziZK299MuA5mk94JnGn3cGlQV
         pSEkJ+3kXBPu06aEKJ1gSE/w+0KYmG+OQOJmGmUzVkuQdvhRf+rZ7Lrqtvk4wMT7U/Gr
         YY3A==
X-Forwarded-Encrypted: i=1; AJvYcCVsgZC0AiMvC6sL+VP90J0kLv0QigsedzZwVxW8vfJdPU535ciRxllmHdDhmRxF1vpOV4OTd4fAtT6Ezgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKN2Vi4OW2tUpEESjjpMwpPoC161A/HjEamuKvl1eu2JqbSo51
	QF88N4i5ZNKXI1wJG07RrVGgTZP1MdA/daDmpbE0/sp1ToYo0duwa8hPfWAlA3+rhYitxczPa+I
	0uwyjqNWph1FThMZLPK7lPGrxw3dXn9M=
X-Gm-Gg: ASbGncuwAyv8Xw21as0xxfEftbrFUGUt6eortC6vQqoDMyQYqcJ7LF8HlWiZsnscval
	Jb5G2+ZofRL8oN/oyoltX8n/+HFbY7LXT5selqpoHF14NH/2t1XtqNLtbVUnYTbCPAq5mWtQThq
	e7S9UHlJcj0qmk4W/OU2516SlH0P0n9QYListdTHKarFeA8dAHH5RV9m0Z4AEGqYvAwO04GBBK8
	1+RAaY=
X-Google-Smtp-Source: AGHT+IGfAD+S6/axI2iYnVbYKCPQDEYT/sroxutjW5MwuDrsaywilPtrk/418Wgx5uDA2xg4jzQfTK07V6LqF3Dx+5A=
X-Received: by 2002:a05:6122:4585:b0:532:fc17:7839 with SMTP id
 71dfb90a1353d-5395f0d5705mr5179241e0c.2.1754344688081; Mon, 04 Aug 2025
 14:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724085600.4101321-1-xiaqinxin@huawei.com>
 <20250724085600.4101321-3-xiaqinxin@huawei.com> <CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
 <c7f7d9b3-2ab3-4ebd-99fb-071733573291@huawei.com> <CGME20250724094224eucas1p13a911259338ac1890d4baed8b9998fb0@eucas1p1.samsung.com>
 <CAGsJ_4zSw57DMyRZM24BUdDpbi4+BRfgWUqxSKurCsAVC7Kptw@mail.gmail.com>
 <f8c0cbdc-9c68-46bb-8dad-1d7c80f3f741@samsung.com> <CAGsJ_4zs8=n+J4Xtd=Un8+p3c=FCOTji9qMfBsOKcc8sFG0v9A@mail.gmail.com>
 <c5170042-ac38-b0db-ba51-c5fce5363d40@huawei.com>
In-Reply-To: <c5170042-ac38-b0db-ba51-c5fce5363d40@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Aug 2025 09:57:57 +1200
X-Gm-Features: Ac12FXwU_Fw8azMCD-b6SxxAp3g9GwaEPrqSRpBFjjlK5ZyS0hml8lQvXIGgnos
Message-ID: <CAGsJ_4yXrFVt5UM-6RqFcia8Qhgg6np7+=7ie7xOk1kSYhLH6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Yicong Yang <yangyicong@huawei.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Qinxin Xia <xiaqinxin@huawei.com>, robin.murphy@arm.com, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 8:12=E2=80=AFPM Yicong Yang <yangyicong@huawei.com> =
wrote:
>
> Hi Barry,
>
> On 2025/8/4 12:47, Barry Song wrote:
> > On Tue, Jul 29, 2025 at 8:32=E2=80=AFPM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >>
> >> On 24.07.2025 11:42, Barry Song wrote:
> >>> On Thu, Jul 24, 2025 at 5:35=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.=
com> wrote:
> >>>> On 2025/7/24 17:07:08, Barry Song <21cnbao@gmail.com> wrote:
> >>>>> On Thu, Jul 24, 2025 at 4:56=E2=80=AFPM Qinxin Xia <xiaqinxin@huawe=
i.com> wrote:
> >>>>>> The padding field in the structure was previously reserved to
> >>>>>> maintain a stable interface for potential new fields, ensuring
> >>>>>> compatibility with user-space shared data structures.
> >>>>>> However,it was accidentally removed by tiantao in a prior commit,
> >>>>>> which may lead to incompatibility between user space and the kerne=
l.
> >>>>>>
> >>>>>> This patch reinstates the padding to restore the original structur=
e
> >>>>>> layout and preserve compatibility.
> >>>>>>
> >>>>>> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common hea=
der file for map_benchmark definition")
> >>>>>> Cc: stable@vger.kernel.org
> >>>>>> Acked-by: Barry Song <baohua@kernel.org>
> >>>>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> >>>>> I don=E2=80=99t think these two patches should be part of the same =
series. This
> >>>>> one is a bug fix and should be handled separately=E2=80=94ideally p=
icked up on
> >>>>> its own and backported to stable.
> >>>>>
> >>>>> Also, the subject should not say "Add"=E2=80=94it should be "Restor=
e". I assume
> >>>>> Marek can handle it?
> >>> ...
> >>>> Ok, I will send a new version to fix it.
> >>> If Marek can help fix it while picking it up into the dma-mapping tre=
e, you
> >>> might not need to send a new version.
> >>>
> >>> Honestly, I hope this gets merged soon=E2=80=94it feels like it's bee=
n
> >>> overdue for quite a while.
> >>
> >> I'm sorry, I wasn't aware that this need to go via dma-mapping tree. I
> >> will take it after this merge window.
> >
> > Thank you, Marek! I also noticed that Xiang Chen=E2=80=99s email has be=
en invalid
> > for quite a while, likely he moved to another company some time ago. It=
 looks
> > like Yicong has volunteered to take this on:
> >
> > https://lkml.indiana.edu/2408.1/08865.html
> >
> > I'm not sure if that's still the case. If it is, would Yicong be able t=
o
> > resend the email with my ack?
> >
>
> thanks for reminding. I think currently Qinxin is more suitable to help w=
ith this.
> she's working on the smmu stuffs and help look after this benchmark tool =
internally
> for some time :)
>
> Maybe she can help along with you (ack the fact that you're always helpin=
g to review
> the codes) if it's ok with you.

Certainly, Qinxin is welcome to take over. I will be glad to review
the code when time
permits, although my schedule is typically quite occupied with mm.

Thanks
Barry

