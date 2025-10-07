Return-Path: <linux-kernel+bounces-844106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C1EBC103E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FE904F4680
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3004C2D8783;
	Tue,  7 Oct 2025 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BdIbUkzG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D132D6636
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832992; cv=none; b=Xbs/5Np+yKY8Cph2PNYn1npFWo7VYp8E83Zsezjj52wnfU6qf1xazWnIJHW2AZ/VGUi831cTbPF3ReSVc881e/NoTMSR4aO7JikftvjzPz7tmkALUMZTCozFz4BH5aSIqcRI4mYmbxqIcw8cnQEt0UbfKYI4yokGy16I57d9sxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832992; c=relaxed/simple;
	bh=2eWusZcNpKtVq5dW80GDrMQQTVeegrdo963Cy6rWQoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlvotzHLxI+P2uDuZMJ7O9mTqnoizfAPcm8yuwUcZLbQFaElog/5oxZqV+nsWI6mQaHhBB3lpbJyXg+bMK4okn2JVissrzho8ktFGOVIWPc8VMUbbF6Jc6afHGoktLV6rgHMhNwbHuaOnP8Zv+ycuuW9gbNTFTmwwepBhAmj2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BdIbUkzG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso44389195e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759832988; x=1760437788; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2eWusZcNpKtVq5dW80GDrMQQTVeegrdo963Cy6rWQoU=;
        b=BdIbUkzGK/w5n87/I8mYb5B4kycq/C/JCF1FtiuEYA2k7+Ka/aWJFVtM9XSG6GX3BX
         q3OG3EkoKdJWIPp5TFdCSoqoOki5sZkPuZpD385VzLJouFn5bzzAa4txMqN3IjMe4oZ2
         4PNucR0G9iGcSv15rk2IWqgE4Hr6KXdDlE93jYyflf7j149YhQX9vuAjgmBzsn6v2dKR
         W21ATPep7idD2dG5cwPGlFhn+MukMofidrBf5wuxIZVtjW48kF4HbYExbeXbnX8HqfS3
         1D0j6UK0N1G2HAa90MHtqb/FzlpK8bsm6DYQiCNjBTLs7YTnKBBbuPlbH/RvIgThnQpg
         W5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759832988; x=1760437788;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eWusZcNpKtVq5dW80GDrMQQTVeegrdo963Cy6rWQoU=;
        b=pRl8jfwGoKS4GjmEVl5PISbKsoAfnj+H9tDigyLzNcvNaPjTA1T0beuXTYTjQGMcJ7
         W29B0SOlKhliUdGB/B52wWL0gpiaCEO7Ty2SVKv+ZO0Ym5CN6Qc3Q73YDmPab4F1yA3J
         8cWV4UQ9roiayphsIRReTIhXjfKrBSGfSdCsrzil0b+hIQ7/FeQEQf8O5TJm5aiyyYrw
         YJUTcvBW+bfw3GklzRgw/dJUa2GcpTGAt2pjh7dksqTeDN0FkQOtj8VM3CJESNWfcRtS
         m0yVHTwcqIEg20gewyI20eQqReZrYYI3lYjsKDL6/FgvfPNjGz+toO7f3bCOIIB+ieZO
         NpOg==
X-Gm-Message-State: AOJu0YwLgjz9hF6U2aM0H2qwvga32WMxAAcLW5S7HEJKsoL7Vx0v3HhO
	LwGx2kVZXhcNuYrA5yg6GL5c9VysOGvHN/LBDp4Yk2lxRQVYdDrpg9CQoTqDtIcGPE0=
X-Gm-Gg: ASbGncvIR0rZJYaELTM10gxxBzCYvbZ3S9L5T9Md7dbnyVhQFPFbVIzqi0liB7aRVk+
	CjaAovQs+fLfgJUWxhvIUGYxqKBu40GYp3ilWUTOSkUnO9WIbuzrkKLuCPXlAb6Wpu/BemFVJRJ
	Tp5JiM9/J7nNOpHnUKpjPDbIY3vktR0C0cma/z9KZu1jnUM41SFxKiserFhQYEcPFW8ZkrAnaZg
	f4SdU121ukT+ldSqsrymk3hP7+FQ0wxtC8R58UjnAA0Gqq/L6LjGs9GDF3e941HGDu68h4sWhOB
	8ROmRF2FJ+UbPURs/zqHFi4bqcpm11cbmp9UIc9EfXkLU9ov7v4B9SKGB3zz9zTcZirTk0QLbEQ
	MWsmn+xPBypH6Quvagc2p801BLiHXvofEfHAU2n64wAE+ZcebtOu9N8LD4iRo0kHDh4bzWGxGEE
	+nG6FNZ97jA4U7mQNxyVWjcCNEA3gO7CH5/2VSa/5z4K7QIP8YqCJ38vzylQOK2l45+nNa
X-Google-Smtp-Source: AGHT+IFa2wmYvLfiKrxFBSn1h4B2BMRTb9cpqLeRxxPX1xSIeF3qD23om02py09WujSEWEu+IDw9Hw==
X-Received: by 2002:a05:600c:8718:b0:46e:45f7:34fc with SMTP id 5b1f17b1804b1-46e711447d0mr95661935e9.29.1759832988302;
        Tue, 07 Oct 2025 03:29:48 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa57320easm9757245e9.0.2025.10.07.03.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:29:47 -0700 (PDT)
Message-ID: <471cefb9-538b-478c-89ec-53ee0e6308b1@suse.com>
Date: Tue, 7 Oct 2025 12:29:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/21] x86/xen: Drop xen_irq_ops
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 xen-devel@lists.xenproject.org
References: <20251006074606.1266-1-jgross@suse.com>
 <20251006074606.1266-16-jgross@suse.com>
 <20251006185553.GY3245006@noisy.programming.kicks-ass.net>
 <c8b3c9ea-8c6c-4ec2-b01f-df3f8f487a8c@suse.com>
 <20251007102106.GE3245006@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20251007102106.GE3245006@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------U1jBHiYTk2zlPK0TSvoBtxCg"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------U1jBHiYTk2zlPK0TSvoBtxCg
Content-Type: multipart/mixed; boundary="------------YTRlFEGN0io5KG2aajn7lFXI";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 xen-devel@lists.xenproject.org
Message-ID: <471cefb9-538b-478c-89ec-53ee0e6308b1@suse.com>
Subject: Re: [PATCH v3 15/21] x86/xen: Drop xen_irq_ops
References: <20251006074606.1266-1-jgross@suse.com>
 <20251006074606.1266-16-jgross@suse.com>
 <20251006185553.GY3245006@noisy.programming.kicks-ass.net>
 <c8b3c9ea-8c6c-4ec2-b01f-df3f8f487a8c@suse.com>
 <20251007102106.GE3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20251007102106.GE3245006@noisy.programming.kicks-ass.net>

--------------YTRlFEGN0io5KG2aajn7lFXI
Content-Type: multipart/mixed; boundary="------------MyW1CCs8heR21w9nT0Sq8wSZ"

--------------MyW1CCs8heR21w9nT0Sq8wSZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMTAuMjUgMTI6MjEsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUdWUsIE9j
dCAwNywgMjAyNSBhdCAwOTo0Nzo0OEFNICswMjAwLCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0K
Pj4gT24gMDYuMTAuMjUgMjA6NTUsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+IE9uIE1v
biwgT2N0IDA2LCAyMDI1IGF0IDA5OjQ2OjAwQU0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3Jv
dGU6DQo+Pj4+IEluc3RlYWQgb2YgaGF2aW5nIGEgcHJlLWZpbGxlZCBhcnJheSB4ZW5faXJx
X29wcyBmb3IgWGVuIFBWIHBhcmF2aXJ0DQo+Pj4+IGZ1bmN0aW9ucywgZHJvcCB0aGUgYXJy
YXkgYW5kIGFzc2lnbiBlYWNoIGVsZW1lbnQgaW5kaXZpZHVhbGx5Lg0KPj4+DQo+Pj4gU2Ft
ZSBjb21tZW50IGZvciB0aGUgbmV4dCBmZXcgcGF0Y2hlczsgdGhpcyBjaGFuZ2Vsb2cgaXMg
YSBsaXR0bGUgbGlnaHQNCj4+PiBvbiAqd2h5Ki4gSSBtZWFuLCBJIGRvbid0IG1pbmQgdGhl
IGNoYW5nZSwgYnV0IHN1cHBvc2VkbHkgd2Ugc2hvdWxkDQo+Pj4ganVzdGlmeSB0aGluZ3Mg
YXQgbGVhc3QgYSBsaXR0bGUsIHJpZ2h0PyA6LSkNCj4+DQo+PiBXb3VsZCB5b3UgYmUgZmlu
ZSB3aXRoIHRoZSBmb2xsb3dpbmcgYWRkaXRpb246DQo+Pg0KPj4gICAgVGhpcyBpcyBpbiBw
cmVwYXJhdGlvbiBvZiByZWR1Y2luZyB0aGUgcGFyYXZpcnQgaW5jbHVkZSBoZWxsIGJ5DQo+
PiAgICBzcGxpdHRpbmcgcGFyYXZpcnQuaCBpbnRvIG11bHRpcGxlIG1vcmUgZmluZSBncmFp
bmVkIGhlYWRlciBmaWxlcywNCj4+ICAgIHdoaWNoIHdpbGwgaW4gdHVybiByZXF1aXJlIHRv
IHNwbGl0IHVwIHRoZSBwdl9vcHMgdmVjdG9yIGFzIHdlbGwuDQo+PiAgICBEcm9wcGluZyB0
aGUgcHJlLWZpbGxlZCBhcnJheSBtYWtlcyBsaWZlIGVhc2llciBmb3Igb2JqdG9vbCB0bw0K
Pj4gICAgZGV0ZWN0IG1pc3NpbmcgaW5pdGlhbGl6ZXJzIGluIG11bHRpcGxlIHB2X29wc18g
YXJyYXlzLg0KPiANCj4gWWVzLCB0aGF0J2xsIGRvLiBUaGUgbGF0dGVyIGJlaW5nIHRoZSBt
YWluIHJlYXNvbiBpbiB0aGlzIGNhc2UsIHJpZ2h0Pw0KWWVzLg0KDQoNCkp1ZXJnZW4NCg==

--------------MyW1CCs8heR21w9nT0Sq8wSZ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------MyW1CCs8heR21w9nT0Sq8wSZ--

--------------YTRlFEGN0io5KG2aajn7lFXI--

--------------U1jBHiYTk2zlPK0TSvoBtxCg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjk65sFAwAAAAAACgkQsN6d1ii/Ey8h
kwf8DMv6TrAfRDqkPlGigKAPtzs+D+AMKXnwnufPoI9OHHcnbakkMxxuivzJhEuIapKEK5ZbSIZX
lq+044LMMvHd4md4tqEWxfCvbFbnMSMWaGbDhcQtEYpxCoKn0vf36a5uwiHGI5EZPOWoirWPAwkh
k+a749JwjiESx8Fe8qMwyBe1GQ5Rk98MyXuDz4F/0XhEMB/9Q5GMsNces73ZNGKc/YtfQtWzVcmp
l68PEO9NZMWsAfnk20gKvv9pZRAHnbFWrOXCh8yQsAtTCR1/8u0eE1CBw8MRG387UgITlayzN6wY
Bh9z2fEMyhPqwdpj7t5tt7H3Oijra5Cg8GhjS7Snww==
=9asZ
-----END PGP SIGNATURE-----

--------------U1jBHiYTk2zlPK0TSvoBtxCg--

