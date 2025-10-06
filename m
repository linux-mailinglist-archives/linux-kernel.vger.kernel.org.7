Return-Path: <linux-kernel+bounces-842757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E04BBD7B1
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6170F3B6EF2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55511FAC4B;
	Mon,  6 Oct 2025 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="a5mSsHUA"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537C1F4E34
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743879; cv=none; b=GWLpxQ/euc8O8SMuxFVW1HWYij7cHJitPDrMa6iYZGNYyKFpJZoplgWC0ppXKv5wuazGf0l+2v44c25ibUnhicyU8SephnYlNFSJQHs7+iutTB5puaNS28zYMOu9+HmeRJYlzvw54w5dP/GyxDzxixqdlDxlOys/BHDJMsx4B34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743879; c=relaxed/simple;
	bh=MvXtf65bnEuClKbWJkEN8SYPRB0VB5jdN4kz//IO70M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mrfDSBwu69nKB1LFWTQFN4xQq5Ua0zSqenlLtLEj7UEcC44dzW//OllOjutjwaiCAWdYQvlmhSedRT87XUc6Pj0t7BGPZxNL5PQ0tJ0vibD2catyWiijU3vtA0TQD+23nIgbHn/Z0N7dzg+CpBahcmaRZFRe4iuBBLcrGTVMFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=a5mSsHUA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so3287623f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 02:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759743875; x=1760348675; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CcE947gZ6W0sbf7VvCWTggrTIyTkHIFkzfAcLajFas=;
        b=a5mSsHUAfVXrAdz0NQmYHe8SrWX+c5qkCcozMg1TZewplpKuSVHgqnpz3CQBpubum6
         fIe1TSccmcNGZByoXPdJbXaFvIKCsWONbGlGk5rE+33z/vhCmhhGmRcKuWLuACrOCPLz
         8aY6Ye3R4Q59TzNYc/ffc2KL1fXNAbDFVQkP/46Bz5xiWSV4pNYi2tHwEphe+hfGzIUD
         NkAkl0MzJdvqdhuwdIOdi3E0XVtVCX5PQNYWa6Tuiy6Hb7sSbHiirar45gAVI84FTynG
         aIb2eOpwr9qEqDwA8rfBtytXraBewejQewHp3cXaAZSFCnTfxF7k9deYJv99OSQL6mb2
         ickg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759743875; x=1760348675;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7CcE947gZ6W0sbf7VvCWTggrTIyTkHIFkzfAcLajFas=;
        b=ZylI6OPt03efZT/8qLwDdw/BK+Y2NFlXTaKmH777Tg5QLl52B1sb9s1a2NUOlHNXWL
         ggYoy02jzGHIp+H/cJW7kKMK/et7N3WdrffVboOkmhJcBIXzin/vk9noN2T35UGcm9in
         Aw41JekpCkKTrJllGJ2Xh3rU6UFnSfUJ87JKjzFSkahDiXAC7209iAY5/wQ0F9Vw6wcS
         VyRpPqtQAFpzD4HstwadPZXb5OHB+ZF5X5M3Cczx76OAP03teffQcca9OpHtO64ZmGpA
         viY0/pM4TxImQgKXGCd4HqDWFWOTsEKKzz7XE8V6MCTgO69arugpRQRyQw3jQNY8xmam
         aI+g==
X-Forwarded-Encrypted: i=1; AJvYcCWzBO+3r/Cdxxz7V8FPO2VapwHftq0fI5c0CYHJJbOUjqGAF4sJJnZ36y4fvYf2+T3M6IozS3EdD5Bzwx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ci6gJQUOjkzxy/ABxI57TbdI0BKFXP8F0y/XQ1IXHV7qSary
	1nXAwFRHOTFAr4naPcJsYqI4MZcKslQxzvD7NjmR1UloT3RwAXmYdBn0b7w6Ry2GoIw=
X-Gm-Gg: ASbGnctW5+u4J8T7alQz1AjBH6x5pRLqGXiB0nyR7rbjlzXFvAujuoFmUy0sBkKnmAp
	0m1saDS3IrMiJwAuN+4oCQbHQ+jry0Vuy4O1nTKZ5FqRsL81Ri1Er+pHYHXajo2rCqZe8h8YY4N
	nKc5AGRm5yFq+rkYLnf35KIagm3O2rVi0mZQpzO2RFl+Y9+7J191kdrp+xPLA5i6bPsp/Clv/mi
	BeDOwwhTj50up+FBY1M6gBZQ+8vXUSiNOWiXSF6o9dlUZnWu6EvfbKUDxzEZX5yd5IT0h7UDDSR
	etVy9MigATyr25uRerjzDNsC64qWStW9vQXH29ljGGlUf8rofGydYUKhNeTMpqyXIgaAmwRreKS
	2pCA+Z8wgHw2mTZDZUkMj+kDr++FVWEvTQSWt9FmZ+ED1rUqyn1h1JRk6C9OoHoFdk7VWe4zLqs
	IICY0qm75djNw=
X-Google-Smtp-Source: AGHT+IH9WtXT37tlC5B2tzxDbJy1Vvge3ED9gBQtVklsT4u+uNG3AW/fSGCPppGvpB9zN4GOAz+5Sw==
X-Received: by 2002:a5d:588e:0:b0:3ec:d7c4:25d5 with SMTP id ffacd0b85a97d-425671b27c6mr6490559f8f.50.1759743875402;
        Mon, 06 Oct 2025 02:44:35 -0700 (PDT)
Received: from localhost (pekko.lucaweiss.eu. [5.180.148.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c4dd9e4sm137604575e9.10.2025.10.06.02.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 02:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Oct 2025 11:44:33 +0200
Message-Id: <DDB553DRF89P.15C4AKUO7IQXH@fairphone.com>
Cc: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add UW cam
 actuator
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Griffin
 Kroah-Hartman" <griffin.kroah@fairphone.com>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <devicetree@vger.kernel.org>, "Daniel Scally" <djrscally@gmail.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>,
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com>
 <20251002-dw9800-driver-v1-4-c305328e44f0@fairphone.com>
 <dfc093a1-e13b-4342-9015-5a896bf18d5a@oss.qualcomm.com>
In-Reply-To: <dfc093a1-e13b-4342-9015-5a896bf18d5a@oss.qualcomm.com>

Hi Konrad,

On Mon Oct 6, 2025 at 11:20 AM CEST, Konrad Dybcio wrote:
> On 10/2/25 12:15 PM, Griffin Kroah-Hartman wrote:
>> Add a node for the Dongwoon DW9800K actuator, used for focus of the
>> ultra-wide camera sensor.
>>=20
>> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/a=
rm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> index 2dd2c452592aa6b0ac826f19eb9cb1a8b90cee47..0e86cd5ff527925c7dba15c4=
e0ee5fc409fe4ce6 100644
>> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> @@ -627,6 +627,15 @@ eeprom@50 {
>>  };
>> =20
>>  &cci0_i2c1 {
>> +	camera_imx858_dw9800k: actuator@e {
>> +		compatible =3D "dongwoon,dw9800k";
>> +		reg =3D <0x0e>;
>> +		vdd-supply =3D <&vreg_afvdd_2p8>;
>> +
>> +		dongwoon,sac-mode =3D <1>;
>
> This property exists, but isn't documented (you need to extend the bindin=
gs)

Please see the patchset this one depends on, which adds dt-bindings and
adds prerequisite driver support:

https://lore.kernel.org/lkml/20250920-dw9719-v2-1-028cdaa156e5@apitzsch.eu/

Regards
Luca

>
>> +		dongwoon,vcm-prescale =3D <16>;
>
> This property is neither documented, nor consumed by the driver (it may
> or may not matter to you, check against what your presumably-BSP driver
> does with it)
>
> Konrad


