Return-Path: <linux-kernel+bounces-868114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D67ADC04672
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3BC1A083C2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F361D224B1F;
	Fri, 24 Oct 2025 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lToeua0w"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF41FCF7C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761284050; cv=none; b=SOSYeZ+5aCKe7h1rLQbK4tLRiS6tpaIN1xvNVq48dNV4gRk1/ToDLpIY0oFIJUMlkD96ddndb65yj10EYP16Dg+h0Qw2ie+u4Yvgp5jcHCTUBrqaepFcmABCgouoauLhfZE+/jzpCVeRx2Tc6B5u95N2HldJ9m0qbPTzoglPKB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761284050; c=relaxed/simple;
	bh=UdeClZXIUWVGOl1GLOaOrjFt7x8K2F6/WYmVgfCof5o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qLxxGheJBELO2XrDi/r5g9SoOSI+xnVLJcM66xt+XEOCeG9qX76pflnwKzfB4TaFOyFvCQdUgNXNMkkfu1rkQ7Ck5gztNupkli4UzkTO73hQ0rrEe0WFMCJ3DApAzDlhDOpiwTmJYx1zcFIpcm+b/jTb/6ahM1pP/VUOqavslWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lToeua0w; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee130237a8so1024561f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761284046; x=1761888846; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UdeClZXIUWVGOl1GLOaOrjFt7x8K2F6/WYmVgfCof5o=;
        b=lToeua0wnKy2uWrwkX5USdh1nEn/oAy11qnt10CzODHFR4WFIyj+1M5dtM9SEyGn1g
         18FTsudsX19Pw6HnPlgp/UDE7U2O6SzjpPfbDOyfD1kiUjCYeFj6NzgMapxSh/OTIJRB
         J/Kzg5N5eEGrQARQvqBcvPFn9Y4OXL0iF68eum/7Gz8pMtxhddoBH+KYH7k65ioIvQht
         TTOhlCMiFXdRG/V7ofqDO5WO8nx4HhbISKEAN/UQ7gDqWMeNQrVvqsLQnZMsltRRQv96
         zeo9IjwlcBnGxRHMnDp5XeCHIaF73weNLJMF4V7Q+J4+km6KgVQOiGUtCHBuO0SNTdjt
         bY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761284046; x=1761888846;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdeClZXIUWVGOl1GLOaOrjFt7x8K2F6/WYmVgfCof5o=;
        b=ez/G8zeAlLWulzYQsSdfqyS9CSyzTRR/YlHAFCM7Vz4ex8bZaqCTprKCZ2K/JqnLqb
         TYZxMs5Gpxo7oZX6qkzhRsSbAtlSaHlCw2nrrqLBtZABxF/wCAE2jeC8FlfdxQClXU6F
         sNmcn9WQQowooQXPQJ4/onnd/xFE5ofFqsomUMa9+WrGuG0GmR8XXVMUa1l1x3PDFmaR
         vSded/XM1zeRpB/Y/hHP4TXh8R92reQbYM2txYgDjKaVRmoeRKtmgMtjtbVv33OCmbdi
         PfFuy+355WH3e9/grhscWawIdkvrsq450rDmUL5B/+aTYZzXgt/PJqbjh4rVnHm5rTps
         Clmw==
X-Forwarded-Encrypted: i=1; AJvYcCVamq6Q5HqCmBzU/R17/upfQof27K5R2F5tsxNAYE+uE72EAp8UsK5nLKA+7+rmt0stOIwjA/g4GJ2Z7Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrn+r1s0GDq+SjHUZvzMbnvwuXPHPIHyauJzs9mmIXF1pKd2Q
	QqAqsn1/CvMjy06M1U25wAXqo84/cgSrx+CDNffJT+DhP3/UT58QgCs=
X-Gm-Gg: ASbGncvSrTR7hw4jkfqgqiOrY/iZCLg8lfHFZMg6pSxakquEj/gxPgej68j+FbQf4R8
	9TNhHDLl6TKkycTNCif0nXrkuJt1nD72sbBnqnFvjT8gj9dhP1XQE9MyaAtawEIltvwSlCoeenz
	9LtBeIT74X+RGdSckdV1md3g8jco5aAC84guHVnhb7g31G/EaqD/TRrlNS9SujK2E+XqyFr5fA7
	nVU6f4OvkBWfF8wudh7i+l/5EX9noX5GC1SYE59809FBg6Y3KWVuZ0UremhSUe/8V25N/+QKgII
	Ea0U0mIP3eccqfivFPFBBNxbWZwaiJOYWbDd+0WTQxeQt4CBxoe2WqJzz0fsiMWunl/wyU0nEnh
	xVZEiopdOBXx69gdMOpUqa57qQMoYuRnvjVim+QY6WHyrBFJ54g0jsifiGrRgmyQIaR36Xlc2Fn
	nGO9b6C3YM3t8uzckdnCDxxj7nqRAcQq7iYAETE5kJ+nzryV4k0mxOChGF3KOrfUw=
X-Google-Smtp-Source: AGHT+IGTb0BhNtLXZjL89zHnvhnrIYZlTtJyn9gLCubUjapXa+451SyphIYoQs9g+1Ce4F+c0arbCA==
X-Received: by 2002:a05:6000:4011:b0:427:9d7:870f with SMTP id ffacd0b85a97d-4299070199dmr708125f8f.5.1761284045381;
        Thu, 23 Oct 2025 22:34:05 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b41b7.dip0.t-ipconnect.de. [91.43.65.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898acc63sm7417423f8f.27.2025.10.23.22.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 22:34:04 -0700 (PDT)
Message-ID: <045e6362-01db-47f3-9a4f-8a86b2c15d00@googlemail.com>
Date: Fri, 24 Oct 2025 07:34:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [REGRESSION][BISECTED] Screen goes blank with ASpeed AST2300 in
 6.18-rc2
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, regressions@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 jfalempe@redhat.com, airlied@redhat.com, dianders@chromium.org,
 nbowler@draconx.ca, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <20251014084743.18242-1-tzimmermann@suse.de>
 <a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com>
 <43992c88-3a3a-4855-9f46-27a7e5fdec2e@suse.de>
 <798ba37a-41d0-4953-b8f5-8fe6c00f8dd3@googlemail.com>
 <bf827c5c-c4dd-46f1-962d-3a8e2a0a7fdf@suse.de>
 <5f8fba3b-2ee1-4a02-9b41-e6e1de1a507a@googlemail.com>
 <e2462c92-4049-486b-92d7-e78aaec4b05d@suse.de>
 <3ca10b2e-fb9c-4495-9219-5e8537314751@googlemail.com>
 <329a9f97-dd66-49c2-bc42-470566d01539@suse.de>
 <270ce9a3-5067-4ef8-9205-414b5667cf3a@googlemail.com>
Autocrypt: addr=pschneider1968@googlemail.com; keydata=
 xjMEY58biBYJKwYBBAHaRw8BAQdADPnoGTrfCUCyH7SZVkFtnlzsFpeKANckofR4WVLMtMzN
 L1BldGVyIFNjaG5laWRlciA8cHNjaG5laWRlcjE5NjhAZ29vZ2xlbWFpbC5jb20+wpwEExYK
 AEQCGyMFCQW15qgFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQSjgovXlszhGoyt6IZu
 OpLJLD/yRAUCY58b8AIZAQAKCRBuOpLJLD/yRIeIAQD0+/LMdKHM6AJdPCt+e9Z92BMybfnN
 RtGqkdZWtvdhDQD9FJkGh/3PFtDinimB8UOB7Gi6AGxt9Nu9ne7PvHa0KQXOOARjnxuIEgor
 BgEEAZdVAQUBAQdAw2GRwTf5HJlO6CCigzqH6GUKOjqR1xJ+3nR5EbBze0sDAQgHwn4EGBYK
 ACYWIQSjgovXlszhGoyt6IZuOpLJLD/yRAUCY58biAIbDAUJBbXmqAAKCRBuOpLJLD/yRONS
 AQCwB9qiEQoSnxHodu8kRuvUxXKIqN7701W+INXtFGtJygEAyPZH3/vSBJ4A7GUG7BZyQRcr
 ryS0CUq77B7ZkcI1Nwo=
In-Reply-To: <270ce9a3-5067-4ef8-9205-414b5667cf3a@googlemail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------krXW3u9GCz73FBYeJPBWkLil"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------krXW3u9GCz73FBYeJPBWkLil
Content-Type: multipart/mixed; boundary="------------sW3anxa1r6YezvSATKrGS7PM";
 protected-headers="v1"
From: Peter Schneider <pschneider1968@googlemail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, regressions@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 jfalempe@redhat.com, airlied@redhat.com, dianders@chromium.org,
 nbowler@draconx.ca, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <045e6362-01db-47f3-9a4f-8a86b2c15d00@googlemail.com>
Subject: Re: [REGRESSION][BISECTED] Screen goes blank with ASpeed AST2300 in
 6.18-rc2
References: <20251014084743.18242-1-tzimmermann@suse.de>
 <a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com>
 <43992c88-3a3a-4855-9f46-27a7e5fdec2e@suse.de>
 <798ba37a-41d0-4953-b8f5-8fe6c00f8dd3@googlemail.com>
 <bf827c5c-c4dd-46f1-962d-3a8e2a0a7fdf@suse.de>
 <5f8fba3b-2ee1-4a02-9b41-e6e1de1a507a@googlemail.com>
 <e2462c92-4049-486b-92d7-e78aaec4b05d@suse.de>
 <3ca10b2e-fb9c-4495-9219-5e8537314751@googlemail.com>
 <329a9f97-dd66-49c2-bc42-470566d01539@suse.de>
 <270ce9a3-5067-4ef8-9205-414b5667cf3a@googlemail.com>
In-Reply-To: <270ce9a3-5067-4ef8-9205-414b5667cf3a@googlemail.com>

--------------sW3anxa1r6YezvSATKrGS7PM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgVGhvbWFzLA0KDQoNCkFtIDIzLjEwLjIwMjUgdW0gMjE6MTEgc2NocmllYiBQZXRlciBT
Y2huZWlkZXI6DQo+IEhpIFRob21hcywNCj4gDQo+IEFtIDIzLjEwLjIwMjUgdW0gMTQ6NDYg
c2NocmllYiBUaG9tYXMgWmltbWVybWFubjoNCj4gWy4uLl0NCj4+IEkndmUgYmVlbiBhYmxl
IHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbSB3aXRoIGFuIEFTVDIzMDAgdGVzdCBzeXN0ZW0u
IFRoZSBhdHRhY2hlZCBwYXRjaCBmaXhlcyB0aGUgcHJvYmxlbSBmb3IgbWUuIENhbiANCj4+
IHlvdSBwbGVhc2UgdGVzdCBhbmQgcmVwb3J0IG9uIHRoZSByZXN1bHRzPw0KPiANCj4gR3Jl
YXQhIC0gdGhpcyBwYXRjaCBvbiB0b3Agb2YgNi4xOC1yYzIgZml4ZXMgdGhlIGlzc3VlIGZv
ciBtZSwgdG9vLiBUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIGVmZm9ydCENCj4gDQo+IFRl
c3RlZC1ieTogUGV0ZXIgU2NobmVpZGVyIDxwc2NobmVpZGVyMTk2OEBnb29nbGVtYWlsLmNv
bT4NCg0KTWVhbndoaWxlLCBJIGhhdmUgYWxzbyB0ZXN0ZWQgdGhpcyBhZ2FpbnN0IHN0YWJs
ZSA2LjEyLjU1IGFuZCA2LjE3LjUsIHdoZXJlIGluIC1yYzIsIEdyZWcgZHJvcHBlZCB5b3Vy
IG9yaWdpbmFsIHBhdGNoIA0Kd2l0aCB1cHN0cmVhbSBjb21taXQtaWQgNmY3MTkzNzNiOTQz
YTk1NWZlZTZmYzIwMTJhZWQyMDdiNjVlMjg1NCBiZWZvcmUgdGhlIGZpbmFsIHJlbGVhc2Ug
YmVjYXVzZSBvZiBteSByZXBvcnQuDQoNClNvIGZvciBib3RoLCBJIGJ1aWx0IHRoZW0sIG1h
ZGUgc3VyZSBpdCB3b3JrZWQgb2suIFRoZW4gSSBkaWQgImdpdCBjaGVycnktcGljayA2Zjcx
OTM3M2I5NDNhOTU1ZmVlNmZjMjAxMmFlZDIwN2I2NWUyODU0IiANCmFuZCB0ZXN0ZWQgdGhh
dCBpdCBpcyBicm9rZW4gYWdhaW4uIFRoZW4gSSBhcHBsaWVkIHlvdXIgbGFzdCBwYXRjaCBv
biB0b3Agb2YgaXQsIGFuZCBpdCB3b3JrZWQgZmluZSwgc28gd2l0aCB0aGF0IHRoZSANCmlz
c3VlIGlzIGZpeGVkIGluIGJvdGggc3RhYmxlIHZlcnNpb25zLCB0b28uDQoNCklmIHlvdSBz
ZW5kIGEgY29tYmluZWQgcGF0Y2ggdG8gR3JlZyBmb3Igc3RhYmxlLCBwbGVhc2UgZmVlbCBm
cmVlIHRvIGFkZCBteQ0KDQpUZXN0ZWQtYnk6IFBldGVyIFNjaG5laWRlciA8cHNjaG5laWRl
cjE5NjhAZ29vZ2xlbWFpbC5jb20+DQoNCg0KVGhhbmtzIGFnYWluIQ0KDQpCZXN0ZSBHcsO8
w59lLA0KUGV0ZXIgU2NobmVpZGVyDQoNCi0tIA0KQ2xpbWIgdGhlIG1vdW50YWluIG5vdCB0
byBwbGFudCB5b3VyIGZsYWcsIGJ1dCB0byBlbWJyYWNlIHRoZSBjaGFsbGVuZ2UsDQplbmpv
eSB0aGUgYWlyIGFuZCBiZWhvbGQgdGhlIHZpZXcuIENsaW1iIGl0IHNvIHlvdSBjYW4gc2Vl
IHRoZSB3b3JsZCwNCm5vdCBzbyB0aGUgd29ybGQgY2FuIHNlZSB5b3UuICAgICAgICAgICAg
ICAgICAgICAtLSBEYXZpZCBNY0N1bGxvdWdoIEpyLg0KDQpPcGVuUEdQOiAgMHhBMzgyOEJE
Nzk2Q0NFMTFBOENBREU4ODY2RTNBOTJDOTJDM0ZGMjQ0DQpEb3dubG9hZDogaHR0cHM6Ly93
d3cucGV0ZXJzLW5ldHpwbGF0ei5kZS9kb3dubG9hZC9wc2NobmVpZGVyMTk2OF9wdWIuYXNj
DQpodHRwczovL2tleXMubWFpbHZlbG9wZS5jb20vcGtzL2xvb2t1cD9vcD1nZXQmc2VhcmNo
PXBzY2huZWlkZXIxOTY4QGdvb2dsZW1haWwuY29tDQpodHRwczovL2tleXMubWFpbHZlbG9w
ZS5jb20vcGtzL2xvb2t1cD9vcD1nZXQmc2VhcmNoPXBzY2huZWlkZXIxOTY4QGdtYWlsLmNv
bQ0KDQo=

--------------sW3anxa1r6YezvSATKrGS7PM--

--------------krXW3u9GCz73FBYeJPBWkLil
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSjgovXlszhGoyt6IZuOpLJLD/yRAUCaPsPywUDAAAAAAAKCRBuOpLJLD/yRMTK
AQDvnxYz2SoIs89+Y3maGD8FqHLRNa/qNgyLwgJi8LTPgAEAz53/dKzJ2V6mQEzWOU1q434RwUzW
ArPxnqW9ZjujIwc=
=oSt3
-----END PGP SIGNATURE-----

--------------krXW3u9GCz73FBYeJPBWkLil--

