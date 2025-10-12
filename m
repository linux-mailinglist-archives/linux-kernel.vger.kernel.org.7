Return-Path: <linux-kernel+bounces-849624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0124BD0869
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 415BA347CF8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A43F2ECE8D;
	Sun, 12 Oct 2025 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MnDHilbs"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127AC2C187;
	Sun, 12 Oct 2025 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760289602; cv=none; b=H8XcFY0c+2korcsRzyi8zvrw7OcIkdwFL8t1OGZM5ZZDWi2xU88IY3Hfi9Wx7BwePRcpiXzEn23KAkgVdNO1fgvYEE1dtOlIPXK/5/3kWGJl/2r/26ANmeY5LLEFSYlAJjhK/4Awopy76DlDj8oShYszgVk9OFxT3iGwbrBuEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760289602; c=relaxed/simple;
	bh=l9bMHZPGAmu8gFlLhXt3Q23lMIv1t8bAW2RltWBnfTo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=h2oi9NTDqSn2gVlixLH919Z/DyamcQ7XYqLxR4y2h/PYbBkaeBID6qCcOhK1cjJk1uhFvYUyZMCO2qbhj9ZUexezmsAFw0Ppe6em3LVEKjpcNnmQWoIDBdLJZDQok4krIAxZP/dorz1bix/knL5fbZEI3iKcscHUWpi0XIFwlfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MnDHilbs; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760289582; x=1760894382; i=markus.elfring@web.de;
	bh=l9bMHZPGAmu8gFlLhXt3Q23lMIv1t8bAW2RltWBnfTo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MnDHilbsqi2D6uK3CDlWX49RJteupezamSjQVaAohR2lliNalsCFS7ebHmnCATRp
	 pjJzeMU+4ngdqEL2shFXqo8xDUCUsQOtEQhkmMjapHmk411Vra7Om+IRpI27NH8tm
	 aBbjNLlQZ9Rxbx8vyVGxRItJWOjl+H0w5nG4sAnCQ5E56zeivjKunVqsynsJ1MIh7
	 HRojZ/WJAPJS1+WLJ0tdIp/9J1zXPESgCd4Zz13C08Givb/53WGmYdKqe7EYrAOxD
	 uUGUAe0BWqDtH3nf9gZ8o4/8nfeTVwHgk0I34morPxZG3IiuUNCaE3as9DI5D26yK
	 KjRAyCUgzGa3bQrjTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsJOq-1uEFVs2hbu-013g8e; Sun, 12
 Oct 2025 19:19:42 +0200
Message-ID: <5dc1ce09-98b4-4c48-971a-3ecb5ed9882b@web.de>
Date: Sun, 12 Oct 2025 19:19:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 linux-hwmon@vger.kernel.org, Cryolitia PukNgae <cryolitia@uniontech.com>,
 =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Dan Carpenter <error27@gmail.com>
References: <20251010204447.94343-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] hwmon: gpd-fan: Fix error handling in gpd_fan_probe()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251010204447.94343-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Hm9I4VsBKNGE5adsCrxqHf49VqYtYl4MXEw328wGQxyTENj6EAH
 Hx7sSazYHhJjNTpCdJB01npRROsOGFjUkWjMIosRst7KpVWY7AT91xGNU4q9wj2kfj9VNnu
 ugNFN0rOG5jWTxmlLFOExD7C5S1FvebkR7l7GkHkswf6OMGKJxE6nw+OIoktROE8qwuPi6t
 8mEcgW1dT4DLOO9lR+OBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AGrh4CZ+OkQ=;CaximESJiSqFqvPXRhBriYgo00k
 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
 gPVaF9dji8vhEA==

> When devm_request_region(0 fails to get a region regrion would be NULL
> and devm_hwmon_device_register_with_info() fails, best to propagate
> the hwmon dev to PTR_ERR() as opposed to region.

Will another imperative wording approach become more helpful for an improved
change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17#n94

Regards,
Markus

