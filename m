Return-Path: <linux-kernel+bounces-836193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2051DBA8F81
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD05189F61C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E82FF678;
	Mon, 29 Sep 2025 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g1Lb1gOQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g1Lb1gOQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911A2FC01C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144068; cv=none; b=dRxo2nodOS+Ntht2C9RQTmHwC+JpED+NiBRd2wh/XjnAolm3gLofPHwO4jpnJOMdEQvWr3Gd7sfKOM8cwKhUrPCgs1dYf8P+0xMKd+zVFrRw1+iHHpgOgzV5YfEtmtSG7tG9eblz6gPN8DvupGrvq4jOZX9E2nfDpGdDL7wBnuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144068; c=relaxed/simple;
	bh=iikqELbpseuYA4fvEYgaaCxqgP1sKetcKtWyVLM4CE4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CRu30VNoRt/9wJOLuHnbzCsywBRJUSqE0Nxz5JKM/l5V4dOhcKPj/j462yw0NeYmMutjfYHq+MHYRTn4TJIC6QG+sWtUSU/J5Im1qx3UYWn7QcCbNc6SOIGpRG2ezvg+1F1FXWUaanI2nyBr9cfSUD+41SUYL72smq7aKYNnXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g1Lb1gOQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g1Lb1gOQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE36B3153D;
	Mon, 29 Sep 2025 11:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759144062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iikqELbpseuYA4fvEYgaaCxqgP1sKetcKtWyVLM4CE4=;
	b=g1Lb1gOQpnwXF+gQVOsXgoeXajCdMoD4C2qYG9jyaRDiyzvbZU37xXXt8XVMc/iZmH9edk
	xMOkw1Jwi2Mp1y50HXuumukZFbh+SBFfuKOroMFu/hzncHTPY6feaomcp5gDGxE+ZGUOj5
	TAovISf9S258+C+GuCU5VF/o184QgWI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=g1Lb1gOQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759144062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iikqELbpseuYA4fvEYgaaCxqgP1sKetcKtWyVLM4CE4=;
	b=g1Lb1gOQpnwXF+gQVOsXgoeXajCdMoD4C2qYG9jyaRDiyzvbZU37xXXt8XVMc/iZmH9edk
	xMOkw1Jwi2Mp1y50HXuumukZFbh+SBFfuKOroMFu/hzncHTPY6feaomcp5gDGxE+ZGUOj5
	TAovISf9S258+C+GuCU5VF/o184QgWI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62D0513782;
	Mon, 29 Sep 2025 11:07:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2duuFn5o2mjxaAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Sep 2025 11:07:42 +0000
Message-ID: <5f6871b5-243c-457f-82f7-47246b6ef6ea@suse.com>
Date: Mon, 29 Sep 2025 13:07:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] x86/paravirt: Switch MSR access pv_ops functions to
 instruction interfaces
From: Juergen Gross <jgross@suse.com>
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, Andrew Cooper <andrew.cooper3@citrix.com>
References: <20250506092015.1849-1-jgross@suse.com>
 <20250506092015.1849-6-jgross@suse.com>
 <722f5b30-20e9-4540-98e4-d211d7c44cbe@zytor.com>
 <9f4e33d5-9cb3-4079-b764-87a15265fd52@suse.com>
 <2365af70-d36f-4663-b819-59d886936ef5@zytor.com>
 <8a82946a-6c3e-41d1-b3bd-be164dc6eeba@suse.com>
 <7047440a-0419-4982-961b-46f9b90a86e9@zytor.com>
 <6eb60b62-bd3a-4a64-9665-fc911cc7d869@suse.com>
Content-Language: en-US
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
In-Reply-To: <6eb60b62-bd3a-4a64-9665-fc911cc7d869@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PXMgO3JbmBo5moltJRZPfnkF"
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CE36B3153D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.41 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -6.41

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------PXMgO3JbmBo5moltJRZPfnkF
Content-Type: multipart/mixed; boundary="------------SFV1VnAbY3HH96F5ZtO1vdQI";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <5f6871b5-243c-457f-82f7-47246b6ef6ea@suse.com>
Subject: Re: [PATCH 5/6] x86/paravirt: Switch MSR access pv_ops functions to
 instruction interfaces
References: <20250506092015.1849-1-jgross@suse.com>
 <20250506092015.1849-6-jgross@suse.com>
 <722f5b30-20e9-4540-98e4-d211d7c44cbe@zytor.com>
 <9f4e33d5-9cb3-4079-b764-87a15265fd52@suse.com>
 <2365af70-d36f-4663-b819-59d886936ef5@zytor.com>
 <8a82946a-6c3e-41d1-b3bd-be164dc6eeba@suse.com>
 <7047440a-0419-4982-961b-46f9b90a86e9@zytor.com>
 <6eb60b62-bd3a-4a64-9665-fc911cc7d869@suse.com>
In-Reply-To: <6eb60b62-bd3a-4a64-9665-fc911cc7d869@suse.com>

--------------SFV1VnAbY3HH96F5ZtO1vdQI
Content-Type: multipart/mixed; boundary="------------ct5bAGbTyiqKBNoXLfZDlBc3"

--------------ct5bAGbTyiqKBNoXLfZDlBc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDguMjUgMTI6MzksIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+IE9uIDI1LjA4LjI1
IDAzOjU0LCBYaW4gTGkgd3JvdGU6DQo+PiBPbiA2LzExLzIwMjUgNTo1OCBBTSwgSnVlcmdl
biBHcm9zcyB3cm90ZToNCj4+PiBJJ20ganVzdCBkb2luZyBhIFYyIG9mIG15IHNlcmllcywg
YnV0IHRoaXMgdGltZSBpbmNsdWRpbmcgdGhlIGFkZGl0aW9uYWwNCj4+PiBzdXBwb3J0IG9m
IHRoZSBub24tc2VyaWFsaXppbmcgYW5kIGltbWVkaWF0ZSBmb3Jtcy4gTGV0cyBzZWUgaG93
IHRoaXMgd2lsbA0KPj4+IGxvb2sgbGlrZS4gSSB3aWxsIGRyb3AgdXNpbmcgdGhlIEVBWF9F
RFhfKiBtYWNyb3MsIGJ1dCBkdWUgdG8gdGhlIHJlYXNvbg0KPj4+IG1lbnRpb25lZCBhYm92
ZSBJIHdvbid0IHN3aXRjaCB0byB5b3VyIHZhcmlhbnQgY29tcGxldGVseS4NCj4+DQo+PiBI
aSBKdWVyZ2VuLA0KPj4NCj4+IERvIHlvdSBoYXZlIGFueSB1cGRhdGUgb24gdGhpcz8NCj4g
DQo+IEkndmUgYmVlbiB2ZXJ5IGJ1c3kgd2l0aCBvdGhlciBzdHVmZiAoZG93bnN0cmVhbSwg
c2VjdXJpdHksIC4uLikuDQo+IA0KPiBJbiBiZXR3ZWVuIEkndmUgYmVlbiB3b3JraW5nIG9u
IHRoZSBzZXJpZXMuIEkgaG9wZSB0byBwb3N0IGl0IHNvbWUgdGltZSBpbg0KPiBTZXB0ZW1i
ZXIuDQoNCkkgaGF2ZSBiZWVuIHdvcmtpbmcgb24gdGhpcyB0aGUgbGFzdCB3ZWVrLg0KDQpU
dXJucyBvdXQgdGhpbmdzIGFyZSBhIGxpdHRsZSBiaXQgY29tcGxpY2F0ZWQgZm9yIGFkZGlu
ZyB0aGVtIGludG8gdGhlDQpwYXJhdmlydCBmcmFtZXdvcmssIGVzcGVjaWFsbHkgcmVnYXJk
aW5nIHRoZSBleGNlcHRpb24gZml4dXBzLg0KDQpJIGZpcnN0IHRob3VnaHQgdGhhdCBQZXRl
cidzIHBhdGNoICJ4ODYvZXh0YWJsZTogSW1wbGVtZW50IEVYX1RZUEVfRlVOQ19SRVdJTkQi
DQp3b3VsZCBoZWxwLCBidXQgSSdtIHNlZWluZyBwcm9ibGVtcyB3aXRoIGhpcyBhcHByb2Fj
aCBpbiBjYXNlIG9mIHNoYWRvdyBzdGFjaw0KYmVpbmcgZW5hYmxlZC4gVGhpcyBjYXNlIHdv
dWxkIGF0IGxlYXN0IG5lZWRlZCB0byBiZSBoYW5kbGVkIGluIGhpcyBwYXRjaCwgYXMNCm90
aGVyd2lzZSBzaGFkb3cgc3RhY2sgYW5kIG5vcm1hbCBzdGFjayBjb3VsZCBnZXQgb3V0IG9m
IHN5bmMuDQoNCkZvciB0aGlzIHJlYXNvbiB5b3VyIHBhdGNoIHNlcmllcyB3b24ndCB3b3Jr
IGVhc2lseSwgdG9vLg0KDQpPVE9IIHVzaW5nIHlvdXIgYmFzaWMgaWRlYSBpdCBzZWVtcyB0
byBiZSBwb3NzaWJsZSB0byBzb2x2ZSB0aGUgZml4dXAgcHJvYmxlbQ0Kd2l0aG91dCBuZWVk
aW5nIFBldGVyJ3MgcGF0Y2guIEknbSB3b3JraW5nIG9uIHRoYXQgYXBwcm9hY2ggbm93Lg0K
DQoNCkp1ZXJnZW4NCg==
--------------ct5bAGbTyiqKBNoXLfZDlBc3
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------ct5bAGbTyiqKBNoXLfZDlBc3--

--------------SFV1VnAbY3HH96F5ZtO1vdQI--

--------------PXMgO3JbmBo5moltJRZPfnkF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjaaH0FAwAAAAAACgkQsN6d1ii/Ey8t
3gf+K2bpqm9A2Bf+03hK9ezhDmN2XLWIGetjUIte/abiUhznYGBPv1YpcZXn6M4upfVEqKkTu5YL
bzpPdahyj23m3tIEjObgeclxs27XyWuugXs1bC3qYmo+ukRdh9FejTCbKmkEXU0jZZNAdbaC6Zc0
AAYppXjQR0yuMoBCHWhnsCUZCeK9N3DBzNlqdxFEZibJyFfFn5891zS4SFTlUzusAhX2sQKKW9Hy
TUGIYYosZCpz2aZIWVfNTi7/cIqU8kHSga8FsGC2srogDAYTWbHM1fipHwOj2tJkXkrGv5HLzJV1
WZ7KY04cFr8c0oK1Vzzy25tZliSs5YsA8Omog9ksWA==
=BL2H
-----END PGP SIGNATURE-----

--------------PXMgO3JbmBo5moltJRZPfnkF--

