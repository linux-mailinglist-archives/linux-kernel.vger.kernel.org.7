Return-Path: <linux-kernel+bounces-749181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA56FB14B12
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B773B60EE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770372673B9;
	Tue, 29 Jul 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="EFcSmrnQ"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00D22538F;
	Tue, 29 Jul 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780821; cv=none; b=qqFlGYYGS5dCIOmboXg2RmMjamKpbpJlBEx0a+V0d2Wmv/9p+eBQ4ujnREB7JUKioz/7K8HCYbiwMToxFO5xC4Oxvqto7dxEPPVToYmu5j5Td3O/v9kAyclyIZf6tG3ZCZha49nusk3VRgw5JeMg4CHd/skKW1Wh9elhk8DcbFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780821; c=relaxed/simple;
	bh=SL47x8RSPgb9O9GPSLVDnHkRq6js7JXYM272pZ+IYJ4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=IH9OZzIoQlfFNTDCP7F4+g6jWyEbGM9s7m+NE5w0dy8ZRBrcNVqQeM4OfXX5APbEnVQgXZ1bRcbLZ2uIwlcyJT6jycrIoCoX1NR1UEazidpfsqZpKtmSxK5D4GGq4j8KLXVM4vJuOqPwxZECBPlJZrVMNQMyBCUZ8jIL9aEsCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=EFcSmrnQ; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753780813;
	bh=SL47x8RSPgb9O9GPSLVDnHkRq6js7JXYM272pZ+IYJ4=;
	h=From:Subject:Date:References:Cc:In-Reply-To:To:From;
	b=EFcSmrnQQ8ni8XA9Or5AqCO4mhm5tLNtScnVIinhQinQ1XeA23f2/+eyTbEe1U0zO
	 fTBXZqqfAfaIofhZnpPu2L8zkC5Oql8rxLJMgtbNqvmn6AZRey5ipVsIaIkxmTxSWX
	 htcc33V1Hv51luA9appWghQ35Jj5d9GiExox+S8CKh501JJDfKuhjYq4+kgtAIHYec
	 fSL0GeLljntcRhfnx4iAG4ATtjAFkKZKlnXuHa0slY7Y2If4AUf2q9p28fcQ85vOrE
	 aUyLf9k5r3cwBgDlaoy5PoXbcrcFKFTVfqbjyBjvsJptI8cMMB54g+mbYbmgY80fcS
	 nuJtonwhT7IGg==
Received: from smtpclient.apple (unknown [IPv6:2600:4040:50b7:b604:2ca9:1ceb:f1ef:b736])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 4C83B27E434;
	Tue, 29 Jul 2025 09:20:13 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Erik Beck <xunil@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5 0/2] Add Support for LinkStar H68K board: ARM64 and RK3568: dts and dt-bindings.
Date: Tue, 29 Jul 2025 05:20:02 -0400
Message-Id: <1283435E-EC3D-492E-8369-E51CBFE5E636@tahomasoft.com>
References: <20250729-poised-proud-ibex-5ab838@kuoka>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250729-poised-proud-ibex-5ab838@kuoka>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: iPhone Mail (22F76)



> On Jul 29, 2025, at 04:56, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Jul 28, 2025 at 11:07:35AM -0400, Erik Beck wrote:
> v5:
>>  - Responsive to comments received from  Krzysztof Kozlowski <krzk+dt@ker=
nel.org>
>>    - https://lore.kernel.org/all/20250728-dashing-discerning-roadrunner-b=
c8b87@kuoka/
>>    - https://lore.kernel.org/all/93c39b36-07c8-4883-bd23-7d0194c50a7a@ker=
nel.org/
>>    - https://lore.kernel.org/all/642df1ee-5e92-4f0a-bcdf-7e10dbc0d59b@ker=
nel.org/
>>    - https://lore.kernel.org/all/9ebd9797-8d92-4799-bb8d-59a796e6043c@lin=
aro.org/
>>=20
>>  - Changes made are:
>>    - Revisions to commit messages:
>>        - Removed notes on base commit;
>>    - Fixed checkpatch warning;
>>    - Removed notes on device history;
>>    - Fleshed out the top-line summary of the dts patch;
>=20
> You did more - also changed order of patches.


Oops, sorry about that; I struggled a bit with b4.

Which order do you prefer?

Thanks,

Erik


>=20
> Best regards,
> Krzysztof
>=20

