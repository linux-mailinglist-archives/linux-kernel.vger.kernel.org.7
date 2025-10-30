Return-Path: <linux-kernel+bounces-878964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23974C21DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294DE406EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730B2374AC9;
	Thu, 30 Oct 2025 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZckXw5vU"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D9348457
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851245; cv=none; b=JglL9/T0yOWczQmiN5Xd/vyKHk6zrQDmzRLxj6HN3VYPDYVOoWDFOV8rhI9wljVrruvnv7gJp+2qf6HrAsmkwicAd3V09Xc/88EehIRUM4ZQkBlhnj+aPYp6I3Vmr08B62I9/ZwhsZiKLDFAwDj/N9U3WX8fc6SmGwjv0KfnEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851245; c=relaxed/simple;
	bh=DvFyvNSh8qxl399ZX4Dvk2UH8sJtqfrtdkTSXiS2O28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhvmmUK47LM2o9ZM5g9n4QBpSx9XW6vH/oZMhJ3s3pgSbr4e95ue5TNFWYQeRPWcaEkyn4R8MtMQ3EzWxPKR5a/a6zyx85Dv8D2V8ENdjh5rom/LvuCIXmFWAsespEbGv4LFxYginoqBqrgbH0YQu1ujZ92ZwLtkC8xZqknxMsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZckXw5vU; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ecfafb92bcso65231cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761851242; x=1762456042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCoLCqthfjlxcZmXPuVo/a5TDaJzLCC0xdNynQX7McU=;
        b=ZckXw5vU0LXRw4K7WamRpYd/12eb909nfOJSCoI08y8xTLLYR3UlS/DHzw/12P+TVT
         WG9hLNIW8f5kI9IjFfPGFdWFJMouX0MULieJ838fZCCc1+PCDzM84UwKh4K1ij6ejU6Y
         xGE6IcMP/05CscvVqu/k/KQctwKgLT0Lk4Te+zPbS1RIYaNxHSKApG2/pfkSibhFMSsA
         eitOA0vQ2U4ni8qXfR7iJiFLC6lDYcuaT/zs2yQpKQ2yV4DgWKO0wAQ8dJYqW+3gCOQg
         rN2flXr4dd6UlmO7HwBbzO3VGPUlNaiUz+flcw9qqCPxtcGQF56uzothabnGPvYrXGFD
         dcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761851242; x=1762456042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCoLCqthfjlxcZmXPuVo/a5TDaJzLCC0xdNynQX7McU=;
        b=otC9x6mv3HH+VGEjEe9WyCbrzYtDivNN9QMnB7cktAIKUY6eTVLqvt8VsUVmjCtk+l
         Q83yIEZx7aBa+pf62GNXLyVRept68jjS1v35KqE5OgdADPo/QkF7Ug5XQO50/UH/hauv
         2dG7ulQ0Sq8ay4n3RovoHAfR9AgZcUG/CXztqHFjADiQHAQbukEWAsW8g+em1HaC8ZTu
         MmDC6IzUapaEySX6sCCWWIuwdDs+j2sYAwBtZBB8BRAN0CX3r6oU0tkxF/UAOrGFem+1
         mXQolc+dGMMOv9ejzUElTNLgTxxGOQFxk5grnJvDhUhBEFCR6PVI1fauIr8HHavb1YS1
         fEfw==
X-Forwarded-Encrypted: i=1; AJvYcCUI4vn5tJWkxiNphrltxXNkd4mh7mvt7mAFk4FFLKb9Nx9JSH8jw8+oXP/5j1tN74JNc3T3SpE+Unq+pUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38PFHNtr0hc2myO3a3p14/5XTj9tigBP7Ka/7Qw32ioUQebz5
	jQTbsPOvzQzCmHMnveQ1sA3t6vFWWSNGenH8mzFeKFhoGXdffplbPblWM5cMaQHGNCN1IkGXemw
	aI9JAQcubUKPCRFB0mdOYYNCLeZF98OBXTTxN/meR
X-Gm-Gg: ASbGncurR3dZSPXem6FxonOU7D7XaVJsopRzDYRLDJ7a21H1LZ0XQMrJqMZxwCcPy1V
	4IrQ+FMcg71cdrO5/ZHg1+XB1OIfcoWIvaOda3ct0IdpJuzavZoH+6Faiv0OPDJ56v1d+V901Wh
	wcB6Kox2/MActO4SHdzWNaLqfJ1H97/7FMnh8wsT0qQbkME4PrLakhiUvu+25txzA913//7mi+N
	mQo+b/mvfDkAo+mWyrJxwpr0vTMSjsmZ/AvlYbpCzh4W3r7G5sfTLeBAn8T9vsTTSrJw5pEUaDp
	6aJ7m1oDUxHc3Kdlw+3O4K1PKA==
X-Google-Smtp-Source: AGHT+IHkIhJCo7NFdaHLBFyJbonDCNFLcwrhYELkE6OW4OeZdx3rf5ADytg1g/CT0hOvRfBwqeiJwH0z6jqJ9LzJDkw=
X-Received: by 2002:a05:622a:2:b0:4e8:85ac:f7a7 with SMTP id
 d75a77b69052e-4ed31f3529amr938991cf.9.1761851241873; Thu, 30 Oct 2025
 12:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030171238.1674493-1-rananta@google.com> <20251030183120.GD1204670@ziepe.ca>
In-Reply-To: <20251030183120.GD1204670@ziepe.ca>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 30 Oct 2025 12:07:10 -0700
X-Gm-Features: AWmQ_bmODnSgIiguqq9wgyDj-h2iOZbOtTbAP3dhn7MpDJGiXfBAH1fV5zpiZRs
Message-ID: <CAJHc60yMgzQL9VT-K4GuDa7ZAYfNBi3Az3nnZTgd+RLYW+3iTg@mail.gmail.com>
Subject: Re: [PATCH] vfio: Fix ksize arg while copying user struct in vfio_df_ioctl_bind_iommufd()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Williamson <alex.williamson@redhat.com>, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 11:31=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Thu, Oct 30, 2025 at 05:12:38PM +0000, Raghavendra Rao Ananta wrote:
> > For the cases where user includes a non-zero value in 'token_uuid_ptr'
> > field of 'struct vfio_device_bind_iommufd', the copy_struct_from_user()
> > in vfio_df_ioctl_bind_iommufd() fails with -E2BIG. For the 'minsz' pass=
ed,
> > copy_struct_from_user() expects the newly introduced field to be zero-e=
d,
> > which would be incorrect in this case.
> >
> > Fix this by passing the actual size of the kernel struct. If working
> > with a newer userspace, copy_struct_from_user() would copy the
> > 'token_uuid_ptr' field, and if working with an old userspace, it would
> > zero out this field, thus still retaining backward compatibility.
> >
> > Fixes: 86624ba3b522 ("vfio/pci: Do vf_token checks for VFIO_DEVICE_BIND=
_IOMMUFD")
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  drivers/vfio/device_cdev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Cc: stable@vger.kernel.org
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Though I feel this was copied from some other spot in vfio so I wonder
> if we have a larger set of things that are a little off..
>
I could only find vfio_df_ioctl_bind_iommufd() in vfio referencing
copy_struct_from_user(). The other closest would be in
drivers/iommu/iommufd/main.c::iommufd_fops_ioctl(), which seems to be
doing the right thing.

Thank you.
Raghavendra

