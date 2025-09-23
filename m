Return-Path: <linux-kernel+bounces-829075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D7EB963AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029B64A5740
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B7824635E;
	Tue, 23 Sep 2025 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BRbxAHrt"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567423FC41;
	Tue, 23 Sep 2025 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637312; cv=none; b=uU2JSVkxHAtsq/sy/dbu81knogoKHN6+TrszNjJ0CZiGYShxyOZ4X8ukdpklRMZV0ka4ax/oEgYDTidZL67muH7YdXv5WrQMYqvXI43htoQsk5FglETwTO5SEa9xgYmpo+RiP5nQ2RG7Aid280lDti1b5FJcleTu7UfHGCJFSF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637312; c=relaxed/simple;
	bh=L74c9IIHIOX2Z92pjI2oltONH2cajKEvUUPh9QApO6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5WG6BLotrUT5NJ67uwUqpePkXTz3Ztr0byGXRaPEoWQNl8cGSO2rshERD156AftHZjl3uYAxsi7hnHscMQDXtJlsGn7C4THykWj4i74UKMtieZdgJw4SfeuZD/DuSvgjwhjcc8eDSdSBhp+COgJnUHDo77PvgiRiEb1LS+DGmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BRbxAHrt; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758637296; x=1759242096; i=markus.elfring@web.de;
	bh=L74c9IIHIOX2Z92pjI2oltONH2cajKEvUUPh9QApO6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BRbxAHrtXeTVqlPZYl8YUcKR1rvqbMgzv4ghGzPFW7BgInUp3TXO2Cl91jsd7ls3
	 vOufZBbRUysFqnB+xUv4Vgx5isUzPZOMtBFmtN1CLpRLrc2zObAVuHzHfDiHsXrdo
	 8lLbr9nnNw3hbildEjzfP4KIR+ISD/P8UqraaehqJ8u32LsqdipMdK4EgFdEKvIQ8
	 wxIUG507k2gt0n0YK61y+iOv8HbzTezXJRc5OJhFe3n0XpfCEE4yR+J5gtO3oLV5f
	 g7jpOGRWFFLVjGa5qXqZ9nwszkmxGMM9kTt5qiCxKYg+8xk88KaY1VrrWHhNsIbK3
	 K7T5DG7NX5LsGBE5gA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4KJX-1v1L0r2jcf-00EwK3; Tue, 23
 Sep 2025 16:21:36 +0200
Message-ID: <a307d75d-477b-4632-9444-c9b9f7883b07@web.de>
Date: Tue, 23 Sep 2025 16:21:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v?] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store()
To: Daniel Lee <dany97@live.ca>, platform-driver-x86@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matan Ziv-Av <matan@svgalib.org>
References: <78e9dde3-9f21-9b06-663b-e7a23451b9e7@linux.intel.com>
 <MN2PR06MB55984287A9BAB69F1711640DDC11A@MN2PR06MB5598.namprd06.prod.outlook.com>
 <ea57d978-3fd3-fd86-aec7-e814359e3e02@linux.intel.com>
 <MN2PR06MB559873DBA3BA4491E08949ACDC1DA@MN2PR06MB5598.namprd06.prod.outlook.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <MN2PR06MB559873DBA3BA4491E08949ACDC1DA@MN2PR06MB5598.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QyfA4A9pYfhpRyXOflEKpb5xLHvy/LRETz8FRO+Mr3d3xntNoIX
 p+MnGRmksAT1nFttJXagl1fnAwnsEOf04LiCMZO2N8EkzN2KSuPSEGvRMnYMvSEAMRJ9elI
 ScNy7ntUFlsJtaO1to9F085Y3wfcVXTCFBjAv5iLKLOzNCAXZMBty3OZRWo81J5mq0oY7uw
 b5og0d7hkIMWgftXPCXiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lPKyIRcc648=;qAuWgtJfRMUZDiE+55lCkenEZA8
 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

> I renamed the variable to `mode`.
>=20
> Is there anything about the commit message I should change?
>=20
> -- >8 --
=E2=80=A6

I imagine that you can adjust the inquiry format.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc7#n638

Regards,
Markus

