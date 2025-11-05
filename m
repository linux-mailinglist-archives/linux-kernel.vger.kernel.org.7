Return-Path: <linux-kernel+bounces-885662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB269C339E8
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883293BAEBA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50B91DED63;
	Wed,  5 Nov 2025 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="F6RwuUPb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0FANijnH"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E20145355
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305418; cv=none; b=oyptLhY7dpA5+2ikGZ3USyVHXd/tIqO8CxyeliktBhtCZGX/8OZW9R577cKX60BWM4sMXd4dr68lXM8MMQXnc++gNblfq0Swl+YBU2ecvALR0ZTCJC9WDLK6cexG274YpwQYcSVO4z4ElCaYo2rEU2aU6+8OECNz8wwbO0oQ2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305418; c=relaxed/simple;
	bh=SEiM+3wEoG3UcWjkwb5EEQVRIf6Q/yddrFAfrhkMCNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uY6opCSk1lcjSEOuvvwmuYDzzpqz1F3SXN5hWXa8QtPTa5wZMIIK1UtgcfeeoP1otdOAzo0m+eL4+p6nmKbzjGm7ifWhRC7Nyukdg2+e+9WNdiOr8xAaEdpUsEIQ9cpuYhbc3m8LyHkdRpbxRAUaPr1zRo119KMKsRRZnwn+u0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=F6RwuUPb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0FANijnH; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 55C5D7A0050;
	Tue,  4 Nov 2025 20:16:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 04 Nov 2025 20:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762305415;
	 x=1762391815; bh=SEiM+3wEoG3UcWjkwb5EEQVRIf6Q/yddrFAfrhkMCNA=; b=
	F6RwuUPbA8hc73G6I44xz23OMsSuvNCPOWjMQKJKX/LAMGVafgD/WfpsnCE/ZJEx
	YH7Ivv4IuCESkS5va4XEEeECW8BqmD7oya557D5Z5x8qbRbu1CIb9yCXUKwts8RN
	UMn5iS2PtipsdVts+FsznDOVgsGjZj3ENNjdrYURdMoeRkjKSXS99G3T3gBOc68L
	l7e892P0GGlNL4iXcvCt8fH7mP1z+X0wpb6gMFFmZ04IHRZLy8hXhsip4XEqIApu
	kaHqpX6OC3f26BIicAwoSddYL8x/EMIPfeZ8K4PZjZco3BitOtWBJ3rjc5TJ5vyF
	sbpA8bz6ljzFPrIH48L5MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762305415; x=1762391815; bh=SEiM+3wEoG3UcWjkwb5EEQVRIf6Q/yddrFA
	frhkMCNA=; b=0FANijnHuNFiDI/dvuO413x/2Y8jTvwhPziCvpdFmLTX3K/vMbX
	Gd1RMwFjFZuT5G8BstpTNqYDdZmm2MHiavgZm0PCNvvZNZZNDKWdGSFoJ4YAvil1
	iaO5Nt6dnwM+vSrIDdo8TACdO9ZT1KqyWnX8DpEHKBJOIDiHzxcxcQ2KKNPwf1RO
	D2mnjfx1hYruKlQUyaXbGNa9aNqSyGevVhw4VfWPcn5Cca3mo90nLi5DGr+P3+W6
	RgCap2su0XT9CrMr+9KvSzQsQa5KSpzYAAVmuKnHQLVSu2yPMi+kaK/k6bvs6TFD
	sPRH2lf9ThReg12117Ee2qQCvwXcuFC8Qcw==
X-ME-Sender: <xms:hqUKaQw8jD0UY2F3bLhBRgKMxRijr3-dSHhpCN4Hx4Ja3_Q4mt_6Pw>
    <xme:hqUKaVyDWXuoS5y292CJ40gjzaR0Lc4g7d2mnQcRZ-Ik4_Ytns-rWrbDDkOH7ka-q
    kNmps11GG-sk30xrGgbrOI6yhIgFPDcU8cAB57xkFjQ_GbRQmA>
X-ME-Received: <xmr:hqUKaSZTBwf70JAj5lJ8ZQNVrTnxfHlRH-sJXeTY3w1blCV9ErNUyJJZuM_TFUQxXkB8guC5fmLGla6OcxtCw5e-PBIvIFIy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgesghdtreertddvjeenucfhrhhomhepgggrlhcurfgr
    tghkvghtthcuoehvrghlsehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqne
    cuggftrfgrthhtvghrnhepffegfefguefgheffudegveefhedvhfettdegheefteelvdeg
    vddvjeeujeeufeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepvhgrlhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjghhrohhssh
    esshhushgvrdgtohhmpdhrtghpthhtohepshhsthgrsggvlhhlihhniheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepohhlvghkshgrnhgurhgpthihshhhtghhvghnkhhosegvph
    grmhdrtghomhdprhgtphhtthhopeigvghnqdguvghvvghlsehlihhsthhsrdigvghnphhr
    ohhjvggtthdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hqUKaeXk1jHs6_My5N9w9v-TQjaVxIcVF9LXAXXbVr2v1jArsw0AVQ>
    <xmx:hqUKaYh7ejnfL3QFW1_FhcNAc10t7RecZroqWf-zXn-MEMhUoo_2Vw>
    <xmx:hqUKaUsK9EyajP8sTMPYBskRZpV9ftTeBowiRoh9EncH62V5ewaMrA>
    <xmx:hqUKaZ4eD9U2i7woksrKq2E2VJ0oXpAECWZRljobwjAk_2JTe74F8Q>
    <xmx:h6UKaV4p4piDrc6u0KCBP3xPYz9rJbil7PhKBKeptae2xGBjTrh6PKEM>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 20:16:53 -0500 (EST)
Message-ID: <7f73fdfa-2875-4349-9ef6-134e678ac691@invisiblethingslab.com>
Date: Tue, 4 Nov 2025 22:16:44 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] xen: privcmd: fix ioeventfd/ioreq crashing PV domain
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20251015195713.6500-1-val@invisiblethingslab.com>
 <5a3660c9-1b18-4d87-a1f7-efa8d68239d8@suse.com>
Content-Language: en-US
From: Val Packett <val@invisiblethingslab.com>
Autocrypt: addr=val@invisiblethingslab.com; keydata=
 xm8EaFTEiRMFK4EEACIDAwQ+qzawvLuE95iu+QkRqp8P9z6XvFopWtYOaEnYf/nE8KWCnsCD
 jz82tdbKBpmVOdR6ViLD9tzHvaZ1NqZ9mbrszMXq09VfefoCfZp8jnA2yCT8Y4ykmv6902Ne
 NnlkVwrNKFZhbCBQYWNrZXR0IDx2YWxAaW52aXNpYmxldGhpbmdzbGFiLmNvbT7CswQTEwkA
 OxYhBAFMrro+oMGIFPc7Uc87uZxqzalRBQJoVMSJAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMB
 Ah4HAheAAAoJEM87uZxqzalRlIIBf0cujzfSLhvib9iY8LBh8Tirgypm+hJHoY563xhP0YRS
 pmqZ6goIuSGpEKcW5mV3egF/TLLAOjsfroWae4giImTVOJvLOsUycxAP4O5b1Qiy+cCGsHKA
 nCRzrvqnPkyf4OeRznMEaFTEiRIFK4EEACIDAwSffe3tlMmmg3eKVp7SJ+CNZLN0M5qzHSCV
 dBBkIVvEJo+8SDg4jrx/832rxpvMCz2+x7+OHaeBHKafhOWUccYBLKqV/3nBftxCkbzXDbfY
 d02BY9H4wBIn0Y3GnwoIXRgDAQkJwpgEGBMJACAWIQQBTK66PqDBiBT3O1HPO7mcas2pUQUC
 aFTEiQIbDAAKCRDPO7mcas2pUaptAX9f7yUJLGU4C6XjMJvXd8Sz6cGTyxkngPtUyFiNqtad
 /GXBi3vHKYNfSrdqJ8wmZ8MBgOqWaaa1wE4/3qZU8d4RNR8mF7O40WYK/wdf1ycq1uGad8PN
 UDOwAqdfvuF3w8QMPw==
In-Reply-To: <5a3660c9-1b18-4d87-a1f7-efa8d68239d8@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------uCOYCjKINtMrC0LGSUDTrSdy"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------uCOYCjKINtMrC0LGSUDTrSdy
Content-Type: multipart/mixed; boundary="------------9O0x2yHcffwYgUCLOptqRBzs";
 protected-headers="v1"
Message-ID: <7f73fdfa-2875-4349-9ef6-134e678ac691@invisiblethingslab.com>
Date: Tue, 4 Nov 2025 22:16:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] xen: privcmd: fix ioeventfd/ioreq crashing PV domain
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20251015195713.6500-1-val@invisiblethingslab.com>
 <5a3660c9-1b18-4d87-a1f7-efa8d68239d8@suse.com>
Content-Language: en-US
From: Val Packett <val@invisiblethingslab.com>
Autocrypt: addr=val@invisiblethingslab.com; keydata=
 xm8EaFTEiRMFK4EEACIDAwQ+qzawvLuE95iu+QkRqp8P9z6XvFopWtYOaEnYf/nE8KWCnsCD
 jz82tdbKBpmVOdR6ViLD9tzHvaZ1NqZ9mbrszMXq09VfefoCfZp8jnA2yCT8Y4ykmv6902Ne
 NnlkVwrNKFZhbCBQYWNrZXR0IDx2YWxAaW52aXNpYmxldGhpbmdzbGFiLmNvbT7CswQTEwkA
 OxYhBAFMrro+oMGIFPc7Uc87uZxqzalRBQJoVMSJAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMB
 Ah4HAheAAAoJEM87uZxqzalRlIIBf0cujzfSLhvib9iY8LBh8Tirgypm+hJHoY563xhP0YRS
 pmqZ6goIuSGpEKcW5mV3egF/TLLAOjsfroWae4giImTVOJvLOsUycxAP4O5b1Qiy+cCGsHKA
 nCRzrvqnPkyf4OeRznMEaFTEiRIFK4EEACIDAwSffe3tlMmmg3eKVp7SJ+CNZLN0M5qzHSCV
 dBBkIVvEJo+8SDg4jrx/832rxpvMCz2+x7+OHaeBHKafhOWUccYBLKqV/3nBftxCkbzXDbfY
 d02BY9H4wBIn0Y3GnwoIXRgDAQkJwpgEGBMJACAWIQQBTK66PqDBiBT3O1HPO7mcas2pUQUC
 aFTEiQIbDAAKCRDPO7mcas2pUaptAX9f7yUJLGU4C6XjMJvXd8Sz6cGTyxkngPtUyFiNqtad
 /GXBi3vHKYNfSrdqJ8wmZ8MBgOqWaaa1wE4/3qZU8d4RNR8mF7O40WYK/wdf1ycq1uGad8PN
 UDOwAqdfvuF3w8QMPw==
In-Reply-To: <5a3660c9-1b18-4d87-a1f7-efa8d68239d8@suse.com>

--------------9O0x2yHcffwYgUCLOptqRBzs
Content-Type: multipart/mixed; boundary="------------T4uhiGdK9N57OX09F48m1Iqu"

--------------T4uhiGdK9N57OX09F48m1Iqu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPbiAxMS80LzI1IDk6MTUgQU0sIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+IE9uIDE1LjEw
LjI1IDIxOjU3LCBWYWwgUGFja2V0dCB3cm90ZToNCj4+IFN0YXJ0aW5nIGEgdmlydGlvIGJh
Y2tlbmQgaW4gYSBQViBkb21haW4gd291bGQgcGFuaWMgdGhlIGtlcm5lbCBpbg0KPj4gYWxs
b2NfaW9yZXEsIHRyeWluZyB0byBkZXJlZmVyZW5jZSB2bWEtPnZtX3ByaXZhdGVfZGF0YSBh
cyBhIHBhZ2VzDQo+PiBwb2ludGVyIHdoZW4gaW4gcmVhbGl0eSBpdCBzdGF5ZWQgYXMgUFJJ
Vl9WTUFfTE9DS0VELg0KPj4NCj4+IEZpeCBieSBhbGxvY2F0aW5nIGEgcGFnZXMgYXJyYXkg
aW4gbW1hcF9yZXNvdXJjZSBpbiB0aGUgUFYgY2FzZSwNCj4+IGZpbGxpbmcgaXQgd2l0aCBw
YWdlIGluZm8gY29udmVydGVkIGZyb20gdGhlIHBmbiBhcnJheS4gVGhpcyBhbGxvd3MNCj4+
IGlvcmVxIHRvIGZ1bmN0aW9uIHN1Y2Nlc3NmdWxseSB3aXRoIGEgYmFja2VuZCBwcm92aWRl
ZCBieSBhIFBWIGRvbTAuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmFsIFBhY2tldHQgPHZh
bEBpbnZpc2libGV0aGluZ3NsYWIuY29tPg0KPj4gLS0tDQo+PiBJJ3ZlIGJlZW4gcG9ydGlu
ZyB0aGUgeGVuLXZob3N0LWZyb250ZW5kWzFdIHRvIFF1YmVzLCB3aGljaCBydW5zIG9uIA0K
Pj4gYW1kNjQNCj4+IGFuZCB3ZSAoc3RpbGwpIHVzZSBQViBmb3IgZG9tMC4gVGhlIHg4NiBw
YXJ0IGRpZG4ndCBnaXZlIG1lIG11Y2ggDQo+PiB0cm91YmxlLA0KPj4gYnV0IHRoZSBmaXJz
dCB0aGluZyBJIGZvdW5kIHdhcyB0aGlzIGNyYXNoIGR1ZSB0byB1c2luZyBhIFBWIGRvbWFp
biANCj4+IHRvIGhvc3QNCj4+IHRoZSBiYWNrZW5kLiBhbGxvY19pb3JlcSB3YXMgZGVyZWZl
cmVuY2luZyB0aGUgJzEnIGNvbnN0YW50IGFuZCANCj4+IHBhbmlja2luZw0KPj4gdGhlIGRv
bTAga2VybmVsLg0KPj4NCj4+IEkgZmlndXJlZCBvdXQgdGhhdCBJIGNhbiBtYWtlIGEgcGFn
ZXMgYXJyYXkgaW4gdGhlIGV4cGVjdGVkIGZvcm1hdCANCj4+IGZyb20gdGhlDQo+PiBwZm4g
YXJyYXkgd2hlcmUgdGhlIGFjdHVhbCBtZW1vcnkgbWFwcGluZyBoYXBwZW5zIGZvciB0aGUg
UFYgY2FzZSwgDQo+PiBhbmQgd2l0aA0KPj4gdGhlIGZpeCwgdGhlIGlvcmVxIHBhcnQgd29y
a3M6IHRoZSB2aG9zdCBmcm9udGVuZCByZXBsaWVzIHRvIHRoZSBwcm9iaW5nDQo+PiBzZXF1
ZW5jZSBhbmQgdGhlIGd1ZXN0IHJlY29nbml6ZXMgd2hpY2ggdmlydGlvIGRldmljZSBpcyBi
ZWluZyBwcm92aWRlZC4NCj4+DQo+PiBJIHN0aWxsIGhhdmUgYW5vdGhlciB0aGluZyB0byBk
ZWJ1ZzogdGhlIE1NSU8gYWNjZXNzZXMgZnJvbSB0aGUgaW5uZXIgDQo+PiBkcml2ZXINCj4+
IChlLmcuIHZpcnRpb19ybmcpIGRvbid0IGdldCB0aHJvdWdoIHRvIHRoZSB2aG9zdCBwcm92
aWRlciAoaW9ldmVudGZkIA0KPj4gZG9lcw0KPj4gbm90IGdldCBub3RpZmllZCksIGFuZCBt
YW51YWxseSBraWNraW5nIHRoZSBldmVudGZkIGZyb20gdGhlIGZyb250ZW5kDQo+PiBzZWVt
cyB0byBjcmFzaC4uLiBYZW4gaXRzZWxmPz8gKG5vIExpbnV4IHBhbmljIG9uIGNvbnNvbGUs
IGp1c3QgYSANCj4+IGZyZWV6ZSBhbmQNCj4+IHF1aWNrIHJlYm9vdCAtIHdpbGwgdHJ5IHRv
IHNldCB1cCBhIHNlcmlhbCBjb25zb2xlIG5vdykNCj4NCj4gSU1ITyBmb3IgbWFraW5nIHRo
ZSBNTUlPIGFjY2Vzc2VzIHdvcmsgeW91J2QgbmVlZCB0byBpbXBsZW1lbnQgDQo+IGlvcmVx
LXNlcnZlcg0KPiBzdXBwb3J0IGZvciBQVi1kb21haW5zIGluIHRoZSBoeXBlcnZpc29yLiBU
aGlzIHdpbGwgYmUgYSBtYWpvciANCj4gZW5kZWF2b3IsIHNvDQo+IGJlZm9yZSB0YWtpbmcg
eW91ciBMaW51eCBrZXJuZWwgcGF0Y2ggSSdkIGxpa2UgdG8gc2VlIHRoaXMgY292ZXJlZC4N
Cg0KU29ycnksIEkgd2Fzbid0IGNsZWFyIGVub3VnaC4uIGl0J3MgKm5vdCogdGhhdCBNTUlP
IGFjY2Vzc2VzIGRvbid0IHdvcmsuDQoNCkkgZGVidWdnZWQgdGhpcyBhIGJpdCBtb3JlLCBh
bmQgaXQgdHVybnMgb3V0Og0KDQoxLiB0aGUgcmVhc29uIHdoeSAiaW9ldmVudGZkIGRvZXMg
bm90IGdldCBub3RpZmllZCIgaXMgYmVjYXVzZSBhY2Nlc3NpbmcgDQp0aGUgdmlydGlvIHBh
Z2UgKGFsbG9jYXRlZCB3aXRoIHRoaXMgcHJpdmNtZCBpbnRlcmZhY2UpIGZyb20gdGhlIGtl
cm5lbCANCndhcyBmYWlsaW5nLiBUaGUgZXhjaGFuZ2UgYmV0d2VlbiB0aGUgZ3Vlc3QgZHJp
dmVyIGFuZCB0aGUgdXNlcnNwYWNlIA0KaW9yZXEgc2VydmVyIGhhcyBiZWVuIHdvcmtpbmcg
cGVyZmVjdGx5LCBidXQgdGhlICprZXJuZWwqIGFjY2VzcyAod2hpY2ggDQppcyB3aGF0IG5l
ZWRzIHRoaXMgYHN0cnVjdCBwYWdlYCBhbGxvY2F0aW9uIHdpdGggdGhlIGN1cnJlbnQgY29k
ZSkgd2FzIA0KcmV0dXJuaW5nIG5vbnNlbnNlIGFuZCB0aGUgY2hlY2sgZm9yIHRoZSB2aXJ0
cXVldWUgcmVhZGluZXNzIGZsYWcgd2FzIA0KZmFpbGluZy4NCg0KSSBoYXZlIG5vdGljZWQg
YW5kIGZpeGVkIChsb2NhbGx5KSBhIGJ1ZyBpbiB0aGlzIHBhdGNoOiByZXVzaW5nIHRoZSAN
CmBwZm5zYCBhbGxvY2F0aW9uIGZvciBgZXJyc2AgaW7CoGB4ZW5fcmVtYXBfZG9tYWluX21m
bl9hcnJheWDCoG1lYW50IHRoYXQgDQp0aGUgYWN0dWFsIHBmbiB2YWx1ZSB3YXMgb3Zlcndy
aXR0ZW4gd2l0aCBhIHplcm8gKCJzdWNjZXNzIiBlcnJvciBjb2RlKSwgDQphbmQgdGhhdCdz
IHRoZSBgcGZuYCBJIHdhcyB1c2luZy4NCg0KU3RpbGwsIHRoZSBtZW1vcnkgdmlzaWJsZSBp
biB0aGUgZG9tMCBrZXJuZWwgYXQgdGhhdCBwZm4gaXMgbm90IHRoZSBzYW1lIA0KYWxsb2Nh
dGlvbiB0aGF0J3MgbWFwcGVkIGludG8gdGhlIHByb2Nlc3MuIEluc3RlYWQsIGl0J3Mgc29t
ZSByYW5kb20gDQpvdGhlciBtZW1vcnkuIEkndmUgYWRkZWQgYSBoZXhkdW1wIGZvciBpdCBp
biB0aGUgaW9ldmVudGZkIG5vdGlmaWVyIGFuZCANCml0IHdhcyByZXR1cm5pbmcgcmFuZG9t
IHN0dWZmIGZyb20gb3RoZXIgdXNlcnNwYWNlIHByb2dyYW1zIHN1Y2ggYXMgIi8vIA0KU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXIiIGZyb20gYSB0ZXh0IGVkaXRvciAoaGFoYSkuIEFjdHVh
bGx5LCAqb25jZSogaXQgDQpkaWQganVzdCB3b3JrIGFuZCBJJ3ZlIG1hbmFnZWQgdG8gYXR0
YWNoIGEgdmlydGlvLXJuZyBkcml2ZXIgYW5kIGhhdmUgaXQgDQpmdWxseSB3b3JrLg0KDQpD
bGVhcmx5IEknbSBqdXN0IHN0cnVnZ2xpbmcgd2l0aCB0aGUgd2F5IG1lbW9yeSBtYXBwaW5n
cyB3b3JrIHVuZGVyIFBWLiANCkRvIEkgbmVlZCB0byBzcGVjaWZpY2FsbHkgY3JlYXRlIGEg
c2Vjb25kIG1hcHBpbmcgZm9yIHRoZSBrZXJuZWwgdXNpbmcgDQp0aGUgc2FtZSBgeGVuX3Jl
bWFwX2RvbWFpbl9tZm5fYXJyYXlgIGNhbGw/DQoNCjIuIHRoZSByZWFzb24gd2h5ICJtYW51
YWxseSBraWNraW5nIHRoZSBldmVudGZkIGZyb20gdGhlIGZyb250ZW5kIHNlZW1zIA0KdG8g
Y3Jhc2guLi4gWGVuIGl0c2VsZiIgd2FzIGFjdHVhbGx5IGJlY2F1c2UgdGhhdCB0cmlnZ2Vy
ZWQgdGhlIGd1ZXN0IA0KaW50ZXJydXB0IGFuZCBJIHdhcyB1c2luZyB0aGUgSVNBIGludGVy
cnVwdHMgdGhhdCByZXF1aXJlZCB0aGUgdmlydHVhbCANCihJTylBUElDIHRvIGV4aXN0LCBh
bmQgaXQgZG9lc24ndCBpbiBQVkggZG9tYWlucy4gRm9yIG5vdyBJIHN3aXRjaGVkIG15IA0K
dGVzdCBzZXR1cCB0byBIVk0gdG8gZ2V0IGFyb3VuZCB0aGF0LCBidXQgSSdkIG5lZWQgdG8u
LiBmaWd1cmUgb3V0IGEgDQp2aXJxL3BpcnEgdHlwZSBzZXR1cCB0byByb3V0ZSBYRU5fRE1P
UF9zZXRfaXNhX2lycV9sZXZlbCBjYWxscyBvdmVyIA0KZXZlbnQgY2hhbm5lbHMgZm9yIFBW
KEgpIGd1ZXN0cy4NCg0KPj4gQnV0IEkgZmlndXJlZCBJJ2QgcG9zdCB0aGlzIGFzIGFuIFJG
QyBhbHJlYWR5LCBzaW5jZSB0aGUgb3RoZXIgYnVnIA0KPj4gbWF5IGJlDQo+PiB1bnJlbGF0
ZWQgYW5kIHRoZSBpb3JlcSBhcmVhIGl0c2VsZiBkb2VzIHdvcmsgbm93LiBJJ2QgbGlrZSB0
byBoZWFyIHNvbWUNCj4+IGZlZWRiYWNrIG9uIHRoaXMgZnJvbSBwZW9wbGUgd2hvIGFjdHVh
bGx5IGtub3cgWGVuIDopDQo+DQo+IE15IG1haW4gcHJvYmxlbSB3aXRoIHlvdXIgcGF0Y2gg
aXMgdGhhdCBpdCBpcyBhZGRpbmcgYSBtZW1vcnkgYWxsb2NhdGlvbg0KPiBmb3IgYSB2ZXJ5
IHJhcmUgdXNlIGNhc2UgaW1wYWN0aW5nIGFsbCBjdXJyZW50IHVzZXJzIG9mIHRoYXQgDQo+
IGZ1bmN0aW9uYWxpdHkuDQo+DQo+IFlvdSBjb3VsZCBhdm9pZCB0aGF0IGJ5IHVzaW5nIGEg
ZGlmZmVyZW50IGlvY3RsIHdoaWNoIGNvdWxkIGJlIA0KPiBzZWxlY3RlZCBieQ0KPiBzcGVj
aWZ5aW5nIGEgbmV3IGZsYWcgd2hlbiBjYWxsaW5nIHhlbmZvcmVpZ25tZW1vcnlfb3Blbigp
IChoYXZlIGEgbG9vaw0KPiBpbnRvIHRoZSBYZW4gc291cmNlcyB1bmRlciB0b29scy9saWJz
L2ZvcmVpZ25tZW1vcnkvY29yZS5jKS4NCg0KUmlnaHQsIHRoYXQgY291bGQgYmUgc29sdmVk
LiBIYXZpbmcgdXNlcnNwYWNlIGNob29zZSBiYXNlZCBvbiB3aGF0IGtpbmQgDQpvZiBkb21h
aW4gaXQgaXMgc291bmRzIGEgYml0IHBhaW5mdWwgKHlvdSdyZSB0YWxraW5nIGFib3V0IEMg
bGlicmFyaWVzIA0KYW5kIEknbSB1c2luZyBpbmRlcGVuZGVudCBSdXN0IG9uZXMsIHNvIHRo
aXMgbG9naWMgd291bGQgaGF2ZSB0byBiZSANCnByZXNlbnQgaW4gbXVsdGlwbGUgcGxhY2Vz
KS4uIEJ1dCB0aGlzIGtlcm5lbCBjb2RlIGNvdWxkIGJlIHJlZmFjdG9yZWQgbW9yZS4NCg0K
V2UgZG9uJ3QgYWN0dWFsbHkgbmVlZCBhbnkgYHN0cnVjdCBwYWdlYCBzcGVjaWZpY2FsbHks
IA0KYGlvZXZlbnRmZF9pbnRlcnJ1cHRgIG9ubHkgcmVhbGx5IG5lZWRzIGEga2VybmVsIHBv
aW50ZXIgdG8gdGhlIGFjdHVhbCANCmlvcmVxIG1lbW9yeSB3ZSdyZSBhbGxvY2F0aW5nIGhl
cmUuDQoNCkknbSBtb3N0bHkganVzdCBhc2tpbmcgZm9yIGhlbHAgdG8gZmlndXJlIG91dCBo
b3cgdG8gZ2V0IHRoYXQgcG9pbnRlci4NCg0KDQpUaGFua3MsDQp+dmFsDQoNCg==
--------------T4uhiGdK9N57OX09F48m1Iqu
Content-Type: application/pgp-keys; name="OpenPGP_0xCF3BB99C6ACDA951.asc"
Content-Disposition: attachment; filename="OpenPGP_0xCF3BB99C6ACDA951.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xm8EaFTEiRMFK4EEACIDAwQ+qzawvLuE95iu+QkRqp8P9z6XvFopWtYOaEnYf/nE
8KWCnsCDjz82tdbKBpmVOdR6ViLD9tzHvaZ1NqZ9mbrszMXq09VfefoCfZp8jnA2
yCT8Y4ykmv6902NeNnlkVwrNKFZhbCBQYWNrZXR0IDx2YWxAaW52aXNpYmxldGhp
bmdzbGFiLmNvbT7CswQTEwkAOxYhBAFMrro+oMGIFPc7Uc87uZxqzalRBQJoVMSJ
AhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEM87uZxqzalRlIIBf0cu
jzfSLhvib9iY8LBh8Tirgypm+hJHoY563xhP0YRSpmqZ6goIuSGpEKcW5mV3egF/
TLLAOjsfroWae4giImTVOJvLOsUycxAP4O5b1Qiy+cCGsHKAnCRzrvqnPkyf4OeR
zm8EaFTEiRMFK4EEACIDAwQv6ptVrbAJWMfhFoih+6gnnmnlUEp9jYsJ74GO8w95
EyJZSplnqbRJA+VxR46MBInbYry6RtRaeodClON+8IfzC81GbUFJoGvITw8w3/jf
uL2NmCHWgpyjTEyCFO+LEfTCmAQYEwkAIBYhBAFMrro+oMGIFPc7Uc87uZxqzalR
BQJoVMSJAhsgAAoJEM87uZxqzalRiZ0BfRhHFq6I6lLAhHX5W2a2iKudwhtppB6e
XUS8nt/7gXrbOn8uKKn732JknKXt6tJMJgGAgejj3/3g8CjnbxhMXFydNSbk2kGN
qvEBkfXkcD1uo2bxFjzVarquYp8FqK/f4QrlznMEaFTEiRIFK4EEACIDAwSffe3t
lMmmg3eKVp7SJ+CNZLN0M5qzHSCVdBBkIVvEJo+8SDg4jrx/832rxpvMCz2+x7+O
HaeBHKafhOWUccYBLKqV/3nBftxCkbzXDbfYd02BY9H4wBIn0Y3GnwoIXRgDAQkJ
wpgEGBMJACAWIQQBTK66PqDBiBT3O1HPO7mcas2pUQUCaFTEiQIbDAAKCRDPO7mc
as2pUaptAX9f7yUJLGU4C6XjMJvXd8Sz6cGTyxkngPtUyFiNqtad/GXBi3vHKYNf
SrdqJ8wmZ8MBgOqWaaa1wE4/3qZU8d4RNR8mF7O40WYK/wdf1ycq1uGad8PNUDOw
AqdfvuF3w8QMPw=3D=3D
=3D/RV6
-----END PGP PUBLIC KEY BLOCK-----

--------------T4uhiGdK9N57OX09F48m1Iqu--

--------------9O0x2yHcffwYgUCLOptqRBzs--

--------------uCOYCjKINtMrC0LGSUDTrSdy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEARMJAB0WIQQBTK66PqDBiBT3O1HPO7mcas2pUQUCaQqlfAAKCRDPO7mcas2p
UYtSAYC4LqjBH3ivATQCqwbKmywC35+ulOYpQIhz6KAH/nsxYUk/+eM4XcIbxFXM
tsJhYQ0Bf2oW8wy3nLgvpHrnE42ErnQ9NIKYOe7Yi+swjJfQ5XgTU7AVO6/xTJBY
4EFxCfr08w==
=Que4
-----END PGP SIGNATURE-----

--------------uCOYCjKINtMrC0LGSUDTrSdy--

