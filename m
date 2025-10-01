Return-Path: <linux-kernel+bounces-839602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF3EBB1FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D88A17250A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFA92DA757;
	Wed,  1 Oct 2025 22:26:41 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED72D23A9;
	Wed,  1 Oct 2025 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357601; cv=none; b=m1KD1n8OI1IazG1qHQ7KMet3qqKofN2pG5JQn10Y/NplbjHEbhmzzqH9+U/lasfJXjAN0BOxDobWngeMRvBXa/GCGzhGB8orYxT8QSMrTCyyR+FgIxBNP218B5FbCX/IC1O0ALO/6n9C03ysKWrGaRL0lEwkwm+mFxoFwxgQNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357601; c=relaxed/simple;
	bh=kdmD9S//kDqyuwjY16zU0Y+/APZ+wqmlD4cuoNUeaQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RINQzwZhuRWmfy6W+TVpA/QO3VspLM5HY+yH3u1Z9pwM7u+pto0mx3qVJ3qZK0I2unKihRQfin63ltNDaj4+AdCHp6ocnAO3IyZxAuZJDz3o9MlVyR0OXqlrHCEQf6yexj/NHI+rI9KUvqu9L6OGUt7WFDD6r7fpT4iqQoHXZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2D0F7340BBE;
	Wed, 01 Oct 2025 22:26:38 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Matt Turner
 <mattst88@gmail.com>,  Stian Halseth <stian@itx.no>,
  linux-alpha@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] alpha: don't reference obsolete termio struct
 for TC* constants
In-Reply-To: <CA+=Fv5R=Gtt2BQqRRQz2tntW4nqTB3d-wb9R-0GjHnm-uXgA6w@mail.gmail.com>
Organization: Gentoo
References: <fc2e8775d55f43e08eb79d326d6fdd89291898dd.1759347737.git.sam@gentoo.org>
	<b6a724419773598d75ace5629bf4b05726d45218.1759347737.git.sam@gentoo.org>
	<CA+=Fv5R=Gtt2BQqRRQz2tntW4nqTB3d-wb9R-0GjHnm-uXgA6w@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Wed, 01 Oct 2025 23:26:35 +0100
Message-ID: <87ms6axnqc.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Magnus Lindholm <linmag7@gmail.com> writes:

>> +#define TCGETA          0x5405
>> +#define TCSETA          0x5406
>> +#define TCSETAW         0x5407
>> +#define TCSETAF         0x5408
>
> Hi,
>
> A similar patch aimed for powerpc (commit ab10727) had the following
> definitions:
>
> #define TCGETA    0x40147417
> #define TCSETA    0x80147418
> #define TCSETAW 0x80147419
> #define TCSETAF  0x8014741c
>
> On Alpha, if I do something like printf("TCGETA = 0x%08x\n", TCGETA);
> I get TCGETA = 0x40127417, but on an intel/x64 I get 0x5405.
> Is this something we need to consider here?

There are fallback definitions in generic:

tools/include/uapi/asm-generic/ioctls.h:24:#define TCGETA               0x5405
include/uapi/asm-generic/ioctls.h:24:#define TCGETA             0x5405

I think those are used where there was no historical value (i.e. for
newer ioctls). Coud you run something like
https://bugs.gentoo.org/962600#c5 to get the full list of (removed)
constant values for alpha? It's awkward for me to test with older glibc.

>
> Regards
>
> Magnus

thanks,
sam

