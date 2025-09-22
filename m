Return-Path: <linux-kernel+bounces-827882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54753B93585
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB32D1887012
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56D82FC86F;
	Mon, 22 Sep 2025 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HzNYUF0C"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265B283C83
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575392; cv=none; b=dS+oMi4RAuSkVrnCAD3MKzMk5cUlAmz8L3fVnnKYHiSHG7pNSXtzlvQ9lY40xm1808LZKBESZgZVNAUbfnAfGDseDRz+2UuZBHcro9TXAA6alMc5Xp26mkCJsRZqOLGKzumtWLSRN7UAWo72HmGfiB1IxN2b/IHwAaU4LrX2TPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575392; c=relaxed/simple;
	bh=8FfsMBJXaP1G1sQ2HidWtn7ujJU+KhdHP65thFW6hrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqClNLFTI+8NtZFzDf/ofErRvjrfvsiGjsLfBFk8n6qXO0SvmVxCLGJ77/HC+0Lxdv+iZBl9pWUVXUN3rDPye3I4lCSBKD0ThMaqWaYJFncNNvAX+ed2rmQrrB4oX999+o6WuPe5gkPPbNPvcFSv/vb1Bu41cdg7uNCJS9AdMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=HzNYUF0C; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b5f7fe502dso26147011cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758575389; x=1759180189; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aIOP0jY/+X/9DN9f80nfhBWfHor4awN8nQUrjS4FFGg=;
        b=HzNYUF0Cc0Y/ldmPM1nCVfeIGKSJbpBEoPy4KJYn1lvkuEwwKGmocW/2LnnUQE4dyI
         1cYbW1w/ZqgoacYfd/Zxzp3jceABfxzGXDXcteL32yOpBV530YUFNi8CFDombdDwiCA/
         n0xT2k7yhg+7Il71Sil4qMY5kBy/nG+W2dfLp97ptija3CelvCtIB25PCFc0V0XcX+M/
         Nup7zwSwMziXSjI2vWQXFr9mwlZcc9iTaFZkkpQacyRL07rDaQn3CNAX3rpRkqOku2zw
         gAc0hXHC787MniLYbYu5ycRGJjIUTrUFtMY5jEzO7yO/4+9HWPZ4aK/DmqrDInDU/4vM
         Cdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758575389; x=1759180189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIOP0jY/+X/9DN9f80nfhBWfHor4awN8nQUrjS4FFGg=;
        b=lHgfJULjFqLIu+2uFzBBRpz5+A1D22FzBxhoP2LsRFE2RHnrR0bx8LIqkhx1YlEIF1
         iCDcjY0aFbohljzwjAQhQIqkpu0FYDy0spLYV525rPjeiG6HQq+Cm7JPJIikbZ2GwlXq
         EkVPgJ9cpCN46C0MGs//2n3e2af/HXJkmqFznSBWM1RGM6Am0E7e5GgGURvoMpi3BDpJ
         zDzjARH79gVH2wTLKHk05QrQ2+cJ72vjSoyLvgMQR7tM0NVQbMcgSqX7U2H0qd1lPci2
         zjHFBTAcf13ZvFigp932cYPdXssBZatOuHWMj+5NCWWvhqhFQ0EKhWhl9Ojl7gFQMm6M
         +t2A==
X-Forwarded-Encrypted: i=1; AJvYcCWbCptGXcKw3XxxXEn3FizOw6kqTvF2zhv+KoCB4+Bg5PQEi4qHRJQ2qEX4lftwHJJGQzFTPD8qQA83kc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypWb1rPL02RHa+3wxaget4yOWlPsULFktE1ipS6DeXs7EzZwJv
	4rzmwDx92M2B4WmlQ17512/AiktsBfFH1sLmpw/BmHq4s1oo/0DH0W9UyX48ErHaHs3d3Xv4DTQ
	1oghi315Tv14faKjy8IUxTnTd35YNK69JYFLBm+0nTw==
X-Gm-Gg: ASbGnctnQgh55Dy6t+3JolTWP6qXh0Ex6Ye00Ylyz8TlZfkegw9hh7j8gorGeWXENj7
	NQC/V7jAJn1W5AIAxL/8lBzXznnbOIRPzpvUCEqArp7GtWfON4uGGPvBE8ojt8NJXf4UNfUJJ4R
	wGqSRp5YjRu9nq6qvPziB3joCyW3xhRlT+CHVMHuOKBUz5ma69KCMzvXvF1XYcJFfdTCOS9a+3i
	R6F
X-Google-Smtp-Source: AGHT+IG/qgae5Me0ExwT19ZtCSc7WJPaTAk40SN+WOTTYohTOQCqtXZFZ8mCtUhw0BmokKMxl2aqS4C1ND0ndsRc4Xg=
X-Received: by 2002:ac8:6f07:0:b0:4cc:48c0:adfe with SMTP id
 d75a77b69052e-4d368a800a4mr3604971cf.30.1758575389346; Mon, 22 Sep 2025
 14:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-17-pasha.tatashin@soleen.com> <20250814134917.GE802098@nvidia.com>
In-Reply-To: <20250814134917.GE802098@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 22 Sep 2025 17:09:11 -0400
X-Gm-Features: AS18NWCsBRxoeYSv5S_-rUt98UUe9gxpk-iBTnQrKdXEdTrrgwXCgW39zL3zdf8
Message-ID: <CA+CK2bD68E1-AWxz9p-Byyb=fDVQGu4Q+GpW2ogCNdjCxbAJqQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/30] liveupdate: luo_ioctl: add userpsace interface
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > + *  - EINVAL: Everything about the IOCTL was understood, but a field is not
> > + *    correct.
> > + *  - ENOENT: An ID or IOVA provided does not exist.
>                     ^^^^^^^^^
>
> Maybe this should be 'token' ?

Yes, replaced with token. :-)

> > +struct liveupdate_ioctl_fd_unpreserve {
> > +       __u32           size;
> > +       __aligned_u64   token;
> > +};
>
> It is best to explicitly pad, so add a __u32 reserved between size and
> token
>
> Then you need to also check that the reserved is 0 when parsing it,
> return -EOPNOTSUPP otherwise.

Done.

>
> > +static atomic_t luo_device_in_use = ATOMIC_INIT(0);
>
> I suggest you bundle this together into one struct with the misc_dev
> and the other globals and largely pretend it is not global, eg refer
> to it through container_of, etc
>
> Following practices like this make it harder to abuse the globals.

Done, good suggestion.

> > +struct luo_ucmd {
> > +     void __user *ubuffer;
> > +     u32 user_size;
> > +     void *cmd;
> > +};
> > +
> > +static int luo_ioctl_fd_preserve(struct luo_ucmd *ucmd)
> > +{
> > +     struct liveupdate_ioctl_fd_preserve *argp = ucmd->cmd;
> > +     int ret;
> > +
> > +     ret = luo_register_file(argp->token, argp->fd);
> > +     if (!ret)
> > +             return ret;
> > +
> > +     if (copy_to_user(ucmd->ubuffer, argp, ucmd->user_size))
> > +             return -EFAULT;
>
> This will overflow memory, ucmd->user_size may be > sizeof(*argp)
>
> The respond function is an important part of this scheme:
>
> static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
>                                        size_t cmd_len)
> {
>         if (copy_to_user(ucmd->ubuffer, ucmd->cmd,
>                          min_t(size_t, ucmd->user_size, cmd_len)))
>                 return -EFAULT;
>
> The min (sizeof(*argp) in this case) can't be skipped!

Done, thank you for catching this.

> > +static int luo_ioctl_fd_restore(struct luo_ucmd *ucmd)
> > +{
> > +     struct liveupdate_ioctl_fd_restore *argp = ucmd->cmd;
> > +     struct file *file;
> > +     int ret;
> > +
> > +     argp->fd = get_unused_fd_flags(O_CLOEXEC);
> > +     if (argp->fd < 0) {
> > +             pr_err("Failed to allocate new fd: %d\n", argp->fd);
>
> No need

Removed

> > +             return argp->fd;
> > +     }
> > +
> > +     ret = luo_retrieve_file(argp->token, &file);
> > +     if (ret < 0) {
> > +             put_unused_fd(argp->fd);
> > +
> > +             return ret;
> > +     }
> > +
> > +     fd_install(argp->fd, file);
> > +
> > +     if (copy_to_user(ucmd->ubuffer, argp, ucmd->user_size))
> > +             return -EFAULT;
>
> Wrong order, fd_install must be last right before return 0. Failing
> system calls should not leave behind installed FDs.

Fixed.

>
> > +static int luo_ioctl_set_event(struct luo_ucmd *ucmd)
> > +{
> > +     struct liveupdate_ioctl_set_event *argp = ucmd->cmd;
> > +     int ret;
> > +
> > +     switch (argp->event) {
> > +     case LIVEUPDATE_PREPARE:
> > +             ret = luo_prepare();
> > +             break;
> > +     case LIVEUPDATE_FINISH:
> > +             ret = luo_finish();
> > +             break;
> > +     case LIVEUPDATE_CANCEL:
> > +             ret = luo_cancel();
> > +             break;
> > +     default:
> > +             ret = -EINVAL;
>
> EOPNOTSUPP

Ack.

>
> > +union ucmd_buffer {
> > +     struct liveupdate_ioctl_fd_preserve     preserve;
> > +     struct liveupdate_ioctl_fd_unpreserve   unpreserve;
> > +     struct liveupdate_ioctl_fd_restore      restore;
> > +     struct liveupdate_ioctl_get_state       state;
> > +     struct liveupdate_ioctl_set_event       event;
> > +};
>
> I discourage the column alignment. Also sort by name.

Done

>
> > +static const struct luo_ioctl_op luo_ioctl_ops[] = {
> > +     IOCTL_OP(LIVEUPDATE_IOCTL_FD_PRESERVE, luo_ioctl_fd_preserve,
> > +              struct liveupdate_ioctl_fd_preserve, token),
> > +     IOCTL_OP(LIVEUPDATE_IOCTL_FD_UNPRESERVE, luo_ioctl_fd_unpreserve,
> > +              struct liveupdate_ioctl_fd_unpreserve, token),
> > +     IOCTL_OP(LIVEUPDATE_IOCTL_FD_RESTORE, luo_ioctl_fd_restore,
> > +              struct liveupdate_ioctl_fd_restore, token),
> > +     IOCTL_OP(LIVEUPDATE_IOCTL_GET_STATE, luo_ioctl_get_state,
> > +              struct liveupdate_ioctl_get_state, state),
> > +     IOCTL_OP(LIVEUPDATE_IOCTL_SET_EVENT, luo_ioctl_set_event,
> > +              struct liveupdate_ioctl_set_event, event),
>
> Sort by name

Done

