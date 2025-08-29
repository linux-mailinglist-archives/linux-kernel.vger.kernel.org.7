Return-Path: <linux-kernel+bounces-791525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74929B3B800
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB6A7C6214
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1AB305E27;
	Fri, 29 Aug 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmDIuR0b"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FA028751A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461683; cv=none; b=nzO/Q5jg5kfB8Es7Vf3OkwNOR5AV79xdsyOHdRNeatZgzNdiU9a1IdCOD6hI7dV5LF04hQpBjVWlPEeeXT9uAcpf5m5OqPMbd7oCZYLD/WpzHUwrdg4gomEVWJrSvBvaZrn7mFSVLDXc+96KVGzpPL3+N0908NpKnCFq+ZnKXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461683; c=relaxed/simple;
	bh=oRH8f0w1otAreNEGbebgngaGLPIDb4bCYEPCriBHAFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUFbj6Gxyu0NIr0yxBXr+ZutjSAUPg4/MWGBjY/bPY1tzQZLQcKgyrSZFAC5Qh8bfykXpa1YssdQXdZN3hdngHjzyBGtY3gmRSQiZd2LEOTpr5Dt4F4mp20Zfyw2P8lYQ5cIC3YUv2Dog7QMlhpP/8aUseLA4LUfNqXSA1e1kZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmDIuR0b; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-327e8c02ca9so28779a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461680; x=1757066480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRH8f0w1otAreNEGbebgngaGLPIDb4bCYEPCriBHAFA=;
        b=FmDIuR0bhpAbYxqK2msTmr2V9PtboHzwqOt+Bv+jDPUqud5Z3MwfXelRhcSyNk38mj
         /fV5O+QsOBho+lLNQsAFx3yYXWxorq+WIYHNiDFfPbvkNlH52LV05Jd3zWazPI27pZHY
         uu4fWwoOBp9CwDPmOOZPTSPPRU517ACXCvxFUXn6FhQbxuNUOke33WddVfr1phBrhxYw
         byN1k5EIH0Rt1rCTvKQs0iWm9e5eS2EbqbzHqCApAFQ4k33mU7TeYKBl0ee2Hnos300l
         TOqzoFWuPJG2/oSDLoL/F/m6wYrhN11s0sP3QSRO/ZfvIYtb619fEQg1KOCo7AQl27qP
         HMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461680; x=1757066480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRH8f0w1otAreNEGbebgngaGLPIDb4bCYEPCriBHAFA=;
        b=Us86mdjxqq6SS+XawOvBssadoK8nhlpfSdX4ysJk5RcLj0JQIiIL3wO6D2oKnYnEiS
         B0EVk1CXSWbwxfG9y3TORiMioAF8xjRVLzWlb4OYudX0c9qTMFpOT2h+0vqmLApWwfS0
         ybYtPtbs0qeVpck4wH3za1E9r0SB+PdbktuxSNevB7EGXK1SZ1ewmWcH1xHMA8I7kYfs
         DF6tK8podwOeJML1dRJpaX1KVvy1Mme76FvriyhN9qV2ExFRIk3fEmJ0YEq5yMZ1wPVr
         lCzs0U53CAp5OryB33b6pDmcCgEdRp4AQAv+wayf0kUcZKng86FTc3T/yNE6qhiqPs06
         I60A==
X-Forwarded-Encrypted: i=1; AJvYcCV1DkPZSO6bo39UMpPMNS0QQxFDE0Av3JKJOB/mL6Pv89u9acCJWkuXWkVNSPvgWsMSxfrygtek7+STC00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvNMX3dcOmsTvkzjH/sstLKrPaF4NOa1xPhOLgag6mEQX/OTGP
	TccsXn6lmDfKt9LJashzgDKO0mXIkLXs8dIp1+vzeJigogNiZOcxemHwZ8VHQnKAYw+ltNvndgj
	TebTlP+OkqM94LW9RO/TaHzrlLXB8Iytshuq+
X-Gm-Gg: ASbGncuxhqEyNGckMGwjWEAvM7DinHIthr9F2KgJSKfqvpv4qRXWfcdieXJzJJn7Vin
	CN7SLRcHrlexNrWTpZ0+USF+lz4VKTpGzOt5WG1+C0xfOL2kSaTM/xEV08vnpN5lMAKxrlD7+R2
	DmVbkkxS8oD0PKuCZFGo09u8HSR526toI0b5OjTDpai2w1Pps/SFuUKsn8in2PIBIY3kWne+Txa
	6rpW17lG6bliOv47jPxz7v57XK2xx/1+BbWBWJF21R8CJORF2TJhAlMw7upD2oCPVonSc4iPkAx
	gxpogDAs9srZeUMk7pV4vPmY6+g5YM176kug
X-Google-Smtp-Source: AGHT+IGJ2lYXuFya1m4Ramq705Evx78C2MmKVqkr3itmOClvIB24UWN1rI/gpubgLX/l8W3IhjN7k4QwxP207019zQA=
X-Received: by 2002:a17:90b:4a90:b0:325:cce7:f661 with SMTP id
 98e67ed59e1d1-327f5b1c87dmr666852a91.1.1756461679909; Fri, 29 Aug 2025
 03:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827082015.959430-1-apopple@nvidia.com> <20250828083737.22214-1-ojeda@kernel.org>
 <DCEKTF8CP2GF.ED9G9ECQMBHM@nvidia.com> <6f32c400-1f8c-4367-8be9-f7082ea87626@kernel.org>
In-Reply-To: <6f32c400-1f8c-4367-8be9-f7082ea87626@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 Aug 2025 12:01:07 +0200
X-Gm-Features: Ac12FXznrXiVcLbGyYEw1vb2wal1r3wZH6fiCopGfQPJ8S6r4KIMuLcfzgZ6bWs
Message-ID: <CANiq72n5N3yHU_vxjiHk=TeJ0ouW1+xLDw43hcOVv6qSPFa=sg@mail.gmail.com>
Subject: Re: [PATCH 00/10] gpu: nova-core: Boot GSP to RISC-V active
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, apopple@nvidia.com, 
	a.hindborg@kernel.org, airlied@gmail.com, alex.gaynor@gmail.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dri-devel@lists.freedesktop.org, gary@garyguo.net, jhubbard@nvidia.com, 
	joelagnelf@nvidia.com, linux-kernel@vger.kernel.org, lossin@kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	nouveau@lists.freedesktop.org, simona@ffwll.ch, tmgross@umich.edu, 
	ttabi@nvidia.com, tzimmermann@suse.de, 
	Nouveau <nouveau-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:40=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> I'm happy about every potential additional reviewer for Nova, but I'm not=
 sure
> it scales very well for the rust-for-linux if we get more drivers. :)

Yeah, it is an informal rule I/we added back then so that people
interested in Rust in the early days can follow everything in that
list.

The expectation was that eventually it would go away organically as
time passed if Rust grew -- I mentioned it here since I saw people
mentioned explicitly otherwise.

@Alexandre As for your `MAINTAINERS` suggestion, up to all of you --
other entries do that currently, but it is not a requirement, and you
are big enough already (have several people looking at patches etc.).

Thanks!

Cheers,
Miguel

