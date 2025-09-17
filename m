Return-Path: <linux-kernel+bounces-820777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C9EB7F334
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB35E1C8041A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68AF323F68;
	Wed, 17 Sep 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b="iQtHddGw"
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726132340D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114858; cv=none; b=psXtN7Fl+Yk6yqzY+XrA4SiA8VJ6cH2WUd1zjLQnzTsBMTbXJ7qBKF0eXKnDuxc4gnxoSWXWATabNMh0CSU4djqvYchQ2dmhMbxIOW5Vrqtk93WTBa/POA4qaSzdiE1Gof4bxFlKF8savxTpvlB+6eHXdKCO8d9Vh5nZYbkK6Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114858; c=relaxed/simple;
	bh=AVTfR3o+7jn50KNytEpn1CX8gwyVF+e5qSI4wA5XEDg=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJOYYF7ZjV9sgytBiFsOIy0oUVyWuZLb9qNV45yq39r3sMR7MeVC3K+kjRVbMXdWdbYSiZE/PIMWS8GdzLSQ3DI2df1A5SnJqlgjPEcp+9FZar179JkdNTjVEG/lo5yfWHEPUutZvizeU0SD4nk9hSEXn+bzBt6gYE7E7BoH50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li; spf=pass smtp.mailfrom=cock.li; dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b=iQtHddGw; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cock.li
Date: Wed, 17 Sep 2025 16:14:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
	t=1758114851; bh=AVTfR3o+7jn50KNytEpn1CX8gwyVF+e5qSI4wA5XEDg=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=iQtHddGwnWdt0gEkK0i1Dr7qeeOWC+cux1qV3l+uTQhh84TV8I4DajuBJGqo6dhNx
	 B+AEVbXBQGFFei8hZH53V2LrnAE/dd7VttjYYfgbxe4dRM0gz4+j/6xk7meklHx4+6
	 aNvTKW4F6CPrQ0ZlZMlUhA48j3kSnTWsuaVPW1F15C+IBpkF+D7VKZAss/EpwiuRyC
	 bO+QGBN0/kgI/wBSBytkHBm71x1RckPltXmF297on9E1LSyFOZDz2GA2jxl3rgdNcw
	 RaaxfdGZaN0HuzsFaJbiVXxnw8z5iVCIiQLgeNvALfyYCfbD/0dRmFmPkgz2J9q6wB
	 YxWw8o642y+dQ==
From: kemal <kmal@cock.li>
Subject: Re: [PATCH -next v6 10/10] arm64: entry: Convert to generic entry
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel
	<linux-kernel@vger.kernel.org>
Message-Id: <G3IQ2T.YZ8RX05BU5F81@cock.li>
In-Reply-To: <886f1357-8d14-bb63-bf46-837bb6922ebd@huawei.com>
References: <20250916082611.2972008-11-ruanjinjie@huawei.com>
	<20250916144621.5606-1-kmal@cock.li>
	<886f1357-8d14-bb63-bf46-837bb6922ebd@huawei.com>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable



On =C7r=BA, Sep 17 2025 at 09:55:35 +08:00:00, Jinjie Ruan=20
<ruanjinjie@huawei.com> wrote:
> Thank you! I will try to implement arch_syscall_is_vdso_sigreturn() as
> this and test it. By the way, is this for supporting arm64 in wine?
No, I don't even know if arm64 windows binaries do direct
syscalls. This is meant for some other project.
>>=20
>>  2 - This trick shouldn't be done if the syscall will be catched by=20
>> SUD:
>>  if (scno =3D=3D NO_SYSCALL)
>>  	syscall_set_return_value(current, regs, -ENOSYS, 0);
>>  As the ABI could be anything.
>>=20
> This requires discussion with Catalin and Will, which may alter the
> original intent.
Sorry, I didnt read the code carefully, syscall_user_dispatch()
already calls syscall_rollback() which should restore x0 from
orig_x0.

You can test SUD using the selftest, but you need to add these
lines at the end of handle_sigsys() in sud_test.c:

#ifdef __aarch64__
	((ucontext_t *)ucontext)->uc_mcontext.regs[0] =3D (unsigned int)
			((ucontext_t *)ucontext)->uc_mcontext.regs[8];
#endif

and you should define TEST_BLOCKED_RETURN in sud_benchmark.c
to make sure arch_syscall_is_vdso_sigreturn works properly

-kemal

>>=20



