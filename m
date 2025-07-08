Return-Path: <linux-kernel+bounces-721546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CE9AFCAAA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AF2484FF9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D82DC352;
	Tue,  8 Jul 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="dWXqJbYT"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7D2DCBF5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978545; cv=none; b=n8lUZKDNdjnwL0gqSfKhBv0pzFrZuZFnDkcKQ8sJQJiL3l/tAzIFOSBEVDyYBAbCUNtInZ86WdbH8crx83nD1pINf6UwpY0Ba3jBT94p+5yRGPtchWsF/rf/UIEGMTsc8UAZ6V0dQqw0FeVW+QXG+UVcbUj1hWa3j4S3noLa3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978545; c=relaxed/simple;
	bh=OMUTx42+lxnfbmDa4w9KRyTNqE2cIBR6M9QVHF4w1fI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kqzw85Rc531waD8bY02lRpcK7Jybz+6arYxI1DTODs2o5tlsS9rX7l+eWjgo73pi1yh2IvFEGf7yY0ETvpUOwKnl6xLQjncEBHd6tMtE1xtipLeFjvavie2IT4SNH2YovHEHwUiBYouvU1uhDaVnhW0RVoP2muJ5YAWLOrw+Lv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=dWXqJbYT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so8623472a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1751978541; x=1752583341; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krWI5dKupRfQc3/61VnzeAoMeO2jYhgWh27WUPDNkkI=;
        b=dWXqJbYT4l0gvL7r8Bk7j3OlqbHVe7abqQS/crSvNpbKx0hQJa7XCbzm9vh1a6ouoN
         65coz8Ejmlkd9cB/NUD6Oh6zz0aMNJ3NBFpTlgfWL2WG4RIZIX4w8e2GHfIX8+Dc9b9g
         ZWzc+Vgi6AEn2o5N0LAFDJf3NtjRKjqUhcKdQt/pJNT3vfNeGrPo4yO7lguh0UGxPV/9
         kXags8eDsrnf07OBD4OG008qKpk29DcGjytFo6HJLeVycrbINXC1a6X/jHxxTyGsRzpG
         x57ln0NusPENSiDS5ElopQv6s5pNRZMw3Mea0PUA27J69fDkFMGkSXroci04BU2JUUXq
         53pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751978541; x=1752583341;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=krWI5dKupRfQc3/61VnzeAoMeO2jYhgWh27WUPDNkkI=;
        b=u+rN9Pf0o53OXHgfd1PaTrCcKTHXKBndv3MiMaEWEzFmwd75kZao337TmIrIAtOXBO
         xnwIhF6lg0Z4AS6enDmfxrD8BGvI6eiOtgnNfl7KVWD8yx8MuYM29isLNGaoYleuxceF
         d7rM0XFBh7CkFWS68PeFAS3qVuzvuEYOWpJviubg7dM/QGKauuoVjktMEqG4ZwTXRUSy
         S6cm0cD9QxIO1BCJs9nNdxrrMDWSQx5wD5HLIuGHut532I3610ebm9y/qgAR/yXr7OY5
         nN0qRSPBAgUluwjkT6+R3352V0hMLwB75l5sL1EjOEkInoNAcdV54wBCt/GwEPGAyEr8
         OQGw==
X-Forwarded-Encrypted: i=1; AJvYcCWcp7Ku0ptOmcZrpzS95Vo4kGuqdqpzEQjwNhRcMuSj13LcZ70uq1qH2cbgKCbwJqtAM7QCVA/uBcPfqLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18c6H/1cjkVwFSt0JWPTfAcLYVMTGy/ULp89mtpQ/JFN/DmIA
	3+YIn8X5bwK/o25vDNtDygBZcUbWyW8juTrjUa/K9UgUapaOrbEXoRUkduXuvvBOG2E=
X-Gm-Gg: ASbGnctSu+spk6d5ZQ0BwQiMzVl2dW1JH+PrsqT+ruM3qBPlrrTNh7jXHRr6hw/iKxr
	Yzxp/5KPS9CSR3t08irWIhSbVpMOpaUgr/LABFOX51i9Z2SmifawOlzfAIn6voOl7GijnZMgFkI
	RNJmcM1ladtPbygLGYMyk4zvleOtCVE2m4e4PLYYKSJzno4qNqXLufSKMqzqZx4NHyDenr5OSLH
	aa8wAvIYoobIKRkHJTj+KOycjZRMCb1eqa8+FZVRGK7KU8elqy/wp9VdfNcqF3xBwHJuZ6NA1kN
	fPBWS8vbXL+COL3jCSFQVp0ye1YiVdfsWYCDj+RahLgS6pPHQOGAtRVeTGTIPaEpbtlFWCBhD6r
	f6eHEurv83SGwDPCMqTWgqwZA764FNlg=
X-Google-Smtp-Source: AGHT+IF8+quXXledQG534WGGLgZTN7F2C1w8IIy/x0D8Dajv4m6QB5Hjruw4R2tZAmvqG+s4Kctcmg==
X-Received: by 2002:a17:907:3f0a:b0:ad8:91e4:a931 with SMTP id a640c23a62f3a-ae6b2b34160mr265150966b.26.1751978540601;
        Tue, 08 Jul 2025 05:42:20 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6949cb2sm889858666b.67.2025.07.08.05.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 05:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 14:42:19 +0200
Message-Id: <DB6OK61BL9ZS.31XB5TN5YTX62@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add Milos interconnect
 provider driver
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Georgi Djakov"
 <djakov@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250708-sm7635-icc-v2-0-e158dbadb29c@fairphone.com>
 <20250708-sm7635-icc-v2-2-e158dbadb29c@fairphone.com>
 <0a09fbc8-8835-4e94-862b-0baaea5ee251@oss.qualcomm.com>
In-Reply-To: <0a09fbc8-8835-4e94-862b-0baaea5ee251@oss.qualcomm.com>

On Tue Jul 8, 2025 at 1:30 PM CEST, Konrad Dybcio wrote:
> On 7/8/25 12:20 PM, Luca Weiss wrote:
>> Add driver for the Qualcomm interconnect buses found in Milos based
>> platforms. The topology consists of several NoCs that are controlled by
>> a remote processor that collects the aggregated bandwidth for each
>> master-slave pairs.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>
> [...]
>
>> +static struct qcom_icc_bcm * const aggre1_noc_bcms[] =3D {
>> +};
>
> You can remove the empty bcm arrays and .(num_)bcms assignments
> for them

Sure!

>
> [...]
>
>> +static const struct of_device_id qnoc_of_match[] =3D {
>> +	{ .compatible =3D "qcom,milos-aggre1-noc", .data =3D &milos_aggre1_noc=
},
>> +	{ .compatible =3D "qcom,milos-aggre2-noc", .data =3D &milos_aggre2_noc=
},
>> +	{ .compatible =3D "qcom,milos-clk-virt", .data =3D &milos_clk_virt},
>> +	{ .compatible =3D "qcom,milos-cnoc-cfg", .data =3D &milos_cnoc_cfg},
>> +	{ .compatible =3D "qcom,milos-cnoc-main", .data =3D &milos_cnoc_main},
>> +	{ .compatible =3D "qcom,milos-gem-noc", .data =3D &milos_gem_noc},
>> +	{ .compatible =3D "qcom,milos-lpass-ag-noc", .data =3D &milos_lpass_ag=
_noc},
>> +	{ .compatible =3D "qcom,milos-mc-virt", .data =3D &milos_mc_virt},
>> +	{ .compatible =3D "qcom,milos-mmss-noc", .data =3D &milos_mmss_noc},
>> +	{ .compatible =3D "qcom,milos-nsp-noc", .data =3D &milos_nsp_noc},
>> +	{ .compatible =3D "qcom,milos-pcie-anoc", .data =3D &milos_pcie_anoc},
>> +	{ .compatible =3D "qcom,milos-system-noc", .data =3D &milos_system_noc=
},
>> +	{ }
>
> a space before '}' would be neat

There is a space :)

>
> Konrad
>
>> +};
>> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
>> +
>> +static struct platform_driver qnoc_driver =3D {
>> +	.probe =3D qcom_icc_rpmh_probe,
>> +	.remove =3D qcom_icc_rpmh_remove,
>> +	.driver =3D {
>> +		.name =3D "qnoc-milos",
>> +		.of_match_table =3D qnoc_of_match,
>> +		.sync_state =3D icc_sync_state,
>
> Are there any issues with sync_state? (hopefully not)

Don't think so, I don't see any sync_state pending warnings in dmesg so
I assume it's 'synced'? Anything I should look out for in particular?

Also since it looks like I'll anyways send a v3, I've already ported the
QoS settings, and don't think I'm seeing any issues booting up with
that. So I'll include it with v3.

Regards
Luca

>
> Konrad


