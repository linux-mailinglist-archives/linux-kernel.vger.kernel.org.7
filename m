Return-Path: <linux-kernel+bounces-778386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E610B2E4D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACC7162A35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DCC278E7C;
	Wed, 20 Aug 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HA/ybv69"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601DC36CE0C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714113; cv=none; b=houP/hzX6CpL7H8aeG2j8oZVKgVn9Suua/Tjpks78HMu0xXk1NHMpPLCN6VZNT4xLzo2EJCN5KUojET/jzsOTgYVrizZwsIcXlfclyl92FDbmQVD0BpuYTMZS9SrN9YlNOWBTx8ygAkF2jLdufh8eZ6wtaGL4N2aaL3/sKNyoS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714113; c=relaxed/simple;
	bh=9u3eJc+Cr/HD2IRm8IYQ1qswckEy9jtZ6vbP4NpLR30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naTNiXMYAg4I0T/22Pb2hZgV1N6u5+5x7sC2QzlchVYozljrOmAhvSlCH0G+3cvTEH53iEZLhLfb2gR7RKneLvxnQnCXZXqMHr60a8y17gNCD7CfOkNcLd+4pMDQapgcYDQo+ORjvvi1B3/awiTHRLoUIVv9fRMxICl44NzuVtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HA/ybv69; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109c482c8so3546321cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755714111; x=1756318911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9u3eJc+Cr/HD2IRm8IYQ1qswckEy9jtZ6vbP4NpLR30=;
        b=HA/ybv69C2EJIgkjvUOPaQ4k5vqTGMzxIB3+668Yu0PmHIL5KF+F2X/lpW8TfzbejS
         74kwjRDHYnCErSbTFq3eGvj/j1AA6hHLJPkIhvjrTbtu6Jh08U2OVAApqrZ1YSvVhYSl
         xE2MUYUWYNzUnJEvhBmODfR1QNsE6N/oY+r6dhq2Bkh37SLPkh2O3/ZUJlldJSSfTO6p
         UKtc9+fDAGwEDkGn6RT9alr75JfnTjHR6vmoB/DoxlH/Hx1DNXvHZ8URob2IrFZ03iix
         UOOGtg/FSzkS0U/ANC/HcOt2OA0+Rq8fE8UTvvkqHBdYf2U4xAVYYQPoZsZj6c2uF+Bp
         LLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755714111; x=1756318911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9u3eJc+Cr/HD2IRm8IYQ1qswckEy9jtZ6vbP4NpLR30=;
        b=xHltEXrSNmpOAoC04BKAeZb27vZDew+WB3qoHl5FHyjuFy+YvawLpgzv3xnF44ePme
         /38UI2zkz/UtTcPv7rp7lJZTWlC6eL3NT3IBbcQzTIBNp7oKh/Gd0IzLsshhJbUH9HTu
         DQsAjNiWsGhb3u1vg1NnFokDoQndBqtU2viKhpZy7zVhBN/WP1TKmvJwHc42HEa4VCr9
         L5XqR4BS9COkeiwZE5gxpSXYLLZOFpq5jdQlJYx5y7nTT9gesE0yC8dmLsCI09sgU7dk
         hJQvyEMoYaGmMeLXeThJTjcujmUG23uHFBTEe+8wvjYwdRHqIUFy/TxG5gRD70CUFP5g
         nLIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXI4acmQZ3CQObu9VP45hQN+QQ/MKGFdtIvVr5c0nQ0nl1ggSs8HE3DYyv/Ywo53spVI7yADIQVhtc1ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzENGRaOovgTNxL/Yklcx98TYnTYQII1d0LjL1XCNgm/hZMTQ14
	4LNUBUKEYLXuPwqOaITE2DBdgFhJnWW5WLDei2C9EGPKY7D546dGhV+D9JIE7/1w/TNlbTpHLCl
	ZDX+rVZWKz98FT8YsCExBm/U+H4YBsSN35ag7JPXm
X-Gm-Gg: ASbGncuj0wwN5oKmi5Ie+BXICGFxsK6HBNKrVsXYWFwpvnxa8+wYApqqH3Gged7yJXh
	FzFFgYQZZx8FsIwXzjWkBazHbOcyZXhjQjpZkvLpFLJzLB8VhjzSa/XLunmlrH0c6UYiOB2LhAU
	S0ilzy+wXibDFL/w60z0SqD737zUmqy9/qe0Bh1psBKpnjOTbKKwGlC/rBETTZRmRGBak9NM1UM
	tI5pSW8AlKh75egn3JyXk6D5Q==
X-Google-Smtp-Source: AGHT+IFtN+kEQBkHVHFlDdHu9xL7iEVvs85IioqCBHEdG4+4w39Pga2xsI9hPIBI84cgx4pD5AL0C4f9XVOfwzVus+0=
X-Received: by 2002:a05:622a:1cc9:b0:4b2:8ac5:27c3 with SMTP id
 d75a77b69052e-4b291c40309mr49861031cf.78.1755714110904; Wed, 20 Aug 2025
 11:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819082842.94378-1-acsjakub@amazon.de>
In-Reply-To: <20250819082842.94378-1-acsjakub@amazon.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Aug 2025 11:21:39 -0700
X-Gm-Features: Ac12FXwJD1Q9uldV_MwNTRIlw_umA48L2xrMHQZoMdQq8LUL1LtWz7MkR21uLbw
Message-ID: <CANn89i+pRcoUO5_VeS9evwPJrNaa=8H2=p7=Fo3oJCENV0019g@mail.gmail.com>
Subject: Re: [PATCH] net, hsr: reject HSR frame if skb can't hold tag
To: Jakub Acs <acsjakub@amazon.de>
Cc: netdev@vger.kernel.org, aws-security@amazon.com, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, security@kernel.org, 
	stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBBdWcgMTksIDIwMjUgYXQgMToyOOKAr0FNIEpha3ViIEFjcyA8YWNzamFrdWJAYW1h
em9uLmRlPiB3cm90ZToNCj4NCj4gUmVjZWl2aW5nIEhTUiBmcmFtZSB3aXRoIGluc3VmZmljaWVu
dCBzcGFjZSB0byBob2xkIEhTUiB0YWcgaW4gdGhlIHNrYg0KPiBjYW4gcmVzdWx0IGluIGEgY3Jh
c2ggKGtlcm5lbCBCVUcpOg0KPg0KPiBbICAgNDUuMzkwOTE1XSBza2J1ZmY6IHNrYl91bmRlcl9w
YW5pYzogdGV4dDpmZmZmZmZmZjg2ZjMyY2FjIGxlbjoyNiBwdXQ6MTQgaGVhZDpmZmZmODg4MDQy
NDE4MDAwIGRhdGE6ZmZmZjg4ODA0MjQxN2ZmNCB0YWlsOjB4ZSBlbmQ6MHgxODAgZGV2OmJyaWRn
ZV9zbGF2ZV8xDQo+IFsgICA0NS4zOTI1NTldIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0t
LS0tLS0tLQ0KPiBbICAgNDUuMzkyOTEyXSBrZXJuZWwgQlVHIGF0IG5ldC9jb3JlL3NrYnVmZi5j
OjIxMSENCj4gWyAgIDQ1LjM5MzI3Nl0gT29wczogaW52YWxpZCBvcGNvZGU6IDAwMDAgWyMxXSBT
TVAgREVCVUdfUEFHRUFMTE9DIEtBU0FOIE5PUFRJDQo+IFsgICA0NS4zOTM4MDldIENQVTogMSBV
SUQ6IDAgUElEOiAyNDk2IENvbW06IHJlcHJvZHVjZXIgTm90IHRhaW50ZWQgNi4xNS4wICMxMiBQ
UkVFTVBUKHVuZGVmKQ0KPiBbICAgNDUuMzk0NDMzXSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5k
YXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyByZWwtMS4xNi4zLTAtZ2E2ZWQ2Yjcw
MWYwYS1wcmVidWlsdC5xZW11Lm9yZyAwNC8wMS8yMDE0DQo+IFsgICA0NS4zOTUyNzNdIFJJUDog
MDAxMDpza2JfcGFuaWMrMHgxNWIvMHgxZDANCj4NCj4gPHNuaXAgcmVnaXN0ZXJzLCByZW1vdmUg
dW5yZWxpYWJsZSB0cmFjZT4NCj4NCj4NCj4gVGhpcyBpc3N1ZSB3YXMgZm91bmQgYnkgc3l6a2Fs
bGVyLg0KPg0KPiBUaGUgcGFuaWMgaGFwcGVucyBpbiBicl9kZXZfcXVldWVfcHVzaF94bWl0KCkg
b25jZSBpdCByZWNlaXZlcyBhDQo+IGNvcnJ1cHRlZCBza2Igd2l0aCBFVEggaGVhZGVyIGFscmVh
ZHkgcHVzaGVkIGluIGxpbmVhciBkYXRhLiBXaGVuIGl0DQo+IGF0dGVtcHRzIHRoZSBza2JfcHVz
aCgpIGNhbGwsIHRoZXJlJ3Mgbm90IGVub3VnaCBoZWFkcm9vbSBhbmQNCj4gc2tiX3B1c2goKSBw
YW5pY3MuDQo+DQo+IFRoZSBjb3JydXB0ZWQgc2tiIGlzIHB1dCBvbiB0aGUgcXVldWUgYnkgSFNS
IGxheWVyLCB3aGljaCBtYWtlcyBhDQo+IHNlcXVlbmNlIG9mIHVuaW50ZW5kZWQgdHJhbnNmb3Jt
YXRpb25zIHdoZW4gaXQgcmVjZWl2ZXMgYSBzcGVjaWZpYw0KPiBjb3JydXB0ZWQgSFNSIGZyYW1l
ICh3aXRoIGluY29tcGxldGUgVEFHKS4NCj4NCj4gRml4IGl0IGJ5IGRyb3BwaW5nIGFuZCBjb25z
dW1pbmcgZnJhbWVzIHRoYXQgYXJlIG5vdCBsb25nIGVub3VnaCB0bw0KPiBjb250YWluIGJvdGgg
ZXRoZXJuZXQgYW5kIGhzciBoZWFkZXJzLg0KPg0KPiBBbHRlcm5hdGl2ZSBmaXggd291bGQgYmUg
dG8gY2hlY2sgZm9yIGVub3VnaCBoZWFkcm9vbSBiZWZvcmUgc2tiX3B1c2goKQ0KPiBpbiBicl9k
ZXZfcXVldWVfcHVzaF94bWl0KCkuDQo+DQo+IEluIHRoZSByZXByb2R1Y2VyLCB0aGlzIGlzIGlu
amVjdGVkIHZpYSBBRl9QQUNLRVQsIGJ1dCBJIGRvbid0IGVhc2lseQ0KPiBzZWUgd2h5IGl0IGNv
dWxkbid0IGJlIHNlbnQgb3ZlciB0aGUgd2lyZSBmcm9tIGFkamFjZW50IG5ldHdvcmsuDQo+DQo+
IEZ1cnRoZXIgRGV0YWlsczoNCj4NCj4gSW4gdGhlIHJlcHJvZHVjZXIsIHRoZSBmb2xsb3dpbmcg
bmV0d29yayBpbnRlcmZhY2UgY2hhaW4gaXMgc2V0IHVwOg0KPg0KPiDilIzilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJAgICDilIzilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJANCj4g4pSCIHZldGgwX3RvX2hz
ciAgIOKUnOKUgOKUgOKUgOKUpCAgaHNyX3NsYXZlMCAgICDilLzilIDilIDilIDilJANCj4g4pSU
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAg4pSU
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAg4pSC
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiDilIzilIDi
lIDilIDilIDilIDilIDilJANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAg4pSc4pSA4pSkIGhzcjAg4pSc4pSA4pSA4pSA4pSQDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiDilJTilIDilIDilIDilIDilIDilIDilJggICDi
lIINCj4g4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSQICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSQICAg4pSCICAgICAgICAgICAg4pSC4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQo+
IOKUgiB2ZXRoMV90b19oc3IgICDilLzilIDilIDilIDilKQgIGhzcl9zbGF2ZTEgICAg4pSc4pSA
4pSA4pSA4pSYICAgICAgICAgICAg4pSU4pSkICAgICAgICDilIINCj4g4pSU4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAg4pSU4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAgICAgICAgICAgICAgIOKU
jOKUvCBicmlkZ2Ug4pSCDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICDilILilIIgICAgICAgIOKUgg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg4pSC4pSU4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSYDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICDilIINCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkCAgICAgIOKUgg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAg4pSCICAuLi4gIOKUnOKUgOKUgOKUgOKUgOKUgOKU
gOKUmA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg4pSU4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSYDQo+DQo+IFRvIHRyaWdnZXIgdGhlIGV2ZW50cyBsZWFkaW5nIHVw
IHRvIGNyYXNoLCByZXByb2R1Y2VyIHNlbmRzIGEgY29ycnVwdGVkDQo+IEhTUiBmcmFtZSB3aXRo
IGluY29tcGxldGUgVEFHLCB2aWEgQUZfUEFDS0VUIHNvY2tldCBvbiAndmV0aDBfdG9faHNyJy4N
Cj4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWt1YiBBY3MgPGFjc2pha3ViQGFtYXpvbi5kZT4NCj4g
Q2M6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCj4gQ2M6IEpha3ViIEtpY2lu
c2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+IENjOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5j
b20+DQo+IENjOiBzZWN1cml0eUBrZXJuZWwub3JnDQo+IENjOiBzdGFibGVAa2VybmVsLm9yZw0K
PiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29v
Z2xlLmNvbT4NCg==

