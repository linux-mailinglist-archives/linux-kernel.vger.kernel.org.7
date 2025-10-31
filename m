Return-Path: <linux-kernel+bounces-880498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD32C25E67
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E043B53CC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955E2E7659;
	Fri, 31 Oct 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JN78CLS3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D38027E040
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925929; cv=none; b=rw0qTVcJCKGdomh7pEu6KYTTbNlDqTI0wu6VYsvLD8tdmnynUe/AWWsvTQ5qDLfHWMBVNnA/EjpfHYoyQ4tBkJ3L76PdTyFvveTXjfzzo4dLDPCISnknlN+pN6KIGjruSAi8gOiDTf8a5EVPyPDd2+BY4OLWn4oLD5is5iFxHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925929; c=relaxed/simple;
	bh=QumGIqvgGxvWAzZUq8O0rMEX39U7yzIGyuI4sneF6rE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=idvsxnMuC9RqnakZ/34oL63B2rm8Vgfp3fzKADfHn9iabEgdYX5FCUMzQw2SplWF6VM7XWYKx9/IZHU/NsbqTm+HMVzyQ8ibDI4DhY9y3JAf80DdbYOFuarUI0ylHSBZuECYla4l3gvimYZ34lR2wH8HaMBJaOP3vCayXQANQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JN78CLS3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761925924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QumGIqvgGxvWAzZUq8O0rMEX39U7yzIGyuI4sneF6rE=;
	b=JN78CLS3xcsXjEhGpIe/XZUxiQeMxstFfXegf0BB50EVz+MVJ7DtWsH1BzPY2fB7xJqElX
	c2Y0E5jigtIh/SrtjkOIFRsFJEd8UmWwRyq/bpYdvJePHj47TYRxap3hOdBJB0Y72IwfUL
	K64FoWorf+RNlcEvp1LXYjlz2rLezXs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-tPFdKjj0PdKKMyypeP512Q-1; Fri, 31 Oct 2025 11:52:02 -0400
X-MC-Unique: tPFdKjj0PdKKMyypeP512Q-1
X-Mimecast-MFC-AGG-ID: tPFdKjj0PdKKMyypeP512Q_1761925921
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475db4369b1so13080085e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761925921; x=1762530721;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QumGIqvgGxvWAzZUq8O0rMEX39U7yzIGyuI4sneF6rE=;
        b=RWfVJMzJPu3lgtwhLUyc6pxQiQn/ma3//LsIRQzUtuD9tMxlzO0iRFBo1i7rKyQi7x
         aCF0N3F3d38d7GMAQEFnlzGDzEgb/yi+sv2txaxXtJ7EyuJrwvafvFT50Dsykw1OWyLO
         gyP85tbkVz8N4DMM0xkAN6DpK93KzEgXu55jpxtxkfgj4KVY4FRiSXvZ1dk6J1ua3yIT
         qQrHowqmKt8pHEikPSZqpN+9rVWNWVVxg7vlaCWclvM2Ez2X3uZBOZHMREwHPB6bsZEe
         EVZV8H37nYq0/1ldQEifvHKVpgpZUc8LUZUOx+dVprOzRlBElKpa2rc9ps2mrnPxfEtC
         QKsA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Sh5FyP13e5/lFHaTtfFT4TmfhabzLkU+ks/1i0yDAoC7rt8HDdBvALeLUs/q5fsGJT+8pvbfjTPo2qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/opcPorY5X3PWQJRA/sYtJNrjyiqrxiUAVSeHA229PFtlEvk
	RI3XbmPXUzCMAF3vntJn4wirjBy0RIWemHGbCcIIEARogPPDT1TI83DaYnQowFVNar3kNk4bPl9
	rFhx8yLplzWZP1NsdbzqDgG5LrmH9+gO0O+9s+vQHr8XqS+Qqhx/AKn6FfAGDi/7QPQ==
X-Gm-Gg: ASbGncujaHtkyVydy1tDxg67d5PTaSHBHc9jyFqk0sCvF9Ja3vDCtrJk+AsQocw1Xg4
	+tKBpJcT3JsAweOf76tyum07D6LRaNM1yvOGFuOPVhShJVqXKaqpAcOBNp6Hi/y/rwTEuVCqgfj
	4oqVkXB+m2Aj/1YVwdzhYeLvH3M+Qa4XP4LED+MAAo6y0Pr8qtMuu9DFQl7cY/q5kNPdKmqDOzd
	hjgP1P8jrGXtJpOOzn3Ghou/u5neVcTUMUiNL8dkv5sz9hp9szs2z7atOkmd+XabQ2t0znc0Bk9
	TJlhxbM07i66fLtWLGF0nO2wOhKo/yCSmKWFEKgRrmj3GPoiRMJvAQGhZ1TunfYNZV186UDyF98
	way86MfFTW7DtmLJekAAw4o9H
X-Received: by 2002:a05:600c:6389:b0:475:de05:6611 with SMTP id 5b1f17b1804b1-47730793c68mr40296235e9.7.1761925921401;
        Fri, 31 Oct 2025 08:52:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEodiKZAMnW8ziu5veojuaGvSdkNGGVPcTkN/bSNPeRDvvGuj3/AjfsF0cMaiQqEPebvLitkA==
X-Received: by 2002:a05:600c:6389:b0:475:de05:6611 with SMTP id 5b1f17b1804b1-47730793c68mr40295925e9.7.1761925920996;
        Fri, 31 Oct 2025 08:52:00 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fbbf20csm24352185e9.3.2025.10.31.08.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:51:59 -0700 (PDT)
Message-ID: <6c8c276e3e69da824dec179b68e6c120d1426a4a.camel@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, Ingo
 Molnar <mingo@redhat.com>, Clark Williams <williams@redhat.com>,
 arighi@nvidia.com
Date: Fri, 31 Oct 2025 16:51:58 +0100
In-Reply-To: <20251031154455.GU3245006@noisy.programming.kicks-ass.net>
References: <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>
	 <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
	 <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>
	 <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
	 <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>
	 <20251030184205.GB2989771@noisy.programming.kicks-ass.net>
	 <20251031130543.GV4068168@noisy.programming.kicks-ass.net>
	 <1f2ad071e59db2ed8bc0b382ae202b7474d07afc.camel@redhat.com>
	 <20251031152005.GT3245006@noisy.programming.kicks-ass.net>
	 <2daa2e6217eeaa239616303626c0d73d808ae947.camel@redhat.com>
	 <20251031154455.GU3245006@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ck9uIEZyaSwgMjAyNS0xMC0zMSBhdCAxNjo0NCArMDEwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6
Cj4gT24gRnJpLCBPY3QgMzEsIDIwMjUgYXQgMDQ6NDE6MjJQTSArMDEwMCwgR2FicmllbGUgTW9u
YWNvIHdyb3RlOgo+IAo+ID4gPiBIdW1tLCBsZXQgbWUgbm9vZGxlIGEgYml0IG1vcmUgb24gdGhp
cy4gQWxzbywgSSBzaG91bGQgc2VlIGlmIEkgY2FuIGdldAo+ID4gPiBncmFwaHZpeiB0byBkcmF3
IGFzY2lpIGFydCBzdGF0ZSBkaWFncmFtcyA6LSkKPiA+IAo+ID4gRG90IGRvZXNuJ3QgZG8gaXQg
YnV0IGdyYXBoLWVhc3kgZG9lcyByZWFzb25hYmx5IHdlbGwuCj4gCj4geWVwLCBqdXN0IGZvdW5k
IHRoYXQuIFNlZW1zIHRvIHdvcmsgd2VsbDoKPiAKCk5pY2UhIFRoaXMgY2FuIGJlY29tZSBhbHNv
IGEgbW9kZWwgYnkgdGhlIHdheS4gQnV0IEknZCBuZWVkIGEgZmV3IG1vcmUKdHJhY2Vwb2ludHMg
OykKCj4gCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgIEE6aW5pdMKgwqDCoMKgwqDC
oMKgIHwgPCsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSvCoCB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTpkbF9zZXJ2ZXJfc3RhcnTCoMKgwqDCoCB8IDQ6
cGlja190YXNrX2RsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8Cj4gwqDCoMKgIDI6dXBkYXRlX2N1cnJfZGxfc2XCoMKgICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tK8KgIHwKPiDCoCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSB8wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCB8Cj4gwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCBCOnplcm9fbGF4aXR5LXdhaXTCoCB8wqAgfAo+
IMKgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0+IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCA8Ky0tLS0tLS0tLS0tLS0tLS0tLSsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCArLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSvCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgMzpkbF9zZXJ2ZXJfdGltZXLCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0rwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfAo+IMKg
ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0+IHzCoMKgwqDCoMKgIEM6cnVubmluZ8KgwqDCoMKgwqDC
oCB8IC0rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gMjp1cGRhdGVfY3Vy
cl9kbF9zZQo+IMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHwKPiDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiDCoCB8IDY6ZGxfc2VydmVy
X3RpbWVywqDCoMKgwqDCoMKgIHwgNTp1cGRhdGVfY3Vycl9kbF9zZcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4g
wqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICstLS0tLS0t
LS0tLS0tLS0tLS0tLS0tK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fAo+IMKgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tIHzCoMKgwqDCoCBEOnJlcGxlbmlzaMKgwqDC
oMKgwqAgfCAtLS0tLS0tLS0tLS0tLS0tLS0tLSsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKPiAKPiBB
bnl3YXksIGJhY2sgdG8gbm9vZGxpbmcgb24gaG93IHRvIG1ha2UgaXQgc3RvcCBvbiBpZGxlIDot
KQo=


