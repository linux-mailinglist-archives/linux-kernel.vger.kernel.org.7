Return-Path: <linux-kernel+bounces-899442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37470C57C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22A51356DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42C11F4168;
	Thu, 13 Nov 2025 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SBzd9611"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2231C32FF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041279; cv=none; b=EqQszUDCSyAYvJ2pKusm/CyCoAofhfTGpBan/Z6SehEkZaxAuthS/PF6MDHkKNNVqkeOAh9l+nqbB3cct1e8JA20RmCFLPXnY1Lq4HnPQQ+eewLStEyLSkPfcC1huyiKKc8CxUUoSwUzSA1VJeC0+67WUr4Z26yvuGVtOcqa6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041279; c=relaxed/simple;
	bh=xRVLeggvTFpxhmDMhe6RFRSWS0nSpHS/MwOalgoq1Ho=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiK3EFMCmsWYCJ5wkBrxpM65Hx+5GnHeNttrITJMin6gmNTYxxxj3gQERB8TlFseF6rmedvKQ04kXUAdBedK1Bs2ZCSSGgBMVZuE2z+j9pxod8dOm6U/IviRXU4bHM29aV3Bpm+e6PvjzzOuen1xSq2q8lPQoNZWZ5HzjGbYJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SBzd9611; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1763041272; bh=yncWPINDR52pv1d4G/0cf1imkpwN4ckdlyrwN55xFuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SBzd9611oZqmP855waMRaatSMd+o6l9+GOK2/f9QU8guHb5wAnp5z0Ek6DeSNZDjv
	 QODrAOGGc1wzKIXYGqOYsXloxf2jjkL6lMAW/hi3eAn8PCo46oiJv9cjT3YN49ZxRB
	 So09S7jA6qKTm/s5MGSoCJO8GruA6e4RRvuYIslg=
Received: from cjz-VMware-Virtual-Platform ([110.176.66.153])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 9F72569E; Thu, 13 Nov 2025 21:39:55 +0800
X-QQ-mid: xmsmtpt1763041195t2zcvgezd
Message-ID: <tencent_27A546C0D8ACEF4B7DEE94D65FD805769809@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeQywFlMHCgen52JUQLc1cmq2dV28SszkRuGBqVKM7Cjf/40tDG8
	 bRJME2qqMhvfI5ygmbW1mPOv1PRrakSmUQ35T/GwhUfF20TJdsdlpJ8Bl3SrFDZdQUGMiOHLDuyt
	 qKpgUIT/cdDeh3ChhYINPf8STcL0tkFVs7+Xnd5l0bh+fumoO4h1S7d7ew4dcil4o0Y/xVE1W89n
	 6Aym1Kjw9uH7hZQolbsQt4UuGQc5XLFee4VXMvUQRRSe2HtDrlJJ/c5jPMCF5NiacEH/94AWiLfM
	 v6YbCfX7qSBFLwVtJbZ3298+thQMw9bQH2aH/8h1dmBTH1WKlswgbt5XGWga7usUcOPbUl9Hq40D
	 6sDQGbrbWUMHX1WXHu6jq1fdgP+LOVPIKpF/pD5VpN5+XDYlGtFDKqZB9kAlgvWc/7Mtwf9MkD38
	 b6nRbD15McDQs0HBgaHv7UzI0/73Q4mWN+yU0g+6lF8DAm0rMHZMusmVBvxruJthWSnvWaIthhMI
	 FDJKCpdglTjeSwgUo5T2/qvluoJitYNfRSq+ukr3Lede+mMfLiC5JGqFjmq7eXy0eO4mN9hga9b0
	 WrYDmhm/siFdLZTfQSzVVp/wbiyC4pz1tqvE+9TJIscNcBfz/S++fdkvgN9W4mS9aX1HcUPTBJb1
	 YjMzmB/xB4dGYqq4t+1XUfQLbVeXEs+uZMwGqnIaooun+PncygTN5nBbxzX1kFJBJP6Xb+T3z9GG
	 zRDzw448GFwLdkudnKJD7ibUZzjELFo5nKu6P7W0t85bOBDshE7HRh3qvPhYatXumkRHWGIAVygZ
	 vSy6efJBndOhps7miQSuwaVdzwSb/Y1u7UZcZrj2TGcvpm4bt1ZRDY2wSieNsWTI9fQPii79B3uQ
	 ta7g2aX0TJdx8+8vUSi5P7XTS/Z8LzWG8O1SsGFJUyOXhw/cmRak3CWFrKFmW/+QUlMd9FGQYkhz
	 cZnRAmDY0VAMjW2d9nqutya34vXJd0OCV6gpwgdnNN3ScUegC9gwBz3+f067SLhZCC9AGfyylUzO
	 7NUzATjM24buqs1Y7i17Bi8PvHuVw=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
Date: Thu, 13 Nov 2025 21:39:54 +0800
From: cjz_VM <guagua210311@qq.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: outreachy@lists.linux.dev, Vaibhav Agarwal <vaibhav.sr@gmail.com>,
	Mark Greer <mgreer@animalcreek.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, guagua210311@qq.com
Subject: Re: [PATCH] staging: greybus: audio_manager_module: make envp array
 static const
X-OQ-MSGID: <aRXfqoWn71fqbv6P@cjz-VMware-Virtual-Platform>
References: <tencent_7710B04B6BEE52903BA2F56376DB9D18A907@qq.com>
 <2025111341-attendee-ferment-262b@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025111341-attendee-ferment-262b@gregkh>

Hi Greg,

Thanks for reviewing my patch!

For sending twice: I apologize for the duplicate. After the first send, I realized I had missed some greybus-specific maintainers, so I resent to include them all.

For the indentation: You're right to ask about it. When I changed the declaration from 'char *envp[]' to 'static const char * const envp[]', the opening bracket moved to the right due to the longer declaration. I added tabs to keep the array elements aligned with the opening bracket, following the kernel coding style rule that parameters should align with the opening parenthesis.

If this alignment approach is not preferred, I'm happy to adjust it to whatever style you recommend.

Thanks again for your time and guidance!

Best regards,
Chang JunzhengFrom: cjz_VM <guagua210311@qq.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: outreachy@lists.linux.dev, Vaibhav Agarwal <vaibhav.sr@gmail.com>, Mark Greer <mgreer@animalcreek.com>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, guagua210311@qq.com
Subject: Re: [PATCH] staging: greybus: audio_manager_module: make envp array static const
Reply-To: 
In-Reply-To: <2025111341-attendee-ferment-262b@gregkh>

Hi Greg,

Thanks for reviewing my patch!

For sending twice: I apologize for the duplicate. After the first send, I realized I had missed some greybus-specific maintainers, so I resent to include them all.

For the indentation: You're right to ask about it. When I changed the declaration from 'char *envp[]' to 'static const char * const envp[]', the opening bracket moved to the right due to the longer declaration. I added tabs to keep the array elements aligned with the opening bracket, following the kernel coding style rule that parameters should align with the opening parenthesis.

If this alignment approach is not preferred, I'm happy to adjust it to whatever style you recommend.

Thanks again for your time and guidance!

Best regards,
Chang Junzheng


