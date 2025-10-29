Return-Path: <linux-kernel+bounces-875314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF4AC18AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6471889F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348B13101B4;
	Wed, 29 Oct 2025 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eACSAdU5"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843223101B8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722355; cv=none; b=mBUxAlOdRwrQuwXaWOKWT+hD+QvoCDzGeDMxKUvzf+BRnKnyqN+GhCzy/Aq+K6MOZ10zxuC9JpDc0TYqrYE5iFFl4cFHNAU4XQOftyUn9DORAIlki3M607LyhysZwCAFH6J5SCWyd5dfHGE7oZ+kb3XU16Mt0feQ2FoR3NXc5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722355; c=relaxed/simple;
	bh=cedvYyov2tcGmR6qnU20vC+0uDof1Y8XOy6UjtwqA0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLL0vn0iuaohx+uDCjryyg6jwi5IylMXfgkbDySJbYF2p8JpTKJpzD7HKwfz+QG/GOYiGC5w/4eWUj3ST2JtPBwYaOHrqQCdukIvsb9NZfWoMkSM1l46c/hVO17XUbccBj1ICVyTPZQec32ZKXN46hJyKG/pFFs04rTY+C/mLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eACSAdU5; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109c6b9fcso62424631cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761722351; x=1762327151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2zOZL3RJrr/s3WzTZRYhpIvHJsTIDHaUxkM5RcoC+F8=;
        b=eACSAdU5VbARxLMIEeRUNxQRE76KvIqJDKEeCVi0c6Hzk9YUjLZjhWpUEm8y3YQBiF
         ZgCGqnGwJ3/MHLzCfWyGnUHUQChwQkFBwE38TBZe1V0V/77NHxS+MeK/BgsXeFYxlBHD
         9rOqMPjAJgdVUIQYMWAmuoCWH8EEzCeSUlVRIym4QdyH4gFhx5/y9L++YlIUfuzA65GJ
         frIdWJBfWfypt4VBo1ZmK14weSeAfceZcNXUUJQHYzHd02zR2tpRNIip2xKwR2JprL9Q
         MlJ2sxLr6AqiEdKrudYSD/PfLfrFJxyGd9Hx7ARw9oj4Z3GzzE79xLiJxtAVw1UdMmaH
         uKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761722351; x=1762327151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zOZL3RJrr/s3WzTZRYhpIvHJsTIDHaUxkM5RcoC+F8=;
        b=hWB9a/u4XsOI7XyEDfxhgJygBAH8WVMD3jJo8bk+yVimFVlRpkZsFuZdNrdnZOxO2g
         ex3GmfuXJ8kJTzre0rjqYcDbXX3gmHa28K+S3DY/iKBzAG3m20yaGVfXh9jT5pRB1kCd
         Rj6SF4DZDXm/sR0yeoCMXdk9Lo2gQYaQpk9eCgDSkmE0oQqfNW5yNVPEyU+TMQi9S/yk
         VFCrW4Dke3mlTa65FyL3A2SIZj50Ls7ZpeU3e6k+ZBGLqdOVqJWg1Y2u5e1jPeIFm2oq
         GiwetF9Ir92Ln+Lw4Xzu4nDsR8YzoBvyuPTwyfwweuX8bP8464NKdztGwMtRQ9SOuCld
         XIXg==
X-Forwarded-Encrypted: i=1; AJvYcCW1jYZOrx4QZvn/4stcgOUBfVWeqO2jfXpnCBPAa2ZYMkaWpOMQqoL1M26mkNazgSpa451XbaPwoyyxx8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWtfN//sj/n4LJYqKdqaiG8nHVyHIgkINP68nL7d0mjawdaSSJ
	bEquvkimmhfZ2NM4ihTwun+yrn/loeIITgXZ0QO/G05ghCpyAP8BSM+DbmhDLFkoDwyZjElJbVB
	91r8cXv3YuUm6FEB2bssIfTw0Sx/lEdroWR4Xh/6Q
X-Gm-Gg: ASbGncupGME/0jlyUOYOXvuWtjDHGOB8Z3uepaGu54SsWMcdMlyKfEPgmoM1TfbQLsy
	cMIvgSKR4Cu0EspxQmZFT8rRhtxzkCO+q8LknanoYz5nHmrDn9A3KZM+e5uRpe0+mOrDpK4+LeO
	2XBuCeCQt3vVFBTTEbQDPY+TAuzsvsI6Vd2C49r8cL5AYVCbh81WauJahXmt1m1t8NRVWztQN4w
	i0+amRjr/2VIbZyZpI8WGWZBTKzg86hknfH5C97BD0h50VWq3IBd8WcXAk=
X-Google-Smtp-Source: AGHT+IHI148acDCimWuVD+Km0fo+iTwtMWXrZKUB+ozD1xZ3t+wOh790x81KtTxlq9Q0sbX44yANCHkoFGeEQ6u7ZBU=
X-Received: by 2002:a05:622a:5807:b0:4e8:ac1a:badb with SMTP id
 d75a77b69052e-4ed15c57cb4mr29054081cf.74.1761722351174; Wed, 29 Oct 2025
 00:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028194010.519411-1-rmoar@google.com>
In-Reply-To: <20251028194010.519411-1-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Wed, 29 Oct 2025 15:18:59 +0800
X-Gm-Features: AWmQ_bl5wmtMiRgwYu11TxhCrJ94J9yU-PRKzbSgF3T5Ld3-llK8KoYcYzIaI84
Message-ID: <CABVgOSkxLKkT7+sa53x4dUsCiG3m=uGmrd9ko3GwjnwGPmonfQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update KUnit email address for Rae Moar
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f7e80e064246f2be"

--000000000000f7e80e064246f2be
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Oct 2025 at 03:40, Rae Moar <rmoar@google.com> wrote:
>
> Update Rae's email address for the KUnit entry. Also add an entry to
> .mailmap to map former google email to current gmail address.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
> I am leaving Google and am going through and cleaning up my @google.com
> address in the relevant places. Note that Friday, November 7 2025 is my
> last day at Google after which I will lose access to this email account
> so any future updates or comments after Friday will come from my
> @gmail.com account.
>

Thanks very much, Rae! Best of luck!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index d2edd256b19d..2fcf7e4a5cfd 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -642,6 +642,7 @@ Qais Yousef <qyousef@layalina.io> <qais.yousef@arm.com>
>  Quentin Monnet <qmo@kernel.org> <quentin.monnet@netronome.com>
>  Quentin Monnet <qmo@kernel.org> <quentin@isovalent.com>
>  Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
> +Rae Moar <raemoar63@gmail.com> <rmoar@google.com>
>  Rafael J. Wysocki <rjw@rjwysocki.net> <rjw@sisk.pl>
>  Rajeev Nandan <quic_rajeevny@quicinc.com> <rajeevny@codeaurora.org>
>  Rajendra Nayak <quic_rjendra@quicinc.com> <rnayak@codeaurora.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46126ce2f968..eefcff990987 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13601,7 +13601,7 @@ F:      fs/smb/server/
>  KERNEL UNIT TESTING FRAMEWORK (KUnit)
>  M:     Brendan Higgins <brendan.higgins@linux.dev>
>  M:     David Gow <davidgow@google.com>
> -R:     Rae Moar <rmoar@google.com>
> +R:     Rae Moar <raemoar63@gmail.com>
>  L:     linux-kselftest@vger.kernel.org
>  L:     kunit-dev@googlegroups.com
>  S:     Maintained
>
> base-commit: 9de5f847ef8fa205f4fd704a381d32ecb5b66da9
> --
> 2.51.1.851.g4ebd6896fd-goog
>

--000000000000f7e80e064246f2be
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
Dxz3AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHZtY3XkWtC2
e2Idfk+0JyK7BLzzMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBo
hqjbVaHxZoT6HHUuwQcTlbgXpuVi59bQPrSwb/6Pn1t3h3SLeuUCvOYpoQjxlWy/FexsPW+nWS0I
PUmWpt6sxbIRTKPfb7cPk32XezfnA0jexucybiXzkZKTrbI7zoMOzDIWpTKYZAonB9Zzi7Dso4An
ZOtz/E3yhdR/q1MK30d5fiCS0vorEd0Oy8Jzcc7TJ2HGMzEEXiFFvVrJYJHvfYOeXE4ywAG6YWO0
x78+bXeB9vkeWHhOYKyYXuAXrnHASddEICg1QlJCHDAISMC1Wn/tjqTMTt3sDAe+dhi9V1FEGTbG
g9PxPVP4huJEMIBu/MWNMzHfiW4E7eCHVPrmtX7CFDlMik7qsgQBbO5h6EcxBamhIflfMgoISsRJ
Vyll2E5BNVwkNstMgU3WMg5yIaQcuGFgFnMTrQcaLEEFPV3cCP9pgXovYDirnB7FKNdCZNHfeBY1
HEXJ2jIPDP6nWSbYoRry0TvPgxh5ZeM5+sc1L7kY75C8U4FV3t4qdC+p7rgqfAggdvDPa5BJbTRg
KAzwyf3z7XUrYp38pXybmDnsEcRNBIOEqBXoiBxZXaKQqaY921nWAroMM/6I6CVpTnu6JEeQkoi4
IgGIEaTFPcgAjvpDQ8waLJL84EP6rbLW6dop+97BXbeO9L/fFf40kBhve6IggpJSeU9RdCQ5czGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAYQLf/BIzLow9kWqD8My
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgMjse6Hiapvh8wSBBhXCXNSfFGOBN
PwoIq2TvrrdLEfQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MDI5MDcxOTExWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEANLJYgQKju1G/cQVJ45ARrLP6hpEmMCVs+GScW3homwVYLQmXA1RA+Tmcbsm0iuQ+
LbtmUzi0fp/7xitFtXkSwsEgEdiTRm6v/oSHE3wbwg52wWwaqNzGsBRZV+T/xYgLEK9zJhjXznRK
0EgiEnvw4OuSiXd3bTmT8mKpVO8McwiTVLpVcIenjyUNnYG/PdSyZINiEXAH9feDAnsSAlqDwFmg
1OICkIAJPwmHXWmxPzlI9RHTiOqYXX4+sQXwJrMGJDOoopRxrtBfKs8F56sYABGjOQxmye7qRMcp
TdHPVDmBXXVQ6LgY3UT2Kh9ln9FfUwUozoPegvj2tYJ16HPvDA==
--000000000000f7e80e064246f2be--

