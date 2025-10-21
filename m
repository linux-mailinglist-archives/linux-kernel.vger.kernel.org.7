Return-Path: <linux-kernel+bounces-861978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA40DBF4305
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EF3835196F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE8F21D3F5;
	Tue, 21 Oct 2025 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFrytNTJ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49C2192F5
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007841; cv=none; b=CPB3raJKDoVs274/6U5Bc9buN/XsKXY+hv8eOSEhUmOQWlRnVp6boCOYWpLrkpg1xepjFX8gYSuyIRmZwPwm5NT+5SqYj7VFoVfXuOUFJo7MK4wwVXxwcKUXtA15rWOJEihSOFDbrukRJ8wMCeYSOJNb7HjDV4kkHVzoYRosZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007841; c=relaxed/simple;
	bh=LiSMJjvl5jo7T9ZHtXYQgM3pgDGZENbXLXRwrLZB5bM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uqob+A1aQuN5HEHO4JX0sn8w/P5hun0MtEpmH98Nd6X34GwTiesEO4DhcfR2L5x1F6Md17X8TDpuAN6+8xbc9q7aKGKxrj4pDGXWSb5DyCbLv0X+NZGtAm+rWDmVB3MOZOU4d/TE9LHjrGYKtqSeu4xabpPyanaK6EAZQUj56vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFrytNTJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7800ff158d5so4465597b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761007840; x=1761612640; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/AwBHEuiIF/vVerErPvl1X5GkSsh/z+FWgAmDfnocX8=;
        b=LFrytNTJSLZrw7TEmvVd/a0KIf+EQ0I6SERhOUwYm46Z4WaGFXW6KZsZ5KT1vIuQ/i
         f7dWsV3Pk4rbQMKBK3YaHGskts/M7IdVI946IRt1IDM47XkFmbsSLOWhITXEobuZBW8k
         H4ac6vhICjTXMG5AeLq8Xoi8i52iycGcqinGFeRd7aY450cSyskVv7bAgbX2w14aLTe3
         yDHr3bqeYyK9SlsjH5fLP+qXDZTKNj53YchleMe3R4yYKO+/goAuGg6cYHFEzMfBdM6v
         PwKSgIqYBTKvfLsCy3gWWSYMmQPoWD9lxizTzDbumkAvR/dHgHDp2Q+R//I+XlJOtMW9
         sjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761007840; x=1761612640;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AwBHEuiIF/vVerErPvl1X5GkSsh/z+FWgAmDfnocX8=;
        b=uVQVk0hi5zx/9ay+eOOEWZhZhQkUQiBP/3OKuYOel/FKUTFH1bD0mMBzKCZnW0TGcd
         y0qBmIxa5tz1P82/v2L/gCsbl4t7Q3zFTPPxfAq3Hd3GFsIWsoNL9EjUqEsE2lkuDj6G
         TP3jP5QvFnD2y0fbcUTZ2PkByYFaPlZWAloRJlSJqIGWxv9fN+zlK5YZlWtbZiQ0LLUf
         bJGVWVHUDbmERa5pwsWZBljHC5d4blpF6o6aiYiv4c2XkapEfiVnR2cUnq0KTiXnzAUe
         dA7rjVgITPsbn1etMwJgkNM1dsaEHGXeG//xrKCRDdl1OzRa9h++k3KYdEJDx934N8Vd
         U4xQ==
X-Gm-Message-State: AOJu0YxNMoT4T/quZKsXmQgNZ2UVnDnIwlTeieToI+MJs9a1NGTv2K9C
	hRh7XVzJqQecKLwsyuwUs8zhgA9gAtMASWSOkI3kf9tPW003bMQo3XfY
X-Gm-Gg: ASbGncsf9bKTO/80KVeWU40JtWsDSVgjBZRfwHnEllcrF70wX//sRNLHlzxl/IRKJxQ
	napOml5W1R4J1AbWeKKvS/bQfkScu4Yr7372j//oifJ4idJDEFdfFzS0OuMKx1ZTMfK1z3MpUWD
	IjQSwUT9xB9RDB7uYpmSP+4Rtw7zdUREvoS1+TdPF1TkL7UDbyTEq3UqhK58TUEq9rm71VBQXhe
	jjNex1TwrEsJHWmHmhB9t6zO8rvM95Y4fFJviziu7dwcfx/9lUSgQn8/+BXKf/TbuBsXANEpQcf
	vplUTaSCLxJJT8AnaKi59t9c32XB5iRWalU59rDucPqn0yYuEb+4xu+cOpNLv/AjIyoAGlBMpmz
	z7J6RBA921py+DHh5juu5Bf5QUbV5lDT9ibQ1bJxP8Ood+aXmsneYslKMyWoBR0MRQa1jFQ+Pan
	6qkDIko8muMH316i59qF9Ef/pAuA==
X-Google-Smtp-Source: AGHT+IHYKVM9Wx8GOSPuqIF83Hb6eKY3hy04OhRs1+D0AiReNFfKAOTUse0p3aL4q3fuZ6sU3GCGMQ==
X-Received: by 2002:a05:6a00:1398:b0:781:27a7:dd00 with SMTP id d2e1a72fcca58-7a220a92441mr18548293b3a.2.1761007839788;
        Mon, 20 Oct 2025 17:50:39 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:badb:b2de:62b2:f20c? ([2620:10d:c090:500::4:1637])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1599dsm9629028b3a.4.2025.10.20.17.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:50:39 -0700 (PDT)
Message-ID: <f7024fc31ccc9c8b8bdfe2865cdf3604079e0039.camel@gmail.com>
Subject: Re: [RFC PATCH v2 5/5] btf: add CONFIG_BPF_SORT_BTF_BY_KIND_NAME
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Mon, 20 Oct 2025 17:50:38 -0700
In-Reply-To: <20251020093941.548058-6-dolinux.peng@gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-6-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:

[...]

> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f0..08251a250f06 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -101,4 +101,12 @@ config BPF_LSM
> =20
>  	  If you are unsure how to answer this question, answer N.
> =20
> +config BPF_SORT_BTF_BY_KIND_NAME
> +	bool "Sort BTF types by kind and name"
> +	depends on BPF_SYSCALL
> +	help
> +	  This option sorts BTF types in vmlinux and kernel modules by their
> +	  kind and name, enabling binary search for btf_find_by_name_kind()
> +	  and significantly improving its lookup performance.
> +

Why having this as an option?
There are no downsides to always enabling, right?
The cost of sorting btf at build time should be negligible.

[...]

