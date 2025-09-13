Return-Path: <linux-kernel+bounces-815317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ACDB56293
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 20:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B7256651B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36B921B9CD;
	Sat, 13 Sep 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XbfTZai+"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216F469D;
	Sat, 13 Sep 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757788975; cv=none; b=ernMR2eS+sZgaVby4jaUbeRwf5aMU4iDgpek3nmCW9xKPn47QdKyBZwsQRrzwpL0fa4rlsq5Rh8ctkgWpvizUtA4BhGGaGR1tbun3/Xo4/PFzYxHgSuMWCzCIuCH2MYys/CrHu3QqR9Hp3itTPgPtfNiIonYBUHgU5JvldxNFrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757788975; c=relaxed/simple;
	bh=SLuR8qxEMfqe5InDtzQ2oGLELyg+xNWm9EY+STIRKqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luDYyISFR9nX8c0aoQXtsVRM9ik6Xp/b7hsKV6q9opqZZheDRWrpY4kURyWjCJPh8CDCv52X2UzVD9v3WQ9GjSNPyHvcUeNygp90buTWCti3Pul/j6D7Yyep8Ey763ZA0/d/EMmgnj+zIoCOA3EhWusl6t2Kdo1mTn0gqZU/I2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XbfTZai+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=COxpmyOT+gvU5PDlLKI7BwcE7Zrd/1BXxX/O8Ztn2XE=; b=XbfTZai+eLISQeMJzWY9/6VOcL
	l+cQ1JpB6HWKf7ZdSNDD+TzRTs3f6ZPlQPTsPYSYsVnX5ya2zrOm5cZk53bliqDH2iYKU1gS+EwqA
	MIE7Bd55uhfsAHfGLShpFRm6E56bh8T3eUI3kbwNPNFp8oODheUKp1T55MHOp7xBsgcY+QkAP/iGq
	c4dsFExPpKigAPVzsRzrBVl9hVdJwRGDdrCZgHUVMLo8W5Zqtl3lIVEO8x9ccghmQ/3+JBe6pY/Ao
	Yeif04ako0h8Pp4gN3sbkEe/EuU498mmV3y7eCkrZDaKs5TcTlCo8rOEAeDvb+10jC8ZQTvoLsS7Y
	VoWN2WDQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxVCz-0000000FqhZ-024R;
	Sat, 13 Sep 2025 18:42:49 +0000
Message-ID: <208fa944-6aef-4acb-ba39-d351d364c53e@infradead.org>
Date: Sat, 13 Sep 2025 11:42:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: w1: ds2482: fix typo in buses
To: Akiyoshi Kurita <weibu@redadmin.org>,
 platform-driver-x86@vger.kernel.org, mpearson-lenovo@squebb.ca,
 derekjohn.clark@gmail.com, W_Armin@gmx.de
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20250913173413.951378-1-weibu@redadmin.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250913173413.951378-1-weibu@redadmin.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/13/25 10:34 AM, Akiyoshi Kurita wrote:
> Correct a spelling mistake in ds2482.rst
> ("busses" -> "buses").
> 
> No functional change.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  Documentation/w1/masters/ds2482.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/w1/masters/ds2482.rst b/Documentation/w1/masters/ds2482.rst
> index 17ebe8f660cd..5862024e4b15 100644
> --- a/Documentation/w1/masters/ds2482.rst
> +++ b/Documentation/w1/masters/ds2482.rst
> @@ -22,7 +22,7 @@ Description
>  -----------
>  
>  The Maxim/Dallas Semiconductor DS2482 is a I2C device that provides
> -one (DS2482-100) or eight (DS2482-800) 1-wire busses.
> +one (DS2482-100) or eight (DS2482-800) 1-wire buses.
>  
>  

Well, I'll leave that one up to Jon. The $internet says that
"buses" is preferred but also says:
"In both British English and American English, busses is a less
common but still acceptable variant."


-- 
~Randy


