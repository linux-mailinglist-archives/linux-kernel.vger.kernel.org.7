Return-Path: <linux-kernel+bounces-665527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E75AAC6A70
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE531BC7555
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCE1286D42;
	Wed, 28 May 2025 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IXzpZcKN"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A81367
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748439038; cv=none; b=OVUZrCFcJKp7Vu9wHNanSZ6srayXd5+k1Cee8sEw/QoZku1mIDYtvy+GF/fM5J8E5Ej/Na2b/XAGPBg3A+fATA9ZqIErezPjlNUJMyWRz2L2CueCXj72+4yLG6T5/XG9yQN85qT/ZvzjbXZubTmqAWz8dbkwRVsQ768rvDm55zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748439038; c=relaxed/simple;
	bh=nbxHvc/1UXYMfKxHHjVvBcdBjfJFZfU930enKhM3DyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/WXueJVKkIoPynesAa2jYfK8zwNQQvIbxN4K4OqF5FCWuCwPEMO+nX8PX3d34L+kK9vrfzd+O1KJHFG5B1PVymphn7yA//+uvK1CpPxAOcv5mgny+7+w5URu5T9rzPvh1zhIWr4KFm+krLc6lwIBXUhR9KsTAdu+PDhlcNtZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IXzpZcKN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad883afdf0cso491395966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748439035; x=1749043835; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nbxHvc/1UXYMfKxHHjVvBcdBjfJFZfU930enKhM3DyU=;
        b=IXzpZcKNezv4HCi95pzlhtKqUuvM4puJbRZyDr4kgD+/76QggZh9co6bKWFczD9UL0
         9rLrsEZRyW7eRsqn2krckaPWsESfCzLaF6YK0Qn62JiklatGpSMgbfEs24Ntsye7h7u/
         Joghwasb0QeFuRyUa9WI9p9YkvCEeRRRNT+iWeIBPE0PXucFtJxOc4qttj2yNPffiT8o
         ljmAujdVJoFrt7Z0sUqcjirFBX7Ir01Z7ymdXQi/4yIQAd1PBZfSEqB9RIID44mgJhy2
         iP9MrdxgpncIPuM5IPXPdvj30B2TrsqawJ8uGa95z4Wy6b6mSzkhfNOHjFfdkjSSSX58
         pEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748439035; x=1749043835;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbxHvc/1UXYMfKxHHjVvBcdBjfJFZfU930enKhM3DyU=;
        b=RwYaGqsQFcoN64BabgleVY/SBwR1hw/OianVS+7H/FTaTjt5peNjRf72zbe9VZCc3d
         Lbd6vs2FUrtAyQFhVjM6Boi1pp7zekJr2Qq4USsHO43/bUhweq41r/b9NYmRgbfWN2aR
         nh2tX5ggSod0JFvZYaJMF27NFT7/xgxJhdAdo3MPxsfWO/7zq7wIWIzRuqczN0l1wjjN
         RF3HxkdCxUtTKWuXOHn+mn2Pm90I50Keup+cBEaA2cZE12+VrhokzBSprIa2X2+MmIlL
         8CZe87itA1Viff3b7VIVLtP9PmnGovvnBSxbxnLwcHZac8d3I3Ur8O3t/m5TDi2WUHnW
         vaQQ==
X-Gm-Message-State: AOJu0Yw2uCwz7EzgXmp4Pp5moeQVUEOL9P7f89HMxFP+wQXT0Vub2zZb
	IYJ/ywYvi+8KQjDzijCcf/02zm1BdNWOsOGRbfncRz1xVLg5R7sF4lodIQB/rjI4kso=
X-Gm-Gg: ASbGncvxWS4FrOV6z1YekWklxTsIAUCtxn4VlDJx8W7g8riGOYqUwpWfdK3FKDYodOs
	nQKYOKvFsHuJVh3SEG4tLBV+hLmkqTvxqNN9BxwTPhhxqWRD5MEsssOQ2yIc6y+sECciEXyFVUG
	O2xgHABe+q8ftJeRPra7Be4JvcAZPeVgSEgxct/ODBZJOYeYzRCR/yI3kXt2tdQbAi3BBWgMcSk
	4gbdfpQUpK4NeDgeugOihiiTDFqXMaPOIQl+E7S809h7pAnNXO70keIvCQUA11sgvY82pg+fFgV
	mbwXUBYk1nFfZ5mq4I4m8A1g7IXWMyPhshmBW5FegKYlMFxFde6WqeACE5VNBIWHafn9BcN93OG
	hzEYcUcw+/STbx85o486CuTQNIzf0Phw3lhgYSBtIvJo9hqnpjHaC8Z+Vnveld73PVlAZzirASk
	PL
X-Google-Smtp-Source: AGHT+IHftjl/IElewdxmuBkjHJFkfiEQrS+QzWH7g5Rh+/nBIQX8StE5oEUjnma1M/1rud3PTR90AA==
X-Received: by 2002:a17:907:7288:b0:ad8:9e80:6ba3 with SMTP id a640c23a62f3a-ad89e807c46mr234927766b.7.1748439034778;
        Wed, 28 May 2025 06:30:34 -0700 (PDT)
Received: from ?IPV6:2003:e5:872a:8800:5c7b:1ac1:4fa0:423b? (p200300e5872a88005c7b1ac14fa0423b.dip0.t-ipconnect.de. [2003:e5:872a:8800:5c7b:1ac1:4fa0:423b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a19accc3sm108090166b.9.2025.05.28.06.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 06:30:34 -0700 (PDT)
Message-ID: <7c8bf4f5-29a0-4147-b31a-5e420b11468e@suse.com>
Date: Wed, 28 May 2025 15:30:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
References: <20250528123557.12847-1-jgross@suse.com>
 <20250528123557.12847-4-jgross@suse.com>
 <20250528131052.GZ39944@noisy.programming.kicks-ass.net>
 <044f0048-95bb-4822-978e-a23528f3891f@suse.com>
 <20250528132231.GB39944@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20250528132231.GB39944@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------L69koOEljdcF9MVPUuFhn8Cb"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------L69koOEljdcF9MVPUuFhn8Cb
Content-Type: multipart/mixed; boundary="------------vuh9P78POzL0ISLqQ6jiBRpD";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Message-ID: <7c8bf4f5-29a0-4147-b31a-5e420b11468e@suse.com>
Subject: Re: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
References: <20250528123557.12847-1-jgross@suse.com>
 <20250528123557.12847-4-jgross@suse.com>
 <20250528131052.GZ39944@noisy.programming.kicks-ass.net>
 <044f0048-95bb-4822-978e-a23528f3891f@suse.com>
 <20250528132231.GB39944@noisy.programming.kicks-ass.net>
In-Reply-To: <20250528132231.GB39944@noisy.programming.kicks-ass.net>

--------------vuh9P78POzL0ISLqQ6jiBRpD
Content-Type: multipart/mixed; boundary="------------oIQOW2zmWhZj7EZXcAARi2OI"

--------------oIQOW2zmWhZj7EZXcAARi2OI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDUuMjUgMTU6MjIsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBXZWQsIE1h
eSAyOCwgMjAyNSBhdCAwMzoxOToyNFBNICswMjAwLCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0K
Pj4gT24gMjguMDUuMjUgMTU6MTAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+IE9uIFdl
ZCwgTWF5IDI4LCAyMDI1IGF0IDAyOjM1OjU3UE0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3Jv
dGU6DQo+Pj4+IFdoZW4gYWxsb2NhdGluZyBtZW1vcnkgcGFnZXMgZm9yIGtlcm5lbCBJVFMg
dGh1bmtzLCBtYWtlIHRoZW0gcmVhZC1vbmx5DQo+Pj4+IGFmdGVyIGhhdmluZyB3cml0dGVu
IHRoZSBsYXN0IHRodW5rLg0KPj4+Pg0KPj4+PiBUaGlzIHdpbGwgYmUgbmVlZGVkIHdoZW4g
WDg2X0ZFQVRVUkVfUFNFIGlzbid0IGF2YWlsYWJsZSwgYXMgdGhlIHRodW5rDQo+Pj4+IG1l
bW9yeSB3aWxsIGhhdmUgUEFHRV9LRVJORUxfRVhFQyBwcm90ZWN0aW9uLCB3aGljaCBpcyBp
bmNsdWRpbmcgdGhlDQo+Pj4+IHdyaXRlIHBlcm1pc3Npb24uDQo+Pj4+DQo+Pj4+IENjOiA8
c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4+Pj4gRml4ZXM6IDUxODVlN2Y5ZjNiZCAoIng4
Ni9tb2R1bGU6IGVuYWJsZSBST1ggY2FjaGVzIGZvciBtb2R1bGUgdGV4dCBvbiA2NCBiaXQi
KQ0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
DQo+Pj4+IC0tLQ0KPj4+PiAgICBhcmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYyB8IDE2
ICsrKysrKysrKysrKysrKysNCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5h
dGl2ZS5jIGIvYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMNCj4+Pj4gaW5kZXggZWNm
ZTdiNDk3Y2FkLi5iZDk3NGEwYWM4OGEgMTAwNjQ0DQo+Pj4+IC0tLSBhL2FyY2gveDg2L2tl
cm5lbC9hbHRlcm5hdGl2ZS5jDQo+Pj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5h
dGl2ZS5jDQo+Pj4+IEBAIC0yMTcsNiArMjE3LDE1IEBAIHN0YXRpYyB2b2lkICppdHNfYWxs
b2Modm9pZCkNCj4+Pj4gICAgCXJldHVybiBub19mcmVlX3B0cihwYWdlKTsNCj4+Pj4gICAg
fQ0KPj4+PiArc3RhdGljIHZvaWQgaXRzX3NldF9rZXJuZWxfcm8odm9pZCAqYWRkcikNCj4+
Pj4gK3sNCj4+Pj4gKyNpZmRlZiBDT05GSUdfTU9EVUxFUw0KPj4+PiArCWlmIChpdHNfbW9k
KQ0KPj4+PiArCQlyZXR1cm47DQo+Pj4+ICsjZW5kaWYNCj4+Pj4gKwlleGVjbWVtX3Jlc3Rv
cmVfcm94KGFkZHIsIFBBR0VfU0laRSk7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gICAgc3Rh
dGljIHZvaWQgKml0c19hbGxvY2F0ZV90aHVuayhpbnQgcmVnKQ0KPj4+PiAgICB7DQo+Pj4+
ICAgIAlpbnQgc2l6ZSA9IDMgKyAocmVnIC8gOCk7DQo+Pj4+IEBAIC0yMzQsNiArMjQzLDgg
QEAgc3RhdGljIHZvaWQgKml0c19hbGxvY2F0ZV90aHVuayhpbnQgcmVnKQ0KPj4+PiAgICAj
ZW5kaWYNCj4+Pj4gICAgCWlmICghaXRzX3BhZ2UgfHwgKGl0c19vZmZzZXQgKyBzaXplIC0g
MSkgPj0gUEFHRV9TSVpFKSB7DQo+Pj4+ICsJCWlmIChpdHNfcGFnZSkNCj4+Pj4gKwkJCWl0
c19zZXRfa2VybmVsX3JvKGl0c19wYWdlKTsNCj4+Pj4gICAgCQlpdHNfcGFnZSA9IGl0c19h
bGxvYygpOw0KPj4+PiAgICAJCWlmICghaXRzX3BhZ2UpIHsNCj4+Pj4gICAgCQkJcHJfZXJy
KCJJVFMgcGFnZSBhbGxvY2F0aW9uIGZhaWxlZFxuIik7DQo+Pj4+IEBAIC0yMzM4LDYgKzIz
NDksMTEgQEAgdm9pZCBfX2luaXQgYWx0ZXJuYXRpdmVfaW5zdHJ1Y3Rpb25zKHZvaWQpDQo+
Pj4+ICAgIAlhcHBseV9yZXRwb2xpbmVzKF9fcmV0cG9saW5lX3NpdGVzLCBfX3JldHBvbGlu
ZV9zaXRlc19lbmQpOw0KPj4+PiAgICAJYXBwbHlfcmV0dXJucyhfX3JldHVybl9zaXRlcywg
X19yZXR1cm5fc2l0ZXNfZW5kKTsNCj4+Pj4gKwkvKiBNYWtlIHBvdGVudGlhbCBsYXN0IHRo
dW5rIHBhZ2UgcmVhZC1vbmx5LiAqLw0KPj4+PiArCWlmIChpdHNfcGFnZSkNCj4+Pj4gKwkJ
aXRzX3NldF9rZXJuZWxfcm8oaXRzX3BhZ2UpOw0KPj4+PiArCWl0c19wYWdlID0gTlVMTDsN
Cj4+Pj4gKw0KPj4+PiAgICAJLyoNCj4+Pj4gICAgCSAqIEFkanVzdCBhbGwgQ0FMTCBpbnN0
cnVjdGlvbnMgdG8gcG9pbnQgdG8gZnVuYygpLTEwLCBpbmNsdWRpbmcNCj4+Pj4gICAgCSAq
IHRob3NlIGluIC5hbHRpbnN0cl9yZXBsYWNlbWVudC4NCj4+Pg0KPj4+IE5vLCB0aGlzIGlz
IGFsbCBzb3J0cyBvZiB3cm9uZy4gRXhlY21lbSBBUEkgc2hvdWxkIGVuc3VyZSB0aGlzLg0K
Pj4NCj4+IFlvdSBhcmUgYXdhcmUgdGhhdCB0aGlzIHBhdGNoIGlzIGJhc2ljYWxseSBtaXJy
b3JpbmcgdGhlIHdvcmsgd2hpY2ggaXMNCj4+IGFscmVhZHkgZG9uZSBmb3IgbW9kdWxlcyBp
biBhbHRlcm5hdGl2ZS5jPw0KPiANCj4gSSBhbSBoYXZpbmcgdHJvdWJsZSBwYXJzaW5nIHRo
YXQgLS0gd2hlcmUgZG9lcyBhbHRlcm5hdGl2ZS5jIGRvIHRoaXMgdG8NCj4gbW9kdWxlcz8N
Cg0KSGF2ZSBhIGxvb2sgYXQgaXRzX2ZpbmlfbW9kKCkuDQoNCg0KSnVlcmdlbg0K
--------------oIQOW2zmWhZj7EZXcAARi2OI
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------oIQOW2zmWhZj7EZXcAARi2OI--

--------------vuh9P78POzL0ISLqQ6jiBRpD--

--------------L69koOEljdcF9MVPUuFhn8Cb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmg3D/kFAwAAAAAACgkQsN6d1ii/Ey9F
Dgf8CtY11GTpCyhQQ4rVkNZvOF+9StCr8+dla2eruAf3u13kQRq9DJj8eXdyvrHXa5VNh9Sxc/bP
2R9oqQttZYoiFFKc//iMGCZZb6lAQ8laESqyYM6sOaCLseTT787t0LILUAXNyrydKCdgmEMivNMv
Fh84Osn431nJ3/Pcj4e9xcoqQtblv7QTtm3+llW8v8OPxgB0x479bkq8ekggtc0wc3snUA6+eNis
aJuPLobOLRKgnRqhZWEQqoSmluyUWyTAu+LPq4M5b7BpW71PGsY2a9i37tvgQfSJKqrvN/XHn9dX
ghdajMYjq/7aoOTXiiap59TlBW5cK9GMCzGqZ+wtgQ==
=al9Z
-----END PGP SIGNATURE-----

--------------L69koOEljdcF9MVPUuFhn8Cb--

