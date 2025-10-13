Return-Path: <linux-kernel+bounces-850096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0BBD1D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4881898552
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1392E7F3E;
	Mon, 13 Oct 2025 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GNTRrMwQ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C4B19C54E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341024; cv=none; b=plXH/NwahgDWtzdHbYeOIhiL6xgj24oqLkdzu4u+K3Q1KWliXtbZOr5R+2MZQVI2kbrPwPUwczlPuP9rogVxkKGjkvJLoSiMJtj4FPbjbjqYGB1bIcYAl+SUP6tiC0keAO+vY/ktmCvjs4Je+OYDiTV2JEcR5z8OgOhCXiUshwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341024; c=relaxed/simple;
	bh=1eBE7IOlVk7k6ixMkt6OHpjtlRnaC7ZAk00BA4td6rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNLPmj91zIZklEHfhbtSmBepSBuPjvsOmwW2FGNyRX9bI5ADGYgqDD5sYiVaxFgvj0En1s913JnH8z5GAUbni3U9oVnfqfPEj9DN6fFn1NMRqWU9CvMwg5dRyyavywBswepAEIHbwbc+pacOgl7hDeAc5cOtXnr0KW6lvejsJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GNTRrMwQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso643215466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760341021; x=1760945821; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1eBE7IOlVk7k6ixMkt6OHpjtlRnaC7ZAk00BA4td6rs=;
        b=GNTRrMwQvjfKF+sAL2W/exu+mNr9qPIilk43Zq++zklPBf2mHDqq+xNVal+hlCTvhH
         P0dGBxWpDLQHWy5aWtWAzrPxECAEyVCO2EIr8HDlytSGjqnRA4ZcbvsHsB070RKOEWyZ
         bmoshjOO/7NJomny1j4zEnvqJU3SHpI5YDNI7ha0TVgo+LI1N1dvkBmLaVeVj9tzG2Xq
         Gvud6G5sB1+BGEqXWYpm5gG1CFaBwcaSQgM0yXtI71B2G9vse4mTpBzCiS0Ra1Gpq/lk
         Ygzwpf7Xfds8zrQ99WalDb8Ilc/yTyTgM14D5VHvgKo0e/1SpSjE3t100dq9bU+giNhp
         jmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760341021; x=1760945821;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1eBE7IOlVk7k6ixMkt6OHpjtlRnaC7ZAk00BA4td6rs=;
        b=TjKtkrWQSJYhdtDmPPMS+bykaJH0Bz5hVR156DzDAePqxlPpb8sb4xpxWAV7X24JWB
         3CkUMWN5nGIAhVrDtMpV7Ixq2ri57hEtOjks4hyUmheZdyRJLjAfcp2pbapbyMyeb0dC
         +uL+2JcvzBnrgngt9nUVKRJf5pY5HAcJyix1j6h2iAjJy9C2pyIm5U6tWRjBqpO6e081
         S71L/j/i1mqUmBk6bjXa7E7ZI5+5bwk9kPjGZfaSMQPs6VO/+6ViQ7hVkkhKrpEUrM3l
         1UiauyJgxutZQ4wblfAYkr++dAEWW1YnevPv3UpBRMyM8xLvNs2Oh7cY9eeOUcD7DiNh
         5gkw==
X-Forwarded-Encrypted: i=1; AJvYcCXt9i5vHZV9TkwNndt6Culx5TSQtOCIlWL9B9bch9gAiwF7gcN3nh/PFLBVSClx9NvLQs7/+zK/hoQLF+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Cgg0IONXqNHx/6xFchc5VkKNkd7ZV+Rj7zyqI05E/WB4/Wz+
	h2FNb2qFjtt9SqSKNIriIIGqEHVnysaVEhjOThoR/Nnm5U73AJ4ZWIdt8hHsOJbdqa5LfIQSSs4
	FCRlxDnE=
X-Gm-Gg: ASbGnctT8b5iE91Na3JkdGo2Jh0n03ww2sde5OIW1LVt3hW1gYbv1nFAHMOXRgrNFt8
	VuRQ9IAUngBU/mfOKllC8jPp8Sg7UB5s1KmsQcd0PYOYzNXEoXO2ndC6EJFFwyvgRe8Mma2iqJn
	RZf3Wo2SelyUvPDsQ7H6UxGgxZNNsryvi12lLKaqf3irvSMHpe32XjM6jrJik02frNmo2yIzaZo
	qKHjZ+WLOkK+ruLOADk4p0C+/9IKHQ/jx6I74FItfBISAMc/pZx0CnPf24KH8veXZOdYesQTSxB
	bv6gUL99SfzvkxUBaBlQ7LxZ2DSzMhke9RZIv3JIDSxePBX3T1Ehd3GsIKhrBdc1+18/VmvxuLC
	AfrJXEjb+B5uTm5ZR28PWuCXkMhuGIXqfeLLzO8LhGl+FdWhlnC1biegdt0xVxB0NB+bZ5tTfx6
	bS1GzRyRsTkOZ4HvOBCXUTDg9MPqBC3IcskGl+OsOXSEGws3uJ04vKXm+K8Tu2F6+IWC0BAVhei
	w==
X-Google-Smtp-Source: AGHT+IFSlhtaUSR1I0MiSHcQJGgX4Q8gAsq6Bs0pChS5GOxfsL5T/zQr/8A34vTYQozYf+cC6OL00g==
X-Received: by 2002:a17:907:c04:b0:b46:8bad:6981 with SMTP id a640c23a62f3a-b50aab9d542mr2143903666b.20.1760341020182;
        Mon, 13 Oct 2025 00:37:00 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d2ce9sm865840166b.35.2025.10.13.00.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 00:36:59 -0700 (PDT)
Message-ID: <65bad926-22fc-41da-b9c4-5857a002b377@suse.com>
Date: Mon, 13 Oct 2025 09:36:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/xen/xenbus: Replace deprecated strcpy in
 xenbus_transaction_end
To: Jan Beulich <jbeulich@suse.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jason Andryuk <jason.andryuk@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
References: <20251012195514.39003-2-thorsten.blum@linux.dev>
 <ebee3406-d515-4e29-9d7c-f54bdb143080@suse.com>
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
In-Reply-To: <ebee3406-d515-4e29-9d7c-f54bdb143080@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------aL9FS5G5uuPKPbejLbRTuXvO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------aL9FS5G5uuPKPbejLbRTuXvO
Content-Type: multipart/mixed; boundary="------------r6UTLeiNBc7xolqcB1fygly0";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jason Andryuk <jason.andryuk@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Message-ID: <65bad926-22fc-41da-b9c4-5857a002b377@suse.com>
Subject: Re: [PATCH] drivers/xen/xenbus: Replace deprecated strcpy in
 xenbus_transaction_end
References: <20251012195514.39003-2-thorsten.blum@linux.dev>
 <ebee3406-d515-4e29-9d7c-f54bdb143080@suse.com>
In-Reply-To: <ebee3406-d515-4e29-9d7c-f54bdb143080@suse.com>
Autocrypt-Gossip: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJ3BBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AAIQkQoDSui/t3IH4WIQQ+pJkfkcoLMCa4X6CgNK6L+3cgfgn7AJ9DmMd0SMJE
 ePbc7/m22D2v04iu7ACffXTdZQhNl557tJuDXZSBxDmW/tLOwU0EWTecRBAIAIK5OMKMU5R2
 Lk2bbjgX7vyQuCFFyKf9rC/4itNwhYWFSlKzVj3WJBDsoi2KvPm7AI+XB6NIkNAkshL5C0kd
 pcNd5Xo0jRR5/WE/bT7LyrJ0OJWS/qUit5eNNvsO+SxGAk28KRa1ieVLeZi9D03NL0+HIAtZ
 tecfqwgl3Y72UpLUyt+r7LQhcI/XR5IUUaD4C/chB4Vq2QkDKO7Q8+2HJOrFIjiVli4lU+Sf
 OBp64m//Y1xys++Z4ODoKh7tkh5DxiO3QBHG7bHK0CSQsJ6XUvPVYubAuy1XfSDzSeSBl//C
 v78Fclb+gi9GWidSTG/4hsEzd1fY5XwCZG/XJJY9M/sAAwUH/09Ar9W2U1Qm+DwZeP2ii3Ou
 14Z9VlVVPhcEmR/AFykL9dw/OV2O/7cdi52+l00reUu6Nd4Dl8s4f5n8b1YFzmkVVIyhwjvU
 jxtPyUgDOt6DRa+RaDlXZZmxQyWcMv2anAgYWGVszeB8Myzsw8y7xhBEVV1S+1KloCzw4V8Z
 DSJrcsZlyMDoiTb7FyqxwQnM0f6qHxWbmOOnbzJmBqpNpFuDcz/4xNsymJylm6oXiucHQBAP
 Xb/cE1YNHpuaH4SRhIxwQilCYEznWowQphNAbJtEKOmcocY7EbSt8VjXTzmYENkIfkrHRyXQ
 dUm5AoL51XZljkCqNwrADGkTvkwsWSvCSQQYEQIACQUCWTecRAIbDAAKCRCgNK6L+3cgfuef
 AJ9wlZQNQUp0KwEf8Tl37RmcxCL4bQCcC5alCSMzUBJ5DBIcR4BY+CyQFAs=

--------------r6UTLeiNBc7xolqcB1fygly0
Content-Type: multipart/mixed; boundary="------------npIkIxiZMvZHSh2uiWTn909H"

--------------npIkIxiZMvZHSh2uiWTn909H
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMTAuMjUgMDg6NTksIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAxMi4xMC4yMDI1
IDIxOjU1LCBUaG9yc3RlbiBCbHVtIHdyb3RlOg0KPj4gLS0tIGEvZHJpdmVycy94ZW4veGVu
YnVzL3hlbmJ1c194cy5jDQo+PiArKysgYi9kcml2ZXJzL3hlbi94ZW5idXMveGVuYnVzX3hz
LmMNCj4+IEBAIC01NDYsMTYgKzU0NiwxMyBAQCBpbnQgeGVuYnVzX3RyYW5zYWN0aW9uX3N0
YXJ0KHN0cnVjdCB4ZW5idXNfdHJhbnNhY3Rpb24gKnQpDQo+PiAgIEVYUE9SVF9TWU1CT0xf
R1BMKHhlbmJ1c190cmFuc2FjdGlvbl9zdGFydCk7DQo+PiAgIA0KPj4gICAvKiBFbmQgYSB0
cmFuc2FjdGlvbi4NCj4+IC0gKiBJZiBhYmFuZG9uIGlzIHRydWUsIHRyYW5zYWN0aW9uIGlz
IGRpc2NhcmRlZCBpbnN0ZWFkIG9mIGNvbW1pdHRlZC4NCj4+ICsgKiBJZiBhYm9ydCBpcyB0
cnVlLCB0cmFuc2FjdGlvbiBpcyBkaXNjYXJkZWQgaW5zdGVhZCBvZiBjb21taXR0ZWQuDQo+
PiAgICAqLw0KPj4gLWludCB4ZW5idXNfdHJhbnNhY3Rpb25fZW5kKHN0cnVjdCB4ZW5idXNf
dHJhbnNhY3Rpb24gdCwgaW50IGFib3J0KQ0KPj4gK2ludCB4ZW5idXNfdHJhbnNhY3Rpb25f
ZW5kKHN0cnVjdCB4ZW5idXNfdHJhbnNhY3Rpb24gdCwgYm9vbCBhYm9ydCkNCj4+ICAgew0K
Pj4gICAJY2hhciBhYm9ydHN0clsyXTsNCj4+ICAgDQo+PiAtCWlmIChhYm9ydCkNCj4+IC0J
CXN0cmNweShhYm9ydHN0ciwgIkYiKTsNCj4+IC0JZWxzZQ0KPj4gLQkJc3RyY3B5KGFib3J0
c3RyLCAiVCIpOw0KPiANCj4gV2hpbGUgYXQgbGVhc3QgaW4gcHJpbmNpcGxlIGEgY29tcGls
ZXIgbWlnaHQgYmUgYWJsZSB0byB0cmFuc2Zvcm0gdGhpcyBpbnRvDQo+IGNvZGUgbm90IHVz
aW5nIGFueSBsaWJyYXJ5IGZ1bmN0aW9uIGF0IGFsbCwgLi4uDQo+IA0KPj4gKwlzdHJzY3B5
KGFib3J0c3RyLCBhYm9ydCA/ICJGIiA6ICJUIik7DQo+IA0KPiAuLi4gdGhlIHVzZSBvZiBh
IG4gb24tc3RhbmRhcmQgZnVuY3Rpb24gKHdpdGhvdXQgZXF1aXZhbGVudCBjb21waWxlciBi
dWlsdGluKQ0KPiBkb2Vzbid0IHBlcm1pdCB0aGlzLiBJT1cgd2h5IG5vdCBzaW1wbHkgc3dp
dGNoIHRvIGUuZy4NCj4gDQo+ICAgICAgY2hhciBhYm9ydHN0clsyXSA9IHsgWzBdID0gYWJv
cnQgPyAnRicgOiAnVCcgfTsNCg0KSSB3b3VsZCBldmVuIGdvIGZ1cnRoZXIgYW5kIGRyb3Ag
YWJvcnRzdHJbXSBjb21wbGV0ZWx5Og0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4veGVu
YnVzL3hlbmJ1c194cy5jIGIvZHJpdmVycy94ZW4veGVuYnVzL3hlbmJ1c194cy5jDQppbmRl
eCA1Mjg2ODJiZjBjN2YuLmM4OTFhZjcxNjVmNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMveGVu
L3hlbmJ1cy94ZW5idXNfeHMuYw0KKysrIGIvZHJpdmVycy94ZW4veGVuYnVzL3hlbmJ1c194
cy5jDQpAQCAtNTUwLDE0ICs1NTAsOCBAQCBFWFBPUlRfU1lNQk9MX0dQTCh4ZW5idXNfdHJh
bnNhY3Rpb25fc3RhcnQpOw0KICAgKi8NCiAgaW50IHhlbmJ1c190cmFuc2FjdGlvbl9lbmQo
c3RydWN0IHhlbmJ1c190cmFuc2FjdGlvbiB0LCBpbnQgYWJvcnQpDQogIHsNCi0gICAgICAg
Y2hhciBhYm9ydHN0clsyXTsNCi0NCi0gICAgICAgaWYgKGFib3J0KQ0KLSAgICAgICAgICAg
ICAgIHN0cmNweShhYm9ydHN0ciwgIkYiKTsNCi0gICAgICAgZWxzZQ0KLSAgICAgICAgICAg
ICAgIHN0cmNweShhYm9ydHN0ciwgIlQiKTsNCi0NCi0gICAgICAgcmV0dXJuIHhzX2Vycm9y
KHhzX3NpbmdsZSh0LCBYU19UUkFOU0FDVElPTl9FTkQsIGFib3J0c3RyLCBOVUxMKSk7DQor
ICAgICAgIHJldHVybiB4c19lcnJvcih4c19zaW5nbGUodCwgWFNfVFJBTlNBQ1RJT05fRU5E
LCBhYm9ydCA/ICJGIiA6ICJUIiwNCisgICAgICAgICAgICAgICAgICAgICAgIE5VTEwpKTsN
CiAgfQ0KICBFWFBPUlRfU1lNQk9MX0dQTCh4ZW5idXNfdHJhbnNhY3Rpb25fZW5kKTsNCg0K
DQpKdWVyZ2VuDQo=
--------------npIkIxiZMvZHSh2uiWTn909H
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------npIkIxiZMvZHSh2uiWTn909H--

--------------r6UTLeiNBc7xolqcB1fygly0--

--------------aL9FS5G5uuPKPbejLbRTuXvO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjsrBsFAwAAAAAACgkQsN6d1ii/Ey98
agf/XDXA7OeiSGF3mjL8FYcZW2JSG5vEYtBx5FBrgkwjAnuDUq0aqv2dK0DEw+7blE0VZ7Z0nIQN
FmBasyqxbol92P8exK/zxV1SlvW+HS8OSP6AmM+siffknx8Bc9bkFYvDNIoS/Yn8xld14p0ANK7B
WmWOsqigTpu7iEM77PVNddt7p3rXOWdFNcLLM/63v2VqfbmDGLvIqL+v+49eYZ4VfimPyeFeWkU7
zNnTzD7LMrp/PLb5gpzjIOwreYZybyxPW6oNR37gqKw3J4OanoXNjasGHAkvybjYXclXAZwXlLek
8dXO71jOl+PFoZGjH+awJzbQHX591PDtZuCtKAHvCg==
=7920
-----END PGP SIGNATURE-----

--------------aL9FS5G5uuPKPbejLbRTuXvO--

