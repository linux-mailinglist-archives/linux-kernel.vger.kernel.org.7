Return-Path: <linux-kernel+bounces-836466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82B5BA9C54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923DA1670AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA96830AD09;
	Mon, 29 Sep 2025 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HrtFj6GF"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A919F40A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759158962; cv=none; b=VyQfdHvk6zU2IL40oJbAKRAiYn6jf7h48HZIUwXeaLt/ABBd9VsaIQVpbsbqhCIUyVj46s4LhfY0JoLhr08cedtlvZKQ9U/ke80DgFxm90Wr9cUmiTEKSBpEkBjNisj5zh7Ql0Xdcj6RgB1FWaZfgszzTQlAiHnEpkRbYRYeUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759158962; c=relaxed/simple;
	bh=s/sM16Xn22YlRk/rJQys09orRj9V/SO0vq5qei3iVlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfENbmAVOmRyDMlZjL+g/IVN+HGx372JpWMgsYQO4ZWwXfp0VY0jmLBiCBUYWmp281KmP97ozlDo2JO2BGUs4o0M4b73VOe6D6JNpi6Wz2VI5VHEHiYDZDddczBicCFztvynSpMPPS71eKsgEH2wPzDkMGUVUnhqGYQZX7aYJcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HrtFj6GF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e3f213b59so135945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759158958; x=1759763758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pkhN2ukYJYto1i2+aNs4By9tc5QGN3dIe+1Mwb8VZY=;
        b=HrtFj6GFUHLsHG5qEuFgQt1REAb5GyhW2aycM8Vd+N+w9OdrbBXqOElml9r5AMlI69
         NQm+HuLagvODjy2eFYriEibbah7aKrxHl45bbpRg8YxWEZF13GG9Op6o5f2DmDXI//H5
         5UyxEXJRYmxDn+bEO3TQ4+hcqh4r5zRVipEsanNEhhACSDDR2TwAc1sb6d1v71lt8zHV
         2afUhVy7Zd8lvGwzAvLZpf5JQpTncXUOjhMlEonsqdrQAVtAPINA3+aiOYao7Xfsm6ky
         2kttT8XrBH76oGmm87JM5izcPsP6cXMAxvNZok3/S9L1fXuSTJvIpk9onXjjvawZht51
         L/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759158958; x=1759763758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pkhN2ukYJYto1i2+aNs4By9tc5QGN3dIe+1Mwb8VZY=;
        b=A94b+n9PLwAw1b5v41KMsYplaHxnWOgWQKTXkk0IQ7qWNG7IcPDUrr8W3f+G39vfPz
         kZdhik0RT/VB7MPupO3M8jXhSBqlsVcgd9iBJRRbfo4a1mUH+7EMQitRot6jAabOQcW9
         dmugBuPRD5w8oE0Dn2OETg+CFIVMYRgDX8tPjUZwkVSXSJ32vL+KD9J1BT/sO7uCJ+ly
         2wEfaRRMkmpPS+kD/Kj/O2c1jdrz9NpaDr0/vxPBhl1Byt7IShOdW2cwZMy7fzm3tzux
         e34S9TwyFXTrQhq/LWuO4p97fSZnNPCacF+Rrw+sfqJDyH/QMxLoOhkVUsqkAws2z+Kw
         LDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdK7X8O9F+QrntgBYIYSgg6snfTv/9pLWzv8tO4wFkQz9KWUWSBIhGebZg/85y5gj6oLpS1i7pQSPlWjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJviYp3gxzSmVi9PVRgYvOSQBwXh4cQKF8n+VLpcpGQcog3s4i
	02tY5AiMcFwN3hV1WbVCBxIgkjc3Pcx0pTd2MYi0g7KndQAo1yXw1xHnB+nvx/BB8stcc9FA+Sy
	0V+DhnO1lizOEx34IbsRKK+szeTeVHBUs/+6cqeuV
X-Gm-Gg: ASbGnctrtwozQEK/KvGNNyshpB8nczEjGgK3kpHd7SgxzMLmwmlVDPiY/1rfHX34DHe
	6onOVjMVVnrocokVbGeiPu9Fzt6CVclEUxHnbPW4YfTnSddqglgZnFUBqT8oy9PcuJ9vN4C/elP
	znnojDA/HYf5C1HMGC0Khhin7M6wJozfryqsL46htkCm3J1CbF96YXvc2OPqz2HC0OmWpdHXU5E
	t66Yltv4tazlS2Ccji/Hb17VgCGsLL3wJIatOCHIA6diNX+H50lBYbK9Q==
X-Google-Smtp-Source: AGHT+IGoVtKn/z+fvBHETKBwCTIhHjfyaWPkAklb+f6MmLruI8Ybm05I9etHLrGBfigctLEhHMHLShZjSxTcGUhWdbc=
X-Received: by 2002:a05:600c:4849:b0:45f:2e6d:c9ee with SMTP id
 5b1f17b1804b1-46e56713c8emr799655e9.6.1759158958285; Mon, 29 Sep 2025
 08:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <CACw3F50ijQ20Vg8ycMROSCccf_XtjB_fFvLGxvQZ7eaNQoLwGQ@mail.gmail.com>
 <5f117b73-8d7b-b233-a0a8-2a29ea6312a8@huawei.com> <SA1PR11MB71306ECC0662B9A952EA3534891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB71306ECC0662B9A952EA3534891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 29 Sep 2025 08:15:46 -0700
X-Gm-Features: AS18NWBdlALjklZrPik0xP6HICNNusJc_VQT87GL7dSv5ULvD7SM592G5TPsAWM
Message-ID: <CACw3F52QNe-JsnK1iu8s21LXGC9heZy0zsGvE3kaRz32HmqjNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: prevent poison consumption when splitting THP
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	"david@redhat.com" <david@redhat.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "Luck, Tony" <tony.luck@intel.com>, 
	"ziy@nvidia.com" <ziy@nvidia.com>, 
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "npache@redhat.com" <npache@redhat.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"baohua@kernel.org" <baohua@kernel.org>, "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, 
	"Chen, Farrah" <farrah.chen@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andrew Zaborowski <andrew.zaborowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 6:57=E2=80=AFAM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> =
wrote:
>
> Hi Miaohe,
>
> > From: Miaohe Lin <linmiaohe@huawei.com>
> > [...]
> > >>   First Machine Check occurs // [1]
> > >>     memory_failure()         // [2]
> > >>       try_to_split_thp_page()
> > >>         split_huge_page()
> > >>           split_huge_page_to_list_to_order()
> > >>             __folio_split()  // [3]
> > >>               remap_page()
> > >>                 remove_migration_ptes()
> > >>                   remove_migration_pte()
> > >>                     try_to_map_unused_to_zeropage()
> > >
> > > Just an observation: Unfortunately THP only has PageHasHWPoisoned and
> > > don't know the exact HWPoisoned page. Otherwise, we may still use
> > > zeropage for these not HWPoisoned.
> >
> > IIUC, the raw error page will have HWPoisoned flag set while the THP ha=
s
> > PageHasHWPoisoned set. So I think we could use zeropage for healthy sub=
-
> > pages.

Oh, sorry, somehow I forgot this so I thought there is no better place
to do the HWPoison check than in __folio_split. Yeah, since we know
the exact raw error page, checking in try_to_map_unused_to_zeropage
like David suggested is much better!

>
> Good point.
>
> David's suggested diff in another e-mail checked the raw error page inste=
ad of
> entire folio. And I tested that diff and it worked well.
>
> -Qiuxu

