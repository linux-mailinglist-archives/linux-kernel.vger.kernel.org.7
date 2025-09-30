Return-Path: <linux-kernel+bounces-837877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C8BADF30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E44D4E25DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4144306D47;
	Tue, 30 Sep 2025 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JxZpcp7/"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A71DE4E1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246950; cv=none; b=rcwyK67QsoIJPTlHoT2hG7LV6s4jwAkd4C3gHLZNA1XHsWqvalnLKfIICCgdioipRCnGUWa4atiMtlvCOrFIFN2ZT+us1MkT/MNXBE0wvGoQ+QN1SS1Gofv5ltohVgSqYpU02osjdw9VevV9vJ5NSWSaowZXUkjgRsjpm/oLGvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246950; c=relaxed/simple;
	bh=feulr94GI8kB8xRHdy+ur/i3nwXnVWO09eLmH/2948M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZqy5rGrkkMHHW6p+Dy5m+Bz3TXq5BUiP6Du4Iq8bZvk4LZiRQQI/+46JRKu7UJ0lmt17fKu9uCoofxhkWpTcOEcs4D10Ivn6m4Ez66UdSDe+a+r2uOinGWTSIZhVEFCBX/wJuDnrd5TMB9trAUxOySl27/Wi5Jo4yDXUmzPPBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JxZpcp7/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3c2db014easo575533866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759246947; x=1759851747; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=feulr94GI8kB8xRHdy+ur/i3nwXnVWO09eLmH/2948M=;
        b=JxZpcp7/GQ45JxLH/3Q+6bjTKLweV0H1CPMQ0ca6gYxMVHPEt6jVeZxH+/cxNPJd1r
         UpmcHK7wCfQ/i4QM9kEfLg/pjimUEANXn87c7tEftRAYez6MhFh9pL1ebbO1Baia+Zlq
         1z76s/CfiORC8CBJETkL6k846aqWfUlfI6VoK8sC+TGcM5bZjF3ZU5xgpFI0uHW3p9Dr
         OReobOefLLVoAiNSGqLNqRD1jF7WjDKnUWGcg34HHtOP/n3IjfJmGZozslYWEAYC9qB6
         Cz0LhtvXmfrbIPF6xrmSXFhz87joNr+ytfwfXf5K5RPm6kQPMUFtUszGbPmmR64hVHc9
         aFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759246947; x=1759851747;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=feulr94GI8kB8xRHdy+ur/i3nwXnVWO09eLmH/2948M=;
        b=eSwUTyxc7qu6t4nbHphejngNwWhGC2dSkHmh++JocRQpRiJC0EcQsl+2PNckdFd29J
         lLLBtWNN0WdAPgQ/t8i/sXotFDc/IVxQYYIf+zA5+0HS20gsMGgqT8fRIK+GILzmS57j
         Wz5GkfICamoIcLl1kAzru6zNxxN/Jpg7RyvM+EYFk7YmUbULFR9spa6hgl+tY2exRyp0
         z5IJRrsGB+cF+QKSu1DFWRaD+ij3UrAxP2CTgtPfTku4HYjjNogQeblb7J9BMrYkU5V5
         mlNB8yFIdwLgZqK8y5/OrQU0jh8e33lVAoBPT0f8+Bl/mv6f9c0Kn44lsupNWX0HyFIS
         TDjg==
X-Gm-Message-State: AOJu0YzjWhZD5czN4JGJEbWma4+n2/4AdpqPsFwOvoT22UO/OfK37QUp
	FGTogBCLLG12kghRb1cApCH5t85MqD2nKBcp+hBpeBCAtCH0ORVBnjL4XY4yi/hfc6s=
X-Gm-Gg: ASbGncvKhbGA6KDGMXd0Gii3yGYA7m/nkEdX+j1OGBfKFsnl8gLtIUXkK5MSKWNn9/M
	TpisVA3jEZrtp3ORuc3C8tm5sI6ufhkBJ9jIB1WdMjSJOr7BB8QJwXJwykWpbLoHdcUs+D270fK
	JKHkp5KfTHLaQdhxsgpgyoMD308vwLGfs7/h5NyTpkw59fu2QRivKeVun7W+lgKLVXv+o/LSSbE
	FJYkUjrY+pCm4pu1kw0BJanOs4XQ75gjwGjV3rmlSP0oSyeQoL7XK0+lwVPoRSyVwxvSMdD/ODX
	VeSQeJM7/IZV6db++lkd4fvnvuBD6Vh+QzD2BbZop7IfMsHwsRrZLrlI3qy2NtLOPyTrzQC4qJr
	D8+L7W6c+1DLHsqZZcSjWeoyksOIEOQm+471RFjYcUS9h6/8hBtHYsN3J1XBB2GHgChZnEIDF6F
	LSIkWJxQ9nsrmdxW/jA5wsXYYrrj7Y3sKg8vdseuru/eJWDxtFUUcGl84b/N6lQUhj0vZGdjBBx
	c/2zOc=
X-Google-Smtp-Source: AGHT+IFfUBRYulHBwf7ahWlyYjYfRuKcvdU3FC87Fo/u7cHgOVImddsj25CUSn0cb/pnH8DQwcqZuQ==
X-Received: by 2002:a17:907:9405:b0:b04:3b97:f965 with SMTP id a640c23a62f3a-b46e6afc90dmr6145666b.49.1759246934987;
        Tue, 30 Sep 2025 08:42:14 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3f3b7eb5ffsm414810866b.90.2025.09.30.08.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 08:42:14 -0700 (PDT)
Message-ID: <2ad137cb-ed38-42f6-ac0a-a81569051779@suse.com>
Date: Tue, 30 Sep 2025 17:42:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
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
 <20250930085044.GK3245006@noisy.programming.kicks-ass.net>
 <20250930125156.GK1386988@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20250930125156.GK1386988@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------G5ZDsJFAeWU3wk5VMeVpL07n"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------G5ZDsJFAeWU3wk5VMeVpL07n
Content-Type: multipart/mixed; boundary="------------WQ0dpVSuF9i7vtFDogawA4is";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
 xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Message-ID: <2ad137cb-ed38-42f6-ac0a-a81569051779@suse.com>
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com>
 <20250930083137.GH3245006@noisy.programming.kicks-ass.net>
 <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>
 <20250930085044.GK3245006@noisy.programming.kicks-ass.net>
 <20250930125156.GK1386988@noisy.programming.kicks-ass.net>
In-Reply-To: <20250930125156.GK1386988@noisy.programming.kicks-ass.net>

--------------WQ0dpVSuF9i7vtFDogawA4is
Content-Type: multipart/mixed; boundary="------------wCjuGdyXwIWCn2JOl5aqCNtv"

--------------wCjuGdyXwIWCn2JOl5aqCNtv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDkuMjUgMTQ6NTEsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUdWUsIFNl
cCAzMCwgMjAyNSBhdCAxMDo1MDo0NEFNICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4+IE9uIFR1ZSwgU2VwIDMwLCAyMDI1IGF0IDEwOjQ2OjIzQU0gKzAyMDAsIErDvHJnZW4g
R3Jvw58gd3JvdGU6DQo+IA0KPj4+PiAJYXNtX2lubGluZSB2b2xhdGlsZSBnb3RvKA0KPj4+
PiAJCSIxOlxuIg0KPj4+PiAJCUFMVEVSTkFUSVZFKFBSRVBBUkVfUkNYX1JEWF9GT1JfV1JN
U1INCj4+Pj4gCQkJICAgICIyOlxuIg0KPj4+PiAJCQkgICAgQUxURVJOQVRJVkUoImRzIHdy
bXNyIiwNCj4+Pj4gCQkJICAgICAgICAgICAgICAgIEFTTV9XUk1TUk5TLCBYODZfRkVBVFVS
RV9XUk1TUk5TKSwNCj4+Pj4gCQkJICAgIEFTTV9XUk1TUk5TX0lNTSwgWDg2X0ZFQVRVUkVf
TVNSX0lNTSk7DQo+Pj4+IAkJX0FTTV9FWFRBQkxFX1RZUEUoMWIsICVsW2JhZG1zcl0sICVj
W3R5cGVdKQkvKiBGb3IgV1JNU1JOUyBpbW1lZGlhdGUgKi8NCj4+Pj4gCQlfQVNNX0VYVEFC
TEVfVFlQRSgyYiwgJWxbYmFkbXNyXSwgJWNbdHlwZV0pCS8qIEZvciBXUk1TUihOUykgKi8N
Cj4+Pj4NCj4+Pj4gCQk6DQo+Pj4+IAkJOiBbdmFsXSAiYSIgKHZhbCksIFttc3JdICJpIiAo
bXNyKSwgW3R5cGVdICJpIiAodHlwZSkNCj4+Pj4gCQk6ICJtZW1vcnkiLCAiZWN4IiwgInJk
eCINCj4+Pj4gCQk6IGJhZG1zcik7DQo+Pj4+DQo+IA0KPj4gT2ggd2VsbCwgbGV0cyBmb3Jn
ZXQgYWJvdXQgdGhpcyA6LSkNCj4gDQo+IFNvIEkgY291bGRuJ3QuIEkgdHJpZWQgdGhlIGJl
bG93LCB3aGljaCB3aGVuIGJ1aWxkaW5nIGEgLmkgZ2VuZXJhdGVzIHRoZQ0KPiBmb2xsb3dp
bmc6DQo+IA0KPiANCj4gc3RhdGljIGlubGluZSBfX2F0dHJpYnV0ZV9fKChfX2dudV9pbmxp
bmVfXykpIF9fYXR0cmlidXRlX18oKF9fdW51c2VkX18pKSBfX2F0dHJpYnV0ZV9fKChub19p
bnN0cnVtZW50X2Z1bmN0aW9uKSkgdm9pZCBjbGVhcl9wYWdlKHZvaWQgKnBhZ2UpDQo+IHsN
Cj4gDQo+ICAga21zYW5fdW5wb2lzb25fbWVtb3J5KHBhZ2UsICgoMVVMKSA8PCAxMikpOw0K
PiAgIGFzbSBfX2lubGluZSB2b2xhdGlsZSgNCj4gICAJIiMgQUxUOiBvbGRpbnN0clxuIg0K
PiAJIl9fVU5JUVVFX0lEX2FsdGluc3RyXzkiICJfYmVnaW46XG5cdCINCj4gDQo+IAkJIiMg
QUxUOiBvbGRpbnN0clxuIg0KPiAJCSJfX1VOSVFVRV9JRF9hbHRpbnN0cl84IiAiX2JlZ2lu
OlxuXHQiDQo+IAkJImNhbGwgJWNbb2xkXSIgIlxuIg0KPiAJCSJfX1VOSVFVRV9JRF9hbHRp
bnN0cl84IiAiX3BhZDpcbiINCj4gCQkiIyBBTFQ6IHBhZGRpbmdcbiINCj4gCQkiLnNraXAg
LSgoKCIgIl9fVU5JUVVFX0lEX2FsdGluc3RyXzgiICJfYWx0X2VuZCAtICIgIl9fVU5JUVVF
X0lEX2FsdGluc3RyXzgiICJfYWx0X2JlZ2luIiAiKS0oIiAiX19VTklRVUVfSURfYWx0aW5z
dHJfOCIgIl9wYWQgLSAiICJfX1VOSVFVRV9JRF9hbHRpbnN0cl84IiAiX2JlZ2luIiAiKSkg
PiAwKSAqICINCj4gCQkiKCgiICJfX1VOSVFVRV9JRF9hbHRpbnN0cl84IiAiX2FsdF9lbmQg
LSAiICJfX1VOSVFVRV9JRF9hbHRpbnN0cl84IiAiX2FsdF9iZWdpbiIgIiktKCIgIl9fVU5J
UVVFX0lEX2FsdGluc3RyXzgiICJfcGFkIC0gIiAiX19VTklRVUVfSURfYWx0aW5zdHJfOCIg
Il9iZWdpbiIgIikpLDB4OTBcbiINCj4gCQkiX19VTklRVUVfSURfYWx0aW5zdHJfOCIgIl9l
bmQ6XG4iDQo+IAkJIi5wdXNoc2VjdGlvbiAuYWx0aW5zdHJ1Y3Rpb25zLFwiYVwiXG4iDQo+
IAkJIiAubG9uZyAiICJfX1VOSVFVRV9JRF9hbHRpbnN0cl84IiAiX2JlZ2luIC0gLlxuIg0K
PiAJCSIgLmxvbmcgIiAiX19VTklRVUVfSURfYWx0aW5zdHJfOCIgIl9hbHRfYmVnaW4gLSAu
XG4iDQo+IAkJIiAuNGJ5dGUgIiAiKCAzKjMyKzE2KSIgIlxuIg0KPiAJCSIgLmJ5dGUgIiAi
X19VTklRVUVfSURfYWx0aW5zdHJfOCIgIl9lbmQgLSAiICJfX1VOSVFVRV9JRF9hbHRpbnN0
cl84IiAiX2JlZ2luIiAiXG4iDQo+IAkJIiAuYnl0ZSAiICJfX1VOSVFVRV9JRF9hbHRpbnN0
cl84IiAiX2FsdF9lbmQgLSAiICJfX1VOSVFVRV9JRF9hbHRpbnN0cl84IiAiX2FsdF9iZWdp
biIgIlxuIg0KPiAJCSIucG9wc2VjdGlvblxuIg0KPiAJCSIucHVzaHNlY3Rpb24gLmFsdGlu
c3RyX3JlcGxhY2VtZW50LCBcImF4XCJcbiINCj4gCQkiIyBBTFQ6IHJlcGxhY2VtZW50XG4i
DQo+IAkJIl9fVU5JUVVFX0lEX2FsdGluc3RyXzgiICJfYWx0X2JlZ2luOlxuXHQiDQo+IAkJ
ImNhbGwgJWNbbmV3MV0iICJcbiINCj4gCQkiX19VTklRVUVfSURfYWx0aW5zdHJfOCIgIl9h
bHRfZW5kOlxuIg0KPiAJCSIucG9wc2VjdGlvblxuIg0KPiAJCSJcbiINCj4gDQo+IAkiX19V
TklRVUVfSURfYWx0aW5zdHJfOSIgIl9wYWQ6XG4iDQo+IAkiIyBBTFQ6IHBhZGRpbmdcbiIN
Cj4gCSIuc2tpcCAtKCgoIiAiX19VTklRVUVfSURfYWx0aW5zdHJfOSIgIl9hbHRfZW5kIC0g
IiAiX19VTklRVUVfSURfYWx0aW5zdHJfOSIgIl9hbHRfYmVnaW4iICIpLSgiICJfX1VOSVFV
RV9JRF9hbHRpbnN0cl85IiAiX3BhZCAtICIgIl9fVU5JUVVFX0lEX2FsdGluc3RyXzkiICJf
YmVnaW4iICIpKSA+IDApICogIg0KPiAJIigoIiAiX19VTklRVUVfSURfYWx0aW5zdHJfOSIg
Il9hbHRfZW5kIC0gIiAiX19VTklRVUVfSURfYWx0aW5zdHJfOSIgIl9hbHRfYmVnaW4iICIp
LSgiICJfX1VOSVFVRV9JRF9hbHRpbnN0cl85IiAiX3BhZCAtICIgIl9fVU5JUVVFX0lEX2Fs
dGluc3RyXzkiICJfYmVnaW4iICIpKSwweDkwXG4iDQo+IAkiX19VTklRVUVfSURfYWx0aW5z
dHJfOSIgIl9lbmQ6XG4iDQo+IAkiLnB1c2hzZWN0aW9uIC5hbHRpbnN0cnVjdGlvbnMsXCJh
XCJcbiINCj4gCSIgLmxvbmcgIiAiX19VTklRVUVfSURfYWx0aW5zdHJfOSIgIl9iZWdpbiAt
IC5cbiINCj4gCSIgLmxvbmcgIiAiX19VTklRVUVfSURfYWx0aW5zdHJfOSIgIl9hbHRfYmVn
aW4gLSAuXG4iDQo+IAkiIC40Ynl0ZSAiICIoIDkqMzIrIDkpIiAiXG4iDQo+IAkiIC5ieXRl
ICIgIl9fVU5JUVVFX0lEX2FsdGluc3RyXzkiICJfZW5kIC0gIiAiX19VTklRVUVfSURfYWx0
aW5zdHJfOSIgIl9iZWdpbiIgIlxuIg0KPiAJIiAuYnl0ZSAiICJfX1VOSVFVRV9JRF9hbHRp
bnN0cl85IiAiX2FsdF9lbmQgLSAiICJfX1VOSVFVRV9JRF9hbHRpbnN0cl85IiAiX2FsdF9i
ZWdpbiIgIlxuIg0KPiAJIi5wb3BzZWN0aW9uXG4iDQo+IAkiLnB1c2hzZWN0aW9uIC5hbHRp
bnN0cl9yZXBsYWNlbWVudCwgXCJheFwiXG4iDQo+IAkiIyBBTFQ6IHJlcGxhY2VtZW50XG4i
DQo+IAkiX19VTklRVUVfSURfYWx0aW5zdHJfOSIgIl9hbHRfYmVnaW46XG5cdCINCj4gCSJj
YWxsICVjW25ldzJdIiAiXG4iDQo+IAkiX19VTklRVUVfSURfYWx0aW5zdHJfOSIgIl9hbHRf
ZW5kOlxuIg0KPiAJIi5wb3BzZWN0aW9uXG4iDQo+IAk6ICIrciIgKGN1cnJlbnRfc3RhY2tf
cG9pbnRlciksICI9RCIgKHBhZ2UpDQo+IAk6IFtvbGRdICJpIiAoY2xlYXJfcGFnZV9vcmln
KSwgW25ldzFdICJpIiAoY2xlYXJfcGFnZV9yZXApLCBbbmV3Ml0gImkiIChjbGVhcl9wYWdl
X2VybXMpICwgIkQiIChwYWdlKQ0KPiAJOiAiY2MiLCAibWVtb3J5IiwgInJheCIsICJyY3gi
KQ0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOw0KPiB9DQo+
IA0KPiBXaGljaCBsb29rcyByaWdodCwgYnV0IHV0dGVybHkgZmFpbHMgdG8gYnVpbGQgOigN
Cg0KV2hhdCBkb2VzIHRoZSBmYWlsdXJlIGxvb2sgbGlrZT8NCg0KQ291bGQgaXQgYmUgdGhh
dCB0aGUgbGFiZWxzIHNob3VsZCBiZSBsb2NhbCBvbmVzPw0KDQoNCkp1ZXJnZW4NCg==
--------------wCjuGdyXwIWCn2JOl5aqCNtv
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------wCjuGdyXwIWCn2JOl5aqCNtv--

--------------WQ0dpVSuF9i7vtFDogawA4is--

--------------G5ZDsJFAeWU3wk5VMeVpL07n
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjb+lYFAwAAAAAACgkQsN6d1ii/Ey98
NggAlQRClZmF42IEyJPjvS7iPsG1lo0/RU4QKwK33L/u409sNoGYvpPDQWYZ+yxiNyk1d8ZjGZZ0
Y8uVODFMyKtyeQMjotHfUOFR2sL82YDe97aDAfvYxMHYVw2z8hnrxRLtYWs7zZZ1dSB6RbATeqHT
sozqS4z9hQyZJnpUkglvRWDOl+2Cm+kvBK/qVRG9cBtHhCGgk+t4SLfzPRdRncvk/EmtGzv5rZ+M
1HKtw3QIqNLoNuF4p6sCMPKsgGMhW6EcyHoWH2aDJ6X+6wjeacBAuNJ1eUbtmrtn+RUW0uMSYtLX
WMn9R5Ch/5gCVFgum56L9go2SmhpU3nV3lCpUaSxnQ==
=n7ux
-----END PGP SIGNATURE-----

--------------G5ZDsJFAeWU3wk5VMeVpL07n--

