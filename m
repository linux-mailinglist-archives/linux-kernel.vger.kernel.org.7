Return-Path: <linux-kernel+bounces-818278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93837B58F41
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3764C321BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26832E717B;
	Tue, 16 Sep 2025 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtmzkV96"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5822B2E6127
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008112; cv=none; b=oY6yQSqHXMWWCQZ1wn5jboiWvHq7TbdHNdtYBqL4ww7xcVCcZuwJ2cJMrT6RTqslM2LcknxdkWy7O7Fp8khb6VUbvq/CH7aHb9DAfKcXKRog2aEE+m8NyXpMMk3f+tw0SKXfI+Yd6Qe6fUf8NQ6WRNQIwPOnJMVJym9jZOIeEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008112; c=relaxed/simple;
	bh=D6d9ekdBEhyb3G2A9aDEOXln00Ab2y76UPi2l9PmD4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0WN3pNHBk93XARxDCwGvcHrzqSCyynnwxd/JveiFKbBtxrsYUbakkRQaA9Fqe69c61vLDgcuA01J1LYYiddXpXTDl5PJkpgJppIIZkF1m0MZqxGwWoWUQxu893cRj51TYq5vAfNQBACgsFmbA8O2ofCNhPqt6l6QVWkq48LG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtmzkV96; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758008109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6d9ekdBEhyb3G2A9aDEOXln00Ab2y76UPi2l9PmD4M=;
	b=CtmzkV96Vv9ucMAcc22Rj07rWdIGUiyaQx4PBF7z8JMTzInlBsh4LLNKQizorBhB/pism+
	zTxvvUOWxMV4MBVcbLuqPdjU9iMZrivUVutuxxMPCtvACniZABhlBJrMb3ptwPCJkigJj0
	gQY9E8JWnltHuQ6E0MUQkLsd2EKVnoA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-3XqeCxgTO7yc72cgtyrG2w-1; Tue, 16 Sep 2025 03:35:05 -0400
X-MC-Unique: 3XqeCxgTO7yc72cgtyrG2w-1
X-Mimecast-MFC-AGG-ID: 3XqeCxgTO7yc72cgtyrG2w_1758008105
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329dca88b5aso6144556a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008104; x=1758612904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6d9ekdBEhyb3G2A9aDEOXln00Ab2y76UPi2l9PmD4M=;
        b=fTX1XFO6eXrgb8UUVmPDy+5Rra9nWL/7W6zn5sxONULSwyNOaT3mAJExq4iUvrZN+3
         Syf2zhmAq9OAGbtBKPEAESX6dgfPF8TswuILbqPylIzvKzKG1FHXEBZHAlGvitgCpBpg
         EbIOoR4RFCeF94LCHhPQsjVZcRc8oug5Q2/Bb/O/+N0qpC+LqKZeuB2Dsa5XZpqjbS5z
         YDD9ApPMkF4vLCB3m/TPnUtaLipRTf+9tI+XpyroFqJ6JBJuwigEhxh8z/eqknUqh/Fi
         oTnelQHp9mZ+NzYLkm5BFlE17b70YtKzCofQy4otiLBTO/SbKA2a82KTpATcYbBvB/fU
         puBg==
X-Forwarded-Encrypted: i=1; AJvYcCWhHIr5tE8Vwuw493EkvlDT5k868jyngH5NPaBq5TRZ+3URwdiXJet9blHzXPw+XCRk4QaObJGB1EHRhTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXnX4a2MNi0mKRaruryDqe2jQ+6e/n0JHxTa71O+7E4cNJY//c
	4Rd9+DvDQPhRxKAz1kercI0Hrt3KH+v+NQT0c4Vjag4aVH6QZexVg/XSp4q+UReIotROKUGdsh0
	RzJfbrviJaYPDZT1X8i/1fdL1FCZ/n1TmUVF2mQcwRgZNI8WvXcQgOQ4oM7WARdm0QTbEw3oT46
	IVfc8uVt5I4tW1R/l5TsEFp40+8KB+/TNqWm71skcI
X-Gm-Gg: ASbGncvSGmwmZg2+2e1W4opr/vMisIF8ffLLLNn1vzCi0+cFWHgtVvQsmbV7lpPC8EC
	GNtxvrKr6ZtmKQy6EemEo3J8BhQOTxjlMhmCS6Xzqr6T7vtNvNpMPddzG44InN2d+NKl6kdO3M0
	17hpDYhiEA/t3z6dNWMg==
X-Received: by 2002:a17:90b:268b:b0:32d:e027:9b26 with SMTP id 98e67ed59e1d1-32ea61f40eemr1655233a91.13.1758008104599;
        Tue, 16 Sep 2025 00:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE41+0nEZ7uR68Mnvkj3byTsvAEGDCXOwLITAVl6OsB+Oh86L0Un50ZLiDd2YqmZSU5tm/eVC4SN1t81Pb26VA=
X-Received: by 2002:a17:90b:268b:b0:32d:e027:9b26 with SMTP id
 98e67ed59e1d1-32ea61f40eemr1655196a91.13.1758008103710; Tue, 16 Sep 2025
 00:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
 <CACGkMEvWNOjFU0pgiS=LF2B+yEC-y_RU3w_P5_dr10RPH+5xrg@mail.gmail.com> <328b3f8f-cca7-4d8f-9335-24341b40b2d5@bytedance.com>
In-Reply-To: <328b3f8f-cca7-4d8f-9335-24341b40b2d5@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Sep 2025 15:34:52 +0800
X-Gm-Features: AS18NWCI_RI0SXTKAt8c2DrKB370dG1BgGK6HWboIC6YYEbwdDnxbL9kobwsFbc
Message-ID: <CACGkMEvXH+VpA-2sJ39QL4Rb3Gg0VCOKn5BApRpft=583Qcp2g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] vduse: Use fixed 4KB bounce pages for
 arm64 64KB page size
To: Sheng Zhao <sheng.zhao@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 7:07=E2=80=AFPM Sheng Zhao <sheng.zhao@bytedance.co=
m> wrote:
>
>
>
> =E5=9C=A8 2025/9/15 16:21, Jason Wang =E5=86=99=E9=81=93:
> > On Mon, Sep 15, 2025 at 3:34=E2=80=AFPM <sheng.zhao@bytedance.com> wrot=
e:
> >>
> >> From: Sheng Zhao <sheng.zhao@bytedance.com>
> >>
> >> The allocation granularity of bounce pages is PAGE_SIZE. This may caus=
e
> >> even small IO requests to occupy an entire bounce page exclusively.
> >
> > This sounds more like an issue of the IOVA allocating that use the
> > wrong granular?
> >
>
> Sorry, the previous email has a slight formatting issue.
>
> The granularity of the IOVA allocator is customized during the
> initialization of the vduse domain, and this value is also modified in
> this commit.

Ok, let's add this to the changelog.

Btw, do you have perf numbers to demonstrate the benefit?

Thanks

>
> Thanks
>
> >> The
> >> kind of memory waste will be more significant on arm64 with 64KB pages=
.
> >>
> >> So, optimize it by using fixed 4KB bounce pages.
> >>
> >> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
> >
> > Thanks
> >
>


