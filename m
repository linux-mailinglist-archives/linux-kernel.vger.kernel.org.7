Return-Path: <linux-kernel+bounces-807711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35952B4A835
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DA616548C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91E12C11D3;
	Tue,  9 Sep 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g3cwDKyX"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368D1A9FA8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410660; cv=none; b=YONjAVWeGURP4ORs6GfPkdfGfTAdiqZhkdx3RhuzT9oWjpjc5pvBXd1jbD9w0gjRS5RY0rvsTI5iGVb8PdNO99c7wRdwH20NoMiv4ELcjEqoNxBF2abp0qcRr4Fi1xEsBA55LhrZYQnYXQfOYXMJ7q40nBVqejK+qMvycUxZTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410660; c=relaxed/simple;
	bh=4XElcJECP7+8ySi8fl9eJbEz4NEzPyATGv+tov1ERLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaL/pQNn+JdTeP2fGFdsvJ1r8GLqUJStwGtiL8ZzoRBYnPCL0XzetgOFnknbMMVi5cLDQPGTN5VgLP1znV8T5c7WUijxc4ll0iQCeeMq6i4NTQZczl3l7nB8njiZvcLN8W4SimXylO8KKKhnoi75yjLX794DmOzHnzP/5WZah/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g3cwDKyX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dec1ae562so9189065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757410656; x=1758015456; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4XElcJECP7+8ySi8fl9eJbEz4NEzPyATGv+tov1ERLQ=;
        b=g3cwDKyXV+XifQVHPCrDnPGVqDjI9T5R0AtXZOR9nEUffVTGRfXJ95J+VCFDRb+RPY
         AsNEmRGLpUP1F101qk49VV8N2GFsUSeLKmWAeR94FcHv8p2iNFI59ki/61sZveoC4z81
         zV6JnwOI3ZblsdVhlhawPcv3SskzWuoRpIwzoeo+XGUDVB/7nARiyYYDxCkn+n/Q/v6u
         DKqbYvaKI1pxVLajJqKzvAk53XaUmD8Z2/x8v80t3yJjMky9XircNzHJq5C11PVDSILf
         o7rJJI+0+Q/p43ssvULzr9baiJRo8zh9IfPJHqxDC0C1z1zebZAif9PcSeTsnRZpklN7
         8jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757410656; x=1758015456;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4XElcJECP7+8ySi8fl9eJbEz4NEzPyATGv+tov1ERLQ=;
        b=XD/5w9GRRGr4coqEQRd6m1iAmN07cDtE4wEJIRd+okNXLh7eyh+o5oyJ6uxFsf0q9N
         UwZUzHHwVgsKMGvpZxTFtJNjuuD1bt8uP1hC1C0Qk3W9KqQ3MdcsiAnBWs3i0NFCbk65
         19035rPiOwKcma+JLVWGckBt9MrTyneqdRo5r7VxcjQG81oZTRJDeL5YJOyJsYy0FbDt
         ghHoaofwsQoLMN3e+WqvQLWmWY27xdUcX4JBfNQCNR5xb5uZMS8QHF88Ps3z/Cwzv1kx
         oBRdE+/OVJFZxqXogzfkN30bq+om1/Bs5qryRCuGfQ/o74dfW9iU+XxyFB+CYgLnK89f
         yInw==
X-Gm-Message-State: AOJu0YziY/lCvn0sZTc8HJS0S1Jvk32HHwLaPQIBMOWIb0Jr2EZXmyrO
	MlLfsCjsUSNWNCAdWwVtB95oED6AniARt/ew7FbHZTRhOk+bjQXUUSAh27ygME2/jMg=
X-Gm-Gg: ASbGncsmnwlfWMrEZiI298UTpcM2DNeew2Pjn/ZZJzJdTJidFPCoj9BDGm1CunhCHHI
	6dHuJTW+dJPR6DUdxx+AuZtkH9FgpFQQRgXIceljEKik326eAk5O8Y/cmW/5FZXRtUuQ0Ty+TtU
	CWdE7UBsMeDl9Q2dzlKAeZ4b92kCU5ou5SwYw5rdhLVMMRfayWXnjkAA8UsXFuTL89I2w7kL5UJ
	6alYM5ludQQTplqeRfgBPuNbDHO/WGzCHq5ARwWVw5h3yP6UAZlS33aILCpr/nK7yN5rmCbDVb5
	/Ru67gCDe3pfwX5CGbBtkB/l9ApnWWM9M00tsPdWRJRyH2qz/bPoC1I0xCP2Cnfx9tbstZblEfe
	UQYaHnQrR2nf2eT2qxHktHk62TEJjfLFfJdQodtfknvrNyg6HvNzVF4xASrMooXGXjz5umczDmF
	ZFruLPYctgP8VeiQwZccdPPmXX8NrKu4xvHIvb0IYUVS4j
X-Google-Smtp-Source: AGHT+IHwqTpyjN6Kpfprj3lvyaI65S9KlfYJXUJjVo+3/81P0K/21tdQcXIRqnFGfxS9vPLVolXDMQ==
X-Received: by 2002:a05:600c:1c9d:b0:45d:e135:6bb2 with SMTP id 5b1f17b1804b1-45de1356cc4mr75349405e9.21.1757410656405;
        Tue, 09 Sep 2025 02:37:36 -0700 (PDT)
Received: from ?IPV6:2003:e5:873d:be00:c26:b971:1ba7:9d8b? (p200300e5873dbe000c26b9711ba79d8b.dip0.t-ipconnect.de. [2003:e5:873d:be00:c26:b971:1ba7:9d8b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de16b8b58sm129214985e9.4.2025.09.09.02.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:37:36 -0700 (PDT)
Message-ID: <360712fa-f7a0-4674-acc4-76f79141fe4f@suse.com>
Date: Tue, 9 Sep 2025 11:37:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] x86/xen: support nested lazy_mmu sections (again)
To: David Hildenbrand <david@redhat.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
 <20250908073931.4159362-5-kevin.brodsky@arm.com>
 <aa28c1a7-82fc-42af-9904-a4d4db078a19@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
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
In-Reply-To: <aa28c1a7-82fc-42af-9904-a4d4db078a19@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BeYvUArs7t07H8bFnKjaf7a6"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------BeYvUArs7t07H8bFnKjaf7a6
Content-Type: multipart/mixed; boundary="------------N21H8u063pzOozrNPbZG8YaJ";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: David Hildenbrand <david@redhat.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <360712fa-f7a0-4674-acc4-76f79141fe4f@suse.com>
Subject: Re: [PATCH v2 4/7] x86/xen: support nested lazy_mmu sections (again)
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
 <20250908073931.4159362-5-kevin.brodsky@arm.com>
 <aa28c1a7-82fc-42af-9904-a4d4db078a19@redhat.com>
In-Reply-To: <aa28c1a7-82fc-42af-9904-a4d4db078a19@redhat.com>

--------------N21H8u063pzOozrNPbZG8YaJ
Content-Type: multipart/mixed; boundary="------------ku0itVfiK1E3s3Do8zg7Z645"

--------------ku0itVfiK1E3s3Do8zg7Z645
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkuMDkuMjUgMTE6MTMsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPiBPbiAwOC4w
OS4yNSAwOTozOSwgS2V2aW4gQnJvZHNreSB3cm90ZToNCj4+IENvbW1pdCA0OTE0N2JlYjBj
Y2IgKCJ4ODYveGVuOiBhbGxvdyBuZXN0aW5nIG9mIHNhbWUgbGF6eSBtb2RlIikNCj4+IG9y
aWdpbmFsbHkgaW50cm9kdWNlZCBzdXBwb3J0IGZvciBuZXN0ZWQgbGF6eSBzZWN0aW9ucyAo
TEFaWV9NTVUgYW5kDQo+PiBMQVpZX0NQVSkuIEl0IGxhdGVyIGdvdCByZXZlcnRlZCBieSBj
b21taXQgYzM2NTQ5ZmY4ZDg0IGFzIGl0cw0KPj4gaW1wbGVtZW50YXRpb24gdHVybmVkIG91
dCB0byBiZSBpbnRvbGVyYW50IHRvIHByZWVtcHRpb24uDQo+Pg0KPj4gTm93IHRoYXQgdGhl
IGxhenlfbW11IEFQSSBhbGxvd3MgZW50ZXIoKSB0byBwYXNzIHRocm91Z2ggYSBzdGF0ZSB0
bw0KPj4gdGhlIG1hdGNoaW5nIGxlYXZlKCkgY2FsbCwgd2UgY2FuIHN1cHBvcnQgbmVzdGlu
ZyBhZ2FpbiBmb3IgdGhlDQo+PiBMQVpZX01NVSBtb2RlIGluIGEgcHJlZW1wdGlvbi1zYWZl
IG1hbm5lci4gSWYgeGVuX2VudGVyX2xhenlfbW11KCkgaXMNCj4+IGNhbGxlZCBpbnNpZGUg
YW4gYWN0aXZlIGxhenlfbW11IHNlY3Rpb24sIHhlbl9sYXp5X21vZGUgd2lsbCBhbHJlYWR5
DQo+PiBiZSBzZXQgdG8gWEVOX0xBWllfTU1VIGFuZCB3ZSBjYW4gdGhlbiByZXR1cm4gTEFa
WV9NTVVfTkVTVEVEIHRvDQo+PiBpbnN0cnVjdCB0aGUgbWF0Y2hpbmcgeGVuX2xlYXZlX2xh
enlfbW11KCkgY2FsbCB0byBsZWF2ZQ0KPj4geGVuX2xhenlfbW9kZSB1bmNoYW5nZWQuDQo+
Pg0KPj4gVGhlIG9ubHkgZWZmZWN0IG9mIHRoaXMgcGF0Y2ggaXMgdG8gZW5zdXJlIHRoYXQg
eGVuX2xhenlfbW9kZQ0KPj4gcmVtYWlucyBzZXQgdG8gWEVOX0xBWllfTU1VIHVudGlsIHRo
ZSBvdXRlcm1vc3QgbGF6eV9tbXUgc2VjdGlvbg0KPj4gZW5kcy4geGVuX2xlYXZlX2xhenlf
bW11KCkgc3RpbGwgY2FsbHMgeGVuX21jX2ZsdXNoKCkNCj4+IHVuY29uZGl0aW9uYWxseS4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBLZXZpbiBCcm9kc2t5IDxrZXZpbi5icm9kc2t5QGFy
bS5jb20+DQo+PiAtLS0NCj4+IMKgIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0LmjC
oMKgwqDCoMKgwqAgfMKgIDYgKystLS0tDQo+PiDCoCBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9w
YXJhdmlydF90eXBlcy5oIHzCoCA0ICsrLS0NCj4+IMKgIGFyY2gveDg2L3hlbi9tbXVfcHYu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTEgKysrKysrKystLS0NCj4+
IMKgIDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaCBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0LmgNCj4+IGluZGV4IDY1YTBkMzk0ZmJh
MS4uNGVjZDNhNmIxZGVhIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
cGFyYXZpcnQuaA0KPj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaA0K
Pj4gQEAgLTUyOSwxNCArNTI5LDEyIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhcmNoX2VuZF9j
b250ZXh0X3N3aXRjaChzdHJ1Y3QgDQo+PiB0YXNrX3N0cnVjdCAqbmV4dCkNCj4+IMKgICNk
ZWZpbmXCoCBfX0hBVkVfQVJDSF9FTlRFUl9MQVpZX01NVV9NT0RFDQo+PiDCoCBzdGF0aWMg
aW5saW5lIGxhenlfbW11X3N0YXRlX3QgYXJjaF9lbnRlcl9sYXp5X21tdV9tb2RlKHZvaWQp
DQo+PiDCoCB7DQo+PiAtwqDCoMKgIFBWT1BfVkNBTEwwKG1tdS5sYXp5X21vZGUuZW50ZXIp
Ow0KPj4gLQ0KPj4gLcKgwqDCoCByZXR1cm4gTEFaWV9NTVVfREVGQVVMVDsNCj4+ICvCoMKg
wqAgcmV0dXJuIFBWT1BfQ0FMTDAobGF6eV9tbXVfc3RhdGVfdCwgbW11LmxhenlfbW9kZS5l
bnRlcik7DQo+PiDCoCB9DQo+PiDCoCBzdGF0aWMgaW5saW5lIHZvaWQgYXJjaF9sZWF2ZV9s
YXp5X21tdV9tb2RlKGxhenlfbW11X3N0YXRlX3Qgc3RhdGUpDQo+PiDCoCB7DQo+PiAtwqDC
oMKgIFBWT1BfVkNBTEwwKG1tdS5sYXp5X21vZGUubGVhdmUpOw0KPj4gK8KgwqDCoCBQVk9Q
X1ZDQUxMMShtbXUubGF6eV9tb2RlLmxlYXZlLCBzdGF0ZSk7DQo+PiDCoCB9DQo+PiDCoCBz
dGF0aWMgaW5saW5lIHZvaWQgYXJjaF9mbHVzaF9sYXp5X21tdV9tb2RlKHZvaWQpDQo+PiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnRfdHlwZXMuaCBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtLyANCj4+IHBhcmF2aXJ0X3R5cGVzLmgNCj4+IGluZGV4IGJj
MWFmODY4NjhhMy4uYjdjNTY3Y2NiZjMyIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vcGFyYXZpcnRfdHlwZXMuaA0KPj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9h
c20vcGFyYXZpcnRfdHlwZXMuaA0KPj4gQEAgLTQ1LDggKzQ1LDggQEAgdHlwZWRlZiBpbnQg
bGF6eV9tbXVfc3RhdGVfdDsNCj4+IMKgIHN0cnVjdCBwdl9sYXp5X29wcyB7DQo+PiDCoMKg
wqDCoMKgIC8qIFNldCBkZWZlcnJlZCB1cGRhdGUgbW9kZSwgdXNlZCBmb3IgYmF0Y2hpbmcg
b3BlcmF0aW9ucy4gKi8NCj4+IC3CoMKgwqAgdm9pZCAoKmVudGVyKSh2b2lkKTsNCj4+IC3C
oMKgwqAgdm9pZCAoKmxlYXZlKSh2b2lkKTsNCj4+ICvCoMKgwqAgbGF6eV9tbXVfc3RhdGVf
dCAoKmVudGVyKSh2b2lkKTsNCj4+ICvCoMKgwqAgdm9pZCAoKmxlYXZlKShsYXp5X21tdV9z
dGF0ZV90KTsNCj4+IMKgwqDCoMKgwqAgdm9pZCAoKmZsdXNoKSh2b2lkKTsNCj4+IMKgIH0g
X19ub19yYW5kb21pemVfbGF5b3V0Ow0KPj4gwqAgI2VuZGlmDQo+PiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYveGVuL21tdV9wdi5jIGIvYXJjaC94ODYveGVuL21tdV9wdi5jDQo+PiBpbmRl
eCAyMDM5ZDUxMzJjYTMuLjZlNTM5MGZmMDZhNSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2
L3hlbi9tbXVfcHYuYw0KPj4gKysrIGIvYXJjaC94ODYveGVuL21tdV9wdi5jDQo+PiBAQCAt
MjEzMCw5ICsyMTMwLDEzIEBAIHN0YXRpYyB2b2lkIHhlbl9zZXRfZml4bWFwKHVuc2lnbmVk
IGlkeCwgcGh5c19hZGRyX3QgDQo+PiBwaHlzLCBwZ3Byb3RfdCBwcm90KQ0KPj4gwqAgI2Vu
ZGlmDQo+PiDCoCB9DQo+PiAtc3RhdGljIHZvaWQgeGVuX2VudGVyX2xhenlfbW11KHZvaWQp
DQo+PiArc3RhdGljIGxhenlfbW11X3N0YXRlX3QgeGVuX2VudGVyX2xhenlfbW11KHZvaWQp
DQo+PiDCoCB7DQo+PiArwqDCoMKgIGlmICh0aGlzX2NwdV9yZWFkKHhlbl9sYXp5X21vZGUp
ID09IFhFTl9MQVpZX01NVSkNCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gTEFaWV9NTVVf
TkVTVEVEOw0KPj4gKw0KPiANCj4gWW91IG1lbnRpb24gYWJvdmUgInByZWVtcHRpb24tc2Fm
ZSBtYW5uZXIiIGFib3ZlLCBzbyBJIGFtIHdvbmRlcmluZywNCj4gd2hhdCBpZiB3ZSBnZXQg
cHJlZW1wdGVkIGltbWVkaWF0ZWx5IGFmdGVyIGRvaW5nIHRoZSB0aGlzX2NwdV9yZWFkKCkg
YW5kIGdldCANCj4gc2NoZWR1bGVkIG9uIGFub3RoZXIgQ1BVPw0KPiANCg0KVGhpcyBzaG91
bGQgc3RpbGwgYmUgY29ycmVjdDogcHJlZW1wdGlvbiBuZWVkcyBhIGNvbnRleHQgc3dpdGNo
IHRvIGhhcHBlbiwNCnNvIHhlbl9zdGFydF9jb250ZXh0X3N3aXRjaCgpIGFuZCB4ZW5fZW5k
X2NvbnRleHRfc3dpdGNoKCkgYXJlIGludm9sdmVkLg0KVGhvc2UgYXJlIGRlYWxpbmcgd2l0
aCB0aGlzIHByb2JsZW0gYnkgZG9pbmcgdGhlIHJpZ2h0IHRoaW5nIGluIHRoZSBvbGQNCmFu
ZCB0aGUgbmV3IGNvbnRleHQuDQoNCg0KSnVlcmdlbg0K
--------------ku0itVfiK1E3s3Do8zg7Z645
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------ku0itVfiK1E3s3Do8zg7Z645--

--------------N21H8u063pzOozrNPbZG8YaJ--

--------------BeYvUArs7t07H8bFnKjaf7a6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmi/9V4FAwAAAAAACgkQsN6d1ii/Ey+F
eAf+JATQ71kRnWaomTj1xL+hfmy+uZt/wVyu3xYTMbJ9EWKIHTJr/D1HsJgdDwE2A5eGGzTSCd5X
PY69tcvWQHLYqi689FgEbCGN2InjvaAtQncZecnR47pyIeYp5IctlX9bkH2BeRw5LrV22rRdLwXn
gBiHVv8Hc7Q0U5MdAfWlYld7f60jjKOL7nrkPnuycfxdXE6LRoKXvavgkczfj3OUfxLpJKN2eUNz
De7Ot1NAH2KSq5mx7560580j0QE1cyJwru6S14unms+MyjlcBxiNtEeRRskOwuPAJ4m8c7CapmbD
/rYnIaeNCRqVGx0NPnojTaMCE+tMExv1H15wHlWA3w==
=5cPm
-----END PGP SIGNATURE-----

--------------BeYvUArs7t07H8bFnKjaf7a6--

