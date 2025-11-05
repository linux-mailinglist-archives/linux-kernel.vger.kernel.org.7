Return-Path: <linux-kernel+bounces-885807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 978F0C33F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 05:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62DEC4E2D58
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 04:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC732561D9;
	Wed,  5 Nov 2025 04:53:49 +0000 (UTC)
Received: from smtps.ntu.edu.tw (smtps.ntu.edu.tw [140.112.2.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACD225408
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 04:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.2.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762318429; cv=none; b=bru/IESnA4JsYLxhCcuy+y1nHl+lQA+oLtyq72m4lR3v8a/QRouy5t1yL7HygDXD6BEsnFhdGFDracT2wl0QaeVEcRTvB5i7/9ZXgdRBvfzpDqiMt4yhQyzBFUGiKveX8kIGCllGweQ8dt/x8mOFd06ZqOa5IqlBBKJv9cvYNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762318429; c=relaxed/simple;
	bh=KL7ZKaYNv/bzLovyJbNjasz/Zqv0zzGXIAt912Kig/g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ra9fVXEZLY8kPFN0Pb+m9cKmxLhWcdnzq2J5uIuKxPEz6LVaFrfmQ8AavbTTlUhON+GocqoVuGuwWHasITauPxI4pBkMIkppggQRfu+ThRc93ZO6oxD5t7YW6YkpCvBBLIavGTToZekuy2/OGybB331yL1AFftXi8x/QAR2fiSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw; spf=pass smtp.mailfrom=ntu.edu.tw; arc=none smtp.client-ip=140.112.2.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.tw
Received: from wmail1.cc.ntu.edu.tw (wmail1.cc.ntu.edu.tw [140.112.2.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtps.ntu.edu.tw (Postfix) with ESMTPSA id 088813201F;
	Wed,  5 Nov 2025 12:53:36 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 05 Nov 2025 12:53:36 +0800
From: Bill Tsui <b10902118@ntu.edu.tw>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, oleg@redhat.com, kernel@xen0n.name,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: ptrace: Merge ptrace_hbp_set_*()
In-Reply-To: <429e94ee-ee77-3a5c-a2f7-c0d027fb7c4c@loongson.cn>
References: <20251029153649.33345-1-b10902118@ntu.edu.tw>
 <CAAhV-H5E79jZ9rMYyP3h+KLX5rDGcB-Ec8WqyAhPC-pvuvv5UQ@mail.gmail.com>
 <429e94ee-ee77-3a5c-a2f7-c0d027fb7c4c@loongson.cn>
User-Agent: Roundcube Webmail/1.4
Message-ID: <34516b92c4e5be92e3f740f167f65431@ntu.edu.tw>
X-Sender: b10902118@ntu.edu.tw
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Tiezhu,

> If there is no functional change, just to refactor the code or
> avoid the potential issues, please give a explicit description.
> We will test GDB to see whether there is a regression.

Yeah, just a refactor without functional change. I should have been
more explicit about the intent and that LoongArch doesn't share the
bug.

Let me resent the patch with clearer commit message.

Thanks,
Bill

