Return-Path: <linux-kernel+bounces-818364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13389B5909E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00CE322F69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB572EA46F;
	Tue, 16 Sep 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WmZCiYCc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WmZCiYCc"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554932EC089
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011371; cv=none; b=gnRlnKcHtG4B224TSN+/P43AiYIp4TfhNACoJJxzTvu88rrNIp+qiIT/1cn/EnEmidQ/xo7XL+Wcj5idUhKoi2kg9NNgwvzArcaVy9D5QP14SxXxP4fywtIx6ywBAGH8Ptt0Ss40ZstnAIwP29iaLoZpU1G5URqc32BKA8irW9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011371; c=relaxed/simple;
	bh=hgclWfd2Iv1YR+0SM795Q/VgpTWx5xPyhfl6zDDwctw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jcjlkxzo5u/Yy91+R0Fu0wxqErXIpOhy8cSa4Y78cddF/Aes81RejmNXmbbIvkdH6s5EbZQK80YaT2GAzBvcG438w5PYcHXPpC2ZGK0/yQqBzsv6UGaF5yRMPoOPkVYMiDSMSybsX1GBGH3CRWiF3wvTnVKTjgpWE5m1ibG5qvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WmZCiYCc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WmZCiYCc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E02422815;
	Tue, 16 Sep 2025 08:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758011367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hgclWfd2Iv1YR+0SM795Q/VgpTWx5xPyhfl6zDDwctw=;
	b=WmZCiYCcmGFsbbVtTZ1+6gDHkOOwYJ4QMMQOaYcg9u8MzJhomPpXmQfnUa9fPVcoSPTffm
	h9Q4M0hMtN9jRjXHkjn+KMtWSdXgtM35RNR97JhiTOvHLAlOuJiXhG1LuSTYyCCEaU/gnm
	k6/hRgnk2Wr82JJVuEDQg5HEfpub4mY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758011367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hgclWfd2Iv1YR+0SM795Q/VgpTWx5xPyhfl6zDDwctw=;
	b=WmZCiYCcmGFsbbVtTZ1+6gDHkOOwYJ4QMMQOaYcg9u8MzJhomPpXmQfnUa9fPVcoSPTffm
	h9Q4M0hMtN9jRjXHkjn+KMtWSdXgtM35RNR97JhiTOvHLAlOuJiXhG1LuSTYyCCEaU/gnm
	k6/hRgnk2Wr82JJVuEDQg5HEfpub4mY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D7D113A63;
	Tue, 16 Sep 2025 08:29:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VZ4CFecfyWgLIAAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 16 Sep 2025 08:29:27 +0000
Message-ID: <46cc57c6-bb57-4423-9fb2-37b5563c4dee@suse.com>
Date: Tue, 16 Sep 2025 10:29:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2023-53283: xen/virtio: Fix NULL deref when a bridge of PCI
 root bus has no parent
To: cve@kernel.org, linux-kernel@vger.kernel.org
References: <2025091624-CVE-2023-53283-674c@gregkh>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <2025091624-CVE-2023-53283-674c@gregkh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------XOAGOVa9WZsc3sIoyGb96Xlt"
X-Spam-Level: 
X-Spamd-Result: default: False [-5.20 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -5.20

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------XOAGOVa9WZsc3sIoyGb96Xlt
Content-Type: multipart/mixed; boundary="------------qhc6LRiSAKinzSYNKYY8IQxM";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <46cc57c6-bb57-4423-9fb2-37b5563c4dee@suse.com>
Subject: Re: CVE-2023-53283: xen/virtio: Fix NULL deref when a bridge of PCI
 root bus has no parent
References: <2025091624-CVE-2023-53283-674c@gregkh>
In-Reply-To: <2025091624-CVE-2023-53283-674c@gregkh>

--------------qhc6LRiSAKinzSYNKYY8IQxM
Content-Type: multipart/mixed; boundary="------------lFJT4JpI6IANTlJ4UoHIbmvZ"

--------------lFJT4JpI6IANTlJ4UoHIbmvZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDkuMjUgMTA6MTEsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gRnJvbTog
R3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAa2VybmVsLm9yZz4NCj4gDQo+IERlc2NyaXB0
aW9uDQo+ID09PT09PT09PT09DQo+IA0KPiBJbiB0aGUgTGludXgga2VybmVsLCB0aGUgZm9s
bG93aW5nIHZ1bG5lcmFiaWxpdHkgaGFzIGJlZW4gcmVzb2x2ZWQ6DQo+IA0KPiB4ZW4vdmly
dGlvOiBGaXggTlVMTCBkZXJlZiB3aGVuIGEgYnJpZGdlIG9mIFBDSSByb290IGJ1cyBoYXMg
bm8gcGFyZW50DQo+IA0KPiBXaGVuIGF0dGVtcHRpbmcgdG8gcnVuIFhlbiBvbiBhIFFFTVUv
S1ZNIHZpcnR1YWwgbWFjaGluZSB3aXRoIHZpcnRpbw0KPiBkZXZpY2VzIChhbGwgeDg2XzY0
KSwgZnVuY3Rpb24geGVuX2R0X2dldF9ub2RlKCkgY3Jhc2hlcyBvbiBhY2Nlc3NpbmcNCj4g
YnVzLT5icmlkZ2UtPnBhcmVudC0+b2Zfbm9kZSBiZWNhdXNlIGEgYnJpZGdlIG9mIHRoZSBQ
Q0kgcm9vdCBidXMgaGFzIG5vDQo+IHBhcmVudCBzZXQ6DQo+IA0KPiBbICAgIDEuNjk0MTky
XVsgICAgVDFdIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVz
czogMDAwMDAwMDAwMDAwMDI4OA0KPiBbICAgIDEuNjk1Njg4XVsgICAgVDFdICNQRjogc3Vw
ZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0KPiBbICAgIDEuNjk2Mjk3XVsg
ICAgVDFdICNQRjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQ0KPiBb
ICAgIDEuNjk2Mjk3XVsgICAgVDFdIFBHRCAwIFA0RCAwDQo+IFsgICAgMS42OTYyOTddWyAg
ICBUMV0gT29wczogMDAwMCBbIzFdIFBSRUVNUFQgU01QIE5PUFRJDQo+IFsgICAgMS42OTYy
OTddWyAgICBUMV0gQ1BVOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQg
Ni4zLjctMS1kZWZhdWx0ICMxIG9wZW5TVVNFIFR1bWJsZXdlZWQgYTU3N2VhZTU3OTY0YmI3
ZTgzNDc3YjVhNTY0NWExNzgxZGY5OTBmMA0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdIEhh
cmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9T
IHJlbC0xLjE1LjAtMC1nMmRkNGI5Yi1yZWJ1aWx0Lm9wZW5zdXNlLm9yZyAwNC8wMS8yMDE0
DQo+IFsgICAgMS42OTYyOTddWyAgICBUMV0gUklQOiBlMDMwOnhlbl92aXJ0aW9fcmVzdHJp
Y3RlZF9tZW1fYWNjKzB4ZDkvMHgxYzANCj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBDb2Rl
OiA0NSAwYyA4MyBlOCBjOSBhMyBlYSBmZiAzMSBjMCBlYiBkNyA0OCA4YiA4NyA0MCBmZiBm
ZiBmZiA0OCA4OSBjMiA0OCA4YiA0MCAxMCA0OCA4NSBjMCA3NSBmNCA0OCA4YiA4MiAxMCAw
MSAwMCAwMCA0OCA4YiA0MCA0MCA8NDg+IDgzIGI4IDg4IDAyIDAwIDAwIDAwIDBmIDg0IDQ1
IGZmIGZmIGZmIDY2IDkwIDMxIGMwIGViIGE1IDQ4IDg5DQo+IFsgICAgMS42OTYyOTddWyAg
ICBUMV0gUlNQOiBlMDJiOmZmZmZjOTAwNDAwMTNjYzggRUZMQUdTOiAwMDAxMDI0Ng0KPiBb
ICAgIDEuNjk2Mjk3XVsgICAgVDFdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY4
ODgwMDZjNzUwMDAgUkNYOiAwMDAwMDAwMDAwMDAwMDI5DQo+IFsgICAgMS42OTYyOTddWyAg
ICBUMV0gUkRYOiBmZmZmODg4MDA1ZWQxMDAwIFJTSTogZmZmZmM5MDA0MDBmMTAwYyBSREk6
IGZmZmY4ODgwMDVlZTMwZDANCj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBSQlA6IGZmZmY4
ODgwMDZjNzUwMTAgUjA4OiAwMDAwMDAwMDAwMDAwMDAxIFIwOTogMDAwMDAwMDMzMDAwMDAw
Ng0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdIFIxMDogZmZmZjg4ODAwNTg1MDAyOCBSMTE6
IDAwMDAwMDAwMDAwMDAwMDIgUjEyOiBmZmZmZmZmZjgzMDQzOWEwDQo+IFsgICAgMS42OTYy
OTddWyAgICBUMV0gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogZmZmZjg4ODAwNTY1Nzkw
MCBSMTU6IGZmZmY4ODgwMDZlM2UxZTgNCj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBGUzog
IDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4ODA0YTAwMDAwMCgwMDAwKSBrbmxH
UzowMDAwMDAwMDAwMDAwMDAwDQo+IFsgICAgMS42OTYyOTddWyAgICBUMV0gQ1M6ICBlMDMw
IERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiBbICAgIDEuNjk2
Mjk3XVsgICAgVDFdIENSMjogMDAwMDAwMDAwMDAwMDI4OCBDUjM6IDAwMDAwMDAwMDJlMzYw
MDAgQ1I0OiAwMDAwMDAwMDAwMDUwNjYwDQo+IFsgICAgMS42OTYyOTddWyAgICBUMV0gQ2Fs
bCBUcmFjZToNCj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAgPFRBU0s+DQo+IFsgICAgMS42
OTYyOTddWyAgICBUMV0gIHZpcnRpb19mZWF0dXJlc19vaysweDFiLzB4ZDANCj4gWyAgICAx
LjY5NjI5N11bICAgIFQxXSAgdmlydGlvX2Rldl9wcm9iZSsweDE5Yy8weDI3MA0KPiBbICAg
IDEuNjk2Mjk3XVsgICAgVDFdICByZWFsbHlfcHJvYmUrMHgxOWIvMHgzZTANCj4gWyAgICAx
LjY5NjI5N11bICAgIFQxXSAgX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4NzgvMHgxNjANCj4g
WyAgICAxLjY5NjI5N11bICAgIFQxXSAgZHJpdmVyX3Byb2JlX2RldmljZSsweDFmLzB4OTAN
Cj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAgX19kcml2ZXJfYXR0YWNoKzB4ZDIvMHgxYzAN
Cj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAgYnVzX2Zvcl9lYWNoX2RldisweDc0LzB4YzAN
Cj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAgYnVzX2FkZF9kcml2ZXIrMHgxMTYvMHgyMjAN
Cj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAgZHJpdmVyX3JlZ2lzdGVyKzB4NTkvMHgxMDAN
Cj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAgdmlydGlvX2NvbnNvbGVfaW5pdCsweDdmLzB4
MTEwDQo+IFsgICAgMS42OTYyOTddWyAgICBUMV0gIGRvX29uZV9pbml0Y2FsbCsweDQ3LzB4
MjIwDQo+IFsgICAgMS42OTYyOTddWyAgICBUMV0gIGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4
MzI4LzB4NDgwDQo+IFsgICAgMS42OTYyOTddWyAgICBUMV0gIGtlcm5lbF9pbml0KzB4MWEv
MHgxYzANCj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAgcmV0X2Zyb21fZm9yaysweDI5LzB4
NTANCj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAgPC9UQVNLPg0KPiBbICAgIDEuNjk2Mjk3
XVsgICAgVDFdIE1vZHVsZXMgbGlua2VkIGluOg0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFd
IENSMjogMDAwMDAwMDAwMDAwMDI4OA0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdIC0tLVsg
ZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiANCj4gVGhlIFBDSSByb290IGJ1
cyBpcyBpbiB0aGlzIGNhc2UgY3JlYXRlZCBmcm9tIEFDUEkgZGVzY3JpcHRpb24gdmlhDQo+
IGFjcGlfcGNpX3Jvb3RfYWRkKCkgLT4gcGNpX2FjcGlfc2Nhbl9yb290KCkgLT4gYWNwaV9w
Y2lfcm9vdF9jcmVhdGUoKSAtPg0KPiBwY2lfY3JlYXRlX3Jvb3RfYnVzKCkgd2hlcmUgdGhl
IGxhc3QgZnVuY3Rpb24gaXMgY2FsbGVkIHdpdGgNCj4gcGFyZW50PU5VTEwuIEl0IGluZGlj
YXRlcyB0aGF0IG5vIHBhcmVudCBpcyBwcmVzZW50IGFuZCB0aGVuDQo+IGJ1cy0+YnJpZGdl
LT5wYXJlbnQgaXMgTlVMTCB0b28uDQo+IA0KPiBGaXggdGhlIHByb2JsZW0gYnkgY2hlY2tp
bmcgYnVzLT5icmlkZ2UtPnBhcmVudCBpbiB4ZW5fZHRfZ2V0X25vZGUoKSBmb3INCj4gTlVM
TCBmaXJzdC4NCj4gDQo+IFRoZSBMaW51eCBrZXJuZWwgQ1ZFIHRlYW0gaGFzIGFzc2lnbmVk
IENWRS0yMDIzLTUzMjgzIHRvIHRoaXMgaXNzdWUuDQoNClBsZWFzZSByZXZva2UgdGhpcyBD
VkUuIFRoZXJlIGlzIG5vIHdheSBhbiB1bnByaXZpbGVnZWQgdXNlciBjb3VsZCB0cmlnZ2Vy
DQp0aGlzIGlzc3VlLg0KDQoNCkp1ZXJnZW4NCg==
--------------lFJT4JpI6IANTlJ4UoHIbmvZ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------lFJT4JpI6IANTlJ4UoHIbmvZ--

--------------qhc6LRiSAKinzSYNKYY8IQxM--

--------------XOAGOVa9WZsc3sIoyGb96Xlt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjJH+YFAwAAAAAACgkQsN6d1ii/Ey+C
YQf+JBNgRF81y9QVGNAhW5HXHAjo77Ct3O4jYjRq9/VZs9q3QZ96nH8d88x06zI/nBIHRyph7s35
duy786+AcWMqSKi1tISlrCyOWkEc43oVmT4kDRNErrg5n4t1+vqALu8ZWFU5iBUw/LPPS+SCtgjy
tJiE+4hJ2BDBrzIxlaXDwtaEwNshkjlLiaHflFhVR28D4b+uCqrY6oNWlY2UzqKEqsyy+hqYqlA0
Sk54GA/3p8TeODD1zSxXjFFALvfckqbAt7MY7/RcbUtzeJFTcBFbYXlxdbWdMDvP+8pPOxC6Ua1K
en6osf5F9CWcGZDE2RGFq55Pifwf9BMl70X9C03wNQ==
=eOcS
-----END PGP SIGNATURE-----

--------------XOAGOVa9WZsc3sIoyGb96Xlt--

