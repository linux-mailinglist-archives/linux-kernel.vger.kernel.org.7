Return-Path: <linux-kernel+bounces-789390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F761B394C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5751C25B20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7BF2D0626;
	Thu, 28 Aug 2025 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="jwaBlKKZ"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A249628C84C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756365131; cv=none; b=Qsyb60/KiSGhyLVfgF8IEaWU5cLQ7cTVdQSaIVunxKOOlkeXEcAZJzS9QDQMrbOj+JuCbAvi6hskBdkkJkzQigiD5xD9ZHix9T810ARmR3jVXh967ZfkmCpoYukmFK4hk2XqutzTMOaKtabh7JHG+G4ANQXyJi3zJXy5DvuWMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756365131; c=relaxed/simple;
	bh=X0ReWVy/9bRIZByWU1a4LxZFCHhsB6SDNoJO/V5qW6k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kf429+1MwWO6rxMMlA+gdCcqQOUcbHxHU74ZL0uUE6BKTpiJlq2YVCDj8GYcAg/c4XQJXuuRMmB66dQDPaqNyMR0LaWtZWYxlEgqUs3zngu+EA7yFFBo52Vts0TlkAa7t2Ow/1uKPzNvas+Yvm8Zb7FrrEah3fxfp68G05zDSDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=jwaBlKKZ; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1756365129;
	bh=2OR7QGlfaXKbbhmoHE/dYhnXZMft1PS1VCZ/6tJ9vr4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jwaBlKKZLxoFHt6YjYTV8msCnlnHUwAQLWnsUkXzw+O4RGp9XX5uTAF66EBq0wzly
	 GPFyPzmMgUer0f+nmrSg9x1MYCakNIfjTQSoRW7l3jSIZ3/RrNhXWTGPTGQ6utascD
	 fTmQXtKzjV4pryCHNRcIfUUO4UPJbogNLBrzrFZg=
Received: from [IPv6:110::b] (unknown [IPv6:2409:874d:200:3037::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 13BD466EFB;
	Thu, 28 Aug 2025 03:12:06 -0400 (EDT)
Message-ID: <601863349f71b54087bc7ffa382955ad6bbf5511.camel@xry111.site>
Subject: Re: [PATCH] Loongarch: entry: fix syscall_get_arguments() VS
 no-bultin-memcpy
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>, Wentao Guan
 <guanwentao@uniontech.com>
Cc: WANG Xuerui <kernel@xen0n.name>, linux-kernel
 <linux-kernel@vger.kernel.org>,  loongarch <loongarch@lists.linux.dev>,
 =?gb2312?Q?=D5=BC=BF=A1?= <zhanjun@uniontech.com>
Date: Thu, 28 Aug 2025 15:11:57 +0800
In-Reply-To: <CAAhV-H68Tzewu3x+8=Psb-8Hqg58o4v-8QyvFew+Wuo=Ne-iAA@mail.gmail.com>
References: <20250826113225.406238-1-guanwentao@uniontech.com>
	 <20d3df642aaff2a771e74452b81463709f7c16d1.camel@xry111.site>
	 <tencent_6579F3317CCF94D00EC3C7DD@qq.com>
	 <CAAhV-H68Tzewu3x+8=Psb-8Hqg58o4v-8QyvFew+Wuo=Ne-iAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-28 at 15:09 +0800, Huacai Chen wrote:
> On Thu, Aug 28, 2025 at 3:06=E2=80=AFPM Wentao Guan <guanwentao@uniontech=
.com>
> wrote:
> >=20
> > Hello Ruoyao,
> >=20
> > Thanks for your review.
> > I will test and send test results later.
> > (use different gcc verions and remove the three flags.)
> I think kernel's memcpy is still needed for CPUs without UAL.

GCC memcpy expansion correctly understands no-UAL case.  It won't
generate unaligned access unless -mno-strict-align.

--=20
Xi Ruoyao <xry111@xry111.site>

