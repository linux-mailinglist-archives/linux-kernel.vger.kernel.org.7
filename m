Return-Path: <linux-kernel+bounces-836456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C5EBA9BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6C0D4E137A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74A830507B;
	Mon, 29 Sep 2025 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkQzKBbz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF3317736
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759158138; cv=none; b=iSHoqOKL3LakY0tHTVVLMgSmL32ijZOfG8xfAgze/KeKmmFraqDJLgngfljMWMWjLbWNjS2ChfgEZMBE6lKcAesYuEjF15wTN3sF26CGBd7vG6A8gUGetqk62HhGpHk4pUKp1jys8aEGH0tEDGF/D7UQsg2VG/gmI0H2SIBDMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759158138; c=relaxed/simple;
	bh=5mApbppp98IoLmLnjxv5jLlE73kH0Xbow0oj0C24KuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQp4yq5zrpUJ09W9C/N3FuyYWOlqN/Qe5Z9f3ySaMo2NDVCnApRunLTcs0VHVQC16+Auqw8mrFED8n/nkbnwTW6FUdHlzJaGn0O+jFwnIh5fqzpogLn4R8kttnRN5Y3FGqfrclcD6F8RBfGZMtXm5+7DLjDaSaf2Lw+Yh5kSKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkQzKBbz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759158135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUZ+nrFNJvugmnH/mfkTXbsSGFlwrwfUzJJqGCuNdv4=;
	b=bkQzKBbzz2VblCMwkfRJD36qlScaakkHdVJHJA4v84pJlirMIoCz3HTBUPkZtAmcd3P1Lk
	FcTgnbbG9oLPhWbN4LWwCf2rBFZgKe41isyIiQwxYlXTaC3KDGW21pKqsvX7gACoioFFvr
	Mcwiup1tF8Kx6KRDnfYuaFPtS9t5ijc=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-7QrtvWoBNuK8x3ehBOI7Xg-1; Mon, 29 Sep 2025 11:02:13 -0400
X-MC-Unique: 7QrtvWoBNuK8x3ehBOI7Xg-1
X-Mimecast-MFC-AGG-ID: 7QrtvWoBNuK8x3ehBOI7Xg_1759158133
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-89021b256a1so5802638241.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759158132; x=1759762932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUZ+nrFNJvugmnH/mfkTXbsSGFlwrwfUzJJqGCuNdv4=;
        b=XxxxL05mWwjg3L8Y4VM50QH29oNqX43SRK3rHynx5LKKltMkIncVGY6AddoYOO7Zkh
         6ggJQ8TahM3yoC+uUp6U1EyPAoeqdaGoEKVWStVSiPe3+O8F7QSov69QvLKzBqB7tCxM
         RwkXcEkvG4Kt7DpESOwNAs3V7Jm+PhFp518SpOtQ2HwDYruDOX+htAyL9UQ+GgSNqzZs
         m4Vsmne4HlZvpJH82u0tVafNw+zIyrmNqmRIqWpwK9//fvMZHcpuvObRrXi7rYVM3WVc
         AKHygZPGvv6oL7ArfilVTzhaxIP359pIwU7ttMdHBgYuYMKSdN8oNxKOnwvkJM2qDziJ
         uk7A==
X-Forwarded-Encrypted: i=1; AJvYcCV1Jx3L+mv5f3p2nJU+WbWSbUBfQ0v/1TXSl0oRW3Kshu54fEKDSa5ffJ8b/oka5zewEpXZbSEFPVgQRow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEplVWf94+sgaep0yRQzw/bpj52sLRvujABC4xnM/7te4c9YMD
	u8ceIntoNoHJhB0NovtE1XVOeewdUGK6ky+K8rsV0GxMCxejgPgMFkp7DvKEGC2NmQJ8ccXenXi
	TcBETu52EEwbe0LEZ5sLc8KYRm/Xy+lYxzeBCXAc3FMtCIxL5DpoQJzKikNimccTOpAIJXDdHsg
	idvn0Y+1v5Izy095IBzLA+BkOfF30nEYYeyIgun7+dti902UFR
X-Gm-Gg: ASbGncsvkrOXk1N3M9bcEqaIyPtYRGmCv5pqkddDRtDrTUcL36MHp62BIDZev7xcCyW
	ODfgUuv7SnbUh1NB3eO0nEZFWsNNlPYUZcLhrvfreez9oKl7labvadeULkIH6jBVUsw9QHvLeN9
	C1O553hS2pZy5JHtNtz/dDaQ==
X-Received: by 2002:a05:6102:2907:b0:523:d0d7:b963 with SMTP id ada2fe7eead31-5accfbb9a41mr4569875137.22.1759158125462;
        Mon, 29 Sep 2025 08:02:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5o3Fh5NHpfh14EAFku8FFD1FNX9jDym8l+iTw0lA93A8OiLv/2ttBnLrVEyNpSA/mfjaMgdkDvrTr7K9j8E0=
X-Received: by 2002:a05:6102:2907:b0:523:d0d7:b963 with SMTP id
 ada2fe7eead31-5accfbb9a41mr4569412137.22.1759158121642; Mon, 29 Sep 2025
 08:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926121231.32549-1-me@linux.beauty> <9f6acb84-02cb-4f76-bf37-e79b87157f1e@web.de>
 <1999588f143.5af31c76548207.2814872385181806897@linux.beauty>
In-Reply-To: <1999588f143.5af31c76548207.2814872385181806897@linux.beauty>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 29 Sep 2025 23:01:50 +0800
X-Gm-Features: AS18NWC9hza2cJywOXBBWmRD7SoOIndJhptqTfOzlEwDEiiwkjBlTEbkxaGHAk8
Message-ID: <CAFj5m9+FGzRV+fsWtsVSHV4JFh9Pit-KFHiKRWtMKBpM9LWBhQ@mail.gmail.com>
Subject: Re: [PATCH] loop: fix backing file reference leak on validation error
To: Li Chen <me@linux.beauty>
Cc: Markus Elfring <Markus.Elfring@web.de>, Li Chen <chenl311@chinatelecom.cn>, 
	linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	LKML <linux-kernel@vger.kernel.org>, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 8:54=E2=80=AFPM Li Chen <me@linux.beauty> wrote:
>
> Hi Markus,
>
>  ---- On Sun, 28 Sep 2025 21:48:23 +0800  Markus Elfring <Markus.Elfring@=
web.de> wrote ---
>  > =E2=80=A6
>  > > Fix this by calling fput(file) before returning the error.
>  > =E2=80=A6
>  > > +++ b/drivers/block/loop.c
>  > =E2=80=A6
>  >
>  > How do you think about to increase the application of scope-based reso=
urce management?
>  > https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/file.h=
#L97
>
> Looks good; I will add a commit to switch to scope-based resource managem=
ent in v2.
> Thanks for your suggestion!

Please don't do it as one bug fix, the whole fix chain needs to
backport, and scope-based
fput is just added in v6.15.

However, you can do it as one cleanup after the fix is merged.

Thanks,


