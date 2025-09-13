Return-Path: <linux-kernel+bounces-815253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEDFB561BB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 17:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8E13AA6F4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADD92EFDA8;
	Sat, 13 Sep 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ftNKsXF3"
Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA79347C7
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776366; cv=none; b=EE3IlNbYQ9RjryfZnGEZtF5WpCljWONWoa62vfyUA+K+x6VStm6tSNLJsh4/jCjrO7EzWXRdWnjgSzEPghloNOtuk94Esss6Idl94cXTgPHbR/0AyHUboVHIq8KCFfQNo/dSkOhuoGAhdi2illKse8oK9m9+hXL3f9ISngRN7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776366; c=relaxed/simple;
	bh=TMpZn4UHZSkIfc5+3t3RzmDhe8Y9p70Cx1wP03yhvL0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SuXsJHajWwrMgACzIuFxFzaI6w/kuMPJmqHypoFsvERUBnqY4p11oEfFnSguLSI/GY+IZgObsjt5VbTMiKrntWf7KsWM7SUGATiEbbJRm5OWU77HfGvUWB4BNcqWApzB/LO0q+EDtyOjFa53XM97zOKU0h0cnlMatLKa8BudYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ftNKsXF3; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1757776354; x=1758035554;
	bh=TMpZn4UHZSkIfc5+3t3RzmDhe8Y9p70Cx1wP03yhvL0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ftNKsXF3RR1oqzM0ogSsCorSJq1TRDXEUn+vLKBuNCYmwUvICHHqi6Utb1le8hgNj
	 lVCrKIiXD0xPL2Bqcbugcji5Hj8Kes68LtzgWP2n4BrtEvXPdw81v9BoYJkkiZPe/a
	 ZhASH61VlBEzYEpM9lMQEtIfaTDl36/7TTnvAQtNQ3N+6W+lnKG8poQmllfqhAcvXb
	 bCzSfHPrR17Kn7Ktoxrb6XHljfZCsO6d8aSG6Rtc3W1Nh+PLR/bf39XZVGzz2PwIlZ
	 +1nQnDCoLzriLcyft15F8g8UY4p9oyTh9ICmDb2mbwmOYPjPkOk+NZ7nqFH9ZoTZLF
	 J9u6NOxUjeSZw==
Date: Sat, 13 Sep 2025 15:12:30 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "??\"ceo@teo-en-ming-corp.com\"" <ceo@teo-en-ming-corp.com>
Subject: Ubuntu 25.10 Is Now Powered by Linux Kernel 6.17 Ahead of the Beta Release
Message-ID: <n8D_SCMYfZexSgw2YbGBPPax78ZJjxSvmoeR1K-68-nuBBnGVoy87IRFKoBiCkYutOzPW7ET2g0YNL6r0YVFk4pwJpdFs6SAOQw7Cea-AjM=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: fa37b4bd64b68c85bd2b1da0925bc09edb89bf34
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Ubuntu 25.10 Is Now Powered by Linux Kernel 6.17 Ahead of the Beta=
 Release

Good day from Singapore,

Here=E2=80=99s a news article I=E2=80=99d like to share.

Article: Ubuntu 25.10 Is Now Powered by Linux Kernel 6.17 Ahead of the Beta=
 Release
Link: https://9to5linux.com/ubuntu-25-10-is-now-powered-by-linux-kernel-6-1=
7-ahead-of-the-beta-release
Date of article: 10 Sep 2025

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals Singapore
GIMP =3D Government-Induced Medical Problems
13 Sep 2025 Saturday 11.11 PM Singapore Time




