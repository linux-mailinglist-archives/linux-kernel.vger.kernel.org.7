Return-Path: <linux-kernel+bounces-749523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B592B14F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CD84E2DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8BA1E5206;
	Tue, 29 Jul 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DRQ/BZJt"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD41C2335;
	Tue, 29 Jul 2025 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800142; cv=none; b=jnJ6bfDJ/77X9iVhE7z4q4yzKCT3FO9vAH5/JVJ1XRP222vn5nVOb1RTNCoPTbYbcQKwNzwcU1RhuNPN4IF7CPXLaZx7/OK8FiWD0+tDFNG4OLGutTGdiJF/wD1/rpHlR0ygyY9sX4ymSw8ttpsTNx9N6e6uN0JqyJdoxfvtwFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800142; c=relaxed/simple;
	bh=IeqpUwDN+q4a6P3JINbsMLGyOaSDoAh+nGw1NYtnjCU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UXwDx3TOA/U62I01FgopLsqF6NUWTn+AEuCPYtpbZkysR6rYcswugq3vefgkx8YUsPz6uVU37HkxWyE/Hvi2RlP0gAcwqQO/fwDb7DGRqol15nx4+tsr6dweF4tzTBO4XL/5rpuySp5Ak9V0Oh8lnOW1qITG6Fro7esDRlEfCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DRQ/BZJt; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753800132; x=1754404932; i=markus.elfring@web.de;
	bh=IeqpUwDN+q4a6P3JINbsMLGyOaSDoAh+nGw1NYtnjCU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DRQ/BZJtnhfu8PVhcSq0LYVDjKIb9j3ijPKNxRzSals5nfuhJRRMHCrevbq9X4vy
	 jluFAx7PkNiq9d6d3wVTZU/94gvqWDXR2sAuXSTa8Omiv0sE7gAuIxDqW0urkwARF
	 O5M5g2u1C0YBKYEJazQAMj8kJf2PY6UttE7dt6p/y3zlJZiD+LZAKkHe4Y8SHFzxe
	 NdDHWyabg9h1Mua7YLb2AlDxwd5z5noOGJ1i4HktDoR5iOIGhmKv+n/EefDf6HN6q
	 6MbgxIjVr1S2Wlu7m3BVcAYe7dtUFXKBS+B5LPxQ0AYin6ulWU0zxk1WMN635y/k/
	 51BEV4pxzg5/fIGopA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.201]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1LsH-1uWPYe43Ol-00uFMV; Tue, 29
 Jul 2025 16:42:12 +0200
Message-ID: <079be718-ae8f-408d-a789-05f4816e0bd4@web.de>
Date: Tue, 29 Jul 2025 16:42:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>,
 linux-kernel-mentees@lists.linux.dev, Andy Whitcroft <apw@canonical.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>, Joe Perches <joe@perches.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250727125044.101779-1-suchitkarunakaran@gmail.com>
Subject: Re: [PATCH v2] checkpatch: suppress strscpy warnings for userspace
 tools
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250727125044.101779-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:STqGquKOFdB+qNZApJMXTkk6cyXlIH7JMiNrlTOpCBJ/0S2YMLs
 WjOcaGT4bSfgVoFbZ2E4af+a3eaFCxeL5HFWbLqE20NkNpokVCWoNdSaVZCQwDUGXq3OkqE
 rgZS9PGp4k2JSTvSpkhIKhhyoO+mf5QQsHUBiIH8YUJX/PL9KDNVSN+X75J7chONQDYmge7
 dy8oYZe5k+5l1vzVxO24g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I0B5X8vIuRE=;lwMYvdrIKoBNVftRop+yrayztIs
 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
 ORDfYjfrqEEG4wyzzbp8PSCCzmkOxAYA=

=E2=80=A6
> This patch suppresses =E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n94

Regards,
Markus

