Return-Path: <linux-kernel+bounces-786982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6B8B36F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653B21BA2594
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99BD312814;
	Tue, 26 Aug 2025 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MLz6I1aI"
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3031A574
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224751; cv=none; b=WcEq7QMp4QGoj6LxITmjV0JN/vBxrdi/PZAxox8rxRIb17U+eBXDs5iO0HhGB6vjZYagepLlcAuLvN7FtY4zwKlBzS/izgT3LWDxGytX+D4qyvMQVd8nd9dpACUw8rINqKRvy3guuhyVJyR0jZ9vzTetF65lPRwiPj5vMj2LUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224751; c=relaxed/simple;
	bh=Oa0pbA0i6E5hM9mdep3/Fk78lmBFDXZUMcUj1Fu5hno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZfVcUbQLvedwEgM/dTQqIk1myjOHC/wx52a2nhVJkmkgWtBQgC+fTMHyc01r6XpDr0CJGQKG5JQjy4Tjdb7hcHU0QVT4Vxuy/Md3/Qnsb7TJs0PhUwxxigpnnLCGLaNmOGHWovP5M4dNYP/cVpajwUTQb31/sMqo6AFYV/f8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MLz6I1aI; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-30ccebcc7e4so2537346fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224749; x=1756829549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NAfIsqIeamHQl40XhRtLzpSTVOKYN4cYjLU5RT2HlTw=;
        b=MqDtmix3AcY0kcvFn0+SEN9R/KDynsUjKcb5L3wnjye8TBPh0NQy8YKHjIRP/4t94Y
         WOqM1qUUs94eQZDJcvNK2xj+9N5+zqhjM7o9pUDKRh1+J0bWA/YQB7lrqBrFJxp4ChEQ
         bmB+xo+OhwJXazfBpk4Wy8Uw76cY/EmOryO73V4IZ4rX/s5LAjHi35CJhNa3aUC7Af0o
         HoJ7pTbxs+lKM+TNzN7DuAecKmbCnUqVSgzkq2uaa+aO69i7Kjm8mDTVFlJ6rS3UfVCc
         0xhpXeqePC2wIMRgmqOYFc+o/rGlzaPuxEpY60Mo+SAEIi9nq0fXO7iqgejmy9Y+dfQw
         zCBg==
X-Forwarded-Encrypted: i=1; AJvYcCXnztN4vKxWNVUGFQ4nbtDHFEShs9Qxtat4H8i9Qhr5BqTg+UcVu6D19m1ehCV1GAGgdjvQKM7Ip7X+LC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEXnuz1LN1IwDx/tCgy0Jj8y7JRLOujfNReEO6WJjhNCEtAxy2
	dVIc+DEZnLhE6AUVgmC8wjyYebwkJ3802wtBtZ13c2O6xgpiFf4JA6h4X7tUoqY4KNxEFxCJyzi
	GRCO62+vADRtZjTel7O/BX+28hVfpHrTLqNvdy1B/L54gK8G5woExR7UGcNN9UYC/AMPqUuncSD
	PHPHecmn5xjz9ALHsx/V8YxxTX+gCU6/dYM0V1amVQSayP4rm0OV1rAIkxbhsF/6ZH7VuB+xbKU
	GFFZHMWhOhK53fm074SSrSa4hLd
X-Gm-Gg: ASbGncudv6wxgbKC1nF0z2TpJCv+csNjLrdX6hu2p8y5U1pf3AxjnjC21c9ZqCfVNiV
	98NVO5wLpwMyDrvCQSyBQcMPZSr+oSD3kjpcXfZwsuzIIjxuHruOlZ0ZDNx0hRk5VenyppTE5Nc
	KKCSr6jtOQoG6zhGvM7pl1IRCaaMtAUxyppNeclDRdiMzxjCk+osCY/JmfNE3Rh4ZoQAW/4mrUR
	dIP9L4FO5zFb/0PiRq9WP1vYZ6QxCiDLHIK7Ylcyuw1zqJTDI/i0ondFitU5cmasWvy1rkkOJsQ
	dz6rfWCeAdFR9y3ILFG3+bYb6Y8g0dhggduEjJVqEnSK8FTeo3xmKeWc/fqNszwO5Xhsu2trwEZ
	oGb/RzipiZxGCheIn3LM89LMn0oWaaZehZZjnufAnr+EFJRCBnb3uPSlx6Lf3TBX+HmvbU8pdvN
	5q+J/mMg==
X-Google-Smtp-Source: AGHT+IFPcAjUSgEX3BYggiDp3dbTMoGGDqROgEk0hKRBbiZLsyjSA3/m4OJzsh6sqyC2zIYi9OAJZ8+meiPQ
X-Received: by 2002:a05:687c:47:10b0:315:51fd:aa53 with SMTP id 586e51a60fabf-31551fdb81fmr726201fac.9.1756224748925;
        Tue, 26 Aug 2025 09:12:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-314f7930122sm1077673fac.2.2025.08.26.09.12.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:12:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-325228e9bedso7573437a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756224747; x=1756829547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NAfIsqIeamHQl40XhRtLzpSTVOKYN4cYjLU5RT2HlTw=;
        b=MLz6I1aII5JLSZxYqpfLtuMYtxUZQq3jsfWeShGre9LftK0ZITj/xms4zcLs39hSi2
         7HmGmDiRKlfjRucEQ1CxZYrCT48V6mR5CVx5xfvcQVuUqSiSKuNCuVJ18U5IeqSQ/kPd
         /S3igGieZJjFcmYh8W2Mtw12Zv0/IV0Kvkk08=
X-Forwarded-Encrypted: i=1; AJvYcCV1q7zY8uUeB4e+GcyJgO5GpI9CdsOkPGTTdxEMRiD/m5aL7fnJRudFLSsevFPtepuPiq4hZJXPLdBQp40=@vger.kernel.org
X-Received: by 2002:a17:90b:1d8a:b0:321:ca4b:f6cf with SMTP id 98e67ed59e1d1-32515ef1564mr19461560a91.35.1756224747283;
        Tue, 26 Aug 2025 09:12:27 -0700 (PDT)
X-Received: by 2002:a17:90b:1d8a:b0:321:ca4b:f6cf with SMTP id
 98e67ed59e1d1-32515ef1564mr19461529a91.35.1756224746887; Tue, 26 Aug 2025
 09:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
 <20250826164412.220565-4-bhargava.marreddy@broadcom.com> <a4ad132d-ffb7-465d-b19a-4c5e0c0665fa@oracle.com>
In-Reply-To: <a4ad132d-ffb7-465d-b19a-4c5e0c0665fa@oracle.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Tue, 26 Aug 2025 21:42:10 +0530
X-Gm-Features: Ac12FXzqerVz7iI6d4FC_-NZmbbB-YF94XV5JZ2hKsaJ74_jQiDxEF2mfFdG5ng
Message-ID: <CANXQDtaM725=xtAPH_wK1y5WjTXz286u8gM_BRp1Ni+9Jx12DA@mail.gmail.com>
Subject: Re: [v4, net-next 3/9] bng_en: Introduce VNIC
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003d5698063d46f0ec"

--0000000000003d5698063d46f0ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:31=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
>
>
>
> On 8/26/2025 10:14 PM, Bhargava Marreddy wrote:
> > +             /* Allocate rss table and hash key */
> > +             size =3D L1_CACHE_ALIGN(HW_HASH_INDEX_SIZE * sizeof(u16))=
;
> > +             size =3D L1_CACHE_ALIGN(BNGE_MAX_RSS_TABLE_SIZE);
> > +
> > +             vnic->rss_table_size =3D size + HW_HASH_KEY_SIZE;
> > +             vnic->rss_table =3D dma_alloc_coherent(bd->dev,
> > +                                                  vnic->rss_table_size=
,
> > +                                                  &vnic->rss_table_dma=
_addr,
> > +                                                  GFP_KERNEL);
>
> @size, first calculation is overwritten by the second.
Ack. I will fix it in v5.
>
> Thanks,
> Alok

--0000000000003d5698063d46f0ec
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWIwggRKoAMCAQICDH/Bh55Nn6Pe2/qMjjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE4MzdaFw0yNTA5MTAwODE4MzdaMIGf
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xITAfBgNVBAMTGEJoYXJnYXZhIENoZW5uYSBNYXJyZWRkeTEt
MCsGCSqGSIb3DQEJARYeYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEApKt+sLxPSTFE+ruMyTpA8tU2ux9z4w711yS/nB4tbYArbQNC
KF9dH3b5h4X3Q6Fq9BLFbCWH7pJ/tEiQ7W19TQkQxiJbj1gdIzalTi4YFPMdTzD6/BaU8IELCGCs
Gjv4zuV2kN5uGAZ/K+WtRFRipB33fat/f0FWZ/FhdjAgTCTBrJ4nt7ENYOjNOZN4fjh78vjZqsul
Q+65ExyCjaRwqzdvCy5NQIZ78a6tvGl2Oj1lK7931edumLgCU6qbvk2FfhcD6tRp0xNL2jwL6Yn1
i2qNOdId5F0Uw9myUIwlW7Zg22U2c0Ce3GZggAfhiUwLYFfT2HXj+2kqrhLjK1T8qQIDAQABo4IB
3zCCAdswDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0
cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIw
MjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVy
c29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8E
QjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwLmNybDApBgNVHREEIjAggR5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wEwYD
VR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0O
BBYEFFh9UQJiPboINUMOwOo9HGoA4rwXMA0GCSqGSIb3DQEBCwUAA4IBAQCx4SG9qg18y5lkgQ4d
aBLzpJdJ9WDhmZ44XpTLWPl1MfjO1slu0OOnDU5YVCMikelOWoIm8CK4bkTJtEj/byNXz/X4yJ0p
Gc6hcQ+sxONsIIJxJiNHbpbUaA/cnobVUgEfxvz1tIDMKsHYia+tKFdJ63yd9IXdtBwark1k/D+L
+dDHf0sRsASxceuhNMc+BAs4rNgE6dqAhyNJnd0jL7m0SiCjJsHYElWwYrVH73TUAWgxOFw9ow68
wsf9W+/wSEvI3N6OBMoRcIL34Z0xhrMZDHNOkYxArYhN5BraAmSU/obLBAbwbfEsOtHgFQpTtcHo
C+fgh5U7No8Z3dJYOsl0MYICYDCCAlwCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIg
Q0EgMjAyMAIMf8GHnk2fo97b+oyOMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCt
qgB3sAYiDf5W5SIZ9F67qq63a55GinpzpLGm4SWxOjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yNTA4MjYxNjEyMjdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAcwkaXY835vOz+9HdtgxxXZEJFT+zN0MSZcxX1
hwO6G7FTUsS7Bxa2mlvtgxUaauY4P8tUF0TeFRdHqMjSOH4UxyB0e2Dp7OPQgtqga3EAn5US+0I7
wsCbPILBXVZ+oaeio3ttWcMhqA7yDS/MDLE6O/J/5TTwpUFIyhDrre+UWJJJxKBS7jzVQ9ZFp/PB
HXrWoY2ExtBmPEDv0AXIVsXjemOyPRm/9pYKJIDcU85d6YdIXrNyaT5Ncg2vDREdt/8f0T9xXjhi
q/gPjhecs1n0IUcWP02QSShmYrjEhZKzeeWcySQSiZhhRHfvSAIBMt/cnP036hy0DpSFo5QV+wMy
--0000000000003d5698063d46f0ec--

