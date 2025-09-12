Return-Path: <linux-kernel+bounces-814591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4E5B55631
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DFC1C809FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3732BF44;
	Fri, 12 Sep 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mKHqWW6T"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E74218E25;
	Fri, 12 Sep 2025 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757701823; cv=none; b=QNKeFm5SPAsVId4/PufolfccdKcFtkdEHpq+MOkykE4gcipAuLtSjBn2S0eTOT38LOY5FptHq3Fi3LlL3t5ZjnCwPBbNqMJnGHN+JmrB1w8IcOHxpb3Rjl+QAuq7E5zE3bCGkuzxmzdBf3Jm4PKsvrHhDXd23VmbGEsvZ9AP2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757701823; c=relaxed/simple;
	bh=A6BXw+C1DkIBGkNnITTdD89zNKj7hS0tzqR6e4+9xYw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FlZ960rZNfMTjlVMrH5TJbCl8EciXMTe8/8aTrfPy2IMcTsNa+7UpLT+gCQrrpiZTaPve181tZki5c9gBcGmYeWcga27NDJIGXDnh/c57cS428d+vPbIS02X0PZBy5msSnK/5fhZTyTNhiGPtQ6IrkbfTjW2mLxRBeuKCX/z0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mKHqWW6T; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757701811; x=1758306611; i=markus.elfring@web.de;
	bh=A6BXw+C1DkIBGkNnITTdD89zNKj7hS0tzqR6e4+9xYw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mKHqWW6THKIk/MAE4gnpAk6XaTudjmIdnarccbHSfMPyZ9mlXBGC5XIZu4UzS3kk
	 oOd/t7a4rZFE3O4zFOh3uJNbrwW+6qRG/NY0v4Ufl6KxEqbfZdZrWMItr31otrQsi
	 yRRHzsknN/l9PaF6Bw+B8X32vSdALObSD6Lapwyns9HhiCGGYcEFZhMA1hEVXaBKz
	 0Er+cKpT4QX59ij0F76oF8s1LE0oqUphpVjIVUraDDXjIKZ8bpTiuN1MHUEmsAoGS
	 fJoqd8F7GfKTr1nd+NHA/i54vPwOiSSwVl/oCbXmMfQtbNYlWNF4cCGhEiDDdbHW2
	 O6lMs7QOqg+zVw0bnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.219]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZjIR-1usN2y0qRT-00NUMF; Fri, 12
 Sep 2025 20:30:11 +0200
Message-ID: <37610abe-e6ea-4694-be63-1a7147c52b73@web.de>
Date: Fri, 12 Sep 2025 20:30:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dany97@live.ca, platform-driver-x86@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matan Ziv-Av <matan@svgalib.org>
References: <MN2PR06MB5598DFC94FB13E9F809F0EB3DC08A@MN2PR06MB5598.namprd06.prod.outlook.com>
Subject: Re: [PATCH v2] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <MN2PR06MB5598DFC94FB13E9F809F0EB3DC08A@MN2PR06MB5598.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8+CLw4rvkkXajMZk4E4yA4wcfTva7vlVKoxxJhg5Pnc7GK88IBl
 bVTHGQ+42guhypVoVWg6NYD8BJZnog1ybxK4l7+fPhWSTO7atgq6ZPSmkhvAFWS8J2mLimN
 2knwhnl0eHVf9u1vSuNOVxONzcp5aljtXoq8UuXCbTsynFgqaYuJwNqDFQO6PJrzEKmc+qw
 FDj8dYK7XKOgxAmsAhxwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dnlCCM1HBx4=;60/bCVSwlzJvNEWkWbIOmqJ51Mq
 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

=E2=80=A6
> Signed-off-by: Daniel <dany97@live.ca>

Please complete the personal name according to
the Developer's Certificate of Origin.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc5#n436


Would it be helpful to append parentheses to a function name
(in the summary phrase?

Regards,
Markus

