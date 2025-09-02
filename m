Return-Path: <linux-kernel+bounces-796094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB3BB3FBDB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689BD172FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D237F280338;
	Tue,  2 Sep 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SLoFAmas"
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724EA2EDD53
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807723; cv=none; b=Go04HzwjCQa7HUMye2wOxytgXGnsq5CYoI6HChGeje5AlfegV/ZQb0T0UJ8zo754Qt2L7ZTII82aXjg6wrlZ4GwZnpLYNYoZIB9UdxtVupBSPYifq9eEEhblwk1BzIpjvjg5i8ypEYyoKvmQ2BBBgMPZcdTUASWeRW7mC4ctn0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807723; c=relaxed/simple;
	bh=BhUk989/7l1kvOFYE18fvkT3vOVdaISsdfIQctgGM68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkvMiMT9NW6z6LrlxP8Juxjg0Xd2EaOnEgvHVLdvWOWkd7EiSMQU9+J/lvRG/0h3EaYhL+JtOEFAP7NVqV3GUiDqrtLs0y/uRxwoZ1AaO1WD6kuFDrEBYTlwuBu6HS0TxxpEE/4E65tidkV749kCNDm5UpZEjqyPXE9FQIY04qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SLoFAmas; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-71241d44792so26749446d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807719; x=1757412519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UmCH1Yy1rqEOVFDE+rXQqYrH6TcQHQoJ1clsR5rUSYA=;
        b=PwztKZSb71OFB5353exF+bCAkL9YbU7KRO0Uyinx+oa4Psf4xM0Oe+yEB+uvHEiaFX
         aSk9EfT2MbqGPtqQRqAEydn0U+y1GzBgHhD6MKZQVYXpKz9f9hHPwzKdC0NjXQU2ewuC
         MHMoq7GVmzviIAd0vukt25h+w6ErUcHu7ym+3S4wHViSjgG8WSN7dziTR4K8Yit/DT0b
         YDAw6xDWuNzmUOxuMUih2EXZ8XmxvoHIQs+yghmJYdpMLTg9ZFu2uA63nwTBK28MTezT
         MzanwofM/OrXI7d/6hYGqm0VOHNUPdmfcoOKQ9CVwm8qJ0NMr8IfBkcvGihUyzJMaAf8
         7tUA==
X-Forwarded-Encrypted: i=1; AJvYcCXjakJKaM9NxbwDXLrwmDOtpdkEgZdnm8I1IYXxUoskk4KCFIRp1RJrA1gA2VrQGAqrMZmRdQIPxr0XtPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTTOqbELmxbMq9TnYLTSETVV3ult7DWT3iJ7Z460aDCQGiVn+g
	LSuuYWnIoMpr/1r7Gn6Yqmnsh5gsH0ee/FOFZ5FY1wR2TvH1urBQSQQLERXwfDCbzBbP2Z72kuJ
	it4gRBsYpnmhVo6vYV8cm8Fvu/dj3zCnj8nnLIXomV5Q+vZFtnPvrdml6M2whOjlz59fOwLVRtb
	9glbQa/cPacASi9NDDURXDV4mYUhJgEcwgtcVc7t8y6tMUYQSwrB4DOMXyyTvAuc7NryFZ3ALc+
	3ROWI4EAUn9oDi6
X-Gm-Gg: ASbGncvVpzxz49GZlYkiehGQ9U7dCB/5M6z/QH43sHB2CuEEuULPFNf9QMTPr8OXp8p
	LaB1vrYiw9TJO0u370u5bdLss18DB8vXnRO/z5Dd+LKRDZAmYbV5cFQLX4tm2gwehViHi87Tpti
	KAkKmcbOs4KQgCkC9TYSIQesXJVFE6hm8TdI1XGnw9DIzEBbwjLbuCoo/A8vI6IXpXi0BCEx0Cq
	MAiTze2cUnN7JHPyIBWj1y9jHXpOCNXzid00WvZFFOgbzAGGt3FXyYXvSppbNQGiAt45+ao5+I3
	Zgi7YSieNwwZOWs0D6Dxf++lcBYSmWdmkRjWGNJSGeb7iw8HHRi/HRSqL4YY2zlv1Z1raaOZgBp
	Gbkant8te0bMXLA0aNyU9PNz2uwRB+vkByA6AplJQ6oPwhQ0N6lAjTIc/Jo3Fh6quER2a58yy
X-Google-Smtp-Source: AGHT+IF8m+II3xk9lKpcTI8ZJo/y4jWYzLbosbyqcLSgq8+Li7WUEBr9np2YZg9r5OvXm6+xKFsLz/epS32T
X-Received: by 2002:a05:6214:1310:b0:70d:b315:beb5 with SMTP id 6a1803df08f44-70fac6fff3cmr127673296d6.14.1756807719178;
        Tue, 02 Sep 2025 03:08:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-720b3bcc01csm932496d6.24.2025.09.02.03.08.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:08:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-544b0ac7eb9so377994e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756807718; x=1757412518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UmCH1Yy1rqEOVFDE+rXQqYrH6TcQHQoJ1clsR5rUSYA=;
        b=SLoFAmas89p9PVlH5/pHqkLq6PxLU0yJjZL1tVaq0kdg2Vjl4hwYaFe/brgvmxI8qw
         TbvK1sscGCTPJawqK4lPco/Xqb+hanGDT938e3RotL/u6k2+ZmumKvW/7PzUSik6Lv61
         C8aGLf27NuDnxEFiztiegvb67Ci8mR0GdROcY=
X-Forwarded-Encrypted: i=1; AJvYcCVNjuNS9eFemlqR2WdvFMOpNP6jnGNI2/Ge7GOA7dMmUNj5B/n19SNNYJkA3LTluwhABwu+qQOCUBOmYl0=@vger.kernel.org
X-Received: by 2002:a05:6102:441e:b0:4e6:a338:a421 with SMTP id ada2fe7eead31-52b19534c68mr2533045137.6.1756807718605;
        Tue, 02 Sep 2025 03:08:38 -0700 (PDT)
X-Received: by 2002:a05:6102:441e:b0:4e6:a338:a421 with SMTP id
 ada2fe7eead31-52b19534c68mr2533032137.6.1756807718044; Tue, 02 Sep 2025
 03:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821110323.974367-1-ajay.kaher@broadcom.com>
In-Reply-To: <20250821110323.974367-1-ajay.kaher@broadcom.com>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Tue, 2 Sep 2025 15:38:24 +0530
X-Gm-Features: Ac12FXzRcQynGFneSwr3u3LMGdh8rUGfSYYsMLtnKHkHQr1Rvj5PZHOTc_Pf4L0
Message-ID: <CAD2QZ9YtE-cEFCu5-uEv4qs8UO5wAVyRPU5gonpR53DW=F8r-A@mail.gmail.com>
Subject: Re: [PATCH 0/2] ptp/ptp_vmw: enhancements to ptp_vmw
To: davem@davemloft.net, nick.shi@broadcom.com, alexey.makhalov@broadcom.com, 
	richardcochran@gmail.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com, 
	krzysztof.kozlowski@linaro.org, rafael.j.wysocki@intel.com, 
	Borislav Petkov <bp@alien8.de>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, florian.fainelli@broadcom.com, 
	vamsi-krishna.brahmajosyula@broadcom.com, tapas.kundu@broadcom.com, 
	shubham-sg.gupta@broadcom.com, karen.wang@broadcom.com, 
	hari-krishna.ginka@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000064bc2063dceac2b"

--000000000000064bc2063dceac2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David, It would be helpful if you could take some time to review these patc=
hes
and share your feedback.

- Ajay

On Thu, Aug 21, 2025 at 4:46=E2=80=AFPM Ajay Kaher <ajay.kaher@broadcom.com=
> wrote:
>
> This series provides:
>
> - implementation of PTP clock adjustments ops for ptp_vmw driver to
> adjust its time and frequency, allowing time transfer from a virtual
> machine to the underlying hypervisor.
>
> - add a module parameter probe_hv_port that allows ptp_vmw driver to
> be loaded even when ACPI is disabled, by directly probing for the
> device using VMware hypervisor port commands.
>
> Ajay Kaher (2):
>   ptp/ptp_vmw: Implement PTP clock adjustments ops
>   ptp/ptp_vmw: load ptp_vmw driver by directly probing the device
>
>  drivers/ptp/ptp_vmw.c | 110 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 88 insertions(+), 22 deletions(-)
>
> --
> 2.40.4
>

--000000000000064bc2063dceac2b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
fEfjRz/Z5b6J+pnCj2dzb2Wir3qx4rt1/aShjQasncmTZ0r8rOk2G3RmKolDmTmWPMeCgzL2KeQs
QRXTsKFFi0np4iUyWo+MDCofsswor1HkoXwlmoIAdrFL+cw3qvOowpOB0pe3+G1rWNvJvYsOAzG6
2a8X0kwMSTEGjJgAX+jQjqwdP8C4ZxmE7n236E9GiM8kfhFFAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF2FqYXkua2FoZXJAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQkdXtSp1Dzqn1C33ctprG/
nnkbNDANBgkqhkiG9w0BAQsFAAOCAgEAQbg6h5rEci8mKF65wFYkl7cvu+zaAia4d24Ef/05x2/P
WAuBmkkDNwevol3iJzQNwlOuR4yR0sZchzw7mXSsqBhq1dgSNbReQ0qJU0YWze48y5rGlyZvCB1Q
Z8FbyfrHGx4ZQJcjB1zeXJqqW6DPE5O8XOw+xTEKzIQxJFLgBF71RT5Jg4kJIY560kzMLBYKzS1f
7fRmy20PR3frP6J2SwKPhNCsXVDP3t0KC5dUnlUf/1Ux2sVe/6G8+G7lBCG3A1TaN4j9woYHN7Y/
U0LCVM46Gf7bFsu7RzwcrKtSOnfJ3Fs7V+IWCrTMvbCSQylAy3+BMkMGFZ0WwtXNLxbYIEhKAZmH
npugOtDKS6j4LkLxkHr/dTYZvfdOXZXTIlz8qTfkTKw4ES4KW3EGzfnRZCL2VD27/GAtt0hwPWrY
HL087+VQLA9RUVdfnigRjZOPWo//78ZaDd9PPWbLKqa6EIboR2nSV5miF9fQinDnxToBGplQEcXG
WwCF8syc/0n0xzLlb/IOwxmkzMizN/3/vVp5eGh64OGdhSwzZDBQuVS08Wgfd3nVHT6zh1F0jBgZ
ACv82jjjtABB+Tg1VZ0vcRr5ZzTC1WylB7ik6soemgWAgbrQfhNh0uHr9jq+NAbTA4wqUK6gA5LP
kPwzH0/UqVP+eM3EQII1r4Uiee8YifwxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgwc6GO95nPh0DhXVGYwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEILcQ
0Q1DO+Q3eXcf6awvPDyEPsgJWkBo4xt1qCTc/8AOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MDkwMjEwMDgzOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAETR07p8KX7gzPzKz13YK9RKSW+44q/0oqEGLOZG
M530ZxQ9S+iB6iuBTVPaiTVoCEBooDuCDBgOMCJS/Rp+T7DwUEmwygs+LlXePZ7z6Ep2bFkaep51
A2/ccFASrJZs2Ts4ZMG7a+sjYIN1R8zvmZNQPR5ROcyl6zPwvG4eGeiHe3sVi2BG0VcB2n9auJln
vIA2z0FXTnmJukiLELUdNQNNO3g57cyWpIQEaigBMveI6nPfZSLfCeO3/9dyiMDUo6+RvFWqOj9Y
LnTw0or6fwjAlq2moauYMnXEsjTWOHSXGAJonBR62u+ClwpVVYRXJBKEF09PA4QHAQErIFpH/gQ=
--000000000000064bc2063dceac2b--

