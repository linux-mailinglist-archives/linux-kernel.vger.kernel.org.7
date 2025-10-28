Return-Path: <linux-kernel+bounces-874787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 991B3C17163
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CE814F770E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3812DEA8E;
	Tue, 28 Oct 2025 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EGgGiaot"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135A2D0634;
	Tue, 28 Oct 2025 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687802; cv=none; b=Y3OVSuvswPL1H0unn4E26AAZ1lUI8zFc4ckeTQulavPsW9LTqVG5MZpzWQtC84TMg+Eojx6BXkfG4amccUMn5BPdlLWCcMGTv695dYGqaoMXmXDXcL1VsyXhHRONe7LPyYBaQl7H7ORFtYInXwWzvU5x9gwnDeucDobAqOFtYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687802; c=relaxed/simple;
	bh=YDqBF/mS2A6UNJxBf/EBwvhrXjgAQntEl4RW5vB6K1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EJHD7qZgoJre+f5smuXQ9A4s0+OjcX6rCeUb5xYjg9ZJ7zM5Tyez78dEpI47DeSxo73SRIB3v4zKoF6Ja10FUDHjsBuoM/U3b1GaXOBo3Gm7gsB8wBf912QqYa8FAjsNLdCtlfXUrQlMY6wv69z/6WbERNH8qgNQ6TDPb0to8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EGgGiaot; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 310E7406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761687799; bh=XaidPgkgSkogQnahzBHg15Gqlc7NpYvwYT9NzMXzVUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EGgGiaottSsXiH3mNpCix02G6V8zqMxsG4ljJVmWImCOOXLoWrYMWBeZct/AhdffO
	 RzcZ9wXYCM+V7WpQaeQ41LIdjez7lZ6KFJRCZ2+T9hn1QMdiFjUAwQrldYuix+JZgJ
	 BmRk7gDNsOSo1v4ApUUQgi/pwJg5isIh248pZxeA6ldrM9B68owDaT1tc98kJNHuV6
	 DaKV9RDyTG8LBPM8Q/40NpHkNhyj6Y0i72QWPgYQ5mhiU838MSgzWgOFwFXMXsjbsR
	 4NhP+P+uSlcL8qM5wKIZuf72ybS5EgZ0dQHrI3tV9aQ8VFsPMmjACrwC0TxoWYbNz8
	 CjzZpS2yBB/kA==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 310E7406FB;
	Tue, 28 Oct 2025 21:43:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/30] docs: reporting-issues: tell users to check
 the kernel log
In-Reply-To: <a5be8e9822bbc1268efc3cad9485d8d926261a90.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
 <a5be8e9822bbc1268efc3cad9485d8d926261a90.1761481839.git.linux@leemhuis.info>
Date: Tue, 28 Oct 2025 15:43:18 -0600
Message-ID: <87ecqmk8i1.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Sometimes what looks like a kernel bug is actually some local problem
> the kernel's log messages explain, thus it is best if users check it
> early in the process.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  .../admin-guide/reporting-issues.rst          | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)

Seems fine.

Thanks,

jon

