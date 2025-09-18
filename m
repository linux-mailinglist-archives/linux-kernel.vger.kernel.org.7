Return-Path: <linux-kernel+bounces-759203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A392B1DA10
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF729564347
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADD026560D;
	Thu,  7 Aug 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JPpwwbEo"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F622641C3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577662; cv=none; b=jJ57T2GbZX0R5HfQ2NJDFSmzxdEVvVqhAJ851MZBO9/7amncTTmtoboJOhC5d28pDwT9fg/eqIGFSgG1qt0lwPW0+hsKdA/E/2GBWzyWp1eUpjLaEAF1yGxT9zfpRqXa8TXrTam3M24ReMHwiygYpH6hCFfyHcg5gkoh5Kx2D+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577662; c=relaxed/simple;
	bh=UNvtAxmLROgNUzbc11bBNIMDhX3I5pMyJHrrae5iWIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeHFAa6JN66IBrx8L9Nua0XmE9BXfFZ1kG5FxLC6xq/U9Kn5vUupdvwwGgqrRuLxuu5Z26OY59lwF+c2RKZ4/D9tu7RFLMdtNZoQT2cPpuHWvsQfjeA3BTGnoAVB4SWrfE3We2AfjLA4rQrnTYfZaFCjZSBBhqcNSSJDwQwjryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JPpwwbEo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-458c063baeaso7008285e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754577657; x=1755182457; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UNvtAxmLROgNUzbc11bBNIMDhX3I5pMyJHrrae5iWIY=;
        b=JPpwwbEoIx6E+2AL182tazxJwgfOXeFEmx+X/T8x1B+amTezQ7ZAuh8LFvCaylSOP2
         Aez4r0MdWrHgdXGjdkdXgwcRop75HBT7yZKlTEK9cHbupwSUXR6xvRRbHHbHO/FCQHTW
         ltvSLuBXGegJZpoG3f5o3iJ6IDAf7xs8fySe+oeLVnL+wiOFCf+e/D4hitkD/iG5jEYo
         DBgPyB65c9XVfUjl/0jcp/WnO2lJyPw0fCpu5atqmNJpykmJfAXsfehkaih6sb3YIxQz
         lqtBlouFmACz4XZxnMt7CMO5YqcdZseQhA75Qbu/Bn+DUzzmPYO2ol+2rzh5Br4a/a6R
         u5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754577657; x=1755182457;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UNvtAxmLROgNUzbc11bBNIMDhX3I5pMyJHrrae5iWIY=;
        b=p4mldPDb/ab8IQWATLQb/3UqTkQ2y4cPPUvgKTFlmnZ1T+W6WtrPTUGzTkxiMb3qyd
         nh1uLHmy2x2BxXp1FJ7ii9Yc+i98p0J/L4f0GafUbJyJ8e9pcrf3ixFpjKNmpB2QgnVr
         shYLSOciMK6IHBBe6Xg8Hy1gN6SRCx69glTtIpxYgS4vC2Upk8CJkP+Tj/P122MmlxXu
         9YGFj6rSdSUOuujmd+2EmX/bVuAJ6ct+BDogNf9vBKA7ODAECObBh+Rs4vMn5uiOsPHw
         f9Vud1mrBON9sA2MrGOWDP9apFoq89p+JHt5p1BEEHLShwD0EPetZkfVtiiZK/ukmaMw
         japQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm/mVXtUHrnh86OKh1CYERuRwwKlZB/3cgu9hW6PMa4f0jfAQmeJzpBXqDEfTKCizJ6MDNB0fHHZkEGnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbv7PgnStlU/r7GZOLg3fYL3JEn0JCNzVh+CxJ91laJU2DcEXc
	zmJFrd9zxPFMxQrvzTa5KvHFFAiSdXXFTU+qPNyWJEK4KmgExzsHnajaOtFTjm7WC7U=
X-Gm-Gg: ASbGncuzGSC0385jRVnHOS723ZfRECSfIvyeu77rAFdPgaWl/YFk8DGoZg62O6j3lde
	VWUQYeqdB3YDufQi9Ianacl0DpwPcmMTpOkyUkiPbBuYzCBql7h0tgUjBEsda8kGwkaEkAnmJT0
	ZowCp0zVCblQ6/xA5OiQC4FUMKJk3rhUz1Sbqo+ZsgSE/JNww7fKThhBAgIK/RqZ45TWMSAzxpJ
	KjqJ2xPJbhxO0hRz/WmpOogm26dbH76tPE/Vbvh9WiMLZFDAr1lGHs42SZnGEtF8SM8uJ1AzgDb
	gKAWwAIC5wfu3KwiPWOe7MozCoJwcWroj94A9gNfz6+m2TRAegZ3Jr3jFfBwBdaBsF2VYISBD8D
	gWKUU7JHcK9tzM1XGSuGJSH+/TwM1tW6rO7u2q7niwEaR39rVPVsiYtc8Ezxms9jljFpb14OrJp
	idjV1EK5JxIZxMDk+yX0v5cKk3fTM9gUFrkFBarZW9tFEneH82k12E
X-Google-Smtp-Source: AGHT+IEdsq/70nzbECt2XZv20aIclJJnJG4WOaVhcMt6Kol5NiFtvhP7+awwyCp70aSiqlFjENFKWA==
X-Received: by 2002:a05:600c:840f:b0:459:d709:e5d4 with SMTP id 5b1f17b1804b1-459e6fb8315mr72888315e9.0.1754577657329;
        Thu, 07 Aug 2025 07:40:57 -0700 (PDT)
Received: from ?IPV6:2003:e5:872d:3c00:27e3:fc0:fb5:67a3? (p200300e5872d3c0027e30fc00fb567a3.dip0.t-ipconnect.de. [2003:e5:872d:3c00:27e3:fc0:fb5:67a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac158sm27487389f8f.4.2025.08.07.07.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 07:40:57 -0700 (PDT)
Message-ID: <e52e54f9-5f46-4d52-b02b-3ddb497d5ed9@suse.com>
Date: Thu, 7 Aug 2025 16:40:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/16] xen: swiotlb: Open code map_resource callback
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Alexander Potapenko <glider@google.com>, Alex Gaynor
 <alex.gaynor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
 iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Corbet <corbet@lwn.net>, kasan-dev@googlegroups.com,
 Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-trace-kernel@vger.kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "Michael S. Tsirkin"
 <mst@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, Stefano Stabellini
 <sstabellini@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
 xen-devel@lists.xenproject.org
References: <cover.1754292567.git.leon@kernel.org>
 <e69e9510d9024d664133dc788f5186aac414318e.1754292567.git.leon@kernel.org>
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
In-Reply-To: <e69e9510d9024d664133dc788f5186aac414318e.1754292567.git.leon@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zbc1rtf2MP4v0hwBljje0R4r"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zbc1rtf2MP4v0hwBljje0R4r
Content-Type: multipart/mixed; boundary="------------9ZSgHGkw4I0gfARYLaBix7N0";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Alexander Potapenko <glider@google.com>, Alex Gaynor
 <alex.gaynor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
 iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Corbet <corbet@lwn.net>, kasan-dev@googlegroups.com,
 Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-trace-kernel@vger.kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "Michael S. Tsirkin"
 <mst@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, Stefano Stabellini
 <sstabellini@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
 xen-devel@lists.xenproject.org
Message-ID: <e52e54f9-5f46-4d52-b02b-3ddb497d5ed9@suse.com>
Subject: Re: [PATCH v1 10/16] xen: swiotlb: Open code map_resource callback
References: <cover.1754292567.git.leon@kernel.org>
 <e69e9510d9024d664133dc788f5186aac414318e.1754292567.git.leon@kernel.org>
In-Reply-To: <e69e9510d9024d664133dc788f5186aac414318e.1754292567.git.leon@kernel.org>

--------------9ZSgHGkw4I0gfARYLaBix7N0
Content-Type: multipart/mixed; boundary="------------MyLdgWVjx6doOE9CX8bqeBuf"

--------------MyLdgWVjx6doOE9CX8bqeBuf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMDguMjUgMTQ6NDIsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gRnJvbTogTGVv
biBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlhLmNvbT4NCj4gDQo+IEdlbmVyYWwgZG1hX2Rp
cmVjdF9tYXBfcmVzb3VyY2UoKSBpcyBnb2luZyB0byBiZSByZW1vdmVkDQo+IGluIG5leHQg
cGF0Y2gsIHNvIHNpbXBseSBvcGVuLWNvZGUgaXQgaW4geGVuIGRyaXZlci4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IExlb24gUm9tYW5vdnNreSA8bGVvbnJvQG52aWRpYS5jb20+DQoNClJl
dmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdl
bg0K
--------------MyLdgWVjx6doOE9CX8bqeBuf
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------MyLdgWVjx6doOE9CX8bqeBuf--

--------------9ZSgHGkw4I0gfARYLaBix7N0--

--------------zbc1rtf2MP4v0hwBljje0R4r
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmiUuvcFAwAAAAAACgkQsN6d1ii/Ey8T
2gf9Fig/dfNm6Pc7N5CfTbfrvQeHxFrx0A+Lbz3wE1LBralSuURdjPw+wrBAGuNq/agCOFH7OBqC
ayEkBjEdcL5kEblmVCgSWfcKQRq0vW5y0zkrzYglQyfuWhihBm/d56LwWxjbGku6QYLMnb5dGvHG
wtjPE58yPWlaVaZa/NiWJLKtHyLc9Ep3+vhGNksayAXIsaRoqhk6g0dlVfOZUhQB2CTSQmBN8Cjo
yhy4qsUiY26xJ0qhoNBaBahj9XRBQX5jz0z6IXT0xVJOTx5MoVU/ciBTMU97RmC1WbR0D5dAFfaA
bgpP4QE+654uwyPjna/thpNWrTTm0kf3W+lFK/6fTQ==
=Fe2s
-----END PGP SIGNATURE-----

--------------zbc1rtf2MP4v0hwBljje0R4r--

