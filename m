Return-Path: <linux-kernel+bounces-764813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C232BB227A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1381B68071
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A92F27466E;
	Tue, 12 Aug 2025 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="cKKw9t76"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52228265CA2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003251; cv=none; b=o+StAsjGTvcNSQyUPGIHi4p6HPZaYzIN2RlxEpinVRCivs0prwPP+zFnSaZ7ouZMG5n707GbqvuoGtnTpErl4TY2QSy3MVbNp1SNZbz7btvvjxuGwPdsH9F1lcpMrusk4V+iEsOJpb2+e46fwi2KHTtYgEykPDNV7+iVfQhQb08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003251; c=relaxed/simple;
	bh=kuFMJmU+9JWcojUuJvsQuwkddP22POkgDm8BHLJTRh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRbb/lWHp/FcaqeM+UZG3oSw5pAcZxiMSycLOjc+XF5zecvG8wrTYD/VDfB7BQDeQapjfQV6jvtk+Dw/mQ/29/JFHIsqxDQnIxA4MhHOjDqwHoDyoQVbC22BgahlZz209PbZK7i/D9eiTNxyDLZSgo2ov3adm8vtvrvzd0ue19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=cKKw9t76; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7de159778d4so565236185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1755003248; x=1755608048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2WtksxPDLT/0y+3eZjc8hEFOkmY30/S+XOZ4ZbmRdMw=;
        b=cKKw9t76vyDgJtFR+gCN5oEIOubX0QbmYB0n5PpLKNfKSp/bQznq4vRXQLLxZmTKTI
         YpfBqKnO2OnQMTTQuMA7+fspjwam8MHCz1DMcoq9g0Zcew3KfXGtPSx9OKdi77E0aHqR
         c3oPD6rQuf61C6etXR3yt9i2olVmC1gF7ZuFUmOQP3U76xKplICA0JdIj+35RavNwBCf
         QVLusNQiijzlX5xVqKoHt2kSKKgIOqPajRwCJlWWoG+naxhljbZihUktkeZIMn/P/s4v
         AyD2d7S8iLCjuf26NWyKxjHtZmFkWbBUk2Biw5cVWJYOZfhbZo9LcybzUmjidNiZZ/sd
         4TZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003248; x=1755608048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WtksxPDLT/0y+3eZjc8hEFOkmY30/S+XOZ4ZbmRdMw=;
        b=a8/kTjwk2mdTUGeIUTYiDEs1IiurJ2GkOqh/C+XXJDivC/MmGRlqa1RazE9jM4GfO9
         u0+wEbq+W/UKTcar5oOz/IkUcNMMtx/InQ/A73iZ3PsWEUhpn6ihjNdw+e9BJ0BVhhDz
         VjbFjqcPHuWbzFgbAa4RqlHt8WnLU+2iD6m378R0ELLoT+zKk16wRJH30gxQG/RMIa8M
         csbbpJWxgTFjL+KiRAZRQzy+AzWTmVsnvj0K8i6tuuzPkvXodhA02flgBMfP4UdON4qV
         2VdnKx/g2zrowuNRj6HJGpoXI+coSUiScJH7xnsdyPiWfREMk1Has6z4wbAD0yKTx86c
         wKfw==
X-Forwarded-Encrypted: i=1; AJvYcCX8x2SV59Ml564DZNai7uOpT/rFT+57GfFJoydaefa0THoV8ybMpyaj9hhpppQUiY2JO/BCVeepNw4VGsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyln0Q9CcYNVUArZiUvqcZ5yH92J4Y9JkZL9OYjy57o1cmDdhM8
	DtarEOJVbYfzap4s5G0U0gOdkD3wD4rcEWn8iDrUa/2jcMvevQwLYhXHaX+cKB1tjS2KJYgzLvz
	QmhYRNmTY58B8dMra/ar+kTyxf+v9NYXtMR4F6SP4bw==
X-Gm-Gg: ASbGnct1yRo1RgfvQ+iGI0ZrLhCZ9ABtqAHS+7rN6m7a+iXBf9WiGtH5khvaZR5iYfN
	ndQiHapO/9LvQTvarnzhE1gNNAG/vTfkg+zQ9ReaZoj9Fsm1pRCVpyY6zga0e8hRSVw6Y6VYGCR
	dfj+v5S5+TDdfHHuT+XOIMaqfPfHtx8zUY2Bx7UQeOBq0TC6dO/6uiOs+LG6Wz6H8xOFq7VfIr8
	Lx2PhXLAeb0DrGSnwtQmU+IxDafeH3NMdi0hOBxWw==
X-Google-Smtp-Source: AGHT+IEigi3eT3slvsaqaQxfpzA5/X/BpBps7n3zcMZvnFhGp0J3xR5YD/W1WjO/6HkGh5ZjKB8p2S+Mbi6DGKsspO8=
X-Received: by 2002:a05:620a:a117:b0:7e6:50f2:d62d with SMTP id
 af79cd13be357-7e82c616e28mr2406978785a.5.1755003248102; Tue, 12 Aug 2025
 05:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-ethos-v2-0-a219fc52a95b@kernel.org> <20250811-ethos-v2-2-a219fc52a95b@kernel.org>
In-Reply-To: <20250811-ethos-v2-2-a219fc52a95b@kernel.org>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 12 Aug 2025 13:53:56 +0100
X-Gm-Features: Ac12FXy89rNxCKeR5zfeZeSe2T50SLXSk1IHDgjCBDBFp3HnioWFlDD6e2e-kGA
Message-ID: <CAPj87rNG8gT-Wk+rQnFMsbCBqX6pL=qZY--_5=Z4XchLNsM5Ng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] accel: Add Arm Ethos-U NPU driver
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

On Mon, 11 Aug 2025 at 22:05, Rob Herring (Arm) <robh@kernel.org> wrote:
> +static int ethos_ioctl_submit_job(struct drm_device *dev, struct drm_file *file,
> +                                  struct drm_ethos_job *job)
> +{
> +       [...]
> +       ejob->cmd_bo = drm_gem_object_lookup(file, job->cmd_bo);
> +       cmd_info = to_ethos_bo(ejob->cmd_bo)->info;
> +       if (!ejob->cmd_bo)
> +               goto out_cleanup_job;

NULL deref here if this points to a non-command BO. Which is better
than wild DMA, but hey.

> +       for (int i = 0; i < NPU_BASEP_REGION_MAX; i++) {
> +               struct drm_gem_object *gem;
> +
> +               if (job->region_bo_handles[i] == 0)
> +                       continue;
> +
> +               /* Don't allow a region to point to the cmd BO */
> +               if (job->region_bo_handles[i] == job->cmd_bo) {
> +                       ret = -EINVAL;
> +                       goto out_cleanup_job;
> +               }

And here I suppose you want to check if the BO's info pointer is
non-NULL, i.e. disallow use of _any_ command BO instead of only
disallowing this job's own command BO.

(There's also a NULL deref if an invalid GEM handle is specified.)

Cheers,
Daniel

