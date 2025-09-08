Return-Path: <linux-kernel+bounces-805120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D44B4843D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A6C165EDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612D81B87F2;
	Mon,  8 Sep 2025 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFTWNUnD"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019362309AA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313220; cv=none; b=GEug+Topx6xflgvZIK4Gnth47IPFHR4S+Mm1XQbL9hCAlkX7XKYlbAKMkVQD9PVXgoUqYlk07ir3lbB+8uAy/l3GLVZoYlZb8v2B3SzNCx4A/08F+ZCYkZ4D1Dm0XGFv+z+CtLDjj7I9788tmKuq5StpAYeaZwOpTRpH3T76BlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313220; c=relaxed/simple;
	bh=OhUH+Z07fRrpKhrZeUuay/g+3leOUtGetWVNCNESxDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=so+KuNk4mN79to5W4Xj11bTeYVzkF7a9Rq78BaVTiWsnCsTIL7DwiXrGzHNkyxYuDnBuWtH8jWIietE9pDvzFpp2xA1o28EGFXWeAi2ahFxoIcRvi3yB1dc3BzkSy0DxUqiXpIAxf3sFVgipBL7bLJo5Q8wD5AvYPjTM8nYGCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bFTWNUnD; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-336bbcebca9so30065791fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 23:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757313217; x=1757918017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJwB7SCX5/adivhWJU1vqxu6DkFRbG1fAaH56kwBC8Y=;
        b=bFTWNUnDXTdJ8zqwZygqhM+R026tEMhXq5hJKHn5xVRv5croyCst+VTXG+x5I/N8ml
         bPYWqhXXs/EcO9lhzWbbPY0TC76sWhIR7g0CoqvVMgU53X9f4qg1zR/m5G7jxFUurPSx
         Yz+vwjGj0BbfyUXRISfE2ogbOVREXFnAMeB34/gaSLpW7Vj7pp6d2GiEDw53zkhK+7/p
         vJWtmPg9H4eXL29WV3YR1cnUVzWxWWCTiqf8CtHS5PTttgTu5TVvCYfl5WBzHV9ZkIOA
         ciXaUhuJ3xB19cgGC2L1c12+wJFU/1652zwcCwl4mntKypzREptftq2DehLCRouYcUDa
         ak0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757313217; x=1757918017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJwB7SCX5/adivhWJU1vqxu6DkFRbG1fAaH56kwBC8Y=;
        b=tIFhngGnLqRGv08zTKGbvtJoVaaiBVIR2AoonmZ7+/6bFBya9t4qTryKVOMmZMYBY7
         3QnfYyNPxkoYa66GbCq7p2c94QuZipopctIuTyIOIKl+q6lnwerDOqV1OQQixEs15J3F
         IUi+gapjgC1DxDHc4j2OKTZ+BjBVpqhlhoaOKWqZGnvDGLoU1Ivs9gCbJKrk7XA0DDFd
         Uzjk/obE8uNIs7L+acF5y9zNWA2JVnEB9i+5McdylEfCLCD+F0zCrDyIlZGfbYPiaDLP
         PbOR3jBVT2U9EgSlQtjfA+qfy8rjxL3wAH8A6XjElUaIf+dItUpyExxr3Iaqouakf0qh
         obog==
X-Forwarded-Encrypted: i=1; AJvYcCXwaQWunrc7i8Dz+6X6RGkwrld/3Mr8qmeYWaihWVOUKCBchShCpzZqSkbtnHiA5cT0/ejg5rfjwAwNs/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSwcj0f1BbYJUFNvTqppRPlAMoErJ+9xGxhcjKZSK1+mPDrjIX
	idrGqpxdxKedVT0mXnOo5bHu4fke32UcDW9uFRqCLn6OxkorOIhG19fVz3tEMBPkVW6gvBpMTdr
	aCGPpwwO5sAAj/WdpK22Mub+1KJNMzX8AZ8pYPdaapI9a0YaXeWN2u9iM4RSn
X-Gm-Gg: ASbGncust2h2Sj5/d1xGedYZCbD2Ap2FONiD9iqmrvjGzUw2TasIiF5p+/+UYYa9H/2
	+v7R/QeG3HN8D4Y7OuTo0iXIBRvj74OSsmGUqBOcPusz0VGsJNTCB7c7jB+yJbdJUEeGcT37anF
	7MqJQ7eMDRBGIh79T0W/Da9ZS7nB1lxy+ww43g7jtxDbXGC6i6o+Yvy0CCsBMJDOsKZEXrETOx/
	rIZm1qkLeO0B34VaQ==
X-Google-Smtp-Source: AGHT+IEul/1lSleLADsQmlrAbcXYeBBuWKXApeelPhH6Kv5m9iAfewvsZxvDD9Q8TaRpetI9kTEL7mGQ3gSQzcdeg6E=
X-Received: by 2002:a05:651c:1509:b0:337:f597:60e8 with SMTP id
 38308e7fff4ca-33b57c43673mr14686061fa.32.1757313217067; Sun, 07 Sep 2025
 23:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822103904.3776304-1-huangchenghai2@huawei.com>
 <20250822103904.3776304-4-huangchenghai2@huawei.com> <2025082208-coauthor-pagan-e72c@gregkh>
 <CABQgh9GEZSasZq5bDthQrTZnJ_Uo8G-swDsrM_gWCecWbtTKgA@mail.gmail.com> <2025090608-afloat-grumbling-e729@gregkh>
In-Reply-To: <2025090608-afloat-grumbling-e729@gregkh>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 8 Sep 2025 14:33:25 +0800
X-Gm-Features: Ac12FXyZQX5Os5_Vuo_rHeb-rj7bzuNbJX-4hZesPdDN-WYbjkO2Mi2fWIpsSFA
Message-ID: <CABQgh9EWysbiOJv1HwpB-EUzxDbOcumnXzAn-p2PvsyB4ZcQJg@mail.gmail.com>
Subject: Re: [PATCH 3/4] uacce: implement mremap in uacce_vm_ops to return -EPERM
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chenghai Huang <huangchenghai2@huawei.com>, wangzhou1@hisilicon.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	linux-crypto@vger.kernel.org, fanghao11@huawei.com, shenyang39@huawei.com, 
	qianweili@huawei.com, linwenkai6@hisilicon.com, liulongfang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Sat, 6 Sept 2025 at 20:03, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 28, 2025 at 01:59:48PM +0800, Zhangfei Gao wrote:
> > Hi, Greg
> >
> > On Fri, 22 Aug 2025 at 19:46, Greg KH <gregkh@linuxfoundation.org> wrot=
e:
> > >
> > > On Fri, Aug 22, 2025 at 06:39:03PM +0800, Chenghai Huang wrote:
> > > > From: Yang Shen <shenyang39@huawei.com>
> > > >
> > > > The current uacce_vm_ops does not support the mremap operation of
> > > > vm_operations_struct. Implement .mremap to return -EPERM to remind
> > > > users
> > >
> > > Why is this needed?  If mremap is not set, what is the value returned=
?
> >
> > Did some debug locally.
> >
> > By default, mremap is permitted.
> >
> > With mremap, the original vma is released,
> > The vma_close is called and free resources, including q->qfr.
> >
> > However, vma->vm_private_data (q) is copied to the new vma.
> > When the new vma is closed, vma_close will get q and q->qft=3D0.
> >
> > So disable mremap here looks safer.
> >
> > >
> > > And why is -EPERM the correct value to return here?  That's not what =
the
> > > man pages say is valid :(
> >
> > if disable mremap, -1 is returned as MAP_FAILED.
> > The errno is decided by the return value, -EPERM (-1) or -EINVAL (-22).
> > man mremap only lists -EINVAL.
> >
> > However, here the driver wants to disable mremap, looks -EPERM is more =
suitable.
>
> Disabling mremap is not a permission issue, it's more of an invalid

OK=EF=BC=8Cit's fine.

> call?  I don't know, what do other drivers do?

Found one example in kernel/events/uprobes.c

commit c16e2fdd746c78f5b2ce3c2ab8a26a61b6ed09e5
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Sun Sep 29 16:42:58 2024 +0200

    uprobes: deny mremap(xol_vma)

+static int xol_mremap(const struct vm_special_mapping *sm, struct
vm_area_struct *new_vma)
+{
+       return -EPERM;
+}


Thanks

