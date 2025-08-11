Return-Path: <linux-kernel+bounces-763615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9199FB21780
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90B67A43DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF7B2E3386;
	Mon, 11 Aug 2025 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v/OKbfwY"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48664311C0E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754948242; cv=none; b=mPPtd9IIrI3MrXhu3Gx2WUctpaCDzrSkL8MhYJfuDnQEG0mtCyA3PDEEoit1oy8ACgXzd62ueFNSTVvQhnsYY5h0+LoU85j+vpvkGnf9J80Hnj/hHpw5i+RJGymXaRpcdYjE347/yIwe42zp+QQD+zNpkyDhbuxez0ymW702t7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754948242; c=relaxed/simple;
	bh=qWIsTeGtfPbRasrX/LrieZfHdO0fcKIavaM4IK2K0+w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cNngbCo2MVlULy1Q0VKI1iua9rH9OFNAN95iREIbzH5mKmqR2wiIcWoW7JcrvVLfly2gqyvKWJYQbNTR2fyuY/AxybxVfYa1JD0d0yvWiSSURmgo847F5mPFIzB9jjRQdsZ32tJL1IEyeTIvDlaxsVpRW0sBojuPvMH7sDXsNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v/OKbfwY; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754948238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWIsTeGtfPbRasrX/LrieZfHdO0fcKIavaM4IK2K0+w=;
	b=v/OKbfwYchKtDxUTbSjUkOUPMdG9ZJ2fvL+Xmj0O4uyf1fmB8UYZ0Ox3SR1707b+qhGtLp
	EWrW6Z6u8MXpTV5+dR9zK8rZ9BdKtZI+NzxtTx+jI4/JKo+I8s947PwHmDQhl6U38PRHJ7
	6HBVG9383DfxMp/Sq4B+tRIbZ7WjhuA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy() in
 vkdb_printf()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CAD=FV=XzSD+pz9RNZDS0paDUWKJ-AW91U5DuEQziszYchuZGAQ@mail.gmail.com>
Date: Mon, 11 Aug 2025 23:37:04 +0200
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Justin Stitt <justinstitt@google.com>,
 linux-hardening@vger.kernel.org,
 Daniel Thompson <daniel@riscstar.com>,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3C68B943-D11D-40AD-9B3D-C35CA38D44AB@linux.dev>
References: <20250811170351.68985-1-thorsten.blum@linux.dev>
 <CAD=FV=UrEv+=KmjZTDt7F5ftuw5xrpOyEim0OrGAkoiJ5Wi2cg@mail.gmail.com>
 <17A3048D-E2E3-41FD-A6A0-853B2E481B12@linux.dev>
 <CAD=FV=XzSD+pz9RNZDS0paDUWKJ-AW91U5DuEQziszYchuZGAQ@mail.gmail.com>
To: Doug Anderson <dianders@chromium.org>
X-Migadu-Flow: FLOW_OUT

On 11. Aug 2025, at 20:13, Doug Anderson wrote:
> Do you want to send a v2 that switches it to memmove()?

Yes, I might just need a day or two.

Thanks,
Thorsten


