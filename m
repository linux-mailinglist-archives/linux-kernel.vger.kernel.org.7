Return-Path: <linux-kernel+bounces-767025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA187B24E35
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC961B68283
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F528C5C7;
	Wed, 13 Aug 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IgeYW6tg"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11D228980F;
	Wed, 13 Aug 2025 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099732; cv=none; b=FodB6pT3lXxFcOPZ1/LYRDozIGWovbu5V/ZrOwvGKW6aAPka+zFzx/3MKgnxtkY9G1K1xeVib7dQ0SSLa3lghLcmkgDcsZUijM4wyX8kWli+qunHDAeY2bvAhZxburKX6cGwAvEHBIdVoMndvV1mkgCpDBWKFSAxqnqO2T4B0YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099732; c=relaxed/simple;
	bh=00pUiwnn65HxWg9x0niKvCv7w5TxlROenXF9QjhH4Vc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ofW1bAioGfmMt8j7xEpnldGfvVany2kKtHUB0eNItXREcea2keHHy9+2E1kcR2fzfO8Msr7VKT18TfgXkzQrpzK/0OtdmxJb0rwVhWABJDwFwfZWl/B/f/fBYuHO30bkXzqo1aHB9tHnieRdKsQ/wi5Sd6YS9EbkhkeRx3JvYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IgeYW6tg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=Z5EearwDRc5Jy3iPH+85T9lKN7Y2Bux21v8MJZsF+Q4=; b=IgeYW6tgRiEpKr3gGfvoriqt1d
	+NIr1v7RnZu1UgPTq7uY5yLTOce3xigumV/xSd2x782pp7ZP76P+vGwWIcb8dbYNJF6Vcsp84UD5a
	/GEa1Ha7QtIR1mtuwwe6Ho+/g0A+9FaQd5xnkK2Jj4o28rCUpWZw08WckbR2XKI/jqyOW/NjJOUBI
	EuGferCIrDLGo6PywgU5USV8z+JRIibptZWjjtnVP4Eg4ndY89I3jpc8+gxdA8keH63X6AHZ8qSgA
	zgDOhL63buhJVtSkAgOOi8hjBg7U5lSMWJoH6Qvug7hBuWrSsnjSjyz1W9C32BEQ0pDnQawYziONX
	Wm2xoq2Q==;
Received: from [50.53.25.54] (helo=[127.0.0.1])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDc7-0000000A1Ci-3IH2;
	Wed, 13 Aug 2025 15:42:08 +0000
Date: Wed, 13 Aug 2025 08:42:05 -0700
From: Randy Dunlap <rdunlap@infradead.org>
To: vivekyadav1207731111@gmail.com, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
CC: Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: Re: [PATCH] kernel-parameters: fix kernel-doc warning
User-Agent: K-9 Mail for Android
In-Reply-To: <20250813131801.2701-1-vivekyadav1207731111@gmail.com>
References: <20250813131801.2701-1-vivekyadav1207731111@gmail.com>
Message-ID: <B15E4343-E543-4C59-85E4-CF06FE78A627@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 13, 2025 6:18:01 AM PDT, vivekyadav1207731111@gmail=2Ecom wrote:
>From: Vivek Yadav <vivekyadav1207731111@gmail=2Ecom>
>
>Fix kernel-doc warning in kernel-parameters=2Etxt
>
>WARNING: Possible repeated word: 'is'
>

Hi,
I'm still a little confused=2E
What tool generated the warning?
How did you cause (or execute) it?

And this should have been [PATCH v2]=2E

Thanks=2E=20

>Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail=2Ecom>
>---
> Documentation/admin-guide/kernel-parameters=2Etxt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/Documentation/admin-guide/kernel-parameters=2Etxt b/Document=
ation/admin-guide/kernel-parameters=2Etxt
>index 747a55abf=2E=2E302145870 100644
>--- a/Documentation/admin-guide/kernel-parameters=2Etxt
>+++ b/Documentation/admin-guide/kernel-parameters=2Etxt
>@@ -7506,7 +7506,7 @@
> 			Set a trigger on top of a specific event, with an optional
> 			filter=2E
>=20
>-			The format is is "trace_trigger=3D<event>=2E<trigger>[ if <filter>],=
=2E=2E=2E"
>+			The format is "trace_trigger=3D<event>=2E<trigger>[ if <filter>],=2E=
=2E=2E"
> 			Where more than one trigger may be specified that are comma deliminat=
ed=2E
>=20
> 			For example:


~Randy

