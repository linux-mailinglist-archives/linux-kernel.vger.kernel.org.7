Return-Path: <linux-kernel+bounces-863665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA21BF8C08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816A219A7D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A568528E;
	Tue, 21 Oct 2025 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="k0c4FtHb"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4170C27B4F7;
	Tue, 21 Oct 2025 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079376; cv=none; b=TypYtxh2Tj5xuxabOAaso6Innv//lDiVr6lP+sFR1uVKOLnjEGu5I2iZwAWdCmbPBhb0uAHkY2jyh694l9Q+wGUa7eD9D1aO/PZ4rMfFnZjUQUq6Fh1qDkeu2P885T7MzfjCcGtIqivwF35Ag3i6T7QZjt6ze1uBVGGgT9c6v/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079376; c=relaxed/simple;
	bh=DWvaHmyhKJXb9JSMX4e2ZfHXF6vP/qJBWO8gl/HIyIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gGYgXlmZgN7NxB0gW5WU+2AXh8xczqpNU1xOePH2artERNbx4GZFPVkKNk6ikzq+JvbfvM0m3dB8rly3et0LAtKs+Oa4PSLX/5cIwI9rDWtEf9D68/xJmnwjvnUEylXcPrBGTirhIVPHANuI2e1OOo9icfiH3aBedQ1bYMNpmhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=k0c4FtHb; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 555AA40B28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761079374; bh=coYt7rpSENqvpyIscPukz78OuO3T7USEqh8+Qeq5GLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=k0c4FtHbueMN51dXgX10rYfCxk9FkJDOCjl/S9ATAnBK4Z+DEJ7bXfldOOlMPYeg7
	 vUDGLVqtc61TC+KyQBqp2lMMv4tMjgSmhVAf2jGpg8kQ+fght8xb4XP7vuhHg2ctWH
	 6aukMuP48J1/IAeOEM69/8LdBUeVahVf3bnhYXeQZXmtl+GGxTe3nCi/dvlwhYgJoQ
	 gxgekaP7Ux6nCM/bY7wMnfBSFYk2t7TOfD1lTXXP8bo/td7sYal5T6IOut+d0nSuy5
	 giorUw1gseouX4/yPRm9bcabxwsN1lZDz22U7IAnROwYRUvzhSGr4YoYpVCyA88gRY
	 WUKTlZuym0zTw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 555AA40B28;
	Tue, 21 Oct 2025 20:42:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Brian Norris <briannorris@chromium.org>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches
 <joe@perches.com>, Randy Dunlap <rdunlap@infradead.org>,
 workflows@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 1/2] docs: checkpatch: Align block comment style
In-Reply-To: <20251017203719.1554224-1-briannorris@chromium.org>
References: <20251017203719.1554224-1-briannorris@chromium.org>
Date: Tue, 21 Oct 2025 14:42:53 -0600
Message-ID: <87bjm0t29e.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brian Norris <briannorris@chromium.org> writes:

> Ironically, the block style comments in the checkpatch documentation are
> not aligned properly. Correct that.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>
> Changes in v2:
>  * Add Randy's Reviewed/Tested-by
>
>  Documentation/dev-tools/checkpatch.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Both applied, thanks.

jon

