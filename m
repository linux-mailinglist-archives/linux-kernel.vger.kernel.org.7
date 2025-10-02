Return-Path: <linux-kernel+bounces-839868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 123AEBB29BF
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 855EF7B42EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC892882A5;
	Thu,  2 Oct 2025 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="pgSzICoO"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9DC287518
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385588; cv=none; b=Mt4aUfHjXRuzoLbNLuxeUOmLeFshQRALyDL+tObzF6lWCyKBlPGJF1+0LRUoELBkA1DRXIZ7BCzxwwH/mMwF5gEA39dhtZzp5SOMbNBMXOedeqh13SrD7bTpTSFBc7AAXcShvWlzLhgt8OBtTC2nhSLHJnrg1VIVAAE/Op/YZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385588; c=relaxed/simple;
	bh=Yb5IJl03lyAhlMMtcN0Ru3b8yvlth20KMRIlGSafBX0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=AEps5NPCEE+eXku3Bf8su2b1zc3FewD1VozoZcee8Q5aTMgezEKpDEK4aDLXPiHggZmyUJ0rwZUVpOj00OspksAr8B2VMK67rt6rJyZtrQGkjsIMS1z4deyL/8rNPaCpxSG7dZbze3enTW032wN2D8W58pLanyhp2RtF0f3GUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=pgSzICoO; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1759385574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iY6dSdFtvP4gk9U5DxF31u6nBgI6+sMVcJp1XVaww8A=;
	b=pgSzICoO5ZoyW5sWDGTFFyOHoQOZlHQk4bQ9dtx78I2TBRU5ahqLkI3CqGYKDWorgEhr2B
	xHr3vBxiQOWLiRqLnrjYAtILGqXF0zYiF2VV22m8Eee1BDxSPTt+lobjjvj7FBpwOOOp6X
	r8PmQ6xCSygu1GdO5lF5hd+GsiZELrHqDCFujTc7wCljhQxsjm8tz9wJl4XkNqSaOinSbb
	KZlUoZuTC6awAfY1fe5bnzpnUuBAxcR8KUOGaKRY/0vruJqlYneS3L/LMxjfQ68FoIhNX+
	P3fbcuZiPW0fhOkshpDvsecBO9QJpYivUJ3oeZfGiqBVtPJV9KvTIUEzTqeU0g==
Date: Thu, 02 Oct 2025 06:12:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Paul Sajna" <sajattack@postmarketos.org>
Message-ID: <49c74c76921245478a158ba872da529b96682d96@postmarketos.org>
TLS-Required: No
Subject: Re: [PATCH v3 00/11] arm64: dts: qcom: sdm845-lg-{common, judyln}:
 Improve HW support in dts
To: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof 
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "David Heidelberg" <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, "Amir Dahan"
 <system64fumo@protonmail.com>, "Christopher Brown"
 <crispybrown@gmail.com>
In-Reply-To: <b8817a128ca13b8bcc3a90fa114d916292183729@postmarketos.org>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <b8817a128ca13b8bcc3a90fa114d916292183729@postmarketos.org>
X-Migadu-Flow: FLOW_OUT

October 2, 2025 at 5:25 AM, "Paul Sajna" <sajattack@postmarketos.org mail=
to:sajattack@postmarketos.org?to=3D%22Paul%20Sajna%22%20%3Csajattack%40po=
stmarketos.org%3E > wrote:


>=20
>=20September 29, 2025 at 5:05 AM, "Paul Sajna" <sajattack@postmarketos.o=
rg mailto:sajattack@postmarketos.org?to=3D%22Paul%20Sajna%22%20%3Csajatta=
ck%40postmarketos.org%3E > wrote:
>=20
>=20>=20
>=20> Changes in v3:
> >  - remove msm ids
> >=20
>=20I'm noticing now that this breaks wifi because the msm ids are used t=
o identify the firmware
>=20
>=20>=20
>=20> ath10k_snoc 18800000.wifi: failed to fetch board data for bus=3Dsno=
c,qmi-board-id=3D0,qmi-chip-id=3D0,variant=3Dlg_judyln from ath10k/WCN399=
0/hw1.0/board-2.bin
> >=20
>=20What are your thoughts on this?
>
Nevermind, the board id and chip id are correctly identified when the hos=
t-cap-skip-quirk exists
https://lkml.org/lkml/2020/9/17/133

