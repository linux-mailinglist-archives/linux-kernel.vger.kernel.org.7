Return-Path: <linux-kernel+bounces-721174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E8AFC5B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AAD18861F6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD202BE02C;
	Tue,  8 Jul 2025 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="hfeHRS9d"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90674299AAA
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963500; cv=none; b=PcwMKs1QMmThstP1C7QUVik7wrvkXMMMBxyr0HKr2eGLaiSRkNADWtHKNUoVByXbWLEqu6uotQH1S9aETnOfn0mmd/Kek1UtctykVCtetKb8zl8gVQZRzddXDNQlH4Zjz2gshSHyNU8c+BMccuZ9gyhIdWASpuI0WcjMgyOG0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963500; c=relaxed/simple;
	bh=K3aWinX3PVP5Yiw5FQcueQIu4e5wbM0J5reriCTyZ+o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OfL88P2h42kPeIVRy5C8GDsjTSwv/44xjH9g2R7+GK5AGzvxnNqoHjA54258/QjyJx3uBynLC3EP4WCC2KQVBg2zpAnC2h+i+SrzGr+P54TyZ99rbbeD30ElZVM3daLyT/KAfLRQ7d+CGZ1tcCo4mBUXltv6Rw7/Mn1RXVoeyFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=hfeHRS9d; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so6745500a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 01:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1751963496; x=1752568296; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbTxGbzVn5eaG424GOYCdjKTORbkvUlYm6kHb9cg2Nc=;
        b=hfeHRS9dK9JfXpGVTfJ/jpmzUIVAlVCFao0McWDCEeiincK6aPJK3W3LW4ysxYmDZc
         DL6iGUeJh48HCFckeLUIb5GqFrM02A/EPJF8fsC8yKouxTSFvTdaQi5YZ6N94MHbRmnK
         ksjLMuyXURlxQvomm0dyyRvLDityalJU2IgRugf47m/vaF4hfhDdAmIOu1wYqBO+wT4z
         NIeNlXdmeBY7p95Dk9f4DEEIpEZ2jRq5vNYhwBZsNLadYI1nLjEUbDYoquWI5XPi796H
         R3MbMClpgzoiiy7BQZ33vuW0lbQN5YTIOCrWrZBaP7/vCjvxr/w+dF3Cy/n8R+Ny7bPu
         MONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751963496; x=1752568296;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SbTxGbzVn5eaG424GOYCdjKTORbkvUlYm6kHb9cg2Nc=;
        b=ThXLYa2W0+FxCzZq8axFSUejIdyvfewo/Y/XJG4ueXNlddlp223DMYudeEWoQduhGx
         6+9XFCEwgf8nGCKDrpecJuhOUxPBlvct3sN36nXXFpQrMJefK72lvU76Wu0414GlCn49
         Lei7db6yFE1KQn+W8O9ZU7ouRLq5K8W+lrrfBL3fHKGFGWEggSjhvwdSGyrOVsBD7GH3
         3YvUAbzMbgngC/HTPVWXQxEk8XXgxi/qoK+/2f569+0CwRJioOoqWAjvrzvF1g1KEs3r
         c7xZYPQacsYGC4xDeHcjm7z2GDnmhx6CSJlqChDiUfX/p4MU5PHbCejtATkwQtzK9EV9
         n5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVY3wifs87KWVTj3gALFfwdt3hTFr5jMrm6E3YyEUU+WM1r/Kig1oLFIC4Px3ccX0aGNZ4WkhMRXOYRsmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Yv6stVJ7ttcY/evggZyS5eC125Ow0gydygvZWjFJBIx0giUm
	mkbEUGnkyamRfUlUfVu9CCDobzy5Upwd9vHQWMXDYpHPPwbo8cTbkQnwziyiknR7zAI=
X-Gm-Gg: ASbGncstee+/P/KvLWr5718hAcgL1MucDTg+NFktkBwdea+6RXrwD18i37Ig0XbhpQ6
	8+PgV4UYDtE5Y4ePHgYShd1b+LHCEE6XR1KMxvca0EBBGI/ICur6GkvKc6JhEZO6UlqWrtRJGc7
	PylY/mG7ECx4uc3txheHBvXwtFuO6zNjz4IdyMO6Ek4VPsek0dxOj6whrFWfZtLeqa+Yk0WClvJ
	ccpI+1GdSwWiZp4GhgM4pTXYyhDbt1AqKxWYJQWz4KZ9olVVwEzvsBwmyV7L96hSlNzUNkQPveJ
	NM1qWDX5PQA5pvrZu/zwO0ChzwDZfmshVlpQBgCWEkCT2rGclpPqPHPU+ooviL4Jdo+bvXGGqj9
	JOg+YcYkNIDD+4aQk12y0DIz3DSrc4E8=
X-Google-Smtp-Source: AGHT+IEm2XH/j6x08TGpkx5iGujBffEeCcav0ZoSdLi8Q5WO8Z9zekT2MKuOG8WCqq09Q57awzXAMw==
X-Received: by 2002:a17:907:6d22:b0:ade:6e3:7c4 with SMTP id a640c23a62f3a-ae6b058b82bmr218443366b.23.1751963495784;
        Tue, 08 Jul 2025 01:31:35 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b5e785sm840185766b.155.2025.07.08.01.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 01:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 10:31:35 +0200
Message-Id: <DB6J86NHFTNT.31MFYDTZ6B4O0@fairphone.com>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Kishon Vijay Abraham I"
 <kishon@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Abel Vesa"
 <abel.vesa@linaro.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: phy: qcom,snps-eusb2-repeater:
 Document qcom,tune-res-fsdif
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250625-sm7635-eusb-repeater-v1-0-19d85541eb4c@fairphone.com>
 <20250625-sm7635-eusb-repeater-v1-1-19d85541eb4c@fairphone.com>
 <20250708-unicorn-of-ancient-excellence-e8945c@krzk-bin>
 <20250708-stoic-slim-bison-ac55ee@krzk-bin>
In-Reply-To: <20250708-stoic-slim-bison-ac55ee@krzk-bin>

On Tue Jul 8, 2025 at 10:21 AM CEST, Krzysztof Kozlowski wrote:
> On Tue, Jul 08, 2025 at 10:13:24AM +0200, Krzysztof Kozlowski wrote:
>> On Wed, Jun 25, 2025 at 11:14:56AM +0200, Luca Weiss wrote:
>> > Document the FS Differential TX Output Resistance Tuning value found o=
n
>> > the eUSB2 repeater on Qualcomm PMICs.
>> >=20
>> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> > ---
>> >  Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml |=
 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >=20
>> > diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-rep=
eater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater=
.yaml
>> > index 27f064a71c9fb8cb60e8333fb285f0510a4af94f..6bfd11657e299273599806=
3b3ca390e04a03930d 100644
>> > --- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.y=
aml
>> > +++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.y=
aml
>> > @@ -52,6 +52,12 @@ properties:
>> >      minimum: 0
>> >      maximum: 7
>> > =20
>> > +  qcom,tune-res-fsdif:
>> > +    $ref: /schemas/types.yaml#/definitions/uint8
>> > +    description: FS Differential TX Output Resistance Tuning
>>=20
>> Resistance is in Ohms, tuning could be in dB, so I wonder what are the
>> actual units here. Neither commit msg nor this description helps me to
>> understand that.
>
> I checked and the values are in Ohms.

Yes it's Ohms but not 0x00 =3D 0 ohms, and it's also an offset in ohms
from the nominal value according to the Hardware Register Description I
have, e.g. 0x7 =3D -12.1ohm from the default

I can try and create bindings using these Ohm offset values, I didn't
worry about it too much since the other tuning values in these bindings
are also just register values, presumably from before Konrad had access
to the docs.

Regards
Luca

>
> Best regards,
> Krzysztof


