Return-Path: <linux-kernel+bounces-815918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257E4B56CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FAA3BB057
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 23:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295B220E6F3;
	Sun, 14 Sep 2025 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RwI7gf0f"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283910A1E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757891912; cv=none; b=kNQc1smye4gSg3aXOQ4aEfWsryvRmymzyj2ueLRP+/Gwkqplpea+De4KTjBJRzuDqx5I0xA7SEatWK1iwLkTS+5wHL804MWeVdQM89ngEiWVn6enYvBLV8WIPj2dr1AqpKlynhrenHuL30KmY0VxIe5tyUDmZ25uag/U/i5sbWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757891912; c=relaxed/simple;
	bh=Ghe+ZTzrLc83+6xGM+du+rMtQ2wLW8ri3LY6XLqTaKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDk1vLOcMfCrZD4VXbwffuJgNRHoBaAZ/8FrXg4NS4gpXa07n3zLtEwstThdx/162DLXb+II/3xiki2KVNLDQ6Ugxqtg/fVYCRLFM06x6Ry/B/KaDAj12QUt+rvlcQSo5DJGkVPQRGwRXNKwDTawYOTXLfxw1Iaq6t+R6rTqKcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RwI7gf0f; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9BE791A0DFE
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:18:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 653056063F;
	Sun, 14 Sep 2025 23:18:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 627AD102F2A7F;
	Mon, 15 Sep 2025 01:18:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757891905; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5F+Y5lsj2A4Q4W4/06tcxUBfMPFqb0LZREUynVIORa8=;
	b=RwI7gf0f8Yo01366R0vgOnbcnRt3sFACYDElP65fQCY6yRFjMVFh21QOsEWo9W0GRE2sMr
	jtTP1ygS6eDB4QySjm+cYfs9Iz2U5i7UjCOSXhWaTWkORXALKtNOWSBwGR43fPOTXxAWKH
	yL2D2l798C+RSazWUjl9OjP4XmPW+pm6NBZH6dPQZY9PhBDE3qLX12RQZrcjNJQDOKxO/t
	8nyRKNA3+rb1es7fAK3RRVozOKZqjIFY7c5xYoIsq3veiAfATBFNyJWAtIBqTA5DmFgzuS
	qUqw14p4oNTYIzpUrkDbH1x60aA5tqLUXro6MgfabHFOFomfannmH1Qm5WKw9A==
Date: Mon, 15 Sep 2025 01:18:15 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/3] Add alarm operation to the rtc-optee driver
Message-ID: <175789183744.411954.8980801689836032350.b4-ty@bootlin.com>
References: <20250715-upstream-optee-rtc-v1-0-e0fdf8aae545@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715-upstream-optee-rtc-v1-0-e0fdf8aae545@foss.st.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 15 Jul 2025 16:07:12 +0200, Clément Le Goffic wrote:
> The optee-rtc driver is used to query the rtc handled by OP-TEE OS
> through PTA (Pseudo Trusted Application) call.
> This serie fixes memory concerns and add alarm operations for the
> rtc-optee driver as the RTC PTA now support them [1].
> 
> For the alarm notification, the OP-TEE OS secure world will be
> able to inform the kernel when a secured alarm will occured
> through a notification sent to a kernel thread waiting in OP-TEE OS.
> 
> [...]

Applied, thanks!

[1/3] rtc: rtc-optee: fix memory leak on driver removal
      https://git.kernel.org/abelloni/c/3e044fa26038
[2/3] rtc: optee: remove unnecessary memory operations
      https://git.kernel.org/abelloni/c/9b9f352d5b02
[3/3] rtc: optee: add alarm related rtc ops to optee rtc driver
      https://git.kernel.org/abelloni/c/96e8fe5b8a88

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

