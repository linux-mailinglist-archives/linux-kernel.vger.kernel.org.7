Return-Path: <linux-kernel+bounces-878175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7739AC1FF18
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184774073A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1047335BAF;
	Thu, 30 Oct 2025 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IuASC5sE"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E452E8894
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826241; cv=none; b=c2Exn4tjpEbEpjn5CdoUgfTREMYzLmuer8KB+weF0vNmz972y35J31KsBomv6JCfN6gHKZtt0JOmGY3Tg0iqbCvkb8QBGXZKwUmI3oIw03mSlqXVKc9RoJNNJQM47Qbg7TZaJqLOINgrbFBLT8hfgVXscRyOHXKXDN+omvGc4ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826241; c=relaxed/simple;
	bh=zJ1BMKe0xLHA2vcalytGuoCGulRSfJEWC9LqRcwSx2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1EQ/is72UDkJbcu0Q5CIeFrA45CH2Izfohj7YHFvWuysduCFiZtnrtKQJgVIkI9cIx/Mddu2cRed/fqENxFaxUbIKnTi6iWhsrl1LRAuATEhkKiMPjzZul3Rtp1263H/P0AwnjZbIFwua/C0NGM6PIl/wGgTxDRykeDvghUUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IuASC5sE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso938968b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761826238; x=1762431038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oJ0JlkrVuBslS3CgdZDs0o9o1Bd+9FyfJgJWBt+B10=;
        b=IuASC5sE4UjyQlPH4sjQT1ittfJNIN0NLN6LCEJkKBqo7kKtmMcbgc1MLJxRXbsgIT
         zrXn7uaS/730H1ImTT0pboeg0wrrbCOYGfcA+KXi6xARPXKRdpm7T95DEjTXtZm3vY4U
         pFVqz9d/KLFdIrAlSCgdQlFGNBAVSf0qkUZnqkE+JfPQv9ZDLvNxOzGqIcOZTyoLXxrv
         Fill8TRBi8/RTJcyOlPjAFNUTQ0jZrbB7TAZbqq9Xa1kCVQBBQ1Oji9xYP7yipJTIcuz
         L0giU3bQf/30c2gSYu0o5x8FoOKuFSMDWTiyl/DSS6Y2TXOpqnMwkyRM2KTyAa+hDfI4
         xZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761826238; x=1762431038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oJ0JlkrVuBslS3CgdZDs0o9o1Bd+9FyfJgJWBt+B10=;
        b=NJ9ubf0FDsO7BJDtzxBDjv37TIGXtfoVLXtEN/FppIEQPOYN8fuNQIGvuTBKWYyOd1
         vExeQ6WOd1X59byzYSfRYfHxLvSswY5MfjKW1ekyWrOaD4NhwyXIz86fudwQ2YpJ8yFU
         ydBYpVwOoiL2cg7Q7pdWCs5F1s4FkD0UwUSWjZcU0BjrJsl8lUkG+MNWpeKXqnhggnfj
         LJL2qfvGbWnjJpcYoRjXVxWB53iPjlXWTX60v5aNEk/1h9DM+GJHjOVBWSPVVIMIMymR
         4zXSma6HPj0lESFIoSgm0Z9/8w5Ovoh8weVK8eCBtPPthLp2iwJtFBe7uqTv3mrrYoeC
         TFUg==
X-Forwarded-Encrypted: i=1; AJvYcCUNane2LzLiKkjMA7ZQ9R58iel/Gl5CvAlYUiZr3EIumFfpVVTE2fm+yHx5mF5XHjXo/o0a8W1T250uxeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoIf2ny9JIywYP3hsyKhoegSrPCL3HZRjTRm5wj2qiQfPm4fpL
	rn8T2h0jIxDDGzZQcWXiGxMi0tg1qMyy9rKCmaicWdbAuMX0hhB1PsK1UbxRlRUxC9UmjiljcPg
	0aCp6bmWQkVE91uthR/3cpTUZZwwxG0hSqhHpqOriKhGt3jxSXU7Xt3Pq
X-Gm-Gg: ASbGncv9q5a13xjiq35K64TV59WSkz3qys8yq2uSG4LwpaplGz5yIby1nJpNzLp7GTw
	DZymti5vIG9ZYuJcwI/bQS08hNNt1u6gme7M4uDaxbNi0YF8EJGzTc/gh1W6WhFFalfa9GW/syD
	rb3X91BPLXnfQ1DRHEsas5LTFe2sMRNRK52T8PIt8JdwSDWEpbrWlLkMbkNUc5uuKdJti5Q6L5Z
	LEd6+THoGcPcke7fAR6CNxqt4eOVAndq8FC8cxZBAqOR+p2DhOfqghkxNnXATh1evaXvqsL
X-Google-Smtp-Source: AGHT+IGcdPel/fTbcZF8JyrLGWNlQpLy1fw1vn/jk/bK9k05MEnRYPrwN86FrLI7df4o62yne5nLNvB1jzmUZ0DyVUY=
X-Received: by 2002:a05:6a20:7285:b0:334:7bce:8394 with SMTP id
 adf61e73a8af0-34654fe4068mr9064766637.51.1761826237600; Thu, 30 Oct 2025
 05:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-2-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-2-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 30 Oct 2025 20:10:26 +0800
X-Gm-Features: AWmQ_bloY2C-mDC1zXHDDyiHqhx48yeEZti-RLhfuos4-6prx5z3FKe-_-91q-M
Message-ID: <CACycT3uwzDc4_Xhg1hOuEpBj9G21P1OJjJyt+GCWi_=NG1ad7Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] vduse: add v1 API definition
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:00=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This allows the kernel to detect whether the userspace VDUSE device
> supports the VQ group and ASID features.  VDUSE devices that don't set
> the V1 API will not receive the new messages, and vdpa device will be
> created with only one vq group and asid.
>
> The next patches implement the new feature incrementally, only enabling
> the VDUSE device to set the V1 API version by the end of the series.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

