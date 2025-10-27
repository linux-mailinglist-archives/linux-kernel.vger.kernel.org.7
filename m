Return-Path: <linux-kernel+bounces-872654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F69BC11B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E49A04E2F59
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A543B32C951;
	Mon, 27 Oct 2025 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5702t1l"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D028221DAC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604177; cv=none; b=S8x9O5THnkvRrZnOcCPs8QF2fG4D3j0+u78X4RUstR/0YM2mRVL8bKr3O6GQv5D9NfSumRREkPeyOh8SR2Y7Ir6M4Jc3nii0rv6M6V/kFq3unjw2/EkpLtaV2JK5T1859C3ZQLs9QTXyljBkEzU/OUJEu7EcAbmUD3mcJ3h3He0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604177; c=relaxed/simple;
	bh=qCctqqmuCWipVL8GughzbbRKWgiygHwz0qUsY2oTFoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1bI+k+pDhxo94LQk1v619d8z4dH8oVo3Cm3cMO5Q01eepX+n4KjNY3xZgta+vHwT3AeK8qahFuSdtNhLRd1nwhUHqZTtf6pK1JJOiHjd+mHfAP8dZv6zAW1fn4QYAGUxyBd//l2QRS300qqK1Oy4QKm38TZdB6yFmNu27BL8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5702t1l; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-36bf096b092so50831251fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761604173; x=1762208973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8OllJa5cnTv18Hb5rtu0WqFYbEpD7McBb4G8sNHUxU=;
        b=i5702t1lHofL4kd8TbEJQuRdtOKuGOjC6zkq6Q7Bk0BuTRiJFdCd4Z9I2wNiSjduhw
         5CuzI/+PgoQRVQ7wp1KMYkVLkL8nXonzXlK6sRjLzcLKSbBazQJdjtT2yvjJO04vToPV
         SrdxhcsReyr6HzS5bA7GwJZzbi77mrRu3iVIHa4y0zURm4fDk4GgQx9zOLq5Gw1kZ8HP
         9IH258d+YyCIp2+pmRggC7bmYZn6HmllfyxNHMB72QYzqFuFB1TOe25AJeJ84O1ahhCS
         eq2L/QK5ODTzibmQ3DQwTADdWZppO9jnZKyIatPJF+LrSxs+CVmSNHV5uchJdoHE3Ivk
         rDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604173; x=1762208973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8OllJa5cnTv18Hb5rtu0WqFYbEpD7McBb4G8sNHUxU=;
        b=JmAuVzTk6qc81JOK1ZE8Hfl8YCB77U2FgX1fI7Zr8OjDq4N17VWM6Hc/R+5J9C7U96
         nJZ093DzeRMBLFut+c7rfT0QwosuxJ3xwRJwCimdoXTG9WZkRV1yPm5mPIfg1MgWbFyo
         R54Cpi6Rx2tj98TzzFfj0QTWg+954SMbGf0E/+tU69fLXNpoaCz606pUfoqFWSZ0vxc4
         tpuj2DIgIijXi/+BihlnNlqF1FHkfHcXBN3d5zUMDXCdoqodfLIOmOSJ+SE+O/5ZEK9H
         wNVNUc+gP0CDqAroRYLVacIrfMjs1aRhTE+uNwSlddpJkgL8mzv0aTr0RtqrWtfmzFWL
         gbWg==
X-Forwarded-Encrypted: i=1; AJvYcCX7sCt4+a6h+7+liKxKCJA3+jeWNIvWln6MrmiazJBvrof9AUaiFEzoYmdk2X8w5cTKGjAJco+mOtlxXiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5uf5dmMx+mnu/kV6H7kj8IvikLn4+1NgSWZvCF1U7cU7TYbXM
	a3a9wbx3PgX1BzkQ7IziAbyIWRZeEIx6IMwGLOAI20jxBNtx2Znf+zfkqn+YhgJwZfT3R97Ru31
	NdmrZY4ZndjxLKjzgdPIdLSkA+a/9UWmkpDnLOyAn
X-Gm-Gg: ASbGncuHDy1Fd4/dSDMOwQs004yqY0ZYhQVKJatQ8mtTU1SvJ+xD8pL0sCnTLJ08GIs
	ZO7eiIaGGdqgibNLY1LrR2CJ/K830lN+TEJLRtgBWN77koTwrvk6CHB8rBXXB9Fi32I8BKcSBQf
	I7HUk2kSzxGdxmTD0GZ8IU4wPqmcc8SOz5HEEUq92YXcIiXknwMe3TG0ke/V2uep/6yLGat4T4v
	d80IpXK6gqi7ih+EBCBVYjnKkc2Emrk3de+M4v0Ln4AHMAd5ZPSdYEvFn4q+Nn1AJ82yxw=
X-Google-Smtp-Source: AGHT+IG3oQ1hLD3e0hS3PRFF5ObbhSTcrKhhLRIEURqvM4Ky9aK8pSzbBQH6dOSSLG+Z8K1fnWad+2c0m7IK5ji+AAc=
X-Received: by 2002:a2e:9a0b:0:b0:376:49b1:7909 with SMTP id
 38308e7fff4ca-379077694a9mr3618351fa.49.1761604173336; Mon, 27 Oct 2025
 15:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com> <20251021000852.2924827-2-pasha.tatashin@soleen.com>
In-Reply-To: <20251021000852.2924827-2-pasha.tatashin@soleen.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Oct 2025 15:29:05 -0700
X-Gm-Features: AWmQ_blnDmlMSHWHiBFbsh6uAwbzzxnGfxP2Tc8ntIAjm82iRY3rUDbemvTKIT8
Message-ID: <CALzav=egQiF6tanYxR9Tow7TnT_UK9bNAR_4DQ2P=2EJ+H4ZJA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:08=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> It is invalid for KHO metadata or preserved memory regions to be located
> within the KHO scratch area, as this area is overwritten when the next
> kernel is loaded, and used early in boot by the next kernel. This can
> lead to memory corruption.
>
> Adds checks to kho_preserve_* and KHO's internal metadata allocators
> (xa_load_or_alloc, new_chunk) to verify that the physical address of the
> memory does not overlap with any defined scratch region. If an overlap
> is detected, the operation will fail and a WARN_ON is triggered. To
> avoid performance overhead in production kernels, these checks are
> enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.

How many scratch regions are there in practice? Checking
unconditionally seems like a small price to pay to avoid possible
memory corruption. Especially since most KHO preservation should
happen while the VM is still running (so does not have to by
hyper-optimized).

>  static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, si=
ze_t sz)
>  {
> -       void *elm, *res;
> +       void *res =3D xa_load(xa, index);
>
> -       elm =3D xa_load(xa, index);
> -       if (elm)
> -               return elm;
> +       if (res)
> +               return res;
> +
> +       void *elm __free(kfree) =3D kzalloc(sz, GFP_KERNEL);

nit: This breaks the local style of always declaring variables at the
beginning of blocks.

