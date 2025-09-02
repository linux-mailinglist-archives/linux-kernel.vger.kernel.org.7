Return-Path: <linux-kernel+bounces-797225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1470B40DA5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D351687F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C60345750;
	Tue,  2 Sep 2025 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b="PNC+nvnu"
Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D4E30AADA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840156; cv=none; b=KeQAmuDvsa9zaJmTmhuTiF3vSXoLE3L8f7PhD1Qbb66Vstk7wjJcxJpqXFTOKlws9Dxm2ghIj8R0VVmyORXaKu3wlmJ/vX1ByN5CrhvK1sIrKapFHlay7tTPlteqxba5GnBn+NMs3XPZ2n/kXDSy3jxg2WbY35n2D0ZKx75pYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840156; c=relaxed/simple;
	bh=K1l5oCejOEuDh3FhRGVEX9+GHaNomT2a84vfKEwh1jc=;
	h=Mime-Version:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:Content-Type; b=Ipvf9l2k5ROe71wFnM2UQ6MIyJ0zunvD+HMnVR+olfd50Di5pbuE1fIcRZnzTQMq2Aqk+uBdX1NODecdIIMA6ciqKcLR3Sw27B+8RPfjzYLOYek+frLbJbhTnp4Vs9j3GsQtRHABDzYliXYEQVSDhKvThy9MphC+9eFU/g3Xg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org; spf=pass smtp.mailfrom=achill.org; dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b=PNC+nvnu; arc=none smtp.client-ip=89.58.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id 2B11B9A2927
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1756840144; h=date:message-id:subject:from:to;
	bh=K1l5oCejOEuDh3FhRGVEX9+GHaNomT2a84vfKEwh1jc=;
	b=PNC+nvnu8nezUL9CnaV5zFrgX05BsTiIKEbC+aU860PJZNm6QGrEQVhO5zgprS6AOPIrMVU/+96
	bw/IzbCDtSXDUCuIWOT7AL+8oRs3+QbQCns12hzZb4rwINqFZyMPC2JLeZ9cIGILMQMyl75ANj0sp
	ldR9jCXnuRG9jXvx1qqPYRIlLiWPa0BGDBRhQanSLEvnJCZzm4AL8hhceTwwmKBXpLy8Rbom/tzLD
	5kSUMANx9WBqR31HrXei4HuCzJIkA0hzxIV5K2rUCCjBN8DIEPOyRAsvnjB4lt3GOSeXuSt2TbMlw
	L8PH+eLsP5JyhIAkSEYXX4JYHyvj7CcBlpUg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Sep 2025 21:09:03 +0200
Message-Id: <DCIJUS5KX4CH.HI8OMXECSDB4@achill.org>
From: "Achill Gilgenast" <achill@achill.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
 <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
 <srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <broonie@kernel.org>, <achill@achill.org>
Subject: Re: [PATCH 6.16 000/142] 6.16.5-rc1 review
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250902131948.154194162@linuxfoundation.org>
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8

On Tue Sep 2, 2025 at 3:18 PM CEST, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.5 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.5-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Thanks! Builds on all Alpine architectures & boots on x86_64.

Tested-By: Achill Gilgenast <achill@achill.org>=

