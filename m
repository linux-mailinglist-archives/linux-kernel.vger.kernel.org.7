Return-Path: <linux-kernel+bounces-873877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E35C14FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC8A42614B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D283224B1E;
	Tue, 28 Oct 2025 13:48:14 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D296C17B506
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659293; cv=none; b=nRAHVTR0zobPc/5kZNNG+oDEEHB2k1UpG0oV8AFw6oQ9RDzv4NyS+g3I/1nng1knmy59fEkBUCfoZr7ItX8UxlKClu++WuHyXathmcnV/Z5pquiW+EbupX9CYte+RvzMJCPi+5Ypq3E51oJ98BQsOLfTTNfvyQn2gTRz3UjS25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659293; c=relaxed/simple;
	bh=mo9APOFetC+o4+E2vl8lwuxRbZ/PNfLE6Ac+ecHV1dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVwvbMZKUkvWwmQLer0zk3ax0vcW5QeAbDlUDlWPbnGSYnKGcDrF7SciQ85lR7diIqVFA4xCTBLDGkuyX2b5NwU1vVZ0IbFp2Jt4Lpih9Mvq7v5xqPbI6MRkBD4n9lvBJYCgUJM7Oe0NRSIskKPysqT1U0+t8zlFQByAEoV36hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63d8788b18dso6481954d50.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659289; x=1762264089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPMFTXsnoNZjm5dyqceKxk4gXVUdwjZcnDXHEFYHIA0=;
        b=sf0h+spCesqMCguNs4zXa59aX69WJAf029me9ZJRna/f3dC772IgGgd2xRAFTw/E6h
         CX6+VBRDZFYm9Xf2o+KIBHOQixcxumD9VAf/htbs9s+P7HgUxw2cJs+WwgUxdQB0DIQp
         J5dyw5eCCJ2dgoaHRf+p6XNJvnTttMHrgFAiX+FTTbO4FWeJVdjxnMed1IhHFA5BrXjn
         KoAb7rW2hc2RdW9UL+HzAjmrQS/xc8K9KQFXLZz58hp42B5XgR+wT7FIVCD1qbN2PbPd
         Kxg82+Up/rYytkJBUFV5Kv6Ygv3XKMkHXdPMwXF3zF2EYuGRLNu+0Sa0q6g3fdmyEP3j
         oElw==
X-Forwarded-Encrypted: i=1; AJvYcCWPOy4ZOqPcBJ0Tfd0ydfqpcWpvRAR4p8RXGD8+TkUDxU6i4v4Nn17ZjIFSHy9w9eICNUJnRnYfXak6pls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSJZEwFYe3zyPmpk/0hrI/qb+ebXBOLKpNKOfEF635nGkhARf
	J7bJ1V6aIEE7N5JGIt56+p27WSZyY3+N/ZSzz+q0qkfBnVghe3nokVjVeGokXEIB1cIHGMaUyJY
	3gAY6vRKXImhS4gwamC0kXKsQnROAWKc=
X-Gm-Gg: ASbGnct8Fr6YC8i4mtHBs05rn3BxFD8+LBs+sInXgKr3CrDUHYHDwEYM07wnCSl3u/G
	48cUyf74lQzvujRsEJoXHGkTApOsZhbZhlrwrHD7KJCiq1FzeSdsZZvTMKHiWdgVEucpWLoHstD
	cBGE2tb8vSj1K5tSzxWIHCIz/HBaD0T+HQbnmIeUCtFkqjRQySv2yGfHEVmCoipsygau1PdkAIA
	uiH446ugQAHar4K9KWHdrjrJumJzsCtnjg6NmWIGOOmt6hA7wl3evhJ3wlp6FjydHRFVZzhaw==
X-Google-Smtp-Source: AGHT+IEpad4qjzXZnnPUSnxLHEvfwEEW/p4NMzrGRe+eVIllVRD+MMw8/uUDVMbqy8K2DcaFli6aaeVoXMtxDLr8VQw=
X-Received: by 2002:a05:690e:42cd:b0:63e:e9b:6220 with SMTP id
 956f58d0204a3-63f6ba95f0cmr2455437d50.47.1761659288840; Tue, 28 Oct 2025
 06:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915062135.748653-1-zhangpengjie2@huawei.com> <651ffa3f-9098-4d00-877b-d22e3e8cd64a@huawei.com>
In-Reply-To: <651ffa3f-9098-4d00-877b-d22e3e8cd64a@huawei.com>
Reply-To: myungjoo.ham@gmail.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
Date: Tue, 28 Oct 2025 22:47:30 +0900
X-Gm-Features: AWmQ_bk23k_KI096SoA9euoBCAKpEylPGoxdr43SmVwRmbr5t2KsgoFftr8vmtY
Message-ID: <CAJ0PZbRsH6DcDKHhYGDktg-zejfWafnRR-DHrp8Zw89ervh2HQ@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: hisi: Fix potential UAF in OPP handling
To: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, linhongye@h-partners.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=EB=85=84 10=EC=9B=94 27=EC=9D=BC (=EC=9B=94) 11:28, zhangpengjie (A) <=
zhangpengjie2@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 9/15/2025 2:21 PM, Pengjie Zhang wrote:
> > Ensure all required data is acquired before calling dev_pm_opp_put(opp)
> > to maintain correct resource acquisition and release order.
> >
> > Fixes: 7da2fdaaa1e6 ("PM / devfreq: Add HiSilicon uncore frequency scal=
ing driver")
> > Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> > ---
> >   drivers/devfreq/hisi_uncore_freq.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_=
uncore_freq.c
> > index 96d1815059e3..c1ed70fa0a40 100644
> > --- a/drivers/devfreq/hisi_uncore_freq.c
> > +++ b/drivers/devfreq/hisi_uncore_freq.c
> > @@ -265,10 +265,11 @@ static int hisi_uncore_target(struct device *dev,=
 unsigned long *freq,
> >               dev_err(dev, "Failed to get opp for freq %lu hz\n", *freq=
);
> >               return PTR_ERR(opp);
> >       }
> > -     dev_pm_opp_put(opp);
> >
> >       data =3D (u32)(dev_pm_opp_get_freq(opp) / HZ_PER_MHZ);
> >
> > +     dev_pm_opp_put(opp);
> > +
> >       return hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_SET_FREQ, &data)=
;
> >   }
>
> Gentle ping on this reviewed patch. =F0=9F=99=82
>
> Thanks!
>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

PTAL, Chanwoo.

