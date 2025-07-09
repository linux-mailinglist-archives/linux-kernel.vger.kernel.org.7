Return-Path: <linux-kernel+bounces-723538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E61AFE83A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7425D56551D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2D2D662C;
	Wed,  9 Jul 2025 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="N6Qx6lO2"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71357277C82
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061732; cv=none; b=kWF235YCLScpZSC5KWze0nwK/I4UxSB6Elibl/q8BbLXs1TIxat1lVm0U/bRz9z5V1ojf69wNLI1epPkhyzFSxgo266nkNUd8TBrRVhtA+kk8g+gyreu8a5IFfGygEEIdt/E/YkkM+MUgc3WZq7x8k6x1oZraPCHA6FhrLnKDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061732; c=relaxed/simple;
	bh=LuFaLCJ0xTPoiWwHiRW6DMu6C4be3/3wdgnHwU5aw20=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Z/J3WnkG+zx+WRoxg8sQ75B4ax0i82OZJ1v75mwLc1lBKUJg/ajFWjU5RcJxTMTVCrlfFsPtrz5AqrEgOuynGgvLkwTEg8eAPnUcoHfdob9U5tUnajBFZuonSFuhdT2j8vf6Ss755k1qBToFRcjMSwb5BcVTc/74zOwKvgwDiTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=N6Qx6lO2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae223591067so909756666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752061729; x=1752666529; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7251uwJfwlSq32A9Vp2rgzafVtiNna6bej3YLziW0U=;
        b=N6Qx6lO2URXqxTheYpr0pbnhSDFAlFwTG/3+A0UDlh+TWi08qhFU7NLS4kHfJ5RkLc
         fqRyFyyn0x4JezJj6FOUIThCMs/mSSa7+IVNYFO/dejS4h+iFB2f2euXiN/jJpJ77mDJ
         n79c+jZGUU/mH7KnKAt/sJ/XW/eY6e616pUK+Y4m1F1gtljFQ5wsFy8r/JSUe8uaWx9l
         apeqCUr1j11/vrv543D2c5eUWITRibL2488RJCAlN7r23isPhIPVIYdUL1nT4sDtmqAE
         sne5ox5AjQzs9q3iDVt6MwYHfzlloI9WirB08iqZ5SMWr7qTg+hFeNWd3YcppJ8vH7Jn
         FhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752061729; x=1752666529;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R7251uwJfwlSq32A9Vp2rgzafVtiNna6bej3YLziW0U=;
        b=aqigttXJ3N4dIxcpNE7og0p8bmGsmfGC8IaD64WrVuWgyFtyVMSkrVwfuhBrIKnTGZ
         2hto5elmt/KVD6T2eJfZKYiBCc261LGvuAL01CrKPxmX1cA73N9r3uWWq4a2nZwbqWSE
         SY0ceWYJzTMEMXVU81pyCgfwCAEvNfW4abva3O3NtF/iBbzYFt87p6FRQFxd3Jl6R6Xc
         356elEjEXZj99PuGSTfU1agVa1Ttx0gCOj8WpnRrBIt7f4Vi1wBLO5qoqUVDQMVMEqmh
         QCIP6/PJLwGY1vXVTgZj0rbCeihPmomkfe1kB7s29k6XN8xoBqGJ5KGAt5tetp3mdgg7
         sJXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdEikAluzkX9XdbvVtf278JE2TnmnYuGbKyidcXPwjtOPvAVWWDi5lSLkErvMQ8RU5eHW0IGFdp5Mr7Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTFIvSY1C4ucLgISmwmpv7qCThukT95mcWBPBQM3dbASgYbTL
	cSdz+RlPhRs56ExIiKFxNwER39H904EROMiVAdEsZO+/XcZJiGnsXxcg308JJ0SP5jc=
X-Gm-Gg: ASbGncsJH0K3FRKKo83YlpLQbPyJQa9eOt1qGqjYaJzxWZI6C1N9yum6Ghv+Sodm1Ol
	fOgzL+x3HWJ+xzqe+d/okO2Po26tDV7/7aHsgEVqv1Uh5Hkc9IUkf0rb9eYf51bsWupX3CE1Lji
	7Nb+72Cc73SWgYun+XIwNyejrD2ixuOyma3uNwjMC+QvAS6lbzxaYKEmSYvwVetjcJ2CTCyUIFp
	h7gOeyZCa9EDLPkeCeYAw8PBxWbtAiXwcefltNbHS2/jBw6kkU9cbzh/8xgcb3r8UjjxfEgFG0A
	p+0tdxgrE94pbsvj+pqEkFpEfOuGLrseVOS87XDR/CufEBc6JBOanRPhSwW8Y8a9CfKhW2j2Gw4
	ir59GimAGEvYX7WqUVf1Q47j9t84heWw=
X-Google-Smtp-Source: AGHT+IFHTk7KUMsYqkCmoCKYDOQn2JjjlDGYad8nB1UbcgqlsPnK+ZRxIkDwhxTp1MQMCfkMx5xzIg==
X-Received: by 2002:a17:907:f816:b0:ae0:a88e:6f20 with SMTP id a640c23a62f3a-ae6cf5b81dcmr253307366b.15.1752061728625;
        Wed, 09 Jul 2025 04:48:48 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac5feasm1091150266b.107.2025.07.09.04.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 04:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 13:48:48 +0200
Message-Id: <DB7I1Q9TD02L.2A18QMRU7VXHD@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Taniya Das"
 <quic_tdas@quicinc.com>, "Ajit Pandey" <quic_ajipan@quicinc.com>, "Imran
 Shaik" <quic_imrashai@quicinc.com>
Subject: Re: [PATCH v2 01/11] clk: qcom: common: Add support to register rcg
 dfs in qcom_cc_really_probe
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Jagadeesh Kona" <quic_jkona@quicinc.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250704-sm7635-clocks-v2-0-9e47a7c0d47f@fairphone.com>
 <20250704-sm7635-clocks-v2-1-9e47a7c0d47f@fairphone.com>
 <64e27035-d124-470a-bc5b-66d254b6ff4f@quicinc.com>
In-Reply-To: <64e27035-d124-470a-bc5b-66d254b6ff4f@quicinc.com>

Hi Jagadeesh,

On Tue Jul 8, 2025 at 7:34 AM CEST, Jagadeesh Kona wrote:
>
>
> On 7/4/2025 12:46 PM, Luca Weiss wrote:
>> Add support to register the rcg dfs in qcom_cc_really_probe(). This
>> allows users to move the call from the probe function to static
>> properties.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  drivers/clk/qcom/common.c | 8 ++++++++
>>  drivers/clk/qcom/common.h | 2 ++
>>  2 files changed, 10 insertions(+)
>>=20
>> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
>> index b3838d885db25f183979576e5c685c07dc6a7049..d53f290c6121f31d06cf244f=
72603b694966e216 100644
>> --- a/drivers/clk/qcom/common.c
>> +++ b/drivers/clk/qcom/common.c
>> @@ -390,6 +390,14 @@ int qcom_cc_really_probe(struct device *dev,
>>  			goto put_rpm;
>>  	}
>> =20
>> +	if (desc->dfs_rcgs && desc->num_dfs_rcgs) {
>> +		ret =3D qcom_cc_register_rcg_dfs(regmap,
>> +					       desc->dfs_rcgs,
>> +					       desc->num_dfs_rcgs);
>> +		if (ret)
>> +			goto put_rpm;
>> +	}
>> +
>>  	cc->rclks =3D rclks;
>>  	cc->num_rclks =3D num_clks;
>> =20
>> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
>> index 0f4b2d40c65cf94de694226f63ca30f4181d0ce5..dbe7ebe5b8710fb03c1671ac=
9022e608a6aad35f 100644
>> --- a/drivers/clk/qcom/common.h
>> +++ b/drivers/clk/qcom/common.h
>> @@ -43,6 +43,8 @@ struct qcom_cc_desc {
>>  	size_t num_gdscs;
>>  	struct clk_hw **clk_hws;
>>  	size_t num_clk_hws;
>> +	const struct clk_rcg_dfs_data *dfs_rcgs;
>> +	size_t num_dfs_rcgs;
>
> Since all other probe configurations are added in qcom_cc_driver_data str=
uct, it is better to
> add rcg dfs data also to qcom_cc_driver_data struct instead of qcom_cc_de=
sc.

Dmitry suggested to use struct qcom_cc_desc:
https://lore.kernel.org/linux-arm-msm/w4eujq72uqflqpsqshc7zhu6lkc7owufep2g2=
rjacvzgj44vmf@auonp4ugbgow/

I personally don't have a preference.

Regards
Luca

>
> Thanks,
> Jagadeesh
>
>>  	const struct qcom_icc_hws_data *icc_hws;
>>  	size_t num_icc_hws;
>>  	unsigned int icc_first_node_id;
>>=20


