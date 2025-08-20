Return-Path: <linux-kernel+bounces-777040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6EEB2D462
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA731C22D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD5D2C15A6;
	Wed, 20 Aug 2025 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zw+Z+dRU"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E82C11CC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673249; cv=none; b=LoD6u/Kqvw6iv31AUVBTe6KTNvp1QHRLrGqbRBEguoVij1n39XnycxNnTVA41eM74JUrGSnyG07VZEES1e0A0TeyYP4lL2FIy4rI46SfVchhDmxF77HmquEKq/p1e0foCp2UVpnzM/rmStMJ6/LQPEDiwGOLsxLRUQaDGdZnq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673249; c=relaxed/simple;
	bh=JgZx//+JX/NvX7pYzi5sMXhKCz3gM4R3Yfx7u8F6BAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeuM3XPW13gARv6Q7Wg2WUSDmGO8b9Hjg77D7nomfTrRLnI8VtxlhqwKKr1cS3E6Iv3azHez7CcwQHa7PrOsIxA/vBuXk0Bz/PTFcVx28xZ9chIlzJRIy+KzYUR/6d7KizUlSejUI4IW/bIFwcWRTnX4rva+AP/rs1LC8Gbvqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zw+Z+dRU; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70a9f15f15fso48003246d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755673246; x=1756278046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u5MXp9JyFotwMMINbfs6v2Z1BHSMBouO3FvidPy/j3Y=;
        b=zw+Z+dRUg7Z6wvXHpZkIYh1DwWV5sn7EkI8qV4+YorzbhGPVQBBs57umf0kHQ5ZyWE
         KL4L7K5+WgG/BtgtAE4chc3u4RkWyHalyFuwadNq3VfXAp9etBfIk2ZcPWKm7Ae4jf8u
         c1vK1QLoRjvpNJp3m4On3dyhwGcXb2pzhsy8xwlmn89bByIvpNFGHOY89daZ5GODxgjD
         VZpsVl+/+LleFQwE9XGDyI6zFFgUaoRUJYjTg2vCICaHRUyBc9aUGovsuqqtqNTqXZRq
         6dBDJ1yZ6PQcqb5BHRK4iWnkwNNOkNNHn9XzHTiQJeW0hThQLiAVcwPcNkEGxzFKSmTw
         0D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755673246; x=1756278046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5MXp9JyFotwMMINbfs6v2Z1BHSMBouO3FvidPy/j3Y=;
        b=EAFK/KDqtjssQbWGS+YGyvovDp3LkL7gGpzrtbIDfew8A0JY6WZynHkVbMiAq6CVRb
         7SouVcKKxNN47TDW6HYLX+rp0llMQuxREMLNM7twkIZrzC6ifQBUyMta3i36CObq0b+p
         MWQzDNDtuxDwgFfZ1kFgzVOBr2ZBWwdkKhmyI2gFOOEqtWtZAwVmCC/9w2SsAJoK2+A8
         fEtj3N8UxlnYeKkmFTx7W/MsQSAMz6qx/f7vcEdC8Bj6PofvZyB9ter1nSDP9bPc1yn8
         d5wNeWOLiKgs1zYl6IRu1D0s0A4Yy71JqxCEPuOWSll6nQdX/dO8ZwUaERADF72EhKza
         03lg==
X-Forwarded-Encrypted: i=1; AJvYcCXT6hyo+UGCMT3WWzb8AigJC6Y0AiKhZsg4FGJX3/zi1N4mns2e4nNBL7QxtfQrRb3KG2W3fetmKfsp+bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDenaXqs1vVJ2XNESRAGZUapif/tzy+/U/n0eETErCnl+reZ6r
	w8idL7eOXGp15ho/zmy5So3hWqEI7Ghc9i5oW98sQ4dMdXxdwdERH8wWwTmrdFE6GBeBPSlQMzl
	WIZ4OFWAYIXAzVskqLnaAF3+J90TKUz/5b+RVuY07
X-Gm-Gg: ASbGncuZsteX28tk2rT1zvA8b+Bvfq5JgKIN1paVjwPn8h+XV4vFgLtP3+a3aEdtilN
	pjhwzgV8eZyNUYlGzNabnv1PWEDb+ZjsGIQ0sxRBWOzK3Ti/xGR7VHfVYhUJMzUY4Q+3svn4FHL
	wok8E0o/Dcn+E9N30bFYUXGZfBnWSu7dvITubqtNFyDBsTkcPrsydTXxZ+Co49lnD7ZaCzF3+VE
	wtVwdl5QqRCrOHM346E8gY=
X-Google-Smtp-Source: AGHT+IEaNj7g3xBQp7yJ9yP4K9LS9/XwY2kmIYOQAexR1VKhonhH7w60cD5Fi5R3e8C16a6FRX0+kY76dQ4puI5u2s4=
X-Received: by 2002:a05:6214:1d08:b0:707:71d9:d6e2 with SMTP id
 6a1803df08f44-70d770bab69mr18978166d6.38.1755673245970; Wed, 20 Aug 2025
 00:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818192800.621408-1-briannorris@chromium.org>
In-Reply-To: <20250818192800.621408-1-briannorris@chromium.org>
From: David Gow <davidgow@google.com>
Date: Wed, 20 Aug 2025 15:00:34 +0800
X-Gm-Features: Ac12FXxd3klZhYlo4LhB2LyHVBqmjyquZ57JOfq-W3BwJ9aqaYCuMa3ZIBExzoo
Message-ID: <CABVgOSkUT_yYqBvk2-+OozKEBybj-07mcRAVECNYQiw+1P67eA@mail.gmail.com>
Subject: Re: [PATCH 0/6] genirq/test: Platform/architecture fixes
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000038a999063cc68897"

--00000000000038a999063cc68897
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 03:28, Brian Norris <briannorris@chromium.org> wrote:
>
> The new kunit tests at kernel/irq/irq_test.c were primarily tested on
> x86_64, with QEMU and with ARCH=um builds. Naturally, there are other
> architectures that throw complications in the mix, with various CPU
> hotplug and IRQ implementation choices.
>
> Guenter has been dutifully noticing and reporting these errors, in
> places like:
> https://lore.kernel.org/all/b4cf04ea-d398-473f-bf11-d36643aa50dd@roeck-us.net/
>
> I hope I've addressed all the failures, but it's hard to tell when I
> don't have cross-compilers and QEMU setups for all of these
> architectures.
>
> I've tested what I could on arm, powerpc, x86_64, and um ARCH.
>
> This series is based on David's patch for these tests:
>
> [PATCH] genirq/test: Fix depth tests on architectures with NOREQUEST by default.
> https://lore.kernel.org/all/20250816094528.3560222-2-davidgow@google.com/
>
>

Thanks very much. These patches all look good to me, so the series is:

Reviewed-by: David Gow <davidgow@google.com>

I am, however, still getting test failures on m68k (with CONFIG_VIRT=y):
./tools/testing/kunit/kunit.py  run --arch m68k --cross_compile
m68k-linux-gnu- irq*
[14:54:23] =============== irq_test_cases (4 subtests) ================
[14:54:23]     # irq_disable_depth_test: ASSERTION FAILED at
kernel/irq/irq_test.c:53
[14:54:23]     Expected virq >= 0, but
[14:54:23]         virq == -12 (0xfffffffffffffff4)
[14:54:23] [FAILED] irq_disable_depth_test
[14:54:23]     # irq_free_disabled_test: ASSERTION FAILED at
kernel/irq/irq_test.c:53
[14:54:23]     Expected virq >= 0, but
[14:54:23]         virq == -12 (0xfffffffffffffff4)
[14:54:23] [FAILED] irq_free_disabled_test
[14:54:23] [SKIPPED] irq_shutdown_depth_test
[14:54:23] [SKIPPED] irq_cpuhotplug_test
[14:54:23]     # module: irq_test
[14:54:23] # irq_test_cases: pass:0 fail:2 skip:2 total:4
[14:54:23] # Totals: pass:0 fail:2 skip:2 total:4
[14:54:23] ================= [FAILED] irq_test_cases ==================
[14:54:23] ============================================================
[14:54:23] Testing complete. Ran 4 tests: failed: 2, skipped: 2

Looks like __irq_alloc_descs() is returning -ENOMEM (as
irq_find_free_area() is returning 200 w/ nr_irqs == 200, and
CONFIG_SPARSE_IRQ=n).

But all of the other architectures I found worked okay, so this is at
least an improvement.

Thanks,
-- David

> Brian Norris (6):
>   genirq/test: Select IRQ_DOMAIN
>   genirq/test: Factor out fake-virq setup
>   genirq/test: Fail early if we can't request an IRQ
>   genirq/test: Skip managed-affinity tests with !SPARSE_IRQ
>   genirq/test: Drop CONFIG_GENERIC_IRQ_MIGRATION assumptions
>   genirq/test: Ensure CPU 1 is online for hotplug test
>
>  kernel/irq/Kconfig    |  1 +
>  kernel/irq/irq_test.c | 64 ++++++++++++++++++++-----------------------
>  2 files changed, 31 insertions(+), 34 deletions(-)
>
> --
> 2.51.0.rc1.167.g924127e9c0-goog
>

--00000000000038a999063cc68897
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
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgkSw4HrLMDzxnpcHN2qb8P9SZFrqm
6XehTT2lDAaZiUEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
ODIwMDcwMDQ2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAUNZpd1xLHSbv9+eOD/lY2YulBl2v+nigjnFKc1rV+/W3z4vG+QCe8SR8DmAiXLQo
/EfIp+4xuyd1UDTK37is/S1auCl4W+9E/WE/gvmOprODr9pwxOYedlOxitLWCicuf+Xy5T4Y92ry
M89eupGcd2ISmd/29UeWTgfz4fvsnK2QN4o/8DdrKG/0A9xQLnpagKoTRvocWFLu9BM/IXAAqZ9/
bBh6hbwEERmfS6tbzuZqcN2xDFw6A7iWBDvi6LUvVdt50X740Ml5RN3wrf37kgcI6Vsq0kHy8Npb
32ioms18+qCzIDUYCBI9dADkXT9e67w7+MDtJUigMuSO6x08XQ==
--00000000000038a999063cc68897--

