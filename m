Return-Path: <linux-kernel+bounces-744364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B29B10BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90E217790B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DE22D3A9C;
	Thu, 24 Jul 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+sozftc"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2204A2C1586
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364315; cv=none; b=iCbmN+jxr51zU01I83y1+lzSK1DsxsQSaKdu2uwDmr+oavcF1tX5vgK/KMM9WEitpM32P+08T/FJ+OXr788EmDicWp6+oYBv80kv0NQZK5LZT3bmRpj7BSsl5yqtKjN6Zq7pxhnN4JDYz3pDOU1NoQ3tnkc5NSNE4UOqCXyHkiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364315; c=relaxed/simple;
	bh=IbVnVuUXikFBJJ9Ko98F0sau5TC35CHjqvTzNtUUNGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X3tVigsLfjVfSd/tpEfs6oBLcx/ChESUkCju2Cirt7GDf3ywTVsSfv9GjwvJRTTiESBF2f6oFTmKGi02geRB5oJFzOquNzmwJWPmJNWweZyitqYMV1i0mFK6S5uKoJQTJCClCgBTPowDFYBk7QuyGRm3OWPjhIxU+o9Dnh0W9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q+sozftc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4561ca74829so10774305e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753364312; x=1753969112; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IbVnVuUXikFBJJ9Ko98F0sau5TC35CHjqvTzNtUUNGk=;
        b=q+sozftcdPDo3Rgjq2URBuvYArk0JTw/ZPhw+XSpGKXn4o8ATX2alAnwdnXaJ1M8Ou
         KpqsTfm1qJtptZx1vVE60x/w6Vk7+1GOljmtnoWGuAOsQIVrZgbTPa8ihoJsNEWP6coF
         5zH/s/NvaJA/nzejqNpweaMZzDHkEZfw2lJFHwoL5wg3zifYXJEV1q6AZbRGRGSvcyp8
         e+Gy7eCzbWYca3Zs7pXUGwOoIiRkd/lZ6RBIKMdu2Y9b9rYf2O6mmruC/h3m7l0B/tDc
         0BtYqOn1oRnhxb1tUAffPdiXyHIxCivoxNBoJpi7TXWrpLFpU9wVHv5O8Dp2h9tDbwKw
         ghrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753364312; x=1753969112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbVnVuUXikFBJJ9Ko98F0sau5TC35CHjqvTzNtUUNGk=;
        b=bwsZ5IYRr7vFOygJGkxuLbukcdz+PRjBj8vuWiPr9cBHXJi9+dJmpqPnQFZ8MCzaP6
         OOI9iuOclDanEizjxOLSCl1dv4WuL9819gaVCQmpHnE99645TUjytLt9/7dAj+xa0zHG
         cMcPp6dBvgXc+QQCX3ctkSC35GFFSqEN1ls3GDLniOpDhQUHJJT8RTgnX8hWJS+tADMb
         DHrN1hnIRTchoU58vdUaarp4MKd/dpsm0Xg1POsbojoDcGHXiE0UJN9n1L7diEIiPakK
         3zFwc/pGEZhx5NOHfze8l5jfmYGjyFJ6r0FGK0c+2ZwavrNPhbNRrgZuCXvqNJUfc7AB
         /tew==
X-Forwarded-Encrypted: i=1; AJvYcCVzWPx1X9MhJuqXS4PoWDl37xSpaSyJWfvCxJFKhNlKaMWvPIACtdve9QzT6gMZvNsPH72oTdOWmApdfx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOl6/3EfNe51OrhNbhWzx5kDdL+U8lTyfqHXfGIOauVccX+El
	oBAh2v5g+HKEDS4KMVvLWsGjpjXyD4/d/+dqOTj6j1dk8Yykur96m8bIa89n/mWzW0Q=
X-Gm-Gg: ASbGncsr9puEBEjJVhcC1vSEbrI+58YrSkryQn4Ny161zZ6Dq3ZIaWeaMVwlMCwavFd
	7kPT9ntVEm80yntUE8DUF1ta/qh9ubO+E341ESh4LGcB+ode7OZ8ZcyGNP10XxKeRw47b6OXR2q
	IhP5c9aKlgM/44BMUenDHUz9KlXWrnP08IFhN4hQpugy1IPIZSbcIBuzg6ZeoPMg9L7nEkagoyN
	xUYGQQtdfGivgpfPDde/gBPZRlJHPmOeWNcoSAxOWkqFhTCtWt/M2YYxVQA5SIV2XJ6IX9eCw4q
	JPdAIhmj4umcsB5aUHJYNxXdTDH5ln74yPeZfMegmyJzn7oA2Wi+3gzX6DGAy4C7o3hYAFNpUCX
	dcIWK/mDY1aY/Rc0q6oWZFg4Vag==
X-Google-Smtp-Source: AGHT+IFTJQA9Boc7JWTCl6LSd+k2ItcXOgwaQYa0NFEIhnO4z236I53hOupq7tKoQvq6tlGKFF+E+A==
X-Received: by 2002:a05:600c:190e:b0:456:1e5a:8880 with SMTP id 5b1f17b1804b1-45868c9cf1bmr63195165e9.13.1753364312430;
        Thu, 24 Jul 2025 06:38:32 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705678c1sm20842055e9.25.2025.07.24.06.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:38:32 -0700 (PDT)
Message-ID: <766fa03c4a9a2667c8c279be932945affb798af0.camel@linaro.org>
Subject: Re: [PATCH] scsi: ufs: core: move some irq handling back to hardirq
 (with time limit)
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, Alim Akhtar	
 <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, Bart Van
 Assche	 <bvanassche@acm.org>, "James E.J. Bottomley"	
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"	
 <martin.petersen@oracle.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
 Manivannan Sadhasivam	 <mani@kernel.org>, kernel-team@android.com,
 linux-arm-msm@vger.kernel.org, 	linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 24 Jul 2025 14:38:30 +0100
In-Reply-To: <53bfd619-4066-4dcb-b3f0-d04177e05355@linaro.org>
References: <20250724-ufshcd-hardirq-v1-1-6398a52f8f02@linaro.org>
	 <f2b85e49152b80a63b20aa5ad67dfbee1190e356.camel@linaro.org>
	 <53bfd619-4066-4dcb-b3f0-d04177e05355@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.1-1+build2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI1LTA3LTI0IGF0IDEzOjU0ICswMjAwLCBOZWlsIEFybXN0cm9uZyB3cm90ZToK
PiBPbiAyNC8wNy8yMDI1IDEzOjQ0LCBBbmRyw6kgRHJhc3ppayB3cm90ZToKPiA+IE9uIFRodSwg
MjAyNS0wNy0yNCBhdCAxMDo1NCArMDEwMCwgQW5kcsOpIERyYXN6aWsgd3JvdGU6Cj4gPiA+IGZp
byByZXN1bHRzIG9uIFBpeGVsIDY6Cj4gPiA+IMKgwqAgcmVhZCAvIDEgam9iwqDCoMKgwqAgb3Jp
Z2luYWzCoMKgwqAgYWZ0ZXLCoMKgwqAgdGhpcyBjb21taXQKPiA+ID4gwqDCoMKgwqAgbWluIElP
UFPCoMKgwqDCoMKgwqDCoCA0LDY1My42MMKgwqAgMiw3MDQuNDDCoMKgwqAgMyw5MDIuODAKPiA+
ID4gwqDCoMKgwqAgbWF4IElPUFPCoMKgwqDCoMKgwqDCoCA2LDE1MS44MMKgwqAgNCw4NDcuNjDC
oMKgwqAgNiwxMDMuNDAKPiA+ID4gwqDCoMKgwqAgYXZnIElPUFPCoMKgwqDCoMKgwqDCoCA1LDQ4
OC44MsKgwqAgNCwyMjYuNjHCoMKgwqAgNSwzMTQuODkKPiA+ID4gwqDCoMKgwqAgY3B1ICUgdXNy
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMS44NcKgwqDCoMKgwqDCoCAxLjcywqDCoMKgwqDCoMKgwqAg
MS45Nwo+ID4gPiDCoMKgwqDCoCBjcHUgJSBzeXPCoMKgwqDCoMKgwqDCoMKgwqAgMzIuNDbCoMKg
wqDCoMKgIDI4Ljg4wqDCoMKgwqDCoMKgIDMzLjI5Cj4gPiA+IMKgwqDCoMKgIGJ3IE1CL3PCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDIxLjQ2wqDCoMKgwqDCoCAxNi41MMKgwqDCoMKgwqDCoCAyMC43
Ngo+ID4gPiAKPiA+ID4gwqDCoCByZWFkIC8gOCBqb2JzwqDCoMKgIG9yaWdpbmFswqDCoMKgIGFm
dGVywqDCoMKgIHRoaXMgY29tbWl0Cj4gPiA+IMKgwqDCoMKgIG1pbiBJT1BTwqDCoMKgwqDCoMKg
IDE4LDIwNy44MMKgIDExLDMyMy4wMMKgwqAgMTcsOTExLjgwCj4gPiA+IMKgwqDCoMKgIG1heCBJ
T1BTwqDCoMKgwqDCoMKgIDI1LDUzNS44MMKgIDE0LDQ3Ny40MMKgwqAgMjQsMzczLjYwCj4gPiA+
IMKgwqDCoMKgIGF2ZyBJT1BTwqDCoMKgwqDCoMKgIDIyLDUyOS45M8KgIDEzLDMyNS41OcKgwqAg
MjEsODY4Ljg1Cj4gPiA+IMKgwqDCoMKgIGNwdSAlIHVzcsKgwqDCoMKgwqDCoMKgwqDCoMKgIDEu
NzDCoMKgwqDCoMKgwqAgMS40McKgwqDCoMKgwqDCoMKgIDEuNjcKPiA+ID4gwqDCoMKgwqAgY3B1
ICUgc3lzwqDCoMKgwqDCoMKgwqDCoMKgIDI3Ljg5wqDCoMKgwqDCoCAyMS44NcKgwqDCoMKgwqDC
oCAyNy4yMwo+ID4gPiDCoMKgwqDCoCBidyBNQi9zwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA4OC4x
MMKgwqDCoMKgwqAgNTIuMTDCoMKgwqDCoMKgwqAgODQuNDgKPiA+ID4gCj4gPiA+IMKgwqAgd3Jp
dGUgLyAxIGpvYsKgwqDCoCBvcmlnaW5hbMKgwqDCoCBhZnRlcsKgwqDCoCB0aGlzIGNvbW1pdAo+
ID4gPiDCoMKgwqDCoCBtaW4gSU9QU8KgwqDCoMKgwqDCoMKgIDYsNTI0LjIwwqDCoCAzLDEzNi4w
MMKgwqDCoCA1LDk4OC40MAo+ID4gPiDCoMKgwqDCoCBtYXggSU9QU8KgwqDCoMKgwqDCoMKgIDcs
MzAzLjYwwqDCoCA1LDE0NC40MMKgwqDCoCA3LDIzMi40MAo+ID4gPiDCoMKgwqDCoCBhdmcgSU9Q
U8KgwqDCoMKgwqDCoMKgIDcsMTY5LjgwwqDCoCA0LDYwOC4yOcKgwqDCoCA3LDAxNC42Ngo+ID4g
PiDCoMKgwqDCoCBjcHUgJSB1c3LCoMKgwqDCoMKgwqDCoMKgwqDCoCAyLjI5wqDCoMKgwqDCoMKg
IDIuMzTCoMKgwqDCoMKgwqDCoCAyLjIzCj4gPiA+IMKgwqDCoMKgIGNwdSAlIHN5c8KgwqDCoMKg
wqDCoMKgwqDCoCA0MS45McKgwqDCoMKgwqAgMzkuMzTCoMKgwqDCoMKgwqAgNDIuNDgKPiA+ID4g
wqDCoMKgwqAgYncgTUIvc8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjguMDLCoMKgwqDCoMKgIDE4
LjAwwqDCoMKgwqDCoMKgIDI3LjQyCj4gPiA+IAo+ID4gPiDCoMKgIHdyaXRlIC8gOCBqb2JzwqDC
oCBvcmlnaW5hbMKgwqDCoCBhZnRlcsKgwqDCoCB0aGlzIGNvbW1pdAo+ID4gPiDCoMKgwqDCoCBt
aW4gSU9QU8KgwqDCoMKgwqDCoCAxMiw2ODUuNDDCoCAxMyw3ODMuMDDCoMKgIDEyLDYyMi40MAo+
ID4gPiDCoMKgwqDCoCBtYXggSU9QU8KgwqDCoMKgwqDCoCAzMCw4MTQuMjDCoCAyMiwxMjIuMDDC
oMKgIDI5LDYzNi4wMAo+ID4gPiDCoMKgwqDCoCBhdmcgSU9QU8KgwqDCoMKgwqDCoCAyMSw1Mzku
MDTCoCAxOCw1NTIuNjPCoMKgIDIxLDEzNC42NQo+ID4gPiDCoMKgwqDCoCBjcHUgJSB1c3LCoMKg
wqDCoMKgwqDCoMKgwqDCoCAyLjA4wqDCoMKgwqDCoMKgIDEuNjHCoMKgwqDCoMKgwqDCoCAyLjA3
Cj4gPiA+IMKgwqDCoMKgIGNwdSAlIHN5c8KgwqDCoMKgwqDCoMKgwqDCoCAzMC44NsKgwqDCoMKg
wqAgMjMuODjCoMKgwqDCoMKgwqAgMzAuNjQKPiA+ID4gwqDCoMKgwqAgYncgTUIvc8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgODQuMTjCoMKgwqDCoMKgIDcyLjU0wqDCoMKgwqDCoMKgIDgyLjYyCj4g
PiAKPiA+IEdpdmVuIHRoZSBzZXZlcmUgcGVyZm9ybWFuY2UgZHJvcCBpbnRyb2R1Y2VkIGJ5IHRo
ZSBjdWxwcml0Cj4gPiBjb21taXQsIGl0IG1pZ2h0IG1ha2Ugc2Vuc2UgdG8gaW5zdGVhZCBqdXN0
IHJldmVydCBpdCBmb3IKPiA+IDYuMTYgbm93LCB3aGlsZSB0aGlzIHBhdGNoIGhlcmUgY2FuIG1h
dHVyZSBhbmQgYmUgcHJvcGVybHkKPiA+IHJldmlld2VkLiBBdCBsZWFzdCB0aGVuIDYuMTYgd2ls
bCBub3QgaGF2ZSBhbnkgcGVyZm9ybWFuY2UKPiA+IHJlZ3Jlc3Npb24gb2Ygc3VjaCBhIHNjYWxl
Lgo+IAo+IFRoZSBvcmlnaW5hbCBjaGFuZ2Ugd2FzIGRlc2lnbmVkIHRvIHN0b3AgdGhlIGludGVy
cnVwdCBoYW5kbGVyCj4gdG8gc3RhcnZlIHRoZSBzeXN0ZW0gYW5kIGNyZWF0ZSBkaXNwbGF5IGFy
dGlmYWN0IGFuZCBjYXVzZQo+IHRpbWVvdXRzIG9uIHN5c3RlbSBjb250cm9sbGVyIHN1Ym1pc3Np
b24uIFdoaWxlIGltcGVyZmVjdCwKPiBpdCB3b3VsZCByZXF1aXJlIHNvbWUgZmluZSB0dW5pbmcg
Zm9yIHNtYWxsZXIgY29udHJvbGxlcnMKPiBsaWtlIG9uIHRoZSBQaXhlbCA2IHRoYXQgd2hlbiBs
ZXNzIHF1ZXVlcy4KCldlbGwsIHRoZSBwYXRjaCBoYXMgc29sdmVkIG9uZSBwcm9ibGVtIGJ5IGNy
ZWF0aW5nIGFub3RoZXIgcHJvYmxlbS4KSSBkb24ndCB0aGluayB0aGF0J3MgaG93IHRoaW5ncyBh
cmUgbm9ybWFsbHkgZG9uZS4gQSA0MCUgYmFuZHdpZHRoCmFuZCBJT1BTIGRyb3AgaXMgbm90IG5l
Z2xpZ2libGUuCgpBbmQgd2hpbGUgSSBhbSByZWZlcmVuY2luZyBQaXhlbCA2IGFib3ZlIGFzIGl0
J3MgdGhlIG9ubHkgZGV2aWNlCkkgaGF2ZSBhdmFpbGFibGUgdG8gdGVzdCwgSSBzdXNwZWN0IGFs
bCA8IHY0IGNvbnRyb2xsZXJzIC8gZGV2aWNlcwphcmUgYWZmZWN0ZWQgaW4gYSBzaW1pbGFyIHdh
eSwgZ2l2ZW4gdGhlIG5hdHVyZSBvZiB0aGUgY2hhbmdlLgoKCkNoZWVycywKQW5kcmUnCg==


