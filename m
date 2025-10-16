Return-Path: <linux-kernel+bounces-855545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31529BE197A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02E23AF560
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754F4244EA1;
	Thu, 16 Oct 2025 05:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHEOO7rK"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE41522A7E2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760594018; cv=none; b=uezsfO4P5X+9EvWXMxNwk1VDeIkW3cgON2qyrW6XdTze8CgoKF9GfVz7UCYcPGvgPcW0MuqUFcVENiKvtVAycPjzM+23W6hkIj8PvWTORFzV5AhskYJYbqphdlWzkAEhejjs2jO4sfpuNz/Naf68GrAY75/Bn/XkYzI++7tWMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760594018; c=relaxed/simple;
	bh=h43Lpj0QWKhbWHWyTH/CRqgeEv5tT9Y15JOhJ6HkdJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eLg+Rl1wiPqK2/vs0+u+Ix/CLUlvzQ1P4ZYN8jIDthp2Ef/1CO+mvxBEMESwMt5mFY4JrXzqMcXEhDRg6i9aNQCfLeIInpK1rbefYOOXg8bIb6XE7C4YIEPJ/4a80fqdD1lEOhap4mdKt3BeibJ8W54UGV95bExaPPvieaQT9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nHEOO7rK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b50645ecfbbso66894366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760594015; x=1761198815; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h43Lpj0QWKhbWHWyTH/CRqgeEv5tT9Y15JOhJ6HkdJ0=;
        b=nHEOO7rKZIkWtYDi0eGXlP30OPZK1y00frSaLEQQY6Gu7bIW6fRaePgg/AxT2wiZcr
         oRVHMkAiRfVxZceEAo7yjqCcb3srVt6ITxzT2eYoo/7CBzDbR1Spvq2hZDkBDWL6ac+J
         PgzzlF43++hfAvtEw2Ucjh1AksS0Ol6u9ma0Pt5Pb3VCj6M67suGtunfz1O6Z8Det2NI
         ZfmyOVBq3my+73f4EulUkpDWMFQeztQ5mXOf3hiSpKic2I1YzjpQIIi+aDOpV8pYTYP9
         z805UbnPCuQRvE8g1fAZ/9RbLd27BPhc5l/DftfypZ/SyH+zYHbHOpKCsoY4C1dM08o7
         R/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760594015; x=1761198815;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h43Lpj0QWKhbWHWyTH/CRqgeEv5tT9Y15JOhJ6HkdJ0=;
        b=lwWlb9ZwZWx8FhxT2cGqwlUa/PO2MfGrHW/1D3e8BVRDAbD1r2yaF7tITuZowuCrvH
         nTeQopAQWZBx03e+32sJPYHOafFfoRdzCwZSInUsst1koUOPtu60X2zJN0Rg6awt+KFQ
         bHwDo3PCnpGf1jZSghmlSfZRePIlDcf3L+kQ/3vbMeps+9N0p2NHtR5et1sSFCb59sSO
         w0o8t44olcpBAAQyN1mJ4m4xX2McoiFNHPFWM6agEXHiSFvDiWM41NIyaYzBH8YWqFgF
         9sOlft6SwNYcobVL/DT2k7aE04czBAlQBuDBZ4nox1aZBJeMEnbmfkU6nvdAfeBoKuSi
         WWkg==
X-Forwarded-Encrypted: i=1; AJvYcCUugd5C4hHsKJM2OWUt/9lKSfn6JFFWLoZrOG4yPYmYBlM73UuNPUYvevfZQPz5ONoIQFB70TQ0nq2TXY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1krluQu7ODsoJp2CInEP6jSigGcbSdfn2o1d6sqOdfr8CzK+
	GWTYW56ppwLnduogRZIV17FnvydnkzhANMWhsXq+qrSgNF5DB0561kSwqIeGJUha1g4=
X-Gm-Gg: ASbGnctd7dVUQD6OfkefNdpdx6pq9H3Xolk93cuQStuwSFIN3K3I55H93qJ2RdoEBII
	/uQ/1u6oX0flICsyTTyQDumDYr96KfTMjpFTV+2KSDklz7mDsrsynxY2SFwTnVWMwhWgpsJJ7Pp
	JUGanYJcg3GGGyvb7Qig0w8sPoYwT2zCDwdMdXyLG/a+iiiX+LZbATRR+/MLg3lPzREWcfeNBaV
	r2e7LvwZ4HB5e6RUoW/QCI6H2EQ/TW9jgq8uAzyY9v5DRbL6qVhbp19xiuCu2E8LmMGlkF+APD5
	c5X7aocU2wRhankFupoK1rKNiaRorB3Cxp0jy1dAUout4llvmhHbuFBHpwj8eYcmDtps7kbD6ou
	5cT+TDc9Y7hsAiG2xT4EdQaKEIZcZzuryE6ryTmcMj8OfpTFJp5ReWxpwu8RYXTY7i9D/X/qHEC
	JaPbKlSM2xItrwqkXXTv2ypDmKpdAe
X-Google-Smtp-Source: AGHT+IG6k82old8Ss2xXFGeUWZ0Z24OHhJFIC1WYkbpaOPTTbKORZrmrrZeZpS+oP1oVNSzs9LZc9A==
X-Received: by 2002:a17:906:cb85:b0:b54:8670:7c2d with SMTP id a640c23a62f3a-b5486707c37mr2358791766b.55.1760594015284;
        Wed, 15 Oct 2025 22:53:35 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdaa0f9sm427529166b.45.2025.10.15.22.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 22:53:34 -0700 (PDT)
Message-ID: <5fa16d95c5b421253135c5ec7974e99b8724f395.camel@linaro.org>
Subject: Re: [PATCH 2/9] dt-bindings: clock: google,gs101-clock: add
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
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Krzysztof
 Kozlowski	 <krzysztof.kozlowski@linaro.org>, kernel-team@android.com
Date: Thu, 16 Oct 2025 06:53:33 +0100
In-Reply-To: <20251013-automatic-clocks-v1-2-72851ee00300@linaro.org>
References: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
	 <20251013-automatic-clocks-v1-2-72851ee00300@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI1LTEwLTEzIGF0IDIxOjUxICswMTAwLCBQZXRlciBHcmlmZmluIHdyb3RlOgo+
IFVwZGF0ZSB0aGUgYmluZGluZ3MgZG9jdW1lbnRhdGlvbiBzbyB0aGF0IGFsbCBDTVVzICh3aXRo
IHRoZSBleGNlcHRpb24gb2YKPiBnczEwMS1jbXUtdG9wKSBoYXZlIHNhbXN1bmcsc3lzcmVnIGFz
IGEgcmVxdWlyZWQgcHJvcGVydHkuCj4gCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgR3JpZmZpbiA8
cGV0ZXIuZ3JpZmZpbkBsaW5hcm8ub3JnPgo+IC0tLQo+IMKgLi4uL2JpbmRpbmdzL2Nsb2NrL2dv
b2dsZSxnczEwMS1jbG9jay55YW1swqDCoMKgwqDCoMKgwqDCoCB8IDIzICsrKysrKysrKysrKysr
KysrKysrKy0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9j
bG9jay9nb29nbGUsZ3MxMDEtY2xvY2sueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9jbG9jay9nb29nbGUsZ3MxMDEtCj4gY2xvY2sueWFtbAo+IGluZGV4IGNhZjQ0MmVh
ZDI0YmRhNTdlNTMxNDIwZDhhN2Q4ZGU4NzEzMDMyYWUuLjVjZmU5OGQ5YmE4OTVkNTIwN2ZmZmM4
MmYzZmQ1NWI2MDJiNGEyYmIgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Nsb2NrL2dvb2dsZSxnczEwMS1jbG9jay55YW1sCj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2dvb2dsZSxnczEwMS1jbG9jay55YW1sCj4g
QEAgLTQ5LDYgKzQ5LDExIEBAIHByb3BlcnRpZXM6Cj4gwqDCoCByZWc6Cj4gwqDCoMKgwqAgbWF4
SXRlbXM6IDEKPiDCoAo+ICvCoCBzYW1zdW5nLHN5c3JlZzoKPiArwqDCoMKgICRyZWY6IC9zY2hl
bWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUKPiArwqDCoMKgIGRlc2NyaXB0aW9u
Ogo+ICvCoMKgwqDCoMKgIFBoYW5kbGUgdG8gc3lzdGVtIHJlZ2lzdGVycyBpbnRlcmZhY2UuCj4g
Kwo+IMKgcmVxdWlyZWQ6Cj4gwqDCoCAtIGNvbXBhdGlibGUKPiDCoMKgIC0gIiNjbG9jay1jZWxs
cyIKPiBAQCAtMTYzLDYgKzE2OCwyMiBAQCBhbGxPZjoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLSBjb25zdDogYnVzCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IGlwCj4g
wqAKPiArwqAgLSBpZjoKPiArwqDCoMKgwqDCoCBwcm9wZXJ0aWVzOgo+ICvCoMKgwqDCoMKgwqDC
oCBjb21wYXRpYmxlOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqAgY29udGFpbnM6Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZW51bToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBnb29n
bGUsZ3MxMDEtY211LWFwbQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGdvb2dsZSxn
czEwMS1jbXUtbWlzYwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGdvb2dsZSxnczEw
MS1oc2kwCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gZ29vZ2xlLGdzMTAxLWNtdS1o
c2kyCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gZ29vZ2xlLGdzMTAxLWNtdS1wZXJp
YzAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBnb29nbGUsZ3MxMDEtY211LXBlcmlj
MQo+ICsKPiArwqDCoMKgIHRoZW46Cj4gK8KgwqDCoMKgwqAgcmVxdWlyZWQ6Cj4gK8KgwqDCoMKg
wqDCoMKgIC0gc2Ftc3VuZyxzeXNyZWcKPiArCj4gwqBhZGRpdGlvbmFsUHJvcGVydGllczogZmFs
c2UKPiDCoAo+IMKgZXhhbXBsZXM6Cj4gQEAgLTE3Miw3ICsxOTMsNyBAQCBleGFtcGxlczoKPiDC
oAo+IMKgwqDCoMKgIGNtdV90b3A6IGNsb2NrLWNvbnRyb2xsZXJAMWUwODAwMDAgewo+IMKgwqDC
oMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJnb29nbGUsZ3MxMDEtY211LXRvcCI7Cj4gLcKgwqDC
oMKgwqDCoMKgIHJlZyA9IDwweDFlMDgwMDAwIDB4ODAwMD47Cj4gK8KgwqDCoMKgwqDCoMKgIHJl
ZyA9IDwweDFlMDgwMDAwIDB4MTAwMDA+OwoKVGhpcyBzZWVtcyB1bnJlbGF0ZWQsIG9yIGF0IGxl
YXN0IG5vdCBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLgoKQ2hlZXJzLApBbmRyZScK
Cj4gwqDCoMKgwqDCoMKgwqDCoCAjY2xvY2stY2VsbHMgPSA8MT47Cj4gwqDCoMKgwqDCoMKgwqDC
oCBjbG9ja3MgPSA8JmV4dF8yNF81bT47Cj4gwqDCoMKgwqDCoMKgwqDCoCBjbG9jay1uYW1lcyA9
ICJvc2NjbGsiOwo=


