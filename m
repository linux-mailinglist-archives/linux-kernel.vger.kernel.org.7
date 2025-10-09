Return-Path: <linux-kernel+bounces-847573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D93ABCB382
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 825294E5DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2361A01C6;
	Thu,  9 Oct 2025 23:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVQ1LGjW"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDDC1F130B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760053270; cv=none; b=MQnEPcIiHFFE0UAsEAgFKFcPjyoZexkd7+Wh9AU65/IGFXf8vXI1RCbi/BLEmPypkgZV/Ind2p/Qm/w5ogM0CeMwZyiBNveIfD4AgDEEVHS6LGKVvtRw1zJRuofxDIto+Y6df50powuhe8Fo2HjtpV0fzx+5Z6PHOvSLqkbqVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760053270; c=relaxed/simple;
	bh=lhUhtM+UZMeb4vU3TZGzGKOGnDsAXUUGXG6fG+ZZYmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2+76eanQyzIL2G7E/PoFFCo1s9wHC5rRNt2Wd7KiVbvMsx92XUiMoU9ZHhIJapMkqmlILtvINWqb1dIJ+lv8rrl4Nx8IV/swy6YsDZGKVvhbfBurXxG95JyDI1E0h5AIwyB1WD5bwU9BcFekPd+B0vP6m5p21r0XjKEnSjFsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVQ1LGjW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27eed7bdfeeso19058675ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760053269; x=1760658069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+Sj/FlLClIAaIi47L5d+OmfIP9+1/M40ysaJFq8xtE=;
        b=DVQ1LGjW2sVCk2tAHrjGHulfG7tvE11wzxcsu4TDw85lrr/xIRfG3rwsVhPI90kRlM
         CDrWFPg4XrOVCeXViTxIHvGhVXcXebptd+P++MI4lNraGl6OqgZw/BioBPuNYwL5RWR0
         vRt2nT4prI/n+cgzxhta3otfvTV5Az8Y/7gBna5l/FrQ+EtmrEM+Gv86cHViNJBizT8T
         ZgGaGtmC+eNe+/EXfdIEwq7D/ggMOr99RRuaSHDAoeJp1AhAiKf0RelAF/fgplcRhO+4
         vs1XJPFUlU/t6mf/GriyXwW3SUBDiVvYczV5xCXxBbxRBVj71rv8nKYtbbLHbMVhMq6X
         RAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760053269; x=1760658069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+Sj/FlLClIAaIi47L5d+OmfIP9+1/M40ysaJFq8xtE=;
        b=KYule1tw0ip6nIQu+3iERsshh1vAizGlskzIj5dmMCRhnrcbZz7OWAy0SXy8e5tzDS
         hzLG5Eag0KpLXCJV/sOB97AbR457Wh4KHzt9nyy3R+ku7LOJCJoXCOnVZR+Q/V9az4mU
         kK0LSoP8r1t9I2JYJKrS2ZdrK6gQBkuA3EmeZJNQ8+Bgo4rF5ZqbIj+tbDF3bUpv0wgF
         fIO/4MpUIKAbr46TZ9WtKgkkz88eVm01ZmMQsy2O87hIBbdj1EdLb2fmHN4qHK0U/Bu7
         PpPxUxfJHw/jgh51ctJIeHKfSp2tU4PzEN4cFZPVVPIrhGTrDyiUVLEJrfDdEMKfQWgP
         QFNA==
X-Gm-Message-State: AOJu0YyRp8wOMaDvNVIg7m5HOPk1Hf4d8W6G2axd+GaqgwhBXPA0wI+L
	zTtghc2xUUZNrDg+i3GBjMwtCTNs+ENkaXPdztppD+0P/E6a1mhZuIcO31rkWYniiLiivjGh7Xa
	+3YRqZw9PuuxD4XBi2A/FW08aKVvZY+k=
X-Gm-Gg: ASbGncsMqb8e1DmTNAeqx1EPFCMJfBXsTvce69jDbQPSXTwzFmXSlss4jBcqOuNjGmU
	4t1k5YoOlt9rnGrWoTrwS+XdAY3iN5CaQEVWBFZi4ViuRqORWq/FO+z18xBmLdG/VzvlrU7J001
	9+7FPmjTUQQKdr9e2180UOWRmpiZCIZeU9pf2LY0f7aJnbgL7UOfsMeXfXAFr1MqnHhyPOVHz5P
	tWRTfRucFyFnAsug5oz75Nqid1W
X-Google-Smtp-Source: AGHT+IFG8GuaAnTC9mm4pLh5wMTiHUgLi3ZgKsO3tOKCTCi2fMgbktYjlP/dKWBXn3a/6oaAReEJJC4o43voe3I/mKc=
X-Received: by 2002:a17:903:1acf:b0:269:b2e5:900d with SMTP id
 d9443c01a7336-29027e5ee48mr125511745ad.5.1760053268902; Thu, 09 Oct 2025
 16:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006191329.277485-1-mohamedahmedegypt2001@gmail.com>
 <20251006191329.277485-3-mohamedahmedegypt2001@gmail.com> <DDBISJ2DUDF6.150HCB14ZRPH3@kernel.org>
 <CAA+WOBvu2Gq=SM2TBdahsQ-RVi+vn_U-oDa7-DG6kj9Arq5tpA@mail.gmail.com> <DDE2BDLEZHBW.253EO66P7ZH2P@kernel.org>
In-Reply-To: <DDE2BDLEZHBW.253EO66P7ZH2P@kernel.org>
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Date: Fri, 10 Oct 2025 02:40:57 +0300
X-Gm-Features: AS18NWD1KmuNQjj2ajk1Vp9hVJ3FbFP6Rph0sUtrDfNLzUy8yptTDSkt7HErI0Y
Message-ID: <CAA+WOBuAJpQARp70XRpLWBMUG6hJCY0+1-dDKJrxQAQg3SwaLQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/nouveau/uvmm: Allow larger pages
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Mary Guillemard <mary@mary.zone>, Faith Ekstrand <faith.ekstrand@collabora.com>, 
	Lyude Paul <lyude@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry about that, I misunderstood what you meant and thought you meant
to remove select_page_shift() entirely and move the shift selection
logic into op_map_prepare(). Done and sent v2.

On Thu, Oct 9, 2025 at 11:09=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Thu Oct 9, 2025 at 6:51 PM CEST, Mohamed Ahmed wrote:
> >> Let's move the call to select_page_shift() into op_map_prepare().
> >
> > How would this work? Originally when we were working on this, we did
> > place it in op_map_prepare() but we ran into the issue where
> > nouveau_uvmm_vmm_put() needed the page_shift retrieved (see
> > nouveau_uvmm_sm_prepare_unwind()).
>
> -                       ret =3D op_map_prepare(uvmm, &new->map, &op->map,=
 args, PAGE_SHIFT);
> +                       ret =3D op_map_prepare(uvmm, &new->map, &op->map,=
 args,
> +                                            select_page_shift(uvmm, &op-=
>map));
>
> You can move this call to select_page_shift() into op_map_prepare(), that=
's not
> related to nouveau_uvmm_sm_prepare_unwind(), right?

