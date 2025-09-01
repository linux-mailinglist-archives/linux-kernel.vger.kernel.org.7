Return-Path: <linux-kernel+bounces-795314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F6BB3EFCE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960FF20640A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13794271476;
	Mon,  1 Sep 2025 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRagE8GT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5590271450
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759251; cv=none; b=UZaSFl867was53oHvpFcd/iaPkeHiqMIf3GVaZRdhizahToJhaJ2lU9ZJD7lKLcQrGO8npN8nxp6h+Lsg6EY+qCACbYBFBb7xhO+1xHgXL2TUi8nPJgEGiEbyVR/qUydqXl0OvkTx0oPeQ6ZaCDhJ1T3ew+3XcAvwGkT2ellFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759251; c=relaxed/simple;
	bh=5n34Vy3SJGpIBzxpUQYczMFS+9WatvVkOg5dSEsG9O8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tr2kuagRP/XHFLFFTA2zs/09z/JHNHqGaYwHhRkGNIDN4T6XR9tgYx1RGyxz7mg97cZUvEnzRSThQjPygubQaJqmTm2b6Fv8XebtJOgPWOf2njqxFtfpuzPTwqBwHvFcHktgD0H/4ZJCJ1fchCt6WnwOxn4wd1W6ybMwfWPZiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRagE8GT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756759248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+B9VAsu0RKzYj0L0AfU6O0ugzD+pX5xv1/kXNBRGfIw=;
	b=CRagE8GTwzjSBbZn2Kq6Uth95FySfwa5+HitAP7sArhzOltlqopJuQceItRI/klOXebDK7
	95FWVWNie2G3nzFINV/MG1mBpQq+CX7oYFVvPIRq+T4V5vRKMpGF3QgH7A7ZmbMedlh121
	/0NBosmXBBgkF+tWHDVY2U8i0kdtugc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-zmzmhTQXMJ-S9J_iMy4N3g-1; Mon, 01 Sep 2025 16:40:47 -0400
X-MC-Unique: zmzmhTQXMJ-S9J_iMy4N3g-1
X-Mimecast-MFC-AGG-ID: zmzmhTQXMJ-S9J_iMy4N3g_1756759247
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f3ee323cd8so5166825ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 13:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759246; x=1757364046;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+B9VAsu0RKzYj0L0AfU6O0ugzD+pX5xv1/kXNBRGfIw=;
        b=VXuUgZq2V3nebT8NKzlCLdNN7kAhRIcS5eJ/vnPbjGB58uV+CGe9X39MqIWhgvns4h
         wtXZydKf2zT68u6Slyl+5A+cBqnjZj0ypWRwscc8i7MN8slwXCsRZuL7+lQ3EYQniGYu
         TMYPQbzsfYjIr7dDx/XDm0a19Jc4t4VsmGmbrAsOHSxYB6xsxX/YUKMO2BZmaS2jZIld
         K/4OVmhAAax/5RpGzveNHftX8SChGpcIFZsUMK67f2SoiiDs+UGhAKUIRQxoBHuMYR38
         ytAA72uSe5jW07Lx5CYut4JYA4JCanB4ZZMA85UudVwzkzLxGetDH85ZzCnTvkEpCLAK
         Aw2w==
X-Gm-Message-State: AOJu0Yxu3xTt8GLyxjXOFrVkzpbjem/hmDS3ZagMjnIAX1xRcI2vmfxc
	RKKvvVClvHZStFTNoleetf28iXFUw5k1nvY5uuAJTLMwujVuf5as5GiCoY4D9gnuoTm3hpDkLtp
	P5qMAxgaZu5gfnDWu/hYdCI+kYbbyFk03yakKW7vdmQ+VgiImck5vSKXo/MlJO/KEzLZfUSx4RA
	==
X-Gm-Gg: ASbGncuynFdIGZFioF8nNrAo1yvF++riya4q6q+k9rSTeai375kJLHvJKc4co1M2NkP
	6wY6I3fIVK2qtsrse8LugHC+DhyCmlX6r2v4dwgikloAF9DafYXbBw1UYhB+GmyM7/DvH+T0DIT
	kvedcwWl1vnAz02VkoOoRGqFJs8Q5V9ytCNzZNn7UN+O2e+kNt7MaLBZa2RznGGJkFT+W6ZTyAC
	wuV0EnsbKmFOZEMzGxZOm6N1gGUcA6jrCUPf28dFSZfHJRcEFdiNO2FMq1flUwtypElHom8CgWE
	wn9IuIIpmrIDdAnVPqQQaTBK6XfTdakccyVtSEjA/xQ=
X-Received: by 2002:a05:6e02:1a45:b0:3e5:4844:4288 with SMTP id e9e14a558f8ab-3f3247c6570mr87671205ab.6.1756759245911;
        Mon, 01 Sep 2025 13:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDCjj9eJz63KAon0nZj1U3iZU1nYx18LdGI9Q8LOi5kKaPZkcCjO1mvqyzR7bme00h+xlmOg==
X-Received: by 2002:a05:6e02:1a45:b0:3e5:4844:4288 with SMTP id e9e14a558f8ab-3f3247c6570mr87671145ab.6.1756759245503;
        Mon, 01 Sep 2025 13:40:45 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f361038sm2501739173.56.2025.09.01.13.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:40:44 -0700 (PDT)
Date: Mon, 1 Sep 2025 14:40:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Eric Auger
 <eric.auger@redhat.com>, clg@redhat.com, Mostafa Saleh
 <smostafa@google.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as VFIO-platform reviewer
Message-ID: <20250901144043.122f70bb.alex.williamson@redhat.com>
In-Reply-To: <20250901191619.183116-1-praan@google.com>
References: <20250901191619.183116-1-praan@google.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 19:16:19 +0000
Pranjal Shrivastava <praan@google.com> wrote:

> While my work at Google Cloud focuses on various areas of the kernel,
> my background in IOMMU and the VFIO subsystem motivates me to help with
> the maintenance effort for vfio-platform (based on the discussion [1])
> and ensure its continued health.
> 
> Link: https://lore.kernel.org/all/aKxpyyKvYcd84Ayi@google.com/ [1]
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 840da132c835..eebda43caffa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26464,6 +26464,7 @@ F:	drivers/vfio/pci/pds/
>  VFIO PLATFORM DRIVER
>  M:	Eric Auger <eric.auger@redhat.com>
>  R:	Mostafa Saleh <smostafa@google.com>
> +R:	Pranjal Shrivastava <praan@google.com>
>  L:	kvm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/vfio/platform/

This would be all the more convincing if either of the proposed new
reviewers were to actually review the outstanding series[1] touching
drivers/vfio/platform/.  Thanks,

Alex

[1]https://lore.kernel.org/all/20250825175807.3264083-1-alex.williamson@redhat.com


