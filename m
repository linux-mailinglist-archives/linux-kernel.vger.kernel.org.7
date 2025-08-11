Return-Path: <linux-kernel+bounces-763663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F451B2186B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33031884AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCBD2E5409;
	Mon, 11 Aug 2025 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="DJs51zFL"
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED702E425D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951390; cv=none; b=h4dBxQ9GMR5mkBAGOEohrLsdkGHxs3le//cLHqVmZuaSB0gaNNooRSPTrGWqrqTMCy5O8H96m+jO4XNysSruA8WP629O7hnibThtaptL4V6OBkCenkD9n3V/Knftk3u+XFsQHR/oR1J1Hiy/DwMNxF4/dDfsPf9GaDtd8wdnaPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951390; c=relaxed/simple;
	bh=PMDEEIrVR4LcjKeT+FuaDVksS6DA0F9s2pn9QeLfY1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEWoWQo0aYpppTFuMO5jP8PwA8AZJtOqir5JtwWnG7uqZEtM0dSUixhI3uAc4OuxOCtFs7KjNUceq/QsYSTdDcCuDkSNJ7863z0U2YmjDoqw0Ra+jbn/ayMKYvtT5p7reSqstRYW0oXBvwfDN/wbXK0Sfo1VSFDP/2rUOHNpWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=DJs51zFL; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BMC3sh014151
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=AE5q
	aVqXBGVV5Dn43rDR9xCaZLA3qjgL/c+3+4/geUg=; b=DJs51zFLcbziotKNHaFC
	QyOQsIGKvsowydM3Lae/IoQKkvjZSvhogiUxH0DC3m/ZI57b2gLyUTx9qdN5Qm6b
	0p+5aq77ddIh0xqUBKDf2r1sfzljtdOpQbt0Ox28TL+WZ11FtiyVtQBdOi/0Snks
	9A5ksIGOO/VTdIEYj3vxSEeqReMX4ZFxKj80KqceDaVfHestaz8bNuENd3BjVEd6
	qgP1FhZViBicuVqHGl2eW6jd68MzRnsch97MWdS0TLPHj5mfc/+BS5mlMou3QMud
	kqkXKXWlnh+wwizm/Vs6uwkBkpeZyNmxkdJa9VQay/nVxQQGDdODNwXtlH+b6KGM
	tg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 48ejn5kfaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:29:47 -0400 (EDT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7196c919719so69791317b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754951386; x=1755556186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE5qaVqXBGVV5Dn43rDR9xCaZLA3qjgL/c+3+4/geUg=;
        b=OgyodGLZ6dNDUv7wGBIutiRwtYhdbbmVmIiGPfMbcu803Pyejvdjqm5nHPn0u1KbFg
         igJeXuo5EGUkK5mqMZ6lN1wJASgzQPiAMLm6pME61iiEJdopTYNxKLMqyz1VVJ113E0I
         Xb7qSe8hNk3UdoVzbjDGmlvi3dzYbEMhnIeyAQs6ftTflera8PJXpHdhzeIhGDK12xCo
         QU06nbne1V1zddra7SLWOt0yo+8Ug8QXQHw4gi877jWn1NGvLCtygjd5Yt98IpS2hlC1
         0O5PRIRjEJPuH8/a5ckTQXdWG1XDqPlr3B4G03zIeDirAiyxVO+mtWQbfsh8kmgO6O+j
         MnLw==
X-Forwarded-Encrypted: i=1; AJvYcCV/K5tWjdN7wyf/1I9AYLD39Su0kQJyCQJRNBAQbsT+7r+zN2vRSApcSjQP1/fiS6Q+vz4FQzvNhVGsAZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdKeTb1gBLCk1TPVw6jPnNYcH99B+ZdmU7kh8YwTr1pyJ/1ra
	pUVfZzbZyFWZZGcLJkdrQgaTiHBP1ePpiSAjD1UOtuysMDcqvuOUaG7hxlnLre8hhvCOaCHHfdx
	zjP2lO236mULYSVHTBGM10/rqagNi/8BPW9dKBIDOexiGmphBtA3bpxgmqTBRC6MhetKDXyiDhz
	0U3Sut/YdbUlQ2AchfluQl0hKgQIHXJZKsz8CxvkADJ1vWD58QSg==
X-Gm-Gg: ASbGncvBTKJYjQelsQUDm8l40pRsHjYba3i4Hw1X/I9zfHbAr3hYZlTbFzvFEJbet4R
	Pcbnpo70Uloflio8JRAfWdx2/Zq43rP4EOilsiKCPiRbaOiGyj0aD3we7857JI3xCm4Tgr/zHMm
	e9sg4eD6jqTHzJR1QsjmIA
X-Received: by 2002:a05:690c:d8b:b0:71a:a9c:30dd with SMTP id 00721157ae682-71bf0ceec37mr215180987b3.2.1754951386375;
        Mon, 11 Aug 2025 15:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4xutuahTdVuDHkB9pGR6PFw62RaMQhcwg1ni+TzXpZI6Q7aTCGZIxYCTxWjI4ddw5HKpnz5sRl2TAesf7Otk=
X-Received: by 2002:a05:690c:d8b:b0:71a:a9c:30dd with SMTP id
 00721157ae682-71bf0ceec37mr215180627b3.2.1754951385770; Mon, 11 Aug 2025
 15:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-vboxsf_folio-v1-1-fe31a8b37115@columbia.edu> <aJpqw4HhLVsXiWvt@casper.infradead.org>
In-Reply-To: <aJpqw4HhLVsXiWvt@casper.infradead.org>
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 12 Aug 2025 01:29:34 +0300
X-Gm-Features: Ac12FXzIpGdHBMABXIL57Onr3abs54wsPYwfjVfBU0PYd6jel03kHRX93Ov0EEg
Message-ID: <CAKha_srnh8HOMdHPp1Dd9drMhtM+oROvC3UDx+N2wiFvwDe-YA@mail.gmail.com>
Subject: Re: [PATCH] vboxsf: Convert vboxsf_write_end() to use kmap_local_folio()
To: Matthew Wilcox <willy@infradead.org>
Cc: Hans de Goede <hansg@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: l1kVRUVOruXmPdyNI5IFWbOTQ_aKRm9G
X-Proofpoint-ORIG-GUID: l1kVRUVOruXmPdyNI5IFWbOTQ_aKRm9G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE2MCBTYWx0ZWRfX7aENqWbaC0KE
 y/nDRH20dZoJms+TjB1h4RFE2/CEKEx4eguICLOIeVRn9UYRSFMknCS5+DTifr0fTQ2gQVoaJTa
 0JzZbFdXiHpBo8/BhKSNGRpsoOC7bYVPxm/8mtnYtUJ5IxONhBuPTYbGhp5u+XSsE+x/e2AYyeJ
 BAehiL33AyOvFKLWKXNpnBN9cDnpDlKauiGarrk4qvYlwSJpV4N+8TdhwR4jzc8E/YoV6MetdR0
 DI6t5ZzoStif+NyhB3T92cDOZ/8vHlN1qTzcmKVKZ+12F+Ogt7a8JNKkeI/efKdsl0B8hwPLgs9
 7CjJFM44DLyBKwXxWnsnJCune+3GBq0aEw11IkbW4+C0+3CLgGcgAm1AXq1deg2T80SKNltTEYA
 i90ge1Ti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=10 mlxlogscore=687
 lowpriorityscore=10 spamscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110160

On Tue, Aug 12, 2025 at 1:12=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Mon, Aug 11, 2025 at 05:42:00PM -0400, Tal Zussman wrote:
> > Now that vboxsf_write_end() takes a folio, convert the kmap() call to
> > kmap_local_folio(). This removes two instances of &folio->page as
> > well.
> >
> > Compile-tested only.
>
> Yeah ... I don't know if this is safe or not.  Needs actual testing.

Could you elaborate on why this might be unsafe? I assumed that (1) this is
similar to the conversion done in vboxsf_writepages() and (2) that the
kmap() call here could be simply converted to kmap_local_page() and then to
kmap_local_folio(), but clearly I'm missing something...

