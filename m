Return-Path: <linux-kernel+bounces-828174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A4EB941B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87DA18A7898
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4112580E2;
	Tue, 23 Sep 2025 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6WzUKuJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAEC3A1CD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598112; cv=none; b=MwBR3v850sPSbSfPdIBa7PJ9sRRkoy9XR6Fwu7mEFjOS52NF9C9vd4rKkYPkWpLWAi8wL5rsLtVn0Dhl4Y4ny6ViyiXIpSl4OOR1Fkp2hpGS5LhNE4V4fo2f1QJ84NSr+IcJA2EQZoKKZA6FeyPmXUL79mXYjau4W0/u+USmPFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598112; c=relaxed/simple;
	bh=VEiYnkys+/NObrb/XpKieYThEWZyI+pcolRDFidPVDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nu26rD0tuf0MdJLczFk7q2AezqTsFe2M+Z3X50dstv+mtIOGsu42ecv24lvnUjzRPIkZsIV6qggXvN3FXam9DAak+oRKy3uXfZMbUWdc/B+PqzYI9H+F6ubBPQr+wRTwL14Ft3OhSSAGKHi0VKUrG0vzn6bo5cJjCIkEoAnJGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6WzUKuJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758598108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpR455knSRZTubPLVpfoMvQcMwIK5eeGbfa9gZCHou4=;
	b=B6WzUKuJ0hi29cvxQg+KEk4einnVhJvLFoRMDyc4BeE5+wrlryCldjCvKyEZK84qCkrS9s
	pL78NeS6TJyuCL4yBHCYoQHBI5kxELUBVOIQOsRYI/bG2ub7SYy2n9TAujs6RFsMlJe0y7
	UMXk6SO6ZVxibfXozYH7Z39/0B3X9Gk=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-engQL1z0O-S6FEyD3O54WA-1; Mon, 22 Sep 2025 23:28:21 -0400
X-MC-Unique: engQL1z0O-S6FEyD3O54WA-1
X-Mimecast-MFC-AGG-ID: engQL1z0O-S6FEyD3O54WA_1758598101
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-54a849ec449so1387951e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758598100; x=1759202900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpR455knSRZTubPLVpfoMvQcMwIK5eeGbfa9gZCHou4=;
        b=II1aQ+XhELu8YomczjF5GeZk9BnIUQOkMh66yQrSvwIjVtxf+wvEi3DD1AI4lUa2Lm
         eq7oWxQrrxeEU4xl5NDZHKhr8S16VMT4PKFB5WckBuZx5IsCUlS6AyVwM++3bdxENlvN
         aYHA6BvsD2hGOUzYuLtPDV4rzAyoomJmZnvYC4mYtrbcQpdA0MBolfoZnSbXg33CKPNN
         b0a104i6JuGODlFkfGXKbqqD7VVliBiJ5/ZdfSKRBCMYGmZI7spjc9CR1ylZqIktNcqt
         8ooGil/noNm5/bplAuyI5muYXsaDisyMXDQKtFs8gmKHHGo7xLyibs5E3v0BFgR/pcHy
         U4Kw==
X-Forwarded-Encrypted: i=1; AJvYcCX+fdDXoKATelHXSxW/i3yQxVsv1qG6jA+SA36ywiT82iz5b0FlvJkESBw+MeYXxQ3stWcJ9t4aEcWN3xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynqVfZDwTJTM4hAF40j9tKXzCgpby63nCC3pdcPT8qaHGqf3k8
	ww8hERsB7A1rgkdwG2a3xIceva2MPHoNjFF/OzsYZ63jF9ssKxkYYsC5j7IjL70EGVAa2GtNTmt
	FJuMN2AkWHy3IBdSSyR09/wXt+BevcTTkveHqTHD9yB7P7n2iEtSaM2cU38dw9U12LxfmiPskdT
	LvXuwqZWwbAgRDzKdzgVrEXz285tZ9XD/sSbj6cBB2
X-Gm-Gg: ASbGncti6EJCdWU06BVr90Nnycdi8e3U30oK3u7cwgr0dx1xhfX+5015MBFy9Cpq1Dc
	2CWztyvvWwP9FbFVCNxzrHWaOUQeLmGd3Ui7WeEsc59eNeod4vWimCVN7I8CBxQV8ws8EzCqZ+D
	VgUSbrVL23W/o62SyjmXT37Q==
X-Received: by 2002:a05:6102:3053:b0:51f:d683:fd97 with SMTP id ada2fe7eead31-5a575a92b87mr362409137.5.1758598100702;
        Mon, 22 Sep 2025 20:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElw4139wAfgIeAYJVLVRtGIrOvYjqMyEE9xZseaAFZhTtwpwAMpdbtJAW2TdUXwsa1niVar77GJhP/uiLmsP0=
X-Received: by 2002:a05:6102:3053:b0:51f:d683:fd97 with SMTP id
 ada2fe7eead31-5a575a92b87mr362406137.5.1758598100402; Mon, 22 Sep 2025
 20:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68d1b079.a70a0220.1b52b.0000.GAE@google.com> <20250922225834.7386-1-hdanton@sina.com>
In-Reply-To: <20250922225834.7386-1-hdanton@sina.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 23 Sep 2025 11:28:09 +0800
X-Gm-Features: AS18NWDIfziv68oLBPo1CPaucl7pALET7wu4nmNtzj7rU3ovMX13Fl-TP3sqS0s
Message-ID: <CAFj5m9+H9t_ytndYk=iA1QvAXbgLFGXJ+5_CmSXpEpQDye-jyQ@mail.gmail.com>
Subject: Re: [syzbot] [block?] general protection fault in blk_mq_free_tags_callback
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 6:59=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> > Date: Mon, 22 Sep 2025 13:24:25 -0700 [thread overview]
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    846bd2225ec3 Add linux-next specific files for 20250919
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13c238e2580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D135377594f3=
5b576
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D5c5d41e80248d=
610221f
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7=
976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D155e427c5=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17bb8142580=
000
>
> #syz test linux-next  master
>
> --- x/block/blk-mq-tag.c
> +++ y/block/blk-mq-tag.c
> @@ -565,6 +565,7 @@ struct blk_mq_tags *blk_mq_init_tags(uns
>         if (!tags)
>                 return NULL;
>
> +       INIT_LIST_HEAD(&tags->page_list);
>         tags->nr_tags =3D total_tags;
>         tags->nr_reserved_tags =3D reserved_tags;
>         spin_lock_init(&tags->lock);

The initialization is needed, otherwise the unitialized tags->page_list
may be accessed in the error code path of blk_mq_alloc_rq_map().

Thanks,


