Return-Path: <linux-kernel+bounces-789346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5385B3941C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F201C226F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47C727F195;
	Thu, 28 Aug 2025 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="C7YMqF9D"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8798125782D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363593; cv=none; b=twAcfmoZkMACp8DOeomhqmLwYLVozdTD3eWZmashHrnLjI9sRkzLqQrwRuTtGWge/wdSlwKfx6IFJL2KRTHo/uhpbnD9HY+of69Hce4PRX4ZrhbFvtOfPcDHEDCdkYiTeYlhG8xXWdkyfxgljbdWcvUS4KI93YlJVwpAfBDwmPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363593; c=relaxed/simple;
	bh=h4IEnhIGqLhKBC+Mi1ckgiPvNjyKGQmoznre6YVVR2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kzeCeMJdzvQXtHX49Y6kBxzLsGUPzEfCvXKNbbnlHVldIxGCY5jcP0GgpHL+aA6O1w0S7XMBxqwO2UKN7kkay21qt0evTAGlCBbZBSlfZZOrfzCBUWwHkwosbHj3Mq7J3rVhRLLn6daLrCp3GFPEM4TXyfM7h8pkGaHogKqAGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=C7YMqF9D; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1756363585;
	bh=h4IEnhIGqLhKBC+Mi1ckgiPvNjyKGQmoznre6YVVR2E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=C7YMqF9DkMoSf7EeME5X5jlNEp3gZrjyGVJWT/JcCH9ZMWeZ9tun7ymGS12gZrSQT
	 d9lY4jg1lmwmqc2kaMKyWXwVEEUK2mk6FW8b+CypQ6TeCmOV6gNeNtVVz3iWOmWTNw
	 5RuZbPWeVZyBbcR0rPjhtqfLhUBnHov11V2SjWX0=
Received: from [IPv6:110::b] (unknown [IPv6:2409:874d:200:3037::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 48A7666AB8;
	Thu, 28 Aug 2025 02:46:23 -0400 (EDT)
Message-ID: <20d3df642aaff2a771e74452b81463709f7c16d1.camel@xry111.site>
Subject: Re: [PATCH] Loongarch: entry: fix syscall_get_arguments() VS
 no-bultin-memcpy
From: Xi Ruoyao <xry111@xry111.site>
To: Wentao Guan <guanwentao@uniontech.com>, chenhuacai@kernel.org
Cc: kernel@xen0n.name, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, 	zhanjun@uniontech.com
Date: Thu, 28 Aug 2025 14:46:10 +0800
In-Reply-To: <20250826113225.406238-1-guanwentao@uniontech.com>
References: <20250826113225.406238-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-26 at 19:32 +0800, Wentao Guan wrote:
> Loongarch use -fno-builtin-memcpy in Makefile,

I still think we should just remove -fno-builtin-memcpy if GCC >=3D 14.=20
There's some wide-spread misunderstanding like "-fno-builtin-memcpy can
stop the compiler from using memcpy for copying small structs" but the
fact is very much contrary to it.

The compiler just uses memcpy for copying the structs of which the size
is larger than a threshold, no matter -fbuiltin-memcpy or not, but with
-fbuiltin-memcpy the compiler can expand some of them into ld/st
sequences, reducing the actual numbers of memcpy calls.

The reason we didn't use -fbuiltin-memcpy is GCC < 14 expands memcpy for
various sizes in a very stupid way, see https://gcc.gnu.org/PR109465.

--=20
Xi Ruoyao <xry111@xry111.site>

