Return-Path: <linux-kernel+bounces-872473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35498C11484
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 275D1352994
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80DE30C630;
	Mon, 27 Oct 2025 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkV0gjLe"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28AB2DF14D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594976; cv=none; b=gDuYaotsDWt3lBSkvhdvtqkgpVfblTJ8RQWGVEaUI90cBntwCyYIvnFyYCqdQYyTQfmXsSoh4aKvrOP0kPSJdSVMLLfsD5q/sD1ykQMQLBwEgOIRLTVcU9jTNWUUYVxrs1WGErO6fajc4HnS8IGYwxNR3rVsEDvKuRN0hcLrJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594976; c=relaxed/simple;
	bh=Av/b87o60kt4fRKuXDsBRbb4urtiij5xxToz7XJ6ECA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByqxUq77p08uCBR9aWfQ9UY/FFOH/+CpB9OvpEpJaaZcSRHKybQstDuE/j3qxnpjcRc19fb+f6ISAyww5OSnDQifLmNRbpdm83cLPqiFNJlhzUWE7CHPv93RVOVZmDSbpV1xr/B7T7Hy/YHjMZkNbW+DBNRcNxXYNNswpdXZiLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkV0gjLe; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so3785056f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761594973; x=1762199773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av/b87o60kt4fRKuXDsBRbb4urtiij5xxToz7XJ6ECA=;
        b=TkV0gjLePAiR9NVnGk0Ebkp8ltL6D1pW8xT3+0GVNZnMCEvF8UbggHtCA7+hVU/KWT
         wCc+CeNX9Nb4sZ45MID5qYrtTlePJS0XJjl/N6oobWa/8nCD+CAqhTzmlf/Hg/aiu14a
         jx85C2CNleixLgywFw4Z3U1iO8440DPa8cWR94M13lfX+1qvMLPZq2eqh9CMF9mpz2cI
         1E5TuBD8EZoS3wuUglXCscQVVvez6JQuFsbYd82ZQZchMPUgC/+Okrd9zfAgwgTvxr3D
         73L9Q574gv+C2wb+9rJbaBXTjyiwEyshoZQgb2KgBp4VWiIfH33ISwC0apYgGujfQONi
         OfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761594973; x=1762199773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Av/b87o60kt4fRKuXDsBRbb4urtiij5xxToz7XJ6ECA=;
        b=lzDK3Uqp/6prdz0hieDFs3ZYJLLpLeeGUXTobNRxD3r2kvdDH6IdkP8QBt2NJTseyV
         vV0tU7r+zggYgsHdC5Ln9pnSfUn7iw/zaVRKwM62yL0kgXftvL1qHm8DW8oFN/jxhjWx
         KDeO7JvW6++QxXAXDbh539nxHTkuiyGzoaygUwmjXesH0+00opvLejtnzXYbg/xN4Yrh
         f1WWgsyg1O+CACYKYGiDB7uFdoPuP8jssHIMNELrBnRygj0ONP2oyQhY4T2/Yg32sX7T
         zaCTg0v0b/d28VnW9R860+uLrkSR2qllxTCP0//P8B3oOCJmetENirZKPKCexw8CqcSL
         ATjg==
X-Forwarded-Encrypted: i=1; AJvYcCUq8b3eIoMMcOZgn0yDLvk8pcOo+8Cy/p5ADZYKLBVOR+LFG/noAg8lwhVlb4xAWZ5diCVdhNZNEYX20Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk6I6LlbWm9n6JG001WY2QGnay58WoewolQC42VdlQKIHH2RwR
	Z8wel8r5ZyTBODyn1PbU2+e7BUmuQEC97McXgVBt+rc0/uFVe0PNTPQyClNO1puV94Binw3Q3Ef
	OveunashzbwHKHIqNDOqFd6OS7O1eDNU=
X-Gm-Gg: ASbGnctszNXgL8h5QIt6/p0n8xYJ9QXoRx5w0014V0G/tU+4TDcokgURIfmJmEjkOoO
	FinBqwb7pxD2FTjSaEIgzbJCCYZFKpiLGw+IpDLphRJOmx61xCvJaossK0aRynoyZtQh6gnL7Mr
	KffhTsQ7V3mGsB0XGGOSyaQ3agPYCHmCuIXL2FZ+fq5VkssuW4+ayVbxBya9+Cz4ecW6atq5kKF
	UNCVAzTDLRoQxwS3Z+9SZEF62VT2LnDgWpStRc/qPEjJyuIUJZ2yuM/DZMu0Uhnn2Pc3fibmuCE
	F7IUbM9GMd0=
X-Google-Smtp-Source: AGHT+IGkJe6IxQG3ZzGtCnUTzisW5p8uuoW+35RXoa4Vr2RavhP+QJRYfvEMxbh86JMQ6VV/YhWT8jH06guakc/3B9k=
X-Received: by 2002:a05:6000:2383:b0:429:8d28:4079 with SMTP id
 ffacd0b85a97d-429a7e86f31mr788123f8f.62.1761594972792; Mon, 27 Oct 2025
 12:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027135423.3098490-1-dolinux.peng@gmail.com> <20251027135423.3098490-4-dolinux.peng@gmail.com>
In-Reply-To: <20251027135423.3098490-4-dolinux.peng@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Oct 2025 12:55:59 -0700
X-Gm-Features: AWmQ_blwlF2Rd-fsxsnykdevc7MNfMtJZXyA0h87WpXOe2WdLWBp8FO-pfhQLEc
Message-ID: <CAADnVQLdN1mU-jR70WkkrWcfHXU1OOKDfWLdHS5Ji3-Fe++-xA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] btf: Reuse libbpf code for BTF type sorting
 verification and binary search
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 6:54=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> +
> +/*
> + * btf_sort.c is included directly to avoid function call overhead
> + * when accessing BTF private data, as this file is shared between
> + * libbpf and kernel and may be called frequently (especially when
> + * funcgraph-args or func-args tracing options are enabled).
> + */
> +#include "../../tools/lib/bpf/btf_sort.c"

function call overhead? I don't believe it's measurable.

Don't do it on libbpf side either.

pw-bot: cr

