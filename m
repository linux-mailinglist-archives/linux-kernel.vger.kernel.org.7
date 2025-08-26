Return-Path: <linux-kernel+bounces-787387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB79B37590
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06126864B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EAC3090D2;
	Tue, 26 Aug 2025 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C3zL5eCY"
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7D2DA753
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251147; cv=none; b=kEY9FKwYswigkLYjif4kJohC7FeX2z2Msng61c8yNoh8OgPWrwiG/a/H5hPuCHRcbt1tbVj5AdLR4aptO4ALtKqPs3uEYrR8zbi/xAu6sj87pA+pV1XhYB0HIRq8zfU9D4iBnlGNjjqbKhqe6qYB7kKQQza9f2rQcVAZtOhs8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251147; c=relaxed/simple;
	bh=p2dSYxz9yvzufqBDxm88nkcyF8nNUXI9oh03mM6g/uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6y1DJ7ytEEFtIdirnhN/8pHal818j+GEt3tsrVeFk96Vb2vwLbcLWVR3BakMEYPMmkeDPuiwUYyeGpLui329QNPvUBly7/1+cZ6Qtsq/rYlxmVnCv/dFE+qHRoLBVuyL1U1Y5AqeKyrGWQfAgSprkIRyqZPOCyBXtpRzEuUrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C3zL5eCY; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-7e870689dedso417176085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756251145; x=1756855945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6uL3vXEMJ7zLFh6sm11Qghv7WFvdD+AqS1CLNi/v1xo=;
        b=ggGc7z0wdT1FRr2XvL3ItEuG08/hxJ1meGOJHHofkbG3eQ6P3DQTfQPYwLZpQ93o/I
         v3XrHz9s+y/KVNN7aES7f2kO5Usm+X3ctVsP4kxwSxH7Nd7CLWEQZzFnL8TAVSHrvzHl
         EcT4a3TldjxOQBD0IUTKm9V75t0TXTp3GfCfDeAIdkgXx3jJ+l5y4ttJLCiAb4bnkeTC
         WzXQZYGeC2+dCW0yIcHRYchKZ8hsKKnx+fmen8M7KDiv8MOH4s8SxKwGnXOE3JU/DORw
         mM9psFtgLB5iucXeRec9a5lSKVrzX40VkhzOXtAJcx7xvC5lXgfjf/h73vIczxg+bCH0
         fTog==
X-Forwarded-Encrypted: i=1; AJvYcCV3db8+oI9HFYe7HsJPxoeWJel01MeZcb7u1knViLEoRvoEteqObhYUIc+5ehGb1EKpV5G7E1Pm/bASY90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Huvjc9tXdh8Mgg7O9v6bwFp+dtLS96QovTIV05TMPCBHb2by
	wFB0WbtLYHYWVw9hUPHF5XfXaIqv1Bs+5XRyST+5kvLleql2/0Lvdky3f/Z3WOOVvrWcV3fw/QL
	j3B12Q3UtN5tlmb+oC5bUTIV7sPg82jUGPSMyy26ivz8i8EVZU4VMhmxvDwTwtzFbnw9OwoTuy7
	iF9vlwncT0/u7Lt4SSyi2/cZSffxW056vdPyNx2KO4QZ+NYHj8kDJCIDacgYMXMYX07nunGQXfR
	YWYu2VU4IZzUoDf97w=
X-Gm-Gg: ASbGncvShkpsVYfw0JZJjTM1XW4xVL7T90EgY7ZoIESORn7eOFyyBuh9tW2YhFL6Cbn
	x86KlEN5fbVK85gDx2QAFLpoZxYrXMWevK9rZyBMGjzGS+NlB011Gm3a1p129MxJ1K6lyEh0qD+
	Ynv7H0+/U5/YvN9w/W7ZcckhhgTPubVUzfIV2GKEsiwW/ZOoLCh5NtARz3nrnMVDnvQyxeACNwY
	6hZ9j6+v86xtUVKPpjqeWEnY0fXOLR5/eAGa7nGdCZU8EK/Zd9b6e+ddusJSWi4SwPMrvEVuV+z
	gZPft8/Bm9gL5nl46zsQUGSxasNlJ5UqOcsfrTa+2uzcbGKv6oc1K1IlV+GmApnfddaY0S+9I1V
	9g9nsRcl2PjUB1RhALJbis563SsKOL+s8Bmm5+niQw43ZnSMUj4ZP/1tTL5zeCFDKIXDM2OGtjl
	8=
X-Google-Smtp-Source: AGHT+IHwUeB/tdP2r1fImS+gpxXhA6Y46hwP/1StDVeQIEXKzO6KmqP5KxbeaVKzHYJrXtvuDis6CyLvsgMa
X-Received: by 2002:a05:620a:471f:b0:7e9:f81f:ceb3 with SMTP id af79cd13be357-7ea1108a82cmr1798614085a.77.1756251144598;
        Tue, 26 Aug 2025 16:32:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-7ebf15fe28dsm36796585a.7.2025.08.26.16.32.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 16:32:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afcb7a5d28eso555124266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756251143; x=1756855943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6uL3vXEMJ7zLFh6sm11Qghv7WFvdD+AqS1CLNi/v1xo=;
        b=C3zL5eCYMNBOf+4O1DhG4RJWGOAY1xmF0l1dfDW8huHk0Pr/OaBzZ6glk+W+G5rvHd
         PY0ZFzV5M40/s3jsB5C4rC3BfZvv9xXtbZgJo2xRL2PDwWhzqBCmGbZpKz360UTS+h8v
         FbGznttG9b2Yg6IazopXzilTkLqE51GO5wUNA=
X-Forwarded-Encrypted: i=1; AJvYcCW5Cy+JxI1+uyMCj1qKxCJiYUIU6vyOiIS5B2gyn+xi3ygyBvlx8xXrAuns6WYFKeQRrNbGjUoVPZITDZ8=@vger.kernel.org
X-Received: by 2002:a17:906:6a1f:b0:ae3:bb0a:1ccd with SMTP id a640c23a62f3a-afe28f2750dmr1614027466b.26.1756251143054;
        Tue, 26 Aug 2025 16:32:23 -0700 (PDT)
X-Received: by 2002:a17:906:6a1f:b0:ae3:bb0a:1ccd with SMTP id
 a640c23a62f3a-afe28f2750dmr1614026166b.26.1756251142662; Tue, 26 Aug 2025
 16:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826162541.34705-1-qianjiaru77@gmail.com>
In-Reply-To: <20250826162541.34705-1-qianjiaru77@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 26 Aug 2025 16:32:10 -0700
X-Gm-Features: Ac12FXw3OJwmOdRtTFdWBPv9wNpD7ENFEGqbAyGAqVUSK0iRJJFSiHoOpohK3PY
Message-ID: <CACKFLins__qAd=RrSGLXf+2_rf-VWbodqEaoMAZZJoU69Uw7=w@mail.gmail.com>
Subject: Re: [PATCH 1/1] VF Resource State Inconsistency Vulnerability in
 Linux bnxt_en Driver
To: qianjiaru77@gmail.com
Cc: pavan.chebbi@broadcom.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000897f95063d4d1567"

--000000000000897f95063d4d1567
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 9:25=E2=80=AFAM <qianjiaru77@gmail.com> wrote:

> ## Root Cause Analysis
>
> The vulnerability exists in the VF resource reservation logic
> where older firmware versions receive incomplete state updates.
>
> ## Vulnerability Mechanism
>
> 1. **Incomplete State Update**:
> Old firmware path only updates `resv_tx_rings`,
> ignoring other critical fields
> 2. **Missing Hardware Sync**:
>  No call to `bnxt_hwrm_get_rings()` to sync complete state
> 3. **Inconsistent Resource Records**:
> `bp->hw_resc` structure contains stale/inconsistent values
> 4. **False Success**:
> Returns success without performing actual hardware resource reservation
>

I will review the driver's code path (!BNXT_NEW_RM(bp)) to support the
older FW that only requires reservations for the TX rings.  This FW is
generally about 7 years old.  More recently added code may not handle
this code path correctly and may have the issue that you pointed out.
Thanks.

--000000000000897f95063d4d1567
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKktCTI1reuotA5WxfslcRDyblkm8lMa
u+jYwmakR8fcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgy
NjIzMzIyM1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAH6ezteXNSvjMjON8a3mF2afYYp+XBtk2mPhz8yClE7vNBqhhIyE1CIEOL9G2J/W4aoB
+GGi33YEjRKgC2YxGkAFOxRYwojPOtBqs2aPHlXM6Kq8+bcwzBLRjUPponUF45VQhLtbfzIwOfTI
L12UWi0+yZObd6w4Cum0KYXutapzB0xBUgBU6oTStWzAtQreChNOdzohmJS8HgBUiSve79DetqSF
GuFNde1jkCjglfaQNnSi8ErhBqSrtoOhjuFbY+M3zpMdxCoFkxSNPVzdtVPFf5MDribTZDgDGrLD
ZQkyDs/LzQ9U55lyHXvjoieYaQqQYrwl9/YlFg9qHkLe0z8=
--000000000000897f95063d4d1567--

