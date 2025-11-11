Return-Path: <linux-kernel+bounces-895075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B5C4CDB4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B3D64F39B1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AC12FD7B3;
	Tue, 11 Nov 2025 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDnvbdt8"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2EA2F28E5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855070; cv=none; b=aVgcrvMGAhCER70jr5Pn9KKRWNwj9//GvC26YhnBpZ4AFn+KWZZiwZ0LgNl3lZSaAU/L3z/hBcq+Prf99KphNbCmnhpvZjSoG64TBoMrRrYXm7Vs0Oi0L5Vem0u55CSTv5EgqEmMMYgArdXvcXVJ+bhFJ8VIzOnwXqHK/yWgeVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855070; c=relaxed/simple;
	bh=A/FDcgEC0NqdGGYV5LPhCY8eQLNHWRRJowrE/ROA2P8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NWCZpIxfrij51CH7VKfvNpQ0jEaPNfGK5Nnydh/2Vg8+9nSxIkMDavGsmJWs/6GAn4mFaDbbbmjCbbG0krqFZl52VOA41N5k/lgMk63n9kwb/5zv1M3FrjFxXFpBuln6OCR90k/9tCJ+2X+mwycg08eSa1UFGc7xxHJPO4MaUKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BDnvbdt8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477775d3728so23154835e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762855066; x=1763459866; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A/FDcgEC0NqdGGYV5LPhCY8eQLNHWRRJowrE/ROA2P8=;
        b=BDnvbdt8iSYN6bxwCsU4EDmY1GHOAcYRVvz+U3H9jx3pABSMYfbGSx7e4UTi4huSV/
         9XAS5nzciGxhzKRcbEKMWqY5DRPjDJUgwdvYRLN7M9ysHRP5T0ne+Jt4qsaI1dnrQQQs
         C5bxL+UhfluxUWO+LOFXeJd8VX/plVfE9j1wkoezNcGqES3aGHlM5411aSH8u+lufGZe
         mEtoYElGp1glT+iVVOZ1hg+VERPjRBvSZ6sEwmhrgA4EkAen0N3m8wYOCnqTHvXuzr12
         XvHmxn2I45PzjZCems0cO1lnWf/UPp9ZVusRwI33NHkEJ8s79DkDJyj0XDDop8sjtWUr
         gyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855066; x=1763459866;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/FDcgEC0NqdGGYV5LPhCY8eQLNHWRRJowrE/ROA2P8=;
        b=J3iazL6lNen1N7oexE1eqEceY2xxRZf26waU/CyxpsBhLgaLHeIswqPuSRTNAFyr8T
         JxHBc/nrMM/UHVs2q+6Co6e9LShFW6VPfa+Fe1eAGYXIykhHXYFMf8On1OhlJ69fQjuD
         hI9wqrr9pNm6cStEQuZQXXZa1Hj8erClHku9zRdCh2lVeDrlfJA9VfiKbo+HLjsGfpb9
         gg1+iE2DclEJEE5MV9eE6qF5O2Wz3febJUJzIjHjfj1guog6OEq66eyy1vp2p7nO5Nvl
         mdjqKAtkkQ7q8u4OANp4Rqp7eo1dTVBsgWiG4K0yWWk+rPQf669H3vPs+dLnQqgr7KqN
         rt6A==
X-Forwarded-Encrypted: i=1; AJvYcCWNqEteQaHSKVfoVAAZVWT7DVY+symxAFNEvj8DGFFfCv2fJ1DNqcQoJlkOOhi/NkfrKGMDBRnt3Vq/Pvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5CCQkFhoGEdKnzCkmiBQDlOy1mckgDYQHChD1C45WnHcnnGyp
	qC1CsCbP5l4xYGmHrExxBrxs+hALayJVaNJRoyoVlM2g5giXfGippcRvh1r6Ufi9lWc=
X-Gm-Gg: ASbGncvrFLqdKukwL00mQwxGDvuG3crr2T/A9ib9o5I8UcntEGNmj+KnYRYH1OJKc6D
	13t7Q+jYcfndHua+j4Lw+e7dFsOMbSAp1FGSZ9AToujZ6kgup5nJQYKGe/V9Stq0bX7wO7E7PXc
	jGDvgqogQ8dcP7Owa5pVXIklDSOLEBtssDL9HcL/Rn3md05Cc37eRLtlvvDuwUpbx9Bl5/9mgLe
	pDD9EQr0pGGZQeL5N/KSgPsW6Qa8OwS603SkaYrUsvOHtRg7MRQVWJ3jiv1vIiBVyFSIdpovtF3
	ASbN7PN1mmZm5o9bg6NTzhdiGsjnNLA9/i2dSRWYiGXOPMUy44W2L252zk/t7znqTKyadU7wN6P
	ko7pbQIoEHoCeRXXPIJCiPcVrB+tiqSfob6Yo247lgNM+1qHMd7ssoOXKqZ11GVsSCJ2moApdMs
	6XuOqIzg==
X-Google-Smtp-Source: AGHT+IFx1tQhYEcMAjmeDGusVpDAcsUi3ywSe54TVsoxYy0zvPtJEA10WARNrOByXA/spkwUzB6jqA==
X-Received: by 2002:a05:600c:1c08:b0:475:df91:de03 with SMTP id 5b1f17b1804b1-47773289066mr81723875e9.39.1762855066460;
        Tue, 11 Nov 2025 01:57:46 -0800 (PST)
Received: from draszik.lan ([212.129.83.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce211d8sm380577775e9.11.2025.11.11.01.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:57:45 -0800 (PST)
Message-ID: <9c344c5f43e71f30ccbd07b201eb470ed8e5fe35.camel@linaro.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: clock: google,gs101-clock: add
 samsung,sysreg property as required
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar	 <alim.akhtar@samsung.com>, Tudor
 Ambarus <tudor.ambarus@linaro.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sam Protsenko	
 <semen.protsenko@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, Krzysztof Kozlowski	
 <krzk@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 kernel-team@android.com
Date: Tue, 11 Nov 2025 09:57:42 +0000
In-Reply-To: <3bb47929b08370d9114ff1dd6b0d0f16d354d63b.camel@linaro.org>
References: <20251110-automatic-clocks-v4-0-8f46929f50b7@linaro.org>
		 <20251110-automatic-clocks-v4-1-8f46929f50b7@linaro.org>
	 <3bb47929b08370d9114ff1dd6b0d0f16d354d63b.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI1LTExLTExIGF0IDA5OjU0ICswMDAwLCBBbmRyw6kgRHJhc3ppayB3cm90ZToK
PiBIaSBQZXRlciwKPiAKPiBPbiBNb24sIDIwMjUtMTEtMTAgYXQgMTQ6MjEgKzAwMDAsIFBldGVy
IEdyaWZmaW4gd3JvdGU6Cj4gPiBbLi4uXQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2dvb2dsZSxnczEwMS1jbG9jay55YW1sCj4g
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9nb29nbGUsZ3MxMDEt
Cj4gPiBjbG9jay55YW1sCj4gPiBpbmRleCAzMWUxMDZlZjkxM2RlYWQ5YTAzOGIzYjZkOGI0M2I5
NTA1ODdmNmFhLi41Y2U1YmE1MjMxMTBhZjNhMmE3NzQwYjhiYTI4ZTIyNzFjNzZiZGRiIDEwMDY0
NAo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2dvb2ds
ZSxnczEwMS1jbG9jay55YW1sCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvY2xvY2svZ29vZ2xlLGdzMTAxLWNsb2NrLnlhbWwKPiA+IEBAIC01Miw2ICs1MiwxMSBA
QCBwcm9wZXJ0aWVzOgo+ID4gwqDCoCByZWc6Cj4gPiDCoMKgwqDCoCBtYXhJdGVtczogMQo+ID4g
wqAKPiA+ICvCoCBzYW1zdW5nLHN5c3JlZzoKPiA+ICvCoMKgwqAgJHJlZjogL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQo+ID4gK8KgwqDCoCBkZXNjcmlwdGlvbjoKPiA+
ICvCoMKgwqDCoMKgIFBoYW5kbGUgdG8gc3lzdGVtIHJlZ2lzdGVycyBpbnRlcmZhY2UuCj4gPiAr
Cj4gPiDCoHJlcXVpcmVkOgo+ID4gwqDCoCAtIGNvbXBhdGlibGUKPiA+IMKgwqAgLSAiI2Nsb2Nr
LWNlbGxzIgo+ID4gQEAgLTE2Niw2ICsxNzEsMjIgQEAgYWxsT2Y6Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLSBjb25zdDogYnVzCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBj
b25zdDogaXAKPiA+IMKgCj4gPiArwqAgLSBpZjoKPiA+ICvCoMKgwqDCoMKgIHByb3BlcnRpZXM6
Cj4gPiArwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZToKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAg
Y29udGFpbnM6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnVtOgo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC0gZ29vZ2xlLGdzMTAxLWNtdS1hcG0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAtIGdvb2dsZSxnczEwMS1jbXUtbWlzYwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC0gZ29vZ2xlLGdzMTAxLWhzaTAKPiAKPiBTaG91bGRuJ3QgdGhpcyBi
ZSBnb29nbGUsZ3MxMDEtY211LWhzaTA/Cj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLSBnb29nbGUsZ3MxMDEtY211LWhzaTIKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAtIGdvb2dsZSxnczEwMS1jbXUtcGVyaWMwCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLSBnb29nbGUsZ3MxMDEtY211LXBlcmljMQo+ID4gKwo+ID4gK8KgwqDCoCB0aGVuOgo+ID4g
K8KgwqDCoMKgwqAgcmVxdWlyZWQ6Cj4gPiArwqDCoMKgwqDCoMKgwqAgLSBzYW1zdW5nLHN5c3Jl
Zwo+IAo+IFRoZSBhYm92ZSBzdGlsbCBhbGxvd3MgKGJ1dCBkb2Vzbid0IGVuZm9yY2UpIHNhbXN1
bmcsc3lzcmVnIG9uIGNtdS10b3AuCj4gCj4gTWF5YmUgaXQnZCBiZSBiZXR0ZXIgdG8gaW52ZXJ0
IHRoZSB0ZXN0LCBhcyBjbXUtdG9wIGlzIHRoZSBvbmx5Cj4gb3V0bGllciwgYW5kIHRoZW4gdGhl
IGJpbmRpbmcgZG9lc24ndCBuZWVkIHRvIGJlIHVwZGF0ZWQgd2hlbiBtb3JlCj4gQ01VcyBhcmUg
YWRkZWQgKHVudGVzdGVkKToKPiAKPiDCoCAtIGlmOgo+IMKgwqDCoMKgwqAgcHJvcGVydGllczoK
PiDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlOgo+IMKgwqDCoMKgwqDCoMKgwqDCoCBjb250YWlu
czoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0OiBnb29nbGUsZ3MxMDEtY211LXRvcAo+
IAo+IMKgwqDCoCB0aGVuOgo+IMKgwqDCoMKgwqAgcmVxdWlyZWQ6Cj4gwqDCoMKgwqDCoMKgwqAg
LSBzYW1zdW5nLHN5c3JlZwo+IAo+IMKgwqDCoCBlbHNlOgo+IMKgwqDCoMKgwqAgcHJvcGVydGll
czoKPiDCoMKgwqDCoMKgwqDCoCBzYW1zdW5nLHN5c3JlZzogZmFsc2UKCm9idmlvdXNseSB0aGVu
OiBhbmQgZWxzZTogY2FzZXMgc2hvdWxkIGJlIHN3YXBwZWQuCgpBLgo=


