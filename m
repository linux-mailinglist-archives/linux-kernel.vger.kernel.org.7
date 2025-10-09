Return-Path: <linux-kernel+bounces-847211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3ABCA417
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 628B64E3B11
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B3B22B8A9;
	Thu,  9 Oct 2025 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7zZJcFL"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83A1E51EE
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028926; cv=none; b=ANY3Te+hHm5MDpnEkDcFb4QnYikNNS5wcOH+aMbangN7nzqCzJBfN1vlM6BlGkT6gJnVJcntOKb+zYge/wNEqmJe7Drv3ioLo/lntMtb0feQaDlGzV3QAnUygGKpOtHAbgIcGbAez8XmPL8FMx33msixXzokaZYZqlj0m4pu8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028926; c=relaxed/simple;
	bh=lg05B+AK9WUzBtS8QfsDIG1heA3C1fd0M3qBhVawjWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKiNfoxvOlmbecDaJC3Pd7llEZff1f2TsAn2ZnzBDufRowxQzuFSSlS/UgHPfJRYPFKF917ArJSaPOZtre+t8ZYjTRn1bRpSJSZW9Iun+Hr319a595Ts00GweLzfHbNoUvYcb9m2aqOmHg1N4L3HGE/9DW85aYzJNaqKmbwhiuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7zZJcFL; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7bc147fd11bso865233a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760028922; x=1760633722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkuMFF+ARdLGeqHd3hp/V7bl9dj0E28Y1GVyNgYJxMw=;
        b=k7zZJcFLU31H6Tihz/WVwJZ7A2EL8EVLTIwjJzY0JQJpfFFavK+1y7AWMUCwLaLh6/
         SOy75rQyrijAB8xTgRRg5kfoCiPfRGYALT08lLnneh2GmDd4HSQsLYss/ul0+S48NTJY
         +jH4L0PQokxJu3pMspuic+Jw4NujzFw6+sWtOgPY5VHsME50n30XqUDoO3+xcmv5U/UY
         bPJV5xBVCs8Z+shCNMNBtkCOJms4g9dUdu3vqrILmnFQ9cw+1j/6JKbHQNIs1eLgMEjv
         VXFLzWjmgTZ8ln7aYKzT0cQr7hOAtdlP/xqmfUApbTo/hJrKjMPfIL/+q764SFM4JvnR
         Mm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028922; x=1760633722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkuMFF+ARdLGeqHd3hp/V7bl9dj0E28Y1GVyNgYJxMw=;
        b=qiuMC8by89C70PDEKUrnqgtSKhIer4JRR2tKkqNdnJH+plgCj1DWe24XNX0uaP3zNa
         9MeukWgHoemJp5/9WARulbort/ZOzNAmHe0CsrZlB3rdx4NzQk9oFV/lMbDXq1WHnS1C
         esLlxfFf2WptwiuHwgs4cMSJbWKTUf1YTsaop4B8507Kgzhw3xhCmr8blvCHMZh6z8bA
         05nTU2UQtXLiVYfFfkMto7PaIf3JwtMY7Tu++igUOVUOz0XuG7cgPYmbkTxkx5sYTTQi
         N3w93QDL3hNryOo6WPNg8PDVOlqqDjb3/nJJ2a8pwASF+3cPZbxU9UZvC1Uau5yQ7ELg
         fm7w==
X-Forwarded-Encrypted: i=1; AJvYcCUQGWhfNvKpGQYnqYQjIuuf5KnL03ODHzyY9j07ZJPPBlFIUAoJN/x9vldxnCpla1k6TrfTZzSqrG9o78s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7C8oWeayUSi2CN5RB3Vt98wX+Ub74iKZfFQElIbuiR+DOstPP
	oZENLjhPy8PlxhjSfJvtetj5u1kH2NNRAnf3Kjg8v3ec/H13BEbxfKYhEny+Uy8D55+SRx5HpiG
	YH2QqAEES7ukdeEzNAQXCwsGKhBy/FjM=
X-Gm-Gg: ASbGncvYLlwU3bAIV7a6jMq+Dhyp+HZJREK8TUPkpZrN65tfpLHj6ZAzU/LeeP9H1p4
	TBOsKNeVxTQc/Dba6dKdEmgjNMTtekd5F2dp+D40QbtFTtMVT89TsF9je1Q3W5rHZN256oTTEZl
	cDGE2lvld70cAPbHk7bAzYv4RDkS5ascCJNPq7KePVbF6Glm2L5T0iCJDki534x5kOTz3Q1t3NK
	rlBXZmuKfXlYJyOBPldoaQh1bWoXig=
X-Google-Smtp-Source: AGHT+IFMkZ+nCsqEt4qzo0y1lcmJ4WPina77QEmn6wBk+ND1hK1VeaxxVfFe967UJ12KUKWhWhzppgbxAf4MfdeefPU=
X-Received: by 2002:a05:6830:82eb:b0:7bd:235c:5437 with SMTP id
 46e09a7af769-7c0df785071mr4288989a34.17.1760028922160; Thu, 09 Oct 2025
 09:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsO8_GXZQ9tJYZJDbO7oGvsHyVS-32L1PZ7YNL0SrA1RFg@mail.gmail.com>
 <CABXGCsO2Yx1FvyryYU_R=kvS292eCDaLr9j0LHKPtNDkkz28PQ@mail.gmail.com> <CH0PR12MB5284060F40235BB4538B51DD8BE0A@CH0PR12MB5284.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5284060F40235BB4538B51DD8BE0A@CH0PR12MB5284.namprd12.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 9 Oct 2025 21:55:11 +0500
X-Gm-Features: AS18NWA7KS5rr3mBhnA2kzBEHmJmLYjxE7iPPHkG_0LysO5VC4a8kX0WUaMBIGA
Message-ID: <CABXGCsMMg59UXnv0EkmjsiZNUsZUBzBaUR8EnSv4FqOTmpOf7Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_6=2E18=2Fregression=2Fbisected_=E2=80=93_BUG=3A_sleeping_funct?=
	=?UTF-8?Q?ion_called_from_invalid_context_at_=2E=2Finclude=2Flinux=2Fsched=2Fmm=2E?=
	=?UTF-8?Q?h=3A321_after_6d31602a9f57?=
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Cc: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>, 
	"Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Li, Roman" <Roman.Li@amd.com>, 
	"Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 10:55=E2=80=AFPM Pillai, Aurabindo
<Aurabindo.Pillai@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Mikhail,
>
> schedule_dc_vmin_vmax() has an allocation which is incorrectly using GFP_=
KERNEL, which is likely the reason for the "sleeping function called from i=
nvalid context". We have a fix queued for this week's update (switching it =
to GFP_NOWAIT).
>

Hi,

Just a quick update regarding the second WARN I mentioned earlier,
triggered at drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:138 amdgpu_vm_set_pasid=
().

After some additional bisecting, I found that this warning first appears
in the merge commit:
342f141ba9f4c9e39de342d047a5245e8f4cda19
Merge: 0faeb8cf99c0 a490c8d77d50
Author: Dave Airlie <airlied@redhat.com>
Date:   Mon Sep 22 08:44:52 2025 +1000
    Merge tag 'amd-drm-next-6.18-2025-09-19' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next

Both merge parents (0faeb8cf from drm-next and a490c8d7 from amd-drm-next)
are clean on my setup =E2=80=94 no WARNs or other regressions.

It turns out that this WARN is triggered by an interaction between the
two sides of the merge.
The AMD branch introduced the new amdgpu_vm_assert_locked(vm) check inside
amdgpu_vm_set_pasid(), while the drm-next side still contained a code path
(for example, through amdgpu_driver_open_kms()) that calls
amdgpu_vm_set_pasid() without holding the expected reservation lock.

As a result, the merge commit combined these two changes and started hittin=
g
the dma_resv_assert_held() check in that function.
Both parents on their own are fine, so this is a merge-only side effect =E2=
=80=94
the stricter locking assertion from AMD=E2=80=99s branch met an older call =
path
from drm-next that doesn=E2=80=99t yet satisfy it.

I verified that removing just the amdgpu_vm_assert_locked(vm) call
from amdgpu_vm_set_pasid() eliminates the WARN completely,
while keeping all other recent VM locking changes intact.

--=20
Best Regards,
Mike Gavrilov.

