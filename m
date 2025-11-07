Return-Path: <linux-kernel+bounces-890255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E48A7C3F9DB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6711890719
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256F130AABE;
	Fri,  7 Nov 2025 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tRrumvxI"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69285280A20;
	Fri,  7 Nov 2025 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513285; cv=none; b=Ke5MvU38vzgsN/5+idzAavd/LzFU3P8pSf32u05IHYrnCLXOX9GXmKpf9TrV3OUmBM/3G/H4cMp3eJpnPlWevpkrr7ZnK6p9nZq55uTZDHng21g1eYziFSKl/O77EuxksbEYMOIDASzKQisIhPpcxFJGT4sUpC9NVN9siTXNwAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513285; c=relaxed/simple;
	bh=XCnoEerULHYqXY5CSxLuwSo74JbUbq13YykTZcg4PVc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GIXTTAlQq2ZSNF6Wnf94vsA1d2JVT8s3dVxZZ39ECJa0/RBEdKj8yb9Vd1vgOqyqc9+boRAYjahnYgzFT9rx/DqDf8caX13KB7/UxpZx3SMY1T7R4h8U1Rh3MweH6QgR/1x5b00lRTMFrL3tdaOxieYSrp09KUTXjQ6nWmBdpGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tRrumvxI; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762513271; x=1763118071; i=markus.elfring@web.de;
	bh=FS35n2bKtaFfvJwNygO/xOItmue7WadXzNpJhF3T7ns=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tRrumvxICir+RnO16eUnSoQPf9aFNmTl5nW0vjJatHqFA2AvzMIZf7gm305JUnKK
	 Dqe+e0H0BSP9GKr2AHoAXJk900/LlegMFG0Oejcqj7kBYjLmrg2C08eAi1A2ZeFID
	 //qo+GkoDNOAC/sHwJ0o1ujYJhvVBmqLPHLAcanUlIlm9b3NrkgndWM8Ff0sf9fpM
	 91Gpg8QuZscerpzfGyIS3u4nschUE8Tbh1t1lQJNIgoenCBG2kcRrL8zmfV+4N/BP
	 ml4HAVP/Adic6LPkMXx2FGq0FDorgvpC4s+B5PL7taHor7loN+peRKX20FOGZ2/om
	 WgFHHNxx6/cF8orCAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5Qm1-1vFxAY1aUv-008l8l; Fri, 07
 Nov 2025 12:01:11 +0100
Message-ID: <fe032b8a-b7f8-4e80-be96-72667bb04c55@web.de>
Date: Fri, 7 Nov 2025 12:01:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yiwei Lin <s921975628@gmail.com>, linux-sound@vger.kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251106165802.3780-1-s921975628@gmail.com>
Subject: Re: [PATCH] ASoC: dapm-graph: Handle sourd card with space in name
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251106165802.3780-1-s921975628@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VFy5mRgo902RDa9UfX7qY6oN1hBXWfinrK0lJpDrzZENToRNbvW
 qXa5j0cp3JKOikriZTj/mwW3NG/9aZ0OzkKQb/DBute1qldH0hkfxIs1JWHJcxEtJ7t3nEd
 W4NIDk7U/dhdPrpCc+Ejmag3O/Wq1X235DlJJRNQZb+FJoBUGAi7lpoVBgs+D4oJRq125+k
 H43p7XxUxlf0pDEyuMpQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HwnVMRMyL48=;iipuwHboq4YDnK0YteemIWM27v9
 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
 7IC6g==

> When the name of the sound card has a space between, the
> script will fail to output the dot file. Consider the
> case to generate it correctly.

* You may occasionally put more than 56 characters into text lines
  of such a change description.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18-rc4#n658

* I hope that a typo will be avoided for the summary phrase finally.


Regards,
Markus

