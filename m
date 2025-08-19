Return-Path: <linux-kernel+bounces-775076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40590B2BAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB4F1675A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109CB3101C4;
	Tue, 19 Aug 2025 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4SSpL3n4"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6002773D8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589507; cv=none; b=RsqDAACsleNMtcSuONma+TByXE2zinl8wqrnrucnJESdDQvaegpi0iCm4MH+qemXMoYsh5hcBLZbxkJHp1qac12SdJHTpDSGHAsODFa7k1rNr8VwKhQJ4+SWboREaV3g4Pn4RNqxYyrpdzrIDFnqELBizpvkNx84iJU66jlQn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589507; c=relaxed/simple;
	bh=dGADOemFCZSmED1NOyW8HXg7x3nks1yEOSBQxtXsY2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYp3Je70LzUVOXmhgV3czGvgH84dAFLoaRGzenS5Qj6NdTiIiLYy3brajmhN1nM0hN49HR6pM1uLAv5EI7S+qab1iwd7ulAUOKvPhIVLP0em9cVxMiv5Byl5LlWnDNsto0HhH6/sENQRXe9ioiWGYvovka4qs8L6uM30ZAp1qoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4SSpL3n4; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70a92aec278so39652376d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755589504; x=1756194304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gazv8RwQtXE/VrusUAhGmhA6Ou+o50oaAywmK7UKSAQ=;
        b=4SSpL3n4/hl5joz0HaX+QOhHqgCMKxSB3eXxi1L5avCwftYYB+maP+AS3fOulePmsm
         k9CHQpg6VdiSAq+4hr7beYFTv3l5V45A3B0d1ngpG0DChprcrrdBZSsDK6Wo9QD+hISQ
         IHf9jWRvmEJmiC6hKY+SGPHwOpzx+8mvYB2gcYhKMq/sYab8hsejROzj1w0/FR2SERiM
         +o5llBhyIgnQL788UnsbRg7ZKc44CYCsrJP80Wuw1KlptOEM5h1hXNxayKtp+on9waZq
         Nf6ZRyqrgF6UMdnZWavh8yg5XFtXdLkmrFsVL5fUm+wpVGpdbmqaBE30y7cXAB41WoBg
         aUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755589504; x=1756194304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gazv8RwQtXE/VrusUAhGmhA6Ou+o50oaAywmK7UKSAQ=;
        b=I8LVeX07xr/3RmoL+697/LdNUA8QlO9BlWyKnOKuxwIbMupmvQYas6pWG7G6DMLF9d
         dvRMFkwJ3AwdkF1RbZdcNlF5y8QBftIDCrAyKVHeuFR1lpZ2rTP2NISh9FsnYdURst3Y
         NSbwdwXThvCrU/x5PBpYk2c/6IFP/eMt9Y0PK/ZV2cEEJjvEQNgwJIC2wpNCnv/TpL6v
         KBDtLVzA1edBukz9GZJg0pgOi2DWl/Ya7fZUmU78q+8eZ0QeSVp8kwe3MEHIh8nSHm+t
         YzYmBms9eBZA5BP06RUgwBMVRwwqY8s9rw+jS/+fhVbsAndVevfV5W53Rkx/Ozo+tEMX
         6zZw==
X-Forwarded-Encrypted: i=1; AJvYcCVGJwKJ3oOI3kzPgfbtNhYMYVUaqFY/DGmnwmThYR2MNPhYubX1J3EIOSlVkurZ50ShXkRn/1UgKZwzZ7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHR0DaEUi3Klb6sNlDKoTHH+urBf/ez7NhQtD/eRHtyzkpId4Q
	xbM9wxxn0K/ApV452hpf37JSZnZQKg63HebPAytmaD8NAFJcNxyMeeJRPLv0uqgJI+UkPFKulTe
	8nmy8X7Fcie6MxdXKJ0xT2r3xgoHkw/eeEHLgbC/G
X-Gm-Gg: ASbGncstYCGYOeIRVwm3y8Uf48VPojJXWctUO+uqwWCa8wclg5+2pul2pbMtGntYxjV
	l9xVIdCgLoQrpQ2pUmQROzCSa8Vtl7s3gsmQUGRV0FBKo69ZqtN6+LcgPQDg6qwdAZVyFd7W8WF
	7ZdqUhuGFds/wznT5LeJT+/Kkwznsb3N+yzeMcqqVOKD94z28nEAwiIHfRGPwx+SGoFvCOMEQwN
	aiMwSuHeW50XaaXYasJbjw=
X-Google-Smtp-Source: AGHT+IFpO2Yt0fTnLtTCha4sRuzJexs8TFc6Ap9UXFsgUVTkg0w9KOR8FxjAjWWj1Qyt5uSZc1CvRlQhVtg9f2yQZYc=
X-Received: by 2002:ad4:5ce5:0:b0:70b:b18b:799e with SMTP id
 6a1803df08f44-70c35cf0db5mr16560386d6.35.1755589503968; Tue, 19 Aug 2025
 00:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818120846.347d64b1@canb.auug.org.au> <1befd7ab-f343-450f-9484-0cef21fe2da8@linuxfoundation.org>
In-Reply-To: <1befd7ab-f343-450f-9484-0cef21fe2da8@linuxfoundation.org>
From: David Gow <davidgow@google.com>
Date: Tue, 19 Aug 2025 15:44:52 +0800
X-Gm-Features: Ac12FXzPp40VIcdYbjAVdVJmSOoC3KnKFX9eLIc_ZDEcxiF92dydp50VadKj8Q0
Message-ID: <CABVgOSm2_FGfjQpUBttuUH5ZrMEqnaGkYVkN6N96wX7Qs8EE2Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kunit-next tree
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Marie Zhussupova <marievic@google.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	KUnit Development <kunit-dev@googlegroups.com>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cc2c42063cb308cf"

--000000000000cc2c42063cb308cf
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 00:32, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 8/17/25 20:08, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the kunit-next tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
>
> Thank you Stephen. I did a allmodconfig build on 6.17-rc1 base - didn't
> see the error.
>
> Marie, David, can you take a look this. Looks like conflict with drm
> in next?
>

Thanks, Shuah. I've managed to reproduce this with:
./tools/testing/kunit/kunit.py run --arch x86_64 --kunitconfig
drivers/gpu/drm/xe

These patches fix it (and a corresponding drm/xe test failure):
https://lore.kernel.org/linux-next/20250819073434.1411114-1-davidgow@google.com/T/#t

Ideally, they'll be squashed into the corresponding patches, as
otherwise there'd be some temporary breakage during bisections. I can
squash these into the original series and re-send it out if that works
best for you.

Cheers,
-- David

> >
> > In file included from include/kunit/static_stub.h:18,
> >                   from drivers/gpu/drm/xe/xe_bo.c:20:
> > drivers/gpu/drm/xe/tests/xe_bo.c:610:48: error: initialization of 'const void * (*)(struct kunit *, const void *, char *)' from incompatible pointer type 'const void * (*)(const void *, char *)' [-Wincompatible-pointer-types]
> >    610 |         KUNIT_CASE_PARAM(xe_ccs_migrate_kunit, xe_pci_live_device_gen_param),
> >        |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/kunit/test.h:210:38: note: in definition of macro 'KUNIT_CASE_PARAM'
> >    210 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
> >        |                                      ^~~~~~~~~~
> > drivers/gpu/drm/xe/tests/xe_bo.c:610:48: note: (near initialization for 'xe_bo_tests[0].generate_params')
> >    610 |         KUNIT_CASE_PARAM(xe_ccs_migrate_kunit, xe_pci_live_device_gen_param),
> >        |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/kunit/test.h:210:38: note: in definition of macro 'KUNIT_CASE_PARAM'
> >    210 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
> >        |                                      ^~~~~~~~~~
> > drivers/gpu/drm/xe/tests/xe_bo.c:611:45: error: initialization of 'const void * (*)(struct kunit *, const void *, char *)' from incompatible pointer type 'const void * (*)(const void *, char *)' [-Wincompatible-pointer-types]
> >    611 |         KUNIT_CASE_PARAM(xe_bo_evict_kunit, xe_pci_live_device_gen_param),
> >        |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/kunit/test.h:210:38: note: in definition of macro 'KUNIT_CASE_PARAM'
> >    210 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
> >        |                                      ^~~~~~~~~~
> > drivers/gpu/drm/xe/tests/xe_bo.c:611:45: note: (near initialization for 'xe_bo_tests[1].generate_params')
> >    611 |         KUNIT_CASE_PARAM(xe_bo_evict_kunit, xe_pci_live_device_gen_param),
> >        |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/kunit/test.h:210:38: note: in definition of macro 'KUNIT_CASE_PARAM'
> >    210 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
> >        |                                      ^~~~~~~~~~
> > drivers/gpu/drm/xe/tests/xe_bo.c:624:51: error: initialization of 'const void * (*)(struct kunit *, const void *, char *)' from incompatible pointer type 'const void * (*)(const void *, char *)' [-Wincompatible-pointer-types]
> >    624 |         KUNIT_CASE_PARAM_ATTR(xe_bo_shrink_kunit, xe_pci_live_device_gen_param,
> >        |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/kunit/test.h:223:38: note: in definition of macro 'KUNIT_CASE_PARAM_ATTR'
> >    223 |                   .generate_params = gen_params,                                \
> >        |                                      ^~~~~~~~~~
> > drivers/gpu/drm/xe/tests/xe_bo.c:624:51: note: (near initialization for 'xe_bo_shrink_test[0].generate_params')
> >    624 |         KUNIT_CASE_PARAM_ATTR(xe_bo_shrink_kunit, xe_pci_live_device_gen_param,
> >        |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/kunit/test.h:223:38: note: in definition of macro 'KUNIT_CASE_PARAM_ATTR'
> >    223 |                   .generate_params = gen_params,                                \
> >        |                                      ^~~~~~~~~~
> >
> > Caused by commit
> >
> >    444be9072fca ("kunit: Pass parameterized test context to generate_params()")
> >
> > I have used the kunit-next tree from next-20250815 for today.
> >
>
> thanks,
> -- Shuah
>

--000000000000cc2c42063cb308cf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgOseZdgY00vUomBJ8dEY1iwNH5haz
fRyPk58inLgbs3YwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
ODE5MDc0NTA0WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEADvQ/7MxbQ0blg/wYpR5mSDR/7JmEEvPkzcfGx+vHxrRj+oTqChPycb2u4XqDSAVx
Y/3RdKcZBdtOo+Gk/coUyLgEGqX00yF4PYFcFd1iFTs8dF/TYBFUIrgrSXYfSdJFxNmt5syUM9TQ
YjMi8zeumxu+7FnFmhrPwHP3ygbicRLTWEVuBLV3BsPw+l+XNLTg+AVZpx2+4xF5akRd5bXrCnP3
TS4GESTWV5JbCIfPNnunxHOy4Wme02csplCsnZdQShpBze45lKNlXveT7mlVez6OWq2Ix0VDvTrt
08G4dGDI7tqfYmtha0AMWbbMqRKmiUx9hHZFx8AJN5OLeLlsCA==
--000000000000cc2c42063cb308cf--

