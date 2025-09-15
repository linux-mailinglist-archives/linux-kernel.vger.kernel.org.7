Return-Path: <linux-kernel+bounces-816354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EF0B572C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FD7189310B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979CD2EB862;
	Mon, 15 Sep 2025 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYMNX5zN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893142C0292
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924536; cv=none; b=kt5SsLp5/ZMSyyMpTHQU/d+4XZULWVp3G2NAyk+/SYTpPe8mnjUtyrzrfOH2fHqgfPBd3T3a0gEKkD5bXyX0v4gLmlFnJ2ev4rPXM5tFpS/yXMkXX1S6RdMbb9NrfbSurYvayy/9UF2z3IwHsGXtBeesMgQ9jnzNUpdHAWREUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924536; c=relaxed/simple;
	bh=7gOJ9B8QwFl0uqXrV6UW9f2cRGBcxSUQ5tkUncDy/Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URCmLu3Qw7Z2tBqAWsIs0WDVQZkgn4cNmhD+QsIs9sVgED4ywUrAqliak0EklSMnWIZU9PuS/XJUhENxjeHr6QGEjY7FqvvKQGsioSICbSwAtsu05YzU+/KEDgRnzZY/TvN91mLNMCqtFbIqsSJ/NbnwfheC6EE4sMkkPpo3OPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYMNX5zN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757924532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7gOJ9B8QwFl0uqXrV6UW9f2cRGBcxSUQ5tkUncDy/Q8=;
	b=AYMNX5zNkEWzJ7zfxIpZ/hb0xU+M9QZnFBcwWMgTGKxQ/v2WWsKJkr4ULKBJJT/XwuW0+0
	m8FIZkxswjFMc0cmeZQ5OsasaoO8REh75R0UheB0QM9Yq+jj5qpKM9az62h1SLgm5HBZwB
	3rnSd1m0a8aRB5iI5jrPfvoH0HTTS0Y=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-ysKR_bMrPlyhdGvVEx5sWQ-1; Mon, 15 Sep 2025 04:22:10 -0400
X-MC-Unique: ysKR_bMrPlyhdGvVEx5sWQ-1
X-Mimecast-MFC-AGG-ID: ysKR_bMrPlyhdGvVEx5sWQ_1757924530
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77283b2b5f7so6373690b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757924529; x=1758529329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gOJ9B8QwFl0uqXrV6UW9f2cRGBcxSUQ5tkUncDy/Q8=;
        b=HxI4y27ARxo39fkuG+R3w4oPNsRlFbgyaGrRAD0kPNs0nCrKpgfaS+amT9UMoOBKc7
         vktB+2nGcIPjMhS/1/XKe1lOn3sXlAjblJ8W6qsOgm5seZv77J33/KCHD6WBBJ/+X0Po
         lQtJLyBKJtFql4f8T2hbABIRPMe2SvNF7tyYKQRHu+oWH6zlEK41H5a31g2JWcRPv4Zy
         vDeyOM4kriAl4xAd1nz5BaLpod86uUphIBRYkjSfTbIJEa5pOWzb9cczC8Jr5Mq0Jpv+
         O/3eyRwB5neCgwo4RZA3Pvmxq4sz5bYKgGIDR2ZvkbXVRro2HNb6B92VgFme7ZIdhlUQ
         9Pfg==
X-Forwarded-Encrypted: i=1; AJvYcCUEsFukr9H+GsHYhk6QfLQikLUgJBzyajgfWBS9oHetY06Evtv938n/hZk2eCkAi1li/V79xMnaIzVNs6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLDNcXFxpYqa5GX/G6b7NG05nkOzuHpu6bJxU4BRM6xNHGKyN
	zRXkD1CGtc1rIHxcp0hX+3ZdKsSXDw6f1PFXsHxbUXluk6rOi9EnkurxS4CyiEteo6SkvQUQEcW
	m9q9EZg1dfRhuU1SfcjVccg7Tlsq7E2+KNF2E0K/PCHJIydSIJLqFQQveGVTyLr225zNsUb51MQ
	l9K3gODaBfIMf60Kq+Z/jWkj3jpQnjm8Hb6BqN20ea
X-Gm-Gg: ASbGncuPxb0Kp4OBVyMGFvewxaS7Ii5jDZDUbKu5Q5+5w4d0HxZeJy7Jj/NhcHvSjaV
	TD+wZR5RHwoimOHyfAqAU5KxBWXIxAUCLGep6AF+pEjdN50Cwwz2cJXGqIK3cH9G+335AcSBO3j
	vUHIge+kOogA7x9xHrcOx2
X-Received: by 2002:a05:6a21:339e:b0:264:94:3f5c with SMTP id adf61e73a8af0-26400943ffamr2934971637.25.1757924529731;
        Mon, 15 Sep 2025 01:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhfvI1qfGeK2cL0KlkdSylK5HkSUKW7hLP9dtt6BGBk0eKte6rAQM80xtdpM9B9QKyHyvudAhZE0QpVQSgpOk=
X-Received: by 2002:a05:6a21:339e:b0:264:94:3f5c with SMTP id
 adf61e73a8af0-26400943ffamr2934951637.25.1757924529386; Mon, 15 Sep 2025
 01:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
In-Reply-To: <20250915073429.54027-1-sheng.zhao@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Sep 2025 16:21:57 +0800
X-Gm-Features: Ac12FXzF3ZG4oBSmyEat2dYzan_yR9R2_8XYd-pPpVSxohzmkUbNAFM28bTPxpU
Message-ID: <CACGkMEvWNOjFU0pgiS=LF2B+yEC-y_RU3w_P5_dr10RPH+5xrg@mail.gmail.com>
Subject: Re: [PATCH] vduse: Use fixed 4KB bounce pages for arm64 64KB page size
To: sheng.zhao@bytedance.com
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 3:34=E2=80=AFPM <sheng.zhao@bytedance.com> wrote:
>
> From: Sheng Zhao <sheng.zhao@bytedance.com>
>
> The allocation granularity of bounce pages is PAGE_SIZE. This may cause
> even small IO requests to occupy an entire bounce page exclusively.

This sounds more like an issue of the IOVA allocating that use the
wrong granular?

> The
> kind of memory waste will be more significant on arm64 with 64KB pages.
>
> So, optimize it by using fixed 4KB bounce pages.
>
> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>

Thanks


