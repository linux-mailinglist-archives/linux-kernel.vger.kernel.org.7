Return-Path: <linux-kernel+bounces-764691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09370B22612
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CF94252AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADD32EE5F6;
	Tue, 12 Aug 2025 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q4VvRkDj"
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F062ED87C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998879; cv=none; b=QSbC5WJPsZzYUTFAUDYddtZYHzhRlSnMyr9sr8gRWF6ROMkKKZiwImkPr5EsK3K+bdnkRVw8m10NIpfXITMTYmDMD0ZCFcVl+EwCVRDZ5NE1RMwqPmnFXIBZ6MiQPC+x28h3g2rx6b3EXRz7BPZllD1TbCPB9e0D4r1sbBCIH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998879; c=relaxed/simple;
	bh=5yiaBxseVZCICZ7KcTe7duwmSRS+gzLWcgf/ITFnqXo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AjR+f31ZRTYBwBcRcgbcQT1F7Bw0nuh/JqnUj3HtxLf+Xo+PlYNwxzBRSFJfWxX+SstbR/C3XojP2Z/lgdwIGqrNFLeLEHAyWyV0UjZalx3yrsJmjBK5AgTkV7v66UQEzBlhdjjXWvIMPCC+9g6df9MyvXTZLBZ/cQ3OgRwCkFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q4VvRkDj; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3e40ac40940so25992085ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754998877; x=1755603677;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yiaBxseVZCICZ7KcTe7duwmSRS+gzLWcgf/ITFnqXo=;
        b=kFs7WYOUqoWEWbZ0Lnb/6IjusMf2ZZ25V0I/zpyRIqd4mGBKX3+wgW+gPxphrNpVov
         C1A4UtMC3P511lxXBTf4xk4fI6tUwecB2SI0yH2IdHBwiyX4bvamgV/paGTyTuQWV1dE
         UVlYoeZGLQs5uLF8Trg5Hz82Zl8eE8/8TBlXc5Kuf00FGDTXH203i9I0E4/SZIIeZ7Fq
         JbSG3h7k60wM+SO2pZEEGpkJuuC7Pd9XlMkqJ/lMczszaBDYGJfOV3XctCOAWm3iMZ6N
         GMSBjHIi/jXNVI1XlWtiQu76BK5KcbkfjfFH8GanA05lYVubyAghhUlkvZ1ePhnPaPfp
         9h4g==
X-Forwarded-Encrypted: i=1; AJvYcCWJF3Nbf3VCtTMY9nMXiZmsKY3LnxFQCRlTgGUJRdVmjXdFh6hte5KUpRFLSRm4Zw0Tcd0xD7LnrZhcyjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpb3kU9+oilHXsYTAvIdaZQgDBvPh6KHowpRKzY4/UZwTMn/3E
	sB6OUghIRIbrQZfX+AdH8m9CkKCLbns3sK+7kV7KpE0HtgbHPcyxVFU7BAVJ0a5NKnlc9R2fzYO
	hNF9j4Yizp2rU8wuRuG4hHhbIyzPRGavP+RBFu1DuxzO5tJxz38nm30ablNUI/6Kp1Z9i5oftmC
	4feoBFbVsZiZDM1e4U+0iiUFLWenoMsXaJkLLWIPF40bBEvMqcsb5ZR2vg8B97utccfKnPk8FZm
	IW8aQ5hMARmMUQavSwh14YT/KG02IiO32my
X-Gm-Gg: ASbGnctFLcEi3AGyqcXnCkgd6qE71OzcH1Y5WD1pfQy++AbIdRrwh+eClpzAB1N0buF
	aRIGOjdWEvV6/0tgCIhbcWYfpMBVLFbZr7bvlTml9i1S6+CGsHiu33DgLYiwgNmY1HLMhRCvdcC
	wzlsCUfsmhalVi3ecOyE8rznWhqkVBa8IuEZT/MA78F/WWfvOLHs/bnlvXGRTnVpI9gok1NiDKe
	FS6bT7wIX63M4PvdCkgNA5BHu7VohoTC2DqczJrO1yOv62rf5Y8YCZfvlFTP/9VMAFSoxCIyf6R
	LyqV19p8sKrdJbRrQyjImRQWYS+gepgehEqSshQMVpgSbadGgqxZ0k4mvvn3f1YyZTpO601jtZ+
	pqmVXWmHO/PkWSJdN05RVsaYKw5aGQ3SKkGvFBMOoWqS4e4lodiFKAXS8ryI/EZ6uX5eBzjVFT2
	fGGrBZjJBjfULpTUDlw/c=
X-Google-Smtp-Source: AGHT+IF1ZDEKu+JXj3hBKfXG1KhODpHyj+Dp22lKDtXJxvRAUrmn3fkKLg6+CG38+9CRP4zIV/OAClN1IhCz
X-Received: by 2002:a05:6e02:218e:b0:3e3:cbaa:e630 with SMTP id e9e14a558f8ab-3e55ac6df03mr50112095ab.8.1754998876866;
        Tue, 12 Aug 2025 04:41:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3e547fa42cesm5038625ab.4.2025.08.12.04.41.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Aug 2025 04:41:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-adb32dbf60bso491968666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754998874; x=1755603674; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5yiaBxseVZCICZ7KcTe7duwmSRS+gzLWcgf/ITFnqXo=;
        b=Q4VvRkDjzI0FPYFvWj76tbAqGkda8fMWMYRGmnM8UDvpJCdslPSYdc+t5+7JmYyB8P
         2weYV2w3+w3zSnPeuJWNyv+xrLd83mmhCkU36AXZ+hgVYZOioxF3g3LZIB987MpQfPNZ
         8EsYvCh9ma+8mO96AOY+iliaVYJaKVZYVqVuI=
X-Forwarded-Encrypted: i=1; AJvYcCUgpPEcXEyFr9DDOCidh9+XrJAW5WFxizhjXAM+dPivwiZJKjYbwB1odw1Rh0xwvYnEOn7ghieLWhiXbJg=@vger.kernel.org
X-Received: by 2002:a17:906:9f92:b0:ae3:5ff2:8ecd with SMTP id a640c23a62f3a-afa1e06dd64mr270664666b.20.1754998874092;
        Tue, 12 Aug 2025 04:41:14 -0700 (PDT)
X-Received: by 2002:a17:906:9f92:b0:ae3:5ff2:8ecd with SMTP id
 a640c23a62f3a-afa1e06dd64mr270661566b.20.1754998873556; Tue, 12 Aug 2025
 04:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Srinivasa Srikanth Podila <srinivasa-srikanth.podila@broadcom.com>
Date: Tue, 12 Aug 2025 17:11:01 +0530
X-Gm-Features: Ac12FXxlhJP1Z3vMi6WVactvzqgW1uzB317UtaRIvqqG5Om59dOYKSLkL3V47-k
Message-ID: <CAGhJvC47-ku9-72pDwVu_2iuROfLGchZVtmofWeJoN0wV7yBPg@mail.gmail.com>
Subject: Regarding linux kernel commit 805e3ce5e0e32b31dcecc0774c57c17a1f13cef6
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vannapurve@google.com
Cc: Mukul Sinha <mukul.sinha@broadcom.com>, Ramana Reddy <ramana.reddy@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007f845b063c29844c"

--0000000000007f845b063c29844c
Content-Type: multipart/alternative; boundary="00000000000070b496063c298471"

--00000000000070b496063c298471
Content-Type: text/plain; charset="UTF-8"

Hello,

I have come across the linux kernel
commit 805e3ce5e0e32b31dcecc0774c57c17a1f13cef6 merged into the 6.15 kernel.

Kernel Commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=805e3ce5e0e32b31dcecc0774c57c17a1f13cef6

Currently, we need this fix into the latest 6.8 based kernel as our servers
are all based on Ubuntu 24.04 with 6.8 based kernels. Please let us know
the process for the same.

Could you please help in this regard. Any help on this would be greatly
appreciated.

Thanks,
Srikanth

--00000000000070b496063c298471
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hello,</div><div><br></div><div>I have come acro=
ss the linux kernel commit=C2=A0805e3ce5e0e32b31dcecc0774c57c17a1f13cef6 me=
rged into the 6.15 kernel.<br><br>Kernel Commit:=C2=A0<a href=3D"https://gi=
t.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D805e3=
ce5e0e32b31dcecc0774c57c17a1f13cef6" target=3D"_blank">https://git.kernel.o=
rg/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D805e3ce5e0e32b3=
1dcecc0774c57c17a1f13cef6</a></div><div><br></div><div>Currently, we need t=
his fix into the latest 6.8 based kernel as our servers are all based on Ub=
untu 24.04 with 6.8 based kernels. Please let us know the process for the s=
ame.<br><br>Could you please help in this regard. Any help on this would be=
 greatly appreciated.</div><div><br></div><div><div dir=3D"ltr" class=3D"gm=
ail_signature"><div dir=3D"ltr">Thanks,<br>Srikanth</div></div></div></div>=
<div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_sig=
nature"><div dir=3D"ltr"><br></div></div></div></div>

--00000000000070b496063c298471--

--0000000000007f845b063c29844c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGhTCCBG2g
AwIBAgIMb8nIUMeKYCnZQneeMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyOTA2MzAyN1oXDTI2MTEzMDA2MzAyN1owgcMxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEiMCAGA1UEAxMZU3Jpbml2YXNhIFNyaWthbnRo
IFBvZGlsYTE1MDMGCSqGSIb3DQEJARYmc3Jpbml2YXNhLXNyaWthbnRoLnBvZGlsYUBicm9hZGNv
bS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDDNbEriwEaloGCny1+OPWSbbIk
wWF3v7K6oVgqedeUIaE4PPXKCDIsh0gaQMPeY8a2g7yuZLFHtlyqpco2325Aapx5NkCbsJVezIIn
Bf7arJVcwl1Tpw3Kq4dspUQX6pMi35RjNRQaUtXakdYv2BbXKpLa2nMwu21gn/PvzU+rqG6JrDPz
yeWQq/Xyu4yUeua9rjdEPR8aXyeGZolkp+GsboLqiPY3L8hw61wfp2PxjrLvJo581jBJCChbjMwq
3cHKcWEjcmnsDtqtrePY8copU4rw+JEzwJR2oJNxygXh8Q/o6vrXxoerqO40uaQpB5esrOC91NbR
KyLhyXczBfmBAgMBAAGjggHnMIIB4zAOBgNVHQ8BAf8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGD
MEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2
c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9n
c2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJBgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgor
BgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9z
aXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWdu
LmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMDEGA1UdEQQqMCiBJnNyaW5pdmFzYS1zcmlrYW50
aC5wb2RpbGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAAp
Np5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBRN465ckGjrhEe19Bejdn0W53l3FjANBgkqhkiG
9w0BAQsFAAOCAgEAgb2uVFeWXvkg7LnTZ33KzNofOqiRMDalPoY0fobp72Ul87LOi+EPCkaOvAd6
WDLHIIckXspw7WUPoystlRNBBo+LN87lioKh/42/UwQQu+2ciaqtJIdaMHyzoQEcbRCwTnDRFuOR
IOfGg3QDlXpSBKvX30EmliCynrArLuNPAegZMjbcrCBTUOelR0IMEtJ2Y9e/5H2rPNONA8u/akWu
LAk+LC2rj8GkYZj3mWYA++fr1Qzh/ZQQXI0mLMzbjzGTvjEtjrmchNHZuXvO2s92RCrO9X7qLx8g
6QviTa5Hai0OgjvkljKAU+2WGXiexb5p8GiwKuY/oz8ERreD+1pyUyBZ/ZRow+i5/zV84uvgvHfJ
h1SfynW57CCutqlt3UIC/uxqRqnWGnZNE1HuvU8Siv8Hkzn7GjjH5MXUFxg/sOosTbagrl65o090
b/CQWBbg0QFpujJgLOl0V1JtTkhZK6scekDw+gwLYNqok0g6QTBDe9N/V+hhg8PYJOKoRxIbpdcN
W2V8I9iVh1SZagCY4014+xAzPdQ1lFOHZDT3o2mSRlEGxb6S0ozYLTwY/13nDU5voY7y9w+d0AOD
4AU8cU+8mwNpiFCqJSKBaCTgymcOBsqEl37x/LsVT+akqeEIXssxqlJ8wViN4d5ohWXD1Ba3/rj+
Nf63Pmdvyu9dC7YxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxvychQ
x4pgKdlCd54wDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIC0ch4xxtymjHaAH1zxX
w9fOIQuWJ+ZOcDJbcwFfH+/IMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI1MDgxMjExNDExNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0G
CSqGSIb3DQEBAQUABIIBAK317Mjy7o9fjiRf3T4nMUlPsZOSAM5M6dNB4zTB95wD9kMdTRj66ktz
6wCulotQP95OXgKfjqmj6XZz4coijeYKAvRr4UI4FpwAKrLTx0BlO0Irx4oRoD2HXTYS48Q8sGHS
W60H8oaEJOhQiQqJC3HsdL2Eidlixc4AvyHg0FBOvvXe1yv240KXoUyBifwz3lBEnV9aH4GDW8+K
6enaTNX1xUZg5f+/p4t1Xpge5YiWDWlQkVLQbnLCKiYuIivCNzA6h3YFznwGVhKgqVcPZkI6iidR
iIw5rpq672HygVOoBnSg30YG/eFvZj/ctX+aeZt/xiH6MOscWLF/icVa5co=
--0000000000007f845b063c29844c--

