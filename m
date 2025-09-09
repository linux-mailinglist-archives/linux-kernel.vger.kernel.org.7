Return-Path: <linux-kernel+bounces-806955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90296B49E08
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF1B3AEA18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8855014286;
	Tue,  9 Sep 2025 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwFBLT76"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100C25634
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757377990; cv=none; b=pOjLzFUA/YU1cyaPb8x5YIppvzKtYzZYt5TmwCzacU03eNBe1+CF+/SNo8P0+3XrCWkgUBlav+GmtNwMr6DdjaQ72Dypk4Kb6ndbXG/yHESfmbiXpjCbzLdoStN6av/lL6FF3B8Gzh3BBHNNznQY6x4PzW/yfhkgKnNz21Ju3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757377990; c=relaxed/simple;
	bh=a/qn949UHnIO4kaVtM6lKe+Z/w3NdRIYJzSb9iIEMr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qbfk9tAG4L4z53S85QhQY54/JXOKRBJsxhbF2FXHVKVk5HFa8vo6llhu/wrM1k6MRov5QyzItYOwH30fNZsm6ycx4E593sHjN2xAMUuOFgXSWTTMs0VPmvWdZR1BVIakiUeTBbyySxE/fT6KiidQjeDbocBzZmvK9bdj4k8vnrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwFBLT76; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757377986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8aPDPeVVXVtlPJcL2fF7xrY3LH7ZYbZX2+8L20uXkw=;
	b=TwFBLT76+YAF6CRjKU6UPVbgHrC5x/HpF7G7GAtelHBi3jTVpC2tT6nKNQTl6RlWOEI8uq
	zBA2D8HKHGzVradeY7JLLFsHpV5GgKqEaXHnH6zR4wayTsMVVpScvv6XeXYPCwsGwvVQTu
	vmwRFBo2SZcWwxi4n5VYNDPP/rP1+bY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-paE9BQX5Mr-5Oovt49dqWg-1; Mon, 08 Sep 2025 20:33:05 -0400
X-MC-Unique: paE9BQX5Mr-5Oovt49dqWg-1
X-Mimecast-MFC-AGG-ID: paE9BQX5Mr-5Oovt49dqWg_1757377984
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32b51a481feso4955254a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 17:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757377984; x=1757982784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8aPDPeVVXVtlPJcL2fF7xrY3LH7ZYbZX2+8L20uXkw=;
        b=XrpaNSZ+Cos2qa8/OBd32uudpSF5Ty9xpVS21FoivM3w3snhpcndqO8a8IT3Mr3r66
         TlBR/MEK57t5xCQ7J35an/i4iNoIBNEebYiDQ/94QozxFn+bYpml2GIqROucPqjK1Rvu
         +3aKaOpJUvMpF0adqGQlNQEKA8VxRr0VYxgvcJq8X4fNm3rzTHZTsRl3b1r2X3NupUkP
         DC4C7WcpFnI/Ub0+/Bb85P6KwYqBHi7xwMgPy7j13+PiLKqGu5gfcuCaSrm/9d6+FiA8
         qZpG/aC9jbWjTvILlBN0Byyd5vEwlrsssymW6Jxogm7skKTfiDCjvBe8qxN86MD8xazk
         2TSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz0i5kuRtqI7mXe6YnQ307MArfIWW8q4IuZ7uc6fa0ffNcNUAc49+N+Sq+5qhznYcXrY0a5tFu7lpVMoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbsSODzVYZ7Od0HWp/v1+KRY/0LMKv2YxQWb5O4KNbD3zlWjh
	0khgWITT4vo45bv73rbjh92rnKWEEfR+oYShfwkEVz5+GNnCFXO6yedyrYgBMF5DdQFHrWdWQgo
	H3fXBeo7hNFnVqbLpF/LvQ7NWMQAOMuppkzr/OOLI0JT9Dpw/ts1JmmQYuq+CviHhdDkVOJi0OC
	Ldv5Egz0yY+2hDbKkFg7ObuZRE/x/IKW34pmGGdVN6
X-Gm-Gg: ASbGnctFWf9WwenIvFgjC1Mi5f4S7+1tKSIgH0fKUxIsxhOnZdfu3OiQPDNvA6WdOwz
	PFS28ToNHgzaWsnE/cbKmhYZLv8moGv3/3r2GNUVFzzSkjKTjUpK4b6hj/J71DRuqpEFw5IwLRV
	Rx9K+mzci4myXgyCQs42CrsQlVh8ebMVUboZLfpBX1dhSvNVYOG0LGyEU=
X-Received: by 2002:a17:90b:39c7:b0:31c:39c2:b027 with SMTP id 98e67ed59e1d1-32d4504c0cdmr13473015a91.7.1757377983863;
        Mon, 08 Sep 2025 17:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB/7LKq5lsBlOebRNDfBxkvSFu1ws6h5PabFN+juLJlOdDrCGtCm03aAPGBXPWywjfdxSvB2eI+Wr2hUmomAI=
X-Received: by 2002:a17:90b:39c7:b0:31c:39c2:b027 with SMTP id
 98e67ed59e1d1-32d4504c0cdmr13472983a91.7.1757377983421; Mon, 08 Sep 2025
 17:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908141152.221291-1-ryasuoka@redhat.com>
In-Reply-To: <20250908141152.221291-1-ryasuoka@redhat.com>
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Tue, 9 Sep 2025 09:32:52 +0900
X-Gm-Features: Ac12FXxmRNXE6fd6lYzBI7AoKQmUGq7MfnSQvaMDdMQMA8oaYPI_f6j8sooIhak
Message-ID: <CAHpthZqD_r_671GhFf4SgMMxcqq-pkzPKigEajgzozn-NMFQnA@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next v2 0/1] add drm_panic_support for vmwgfx-stdu
To: zack.rusin@broadcom.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	ian.forbes@broadcom.com, jfalempe@redhat.com
Cc: bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 11:12=E2=80=AFPM Ryosuke Yasuoka <ryasuoka@redhat.co=
m> wrote:
>
> Add drm_panic support for stdu in vmwgfx. This patch was tested in
> a VM with VMSVGA on Virtual Box.
>
> I got 2 type of suggestions from reviewers:
> 1. Write the panic screen to guest_memory_bo and send dirty/flush
> command
> 2. Write it to VRAM directly and then switch back to legacy mode
>
> Since option 2 is simpler than another one and ldu might be able
> to re-use some codes if ldu supports drm_panic, I re-write this
> v2 patch with option 2.
>
> Ryosuke Yasuoka (1):
>   drm/vmwgfx: add drm_panic support for stdu
>
>  drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c  | 73 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h  | 18 +++++++
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  |  9 ++++
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  1 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  | 43 ++++++++++++++++
>  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 34 +++++++++++++
>  6 files changed, 178 insertions(+)
>
>
> base-commit: 306c8959b5fdfdc3900aebe4e56257a349f5765f
> --
> 2.51.0
>

This is the history of this patch.

v1:
https://lore.kernel.org/all/20250901083701.32365-1-ryasuoka@redhat.com/

v2:
- Map a scanout_buffer to VRAM in .get_scanout_buffer
- And then write to VRAM directly using fifo in legacy mode to avoid
allocations or command submissions.

Regards,
Ryosuke


