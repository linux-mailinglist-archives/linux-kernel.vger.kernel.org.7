Return-Path: <linux-kernel+bounces-824201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22468B885B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0989658047F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9D305064;
	Fri, 19 Sep 2025 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="YJBB1iDZ"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E6304BDA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269543; cv=none; b=QVKm34G6MbTEID2vGCMn4qeOI+43xy4azFdxdjokyzQepbPTtxOL9mG4Gmb0xSzBBCdEvd/4nUm+5BdDtjAs6Uvl9KncmuC8unKQYw5r2+8aZTrQf+tAQMJMxc0Ilup9ruELRuiFEz/wn7ClOjne4T/XWn8HtUjxaQNHsULkUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269543; c=relaxed/simple;
	bh=NpaY/s4HIMDt0+2Bxnt8uJctQlICgEp1j3rKlIvDyLQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lcoeD8PnawrodxfZTlXL5EDfv8TMhs72oB5vdn5LUCzavyle/zNKTNEYZs1QJkPcjPieRU6u9k5EvoLizDFMu5qCET0xJcaCIGLNuvb9lmO8lBsdFvA2OBo2R0BjfiJ+zyQ6mbS4H3iI42JNIB4QgxPd3aOzohO+nSsA40CaKE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=YJBB1iDZ; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-62fce8b75a3so270052a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758269539; x=1758874339; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpaY/s4HIMDt0+2Bxnt8uJctQlICgEp1j3rKlIvDyLQ=;
        b=YJBB1iDZ2SM/3fNTx+cKBUR2i3rVdSHcZQhcVOc1zml7yyFnwsG0wVbwtYUdJwiyR8
         meRFgoRJiFhqJn5lbG1V8ayujsMpvqErsq29EiWUXCFSqAJ9TRqEZ/cHTtL/Uq1IsET9
         pFB89G2kRXutIzdLi35DWtXcnZGuBSO4P4fC3sHteLK7ubTeFS339Yu40ZY89Nckj7KG
         lrkqBiSxw6EyFPcU9IrRPyaClQLfPTi710tAxkBySmh2HWH7C14f/YREbthmwZZVUJT5
         3jSBcypiUAXvqeXaISKYpAjFrTUFLXauCYnCp4IQ2oZn6RAT1ctCuJ2cPXoC9IuJKBJk
         MucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758269539; x=1758874339;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NpaY/s4HIMDt0+2Bxnt8uJctQlICgEp1j3rKlIvDyLQ=;
        b=g/HEpRjTafxU+KEqeLO/yeCtGvBfLACHAgXYY8zlpI7w8U4W/Y3DrwTOa8lCPca7/j
         65qZraJ/jEMJqNleDLKmBtxaB6cQWEjHydMgJyKjp5Xi9NILsawH1wT3wREv3w+OP6bU
         pQaBsgsKc2VC4suttOAq0zd2I8LB7KvS1VPj1yThb2PuF7y6JL01CkCs+Qz62GB0f3XF
         9JHu4KqVZGVPyhK3KnTsjaQAmj7yO7AvzZc+aYjr+CZ2gzlZS0D/WiaWSZSpV9mAC3b3
         j0FNCOHfv7LkxXsxdHXNpavp0+vEXkmHJzOuuMFFO66BDFcs9Jc+7+x/oc3xAroR84E2
         a1iw==
X-Forwarded-Encrypted: i=1; AJvYcCW+U2Yelp5PaFCsaZKAQTI7kdoK8JiU6E6LMFfLxLudToIjekIFS+Jjp4254M5EZ7GpnDF+7M4miAe6L4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGFzGnhqYsQTyBaGboFUDgAIsQOloiBCoe8ge8qhQeNeS+WS5H
	ZFK6+HOebZbjfeg4J4wV8FYBbUhX27SEOg4MRmbbIsqHn+iMvvKbJtpV8ZN0lzz73Wg=
X-Gm-Gg: ASbGncth1OP9/BByKPK1v2wQSKAs0oIKLvRwP2YxKF5tpPaY0Pi7dZjmYF9jB4l8vWd
	P9T4vcz1dU84hE6jnd2iOPlMETWdRyBqdfV+AqcZVeL01SEl7+/HlZ7omlWOT76iwNxe6Mhk9JP
	y9O6ERjD0HjoAcuS0t09GT3O35tC22dDcsnNUmjXaOA9xhx3lwj4buXqRwwnMK3k0ZSXlg0Zjd9
	WNIV5R+LEbSr1c7iTgcl0Sf5dDIVcVA4VXmFJnUhMCYQ1ZqL4JPZhQJz2stk0SOlNNh1byRTNim
	QnqYU5Bzao3+bIIBFKGShuD+Qypgb+xlHkfDyFaw3bSMhgvIZEk0lGJAwq+neVil8G/DCZDq6JT
	lRBIaJjF7vSDegyHjPEbRZNpBNO1puiVs3H+OBhMUFvsqjEaL1gdozuk5vfIh0C33xi5o
X-Google-Smtp-Source: AGHT+IGH2L5Cs1Yr4IicnBQLWLPnN2LIXEqc14EimrkOsvHCK05Z8Mf+Sxf46z58s1gpwiushS71dw==
X-Received: by 2002:a17:907:849:b0:b0e:8cd4:e2e8 with SMTP id a640c23a62f3a-b24eedc3122mr252009466b.17.1758269539368;
        Fri, 19 Sep 2025 01:12:19 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fcfe88d79sm378700866b.65.2025.09.19.01.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 01:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Sep 2025 10:12:18 +0200
Message-Id: <DCWMJ6YDI2GA.EKTOE6UN9HNQ@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-shift-axolotl: Fix typo of
 compatible
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Joel Selvaraj" <foss@joelselvaraj.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Tamura Dai" <kirinode0@gmail.com>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Joel Selvaraj" <joelselvaraj.oss@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <4ae418ec-5b84-40b5-b47f-ee2e988d7e99@joelselvaraj.com>
In-Reply-To: <4ae418ec-5b84-40b5-b47f-ee2e988d7e99@joelselvaraj.com>

On Fri Sep 19, 2025 at 8:23 AM CEST, Joel Selvaraj wrote:
> Hi Luca Weiss and Tamura Dai,
>
> On 9/12/25 02:24, Luca Weiss wrote:
>> Hi Tamura,
>>=20
>> On Fri Sep 12, 2025 at 9:01 AM CEST, Tamura Dai wrote:
>>> The bug is a typo in the compatible string for the touchscreen node.
>>> According to Documentation/devicetree/bindings/input/touchscreen/edt-ft=
5x06.yaml,
>>> the correct compatible is "focaltech,ft8719", but the device tree used
>>> "focaltech,fts8719".
>>=20
>> +Joel
>>=20
>> I don't think this patch is really correct, in the sdm845-mainline fork
>> there's a different commit which has some more changes to make the
>> touchscreen work:
>>=20
>> https://gitlab.com/sdm845-mainline/linux/-/commit/2ca76ac2e046158814b043=
fd4e37949014930d70
>
> Yes, this patch is not correct. My commit from the gitlab repo is the=20
> correct one. But I personally don't have the shiftmq6 device to smoke=20
> test before sending the patch. That's why I was hesitant to send it=20
> upstream. I have now requested someone to confirm if the touchscreen=20
> works with my gitlab commit. If if its all good, I will send the correct=
=20
> patch later.

Hi,

As written on Matrix I've confirmed the patch you linked works on v6.16.

Regards
Luca

>
> Regards,
> Joel


