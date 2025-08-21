Return-Path: <linux-kernel+bounces-778875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96336B2EC49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153BE7A2605
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E522E8B61;
	Thu, 21 Aug 2025 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXkg1zma"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F92E5406
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747931; cv=none; b=RPCCzYAJCPOCmLjqHBxJwJhtuJc3n335VrZz0gaoEJzPX+gjwhnBxUrkY0DneYT0ZDhzYxTvm3icihTePu3XwkpfWCNAm6E+kHWjGiizLo0lh7HblMkgDbHwKsGrMhe4mOpwUqycBUFxiB+7lbiwUgQsbxHrDTowkObcYDo01Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747931; c=relaxed/simple;
	bh=kqd82iuup2BD8P7OsXk/sDUZpeOVSaOvpvZ1wRizI88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qty72mVt5Yru99udKJrYkyCBFYDuM8ihaNf7gAB4FxqSk89oyynXkkhth3X0C1vL4WauAdkhzsyT6wYRXNWOjoLXyBlpRFJi4oBiZfcTKjNkjfPyBQ6ZcmXrnCKrpPGjMswRHA/c7wEZs8RmcpB3Z6kugwDVx8ikQaCYwwU/rkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BXkg1zma; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b1098f9e9eso8889641cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755747928; x=1756352728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kqd82iuup2BD8P7OsXk/sDUZpeOVSaOvpvZ1wRizI88=;
        b=BXkg1zmacfOZXH8u0kimNPAtB/tffBuhCpqlV5Eq8TzctLocnAEjVE7mIxzv4oHEI+
         q/oKjMALDAu01ji7HJPC9TzPbyxsCKjr3ZIVMQO8NW32muRxkpknxSeAa3pHbrlXM24+
         ACoWSgx/ZtIH7yl4YpQkTBdV+I1JveuoxHqjvRAWdIuozO+0iJJNPrSwA/Eo26ZEsJkO
         izfZebI3X4sDOw46AhXKdSQxsxOKLruzbAnwmBEph1mRiB6zL79SsukorucoZ21F+6Wa
         9DTk1AyPNw6cma6uS6WUcS4cG1A1QGUi7UuvX/zb4Glkb6aeCkoFXn8NK3aH7Chfbjig
         zghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747928; x=1756352728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqd82iuup2BD8P7OsXk/sDUZpeOVSaOvpvZ1wRizI88=;
        b=r44h9T4ZkwveoeoRoUbe1FFmAQlxWY44Ii1OjIbg+0V5nHiho2Tv2nogtXMAm4QjFp
         pIY89UyoCOrk1cXFOHAdBaCzGlnxbzgmdU1NV0RKNdK19yw/gJxxrnUpuoWh+KzV2eH2
         iXpN2i/rqJIEniB1u4ujdHh/2tQga9nvh0uXkarBR6OEu8yzELEOZrQxYbblKxfrHc4I
         xbHxUutvK85ynENhk13n5NDVaaxmg9ArqUTrnMevQVsS+FzgHviQ2Vri7DvoNwOIJTFv
         K1Zo3GMfSNiSLJNjTQglR+yWpXq3ALnAKYNZmx7DcsLJGnB9kgVM+oq/ij/PcIPVFpY1
         f9zw==
X-Forwarded-Encrypted: i=1; AJvYcCWLi4nAfe0o7tvG5dd2Ejvd3/zdALjpHOsT6HWBZvhJWhMCnpLCgYMmC5hhDqYSmkux063y0v44AoNkQec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT5eb+dS2MKIfB/JaMf+inIAtlzlVynvWtDcPpGl4SZxPXpREj
	KwBniuAFESB0zBBZXdpd5yNzm3U5jy+ahoYWHHMsJTqGanYr6rfleNJeln3edoAqbksLpEEM+0k
	hRHqhAWI/BMqdYA5/6f6bIWwIrQZ/Owhb1Hz9Zcr+
X-Gm-Gg: ASbGncsRw+slbHnIRSjUhL4J/kaevPibGgc5IAV/rfJycLAl4Eh2SnSUmgvuqLdS4o8
	ZAPwytn/oVU2tOLQvV7R6SfqYwp89MQjs2sBo6fkgu0UgVcgAC4wUWceT+ZKnGnfulwIzPW6XwU
	emmxZEh3SSNfIGcTnmJs1NXCT4ppkSWWp1OhHNdEjqeDd3cTep04dXnkA8aDxg8NDGujrzX7N5Y
	BH9in0v2FuOfwqnFudLdZE=
X-Google-Smtp-Source: AGHT+IFz+XUqm2XwfejAzjO9TtBRYiPce1OqKnqLfjzmKltzefUXYhJgD6PSAN7JqsnNbYIo2CtUXQL14inHgxYe6yk=
X-Received: by 2002:a05:6214:226c:b0:70d:6df4:1afe with SMTP id
 6a1803df08f44-70d890826b0mr10934836d6.60.1755747928241; Wed, 20 Aug 2025
 20:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818192800.621408-1-briannorris@chromium.org>
 <CABVgOSkUT_yYqBvk2-+OozKEBybj-07mcRAVECNYQiw+1P67eA@mail.gmail.com> <aKYEVTRhzbXvwlbD@google.com>
In-Reply-To: <aKYEVTRhzbXvwlbD@google.com>
From: David Gow <davidgow@google.com>
Date: Thu, 21 Aug 2025 11:45:16 +0800
X-Gm-Features: Ac12FXxLMOOEgXBkyWtT0qfVSC_NcHMSvy3RF37Y5Ouo4vEVI45UAmtPmDfyqt8
Message-ID: <CABVgOSkfADJGnMekV9Zz4x_Ana2uZYMnca1SDXoJnWjvPRGv8Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] genirq/test: Platform/architecture fixes
To: Brian Norris <briannorris@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009cc33a063cd7ebb7"

--0000000000009cc33a063cd7ebb7
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 01:22, Brian Norris <briannorris@chromium.org> wrote:
>
> On Wed, Aug 20, 2025 at 03:00:34PM +0800, David Gow wrote:
> > Looks like __irq_alloc_descs() is returning -ENOMEM (as
> > irq_find_free_area() is returning 200 w/ nr_irqs == 200, and
> > CONFIG_SPARSE_IRQ=n).
>
> Thanks for the insight. I bothered compiling my own qemu just so I can
> run m68k this time, and I can reproduce.
>
> I wonder if I should make everything (CONFIG_IRQ_KUNIT_TEST) depend on
> CONFIG_SPARSE_IRQ, since it seems like arches like m68k can't enable
> SPARSE_IRQ, and they can't allocate new (fake) IRQs without it. That'd
> be a tweak to patch 4.
>
> Or maybe just 'depends on !M68K', since architectures with higher
> NR_IRQS headroom may still work even without SPARSE_IRQ.
>

I'm not an m68k expert (so I've CCed Geert), but I think different
m68k configs do have different NR_IRQS, so it's possible there are
working m68k setups, too. (It also seems slightly suspicious to me
that exactly 200 IRQs are allocated here, though, so a lack of extra
headroom may be deliberate and/or triggered by something trying to
allocate all IRQs.)

Personally, I don't have any m68k machines lying around, so disabling
the test so my qemu scripts don't report errors is fine by me. Ideally
the dependency would be as narrow as possible, but that may well be
!M68K.

The other option would be to try to skip the test if there aren't free
IRQs, but maybe that'd hide real issues?

Regardless, I'll defer to the IRQ and m68k experts here: as long as
I'm not seeing errors, I'm happy. :-)

Cheers,
-- David

--0000000000009cc33a063cd7ebb7
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
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgvhxLfX7dsg8ju4SLOzZAJMoo0rjt
Y5O9UOJS1fNR7v4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
ODIxMDM0NTI4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAaefGb7sRrsPO/OXdOx+lgAgvjZWAI90Pcnt5RTm8nWAjRxTWnmAv8LD+oXTRZyHT
F30THjghxunGUtlWn4GANlgO75UIkP7/8qz0c52+v99/OMtVsSHpKzGCxQuUJxAZzlk3o96V0uVU
8VGdz30NxAew8UkARO9Slab537jqnKhYgqv4G5NIH8jPwoEGIHlyKktvDwTXG+UZN50WE0oP5qNX
1S8lAB0Eqdz2cQ8ujMNIinzvymlbaGwI3T6rdZ+/QSkpBlC8UeGrsK3odFZ9odjE/wNLCH2LUxUu
R+Qfl9LKSxeFpkihdoHN/uMvCSejE2JSn56Ynnfvd3af5MwAHA==
--0000000000009cc33a063cd7ebb7--

