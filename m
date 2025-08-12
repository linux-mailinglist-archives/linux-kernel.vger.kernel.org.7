Return-Path: <linux-kernel+bounces-763910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86244B21B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9546F1A24AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCED92D3EC3;
	Tue, 12 Aug 2025 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EGhk7LN3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1F813D8A4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968443; cv=none; b=dx3GPTJ2IIaKIjQM3CUeF5LgLQCbHgosTE49J4yhHPFxBK3sRblSO8XjsgVFaP5pQCZyDUvYQ5QKM+ryGjDLGLoIW0GMkNPwkgrxUQeAIzTWsqP6yLaOCN+7CWyuqJMtrgApUQLtS7srjQA4enwDM4zserlX9Xq7U8Fr3lPDBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968443; c=relaxed/simple;
	bh=nUryommIT7kA5DxIUCgPRPw82+zTeAEOA+nOqx7Wh84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYIyn4iJblvpq1ToxlwzT3hQg6Be4OM49aVUxieuGxvjHk4iwYNVytsYeyRJp8aUQvxc0hgGdAaEPENLT3NmvrGedFFMGFgXW2yD7a/qsblTfQDQ676W2JaEAif7yOrSiQyL/RXZH8MDiBUJSpdHBgpA1UN4sOt58DbVMHvJ9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EGhk7LN3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BFjcWk028799
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DkTlVKfVYuPJQlHKCQwVV7GZENK2bWR3hvuKtvF5yEs=; b=EGhk7LN32ZDrwh6P
	UV8aqdgbKK7imYPRTgBdB6tQRbTjbG8wzebZP7AlDFSG7mY55osvOf46uqGiyJY0
	5/HoW3d0OQXRuLz3NqzhPK4VdWTBbFAy2C82Ip2VwL+J8ixvM0zcbvGt4qs0wrXq
	frLA2anr7exqejzk1sdYBshe7vHYoODba2oUyiKV6uyK1CCfpYl9S97769D8aNE/
	Lk/aORziYMad6JF4crv0cCuIgtcmmfY+T0h6BBRyOxlBl5tBJPNnpiRZXpajqcof
	7YwhCAtlaGTsip439xt/4zs7ER4q1V5NiOha3lm5FSK5vJ3UHKBXsJ+VnRIibhYZ
	Pvb7Wg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9spr6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:14:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31f2dd307d4so5151448a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754968440; x=1755573240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkTlVKfVYuPJQlHKCQwVV7GZENK2bWR3hvuKtvF5yEs=;
        b=tsvpZiFas56f64BJSQjusFPDQX0i2MtOLIjHYDakMdu1ipMKd93tvAQ5Y75+7n08Fn
         BYVhsz290OBmGhMhcCVmO22F2DiTmK7zmVksi0HzyWTkWGpby/AD68EwKa2hOZdmD1WK
         ipZsBJKlEkTkY5fXrhhQrI42hKFDKb0roABSF0kAFRfs9cHtfTGIwP5l46eJtj1zWHY3
         pjU+yKsew9BlvBbG1MsCcfJm+nixQdsqp4oAT3wrhxRsDC0+hjOIwFpHtiavyEUWahsi
         H3aWJc7WZn+EJaQ3UgvKCCUJN8KZeBPiLY2+QMvJ9sAijhFIqXhE4ucYagkVWZ+FAJ5u
         tv9w==
X-Forwarded-Encrypted: i=1; AJvYcCXYqz8/nhvEAwfKyxJBeE6rV87/SPPP9RA71omwJIYHvaCIozuCY7Gz+ad3WIZ6UiZhTvgxhBylS1EdZrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtmY/CuUIm8v9tEqQvFh3gWIwf/jjdgbu3IVn2PDJRAeqIAkFm
	U5KE4sBP5o5t0nUINMlsCjkzBjzj0cegxMdguECrOyw/QVs8N23QoGwPnHQUf/8+7Paboz+05T/
	gG8oZwp69WvDjF9RPB1kFwRg832XwOpleZRG1vUJs6UybbK4fnJaPM65hfM9oGVKpTefhq9OgXs
	jnyTsyedjVnNGhkOD9c/IQKtyLe1fEV0eiA887nGLTb1tSKdAwBxnx
X-Gm-Gg: ASbGnctNtUPgWMP6S5bA4hf10FEww6jrU7iN1ZzJNwb9qvQEth3XBZPjtb+qB7eQqYZ
	E57+yRvY8xq0ihvMZsDjFXSr/uCT+aA+g5jlTGaREWaF8pL5L7w+VMN/w0lkXJwqhtOJbqtIbYQ
	L5CUxv2RCvUtaGGvAyDEXlcA==
X-Received: by 2002:a17:90b:2e49:b0:31f:d0:95bc with SMTP id 98e67ed59e1d1-32183c4585dmr18544864a91.25.1754968440114;
        Mon, 11 Aug 2025 20:14:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUiK6dnsViZo/ONR7KmYw+KPZQS6TalkPG/etm+Je1f0NInLqS9jT8UOECE9oao7uSShvDjBNgBEF+aFsCkEc=
X-Received: by 2002:a17:90b:2e49:b0:31f:d0:95bc with SMTP id
 98e67ed59e1d1-32183c4585dmr18544838a91.25.1754968439660; Mon, 11 Aug 2025
 20:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJmjXABrInqumY1-@kernel.org> <20250811140246.3264034-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20250811140246.3264034-1-joshua.hahnjy@gmail.com>
From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 08:43:48 +0530
X-Gm-Features: Ac12FXwsrjZcINNlzWI6lgdmeiQy0GqtD8W4UPHL3OIWUnCskvWeVE_f-N5opUE
Message-ID: <CALzOmR1BoVs4LGaygpE-fiKsRztCh4_tsESyFTT5qiHtup5E7w@mail.gmail.com>
Subject: Re: [PATCH v2] mm/numa_memblks: Use pr_debug instead of printk(KERN_DEBUG)
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689ab179 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
 a=Xl4m31Bx6Sv-n4gzfLwA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: g83KnWMREHSZy1t1dZsxF3l83EKri56o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfXxIJ7rhjdLYyS
 SSe8CgWroUNVHnhuHSWo6VNfjLwlFuoxnWFfpap1dQODoGEqP6V5x6FObIl2ZdNeEA0bPKiqsvL
 JFwCdxDsF6iDt/tQuIFMwaDwsKp78kV/dQV91+jrQf5/IaJoCv6Cvv/iBFgEhD2z7lybnqPIjqQ
 BtR1U6tg988q8X03HfkXwegP5GnYmn469zQq8I396pH8yLjySojWnLTL4CNyEEpTQKDWmRTH9Jg
 Ww4w42RaSnaAJksr8zpbH+2XGDtOuAw8utnIBAYP4Ak0JsUsZQjadOzCWTk78hhij9YRifDNGNH
 UkMq9sng9e1hST9qxCd0B3UmRSxmv/ciujmim1BlqHJNtuRSwXc36brVeCsI+Hpfq+I32ahm6B7
 cOWgVW3G
X-Proofpoint-GUID: g83KnWMREHSZy1t1dZsxF3l83EKri56o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

On Mon, Aug 11, 2025 at 7:33=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
>
> On Mon, 11 Aug 2025 11:01:32 +0300 Mike Rapoport <rppt@kernel.org> wrote:
>
> > On Mon, Aug 11, 2025 at 12:13:54PM +0530, pratyush.brahma@oss.qualcomm.=
com wrote:
> > > From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> > >
> > > Replace the direct usage of printk(KERN_DEBUG ...) with pr_debug(...)=
 to
> > > align with the consistent `pr_*` API usage within the file.
> > >
> > > Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > > Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> > > ---
> > > Changes in v2:
> > > - Removed printk header as suggested by Joshua.
> > > - Link to v1: https://lore.kernel.org/r/20250808-numa-dbg-v1-1-2ddd1e=
c634aa@oss.qualcomm.com
> > > ---
> > >  mm/numa_memblks.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> > > index 541a99c4071a67e5b0ef66f4136dee268a880003..ed6fcfca057ab4c9a8aa2=
6cd1929551b4ded4a5b 100644
> > > --- a/mm/numa_memblks.c
> > > +++ b/mm/numa_memblks.c
> > > @@ -2,7 +2,6 @@
> > >
> > >  #include <linux/array_size.h>
> > >  #include <linux/sort.h>
> > > -#include <linux/printk.h>
> >
> > Please don't, pr_debug is defined there.
>
> Hello Mike, you're totally right, sorry about the incorrect feedback.
> For some reason I completely missed this dependency when reviewing.
> Joshua

While the current patch compiles fine as some other header includes printk,
I see sense in Mike's suggestion to keep the printk header. I'll
revert to my original patch
in the next iteration. Joshua, would you be okay with me keeping your R-by =
tag
in the original implementation?
>
> Sent using hkml (https://github.com/sjp38/hackermail)

Thanks and Regards
Pratyush

