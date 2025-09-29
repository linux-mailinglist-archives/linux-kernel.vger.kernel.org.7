Return-Path: <linux-kernel+bounces-835917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E527BA8576
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81CF3A627E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795C4264A60;
	Mon, 29 Sep 2025 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQJum7fI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24A1DE8AD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132598; cv=none; b=h3q3m/3yY2aaVCJ3+N6OCEId/pCjXBx2pwz6O7MH8VnKDEbxajByj0Ounq2CXXZuRzQmziDQD0YYoujpuud/L2wJQpmQBPZAVfINoSw3EO6H1akU+ObB73tAAHu41q3CjPL5wH4w8VwQq6ow2NfLk28i0W5MzRcP7ljk8l8rtPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132598; c=relaxed/simple;
	bh=sWOVusL7EvxSTeXMYcYJrEbLpqwpAufzB9zqoLkNFt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXr5Jrmiwmpt2gjd0BsWMgqHiV18ejtYK/mKsDb5Xm52KtrDoWifYNfYQgtViOZA7N8bOgRfOwOXaaxbhJqQPOiE4g6LgXnLQtzOTDSIM29q5e11nCFXKtoMgTfF7PHyHdrZk5CJ7AB+eC3nnbo1yYnnEmFm8FCBfhGQGMT4HIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQJum7fI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759132596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CfcWpYXomlJbET3NgLmWYr8bB6pAdVPNYM0EnAdbrUo=;
	b=XQJum7fIUbEJfMCNexFLsV3qW6S9ujJ0aeQlokYdKIydBnDgXsTtK2xkyl64CpE2COUuKW
	L//DcJ4TDXvVEd7mkJsj4VKat2DaFUxG3vSPBjRb9ATbNcHiKZMM/QGwz8on6Qtu3bwkwe
	rx+F1F/m8p3ifvNW/piGv1RPGmCkG/c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-W53CWY6DMnC7Q7sBYB4imA-1; Mon, 29 Sep 2025 03:56:32 -0400
X-MC-Unique: W53CWY6DMnC7Q7sBYB4imA-1
X-Mimecast-MFC-AGG-ID: W53CWY6DMnC7Q7sBYB4imA_1759132591
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so2093545f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759132591; x=1759737391;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfcWpYXomlJbET3NgLmWYr8bB6pAdVPNYM0EnAdbrUo=;
        b=Q73H4cL1Qz/5HZ4aem3XMjs9VC+KjjCnzCQ8LZVnF0D9YAPIOrkPAoiRJKzS6Z6RTs
         XQ/jM6ew7w+r1PiA0or95uM4usT3IUXOHFLtYTJ4pzLYU8MHALQjDjTdVGpfce0YzO/0
         zdyKQ7qAhipRSy3+zuNExQwU5vUlLF3eg0+MiM9C96wCzppmhgOBNnMfjk2RiYz/gIAg
         yD+BdqmR8WTm5Pj7et5XwpthyoiGRBxGqy/IfrnocKqUGJcEoOdez9dyVwbfir6BqcoJ
         U4UHzT+mUncAoW/pXntj5EPDsbBNeDaXPfNDkP1d6egp0tPx7JgjAnQEROkv395c37tU
         sYNg==
X-Forwarded-Encrypted: i=1; AJvYcCVoWo4okrKDF7CNPZ2UdqUcKlpKsII21eUzJk6geqVVV/hKp4VHkBEQDtLqhWAEnnyWx+u0QoiQj87XZ0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBgjCyz3yEJPFMQch8kl5RHuQqE7IKhnnU4U+aeJfUzjSxCH4
	qa2gJQyXbwDuiYaDOqxD6K75f+ALO2H4ldbYYLQolnmKfmDdDlofiR2UTWPFzKS8TIUq8oQ5Dea
	LGQrnxWPzVuI6RLUwHBmD9xWJC6lrUqYrtBwFnHO4xZoLo1LYXImJ+KPSpbGYICRetw==
X-Gm-Gg: ASbGncsOTJ7B/pww48wUwSbzT2ak6Aw3OyLVz/73DQvx26SnFZ9QWkTF9qDc7L2/lp3
	2oxwa6wtpDJ9UNGiE5UwTfQqXzlCoh5cEORpwpXANB9kpkeqm7mMYFn0bZtcy0oRMyZjSTkwy6m
	l9YoYwsM2fVihHWvqTVtP1tbnCAjJmBdAgstmpQ+tKT1OUZhguEzFF9OuN89O8AcePEgixiEHtS
	zkHWXlRlSZnxTeAYuqHjWZ+1hhSDNx6hfkLs7EbATcqw3+rnJsmqn3nYit5dxD5mBnbodmV4oKD
	rud0n5o4jpG1+dU9QJ1uDFLYEiIGZM2S0g==
X-Received: by 2002:a05:6000:2486:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-40e42502e25mr13992514f8f.2.1759132591246;
        Mon, 29 Sep 2025 00:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3u7Fng3Kymf2Ta2mHeAgLg78qvIklkkslGuwqTeY5v8ysKjPMZWXtHZMLOHDUtDUaPaKw8A==
X-Received: by 2002:a05:6000:2486:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-40e42502e25mr13992495f8f.2.1759132590868;
        Mon, 29 Sep 2025 00:56:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm216565635e9.1.2025.09.29.00.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 00:56:30 -0700 (PDT)
Date: Mon, 29 Sep 2025 03:56:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 0/6] Add multiple address spaces support to VDUSE
Message-ID: <20250929035620-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
 <20250926103421-mutt-send-email-mst@kernel.org>
 <CAJaqyWfeiAiNOBtGoEYK7PLncXLMO+wZ=Gse+=X0FO65qQO4LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWfeiAiNOBtGoEYK7PLncXLMO+wZ=Gse+=X0FO65qQO4LQ@mail.gmail.com>

On Mon, Sep 29, 2025 at 07:41:13AM +0200, Eugenio Perez Martin wrote:
> On Fri, Sep 26, 2025 at 4:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Sep 26, 2025 at 12:14:26PM +0200, Eugenio Pérez wrote:
> > > PATCH v5:
> > > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_FD
> > >   ioctl (Jason).
> >
> > ???
> >
> > I think copy_to_user returns an unsigned value: the number of bytes copied.
> >
> >
> > static __always_inline unsigned long __must_check
> > copy_from_user(void *to, const void __user *from, unsigned long n)
> > {
> >         if (!check_copy_size(to, n, false))
> >                 return n;
> > #ifdef INLINE_COPY_FROM_USER
> >         return _inline_copy_from_user(to, from, n);
> > #else
> >         return _copy_from_user(to, from, n);
> > #endif
> > }
> >
> >
> > so, how does the patch work then?
> >
> 
> copy_from_user returns the number of bytes that could not be copied.
> For example when the object size in the kernel is less than n bytes
> long, check_copy_size returns false and copy_from_user returns n, the
> amount of size requested to copy.

oh, right. thanks!


