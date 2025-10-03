Return-Path: <linux-kernel+bounces-841654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2CABB7ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA73C3A2F70
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B482DF124;
	Fri,  3 Oct 2025 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="YgO7rT7E"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE442D780C
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517530; cv=none; b=lLf6CdEU9MOADR3O0yqWk5tD9K/HT7DeN1fO9QEyhG10PLrc3+4yTuOHQjY2oJTIvAKtPBsmg/OrdLiS8euIH316lIAGssJNUThFoCPiWh4+73bd98NahcGPzdl3tl5AE/MjdCOVw+BdVQS2+nW+VBybv0pEbbgUYQ14nWBRUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517530; c=relaxed/simple;
	bh=B15vy4G8yT5+l7Cy5PIAiqSAyyBps0v1UUV+YoW1CDk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=DIJrbRshUjwuzpHn1rzSdRhFjO0uq1hT6J4H+jYauTujWLrSSdo+6rvQHRwTZCl7KfaBIGqNw9BihvNUa/pNQbzXTE2zrflx6JXbkOttEGFmdndQuH0/1fyq2BGUBqJpLyBZ/zOHlyQWPSapPQBnNjlYnf5+uo6gb/hj5NUSY48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=YgO7rT7E; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1759517525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B15vy4G8yT5+l7Cy5PIAiqSAyyBps0v1UUV+YoW1CDk=;
	b=YgO7rT7ErOyaf4CxR+vjsT+kvZMhD2sDhOn3Y3BG9FjIAtf4nq/SMF3G8LRRGFvQtcA0Ei
	pgQY2IAQC/n6luIXBj4cTjrz35mNnh+7xXXr5EIbkxQ2CPbQbdgac7TWt16CA6b2qL2EeQ
	WB1UaqKqr8n1Wv52ag0IFf9dmP2azkyjaK34Rj4U3LD3OJB6ZramBrv4vzxSZS1o2zAPaA
	cLp9ckPDccsc5txzbT1/a2e4esAhzQNM9FhIHX/vO/Z1ov/WJ5V9Af0rUZ42wOVThxyuH0
	EMDdFBo0xLbpof9HDqkRtUNbMh0G1UonHqZgd0dvh2c1VNpy0ejgFl/An1VCsA==
Date: Fri, 03 Oct 2025 18:52:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Paul Sajna" <sajattack@postmarketos.org>
Message-ID: <b9285a2e81ca992b9fc560c78ae03921000e388e@postmarketos.org>
TLS-Required: No
Subject: Re: [PATCH v3 07/11] arm64: dts: qcom: sdm845-lg-{common, judyln}:
 Add wifi node
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "David Heidelberg" <david@ixit.cz>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, "Amir Dahan"
 <system64fumo@protonmail.com>, "Christopher Brown"
 <crispybrown@gmail.com>
In-Reply-To: <gfbvgsen75w5h7afyo454pvdfslkeprqyuycuok6syinbza7vx@crapzdo33re7>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-7-b14cf9e9a928@postmarketos.org>
 <f58493a9-6def-4610-9c3e-d6a877dc23d3@oss.qualcomm.com>
 <d38801bc77ad00442b1669ea252ae30a5c6af5b4@postmarketos.org>
 <7661d9d9-eca3-4708-8162-960df0d7f6c7@oss.qualcomm.com>
 <ad721948b83a54eaa34f367e12564fe6acc222a1@postmarketos.org>
 <gfbvgsen75w5h7afyo454pvdfslkeprqyuycuok6syinbza7vx@crapzdo33re7>
X-Migadu-Flow: FLOW_OUT

October 3, 2025 at 5:13 PM, "Dmitry Baryshkov" <dmitry.baryshkov@oss.qual=
comm.com mailto:dmitry.baryshkov@oss.qualcomm.com?to=3D%22Dmitry%20Barysh=
kov%22%20%3Cdmitry.baryshkov%40oss.qualcomm.com%3E > wrote:



> Regarding the MDSS. Is it being solved by adding reset to the MDSS node=
?
> Or are there any other issues?

Yes I'm referring to the reset / pmdomain issue. Joel Selvaraj is looking=
 into it in the sdm845 tree. He said he tried doing what other SOCs did a=
nd it just got stuck in a reboot loop. More investigation required. Curre=
ntly he's reverted the pmdomain commits in our tree.

