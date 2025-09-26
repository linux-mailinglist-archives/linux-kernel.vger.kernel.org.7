Return-Path: <linux-kernel+bounces-833668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62000BA2992
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28630166CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8025283CA7;
	Fri, 26 Sep 2025 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2Ih5WPM"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5597A283151
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869991; cv=none; b=qmQWb6NAMUfVpwwNpK+O3xvLNOSftrz/JBCN3rxbyYsHCOSFjsq7kXWj7kXQAoveXIQFfC1y1TIOUPZxTin+8VztB18VSVjTpU5NfJBAAZNhPG0JIUQZQYGXZRqp/15Uon/FT3GN/eSm+OIIK3g2nTVNbCFYHIv/NK50Xl6XMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869991; c=relaxed/simple;
	bh=muKoX9Lz4smrQHWPif2rVUJUKAEdAjfZfAB7umr7LbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRKayyOCTBZrQfxiFfcE7nauF3SoEa/1Yrheapowdb4KmuU6OxDxNn9XAfpNMq9kgsbA/WvXGymyNQJ9e8/qTsn4dDVmGooUeG6Ph2UpsLmj8nD1GB60FWiX9+oOzD5MMw7nfD2dNljyD+oSLXpOurRH0ednshsn8KYTD/HiFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2Ih5WPM; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8582a34639aso117142485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758869988; x=1759474788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muKoX9Lz4smrQHWPif2rVUJUKAEdAjfZfAB7umr7LbY=;
        b=C2Ih5WPMxg8nwcISX7v/X3DarZkyHP+KSXKE7Z/ArfvndFiV6P+HGqje4aum7dlBRC
         QCJ0+F8xgRVJI767ABuDEcK6U84MgmSIVmi7/MNwohVNvI1BAF+wp1sNVApEaHoLeCAh
         NWfU+GUaaCH7VsERzF6SsqHzntzcijuMVhWiSy15S8Gs4NBT5xerkunDaFjBJEgD8NXk
         fCYLwFWTDop+fdL9VyD/W849homTRahJX1jPnk1QE+k///XYeCFIPsmCavU+QQXq1vdp
         7Z1liOCmoYqLah4qv8rMYwr+ROwmJy4Ufy2G5wMdpqZ38tw+8KF8m8iY4oyMgjZ+JF56
         oAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869988; x=1759474788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muKoX9Lz4smrQHWPif2rVUJUKAEdAjfZfAB7umr7LbY=;
        b=Jus4gX7Jib19/8aiJrD86mOYDt6SUCF1Kya3oFUfjsVfUpYPqJqQWbJluYxIb6pDfa
         2Wm6cWZO2B6iO+J2sjbuD314HeTM2/bPTYE7lwtN8uhKfpg3Ek68kwYVWK0xvbdUVKP4
         /gAWqGfbHRGzJ1YxZqhVIVtZ+LVis0uasU0Eob21Ip9mpctmXzBzZdkXxDuh1l2JgmJr
         uaCFrVmxQhbukY2FkNoiytJ+T+06Z1F+uZ1vI/dt0s4b63Tx+aAlOgdntB/SVjM+XBAm
         XKu8u39YpbVGoiBQysfJ02eAjemRdPbFMWWJpZiQ6wFazfw4jp9feQnQ7FF/Jyc696t+
         ypGA==
X-Forwarded-Encrypted: i=1; AJvYcCXblJFZ61kqRKKNSgTUHIYc6AoB3B7hYdyxbrzrjR6wWO5mwCjZkYTy1J+t08vKj0L24LPoQYy5fytsaoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinPTf3UjmJ0s8Oass90EK62rJcFm/B1nkTDal/+nhTPfNopYU
	i9CY1yn4kk4NuU07X7zOYwMPtj5EWHVC9+qUdCu/phWKe5VCyO4MzNt91K1YL/2m5HyY2n4CKEy
	ZgNd92elhppGV8aqfPZfkpKQUZM9pIos=
X-Gm-Gg: ASbGncuYm7ncBnOG6lscYG+WpiLlZj1XNP4gq7RAbrZIFLZQ/E85cXx40NP9odEhL8U
	IgsgGx+OZDiPJiTM0BxT1QN7mL/yg3Z+QXkzuIIGYGq2D2vbsULlKxKywurPwKQTgAhc+2FPdzI
	8ZQyHOEaKlKE3+MnqwQ/bM3MotWuQ8D4w2I5TiWzCof83VxgIKz41Ygt4yMQy83vs1ZAyvaMIZ/
	kCD99Hdptj2Cv2E080EP/EJ9YTlrFqYJoSwfUAThbYfKlTG8AMU
X-Google-Smtp-Source: AGHT+IGmsSn5EbyCIHMm8T/GkRc2eWXwzt4uWrfKxttXxzm2Ji9H9SJJpP6ia5juDK2kGvULjyR8pxB990+cvb4nKmw=
X-Received: by 2002:a05:6214:242d:b0:817:2871:ae7 with SMTP id
 6a1803df08f44-81728710da1mr38870616d6.23.1758869987803; Thu, 25 Sep 2025
 23:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250917011807eucas1p2dc0c24ef4ad8effcc1a2174d54cf4161@eucas1p2.samsung.com>
 <20250917011759.2228019-1-xiaqinxin@huawei.com> <11183850-d6d6-46c9-8079-330bf4c541e3@samsung.com>
 <CAGsJ_4yno_a2vD9OHhruXbNOXuVKg97NcOdFHpe283FJ9hXL7Q@mail.gmail.com>
 <0c59d099-4844-4fb2-80e0-6d3fc0077985@samsung.com> <ae8a2c37-74db-4e53-99c1-fc7f86e80253@huawei.com>
 <5900de48-e4a4-45cc-be7d-c906a59ba04a@linuxfoundation.org>
In-Reply-To: <5900de48-e4a4-45cc-be7d-c906a59ba04a@linuxfoundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Sep 2025 14:59:36 +0800
X-Gm-Features: AS18NWCN7qHj9Kdjnu54T4fQm519m89ro2y5SacOuc8hZbm3jQYVG4sH7Z8MwI8
Message-ID: <CAGsJ_4yrm_3ZftZtYZ==YsEt14OR+t1FkVNzLzYjPxqXNdeURA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself and Barry to dma_map_benchmark maintainers
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Qinxin Xia <xiaqinxin@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>, shuah@kernel.org, 
	robin.murphy@arm.com, jonathan.cameron@huawei.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	yangyicong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 6:09=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 9/25/25 07:11, Qinxin Xia wrote:
> >
> >
> > On 2025/9/22 20:20:39, Marek Szyprowski <m.szyprowski@samsung.com> wrot=
e:
> >> On 22.09.2025 01:50, Barry Song wrote:
> >>> On Fri, Sep 19, 2025 at 2:17=E2=80=AFAM Marek Szyprowski
> >>> <m.szyprowski@samsung.com> wrote:
> >>>> On 17.09.2025 03:17, Qinxin Xia wrote:
> >>>>> Since Chenxiang has left HiSilicon, Barry and I will jointly
> >>>>> maintain this module.
> >>>>>
> >>>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> >>>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>> Thanks!
> >>> Marek, would you rather merge this into the dma-mapping tree
> >>> instead of ACKing it, or would you prefer it to go through
> >>> a different tree?
> >>
> >> I expected it to be taken by Shuah, as she is responsible for the
> >> tools/testing/selftests/ directory, where the dma tests are still plac=
ed.
> >>
> >>
> >> Best regards
> >>
> > I'll send V2 in the next version to fix some of the review comments of =
V1, and maybe there's some discussion about V2, I think shuah can deal with=
 the patches of MAINTAINERS first :=EF=BC=89
>
> I can take this patch through my tree. Are you sending v2?

Qinxin mentioned a v2 for the tools/dma modification[1], but there=E2=80=99=
s
no need for a v2 of the maintainer patch. Could you please pull this
one into your tree? Thanks!

Qinxin, could you please avoid mixing topics, as it can be
quite confusing?

[1] https://lore.kernel.org/lkml/20250814133527.2679261-2-xiaqinxin@huawei.=
com/

Thanks
Barry

