Return-Path: <linux-kernel+bounces-778560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0924B2E762
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8125A014B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7CF26E71E;
	Wed, 20 Aug 2025 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xHJ/lEE2"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60B91E49F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724701; cv=none; b=SHoFVotnP7acqXnRgEjIz7GRwkQRJqxM+tWSqBfWQAf603JkjfDTA3/QN92TqpTtWrPDBQRpwDP0BX2RtXJ4ZJMVgOHv98nqn9QxK+UOKc3htLQl5mJwdlzOK1PsquYHKbie2iNAUAGT/z6IOzKaEcW0+xDK263GfXzv7c7RtAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724701; c=relaxed/simple;
	bh=P2sI+EmkGPgxhQKQRdeihx9n+/PXLkEt2V+3lWG3atQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GSP2wxCOVHQWsBCEHa+L8wwAgMH1s2Lg5qGy8oEezA+wuTyN38ZwWrShQluokIzIX+Z5e0l/BkV2peCxSuZ8ejEZ6W5VjT0CvhIMnaXOr+BmdWxMSNq1HzNQF8IhiWq3CVbXeHeLTkmp8ochPDveW2uNEGdxytP0Zokq1sINSYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xHJ/lEE2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e9a98b4so257490b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755724699; x=1756329499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:user-agent
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2sI+EmkGPgxhQKQRdeihx9n+/PXLkEt2V+3lWG3atQ=;
        b=xHJ/lEE2YZbgGShgc7S8ufP7tbOLpK+p5ItZ1XinD635zg+MGnFOd9gchA5cNW7NhE
         QSUHA32gN12fE0QhapzGcMBBLUWQrqihUH0fvqEiESNlZ2wLum5AC87dmDBICCTen8nw
         q9OGykL6QKws/Sx0+WaYkMW7dEcIaZMoQ3hjLxITFa/TKpXWWXlbGdGgxXYNyj98e+I3
         rznSAf5XUQEeW3XF1vOvyvR4PhmfrTPWkL2sIX2GBTYq2z8ia863/rVETvTL2XWNQKJg
         A2dow8toChrvCbhz/8mvfmgdBo7Kayqg/qagJsW614AQJmd4LqfruyesROlzo9bA88ER
         oLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755724699; x=1756329499;
        h=content-transfer-encoding:cc:to:from:subject:message-id:user-agent
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P2sI+EmkGPgxhQKQRdeihx9n+/PXLkEt2V+3lWG3atQ=;
        b=f4sA0kOnkzP+XeHcm23rPUzRknFMgkls/SF8NmtEspgAgRym6ZPdFd/lE8Ve+2HmzI
         X5yak4ZoZ5LrQTobZSnoqtpLq+TCn7cTzZHzMB1+I4vnkWXxTwzLfKfj89nqjqY147M7
         qgzE3U2a1LcyYceVi/zy0ILTNiCAEb4Hc5GgIWIvki56Lc4GQ3gn0eNchvYoLjEstGag
         8Cl14dXhHbQKg8V48Fdy572L9PoUD6zS6aIH8rFRp4cv1uX6y8WspMSPa1FRqZ9IAK9R
         SCpS75vK/JrLXxX1gEdSyPbNweZx0dPpPUBuhvFySKrBgzjiVV1JmAitbWhfYNauy9Ak
         DEug==
X-Forwarded-Encrypted: i=1; AJvYcCXM2NGhAuiN5vqLUBrgdOXjcM1DF1nPmnYwRpusJhWTZSsHQVZc2fXpkkJI+z5Wj06AHhw8gFfq1xBkR7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxILd5ffTGAyhF/JTCiJ/iTP3Jqj0yo0UCsHl1/Gdshrf05xrVf
	Lik2lnU92OqF2l/D6Wr4cGHKdYrlYs+69EQNt2ZBJkdxVKPKLPstxI57cSnDd21BkwgjdBW4Xiv
	UInchyVqBow==
X-Google-Smtp-Source: AGHT+IGfZP+wKkOwbvIAFQDDRrNs531sY6ekAT/1sq8Dm++Un59KxoImN/CEr2ujCu8EtL5kcx22ioHf3ZVg
X-Received: from pfbhc8.prod.google.com ([2002:a05:6a00:6508:b0:76e:7044:f5e6])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2a8:b0:76e:8bb8:b1b8
 with SMTP id d2e1a72fcca58-76ea303345fmr42111b3a.7.1755724699067; Wed, 20 Aug
 2025 14:18:19 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:18:17 -0700
In-Reply-To: <20250820201612.2549797-1-cmllamas@google.com> (via kernel-team's
 message of "Wed, 20 Aug 2025 20:16:11 +0000")
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250820201612.2549797-1-cmllamas@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8a53t7kva.fsf@ynaffit-alt.c.googlers.com>
Subject: Re: [PATCH] drm/xe: replace basename() with portable strrchr()
From: Tiffany Yang <ynaffit@google.com>
To: "'Carlos Llamas' via kernel-team" <kernel-team@android.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, 
	"=?utf-8?Q?Thomas_Hellstr?= =?utf-8?Q?=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matt Atwood <matthew.s.atwood@intel.com>, Carlos Llamas <cmllamas@google.com>, 
	linux-kernel@vger.kernel.org, 
	"open list:INTEL DRM XE DRIVER (Lunar Lake and newer)" <intel-xe@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

IidDYXJsb3MgTGxhbWFzJyB2aWEga2VybmVsLXRlYW0iIDxrZXJuZWwtdGVhbUBhbmRyb2lkLmNv
bT4gd3JpdGVzOg0KDQo+IENvbW1pdCBiMGEyZWU1NTY3YWIgKCJkcm0veGU6IHByZXBhcmUgeGVf
Z2VuX3dhX29vYiB0byBiZSBtdWx0aS11c2UiKQ0KPiBpbnRyb2R1Y2VkIGEgY2FsbCB0byBiYXNl
bmFtZSgpLiBUaGUgR05VIHZlcnNpb24gb2YgdGhpcyBmdW5jdGlvbiBpcyBub3QNCj4gcG9ydGFi
bGUgYW5kIGZhaWxzIHRvIGJ1aWxkIHdpdGggYWx0ZXJuYXRpdmUgbGliYyBpbXBsZW1lbnRhdGlv
bnMgbGlrZQ0KPiBtdXNsIG9yIGJpb25pYy4gVGhpcyBjYXVzZXMgdGhlIGZvbGxvd2luZyBidWls
ZCBlcnJvcjoNCg0KPiAgICBkcml2ZXJzL2dwdS9kcm0veGUveGVfZ2VuX3dhX29vYi5jOjEzMDox
MjogZXJyb3I6IGFzc2lnbm1lbnQgdG8g4oCYY29uc3QgIA0KPiBjaGFyICrigJkgZnJvbSDigJhp
bnTigJkgbWFrZXMgcG9pbnRlciBmcm9tIGludGVnZXIgd2l0aG91dCBhIGNhc3QgIA0KPiBbLVdp
bnQtY29udmVyc2lvbl0NCj4gICAgICAxMzAgfCAgICAgICAgIGZuID0gYmFzZW5hbWUoZm4pOw0K
PiAgICAgICAgICB8ICAgICAgICAgICAgXg0KDQo+IFdoaWxlIGEgUE9TSVggdmVyc2lvbiBvZiBi
YXNlbmFtZSgpIGNvdWxkIGJlIHVzZWQsIGl0IHdvdWxkIHJlcXVpcmUgYQ0KPiBzZXBhcmF0ZSBo
ZWFkZXIgcGx1cyB0aGUgYmVoYXZpb3IgZGlmZmVycyBmcm9tIEdOVSB2ZXJzaW9uIGluIHRoYXQg
aXQNCj4gbWlnaHQgbW9kaWZ5IGl0cyBhcmd1bWVudC4gTm90IGdyZWF0Lg0KDQo+IEluc3RlYWQg
cmVwbGFjZSBiYXNlbmFtZSgpIHdpdGggYSBzdHJyY2hyKCkgYmFzZWQgaW1wbGVtZW50YXRpb24g
d2hpY2gNCj4gcHJvdmlkZXMgdGhlIHNhbWUgZnVuY3Rpb25hbGl0eSBhbmQgYXZvaWQgcG9ydGFi
aWxpdHkgaXNzdWVzLg0KDQpOaXQ6IHMvYXZvaWQvYXZvaWRzLiBPdGhlciB0aGFuIHRoYXQsDQoN
Cg0KPiBGaXhlczogYjBhMmVlNTU2N2FiICgiZHJtL3hlOiBwcmVwYXJlIHhlX2dlbl93YV9vb2Ig
dG8gYmUgbXVsdGktdXNlIikNCj4gU2lnbmVkLW9mZi1ieTogQ2FybG9zIExsYW1hcyA8Y21sbGFt
YXNAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3hlL3hlX2dlbl93YV9v
b2IuYyB8IDQgKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCg0KDQpSZXZpZXdlZC1ieTogVGlmZmFueSBZYW5nIDx5bmFmZml0QGdvb2dsZS5j
b20+DQoNCi0tIA0KVGlmZmFueSBZLiBZYW5nDQo=

