Return-Path: <linux-kernel+bounces-800929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FDDB43DD2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0B51C85F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEFE2FD7BE;
	Thu,  4 Sep 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="pswt4fBT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cEejrdHe"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247F272E41;
	Thu,  4 Sep 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994074; cv=none; b=WKOiN20oM7YrGjaJEGJm+EzAY1BwnkEuxkYNaRR21c51b+LoWlOuPdoERyxb/YXWjuHJZgmE9KW7T+kxLslVZG1bUFVlyS6WGa6yeLZP93enuBK94Awyup/oYO7bCirjY6keZXvGMg0wEnKUEIf/0x/AKy/5qCH0tMZ/D4c1GcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994074; c=relaxed/simple;
	bh=yizNSmYKll/I9v1A1YDZ1yRBbMjUVek6yUuASN23Gjo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U5N9aTDMcWbPhfyfOQmEdK/JFPjl9aqigGFHjLsIxN4WqNPhZ51JClDe9sv90BFZjxTp4FeZDOxpOLsTphp/3DFGRLI0EQIs+7nJ/MS+kcm+rPbhGGAoCAgpVbPM85VMTeHgOc7SamCDuSdOnBnVMQbCUj/2gySl4lb7MLnNgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=pswt4fBT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cEejrdHe; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2BEDA140026F;
	Thu,  4 Sep 2025 09:54:31 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Thu, 04 Sep 2025 09:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756994071;
	 x=1757080471; bh=QHTyeTwg544q5gmqzTQTcSX3Fd3rpZ72Ve8h4qh1aS0=; b=
	pswt4fBT2oiukMBvIiWEqWwpWAw09oZyi6OgPfYJqPes54lARcwO37wgvpQUHlH/
	1oFExGG4qoLjhxU5jaiotq+kd93XNVVQE4nKDs3kh8zUQ8f/c9Zyk9ZAF199VW4w
	uTL0+YBwNWNeX6E0NIcOkn6OoGa08kSbFGZx5nlvU7Fubgx41BhQRiHxFYWvr0V4
	VFWODJ/D1fd8PvLM237yHNnF+d2Sp5Cn8BszFRe/clHHMbZzWDOeKDL8/jCgp2PP
	mwV7qskPwb1XI0i18ZKKX16xe0ty5dBrCIc9VB9x/+PK+wTfgjZ9dWFWAbiCrOCB
	/GvcYSI9UekxAzyKZCp7nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756994071; x=
	1757080471; bh=QHTyeTwg544q5gmqzTQTcSX3Fd3rpZ72Ve8h4qh1aS0=; b=c
	EejrdHeiJLpzN4A5pMt59pe64pchEN1oFubBUSyqtDFvDMvZ30RIg/FP29Q+kl7T
	dh1tNU3HRXPU6hSjqAOLA73UptF68ol5sl/bygHq0OdWACp0CydsW8dAqlVbaR1k
	7lx3iXkFWKKYKV2SE8ZUyIFNROVvvzJ3R61nXfVeVg9E3qfXB7yPt3RzSyi7Avmr
	qIavVVAo1mIkWWa89Rt3fBhpwRb1Rvd78wpdFsY14zBfZDc1ExQiYhm6bi5iykPN
	nQfhyzJUMhDQkg8sUwMNhRsMYzAPInazIdRri1anzzgZohV5nDj3/HgsVAXdpRDi
	uCjk+D5XIRkw5do9/e12w==
X-ME-Sender: <xms:Fpq5aBf8kwyJDUyPF2yMx-2eA2Wd7OgFPfDQL-nLit5N28FgYnFcQQ>
    <xme:Fpq5aPMbqe6JXXZch1SmEMP4YPIp9cNTqICLDwQ3i_WUAysNPZVBoIMMAT0_TVV5y
    SJI1EY4FZ7uan3KIHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfofgrrhhkucfr
    vggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqe
    enucggtffrrghtthgvrhhnpefhveekjeeuueekfefhleeljeehuedugfetffdvteekffej
    udelffdvjeekfeehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvggrnhdttd
    egkeesghhmrghilhdrtghomhdprhgtphhtthhopehhrghnshhgsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Fpq5aO5REiiw6eDv_ViQQfFQTm9s7Y9dBHzNHGNjSz-ukPWdnuZMuw>
    <xmx:Fpq5aAURlLnMVC902C2jBLTaYMql2dQkCeFTsLVGHNRrGniAjYPOlg>
    <xmx:Fpq5aN4s3_WvSnmJkDFfV4fwHTMZiwAM6rOyEtSABkkn6RDv5oyvhw>
    <xmx:Fpq5aLpdc3k7s7yQwgt4oThK1kbxcFpTPIzHY4vw1fINlwLY4FfoPQ>
    <xmx:F5q5aLXLsONKkrLGGts6u9UWX0UzDCV0u2psXJSdZFzDn0R7xuIEk94y>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BAEC42CE0072; Thu,  4 Sep 2025 09:54:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhK4IBiDdJJ-
Date: Thu, 04 Sep 2025 09:54:05 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hansg@kernel.org>, RenHai <kean0048@gmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <4b057170-3edd-4770-b6e3-b2369d910b44@app.fastmail.com>
In-Reply-To: <175699218574.16699.13124325115196828575.b4-ty@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20250903173824.1472244-1-mpearson-lenovo@squebb.ca>
 <175699218574.16699.13124325115196828575.b4-ty@linux.intel.com>
Subject: Re: [PATCH v4 0/3] platform/x86: think-lmi: ThinkCenter certificate
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Thu, Sep 4, 2025, at 9:23 AM, Ilpo J=C3=A4rvinen wrote:
> On Wed, 03 Sep 2025 13:38:11 -0400, Mark Pearson wrote:
>
>> Patch series to implement certificate based authentication on
>> ThinkCenter platforms
>>=20
>> Patch 1 introduce a certificate GUID structure to make it easier to
>> support different GUIDs for certificate authentication
>> Patch 2 implements the changes needed to support ThinkCenter platforms
>> Patch 3 adds some extra error message handling as used on ThinkCenter
>> platforms.
>>=20
>> [...]
>
>
> Thank you for your contribution, it has been applied to my local
> review-ilpo-next branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-next branch only once I've pushed my
> local branch there, which might take a while.
>
Thanks for the reviews along the way
Mark

> The list of commits applied:
> [1/3] platform/x86: think-lmi: Add certificate GUID structure
>       commit: c778f7ac13d5e94db821cf8e1078aa318cc15460
> [2/3] platform/x86: think-lmi: Certificate support for ThinkCenter
>       commit: 07b93b747cb713478991388b3d55c3ce9267e037
> [3/3] platform/x86: think-lmi: Add extra TC BIOS error messages
>       commit: a0d6959c345d89d811288a718e3f6b145dcadc8c
>
> --
>  i.

