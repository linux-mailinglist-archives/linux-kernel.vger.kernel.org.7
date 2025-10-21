Return-Path: <linux-kernel+bounces-862131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CBFBF47FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8752E18C4277
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A9238C03;
	Tue, 21 Oct 2025 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="JuKGwTFa"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1CC22A817
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761016932; cv=none; b=K5hu9TzD7QONkbO1+xqsw/hYDqBovUCUVKp5z+TyNWbBnee8UiPIKPASMSl3ndzn57urwhgLDah9rSevO9pnTsn23JQnLJOZui6nF8GuQ8gIR0gAGCsib5oIaUhR5HAmEfhlsZgwBfUJ13lXQm2zGguYc4PtImD9wa3pfbhneQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761016932; c=relaxed/simple;
	bh=kpy3W3KmYTz6pOIyAUYRAp5lOnGa6xTDAN096KTZUYQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=TbCeh8j6DFBAcb6tMs/0Zi9Uk5w3AUvqs1If85fdqW2kLtM/2Rgyi6kjvpKZIrGe8iIacPtw2eoypOjDT8MKAsPIy+Zxj4y6BC93Fh4xT5zw/JDVmfU0ijuevweK6mWaEDZE0b3QQyc726C3Z61tnEWqKlCMrn+5vj7Mghc3/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=JuKGwTFa; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1761016916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpy3W3KmYTz6pOIyAUYRAp5lOnGa6xTDAN096KTZUYQ=;
	b=JuKGwTFaYnULDG+s+GOm1ktKMpfexM4vQ6rV9MKIC2NVmj0pJjLOG6FDlPJ+R4dQl9P+86
	OTzOzVBp/DgYeIGSrPhU3zHkepHsf17SvYfdSnKyFGroup2B2AWYglqDkooPkAW7zkKNv7
	7IqjZ9s7eNqbnZHWnqvDtv7lrR1f2ReHoSo0lswGZqlxeR8FQaRMLGGiWMjfdjFyTMa1oj
	OueVrE2eRRiUrDBsAGS1OnbpACF2Lxjo9J7h9bz/gKnDTbhu8RhgpdZGpok9AvqXO7Bo9Q
	z2LwsZsbLnMG16VAMIs/cNTr8+Bdr0KsTe/cTLvncNI8qhF4FLfNDvuI44wjaA==
Date: Tue, 21 Oct 2025 03:21:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Paul Sajna" <sajattack@postmarketos.org>
Message-ID: <07611bad51014c3699966c0deb5edd7ce65c21aa@postmarketos.org>
TLS-Required: No
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Define guard pages within the
 rmtfs region
To: david@ixit.cz, "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof 
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, "David 
 Heidelberg" <david@ixit.cz>
In-Reply-To: <789a2ffa637842215084a39eeee94993a315ccbe@postmarketos.org>
References: <20251020-sdm845-use-guard-pages-v1-1-64d714f8bd73@ixit.cz>
 <789a2ffa637842215084a39eeee94993a315ccbe@postmarketos.org>
X-Migadu-Flow: FLOW_OUT

October 21, 2025 at 2:49 AM, "Paul Sajna" <sajattack@postmarketos.org mai=
lto:sajattack@postmarketos.org?to=3D%22Paul%20Sajna%22%20%3Csajattack%40p=
ostmarketos.org%3E > wrote:
> I tried something similar before and didn't have much luck with it. I'l=
l test your patch when I have time.

Your version works as far as I can tell.=20
ModemManager=20always reports sim-missing on judyln, so I can't fully tes=
t it, but no crashes and qrtr-lookup shows rmtfs is working.

Tested-By: Paul Sajna <sajattack@postmarketos.org>

