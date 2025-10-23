Return-Path: <linux-kernel+bounces-866045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1491BFEC30
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8DE3A910F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0642D137930;
	Thu, 23 Oct 2025 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzmXnsLK"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC37483
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761180724; cv=none; b=thInFSYU/sJmmE+0clZIpeE79o6gHWzoHh9HrU6T3pg4mxK9GaGBBL08IaCJtV7MjIGdsJqhu7eXBl21oCojMABgoi/JItAjU7iaFK4zUnYS8q4LI2KxiL/8rPB/JAgQbChO7sJ0pW5RmNOFUjL2ek3ezPRoy9XdL29/UpjjwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761180724; c=relaxed/simple;
	bh=W8Jk8TbFz+c+orpz7oeJzw7HBha49CvaH4Ccjpa3WnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dACA6i8AtnO1500h0VqzXS/reku2EgyE35/kg4Fs4H5l09KNHL5SxOAHts6kht8B5OO/oYvcgB8Z/RvPuxQ503b/ax6cRvDBsgt5ASsc2qWDL6YCmV4RYS73E+BTLUT3oD/wallw6UX5Ka4/frl3A4sm1W+fZ5Im1DkA7klM91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vzmXnsLK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4298a028de6so80062f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761180721; x=1761785521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8Jk8TbFz+c+orpz7oeJzw7HBha49CvaH4Ccjpa3WnU=;
        b=vzmXnsLK2LYzH6S28cw5PqmdBxEjonkY2wKwj9exfQouRqbJzhZHAIPH6LSVIib+3j
         d+rO5w5WFbeVHzDwTS4ZVlwNenp/C4FDYN18yT0vy8vk2uGV7siujtjuuXsY1bKlT2uA
         IB1Gvhqs1lw2scvVdxjEILbjWysGIjIvgctmKaqPe5XnjqO8CDbBxNqwe0nzgc/arD8I
         VAWKYirihXsPtgHhy96ftLKs5fDEtRPg4rvjopPQY6t6+qKUg1MEBU537H+exS6fuVNN
         npioYcDU+0um/eE8h0FjmOeCS6R3b4T5W55RBeFbqe+INbDEgagsH2zkwCEQ2QvecD9z
         d6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761180721; x=1761785521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8Jk8TbFz+c+orpz7oeJzw7HBha49CvaH4Ccjpa3WnU=;
        b=LUktUy0teutKz+xi7cMEoDmyVsRwxm47nlnIMM7a71gVQWxauGUGpiLYO90MzgBuE/
         XPvoQMM92SM8zzArJd6eXio807Ja21sEgzvhlJMQq7Pr1OJroQPLTjKglSGv6i6m0nhy
         IIhzoBExYGEKCJq/ZwAQjNvVJZqGryoO8cNQ1xQukPNa3EdO2JO0vm8ftLaiMnP0nhMh
         BUvuLc7g+3sILEmH4FCv3njVma/zeIDXKMzZ+hn67lTItsprlohKFVphP8DOsoW8iZNk
         ch3r0hax6MtmDmi+qG3A/EohIpa94nqNeq4z4Na6niDX82E6sDrfO4HCPs27Xs29O6Iz
         892g==
X-Forwarded-Encrypted: i=1; AJvYcCWjYjHryj1SE/2tuUCgQx0M1vEYimYtG0iteSg6j7OOhIUbtlS+O0CZdU76pE+eIYYFD7J1iPs160gEyaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6K3utCevfNbRzpNuhs3Eowv4a3unDc0z6DVlYA2Ox8KWps71
	AaadtnAgYx9jo5C0cOvL1YhWCF2D8O8fnpYU13lBKVtSpI9UJqH4m452aJKzOIQG4BBwVuHP2I7
	8Jc+B1VQAh4mwrTrhOKGpi/r2sfaH+QjIT8t9aPdH
X-Gm-Gg: ASbGncsl6LZDOXampKHfyL+abOnBnLgdrildkJJ1jETAIzfBKTQdtW00yRnPQ09CAe9
	W4qbABu13plb4xL33nVON2aUQ+wdqaieslLyHLWBlFsW+B2/mSYe3S3dY8jS5pXn4hODdaEB7c+
	riLNa65/kuGJ2l4ghUkY+bNwRa37vlPAe3OD7z1FzoyWdFb49+GCZ5EcU17AEN846QInVGLN/gZ
	m9hwdn4SwIMNo9RsIV/IT/l5ZUyrCLj+/L7NpVGjHLtPRUMP4Ph32euSq04VMdQKMUD3XDbgSLc
	yy+3OKIwin5cXhI=
X-Google-Smtp-Source: AGHT+IFK/T7RW48hj+WP37N9B2l1dCUkOXONz78Rxgy6qFPZrqWAJdOfNPD+bEnJuzrg23GT3t2tLGdMLUv/EK5dHM0=
X-Received: by 2002:a05:6000:401f:b0:428:3d14:7378 with SMTP id
 ffacd0b85a97d-42856a824dbmr2474671f8f.24.1761180720791; Wed, 22 Oct 2025
 17:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020100306.2709352-1-jasonmiu@google.com> <20251020100306.2709352-2-jasonmiu@google.com>
 <CALzav=eqwTdzFhZLi_mWWXGuDBRwWQdBxQrzr4tN28ag8Zr_8Q@mail.gmail.com>
In-Reply-To: <CALzav=eqwTdzFhZLi_mWWXGuDBRwWQdBxQrzr4tN28ag8Zr_8Q@mail.gmail.com>
From: Jason Miu <jasonmiu@google.com>
Date: Wed, 22 Oct 2025 17:51:49 -0700
X-Gm-Features: AS18NWC_Hu82xF4WRuApY2_35h--MDrT0GhF0LG3r2mN6SSshPCeTMJF4FJ7YTM
Message-ID: <CAHN2nP+uiz5MMPTi5pBVF355_=GibgYf+6jQR1xVOAdtD-2aZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kho: Adopt KHO radix tree data structures
To: David Matlack <dmatlack@google.com>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vipin Sharma <vipinsh@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:51=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 3:03=E2=80=AFAM Jason Miu <jasonmiu@google.com> w=
rote:
> > diff --git a/include/linux/live_update/abi/kexec_handover.h b/include/l=
inux/live_update/abi/kexec_handover.h
> > new file mode 100644
>
> The need for this directory also came up in Vipin's VFIO series [1],
> so let's align on a directory we can all use.
>
> Should we s/live_update/liveupdate/ to align with the file/directory
> naming convention Pasha is using in LUO (no underscore)? [2]
>
> Otherwise, LGTM.
>
> [1] https://lore.kernel.org/kvm/20251018231126.GS3938986@ziepe.ca/
> [2] https://lore.kernel.org/lkml/20250929010321.3462457-1-pasha.tatashin@=
soleen.com/

Thanks for the suggestion. Yes, let's follow the convention in LUO
[1]. Will use "include/linux/liveupdate/abi/kexec_handover.h" in this
patch and share the "include/linux/liveupdate/abi/" path for
liveupdate components.

[1] https://lore.kernel.org/lkml/20250929010321.3462457-7-pasha.tatashin@so=
leen.com/

--
Jason Miu

