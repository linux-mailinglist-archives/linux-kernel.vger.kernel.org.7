Return-Path: <linux-kernel+bounces-751579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C63DB16B10
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B26166E94
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D500A921;
	Thu, 31 Jul 2025 04:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMId3qxJ"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D423C4F5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753935255; cv=none; b=k2VkBENpkPjgMKb4CwUh0Yg0LJp5Nob3yooOmmrzqK8qKrxTg4cnQhnJvYjDgjmnIc4xQYb1UpKB2bftmb7nrBSM02IStLD2SDaszVwypOU6Cy1EVLqzYFxiDIZJCCxfIEVPWm+URbZqLa4ALXOQy7UD2Oq+1cX3nrBhWzIZOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753935255; c=relaxed/simple;
	bh=Icj03AD5seioanKrMUbAeBVkd1zAZXAVe4I3lLzCEEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uduRM7wGiRLnODh+nEoI+j6/sRmJrIdHiFpqDzJFlyG4d3Lvy3SJPaaSoA2+p+ZtI5wi6rfmBCVleYsAK7DD5k5hmTpEKwDLnIj7Q/MElLbLH0J8gvrVT26y8XA+QuvJDMzz11X0AONOE03Wd5i5gCLGHbElc0ETNzSyyGBf+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMId3qxJ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70756dc2c00so7189996d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753935252; x=1754540052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FkXa1QoBxz81nIPQCQSgYxjpADhMZOjUgYthmsvt05c=;
        b=PMId3qxJBKugjfN+vOc7hmRMx/OVSu6LN7u3GlhbZW+7PsZmrW1w5KY2U3pB/FVTYV
         HERS7HIJuj63zEVaUmeLCbunI2/Tx5FndQTV4Llbo0DpFvZuHsFrVpkmYnBYZNeETD0f
         jOCAeRXjChLMtcqJ3LhRSla9Zv/fSKH2HMAGZa9VgomI/6GmZpUb4X9fYs29rHzeWG9M
         5DZ0QaCG0X/sFAM/J9evRpW5NF7+CgH/wRTUi9ThbUpslwiMrDFbrK96toaUgMgRvzWq
         H3EF8h8mpgNGomgHMHrzQQvewfCc29YjPjaYdWvh5btP32rfok0W8FpAVTN7uEkXxhEM
         Lb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753935252; x=1754540052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkXa1QoBxz81nIPQCQSgYxjpADhMZOjUgYthmsvt05c=;
        b=BYtMSkmoFe+8HslSmSKpjSgUqOoEuf4Dghh14HAeTtv1vfkmwzRFF4m8DmO/3XnaQd
         0KaFzO7WG7iqMAVS4wJoxhFoDZnf4nJf81sbETUZpdeHBB8CTcqoO714mBwX7inwBLGh
         Ru3MrHGQRRY2hcTOqfFY9W+EFkwZVLC5/RjVHrIkrdyMPB+8aCL7FZVZ78HgRKKs/TGs
         ycn6SjjUYbw8cYPh/rRGrbkefK8K3vIqvg8z4Kosz32lbc9we6YNAHbb+lvJK+nUiO4u
         GKulkB4Kk90evWyd/dBNWVPinvr/EJsYTrUDe88FTEUz5XrvjtfTtPFDHdel9piF+aLz
         tKoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSNDULipEXfccGWdpIKujJIegXuC3psT0CDy8CSt7Ok3ZAbzpnz0yX7hfFZsYJTmPE/fblbse+TtZ33pM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2cubSRPbGNTRrlLLhjM12CLn9WgrCdnTrokKYykV3UGi7ttQ/
	+DW+DVmaWRUF+IKXY0tw8tCrVxmxh3M66ePBmoroILbIzCmNMEQgephQnu4+Rhq5tbDeUFqbDFC
	iwwHrtFeYT8qcu8DF8QjkUFmlhF8FFRji5DUA6/xo
X-Gm-Gg: ASbGnctNn/gCJ8xXo1jbeYiapu+5wAY6+seQqc0i6Qup3T5L6jOSrjj9sNIfg8Xw/x5
	e7vVzd6rdG3iWO1YmwRGKhRzD12xBqalaF2eR0/AJq8S7zoc/PEfAfL4dYUzl/zoryfEJ+IpyNY
	/5vBzg2WG+hwpw6+i6KgvC4HZNzsgYLCbQq/bj1+HXxbewjqG8+hOzYg51pMs6I/gaP8X7tmzJX
	wiXKf/aKJd/3Sgw0Bg=
X-Google-Smtp-Source: AGHT+IHb92ZyHe6Nle/sXeXlXWogl7E6Ff1tDac5ABqMKM/afHSHLsOK7my6IblQhV/BBGV9ZdGDvzlTbUaja4IDXHI=
X-Received: by 2002:a05:6214:27ec:b0:707:4cf1:412a with SMTP id
 6a1803df08f44-707671d1926mr73624666d6.29.1753935252013; Wed, 30 Jul 2025
 21:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753929369.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1753929369.git.zhuhui@kylinos.cn>
From: David Gow <davidgow@google.com>
Date: Thu, 31 Jul 2025 12:14:00 +0800
X-Gm-Features: Ac12FXxXXKz9xdPB3mHBANkA21ndZVcqaqi9D1gjsg-XvWpzx6dBHmcw30Ek3r0
Message-ID: <CABVgOSkphk7X8nKGePTf88RzW91Pb8NPAbryVvL=zQ370o62RQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] Rust allocator and kvec improvements
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	vitaly.wool@konsulko.se, Hui Zhu <zhuhui@kylinos.cn>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b358b4063b31dfc5"

--000000000000b358b4063b31dfc5
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 10:51, Hui Zhu <hui.zhu@linux.dev> wrote:
>
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> This series adds tests and docs for Rust kernel components:
> Patch 1 adds KUnit tests for allocator alignment guarantees.
> Patch 2 documents KVec::as_slice with a usage example.
> Patch 3 simplifies KVec test module naming convention.
>
> Both patches are co-developed with Geliang Tang. Based on [1].
> Tested on x86_64 using KUnit.
>

This series looks good to me from a KUnit perspective. I've also
tested it out across a bunch of architectures (UML, x86_64, arm,
arm64) with no problems.

A few minor notes:
- You should squash patch 3 into patch 1: there's no need to introduce
the test with one name only to rename it in a later patch.
- The link to [1] is missing in this cover letter. (But at least the
test fails nicely without it!)

Otherwise, looks good!

The whole series is:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> Changelog:
> v7:
> Updated according to the comments of Miguel.
> v6:
> According to the comments of Danilo, updated test for allocator.rs
> and allocator rebase onto [1].
> v5:
> According to the comments of Danilo, change to use generic struct and
> allocator Generics in allocator.rs.
> v4:
> According to the comments of, add the error check for push.
> v3:
> According to the comments of Danilo and Boqun, move KVec test to doc
> example and move VBox to allocator unit tests.
> v2:
> According to the comments of Danilo, updated the commit to samples the
> usage of VBox and KVec.
>
> Hui Zhu (3):
>   rust: allocator: add KUnit tests for alignment guarantees
>   rust: alloc: kvec: add doc example for as_slice method
>   rust: alloc: kvec: simplify KUnit test module name to "rust_kvec"
>
>  rust/kernel/alloc/allocator.rs | 56 ++++++++++++++++++++++++++++++++++
>  rust/kernel/alloc/kvec.rs      | 12 +++++++-
>  2 files changed, 67 insertions(+), 1 deletion(-)
>
> --
> 2.43.0
>
>

--000000000000b358b4063b31dfc5
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
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgibTljknK2ZM/0W1D24+z3OOcC1eG
ZZh6V8+YidRGid0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NzMxMDQxNDEyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAeO4Pw9dNwqGyQsmhbEvDBlXnWB1CSLPKVGsAbyLNMKG+ZXSp4QW4jpcBMeYX6nIk
KVnDfD+Kq9ArwbYL+XcKDDO3pOX23fsSfrQyCpoPCk1koEg7OtxuVhjo4eiKJ+o9wX6ZDEm5aK1q
GyZsCljr7Sfy2+FQvQijLOsCWkQccWHOMiZw7CUu6Phi0xqiMKa0QqgupKubuFhTaLrEXTS+tUTA
qh+xu1XwlOv5rn4uUFi32MZyFnSs7IFgM5LpQxrBB7gHC962UQhk8YTleVi/giDU6+KmbyzjACln
nbAUL5bv/TBfHgilEOFPc98tOpSHO0Kj5CzVtJ+anNPy7SLm4g==
--000000000000b358b4063b31dfc5--

