Return-Path: <linux-kernel+bounces-838609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2348FBAFBBF
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B082A28AC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85807284B2F;
	Wed,  1 Oct 2025 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XlRX3QTG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XlRX3QTG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ACE235C01
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759308657; cv=none; b=u1FxF5AFcJHe7mUbcEWWOISNQHDjmsY2awX70+7ewA55LepKQzBdpq7oenttx4+SHPd2Zipz9LDTF8/K+NVjS4McLFZEY2dVZqBkmMeTHfekMsSdIYVERn9u9Ho2e95QM7wi3bImyF5uHTaCdjTZyAUUEhrbtO252Wyc6iG4hSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759308657; c=relaxed/simple;
	bh=bSSwEfWJRfBOwWf5F5dz3odPFVIHP56hEMWrlrmXUoY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M2aw/grD6Gp7eJmPogyUdFVX9nKCSsUaOFdVxbnBlIBrXDZK/Y49IA3yumEa0BGEAA6Emr58pp7X3UshtS3RVxztWXXTtCOau6dVwrpSDssfS21NsgGyi5TnfyW3KQrJLA5H4AhFWMGas82mBYLt2nk/BD+7FC/lJ2DGDiOsBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XlRX3QTG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XlRX3QTG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 720C833B83;
	Wed,  1 Oct 2025 08:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759308572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bSSwEfWJRfBOwWf5F5dz3odPFVIHP56hEMWrlrmXUoY=;
	b=XlRX3QTG4iwBP/D6iGqS0H3nSI6yCh8n4SW4OnValWhtY6ha0LDR6q8SYzKnWI2iT1n2Xj
	7aGd8sMxCCez6x3PJXF9MhBkkLTIDATuct3ODM3Um+SqTJI2VJoMXAGjFkxxqc37Ylj1LH
	0R6edUXU/iE1OxeXy1nE1GCX32Rq4To=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XlRX3QTG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759308572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bSSwEfWJRfBOwWf5F5dz3odPFVIHP56hEMWrlrmXUoY=;
	b=XlRX3QTG4iwBP/D6iGqS0H3nSI6yCh8n4SW4OnValWhtY6ha0LDR6q8SYzKnWI2iT1n2Xj
	7aGd8sMxCCez6x3PJXF9MhBkkLTIDATuct3ODM3Um+SqTJI2VJoMXAGjFkxxqc37Ylj1LH
	0R6edUXU/iE1OxeXy1nE1GCX32Rq4To=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0182913A42;
	Wed,  1 Oct 2025 08:49:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q65lOhvr3GjiNwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 01 Oct 2025 08:49:31 +0000
Message-ID: <b2e07601-80d9-4a6e-a60a-6667d679494c@suse.com>
Date: Wed, 1 Oct 2025 10:49:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
 xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com>
 <20250930083137.GH3245006@noisy.programming.kicks-ass.net>
 <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>
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
In-Reply-To: <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------78FHMnpx10wnoe8Kmse05yIN"
X-Spamd-Result: default: False [-4.91 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.linux.dev,zytor.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,gmail.com,google.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[lkml];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 720C833B83
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.91

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------78FHMnpx10wnoe8Kmse05yIN
Content-Type: multipart/mixed; boundary="------------hsogYg5ThxpbJDGH0lmSSEn0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
 xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Message-ID: <b2e07601-80d9-4a6e-a60a-6667d679494c@suse.com>
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com>
 <20250930083137.GH3245006@noisy.programming.kicks-ass.net>
 <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>
In-Reply-To: <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>

--------------hsogYg5ThxpbJDGH0lmSSEn0
Content-Type: multipart/mixed; boundary="------------EeGf0iTatkiy7TdkXcc0x83q"

--------------EeGf0iTatkiy7TdkXcc0x83q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDkuMjUgMTA6NDYsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+IE9uIDMwLjA5LjI1
IDEwOjMxLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+IE9uIFR1ZSwgU2VwIDMwLCAyMDI1
IGF0IDA5OjAzOjUzQU0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pg0KPj4+ICtz
dGF0aWMgX19hbHdheXNfaW5saW5lIGJvb2wgX193cm1zcnFfY29uc3RhbnQodTMyIG1zciwg
dTY0IHZhbCwgaW50IHR5cGUpDQo+Pj4gK3sNCj4+PiArwqDCoMKgIEJVSUxEX0JVR19PTigh
X19idWlsdGluX2NvbnN0YW50X3AobXNyKSk7DQo+Pj4gKw0KPj4+ICvCoMKgwqAgYXNtX2lu
bGluZSB2b2xhdGlsZSBnb3RvKA0KPj4+ICvCoMKgwqDCoMKgwqDCoCAiMTpcbiINCj4+PiAr
wqDCoMKgwqDCoMKgwqAgQUxURVJOQVRJVkVfMihQUkVQQVJFX1JDWF9SRFhfRk9SX1dSTVNS
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIjI6IGRzIHdybXNy
IiwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQUkVQQVJFX1JD
WF9SRFhfRk9SX1dSTVNSDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgQVNNX1dSTVNSTlMsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgWDg2X0ZFQVRVUkVfV1JNU1JOUywNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBBU01fV1JNU1JOU19JTU0sDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgWDg2X0ZFQVRVUkVfTVNSX0lNTSkNCj4+PiArwqDCoMKgwqDCoMKg
wqAgX0FTTV9FWFRBQkxFX1RZUEUoMWIsICVsW2JhZG1zcl0sICVjW3R5cGVdKcKgwqDCoCAv
KiBGb3IgV1JNU1JOUyANCj4+PiBpbW1lZGlhdGUgKi8NCj4+PiArwqDCoMKgwqDCoMKgwqAg
X0FTTV9FWFRBQkxFX1RZUEUoMmIsICVsW2JhZG1zcl0sICVjW3R5cGVdKcKgwqDCoCAvKiBG
b3IgV1JNU1IoTlMpICovDQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKgwqDCoCA6DQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIDogW3ZhbF0gImEiICh2YWwpLCBbbXNyXSAiaSIgKG1zciksIFt0eXBl
XSAiaSIgKHR5cGUpDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIDogIm1lbW9yeSIsICJlY3giLCAi
cmR4Ig0KPj4+ICvCoMKgwqDCoMKgwqDCoCA6IGJhZG1zcik7DQo+Pj4gKw0KPj4+ICvCoMKg
wqAgcmV0dXJuIGZhbHNlOw0KPj4+ICsNCj4+PiArYmFkbXNyOg0KPj4+ICvCoMKgwqAgcmV0
dXJuIHRydWU7DQo+Pj4gK30NCj4+DQo+PiBKdXN0IHdvbmRlcmluZywgd291bGQgc29tZXRo
aW5nIHRoaXMgd29yaz8NCj4+DQo+PiDCoMKgwqDCoGFzbV9pbmxpbmUgdm9sYXRpbGUgZ290
bygNCj4+IMKgwqDCoMKgwqDCoMKgICIxOlxuIg0KPj4gwqDCoMKgwqDCoMKgwqAgQUxURVJO
QVRJVkUoUFJFUEFSRV9SQ1hfUkRYX0ZPUl9XUk1TUg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICIyOlxuIg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEFMVEVSTkFUSVZFKCJkcyB3cm1zciIsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQVNNX1dSTVNSTlMsIFg4Nl9GRUFUVVJF
X1dSTVNSTlMpLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFTTV9XUk1T
Uk5TX0lNTSwgWDg2X0ZFQVRVUkVfTVNSX0lNTSk7DQo+PiDCoMKgwqDCoMKgwqDCoCBfQVNN
X0VYVEFCTEVfVFlQRSgxYiwgJWxbYmFkbXNyXSwgJWNbdHlwZV0pwqDCoMKgIC8qIEZvciBX
Uk1TUk5TIA0KPj4gaW1tZWRpYXRlICovDQo+PiDCoMKgwqDCoMKgwqDCoCBfQVNNX0VYVEFC
TEVfVFlQRSgyYiwgJWxbYmFkbXNyXSwgJWNbdHlwZV0pwqDCoMKgIC8qIEZvciBXUk1TUihO
UykgKi8NCj4+DQo+PiDCoMKgwqDCoMKgwqDCoCA6DQo+PiDCoMKgwqDCoMKgwqDCoCA6IFt2
YWxdICJhIiAodmFsKSwgW21zcl0gImkiIChtc3IpLCBbdHlwZV0gImkiICh0eXBlKQ0KPj4g
wqDCoMKgwqDCoMKgwqAgOiAibWVtb3J5IiwgImVjeCIsICJyZHgiDQo+PiDCoMKgwqDCoMKg
wqDCoCA6IGJhZG1zcik7DQo+Pg0KPj4gSXRzIGEgYml0IHdlaXJkIGJlY2F1c2UgdGhlIG5l
c3RlZCBhbHRlcm5hdGl2ZSBpc24ndCBmb3IgdGhlIGV4YWN0IHNhbWUNCj4+IHBvc2l0aW9u
IEkgc3VwcG9zZS4gQnV0IEkgZmluZCBpdCBhIG1vcmUgcmVhZGFibGUgZm9ybS4NCj4gDQo+
IEkgZG9uJ3QgdGhpbmsgaXQgd291bGQgd29yay4gTmVzdGVkIEFMVEVSTkFUSVZFKClzIGRv
IHdvcmsgb25seSB3aXRoDQo+IGFsbCBvZiB0aGVtIHN0YXJ0aW5nIGF0IHRoZSBzYW1lIGxv
Y2F0aW9uLiBIYXZlIGEgbG9vayBhdCB0aGUNCj4gQUxURVJOQVRJVkUoKSBtYWNybywgd2hp
Y2ggaXMgZGVmaW5pbmcgdGhlIGxhYmVsICI3NzEiIHZpYSBPTERJTlNUUigpDQo+IGFuZCB0
aGVuIHJlZmVycmluZyB0byB0aGlzIGxhYmVsIHZpYSBBTFRJTlNUUl9FTlRSWSgpLiBJbiB5
b3VyIGNhc2UNCj4gdGhlIEFMVElOU1RSX0VOVFJZKCkgb2YgdGhlIG91dGVyIEFMVEVSTkFU
SVZFKCkgaW52b2NhdGlvbiB3b3VsZCBmaW5kDQo+IHRoZSB3cm9uZyAiNzcxIiBsYWJlbCAo
dGhlIG9uZSBvZiB0aGUgaW5uZXIgQUxURVJOQVRJVkUoKSkuDQo+IA0KPiBBbGxvd2luZyBz
dWNoIGNvbnN0cnVjdHMgd291bGQgcHJvYmFibHkgcmVxdWlyZSBzd2l0Y2hpbmcgZnJvbSBw
cmVwcm9jZXNzb3INCj4gbWFjcm9zIHRvIGFzc2VtYmxlciBtYWNyb3MuDQoNClRoaW5raW5n
IG1vcmUgYWJvdXQgdGhhdCBJIGJlbGlldmUgdGhlcmUgYXJlIGFkZGl0aW9uYWwgcHJvYmxl
bXM6DQoNCkhhdmluZyBvdmVybGFwcGluZyBhbHRlcm5hdGl2ZXMgbm90IHN0YXJ0aW5nIGF0
IHRoZSBzYW1lIGFkZHJlc3Mgd2lsbCByZXN1bHQNCmluIHByb2JsZW1zIHdpdGggbGVuZ3Ro
IHBhZGRpbmcgb2YgdGhlIG91dGVyIGFsdGVybmF0aXZlIGluIGNhc2UgdGhlIGlubmVyDQpv
bmUgc3RhcnRpbmcgbGF0ZXIgaXMgZXh0ZW5kaW5nIHBhc3QgdGhlIGVuZCBvZiB0aGUgb3V0
ZXIgb25lLiBUaGlzIG1pZ2h0IGJlDQpwb3NzaWJsZSB0byBoYW5kbGUsIGJ1dCBpdCB3aWxs
IGJlIHRlZGlvdXMuDQoNCkEgc2ltaWxhciBwcm9ibGVtIG9jY3VycyB3aXRoIG15IHJlY2Vu
dCBzZXJpZXMgZm9yIG1lcmdpbmcgbmVzdGVkIGFsdGVybmF0aXZlDQpwYXRjaGluZyBpbnRv
IGEgdGVtcG9yYXJ5IGJ1ZmZlci4gQ3VycmVudGx5IHRoZSBjb2RlIHJlbGllcyBvbiBhbGwg
bmVzdGVkDQphbHRlcm5hdGl2ZXMgdG8gc3RhcnQgYXQgdGhlIHNhbWUgbG9jYXRpb24uDQoN
ClVzaW5nIHlvdXIgaWRlYSB3aXRoIHB2X29wcyBjb3VsZCByZXN1bHQgaW4gdGhlIGlubmVy
IGFsdGVybmF0aXZlIG5vdCBiZWluZw0KYXQgdGhlIHN0YXJ0IG9mIHRoZSBvdXRlciBhbHRl
cm5hdGl2ZSBBTkQgYmVpbmcgbm90IHRoZSBpbml0aWFsIGNvZGUuIFRoaXMNCndvdWxkIHJl
c3VsdCBpbiBwYXRjaGluZyBpbiB0aGUgLmFsdGluc3RydWN0aW9ucyBhcmVhIGluc3RlYWQg
b2YgdGhlIG5vcm1hbA0KLnRleHQgc2l0ZSwgcmVzdWx0aW5nIGluIHBvc3NpYmxlIGxvc3Mg
b2YgYSBwYXRjaGluZyBhY3Rpb24gaWYgdGhlIHBhdGNoZWQNCmFyZWEgd291bGQgaGF2ZSBi
ZWVuIHVzZWQgYXMgYSByZXBsYWNlbWVudCBiZWZvcmUuDQoNClNvIGluIG15IG9waW5pb24g
YWxsb3dpbmcgYWx0ZXJuYXRpdmVzIHRvIG5lc3Qgd2l0aG91dCBhbGwgaW5uZXIgbGV2ZWxz
DQpzdGFydGluZyBhdCB0aGUgc2FtZSBsb2NhdGlvbiBhcyB0aGUgb3V0ZXJtb3N0IGxldmVs
IHdvdWxkIGJlIGEgcmVjZWlwdCBmb3INCmZhaWx1cmUuDQoNCkkgdGhpbmsgSSdsbCB3cml0
ZSBhbm90aGVyIHBhdGNoIHRvIEJVRygpIGluIGNhc2Ugc3VjaCBhIHNpdHVhdGlvbiBpcyBi
ZWluZw0KZGV0ZWN0ZWQuDQoNCg0KSnVlcmdlbg0K
--------------EeGf0iTatkiy7TdkXcc0x83q
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------EeGf0iTatkiy7TdkXcc0x83q--

--------------hsogYg5ThxpbJDGH0lmSSEn0--

--------------78FHMnpx10wnoe8Kmse05yIN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjc6xsFAwAAAAAACgkQsN6d1ii/Ey/t
ZQf/RS4Hc6lk09cg5QauTL2zsh4tHXBL1AgNHCmMWVdc77xlLDdy/215ZO+hEAZNxa/D97NXaTUl
URV8foYGnd6Jb1kuK6L2hvILFnNsc+rzJSzLJn+Qz1p2HiH262Af0tQYAxciDkxcT4xfcsOt4ZJq
Tksw7FnF12ShV6bc1Q93NQ1KCkSsL6HOUKNogHK75VdhMwjfwYM5prMz/75WDNFKfo2A5QVoV4QI
SJXUAMLivqrroNP3c3n5qmFPPKr1cBS9jsoaM6sKcXYAa4iYeJc4YL79fJunJxwK3ZE6Iv5OB9mJ
yZzbsRGwejPGr1ip7qk34+V1EdyGwy0O7dzLrDo0eA==
=CpS9
-----END PGP SIGNATURE-----

--------------78FHMnpx10wnoe8Kmse05yIN--

