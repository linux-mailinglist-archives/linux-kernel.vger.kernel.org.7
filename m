Return-Path: <linux-kernel+bounces-850220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7769BD247C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B273B6C70
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838262FD7A7;
	Mon, 13 Oct 2025 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bBoCCieI"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117F2FD7A3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347460; cv=none; b=NiPHRS/a/FEYfzai5TZnMh0YrtqFX8uJ5ojUzqnrEeQAIeSQ63TKLSoxwwiXD1oq53R7FJeppiykUoXLiZ4KXFap8KfsHvPxYjZwBvimOTWD0GXQr6+u3K5ZKEPgVG4RlXUACcqj6psED9BEU0ERtL+hPIpaJ4vbgj9xGWyysuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347460; c=relaxed/simple;
	bh=RDKO3CyqyzhvakuwAtJ5SoV+8aPiDDeg6AuS6/rUCE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBsYZ5WUiv5GUt+bbga7yyAQ77Cwr7uINGLxtF/7FCuq4YNxTUljhOcBnvFLy9646ZxKb9oQTvIAM7Hlu8AQ3wCyOSUpTWJkZPfKaBu78ZxWa5e3+8LWillqkAIPZtHjX4rfaErHk8Va+yyIV5TMSeL5llm+E6HZi1KT5IHTAyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bBoCCieI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so36036825e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760347457; x=1760952257; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RDKO3CyqyzhvakuwAtJ5SoV+8aPiDDeg6AuS6/rUCE4=;
        b=bBoCCieIxEs80EPW6GH4qwjBBsZ2ByCro+mH0sgcI1+BmsWJCydNIcYwwD3IwZAVaG
         suuoh75uWk2/SHwqSX3D0Xa/xRAgogU6yHpGkttdbzePP5oN67Zf8kawJQYWakQjfWO6
         bh1ouT9c8eaa9ufb+ZGklHUumRpRcx4Xl8HOisB2pysUf+QB1sPhctf3MFgSZOCqgSxq
         uAbpgigjC5jMzwLYFUCyED50vcwcniVX+eXcegxOyJK/h5q1O2NgYAA9AXaYhvSrcDRV
         rrCGFd6nkqqJGNVPY5OtysupamPN2T4VLbotxzTROXJ04KyEQ57DDUyF0eUWuOQ0cq05
         IBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760347457; x=1760952257;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RDKO3CyqyzhvakuwAtJ5SoV+8aPiDDeg6AuS6/rUCE4=;
        b=lEFM1BVGKFiXYhHkZKB5lKA6Suhd1XQ+5yghISsZ4Q3nNLeW4CL9BCtYn5kPgEhU83
         /JbvC0YmSxH0Vw3esJhj5kWYW9SyXWbJD85llv42kZRr0Ai690/b34gMUWJhXN0KeV3e
         OoWYl4tWjwVVaRA7e+oeQXzVzPSQg0IWDRlLOyrWWofRuHJRSCgAT7Q3yPbOHCbQGZcg
         6KeKl1TzGOolnG39aEhZkf0+4aHT5YYf5zKsxEx0cxIn1UFjIH0y+Eepm71ni9XWirmA
         AE5M3sWpWoX/AebsZPCW7IyAIqrlwy0C6jlMLk7dWVZsUlj3Y9RiD+flHRGGyYpj6x3x
         9eCA==
X-Forwarded-Encrypted: i=1; AJvYcCUnXslea0JhJOrVMC6SGTeK2Cb24aLS9gvHawHocShZe3/rPFjP7TnlvDjdIfTySP6rDG6l8Ejc2uwPPjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0XcC7FVk7BrYmMYvaiY9YQv9acdBPCFkTEUN3HhLCaGeTdjM
	Q+TlXfKJMPCKkFL83L+KM2JpY/ggU89KpHnpdU7hLrUFZn/kAbInRUpSgYsJhQweSFI=
X-Gm-Gg: ASbGncvHqkTL5IZofCmLCF2CAiA4gfIosWm+TGAmie478FPDfvyzbm5E+3h2xNfOTcZ
	jM4yqI7btI+OY0JxyFeOkk36/90AQmHRgodK6iIga4LJ6dS41rdxandseeIGzEJIjvPexEPWRRf
	mFIM7YBSw+gsycXrJ9NNeyCIt5mBZUqZEd1rDjLaQfkiKcgMCKXrIpwtsCqY97EeI/4YS6mB7Bx
	CblpHr1F0NYyHpvYlohH8poscpvaG+ISXt9BwDyyZmDYsuTo1zR8Se69ud2VyBq8Yzh7Dm6YZdx
	aOwRN7fXzTNTSWUiSgNYp2ASHaw4sOoDB/evX+bWMsn8EvYKktQie6W6PUBfuAIOfSGnKVOdc3y
	dqAJqtuNt9eU7/hQLs8Abym9HUZYWMMDuThvqiloFg4lqLb/HN5f9X4ig3Aw/Z+dboRhw+k8gqW
	bY5OOTXku+shWcRsyAUNB2x1X2wOY7NLvaEd6U3nSMg27ZjIy42sc6KX1L5uZ2i5I=
X-Google-Smtp-Source: AGHT+IE999RS83wgM/jkQhKuoMODNuQrc6RYGtNr/tj0Tz7qZq7NRTO5fQ3tcB/e6Xd8+p0qiAfDEA==
X-Received: by 2002:a05:600c:8b4c:b0:46f:b42e:ed86 with SMTP id 5b1f17b1804b1-46fb42eee22mr83730185e9.39.1760347456663;
        Mon, 13 Oct 2025 02:24:16 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49bdfd0sm176522245e9.10.2025.10.13.02.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 02:24:16 -0700 (PDT)
Message-ID: <2cce7bee-af02-4850-b1a8-b7f2cf3f1efb@suse.com>
Date: Mon, 13 Oct 2025 11:24:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/xen/xenbus: Replace deprecated strcpy in
 xenbus_transaction_end
To: Jan Beulich <jbeulich@suse.com>
Cc: linux-hardening@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jason Andryuk <jason.andryuk@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Thorsten Blum <thorsten.blum@linux.dev>
References: <20251012195514.39003-2-thorsten.blum@linux.dev>
 <ebee3406-d515-4e29-9d7c-f54bdb143080@suse.com>
 <65bad926-22fc-41da-b9c4-5857a002b377@suse.com>
 <13cbd826-540e-4352-8e0d-ae0c9fbd2faa@suse.com>
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
In-Reply-To: <13cbd826-540e-4352-8e0d-ae0c9fbd2faa@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VOS7NuzCrLtN1GiTjf9Y1UPB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VOS7NuzCrLtN1GiTjf9Y1UPB
Content-Type: multipart/mixed; boundary="------------5mlYFgxXSIL0gWIqUV1kH0Ax";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: linux-hardening@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jason Andryuk <jason.andryuk@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Thorsten Blum <thorsten.blum@linux.dev>
Message-ID: <2cce7bee-af02-4850-b1a8-b7f2cf3f1efb@suse.com>
Subject: Re: [PATCH] drivers/xen/xenbus: Replace deprecated strcpy in
 xenbus_transaction_end
References: <20251012195514.39003-2-thorsten.blum@linux.dev>
 <ebee3406-d515-4e29-9d7c-f54bdb143080@suse.com>
 <65bad926-22fc-41da-b9c4-5857a002b377@suse.com>
 <13cbd826-540e-4352-8e0d-ae0c9fbd2faa@suse.com>
In-Reply-To: <13cbd826-540e-4352-8e0d-ae0c9fbd2faa@suse.com>
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

--------------5mlYFgxXSIL0gWIqUV1kH0Ax
Content-Type: multipart/mixed; boundary="------------PFM0mkBhHcO1BbIdHg08Ek5p"

--------------PFM0mkBhHcO1BbIdHg08Ek5p
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMTAuMjUgMTA6MjIsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAxMy4xMC4yMDI1
IDA5OjM2LCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0KPj4gT24gMTMuMTAuMjUgMDg6NTksIEph
biBCZXVsaWNoIHdyb3RlOg0KPj4+IE9uIDEyLjEwLjIwMjUgMjE6NTUsIFRob3JzdGVuIEJs
dW0gd3JvdGU6DQo+Pj4+IC0tLSBhL2RyaXZlcnMveGVuL3hlbmJ1cy94ZW5idXNfeHMuYw0K
Pj4+PiArKysgYi9kcml2ZXJzL3hlbi94ZW5idXMveGVuYnVzX3hzLmMNCj4+Pj4gQEAgLTU0
NiwxNiArNTQ2LDEzIEBAIGludCB4ZW5idXNfdHJhbnNhY3Rpb25fc3RhcnQoc3RydWN0IHhl
bmJ1c190cmFuc2FjdGlvbiAqdCkNCj4+Pj4gICAgRVhQT1JUX1NZTUJPTF9HUEwoeGVuYnVz
X3RyYW5zYWN0aW9uX3N0YXJ0KTsNCj4+Pj4gICAgDQo+Pj4+ICAgIC8qIEVuZCBhIHRyYW5z
YWN0aW9uLg0KPj4+PiAtICogSWYgYWJhbmRvbiBpcyB0cnVlLCB0cmFuc2FjdGlvbiBpcyBk
aXNjYXJkZWQgaW5zdGVhZCBvZiBjb21taXR0ZWQuDQo+Pj4+ICsgKiBJZiBhYm9ydCBpcyB0
cnVlLCB0cmFuc2FjdGlvbiBpcyBkaXNjYXJkZWQgaW5zdGVhZCBvZiBjb21taXR0ZWQuDQo+
Pj4+ICAgICAqLw0KPj4+PiAtaW50IHhlbmJ1c190cmFuc2FjdGlvbl9lbmQoc3RydWN0IHhl
bmJ1c190cmFuc2FjdGlvbiB0LCBpbnQgYWJvcnQpDQo+Pj4+ICtpbnQgeGVuYnVzX3RyYW5z
YWN0aW9uX2VuZChzdHJ1Y3QgeGVuYnVzX3RyYW5zYWN0aW9uIHQsIGJvb2wgYWJvcnQpDQo+
Pj4+ICAgIHsNCj4+Pj4gICAgCWNoYXIgYWJvcnRzdHJbMl07DQo+Pj4+ICAgIA0KPj4+PiAt
CWlmIChhYm9ydCkNCj4+Pj4gLQkJc3RyY3B5KGFib3J0c3RyLCAiRiIpOw0KPj4+PiAtCWVs
c2UNCj4+Pj4gLQkJc3RyY3B5KGFib3J0c3RyLCAiVCIpOw0KPj4+DQo+Pj4gV2hpbGUgYXQg
bGVhc3QgaW4gcHJpbmNpcGxlIGEgY29tcGlsZXIgbWlnaHQgYmUgYWJsZSB0byB0cmFuc2Zv
cm0gdGhpcyBpbnRvDQo+Pj4gY29kZSBub3QgdXNpbmcgYW55IGxpYnJhcnkgZnVuY3Rpb24g
YXQgYWxsLCAuLi4NCj4+Pg0KPj4+PiArCXN0cnNjcHkoYWJvcnRzdHIsIGFib3J0ID8gIkYi
IDogIlQiKTsNCj4+Pg0KPj4+IC4uLiB0aGUgdXNlIG9mIGEgbiBvbi1zdGFuZGFyZCBmdW5j
dGlvbiAod2l0aG91dCBlcXVpdmFsZW50IGNvbXBpbGVyIGJ1aWx0aW4pDQo+Pj4gZG9lc24n
dCBwZXJtaXQgdGhpcy4gSU9XIHdoeSBub3Qgc2ltcGx5IHN3aXRjaCB0byBlLmcuDQo+Pj4N
Cj4+PiAgICAgICBjaGFyIGFib3J0c3RyWzJdID0geyBbMF0gPSBhYm9ydCA/ICdGJyA6ICdU
JyB9Ow0KPj4NCj4+IEkgd291bGQgZXZlbiBnbyBmdXJ0aGVyIGFuZCBkcm9wIGFib3J0c3Ry
W10gY29tcGxldGVseToNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4veGVuYnVz
L3hlbmJ1c194cy5jIGIvZHJpdmVycy94ZW4veGVuYnVzL3hlbmJ1c194cy5jDQo+PiBpbmRl
eCA1Mjg2ODJiZjBjN2YuLmM4OTFhZjcxNjVmNSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
eGVuL3hlbmJ1cy94ZW5idXNfeHMuYw0KPj4gKysrIGIvZHJpdmVycy94ZW4veGVuYnVzL3hl
bmJ1c194cy5jDQo+PiBAQCAtNTUwLDE0ICs1NTAsOCBAQCBFWFBPUlRfU1lNQk9MX0dQTCh4
ZW5idXNfdHJhbnNhY3Rpb25fc3RhcnQpOw0KPj4gICAgICovDQo+PiAgICBpbnQgeGVuYnVz
X3RyYW5zYWN0aW9uX2VuZChzdHJ1Y3QgeGVuYnVzX3RyYW5zYWN0aW9uIHQsIGludCBhYm9y
dCkNCj4+ICAgIHsNCj4+IC0gICAgICAgY2hhciBhYm9ydHN0clsyXTsNCj4+IC0NCj4+IC0g
ICAgICAgaWYgKGFib3J0KQ0KPj4gLSAgICAgICAgICAgICAgIHN0cmNweShhYm9ydHN0ciwg
IkYiKTsNCj4+IC0gICAgICAgZWxzZQ0KPj4gLSAgICAgICAgICAgICAgIHN0cmNweShhYm9y
dHN0ciwgIlQiKTsNCj4+IC0NCj4+IC0gICAgICAgcmV0dXJuIHhzX2Vycm9yKHhzX3Npbmds
ZSh0LCBYU19UUkFOU0FDVElPTl9FTkQsIGFib3J0c3RyLCBOVUxMKSk7DQo+PiArICAgICAg
IHJldHVybiB4c19lcnJvcih4c19zaW5nbGUodCwgWFNfVFJBTlNBQ1RJT05fRU5ELCBhYm9y
dCA/ICJGIiA6ICJUIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIE5VTEwpKTsNCj4+
ICAgIH0NCj4+ICAgIEVYUE9SVF9TWU1CT0xfR1BMKHhlbmJ1c190cmFuc2FjdGlvbl9lbmQp
Ow0KPiANCj4gSG1tLCB3aGljaCB4c19zaW5nbGUoKSBpbmRlZWQgdGFrZXMgYSBjb25zdCBj
aGFyICosIGl0IHRoZW4gY2FzdHMgYXdheSBjb25zdC0NCj4gbmVzcyBiZWZvcmUgaGFuZGlu
ZyB0byB4c190YWxrdigpLg0KDQpZZXMsIHRoZSBjYXN0IGlzIG5lZWRlZCBhcyB4c190YWxr
digpIGNhbiBoYW5kbGUgcmVhZHMgYW5kIHdyaXRlcy4gTm8gcHJvYmxlbSBpbg0KdGhpcyBj
YXNlLCBhcyB0aGUgc3RyaW5nIGlzIG9ubHkgcmVhZCBieSB4c190YWxrdigpICh3cml0ZSB0
eXBlIG9wZXJhdGlvbikuDQoNCg0KSnVlcmdlbg0K
--------------PFM0mkBhHcO1BbIdHg08Ek5p
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R3/CwO0EGAEIACAWIQSFEmdy6PYElKXQl/ew3p3W
KL8TLwUCWt3w0AIbAgCBCRCw3p3WKL8TL3YgBBkWCAAdFiEEUy2wekH2OPMeOLge
gFxhu0/YY74FAlrd8NAACgkQgFxhu0/YY75NiwD/fQf/RXpyv9ZX4n8UJrKDq422
bcwkujisT6jix2mOOwYBAKiip9+mAD6W5NPXdhk1XraECcIspcf2ff5kCAlG0DIN
aTUH/RIwNWzXDG58yQoLdD/UPcFgi8GWtNUp0Fhc/GeBxGipXYnvuWxwS+Qs1Qay
7/Nbal/v4/eZZaWs8wl2VtrHTS96/IF6q2o0qMey0dq2AxnZbQIULiEndgR625EF
RFg+IbO4ldSkB3trsF2ypYLij4ZObm2casLIP7iB8NKmQ5PndL8Y07TtiQ+Sb/wn
g4GgV+BJoKdDWLPCAlCMilwbZ88Ijb+HF/aipc9hsqvW/hnXC2GajJSAY3Qs9Mib
4Hm91jzbAjmp7243pQ4bJMfYHemFFBRaoLC7ayqQjcsttN2ufINlqLFPZPR/i3IX
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------PFM0mkBhHcO1BbIdHg08Ek5p--

--------------5mlYFgxXSIL0gWIqUV1kH0Ax--

--------------VOS7NuzCrLtN1GiTjf9Y1UPB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjsxT8FAwAAAAAACgkQsN6d1ii/Ey+y
/gf9GK6Lwa46fzJStSHQj8UzSzffMHs65l/p8SyVO4BOK0xkmcVilZOPmSh4fteTkbha5gbYvRkJ
n59yHIvJZyESdE8/E+hSbXF35xOj7KVE89G/95aJZfG8Ez0HaD4XAsfvX+K7tnkewjkmEaNTuvyI
N7kD/SVDs9P3xmt2b56KxLOWDZ+mBjsv3aQAGj/mbeeewlZhqhZPiKbSu0EVxI8KJqeelDvp6+kt
G0QYfDW6u2d8yGDSvW56tDFf/EynXOJ5P7Rk8j2x+lDXWsHGqkQg/l1xR0LeoTReOswojHcJrH4K
alJkUz1yhZAQWY41bBfECdnvZ4CFxMmoehCTeq3oQQ==
=icgx
-----END PGP SIGNATURE-----

--------------VOS7NuzCrLtN1GiTjf9Y1UPB--

