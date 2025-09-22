Return-Path: <linux-kernel+bounces-827871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 204DEB93519
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A8E84E2682
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91808221F15;
	Mon, 22 Sep 2025 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRjSels8"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B8619994F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575061; cv=none; b=vF53lhdtwbPM9diqrXkVUOrngqGywfH4qTQeHIYbFTueT7acWFfiahwskk9P7Vf6AGy9wpuETC1dOFCfuzyEVl80cG/A97dSo2D5Outrjz27VCIf7vEE4K8PwBXoZBzDQ45OY5Vav9xgo5xkdoR8ANyzkWihMk9yYxf4IBqPkaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575061; c=relaxed/simple;
	bh=IR27taLTFITOYV4B00ku0qQKC4bEZ+4qpChrvPMvsvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DE9wa3bXQ84mwE+dERTFfAM/aLcHkP+7r4MyhV1qbPeqsQvLm84l7ZmNFNtCDYJTVpuhZCKvvLVOz3qbid2tFigrSm/15oZmJDQbjVax/erS1hKxtbYhqPAT9kbbKUBHkzHP1sTBenAGci6hv/RyWX/jbdkDuXbz/n1gkJdodrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRjSels8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62fd0d29e2bso5073884a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758575058; x=1759179858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uh7Hyul+h5lwAcNtxj/DI9qojjFccIciQ/b88SlaL0g=;
        b=BRjSels8DOVs7qW6xbfiJMfD/GfyjPcjHOVYe2Rgt+KQAzD3xMEVJXn/vZai3COf86
         269dksgcmZHtamVFgfH8sYfTPVXXWSuMj9MoViEJ5+4HLu8qwGyL8EUOtmG2hqR5p35V
         yI+hLu0BNSLw4AGDXrR09NtFb5VtSS8BBpbe5PJujhaqK2PoEpJVh1aX00FoUE8A2jMh
         S65Fu9Jqc6iQF0ibDHrITbxfN0HoM2BjS0IqXUlVyhwKuWSvIFhUUw5rAt3xLQDHs/5D
         F1s6d0NCxxk9yD17M7mGb0zy+bcuTCjw3cgLGT8FGCPFRs0GsBG4kg471XqJ3SJQ2cCK
         lVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758575058; x=1759179858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uh7Hyul+h5lwAcNtxj/DI9qojjFccIciQ/b88SlaL0g=;
        b=iyMbPLmZUvOGacefiyXSCEnK/8OKcMq7jxQ6ILYWzP8JquCL4EB9SDs0vtOC6+e91d
         fPRP0N0lihNqByWTfyN4gi8F7XcbW5tMWgy3l8cMyJgv6HkOU4H9f539MNsBK1ZEp+Xu
         fEDh9PkvaHdh/itTSjNs/xrAxEPMvMYmDLGm3H4usFfnCsxY2NVJMPOx129fNYoDGmSa
         YYDOYPSplx9Wu8/QzjYt8BmzsC7Sjm9J4SFBC5pBniJFxVTap+gcWyEM79h4jlRCj2ch
         k/AA/estZI5tn8t6siAU75cmtuh43Il35yUWu+Lz7WpVz4m/UFljaNEK47bJQeUGanvr
         mXvg==
X-Forwarded-Encrypted: i=1; AJvYcCU1CVz1hUK6rrMxVI51LVW8hjGaQFn5b1JB9VFRw96465a53sLrBIhyjKuaPNgkHqtkhc9AtRCJEyGehgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5dS8746ws6/a0dj4fNFGdZTMhYsG2lJpAxOzVLqjSz3wzP2G
	jq7IXBJsXcKFaJBkCds8Dm3XEYG7Q4EVzOIk+O0B/uRYJ2AUDgR0279JGb6Ptd+XAOijFZF1hPg
	OqULjnRRuSWjOVR4n5YglQi/fxwayBUw=
X-Gm-Gg: ASbGncs1rbjq6dGq33jaRzZxlhQgI7CzjzNAUJnrmp2NP8a0F1DSzxnqAtsE2XSgwGu
	PL0Eivr6dUfyN/bZRwAnQS8Qh5uGm24kmdrM1a3ErG9bIBTWimh2Rpd36yPBOX31bf1eU85sTce
	iZWDnmBZaXhDX0L4qGI72lVJA/+r0kqIOVOtN3z0gKFL7YWx5hKmvFiaJNIGYwkuWOwtBb49OtG
	9Tv0X0YV2dGjCcPGDs=
X-Google-Smtp-Source: AGHT+IFr06URzpJ6aUp4DpRFc3gqIF/QKzvPatkXOguRNAK+5vyBht27Wi77YYUi7cw/QJFO8eHWzN6Nc8/pR3lh7aU=
X-Received: by 2002:a17:907:72cb:b0:afe:d590:b6af with SMTP id
 a640c23a62f3a-b3026c84e0cmr5356866b.20.1758575058272; Mon, 22 Sep 2025
 14:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
In-Reply-To: <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 22 Sep 2025 23:04:06 +0200
X-Gm-Features: AS18NWDVFMZZnWEreuo7vPXyYUB8RQkWA0R_TESbZnVi7LcEMvax5dEHcVzVJVI
Message-ID: <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geoff Levand <geoff@infradead.org>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	iommu@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jason Wang <jasowang@redhat.com>, 
	Juergen Gross <jgross@suse.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	sparclinux@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	virtualization@lists.linux.dev, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 8:45=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Alpha doesn't need struct *page and can perform mapping based on
> physical addresses. So convert it to implement new .map_phys callback.


Hi,

SInce this patch affects the Alpha platform I got curious and decided to
try it out. The patch series requires some preparatory patches. Leon
provided me with links to his dmabuf-vfio branch, which had the
patches (and some prerequisite stuff) applied already.

Based on the dmabuf-vfio branch,  I've built a kernel and tested it on
my ES40 Alphaserver, the kernel booted fine but after a while of
moderate filesystem load I started seeing some ext3/4 related error
messages in the system logs. Rebooting with my old kernel into
single user mode, I was able to recover the filesystem using fsck.
Clearly this set of patches breaks things (at least on Alpha).

I haven't yet dug any deeper into the root causes of the file system
corruptions and I've only tested this on Alpha, maybe there has been
more testing done on other platforms targeted by this set
of patches?

Regards

Magnus Lindholm

