Return-Path: <linux-kernel+bounces-773982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBF7B2AD33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B941B685B11
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0D1261595;
	Mon, 18 Aug 2025 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="j9R64CuP"
Received: from mail-244104.protonmail.ch (mail-244104.protonmail.ch [109.224.244.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477F258CE1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531789; cv=none; b=EqVEelXfn2agtw0CYGJNNz5Fbf7mL5+aNjP7paUFPwI88L5+pKut9fmE0X3fJ/XeyzIY9+m+hWjNj1EzT89ssiB+t1tw8lrABykJYyyMq2v6bbynVuLcL3wNFd8Oh5hyhxNKIn4kzDXau08cMiDUzTLqWpczXN3uxiyWeEatH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531789; c=relaxed/simple;
	bh=mQ1gk1JZWV6GLcg3lVdYTkOrYqwl3jyZHswCmkDgmf8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ipI0t2yhZlGqrGo4bAMAWcRszcCu+ky31AuxIfCZB8l/jLm/6TrTZWe7dj7byzfcL5qJnkyNOfjxcijmAM9k4rqAqHLeBIifCFqw8x8c1gjVb9COF+mM9m6Wx96+DfjjVL8zDu533Nv2TCxY8gzQUj4yX+91DafK9I6UdigNYpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=j9R64CuP; arc=none smtp.client-ip=109.224.244.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1755531253; x=1755790453;
	bh=mQ1gk1JZWV6GLcg3lVdYTkOrYqwl3jyZHswCmkDgmf8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=j9R64CuPl1+esJKxxkdwintKKjPxAFCIXNqzwfFS7VZQiXUDm7n902G7RkxOIxp+P
	 hyc/s71j8rqvHkO8Ik0luxz6FFrqvZZ4nI5wFTFFYdNRyRzy6YojEOxVitA1ANBUv7
	 LXYeVCdMiwS6Ak5xDbdPA1Kg+UtpaHny24VWa+Lv3hoQ4+GcRUrQtjZJr4D071rzco
	 8CbO7ohbABD8yCH7dn20E4XFp9yVJSiv46eCWLeuddA3MjxCk5aZDEXJQvB4jxa76r
	 ivXfylcX0Mt4RbWkgCEzDiVLN1ot0alsbCFfpzqwYGK7wt46sV+iKHmuZazxP1mBn5
	 y2ar4yTx5i+7w==
Date: Mon, 18 Aug 2025 15:34:09 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Linux 6.17-rc2 Released With Performance Fixes & More
Message-ID: <0RVaBu15UsbcEigNEJfEB1Wo9Fd5jbwvToVgdNw0rfQkjOLaLEZDVIbnNX8z7fd87MQ57j3K6AGhXgClvcKDImoChyrGitMB260-VAlSxR4=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: ceb299e1d8122af46f4a0440476573074d6de206
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Linux 6.17-rc2 Released With Performance Fixes & More

Good day from Singapore,

Here=E2=80=99s a news article I=E2=80=99d like to share.

Article: Linux 6.17-rc2 Released With Performance Fixes & More
Link: https://www.phoronix.com/news/Linux-6.17-rc2-Released
Date of article: 17 Aug 2025

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals in Singapore
GIMP =3D Government-Induced Medical Problems
18 August 2025 Monday






