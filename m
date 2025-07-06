Return-Path: <linux-kernel+bounces-712620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DA8AF0C1A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 08:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6491C02119
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 07:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FC4225A47;
	Wed,  2 Jul 2025 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEqnz72S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68389224244
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751439580; cv=none; b=uvyGNYdpMHWeNiorVogP+Ak2a/JE3Q29Sl9mwgFgWDxfjdV/B5Jh/uu+fsC+o5sCpkJ55LINxCyx06YWpNUiO8mxinBvQBHIWoZDaGp2TRJO+GG+LepTxDSoe0IrY0XFM61Y1WK76xxQTnkSWKxQbZlcpv0KfREdyCQcwSkmE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751439580; c=relaxed/simple;
	bh=FuVYA1DBsUs8nHuz1QNLYEtINvz/XpKrOjhWBEaED8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBynpx2c4KcIJIBgcxxQNfY+xpV0+E+k8JlxNE6QaC5tCk8uo4uEBWEEUDy7U1XjX7Yc0qVCk0fP1g7Tp0lYrGDP5rtE2jhwFxCYP5jD7i+ANY/H8s4Mc88UhuulRuB4GmmR89HlBgel1mAbIbzhlr4H+Ond7nxN6HakX/Pkr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEqnz72S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751439577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9oktXAsQiQp5i7sShP6Y80qG42xcBA2kpSrzl21Pw1E=;
	b=XEqnz72SmnVD4BbsnT0PEkgzUfohFQtMpE+5fgfAWcUG1SGNNsJd+UtVQ2yR1w/hyp+mBg
	/8qTE8DY0phVQU52pJrywTr6/leCUyR7IuWk8uLPY4+O5bXGvEG5kZw1yX9+mGqhJ7wjfs
	n5wBgxnf24dL6rYBc7FAqx/M4wnUkc4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-Ife2ZeUQOdS3DLaxIASs0Q-1; Wed, 02 Jul 2025 02:59:36 -0400
X-MC-Unique: Ife2ZeUQOdS3DLaxIASs0Q-1
X-Mimecast-MFC-AGG-ID: Ife2ZeUQOdS3DLaxIASs0Q_1751439575
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7425efba1a3so7430128b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 23:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751439575; x=1752044375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oktXAsQiQp5i7sShP6Y80qG42xcBA2kpSrzl21Pw1E=;
        b=mKg0ucaGN50fc9iF6itQIfSJgaeugxoFY/LQRp9Fz9E6EVpjMOiqR/HFsTlo7vvscC
         HhgCkr8/JzeK/YmtuKxX+SplMorkfZsKJD0UyFfnhCN2eMckje+Pwy9Xn6g9lMuOIRn2
         yI2zWEA2lHCPkzdXrInHh2hp0dEZ0JeqnkXzXRuWERGaUI/cwAG+E2ZnX2Vi1YyIloW/
         OomzbIvloOIaGgxO6QA2kylIw0/MPQuLd7DNOMFwV7Krjeg6WBdC2apKnMFiwMfSN95t
         NbgC455eIFMz/293p68DEfEKlbHIejFo++Ef3rtRNWvh8TNhUTQ6Wuac3pQwUM4c3n37
         dAcA==
X-Forwarded-Encrypted: i=1; AJvYcCWpSLsLOtR5qkQmR1vZvbLohw2hnqUkKMrHsWRc3ZRECkFBMu6rF8Ol5pOOk+hoCDFnskegluaIu6cO43c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgq5bWdJGGUgtNJ9XtIK+uo/phHgDUkqUiaZL4m1Koe9w4rjgM
	mEV9/SGmue94iNh6ohw8vTMOZvOn+24pNrw3lYoOnvvmxAl/R60t//nS/GNCFwudPIMykwxCHV9
	hkmgsivqLMhjYG2NTU2mL1/CaknF0f/7NHZSAGuh3txxpuhbdpNuNcyR0Nf9Er3oFT/a/KNPgAF
	dJqM+GfNrDG4qIvr2lqJgGz5NkbA1Vub9pcGtENaGR
X-Gm-Gg: ASbGnctiNnFv82PfEu94O5vBrriHgu8/XozEm+gJ467pk5Yfibiiu/xwPmcspZ1trVM
	GNzQ0T/RlaPLQviBvkxusoF04Q0kyDinBjksvlF/4yGe+yPW/voirPq3BfgoBDZVq+iJPR7su39
	8s
X-Received: by 2002:a05:6a00:18a8:b0:746:25d1:b712 with SMTP id d2e1a72fcca58-74b520c7795mr2076717b3a.7.1751439574923;
        Tue, 01 Jul 2025 23:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs7ktrYM9fwj/23hUCctOhF9JiJbm2p5i56/LZ5EavRIaEm0fNI4z9W3n/6Xdc5OGC8rN13n7jqzjq8exUvhQ=
X-Received: by 2002:a05:6a00:18a8:b0:746:25d1:b712 with SMTP id
 d2e1a72fcca58-74b520c7795mr2076679b3a.7.1751439574437; Tue, 01 Jul 2025
 23:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701011401.74851-9-jasowang@redhat.com> <202507021212.rhQmuuvi-lkp@intel.com>
In-Reply-To: <202507021212.rhQmuuvi-lkp@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 2 Jul 2025 14:59:20 +0800
X-Gm-Features: Ac12FXxiZW_D57LUa3xpUl0ycvSaJSDuvuQ1l02cBG4QNnzDlhokAJCadnvHiDk
Message-ID: <CACGkMEuu=qw4GMzM9x=WdYEaVBxQEvEq2mYKtQZiQFYocgmgWQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] vdpa: introduce map ops
To: kernel test robot <lkp@intel.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org, xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 1:21=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Jason,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on mst-vhost/linux-next]
> [also build test ERROR on linus/master v6.16-rc4 next-20250701]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Wang/virtio_=
ring-constify-virtqueue-pointer-for-DMA-helpers/20250701-091746
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git lin=
ux-next
> patch link:    https://lore.kernel.org/r/20250701011401.74851-9-jasowang%=
40redhat.com
> patch subject: [PATCH 8/9] vdpa: introduce map ops
> config: x86_64-randconfig-073-20250702 (https://download.01.org/0day-ci/a=
rchive/20250702/202507021212.rhQmuuvi-lkp@intel.com/config)
> compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146=
a88f60492b520a36f8f8f3231e15f3cc6082)
> rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250702/202507021212.rhQmuuvi-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507021212.rhQmuuvi-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    drivers/vdpa/mlx5/net/mlx5_vnet.c:3405:21: error: no member named 'dma=
_dev' in 'struct vdpa_device'
>     3405 |         return mvdev->vdev.dma_dev;
>          |                ~~~~~~~~~~~ ^

It seems I forgot to convert mlx5 divers. Will do that in the next
version (if we agree this is the right direction).

Thanks


