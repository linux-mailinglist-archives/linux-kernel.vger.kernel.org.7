Return-Path: <linux-kernel+bounces-889262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF2EC3D1A2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DC93BDCA2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093E3350A3A;
	Thu,  6 Nov 2025 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bDVg6pmE"
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E533328E9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454740; cv=none; b=LLWKOQPIfCzOfdxYaDs0Rn2PSbnzHH0DEbnmYoMkxDMHtWuhjA4WNlJLyYJ4woEM+9kGELNkjWuPK18yVOgsQ6+NPedTWkZ+VNwimTcLtnMO/Qk+JCl6f0N2XV2CjXlqpM2p0ZGb9w3+1ZE+AaJsfSQ/PT9Dg30vXZ6lvl9u1N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454740; c=relaxed/simple;
	bh=wL04idov3C1j//8MgXonXXolKP1PcR8MESxIzdHVqzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9lSC4diFq1ERRqJiX+YhEE2haidzJnYbyPrgTjiq45uYQZqqqIVIWkm7T+VpHlc/R1YNZfhvUZcxl02h3Abjwff7NHkDv9uTgekSbgjTlrj41nLBbKcTA2OQW1zKrQyrTESPzNMpY4/LiP3YnKuEK8jWuz743qP2exK1Ay7TA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bDVg6pmE; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7c69476dd8cso828827a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762454737; x=1763059537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Py1PlnTn5SijR/zPM+93egBEgJZtZKSgm6sjrGb7uLA=;
        b=d+jSfRlLRmzsvl3AfNZXmKlwbx2+m7TeXI6Pl+4ZoDqhI/K836TwGIryDC5wdE1TyX
         YMMzvqpLJboOIwIraa9em3tMcI4oIKEIoCVV6DqD6/MdXEjKoMz28+14qErWlN8353tS
         Q95XUgGPk6QV7BP2rASpPAnDXclmwYqyCRpp5K7x9YkOS0nC8asQ5Q3rKpgqNDFG1Vqr
         c14soj4mOjsFpRTJPWUqmUlvbRxsAmffHyh7FE5ROWnvNzd3YyQlvaYmvMBhvQVYPUfP
         kqlun9/P+SkQyo1aNgCdMozQp3BE09QY4BSIsu6E0EJTOLR8XqTkPEYWi/J45uWC2XXl
         Jx1w==
X-Forwarded-Encrypted: i=1; AJvYcCU8RV3ZgTDb3hp/A9P4jBCJDSHvOiflSWsdL+sovF6qreQ9A7/p5fgSmqpCRybfzVfFjELE0cyHSESak5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9au2t8Oo8i9eDYpN4wPaI8jAU32fg+2PTzvlgZL51+JQWUFy
	Sk9YWQiNDXlfWmxbd3TcroQKqXMEkKL3SrSz2OTkpbRM+6+9vyA5dO34JtgV9Ors+WNUwdpY1TL
	Nn4afT1USIgRTB/oedPqQu76lZYCThZOJypFoxZmLC6W+j4ZDZjAPYL6F4N4TuM+3YnKhP6Jezs
	tptaFKYNoDCBf2CWpKNTHBpjgeKk2NIUwL2t+I3xrOhQd8r36VJ5IZQevdkbIGUKEQanxk9NQMS
	wKYyeFVmjggVhNQ+dE=
X-Gm-Gg: ASbGnctIvcxFREGpWayaWTmbmh+RhXEr/X/i/3G5BbdPi3J+Vxdr5raBcZs7VQvbfGB
	ntg03aMsh7SAqPw8bbmWDOknAq20v3wqA0gvvFUIU7j7M13OtMS4WbkPKVC9vXEZ75A+lUWOTUa
	iklG2OQoKAOrdp3jASQWD/a4bP+6ye8wwmuakyu9OSjavrKolMgyOA6PsQ3g6j5DNl5nUKRwreJ
	lIitpBWTyG92rGudWD7BWyrvxL6WB1L7Ixy9Vt1q+hCdhnkV4/un7NCV5wL23sjpuzJE5ROYvqb
	kdXBLbVUu7uezBGlDMsQBzgMrGK4YrSEN6Xqghnr+P4Utwp9D54R8RmEtZQfWLxRrUVylsVdfda
	7jG4/lVoOe2kiAt9qq/vt8zkXHbb6cokm08yFHEJ+tiG5jVis5eZjTOEhNZE50VXauqPAJhFsSc
	/omboFd0j+2s1tjO6o1WZObrEwRRvzHkbUDNiy
X-Google-Smtp-Source: AGHT+IENvJsIlWSQ4hfg/icNTfieG8denYrIET8fULJ7tM0kVRuCH6UpLWLQm1BeBILGG09pmkS1D/QnjTC0
X-Received: by 2002:a05:6808:f11:b0:450:1179:5f46 with SMTP id 5614622812f47-45015d78cdemr241770b6e.16.1762454737407;
        Thu, 06 Nov 2025 10:45:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-656c550f2f2sm198500eaf.0.2025.11.06.10.45.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Nov 2025 10:45:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b727f2fca77so294367866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762454733; x=1763059533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Py1PlnTn5SijR/zPM+93egBEgJZtZKSgm6sjrGb7uLA=;
        b=bDVg6pmEJFJBWhdv+1E1j1t3ihwKP9efWbQEc5jrPtpS30AjMwUFMK0wySrGtBQJUj
         9ijZyrgoKGR3NAumfyZ3X+E84K7ymKJKY/KPws4UMPxN0ZJwLHFDjX9ZHxULi4k/shRp
         FSGkzsgF2jfbyXasG2OmFF7XRhly0z+6qPT64=
X-Forwarded-Encrypted: i=1; AJvYcCXq8xhBtYhs7A9iaWdLkYbnHvl3dnG2GDVR+oca84qwssYXdfKU3czMvFtBhTYRZay/Qq7NNZc71n+gdTg=@vger.kernel.org
X-Received: by 2002:a17:907:3e28:b0:b70:b52a:559c with SMTP id a640c23a62f3a-b72c0ac2ca4mr22701866b.31.1762454733488;
        Thu, 06 Nov 2025 10:45:33 -0800 (PST)
X-Received: by 2002:a17:907:3e28:b0:b70:b52a:559c with SMTP id
 a640c23a62f3a-b72c0ac2ca4mr22697966b.31.1762454733028; Thu, 06 Nov 2025
 10:45:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
 <CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com> <4abcq7mgx5soziyo55cdrubbr44xrscuqp7gmr2lys5eilxfcs@u4gy5bsoxvrt>
In-Reply-To: <4abcq7mgx5soziyo55cdrubbr44xrscuqp7gmr2lys5eilxfcs@u4gy5bsoxvrt>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 6 Nov 2025 10:45:21 -0800
X-Gm-Features: AWmQ_bnSyz4OAISXJ-B8AY-OaMnl3-mHYoDzJbS-SHQkGHb0O8Mi6IxVgV_b3Pg
Message-ID: <CACKFLinyjqWRue89WDzyNXUM2gWPbKRO8k9wzN=JjRqdrHz_fA@mail.gmail.com>
Subject: Re: [PATCH net-next] tg3: extract GRXRINGS from .get_rxnfc
To: Breno Leitao <leitao@debian.org>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000582e250642f17886"

--000000000000582e250642f17886
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 9:06=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>     tg3: Fix num of RX queues being reported by ethtool
>
>     Using num_online_cpus() to report number of queues is actually not
>     correct, as reported by Michael[1].
>
>     netif_get_num_default_rss_queues() was used to replace num_online_cpu=
s()
>     in the past, but tg3 ethtool callbacks didn't get converted. Doing it
>     now.
>
>     Link: https://lore.kernel.org/all/CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaL=
ZOons7kMCzsEG23A@mail.gmail.com/#t [1]
>
>     Signed-off-by: Breno Leitao <leitao@debian.org>
>     Suggested-by: Michael Chan <michael.chan@broadcom.com>
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/b=
roadcom/tg3.c
> index fa58c3ffceb06..5fdaee7ef9d7a 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -12729,7 +12729,7 @@ static u32 tg3_get_rx_ring_count(struct net_devic=
e *dev)
>         if (netif_running(tp->dev))
>                 return tp->rxq_cnt;
>
> -       return min(num_online_cpus(), TG3_RSS_MAX_NUM_QS);
> +       return min((u32) netif_get_num_default_rss_queues(), tp->rxq_max)=
;

Isn't it better to use min_t()?

--000000000000582e250642f17886
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCD40ifL
vRDEeOqKobmTFJYOYbGVfo7IhIlgD1BtYZ2RTTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTExMDYxODQ1MzNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB7Q5tcoKnTiiWm+ddm6NsFaX6Xd6ZPZ6OWdTBehBGs
b+o6RHQRxO1ru6csJgxfhhcZvV99BdqASzu57OtwxHbEanFTxdbB9FMW05pYTB1ZWy/gltHFweBz
WF00g23DjlGHq7Rd1W6gKU6Vli8LfWjIdM//pPsFHAK8Z0MgGejS2QDf7m/Ysy7FFa4kroHOVePR
IASJ5JqA0O0zHhj25rximaaPrZpJ2cylQOWwv9u7ODfNcipz99FsapTuLsdpA1Xj8QXOnFSJCQoK
TdMzmPjGaZ7x/MSYj74IbGBwSVR/dsd8K6G5ul88OdAxSr3mxqnbtyE+XJiclcSHs2oaKQyD
--000000000000582e250642f17886--

