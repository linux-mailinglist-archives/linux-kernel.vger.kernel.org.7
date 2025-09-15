Return-Path: <linux-kernel+bounces-816414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F1FB57397
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5533D1A20A32
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5C82F0C7F;
	Mon, 15 Sep 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMD5EhYV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39DE2EFD98
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926263; cv=none; b=ogA0BtkQt0WS3G1DcVh0L89BtA5yOvHrQLSjBWU8zhdYJlbdxQSiJF7nZgpjFXErNUzVgoRrDBDJwwPS3c/sPvvJyeT/20Zg7lFgR+RvBNsWsfSpshYIh8LIKG+cfWARVWBSdOLAcubJ5fd76I4Ds2zDo7OxfpCEoGVxBvJgJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926263; c=relaxed/simple;
	bh=wPZPeUMuJZB6mmUn0N0BcQU5xP2lBbhUb5Om7x+1yKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHPX+meCB4yQ7eqib7kNQOtqQhHqyQlL8/0FLmeDGvZZYfMQxvAtijI+C7wCXlyaeOZ3J8gaKXGgFOuojry9d/pHRSOT5312ebFv2dUES4TYvYvKSE7DxoA6OPGc18VZygXC1btz0dDs7XaJ40kD0YMqfRJxZiAnPY4PnH+LE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMD5EhYV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757926260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHAiXvx7xZu60Hqr98Fl5/ljjKFjkxjgYFM+bVq7QJ8=;
	b=GMD5EhYVLCSzsu8nfl6dJOfSGgKf9FSE4Wnuz+l7bbPcgI5tXY3wCaiUXyCRBcTPx142p4
	V7vYUHF4BmUAbAB14YaS+6MuSoYZJsl8nGNSnJJv3NLsM9mRDJbL3Mog+HRzPYU+xNw0kP
	Z8TkS/He6heXqhgLez1uClApTTHlL20=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-kXat1iayOhi7OCWJ4ZmYhw-1; Mon, 15 Sep 2025 04:50:59 -0400
X-MC-Unique: kXat1iayOhi7OCWJ4ZmYhw-1
X-Mimecast-MFC-AGG-ID: kXat1iayOhi7OCWJ4ZmYhw_1757926258
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-336de88c3caso16894201fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757926258; x=1758531058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHAiXvx7xZu60Hqr98Fl5/ljjKFjkxjgYFM+bVq7QJ8=;
        b=OIUA5Lm/jCn7IDyijE+FNr2kakpFM6sH96DiJLtZX0knHwymACMPunleiZDfcPafUE
         HP6S4ytKFnzoMSfD7ZGsoOFuBcmu7GoC7kpt/WorUEuPWAPbs7jcGfajowYBW28KZ1ED
         vlCCNmcwl6N65XPmBsCB6XHuzkRGHJUD91guPIRGRYys8Cs2liNHvVhbx4juqiIuYwo8
         ydy0Yxj6Kp8GKq+fmV3MqAMJIqX2AHOldxGTXYFRNiKLV+ppku+DWOQman5rzbmFBOdI
         2bjKkrLZc+AO2/61nMxzwt08i9mE68CDAyO9iDmvhFNM5VNVcUg7TVaMHTZZKKDAPriV
         3m+g==
X-Forwarded-Encrypted: i=1; AJvYcCUzkRPEEHn+iLif2FR4gXbm/sbLHrVm+tu3vMjYA4uzvHsGWtWvnMP7OrbYGExJV0UEZ/8p1prnpZhE/o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN1ua1Kj27A2InTyeimz87xXM4pn/eDBAi1adtybog8kftiZdL
	BmkvP9BMjX/CDMY9+NYLHtDBdjhPZZUZ3cD9+5PXwVdwXGx/FyTBeWUlATrMxjeQDsK0V2EoqOK
	uGxdoQLfFZgZXzgL38AVw6wwdX2OE4l2Y3sN9IXU15rwTIMw/sSiuAHmH2qxQrunFK1exR4fYlL
	o+NYVCl+rmjx0fRmX67zw5UCrBuK3sC1xZ4Oa6tAH2
X-Gm-Gg: ASbGncuV/+1lyf1Anxua4rG1DABn7cYHODg25be82xeYh0hPNRWK+xvSxkzWJmEFXQr
	k7ZhzYH+7J6OQe/EARe7mcHzXPp6NH48DyICJSvIQBqGAKNeP9amhlJcL2T+AuPmJZBHNdke3tV
	Exa8fRdZp4xr13kPFfgk8gPw==
X-Received: by 2002:a05:651c:4418:20b0:336:d1c3:37a7 with SMTP id 38308e7fff4ca-3513d579c3cmr30012581fa.26.1757926257587;
        Mon, 15 Sep 2025 01:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl0ZUO2JTUZirUwacmY7tp8JOoWQWR66JhMiR7uFGREt2YvznZEpf+Aap5lqTItF9SsIhP1MK0sxbosCwSIes=
X-Received: by 2002:a05:651c:4418:20b0:336:d1c3:37a7 with SMTP id
 38308e7fff4ca-3513d579c3cmr30012451fa.26.1757926257122; Mon, 15 Sep 2025
 01:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911073144.42160-1-linan666@huaweicloud.com>
 <20250911073144.42160-3-linan666@huaweicloud.com> <CALTww2_z7UGXJ+ppYXrkAY8bpVrV9O3z0VfoaTOZtmX1-DXiZA@mail.gmail.com>
 <9041896d-e4f8-c231-e8ea-5d82f8d3b0d2@huaweicloud.com>
In-Reply-To: <9041896d-e4f8-c231-e8ea-5d82f8d3b0d2@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 15 Sep 2025 16:50:45 +0800
X-Gm-Features: AS18NWBaOBbr4paKcZMzxqFFD0Hqf4jhv8wGm06I2UjwMAQ7TTVLejBmju46_1U
Message-ID: <CALTww28y7D32SAeoGgv2HjFJW471AtTD-SG0yxed4ZCJSOCHUw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] md: allow configuring logical_block_size
To: Li Nan <linan666@huaweicloud.com>
Cc: corbet@lwn.net, song@kernel.org, yukuai3@huawei.com, hare@suse.de, 
	martin.petersen@oracle.com, bvanassche@acm.org, filipe.c.maia@gmail.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:15=E2=80=AFAM Li Nan <linan666@huaweicloud.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/9/15 8:33, Xiao Ni =E5=86=99=E9=81=93:
> > Hi Nan
> >
> > On Thu, Sep 11, 2025 at 3:41=E2=80=AFPM <linan666@huaweicloud.com> wrot=
e:
> >>
> >> From: Li Nan <linan122@huawei.com>
> >>
> >> Previously, raid array used the maximum logical_block_size (LBS) of
> >> all member disks. Adding a larger LBS during disk at runtime could
> >> unexpectedly increase RAID's LBS, risking corruption of existing
> >> partitions.
> >
> > Could you describe more about the problem? It's better to give some
> > test steps that can be used to reproduce this problem.
>
> Thanks for your review. I will add reproducer in the next version.

Thanks.
>
> >>
> >> Simply restricting larger-LBS disks is inflexible. In some scenarios,
> >> only disks with 512 LBS are available currently, but later, disks with
> >> 4k LBS may be added to the array.
> >>
> >> Making LBS configurable is the best way to solve this scenario.
> >> After this patch, the raid will:
> >>    - stores LBS in disk metadata.
> >>    - add a read-write sysfs 'mdX/logical_block_size'.
> >>
> >> Future mdadm should support setting LBS via metadata field during RAID
> >> creation and the new sysfs. Though the kernel allows runtime LBS chang=
es,
> >> users should avoid modifying it after creating partitions or filesyste=
ms
> >> to prevent compatibility issues.
> >
> > Because it only allows setting when creating an array. Can this be
> > done automatically in kernel space?
> >
> > Best Regards
> > Xiao
>
> The kernel defaults LBS to the max among all rdevs. When creating RAID
> with mdadm, if mdadm doesn't set LBS explicitly, how does the kernel
> learn the intended value?
>
> Gunaghao previously submitted a patch related to mdadm:
> https://lore.kernel.org/all/3a9fa346-1041-400d-b954-2119c1ea001c@huawei.c=
om/

Thanks for reminding me about this patch. First I still need to
understand the problem. It may be a difficult thing for a user to
choose the logcial block size. They don't know why they need to
consider this value, right? If we only need a default value, the
kernel space should be the right place?

Regards
Xiao
>
> --
> Thanks,
> Nan
>


