Return-Path: <linux-kernel+bounces-806334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A758BB4952C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64E3D4E1EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FBD30BBA4;
	Mon,  8 Sep 2025 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="UJphDDG7"
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453652F5485
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348815; cv=none; b=qV1j3puP+KZ6BJImYw2WDd23f1DeUlkhTE3XXpnjRfKGf9JVKRdY9FcyuKf+NmP8e9hOR9gFoxt6YS4XJBhVKU7ZWNN577ikqhkDKkLyzWNlDa/aqb1VrTqYiZncoz5kkBQgikBbHI4LA3RFCtKqqdShsleNvAwzfUc2k8a49I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348815; c=relaxed/simple;
	bh=+JvYa5YHa5sOawRyETJe4yDCbD+/yeemIQLH0Z5Ui4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fm9IS0ctX/Kthf3AyKf18kLODWKL0/+WwboZtELy6u4YHYv/ZrrGxSEZ6MzlRSz1lmWQfTKGGEW7eWMgFbRes2YL8RaYBHlpc40FjoAqtkLOYrUwszuNz2v5oIlq2E/kuLxni95Rrx3XnIsgLwR1khujaJC9AinZpg6R1drAs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=UJphDDG7; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+JvYa5YHa5sOawRyETJe4yDCbD+/yeemIQLH0Z5Ui4o=; b=UJphDDG7/7o+wcTtCJ6L93GxSz
	eDNxhQNo9AcWzu9tlDYepBKaGkS8YPrXKvQ+z4nXqwB69rr4bTRKqBsT8Dqp0LHcgmZudB1/gesUR
	xqlLYWzrYY3kSLklK4nVHmRAWFK7SuQYxP0jEQLhPgBf1Gjv/qlfE2Z2BHtQEz1YLPrHhYAJuJWrg
	gimY7gl2/90c8v+U4p8OqVl0WsucQHobQu9AVsx2e2IzpZRzs975NF2tWT/Vp2savX9oOeBZHystq
	7IawuIi2WZrSe98oWL3WQbN8vnrG9lMaOjnyPNRS1GLrFNM6sTPUBcokn0GKvo5s34a/kzNhcQyaT
	2VK41NaQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1uvegf-000000000Qz-3hWN;
	Mon, 08 Sep 2025 12:25:49 -0400
Message-ID: <46380ec48c4d2e2d01a229650129066bb3d6c329.camel@surriel.com>
Subject: Re: [PATCH] sched/fair: Correct misleading comment in
 task_numa_migrate()
From: Rik van Riel <riel@surriel.com>
To: Jianyong Wu <wujianyong@hygon.cn>, mingo@redhat.com,
 peterz@infradead.org, 	juri.lelli@redhat.com, vincent.guittot@linaro.org,
 jianyong.wu@outlook.com
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Date: Mon, 08 Sep 2025 12:25:49 -0400
In-Reply-To: <20250908061923.543081-1-wujianyong@hygon.cn>
References: <20250908061923.543081-1-wujianyong@hygon.cn>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-08 at 14:19 +0800, Jianyong Wu wrote:
> The current comment implies that both the task and the group must get
> benefit for a node to be considered. However, the actual code allows
> a node to pass if *either* the task *or* the group meets the
> criteria.
>=20
> As established in the previous discussion [1], the code logic is
> correct.
> Update the comment to accurately reflect that either condition is
> sufficient.
>=20
> Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

