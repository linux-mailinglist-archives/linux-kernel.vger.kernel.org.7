Return-Path: <linux-kernel+bounces-781893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B90B3184F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04100AE035D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0072FE56B;
	Fri, 22 Aug 2025 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pho7/G9j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8A2FD7A1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866985; cv=none; b=HoKGth7zrUTnOzgKmCljmoZvEsaTMTfS9EGuAwUzqnAR5YsJBD77EgbgS3kF3wF4fQvs2CMjYcM0U1JB7Os2MZyDrXzzrNmFlJJn9NLlJaSgoIPyNhXwf56EFFbC9ChMaJwP8kKS2QibEt47lQffKdEaXzAWaB0M9r2Z0PXG3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866985; c=relaxed/simple;
	bh=YYE5x3rpclM2L3Vjf+QXn3YHsE6nuL4ZAjscgygCnLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPpgeBPQ/5yzmyKjVDNP5hgssr5c4LC5bnfUwK1srQe04Ayets6WcBwL9V3KCkCmI/eutjjxlCHHVj1JW/EBoBW77eMC2IcC+DOIbQybpf/1T6gE3aoQcRGij0xBDlwgOLSDnk8LdH/YLpPBv0rIz/T/Kl4/pjTlr1ckCS2aqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pho7/G9j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755866982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbVxxqHKodZYFsug0blUFZKne7Mtc5nkor9jm2rzIMY=;
	b=Pho7/G9jyAt8LZt7eOBxTSeIQqUI9H9BBj4uHpAfunYT1ZI37qcxCH02o1jXXyk6y20Pnt
	TCBBX++S37NR4OyXlO35y9edltwYKn9dTyFH7pcgv5T/LBEmrylLqKHIfEYuOdejoZ6wx/
	uI8hx9kx9yPQ3WYm5w0+tsLfWqUDrMc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-geT72bJSPQyKpgqxiH9UZA-1; Fri, 22 Aug 2025 08:48:33 -0400
X-MC-Unique: geT72bJSPQyKpgqxiH9UZA-1
X-Mimecast-MFC-AGG-ID: geT72bJSPQyKpgqxiH9UZA_1755866912
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b10946ab41so51150961cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755866912; x=1756471712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbVxxqHKodZYFsug0blUFZKne7Mtc5nkor9jm2rzIMY=;
        b=aUNVDaL9ncPg0QJG3uErlrae6MOoBwwAzXRcfN2+X80RYxcP0l4sJKmfrW4t94s9rt
         RWbRF9UNpWlE5UJHJ1KgphrLOIyD3gad1s0ne0euYJj4dLo4JXUPApdFsyCkIlFlAG3M
         BIO2jEpTXE/gHmEtR6LRcr5baCvl/HfwdOVTC3cH3HjGcmnbm1V6ns8Q1iAQb30/STXL
         f67JUSVNMJkWoAfhSTan5meym4wzRP22fCpSvwjxmL8zIWmQAZ5zQal60I9Sz0Ebjdxc
         QNmXzFVV2FEr2mnoDQgK+NT10UfwtwKiQ7O0FIPpvZqvweSI6JlEm2VOOCBkgsK5Lqfo
         ltjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX33BSN9VnfDA8Y7+ChFIxGJot3UFgwcqgtQ9tZIwZ8iAtFSgxZxnofFq2U9910NCJS/4mvgAKIsFs08zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8EnyJyxcUSJ8LXncCvJLVIsh8bk+m8+1tTg4AHsoBgScGOGD
	9CGVlyuyqiFHCGEeoE388FNI0bj5XIZwZq6Fg2pr8RCLtY5zLlWqgHa8HCi4jHr5W9bc28uCZfE
	9LGpcRnkHXDXktIrFeZwi8jddphCer3oEh2rLjx6CmPkTH4EG44AxDrLuxW3X8r2gbvBU1kwhAx
	ulz0t2GFbEf7VOiP6oH4IbqZ1reBywI65ChjMrxzZ7
X-Gm-Gg: ASbGnctOxVny6qdF/eIw3fPP71QvNeH+FJcCXf4cfaGYNkAYl3JNtxMghHwbqf2jQz1
	+dA3d49MxbN2MWZJyceTbsIaMf4QcPNIICyG0KxXKMEjNGyI0hDIqEHpjjG35N5fqiF13qLGxnP
	Cyfaa3jpjX5gELIs0Gmj7nXdtylyv7H+BE9YFXc3lFThyUAvkz9a8B
X-Received: by 2002:a05:622a:2b06:b0:4b2:8ac5:2594 with SMTP id d75a77b69052e-4b2aaf88157mr32970461cf.39.1755866912309;
        Fri, 22 Aug 2025 05:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGclQR87zmWeT+VM3r9gdWgWNuVTR3jL5gvhn+oOXtGpF8D4a5y/GyCDWpLgzvoOApqTGx9rQ3k9v8uTyYsc/g=
X-Received: by 2002:a05:622a:2b06:b0:4b2:8ac5:2594 with SMTP id
 d75a77b69052e-4b2aaf88157mr32970021cf.39.1755866911689; Fri, 22 Aug 2025
 05:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815121459.3391223-1-lichliu@redhat.com> <20250821-zirkel-leitkultur-2653cba2cd5b@brauner>
In-Reply-To: <20250821-zirkel-leitkultur-2653cba2cd5b@brauner>
From: Lichen Liu <lichliu@redhat.com>
Date: Fri, 22 Aug 2025 20:48:20 +0800
X-Gm-Features: Ac12FXwQJbPmbQRxMp7qGDkCOTeicgMXQCgW-fagYfwyy8_vEsAkdFyogKGO5Zk
Message-ID: <CAPmSd0MikBnSRvMvb5eTa=WZrfsjP-Wy11PSCRY4X7u4=T-bUg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	safinaskar@zohomail.com, kexec@lists.infradead.org, rob@landley.net, 
	weilongchen@huawei.com, cyphar@cyphar.com, linux-api@vger.kernel.org, 
	zohar@linux.ibm.com, stefanb@linux.ibm.com, initramfs@vger.kernel.org, 
	corbet@lwn.net, linux-doc@vger.kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for reviewing and merging the code!

I used "rootfsflags" here because it is shown as "rootfs" in the mountinfo.

My opinion on naming is similar to Rob=E2=80=99s. However, for me, the func=
tion=E2=80=99s
implementation is more important than the variable names, so I don=E2=80=99=
t have a
strong opinion on this.

(Christian may see this message twice, sorry for that because I clicked rep=
ly
button instead of reply-all)

Thanks,
Lichen

On Thu, Aug 21, 2025 at 4:26=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, 15 Aug 2025 20:14:59 +0800, Lichen Liu wrote:
> > When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> > By default, a tmpfs mount is limited to using 50% of the available RAM
> > for its content. This can be problematic in memory-constrained
> > environments, particularly during a kdump capture.
> >
> > In a kdump scenario, the capture kernel boots with a limited amount of
> > memory specified by the 'crashkernel' parameter. If the initramfs is
> > large, it may fail to unpack into the tmpfs rootfs due to insufficient
> > space. This is because to get X MB of usable space in tmpfs, 2*X MB of
> > memory must be available for the mount. This leads to an OOM failure
> > during the early boot process, preventing a successful crash dump.
> >
> > [...]
>
> This seems rather useful but I've renamed "rootfsflags" to
> "initramfs_options" because "rootfsflags" is ambiguous and it's not
> really just about flags.
>
> Other than that I think it would make sense to just raise the limit to
> 90% for the root_fs_type mount. I'm not sure why this super privileged
> code would only be allowed 50% by default.
>
> ---
>
> Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.18.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.18.misc
>
> [1/1] fs: Add 'rootfsflags' to set rootfs mount options
>       https://git.kernel.org/vfs/vfs/c/278033a225e1
>


