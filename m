Return-Path: <linux-kernel+bounces-736164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D87B09997
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF124A40E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2E8198851;
	Fri, 18 Jul 2025 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VA4hiFRh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D422AD2C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804284; cv=none; b=WP7wS6jq07gXx4FVOjaTuiBNl87GpuDfqOPKoGuyFF0TUt+hPwuBpRCXbTvUedykeg1d/o5cHUdulG5AosKw87jtJK51s/mVKkxYSNkUl5oNEbaZoQ/IiYRHZmJfIMvvGwrsYGt7QbQL1W8/Uy2MUJLWuIiszb7MeGd9L/7ugGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804284; c=relaxed/simple;
	bh=F9KoY0fWAyT0ZBg+rowE+1s3YIsLeaL/832ZnoeP1Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFtPDiw2JorhTYWgbrM6bUlkRIV7LPKKSHbbTpurU3CzzqqVFx74pl57a8Ry8e99AvRLi7iy2H7CrWmszBXtcwTARQYd0Zhz0/meoA/7m7Iy/JgxC8eN5aScSLujqwzxn0RljGQvWXnnfBbAusGtvN0uFMjVGcb9sv9j2IW6Jko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VA4hiFRh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752804281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9KoY0fWAyT0ZBg+rowE+1s3YIsLeaL/832ZnoeP1Wc=;
	b=VA4hiFRhesqVmBUM+5sKPmL85Q7c1wpVu9NiPSxk5wDQ1LFBrgxZAyjaSnH7RGWgBu+V7L
	YeHN2cbSirZilNhrJMnMFh4f1s/ohWjdlxuUhAIg1x57lCFlwH2VjCCswYZGaSEmQgL5HZ
	SN8KM3ZYqtv9hdabCPKHbZVT3Oq+v2E=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-l2B6MtYUP7u33AzWe8psfw-1; Thu, 17 Jul 2025 22:04:38 -0400
X-MC-Unique: l2B6MtYUP7u33AzWe8psfw-1
X-Mimecast-MFC-AGG-ID: l2B6MtYUP7u33AzWe8psfw_1752804277
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31cb5cc3edcso978901a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752804277; x=1753409077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9KoY0fWAyT0ZBg+rowE+1s3YIsLeaL/832ZnoeP1Wc=;
        b=h4XIvhjyiKffNNpL5c6/cgGg8ZTWEdllLm/S/OBPO4nxYDrD41IeEs9L2Coo/jzaff
         hAi3ARDjtkATUPFoi/F0hlmmt4/rja3s0oYreYlL6tzAwig7c62VS1Q1SntyFgsxKavR
         zSwVrjAxD0NscfL5GDkGUrDKe8kcQ2VtuWNh69ldTECAsnazkCuwk9xeRsBRsOd6v1RC
         Nqf3ZQijSFvMlwFL9JPY4UngQ1s3xm3Qvcf/KOJfOoNRt/Y8erUhMWdqwf7yiBrPavve
         FCrQYIRV0Hkr1akZcVGUH/RS40xQJgWcrJpezHSlttzbgIzy6rGZio2WLI+1OmZu6t5H
         ertQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu9vzo4oBSI3ziobnTWphaa+1HD3VYiU35Ou4ik9xdfyS6Hq+rA7ykukaUBtplqHkIZvNTsHZi11pkd6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKdP7Wavl2D6tGNKiqBSPUXrtjsPdnZ53JiNE8D+G2rC5tPSMA
	qxbzs8nBRbNxuRPkegRSz3Bx+faMo4h/YnOCuMgPi1Yrb41PHO7161AgaXsZd8vOdx1oR2p7MII
	1rWL2Zh5S933PG8wfh1Dkh/p/0feVL7qlXZFohWuo8FjkEzy9t3bDBrLw0MEQdHhUBtsVO2wGsR
	QMAqwbbVX2sA+EHBn28v2sKNzQ3LeE2rq+4utIoMur
X-Gm-Gg: ASbGnctjcTYh3CPypKawdG0a4C1R2SfZG4EJeKYS0UA+R7luB4dY6KJEugHpjIpi5t6
	NIdykwxYKq1MbjE2jGeua6CGH80O5800Lf2z2O66VZj0L2VBr/bdcWjjlOqOTJrEX8FBF3nvuPY
	WDWUoDApgbEO6lxbCtr8sK
X-Received: by 2002:a17:90b:1b05:b0:313:fa28:b223 with SMTP id 98e67ed59e1d1-31c9f3c3538mr10850945a91.3.1752804277417;
        Thu, 17 Jul 2025 19:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8KqrUIVNAEyJPRiT2OM9FATHXOwO2SqN0Txk9K1dB4PdC1uDpWK6ggmwhD+ohejDdUwFOfVzzFbUMJaFde+g=
X-Received: by 2002:a17:90b:1b05:b0:313:fa28:b223 with SMTP id
 98e67ed59e1d1-31c9f3c3538mr10850916a91.3.1752804276960; Thu, 17 Jul 2025
 19:04:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714084755.11921-1-jasowang@redhat.com> <20250716170406.637e01f5@kernel.org>
 <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
 <20250717015341-mutt-send-email-mst@kernel.org> <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
 <bea4ea64-f7ec-4508-a75f-7b69d04f743a@redhat.com>
In-Reply-To: <bea4ea64-f7ec-4508-a75f-7b69d04f743a@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Jul 2025 10:04:25 +0800
X-Gm-Features: Ac12FXy68XSJi1v7t16tcsLyYegSvV6N-LmJH3rh-wlnh3moxbcvqEtUDzYQPos
Message-ID: <CACGkMEv3gZLPgimK6=f0Zrt_SSux8ssA5-UeEv+DHPoeSrNBQQ@mail.gmail.com>
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, eperezma@redhat.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 9:52=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/17/25 8:01 AM, Jason Wang wrote:
> > On Thu, Jul 17, 2025 at 1:55=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> >> On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
> >>> On Thu, Jul 17, 2025 at 8:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> >>>>
> >>>> On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
> >>>>> This series implements VIRTIO_F_IN_ORDER support for vhost-net. Thi=
s
> >>>>> feature is designed to improve the performance of the virtio ring b=
y
> >>>>> optimizing descriptor processing.
> >>>>>
> >>>>> Benchmarks show a notable improvement. Please see patch 3 for detai=
ls.
> >>>>
> >>>> You tagged these as net-next but just to be clear -- these don't app=
ly
> >>>> for us in the current form.
> >>>>
> >>>
> >>> Will rebase and send a new version.
> >>>
> >>> Thanks
> >>
> >> Indeed these look as if they are for my tree (so I put them in
> >> linux-next, without noticing the tag).
> >
> > I think that's also fine.
> >
> > Do you prefer all vhost/vhost-net patches to go via your tree in the fu=
ture?
> >
> > (Note that the reason for the conflict is because net-next gets UDP
> > GSO feature merged).
>
> FTR, I thought that such patches should have been pulled into the vhost
> tree, too. Did I miss something?

See: https://www.spinics.net/lists/netdev/msg1108896.html

>
> Thanks,
>
> Paolo
>

Thanks


