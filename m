Return-Path: <linux-kernel+bounces-808842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79307B5054E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1C91732A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C3830103D;
	Tue,  9 Sep 2025 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eV9HaJrc"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5BF3009F7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442662; cv=none; b=D/swPtYnHPr6vi+6WpQN2RkguIDLikLVhbegNtWKavg+Y4Osu/TChJ6BE9f++CmQanH9PSq/1+dpVR7tbFwgytdeB5zqgd4IO/DaAv7kQLPIDAiOrKFhOGbSidR+SXtyV91sGFwv6ScnQuj+Bj3jsz/IiZllN4mcbhkRmuM626w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442662; c=relaxed/simple;
	bh=yM0Xnr5mgLbhYQekgENeXiwmJdvFW1b1xD3j7t4hWgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjVXaFs1nuUKCwLiXUmRbE9NfDE2E7DbR8hV04iYXdgy9LH/lXKKr231aJTuh6xAhv8vZadRQT4W2JN9QRNy8MgQ5FTIrS4Jl/gKg00Y+TZCwTWLtitAzi+R4s7DsUoRelgtVWqGWl6xWiN3fhzGkGa//W9/dBz4UoCLUZDRbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eV9HaJrc; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b4bcb9638aso80151cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757442659; x=1758047459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfxcLFfDrPkIJiNUWhVN3N4fK2AjPT82pZU1A16szcs=;
        b=eV9HaJrcffLw2wcJOwuh9jBfwLf+9jAh052njveUOMGOkBJsaJRnGsZ49WMM86bcMz
         bFTj/vd9dq1C+un8MefSP7GZsv3j8NTB81Gysjp16EA5HCdbGyGc4zeYcJkizKT+Kt5O
         6zYDTnH1sOsObcUiS95JNSabZbKLVy4wIIptrsSLn7P15POVs8nGXYXjfJvBUHdA41HF
         5cI+LL7rHkrap7rgc+pT+zfks9Funl2758CJh9M735QF17uJ7vInk53b9E5YvksFLIqD
         ey9cyQYYiDvqHDwTBDxCuwDrV1KxBKFBZ1F69vQTJ3PtdTPk6EXFNjctcb90jm4ccTAG
         064g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442659; x=1758047459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfxcLFfDrPkIJiNUWhVN3N4fK2AjPT82pZU1A16szcs=;
        b=JglTl8mMQ5sfcwpy//ZSakQ5lSXjkFVCbzHfRXdhvIW2jr2AxQScDEz4uTtQBuO96w
         dHaKjKxFqDWODAoDf5Op7M0KgdXKKcZuWz1jctBl3uUjrIpOdTrkClfqYjdiY/SftmyJ
         AGypxMsrO0u0ht6xpuSKGdWkyVUq8H8/49UOodEAcXZGj2rX1DYS8rVCvAZJl5Mzk7KE
         jUyj56DUrLiaSBAs9f7yDsX5RFun3kS+jk78f9oXvGGcYFMsaZSG+lXx+Dkv6wjo8KdR
         6vmmMYNv5/z30A7D6oSmIjw8mpzilVo+/+qr0YqRMZRR28cr0lXxGgNl2trvkSax1yJ1
         qQAQ==
X-Gm-Message-State: AOJu0Yy9pdMcF6vrtUeaYyvHpIz5CQjYQ2c63RCEKy1z0rOZd8QV97hJ
	Wl2iJww0T+1yYdqRJ9I3hmK8ymmYoOUbWFNwKKk/q0TFp6BwR4bjqazs1ceOiGhccKTeKF+azU0
	9g/UgMwAQW8t+ry+2yzDHt+cCj3qiX7/uZkJN36CF
X-Gm-Gg: ASbGnctpeznAkHzOYqZPO0y4u0+vF7uY+7HrYK3K0lVyk1F3PSkCzsvUoAv3OwjwrFO
	rCA9pcUav6gkLHqPjUXjA+T2k7vNoho61jYh0cfIbtcgcS1z7lPHp21ZLiLV7ZbIyZ+nlws3ah2
	4s0jnKBm2SSVvnpb6OjWk/T9lifPUpPz/ZMWxO37DxTen7ZPLMYwapHaDfIU0ilx3yPb6R1Yqq9
	MbpkSdA3PbIbXCoTG9jqw==
X-Google-Smtp-Source: AGHT+IGf+Q8hPzzej9xbfaEr60LoJgETjDgKDHy0ML31wiaO21T7Ktg8vRU8pvPgmGyM85KMJM70NWIugrUwyx3yAfE=
X-Received: by 2002:a05:622a:14e:b0:4b4:979d:8764 with SMTP id
 d75a77b69052e-4b62569f89bmr232071cf.19.1757442659042; Tue, 09 Sep 2025
 11:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com> <20250819215156.2494305-17-smostafa@google.com>
In-Reply-To: <20250819215156.2494305-17-smostafa@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 9 Sep 2025 11:30:48 -0700
X-Gm-Features: Ac12FXyo44kEPGnZiMSM0NG36OMtjkd65ZSJDU9pCejgoL2I9Mvg7O8L88TNYvU
Message-ID: <CAE2F3rDc-4SirDDrQeZJQDqjdv67-QFfQhHfwyd+O6f5OsBSpw@mail.gmail.com>
Subject: Re: [PATCH v4 16/28] iommu/arm-smmu-v3-kvm: Create array for hyp SMMUv3
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, qperret@google.com, 
	tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 2:55=E2=80=AFPM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> +               if (kvm_arm_smmu_array[i].mmio_size < SZ_128K) {
> +                       pr_err("SMMUv3(%s) has unsupported size(0x%lx)\n"=
, np->name,
> +                              kvm_arm_smmu_array[i].mmio_size);

Use format specifier %pOF to print device tree node.
If mmio_size is a size_t type, use format specifier %zx.
Align language of error message with kernel driver which prints "MMIO
region too small (%pr)\n".
I'm wondering if we should use kvm_err instead of pr_err.

