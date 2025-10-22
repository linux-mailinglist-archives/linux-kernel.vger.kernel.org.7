Return-Path: <linux-kernel+bounces-864109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D444BF9EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83EE7343A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09142D5408;
	Wed, 22 Oct 2025 04:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzOsVt/f"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BE42153ED
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106998; cv=none; b=CH1hxyFNFVOSYRftECFrSoMBgVPGfeTz6s8jAMOyxYNXxM66lCnfQyfd1Vfg+z8TvywWmLoaRGtFlQ+qiDwtTXo9AUXYrGAQGC39zoBwizgBZ16EDng/t54fRJQDtI7PbI3hU5OmTpUDte9KkFPkrpvCBh8J4+nlpV/9RfDV790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106998; c=relaxed/simple;
	bh=/Zs13rwyEpacp0dK+/i30k2S0FjwWy/zQPbtxe8LS3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcNwT72m6KoxJJgy+uKxL7M5imqu8rObMZOD8pBiF4CDkjfRWiJrXDQVQ8zJKtLqJpjZLpaWZEvKm2qinel8eTdwJSyYyFJV/DVbMdOKOHhibKkQZ5CGwcilFeqy+QODawzQ/Fw3g9/QQC8BYKwOXc19eDUu7Qg2nTjieUB3IpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzOsVt/f; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e8850b09eeso6379721cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761106996; x=1761711796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjmqgq4oXJ6KcLliX8XpjgciioGaVT0ubuH52tHqk88=;
        b=CzOsVt/fNCyakV/XkbSnFqy4BN1kAG0gyD00J5dz6NMK9zdn3lm/+qF4Dp9Mr49xOn
         lV71duAGGjbEU35aD4Ri3liFIpQL0wDQzgrG7wCCPZ4u8I3E7TNz5oVPv125K39Yn1Jh
         hVDK79GlXWsj3q95oG2MYgENo31TTi+g4e66ZFSoQzF5Rg/8N0xAeOH2pdY+nuFW1yEU
         brdOTEBfrwGftCWbjLg0oqacWSwog7vmuBfuAAmzguB4WEolwFM7CGowS3JRyukvOpBH
         xmBwpHuPt7oOID0hDt5R1v1hmvi+HTIoUhMVl2dPzpXT/VAAlj8ybzjizwSH5vRdU/uU
         iXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761106996; x=1761711796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sjmqgq4oXJ6KcLliX8XpjgciioGaVT0ubuH52tHqk88=;
        b=F9V2z/aTVhpYs+rmDA5HxnXP5o0ULuHYTKbB3wWR2zhBbBcqlE7tLB81kELo9mL7BY
         aSNGp1flcdw43vKgJi6nNnN4yeEXZ55NGg4lDsJQ+cXnh7bMeT/sQ7stmeGoYGkedqaZ
         5dXRYuYCvwoXQnVNukbrS0bzmtTdhU85H+THfkGfaicpVXhfy/0jXVgVVJzKk8efp1UI
         hrPsHmpUrlmc318c/jSJCb6Bc6DYjwDY1slTPTJDLmKabtwS/C0vtVRzLE89pj/4Msn/
         ARlpxAm4+S4xW2WAuKTt6WsadxWDpFDOExfoM3YayZVLPQYuO/yPdILHgDqBRU7wAK6c
         mpow==
X-Forwarded-Encrypted: i=1; AJvYcCWAqtJuKs57yYCbqwdKoal/V2K+z/IRXeQ1Ihvhj5myw2OMTITtXpCALK08u7yPiUT+Za6Ol67jHpKbA2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw00vvd4V6+ZF1XxS65BywEcxOksSrBlhFMORp6XKLgLzYFtcw
	pwZPmw36+e8orIkQGObk3LhTx7d3nNa95m9OkIJah1ISq52F0MvvDpPUCpyatCuA/obyE5stNNR
	RaGCEyuJtjO/CzE/32B46/Jh/kdiEmCY=
X-Gm-Gg: ASbGncuhS5N+jGI+Z92DzAEW0lpfs42kU7rX5ttMgQ8HSv+JYcyEGfdMEaUjD4clQlf
	BwiOXDeji6XGNIhhuxMpfnKFQPhUwuQLriD1GIym4BZ1z5aeQcPwP5MJJHWc7Sd5bFpq9VELla9
	5NOD2WL0KuC9PQEskEY4shMWMD5rdOZaCIyfR2wD066ieS9HhjcHX5wnu/mp9FEWnOMRhkINg3s
	4iBppNTttFzYsVKx8iuP5IkY+K9oLedyHYcUwoT5BJGOTOqAfYG9KYdXSlB6x4UEK3nOxgy1bFV
	3OjxqZirljrdZVJDcN2aK3lg3c4=
X-Google-Smtp-Source: AGHT+IET3KONaMTPsD7UN46S/d5mCN7Cml92VempLxDbxjOOdFk+rRCfF/tG/QFVrcvPqNcaPJObQ/afb8c5JEx27pc=
X-Received: by 2002:a05:622a:2d1:b0:4e8:b42f:47c5 with SMTP id
 d75a77b69052e-4e8b42f5e12mr139992311cf.78.1761106996012; Tue, 21 Oct 2025
 21:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022035528.1981892-1-xiaqinxin@huawei.com>
In-Reply-To: <20251022035528.1981892-1-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 22 Oct 2025 17:23:04 +1300
X-Gm-Features: AS18NWCLIHUfH8BzEYNpLGT7bL_umdvnAny2MMiNLDgcr_j91CPuqciAP0wO7Oc
Message-ID: <CAGsJ_4wMtWZUTWRePK9_90LrbANUo7RcVkBRbQJ4aBEypWwtLQ@mail.gmail.com>
Subject: Re: [PATCH v4] tools/dma: move dma_map_benchmark from selftests to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
>  #define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
>  #define DMA_MAP_MAX_THREADS     1024
> @@ -27,5 +29,7 @@ struct map_benchmark {
>         __u32 dma_dir; /* DMA data direction */
>         __u32 dma_trans_ns; /* time for DMA transmission in ns */
>         __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a ti=
me */
> +       __u8 expansion[76]; /* For future use */
>  };

I didn=E2=80=99t realize you were hiding a bugfix within the code cleanup.

We agreed this is a hotfix that should be merged promptly[1]. Before sendin=
g
v5, please submit the hotfix first using the existing folder (without movin=
g
the code from selftest to tools). Once it is merged, resend v5 based on it.

[1] https://lore.kernel.org/lkml/f8c0cbdc-9c68-46bb-8dad-1d7c80f3f741@samsu=
ng.com/

Thanks
Barry

