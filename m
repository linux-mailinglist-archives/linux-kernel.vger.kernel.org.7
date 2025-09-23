Return-Path: <linux-kernel+bounces-828818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33450B958EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB6E3B4A78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0455321457;
	Tue, 23 Sep 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVjGcreY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6325F321459
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625405; cv=none; b=h4hfLWPUm0+d9aH6qvyxfS6UAb1lUpJ/1ewZHjHdPoFu2WmuElfR8xRtrUr/uikZnjse320f+AcvmYKh/9E93gvl7Lk4wje4L5euoRKi/Hvmk2tEaVvmudl9m8e5dCp5qbMJ8fL5IBd+3SI/u7TrSZWz5zleXI8nt1grL/Kpy00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625405; c=relaxed/simple;
	bh=Swe6rY9gynxIoiAb72Hw4MkrpYa4S9mjWoRmp9FxCiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvuOX4imZ8gc1m07218Ez0KO2a2dwyH1ayAzUpS0KPyRfDpU8WXp35Sg2ERnQr1XEjptEcEHkCdCgG+uL+aedrJ7db/N1S3vEiw7AzC2N1tyFr8r29WeMbso/9+4QwwfM0Y/E9A8ariR8KlEhtCMHR0ehO8h5VCN44nrzAkqCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVjGcreY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758625402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Swe6rY9gynxIoiAb72Hw4MkrpYa4S9mjWoRmp9FxCiw=;
	b=NVjGcreYgOGYPX4pC6UZqrZ08SzO3gFMM72ycJCI543uhdOce6AdiTS3+h3d8Nk6smHipN
	Y5+mFkvtgexC+mLDaaWI9jHoiSc0L4CFCJJCXAHfR1O5DwPL7EJrDuEBpm6WB1vKI88+6N
	2g0I4sJ8wZ8dQpvvMrQ003v9rM4HJyY=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-G4Tz3MMONkmgpPhwl9mw0g-1; Tue, 23 Sep 2025 07:03:21 -0400
X-MC-Unique: G4Tz3MMONkmgpPhwl9mw0g-1
X-Mimecast-MFC-AGG-ID: G4Tz3MMONkmgpPhwl9mw0g_1758625400
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-54a939c158bso3623144e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625400; x=1759230200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swe6rY9gynxIoiAb72Hw4MkrpYa4S9mjWoRmp9FxCiw=;
        b=oerWwzJkIvM7PPPiDmNk90+4TjD9wTJoBxlR3SnAgBP/psjpKn48BbCnXu5r0aOYgg
         yhO52Q1gO02B8vtJWbjjeeRZOZ2+zIwToHap/wTlPtE+ZNVovHHzjKKOeeH1dZPeVCcW
         3klfToWBIhYxP/kZjaFUHRZ9UzzaIyjZlkK9jLPCeUwPwEi/mLQDO3gA7fbOEt8Jx26R
         cktmbn6211T3WPa2wBUwLhgVBm5/LArBYleTBWyp8JysjdGOONSAlp1zFAU56Ei5Clh8
         YmotNCflKntqJrvsQ7aySpt8jlmTysIa2c4/pbekdJxBAbo/iCF+HvllIef2g7uySg7v
         N4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyrbmqiWXaV/jgo+o14q0PCDXFd+Fb/r38e91v1hz498oW+CwrMRngteIzC45xDiW67jIGvNqOJj6txOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzitHnj+tGi5cWGVxgnzNKNhs/sOQPIqcZbC0/YDXQ7+lh/9yF4
	e+4KTt3vLVqEZqCYnGjnNfxHoaufwN8OH4FHER/4QOFVtbGqeeE5GfcKFvHctoh3zGoWGkFkvwT
	s7znasDp5kleC/k1S6Du1Bzb2+Tiq6FkuXD/u7TQhEw+rYjhVQnioGMhB5R8JdeKi0KVI3s3Frw
	JkKeSRc0bHiHITOJIsePEi5ocy5IA91Ga1iBbfeJ3T
X-Gm-Gg: ASbGncvlU6A1vkO7SiM+L1sP4XiFwR339liwi90DI96dz2G2kWlwBnok6lNdY1LR2GS
	FctYnbUOatLdYwyXBkjUl0FMEvyqnX7gs24AU/5dpZXXwUdT4eO7g1JOI7vRB+gIvskT6dPl9Mw
	Mzt5SSy+dhREZcH3w0KPoyZw==
X-Received: by 2002:a05:6122:251c:b0:54a:8ad7:59eb with SMTP id 71dfb90a1353d-54bcb1d349fmr691541e0c.9.1758625400398;
        Tue, 23 Sep 2025 04:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmWnjjnlbxkqsmt70oRkDaJTjcTb/VK4xGaXasfxB0vFXQD9TngLFTar/C7vX/7UorI+HUBvcEWxOQXxVzWKo=
X-Received: by 2002:a05:6122:251c:b0:54a:8ad7:59eb with SMTP id
 71dfb90a1353d-54bcb1d349fmr691530e0c.9.1758625400121; Tue, 23 Sep 2025
 04:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923075520.3746244-1-yukuai1@huaweicloud.com> <20250923075520.3746244-2-yukuai1@huaweicloud.com>
In-Reply-To: <20250923075520.3746244-2-yukuai1@huaweicloud.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 23 Sep 2025 19:03:09 +0800
X-Gm-Features: AS18NWAY6oD65lXZ0U5a_gALUERAdhfENkXD2FWMa3u6Mrw0iQdazbmftghMxvU
Message-ID: <CAFj5m9KSEvP_gqN5_51q_iaUrOS70xC5r-odJYLOami4EKDVUg@mail.gmail.com>
Subject: Re: [PATCH for-6.18/block 1/2] blk-cgroup: allocate policy data with
 GFP_NOIO in blkcg_activate_policy()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com, johnny.chenyi@huawei.com, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 4:06=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Queue is freezed while activating policy, allocate memory with queue
> freezed has the risk of deadlock because memory reclaim can issue new
> IO.

blk_mq_freeze_queue() already covers it by calling memalloc_noio_save(),
so this patch looks not necessary.

Or do you have a lockdep warning?

Thanks,


