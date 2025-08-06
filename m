Return-Path: <linux-kernel+bounces-757142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FD8B1BE3E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58B33AC9DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426FE38DF9;
	Wed,  6 Aug 2025 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SZXnJZNQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF487261C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754443036; cv=none; b=ccyMopLwkEe0ftyuw2NSrnbvjrCJFZckcjw6OQTogwMFslU6LS3ZJkhSyPpD3fSL31CtL3SOGA5CEkl80J0ro1D2PQpiQw5GyHg60Tgrbvz5kt+TypEzwHxrq7KlokWJ2ZVMZujGJoo6SprcuhtC8AX5DZfylczgOLrGP74/7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754443036; c=relaxed/simple;
	bh=E/w+DRqXb2jFxDHaU6euhPt7TOxgsKSFsApi1bZjEcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkzAePxkpDLodW6GU7sOqMy4JoQ6C67YfY+FjRRM+ZtxAyaVuBRyIQpu5/R6xlHxIvZtRrMl7NlGWRgMctJyvrSsV/Rjoz0Vn2cdzaFNEvKc6ii6SAH1p6aoqLyg4dtHKvph1ObK139V7fX6uiLNuL60rmTyfsoQdlfGsrSBs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SZXnJZNQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-615c8ca53efso10256009a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 18:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754443033; x=1755047833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d2GKUutMb+CTg/SBIA+X4H18S3n8qy8/RVR5pHccndQ=;
        b=SZXnJZNQ3VfNhuc/EWHWUt7xuS2zfdlnar67RAwe3NntpBh2ORXOO1ubCvYTXfNiNv
         qPukEMVJAhyOl8hSBsNMkxWeWYOo/IIVhDGEJl9ijh4hvaWaS+ASbm44kqsAImjT0o6I
         WjSVB709hFX0u6szzHh+JrwnuWilIcf2vMbgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754443033; x=1755047833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2GKUutMb+CTg/SBIA+X4H18S3n8qy8/RVR5pHccndQ=;
        b=BnWbuyw6aE0WBeH9mIVCWOXW1kCdggNItcM4yJCmw+1awb6bcbsd0IA5gpS1afn3pP
         4PqpK3lLhljdyKIjTEJ6MQQgLRk+fozQXLaA4KjeN9MWltIbXxwXsqlnkr4znW2U36AO
         DXFKW/WSXBrTFOqO9mlZxNBWXvtUWESBFQpwaLgg7X2zWHzhq1W59PpLV4CoASFHeCiS
         G+TM9KrHjqoqkAlZKnZZ6YrzzVFTJFj9UJxJv+4MNaHOqqg586zjJi622wHAqzXbP3ao
         xW2pHGHGCuptmiaTagd5VSsKhFsIcpyu24j5hJPRpXTjoVzGXGQBj1QvyvPJ/XMBXFuy
         Z8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCV72Q86jkMU9lCdZi2MCJyxbdIZNnw17UywgkWnVto+f1kbLPKVAScXuSdQzR7kvKn3KGboD8RrgOd1qU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04c1zZMy2gll+UhnW4QcXD7YBr3+QxnKITjVc1gq2VgtNWacn
	MVU93YKry9R7NKTM2O6SyAnU/G6yoWunmvt46qfDtc339L3sYDEd/LxkwVGGEJrpTGYIHLcFAVG
	5o0DsmSKoHQ==
X-Gm-Gg: ASbGncse+bSC0HIHkhonbewVq2GiA4C3NXihW3bC48XRXc0hXD8Yt1z+3tX40rj4Pko
	DJrZMT1q10ALKXvkhky9wEnChB8d1KJQq2ROjo2tqkqBbuTbC/dL1J48zyPTQGmY8WHgRhuO7nh
	XKchMKQ8NVM4j6cSjT1vq4UdGzp5tRADLz91NKpmBypraHbOQviGhvwKKtdFoL49moeJiQaufr+
	N22TKbalBEWCevSOsar9itlPh3rgCVhLnB5VKJCSmugBzLbGezwoUSDe6hSToE50I5NIpzgDpvR
	z6kk/Z6TPQobnB/+lpJTqEow116Ap9sUCqs4RtwPVK4K5aB2u7/D5IwNyDFCFu/MwTIXKrCMseS
	NS5T5BC6ejmYoA8gHEmpBTS02VQzIOV+DSLNFiE5KNro1tOFybIATzUN6J38a5dPUWWSoExPF
X-Google-Smtp-Source: AGHT+IGsHnZX6NHGqvWUxSi4AX4cwaGs3DP7mNE+ZM2iIPxFAhLHTfN8AvF5SdQKKxmKbjTbdme9sw==
X-Received: by 2002:a05:6402:3549:b0:60c:4220:5d89 with SMTP id 4fb4d7f45d1cf-6179616152bmr805297a12.23.1754443032657;
        Tue, 05 Aug 2025 18:17:12 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f245c1sm9306990a12.22.2025.08.05.18.17.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 18:17:12 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6153a19dddfso9638361a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 18:17:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHxJoBBo+BVBhSzcLRezSl4ICuf1NwuYQnAmRIpV3OOVnF7eL2IGXY35YZjaeH1LDuV2ePvqj2lMUsqZU=@vger.kernel.org
X-Received: by 2002:a17:907:9703:b0:ae3:6651:58ba with SMTP id
 a640c23a62f3a-af9902dffaemr94719466b.35.1754442686168; Tue, 05 Aug 2025
 18:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org> <20250805202848.GC61519@horms.kernel.org>
 <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Aug 2025 04:11:09 +0300
X-Gmail-Original-Message-ID: <CAHk-=wh+bnqPjL=9oq3uEkyZ7WB8=F_QMOHsGjHLj98oYk-X3Q@mail.gmail.com>
X-Gm-Features: Ac12FXx151gZKxn5F0B-h1oNAfMmrkA84RTvsrxwBVO-1UWY7oBd7NqVoQGVGt8
Message-ID: <CAHk-=wh+bnqPjL=9oq3uEkyZ7WB8=F_QMOHsGjHLj98oYk-X3Q@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on() call placement
To: Simon Horman <horms@kernel.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, Oliver Neukum <oneukum@suse.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux Netdev Mailing List <netdev@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org, 
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Content-Type: multipart/mixed; boundary="00000000000016f79a063ba80507"

--00000000000016f79a063ba80507
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 01:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And no, I didn't actually test that version, because I was hoping that
> somebody who actually knows this code better would pipe up.

Bah. Since I'm obviously horribly jetlagged, I decided to just test to
make sure I understand the code.

And yeah, the attached patch also fixes the problem for me and makes
more sense to me.

But again, it would be good to get comments from people who *actually*
know the code.


              Linus

--00000000000016f79a063ba80507
Content-Type: application/x-patch; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mdz5fpf80>
X-Attachment-Id: f_mdz5fpf80

IGRyaXZlcnMvbmV0L3VzYi91c2JuZXQuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3Vz
Yi91c2JuZXQuYyBiL2RyaXZlcnMvbmV0L3VzYi91c2JuZXQuYwppbmRleCBhMzhmZmJmNGIzZjAu
LjUxMWM0MTU0Y2Y3NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvdXNiL3VzYm5ldC5jCisrKyBi
L2RyaXZlcnMvbmV0L3VzYi91c2JuZXQuYwpAQCAtMTEyMCw2ICsxMTIwLDkgQEAgc3RhdGljIHZv
aWQgX19oYW5kbGVfbGlua19jaGFuZ2Uoc3RydWN0IHVzYm5ldCAqZGV2KQogCWlmICghdGVzdF9i
aXQoRVZFTlRfREVWX09QRU4sICZkZXYtPmZsYWdzKSkKIAkJcmV0dXJuOwogCisJaWYgKHRlc3Rf
YW5kX2NsZWFyX2JpdChFVkVOVF9MSU5LX0NBUlJJRVJfT04sICZkZXYtPmZsYWdzKSkKKwkJbmV0
aWZfY2Fycmllcl9vbihkZXYtPm5ldCk7CisKIAlpZiAoIW5ldGlmX2NhcnJpZXJfb2soZGV2LT5u
ZXQpKSB7CiAJCS8qIGtpbGwgVVJCcyBmb3IgcmVhZGluZyBwYWNrZXRzIHRvIHNhdmUgYnVzIGJh
bmR3aWR0aCAqLwogCQl1bmxpbmtfdXJicyhkZXYsICZkZXYtPnJ4cSk7CkBAIC0xMTI5LDkgKzEx
MzIsNiBAQCBzdGF0aWMgdm9pZCBfX2hhbmRsZV9saW5rX2NoYW5nZShzdHJ1Y3QgdXNibmV0ICpk
ZXYpCiAJCSAqIHR4IHF1ZXVlIGlzIHN0b3BwZWQgYnkgbmV0Y29yZSBhZnRlciBsaW5rIGJlY29t
ZXMgb2ZmCiAJCSAqLwogCX0gZWxzZSB7Ci0JCWlmICh0ZXN0X2FuZF9jbGVhcl9iaXQoRVZFTlRf
TElOS19DQVJSSUVSX09OLCAmZGV2LT5mbGFncykpCi0JCQluZXRpZl9jYXJyaWVyX29uKGRldi0+
bmV0KTsKLQogCQkvKiBzdWJtaXR0aW5nIFVSQnMgZm9yIHJlYWRpbmcgcGFja2V0cyAqLwogCQlx
dWV1ZV93b3JrKHN5c3RlbV9iaF93cSwgJmRldi0+Ymhfd29yayk7CiAJfQo=
--00000000000016f79a063ba80507--

