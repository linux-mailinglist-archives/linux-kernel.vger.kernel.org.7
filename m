Return-Path: <linux-kernel+bounces-805783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F7B48D58
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1191745FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C95F2FC01D;
	Mon,  8 Sep 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nn/lEiC0"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E329A1DFE22
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334328; cv=none; b=rym0DonJHAMucAkJN+cS0DAgWx4jU04XZ4h1cUXW510jgdlkvw/qiNk8kREgajpBo1peQXcHYcYr2RSQO7Coo7cUNWuUwr9u+t9LqplZ+88qAwE8zg67Iq6wtNlecUhpGXyLjffydjWQqqmsBaCVLzL4QzvvoEyKfzAUwSFk1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334328; c=relaxed/simple;
	bh=9azjghk2xcsfZmAQANBgaebfspfhLCb8gpaydbglb38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/U5wBM+KYt2Ms/UFffA1WZoa9+OED/XM54C04IOMizDapjxts3idxQlsaCg25aY8XA4TvjY9ea4Rxj923UyKwDmJLPFDIc0mbemWMDvpxdbwn2ZlkF9B+tKxiq6ptA3ayscc3rpOZDtFn0gbgAAczQGcK9/+7v2PEKLd22W0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nn/lEiC0; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-560888dc903so2122375e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757334325; x=1757939125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2OtEpvnvNll67fbUxSAcjD0gCAC/4drMbXXMiZy/cs=;
        b=Nn/lEiC0sLSmIA0MKw+hU3EQxezQXPPKe6o/ZfomRlAf5Ebh+yJxDoGnkT3hw8kJjJ
         QVjPYC3iHa6krwhk4wQWPLdAD/tcrbT3YJGVFh/c6enNCJvehOEUjVNsEwxN6vVniEZI
         KU1YDVGK0LKMwBbLJixK60P9ng11dWaXrujDXxFXgrbMgn1FmN0UaJw13RLg7znR1BKL
         7u4K3mMd9QWKPNckOuODdj+5SR7hQFc59y5yshsTvxZ7zB8Mha8CnkE2XorXyieyEfqS
         v+ea4ym5UN45ujzOuLq2Goht4BKxFFvB5poU8GZQ08B6Ni9tdVssattV8gAzVLV2nqnN
         ebzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757334325; x=1757939125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2OtEpvnvNll67fbUxSAcjD0gCAC/4drMbXXMiZy/cs=;
        b=sxLRUOX3dJqJAHbFj78mayyENerJhl4IY2etnyquQa+VWytP1/TMmuDacLFCRsHQGd
         RdHnCV9Hc5sI7wwOKuvzRMeqO/VKjItNG5J2vImqTBrCRraKvObHvxdughjeprtrZVYd
         SiXBM3CbAu5E+Lq9HX+5CDsEt+S+h6PYZemvNKEFZ1vm42cB35/uoC7d6ZuPGl3pp5w8
         /ROEuufDQ9qHf6QIsceyJYTiwJzZ/HxYWw7j5D2SSF5QS0owcaJJaHtdw138QDHwGzgy
         BsKcRpcovwWFsfAaO+r9EEI/I0Ssjld9dH9isyylx9w3zj/3PwMhCKhKDh1IzYIm06Yp
         tLHA==
X-Gm-Message-State: AOJu0YyYI0MCD/cMnIhwejUb2NtsmxvJH0M+Nm9J6C6IQVGNtp0OCVGB
	IyruVuEhuzmleWx3bnFpCSL94zP2aRO+LFtSAdObAs+mga+pRqcszhGrcRsRVaRl+AZbSwTh5r6
	+0cWqZAeWKejOACEDwZC0pm084RKVhROffFUYgtD86w==
X-Gm-Gg: ASbGncsamq723uwP/UONGFLkUlMyI/h29wT8fROVp+A0WxyHQ8H8uwGx45ONV9udFqW
	3YIS4VVtEiJrDhV0iGe9A6Y2dkR4jOZND1iMyT4YXWwNSrxQnf1L84sIzfDE2klDgVwAbmcz/79
	NdkSfWav7xAhcuaDUe9cp6Fg+TarUT+D2N9OQnkCsxnW4u8j3n8SupPypMZetfVDGKdSZq4jQ4w
	r2SfN3vH7mJrEx4JGKXn/YwW4veU5XpCyNMlCibpWQZp0t54Jo=
X-Google-Smtp-Source: AGHT+IExx/gfxmWNRKNNKBWyYkZlBC7eWsqjFOGaVOPhAuo3NUC6qkn3Wa81tso4tElQTsfMK/eIY9azCYilycgcsLc=
X-Received: by 2002:a05:6512:3d11:b0:55f:6c5d:759d with SMTP id
 2adb3069b0e04-56264354939mr2295450e87.49.1757334325045; Mon, 08 Sep 2025
 05:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905091325.112168-1-marco.crivellari@suse.com>
 <20250905091325.112168-4-marco.crivellari@suse.com> <aLsdBIY01140Vyy_@slm.duckdns.org>
In-Reply-To: <aLsdBIY01140Vyy_@slm.duckdns.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 8 Sep 2025 14:25:14 +0200
X-Gm-Features: Ac12FXwUE27r5Xda9gj9HBXobShUUaWwjqsywgktQwA-5--CsN6zNGOO7S7aENE
Message-ID: <CAAofZF6JJQqSJ0=_TeqCJwT6tor82Ce+m7z4QA1q8yFE31OdOA@mail.gmail.com>
Subject: Re: [PATCH 3/3] workqueue: WQ_PERCPU added to alloc_workqueue users
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 7:25=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> The patch doesn't apply to wq/for-6.18 and...

Hello Tejun,

I will rebase the work.

> >       system_freezable_power_efficient_wq =3D alloc_workqueue("events_f=
reezable_pwr_efficient",
> > -                                           WQ_FREEZABLE | WQ_POWER_EFF=
ICIENT,
> > -                                           0);
>
> Isn't this missing WQ_PERCPU for system_freezable_power_efficient_wq?

Yes, you're right. Sorry for that.

I will send the v2.

Thanks a lot!

--

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

