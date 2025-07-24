Return-Path: <linux-kernel+bounces-744589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24AFB10EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD3C5A59A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B7E2EA478;
	Thu, 24 Jul 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4fXOLa2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654512D3EDF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371667; cv=none; b=eX6kva+RLpFX/y71oAfBW1fW0ZeEq/3mDOlq9qIl2egAr8249jEstyk/I71utW9FjDxT6JtsmJrmAS03AUEVOFvDvBlO03A4iO0LEUjgqGkEJVc+1ZXsP06cTdcyYvGsUnKbasBgzeZkKZ1bhfSnoNKsmdxADtXDdKFDNwmlSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371667; c=relaxed/simple;
	bh=rL72xLvDpaYB5a3K56U+QX+tDm0UKRXbjJu7lpGADJA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=V2Q1ernvl4a7SQUUTRhxAfj0LcnWAEYKHQ+7gJRSK8udu0CVi59G1yf2OGnI7kcS+fSh9QK6UveqiTnVDRYJ90bWeRX3z5MeVQFgOx8anDPkIQNQu04/sUJO+WhqCEM3bZbEbAY7OuKZx52qDJeAJr0vWWVjIzTNh4atnGzvjVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H4fXOLa2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45555e3317aso6118995e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753371664; x=1753976464; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijalKac4tH/bOL3hkdX4ec4lsO5RsEUy1SQ79bJniFw=;
        b=H4fXOLa2L7z4w2CWSCTh7c+w0wpqWUYXBVlunlre/7F9iX/aefEVA6PyBEht1wCa6T
         EYGYyjMXJRU+t2Kti3H9VLa7ebbewV1ZoOFNqlpAH7xpKxno+liAUvG/Tnsamk28LZVF
         FZry65eCK6e9utHQZ9bjdvEFfPyWafUN2nFZ+a1CTQYSnvlamy+dyOdoIIu+JWA5iSE5
         Swdxljkm1kCqC4cKvkL6aPjVGeKbXbTPcYubi6HYQxb+h5ZNefBLJ9oj2O7VdQu9nI9H
         koZwt7Xj/rw6yNjOrG6M17+66L8FWy2Y3ohgbk34sbt1URaBOVd92uCxZRD2thEO5Cdy
         Wigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753371664; x=1753976464;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ijalKac4tH/bOL3hkdX4ec4lsO5RsEUy1SQ79bJniFw=;
        b=a9xDGONBGszwdeHbBs8GOkwDLoLgCOSURxK5R3SwcuqF4pYC9r1d1vtGbmDyFL80gG
         leDhH1EN9uPqyhjsgQPgIIhG94GXtJ7CfB/I3AWM4u1f1O+myDTBznHN1CTkKit8fIeD
         dWlzJjj3P4+ivU85PiPvu4WGsKd5WhQMkLN9JkngF833hWpVHVS9sdgo59veXeiILh/B
         eC4/8BZ8xKgii6VrlcKgpRAr33wzf7U845vSvHqOg4PgSs8VMhl+sOAhKiWgl4Rmozog
         qRPUq5yKWr0qGmI5psVJXr6C7zu/nAVxQs4Ln+pj04CGo9z2TfiQJVC9AoZsbOqf5l5f
         vlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuBW9+tW0HIF+tRVVbecxTvGzealaGe7O9udLxV5LlNZet8NyJUrmG762rJylSFj2F7jrAJM/1jzQo0OA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51x83FFJvwjguas4RkMMhNjslSJWC8ubYmK2h9f7D7Lupeow/
	J95Cw6CAu0Alpp7tkS5Y7Emd6JrgDVZnL5b9qHNtjeCpGvXX+8V/A2T1zMiM0sa6d/s=
X-Gm-Gg: ASbGnct32mhs+WF56JBt0z3z9AekuVC4lhytQ0GVp6FFRo/R4JT9G4gdJTLwQGaTcht
	048kXhKIBnhxHtbrtJ/RRRVh6R9i3o4242qkqtSOI+zqCKIgmiyBPFwECN4BtsGbNMHDxP5hnyt
	hUt10zs7yKQyaZJwAaSAgVef2XsIYkpNkUUz1iATmHDVf0t29m/mgoPZIHm5n0H+DsHqtcnBEc5
	6yHbvip0pWjH4X9ALVP65q2WG+7geQOSqj//ptaFPSnDNbJ5+a4u0xEN+s0xJCWZMxlaGlZ9PtH
	YndgnwsEakOdwkDzAjM6gCUtnRfsgapMVMREmK7pjSnoRhpMCIb+J+/AuoCZBO5w13Lvy4k152H
	E+9421761O/rHZDFsVUtAxuHuHsK1CSPlCFcSLQ==
X-Google-Smtp-Source: AGHT+IH+Kt4CbvgwU5Pt6jGjtNicK9BRckQRniUA+bTcD0KYObJ3m+6Ey87TiLjq1ghjyaSgL9Tpdg==
X-Received: by 2002:a05:600c:8905:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-4586954d51bmr52814455e9.8.1753371663558;
        Thu, 24 Jul 2025 08:41:03 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:6c39:59e6:b76d:825])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45870553d72sm24018765e9.16.2025.07.24.08.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 08:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Jul 2025 16:41:02 +0100
Message-Id: <DBKEDPOEQHOJ.2DA0F5PUZGCJO@linaro.org>
Cc: "Srinivas Kandagatla" <srini@kernel.org>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Stephen Boyd" <sboyd@kernel.org>, "Lee
 Jones" <lee@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai"
 <tiwai@suse.com>, <linux-arm-msm@vger.kernel.org>,
 <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Srinivas Kandagatla"
 <srinivas.kandagatla@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] ASoC: codecs: add new pm4125 audio codec driver
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
X-Mailer: aerc 0.20.0
References: <20250711-pm4125_audio_codec_v1-v2-0-13e6f835677a@linaro.org>
 <20250711-pm4125_audio_codec_v1-v2-2-13e6f835677a@linaro.org>
 <20250711-hungry-uppish-taipan-a0a35a@krzk-bin>
In-Reply-To: <20250711-hungry-uppish-taipan-a0a35a@krzk-bin>

On Fri Jul 11, 2025 at 9:29 AM BST, Krzysztof Kozlowski wrote:
> On Fri, Jul 11, 2025 at 04:00:11AM +0100, Alexey Klimov wrote:
>> +static void pm4125_unbind(struct device *dev)
>> +{
>> +	struct pm4125_priv *pm4125 =3D dev_get_drvdata(dev);
>> +
>> +	snd_soc_unregister_component(dev);
>> +	device_link_remove(dev, pm4125->txdev);
>> +	device_link_remove(dev, pm4125->rxdev);
>> +	device_link_remove(pm4125->rxdev, pm4125->txdev);
>> +	component_unbind_all(dev, pm4125);
>> +}
>> +
>> +static const struct component_master_ops pm4125_comp_ops =3D {
>> +	.bind =3D pm4125_bind,
>> +	.unbind =3D pm4125_unbind,
>> +};
>> +
>> +static int pm4125_add_slave_components(struct pm4125_priv *pm4125, stru=
ct device *dev,
>> +				       struct component_match **matchptr)
>> +{
>> +	struct device_node *np =3D dev->of_node;
>> +
>> +	pm4125->rxnode =3D of_parse_phandle(np, "qcom,rx-device", 0);
>> +	if (!pm4125->rxnode)
>> +		return dev_err_probe(dev, -ENODEV, "Couldn't parse phandle to qcom,rx=
-device\n");
>> +	component_match_add_release(dev, matchptr, component_release_of, compo=
nent_compare_of,
>> +				    pm4125->rxnode);
>> +	of_node_put(pm4125->rxnode);
>
> If you drop it here, then you do not need to keep it in pm4125 in the
> first place. But this will point you to the problem - what if
> pm4125_bind() is called after you dropped the reference?

So I guess the right place is in pm4125_remove() right after
component_master_del()?

>> +
>> +	pm4125->txnode =3D of_parse_phandle(np, "qcom,tx-device", 0);
>> +	if (!pm4125->txnode)
>> +		return dev_err_probe(dev, -ENODEV, "Couldn't parse phandle to qcom,tx=
-device\n");
>> +	component_match_add_release(dev, matchptr, component_release_of, compo=
nent_compare_of,
>> +				    pm4125->txnode);
>> +	of_node_put(pm4125->txnode);
>
> Same problem here.

Thank you,
Alexey


