Return-Path: <linux-kernel+bounces-681842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F977AD57FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 16:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FD51E1FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C1729ACF9;
	Wed, 11 Jun 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wk0ZcISF"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF227CCF3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650695; cv=none; b=OG3ESB5dZyFbegIrzctJkFJQ70lxmMnHmCtJXqYnxepUn/BwvAWxa0nARch05/EfP1/di76z5kk0mtry48O8PhwTb5L5xYPLZlXo7N41R1e/kX0BgZn4nPLTq+MBya902O29HQ89nGjM5G/3fA90OZqhWU7ew5HNAlRKW9O6QQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650695; c=relaxed/simple;
	bh=rfoDfSY9BodSaLrtYekBqaMvqcOHnjl0fyfcQsXJChA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7kGO+9VjeEhnOKw7ukn+kY7ILBvI7L81B4LgqIezGQyuzKOpLhCZcy5j7F+Nnlpc4LMVYcHb7r1P1G9sLUDmyjqSFVMG48BiEWVtuvwLIH0Sz15ZVB4iE/V1K1udFiSc8rLFizJbEvJlYTz5IZj+ZlW2CGghnbXR8WY45gRto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wk0ZcISF; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Jun 2025 16:04:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749650681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txq23bJazbIYagctbPRu50Tm0ZoM/NcejOe7Q1liC8k=;
	b=wk0ZcISFpG7EdDimklFUqd02SAESZEZcA+KDyXAEHqt10vo2jUvcEe/cO2Yq6tJFVV4dAc
	L0GmmiPNFoYcR8pSaqlrip1ZkN7z2ZbLbzI7BC9ZgVP4yZxnkyM3JZqpIJm+9YnviJndsI
	lMKJEV+PHU+WLAtw4eKKZD49/eTtZCU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	workflows@vger.kernel.org
Subject: Re: [PATCH v3 03/16] init: re-add CONFIG_CC_CAN_LINK_STATIC
Message-ID: <20250611-nostalgic-terrestrial-armadillo-eecfec@l-nschier-aarch64>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
 <20250611-kunit-kselftests-v3-3-55e3d148cbc6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611-kunit-kselftests-v3-3-55e3d148cbc6@linutronix.de>
Organization: AVM GmbH
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 11, 2025 at 09:38:09AM +0200, Thomas Weißschuh wrote:
> For the kunit UAPI functionality this feature is needed.
> 
> This reverts commit d1b99cdf22e0 ("init: remove unused CONFIG_CC_CAN_LINK_STATIC")
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  init/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Nicolas Schier <n.schier@avm.de>

