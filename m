Return-Path: <linux-kernel+bounces-889716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A5C3E4DF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA44E3F33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9724886E;
	Fri,  7 Nov 2025 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uPJ2hOP/"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4902AF1B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484866; cv=none; b=JnGpPMHqYZXnhDEl30B2nCBVuTEQPhAnR2wwMQxlcM0Br5wQrL4fN7fL8VPpcEBvDC6HFgPdtePWSjj/WYeMtIsh86GpRfXWUnffxQp9UKBanC9KZynoxt6ksY8PRET6um8TV70OvF3AM1T4IRHcNXQPk2V/AwZNr+5gqEwIYJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484866; c=relaxed/simple;
	bh=AQJfYkgpF8M+7ag03gUO0WbJqUQBHhZrdV7imAlPQs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNkb+TFzW9Lv3C3buTPo6tMHhdf7s8CUBDdjKT/omEP/yp9FeXzIjP5Fx2+uVP/2pkP9kpqx36CSMsOTlSq0TZj8W4UYZ/BEfUuaknIIGZs/BZ7Uyrbq8WWtEJf1BzrcGLECUqJ2NwX1i3SJnPGTciwNUlS34ExKYemoFEvK2q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uPJ2hOP/; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d2kWW3J1sz9tWy;
	Fri,  7 Nov 2025 04:07:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762484855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jx2bBAIXMGIZv7u/FcJ32DGgtD9uv0lkYEYQRNJYCc0=;
	b=uPJ2hOP/+o0SiGaTgGPIiT+z3ILPYbXujp1D/JGrbmRks3K1EDPF9/Prur54HKDJfeOyYN
	ai8+melom3FpWK8MADkv28PIXqt1gpPEy2zP0T9ULSDeGWidyWAAgWNcnys/5KRQybETMt
	pThMr/WQv7Cnp/g8DK6qgIaz9UUSGx7bwP+0kPeO0Bdl+6T1ASimqdF+RvEqqDAKTjKp1s
	tv5Rg7TG5zWtRQNLfs4rlqucoEj0F9pkbL6OC82Ji1P94A7R+WaqCce59ZuPq5VCxM4Xv7
	yOM2V0qzJ0TXTMLIC0M/zSB1WrARYS3bFFl7FnAMDLDkDhsnqS4PRjjbU1lrLQ==
Message-ID: <4ec46455-a872-45ae-963e-cb2a76f5a845@mailbox.org>
Date: Fri, 7 Nov 2025 04:07:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/etnaviv: add HWDB entry for GC8000 Nano Ultra VIP
 r6205
To: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Gert Wollny <gert.wollny@collabora.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250919183042.273687-1-marek.vasut@mailbox.org>
 <CAH9NwWcK_z_4CcDBRYS2nf3AxYV9-XwirvTd+O9uJtHMhyA3Og@mail.gmail.com>
 <CAH9NwWdkjpV5YHmOpuCE=f7RVm1kXzqAOgN6=Sx1s-wxO_SGGA@mail.gmail.com>
 <4ac9dd98-adc8-4be9-9f5c-4e653f656453@mailbox.org>
 <CAH9NwWd+1MSBGdn6G0zRQgmC7cHCmG3BSxeDUQV-waMG75E2KQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAH9NwWd+1MSBGdn6G0zRQgmC7cHCmG3BSxeDUQV-waMG75E2KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1f2d2d18baad58fb76b
X-MBO-RS-META: ptcbbyfqd96su78xegda7fk6isrd8b7f

On 11/5/25 2:44 PM, Christian Gmeiner wrote:

Hello everyone,

>> I _think_ I will try to respin the flop reset patchset next.
> 
> Gert told me on irc that he has reworked the series already and just
> needs to do some testing. Maybe wait another 1-2 weeks
> and/or sync with him directly.

Let me add Gert on CC . I can also do that testing and provide TB if 
that would be helpful, I already tested the previous series and have MP2 
on my desk now.

-- 
Best regards,
Marek Vasut

