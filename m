Return-Path: <linux-kernel+bounces-761536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A46CAB1FB83
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 19:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B7A177C33
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD88F271A7B;
	Sun, 10 Aug 2025 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ryc/S090"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6484CAD51;
	Sun, 10 Aug 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754848722; cv=none; b=C994TQOAoNiBdsjAgX0gDBZBiuioXeaSgsXPrIi0NCwoshuMKi2YRzmCrYU51Uec9ChaMFMrscDI+zSYyQewIkQ74htawoIbJsHn5OMA88Q7L9up7BdY79kScUWATf2ZBTwNHui9HkyjBeoYwYZcX3uQozD1JBNhq/ZujiekO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754848722; c=relaxed/simple;
	bh=3DY4sdD6Ak+INsGBF03kY73HAAA8wXnirguJXoLXA0k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BJkrH6O0N4g40xWcNeJ3op6F5PwEhVXtZWU87N1M50DSr5sNreVYF1Pn6hTuCjDBHCJty108OW80Kn/EYiH4oQdcejUWZ3/DjPC3v+vcUBRcyvZGc+LnkDXM7DHSMZ8Oc2e4RW+vS7u1qnUDZmZoCQDNrlvkE32COnDphr/nSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ryc/S090; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=7ytPBLXxydKCW1rvbBIqeVfDBeJGUvXYVWgQ5qPn73o=; b=ryc/S090TD4aAR+Y9CodqeNpBu
	LZ1y5H+kzmlFZdM60EFQeH+97ZaBFuRtt5khUBV/BHpWOosdVmq+spJRD5gqVU4PQUdMsYQD5OlrW
	b87yc7mM1GOjqttFxDB8rJABM/rHrFI2GM1rxsqrCm7dMjJHbuaethW6vAs8aV0lu5DdVkfCikJkA
	orMvEh+P33DPIXAVXZ1F8S0VR3RfJGKXuUZkOx1uexiME91cgp8OicTsrBzHXWaxwGoUlOaH1cW5N
	gkeIt5YvCVFihj1IvNzCWfgo23JuLeuAvd1n1eEs6lXQOA/jKqfOQkHU+jjwbLmH/EFLBiztawwbO
	bK9bbVOg==;
Received: from [50.53.25.54] (helo=[127.0.0.1])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulAJT-0000000DER1-0v6h;
	Sun, 10 Aug 2025 17:58:32 +0000
Date: Sun, 10 Aug 2025 10:58:28 -0700
From: Randy Dunlap <rdunlap@infradead.org>
To: vivekyadav1207731111@gmail.com, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
CC: Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: Re: [PATCH] kernel-parameters: fix kernel-doc warning
User-Agent: K-9 Mail for Android
In-Reply-To: <20250810172425.21990-1-vivekyadav1207731111@gmail.com>
References: <20250810172425.21990-1-vivekyadav1207731111@gmail.com>
Message-ID: <E7C759A2-E5B2-435F-AF94-E5FF8D9DB281@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 10, 2025 10:24:25 AM PDT, vivekyadav1207731111@gmail=2Ecom wrote:
>From: Vivek Yadav <vivekyadav1207731111@gmail=2Ecom>
>
>Fix kernel-doc warning in kernel-parameters=2Etxt

Please put the warning message here=2E=20

>
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

