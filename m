Return-Path: <linux-kernel+bounces-798844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF82B423CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F431BC2CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BF020298C;
	Wed,  3 Sep 2025 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="OO6D0bjv"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607491482E8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909911; cv=none; b=d8HA7PddttmLJ+cRev7/5DVPAAhazJQsVadtQ5KofuuPCeXnZMdg0XgiaEjAPAelMSn4NLtlFUL8ttn1ba5MDrAreM9PbeaBjtEVGncmNB7LaAp9Y6G1ODOWO2WCja+rz/ZZRns2ETLOxKkuE3RTcOKAmSR+lW1IY8XHfetGOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909911; c=relaxed/simple;
	bh=dFJHOuSlomZMY1e1WhYT/9BjuUTdLl4qUfkdjnWwEdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAGMw2IqEqGw6FAfR8rY6dStPPLdUATcbqcK3G/RV7/MVFmUKDHtcf/OmK1+Ia7++ytaRlzoipcEATKkWned/X3vjdtrymC2w5T7JM2vc2jXIuAgMiLcMkmpm/muCMIK1f/qvpnnvDxNN4WBYwnp9+49bxLmBxx8DB0iVSsnOG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=OO6D0bjv; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3f2da50ad46so31836625ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1756909909; x=1757514709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xK1Ixt22UPQpRV6eJF15nySq1ENYn93GAeXzGVGJzQ=;
        b=OO6D0bjvsCNz4UDjJc/eT5GiK/c5J+Hxok4gpK5DlhwLVFp/jDdWosAR0he7yTlLMP
         G0OtHeQ0jLvw2FPtrRVnOyiflVyHps0HdBMYaZqXglvh8vADnJ1lgEM1k8YFHsoFkjSA
         vbkuvgwq1SheH2p7HotMXtBh0X7miwaXjKP5XsBqkssNoeuiOc17ydxcwo3wJXuura/i
         Jn3WqYjZ6ytUt//11QiXNCZFMy7ZPoxAFiZ7Fa0kmb/v2X91DCa29XysIjuzkWZiCyns
         9gn97QRkMgJ9tO3RnL7mjbWy0933idCIfYYoyissrdB4I8ngszURRBpkFLAF2IGTN2je
         n/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756909909; x=1757514709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xK1Ixt22UPQpRV6eJF15nySq1ENYn93GAeXzGVGJzQ=;
        b=dWYbRVHz/AD2Fhd/2ueSR06Gjf4Y72B80nCm7chGDAE+96gBu60ldMHgPTAhnwz/MU
         qXwrgP3Pnaf08nBIJwHJUaS3qolgjgjxyULBu7UVZkNwLlYu/Cwbh0Stm6FD0hGGUtHt
         4NWjCbDTB4xyp0HZNuKw/lvcfln3MCE8F9Oh0dey228w90C1oorxdVJz4ZgaWlpUr+p4
         +s8edR4/vZF964T1Avd1vgQuS+tRyEz5KqWsREkOn6JFK8dx2KtdoJc96/61BExrKLKh
         CpnF07I/bZ5jghAZ5+5d3I4KoU7BSq4+VsGBRV+cpnJ179CoFTiWVs6697YXkSSflmYC
         Q6+g==
X-Forwarded-Encrypted: i=1; AJvYcCXYlLF2E0l/furPHV4fipN56qPfqWuyItwPIlFMlOIcBWAa/+0SepdThsd7k2Yl1Z3EKp9J48e7cQ8PFeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwzJXNa1BsHUN61Bq2HAKVSiUsYoV2TwoLwpD/DKozEfaaGO8
	pDjSnejDAl9Mx6a26Ox3aRK346CG6Frtwb8RE1XoNxOUOxJd/5Nf5QhQn6sSd3cRLs0m8ALzIh3
	d27v3weyculAVSsJbL+KJVOhM9kOgm+Z3W4WCqxLfVg==
X-Gm-Gg: ASbGncscx/eGu7bQKFERS2l6a8rx6npHq+foHVYbg3yfR5X8Ev/y9Nc1tfdv3bSgBKM
	5G8gR60yrKi/VcYt/MiAYWgEr7UWtRk+FyoipWgu/7AhI6NO6+gWT1bLVnjZdRXtqYA22XeHokp
	g0RAf7cMrs/3faO9bkwYQiYpeHwzx50cFI8nJTreKxKnjX3MNAbCuJ1SrTk7KMSLmKGd3+uhAOe
	MXTgwvrhQXe+EtnyPeKc5toWR/BeOg7XXfgyUaoEW6G56ezw//iDjxya1HR6A==
X-Google-Smtp-Source: AGHT+IEdqptgFgnh5uv2GzzQGJFqAZUOszFTkmnyBR24wl/TgHUrHJeCtE9hinNDxe7tcZMD8cJExtpH41CpN+afzKw=
X-Received: by 2002:a92:ca4a:0:b0:3f2:1a77:4876 with SMTP id
 e9e14a558f8ab-3f4024cb129mr260307905ab.26.1756909909294; Wed, 03 Sep 2025
 07:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756710918.git.dayss1224@gmail.com>
In-Reply-To: <cover.1756710918.git.dayss1224@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 3 Sep 2025 20:01:37 +0530
X-Gm-Features: Ac12FXwG5rgdOIo0vaX3JEvtxdbhO8ebAqv0PdEvBcoUhtsHNdiKMQlA4BgxMFY
Message-ID: <CAAhSdy0DriNa-90QO_YgUbuxrjkDSQ_iTtNVG5ie0h09y2xSHA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] KVM: riscv: selftests: Enable supported test cases
To: dayss1224@gmail.com
Cc: pbonzini@redhat.com, shuah@kernel.org, atish.patra@linux.dev, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 1:06=E2=80=AFPM <dayss1224@gmail.com> wrote:
>
> From: Dong Yang <dayss1224@gmail.com>
>
> Add supported KVM test cases and fix the compilation dependencies.
> ---
> Changes in v3:
> - Reorder patches to fix build dependencies
> - Sort common supported test cases alphabetically
> - Move ucall_common.h include from common header to specific source files
>
> Changes in v2:
> - Delete some repeat KVM test cases on riscv
> - Add missing headers to fix the build for new RISC-V KVM selftests
>
> Dong Yang (1):
>   KVM: riscv: selftests: Add missing headers for new testcases
>
> Quan Zhou (2):
>   KVM: riscv: selftests: Use the existing RISCV_FENCE macro in
>     `rseq-riscv.h`
>   KVM: riscv: selftests: Add common supported test cases

Queued this series for Linux-6.18

Thanks,
Anup

