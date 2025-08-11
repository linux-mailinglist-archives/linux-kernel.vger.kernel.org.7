Return-Path: <linux-kernel+bounces-762377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3678FB205BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1053BFCA4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D78825FA0F;
	Mon, 11 Aug 2025 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iGERkDzz"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256C2475CB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908617; cv=none; b=UUIOI6DwuJ3OQi9Ahez/tISetMtwPWNXY/TMKujTC+DeDODPicRUcISSMw/SMcsvveOYNf8KX2gSwu4xFYv+HI7EY1tqMgWJloZNxFc1VAMws8pPszDr9848Soga2EV1NrD6SRwNcrqORpLq+QkYtmlGbO2ApjrUcnXa8ySlpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908617; c=relaxed/simple;
	bh=hpDUjsqccXzyLu0Sg88WqPaJK3bg0zLcHCTDj/5pgZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8b49RVQz3EFf+guIqEaOplJYGIaVDFDrz0LXRDMCHOpjoRPW1hSzB1DFgp8qET6xdGLDY5ssAR+xuJ3JTYd/vrb2TcGyNQaAP+Zh6onWtOE7Ff9qIPIEkWr2Ez1eV4LPp7hj3q/3gdBZIX40yeItNvPRc68lSquNP7um581XZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iGERkDzz; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3e5527b96f6so5382305ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908615; x=1755513415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HX8mWJRaQ3qDD4j/yFDo61HcHgz8UAX6Zjz+zZBHvUY=;
        b=eYNiPd7Rm81xxdMpMsbtJnA/3noM6Z8Ri83e4gtMSTbSPixVPv5AF332MIN5QMXfoE
         xtH/VN/+b5RWyK6KGyms/RQHPDRpTWfhDJwJTt/1zcXY7OYwGmTHpBk3GTWI2KIyaY4v
         bOgWgnjlmxMwmXD8FmE/ruUi9lCus2SqAB04QRVKiQs7W3GslSf+NWrB4rcRfFafkOP+
         s/NsQmBLuNuyPbOEYRgi8Z9RnhuzoQAKyhAyP1Nv9pAbiTsF39+MJkjGpcUqSHrN4QTD
         W2cXRWV60NvvQCb+Mu1kxPDYCreeZdMXJnj6oqPkXS03mxrybnhzxF2sGSonh1yfoaVM
         YQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCUPEJ7Xx+FDRe9JEh1ZkdfiHZvd5dGpPurMwqpTvdyLhQSmQlnSBPy/AvQxCrBD6wPmJAG3UYZO3OahnQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX66lyLjgRgIY6Q17h5vMIKAsMan7tf5co+AIgwyO2xMHd6XHZ
	OsvniO804oN2amfo/SPSKKvzp8k/axpum+T1bnFXKmdGkF+s+JKQnJEfwmYO7qvP/YDAHA7N0O5
	eRrb9C1r8GJpfaloph6Q2k6je47CxUX77OgbKceSr3tr6zA11jVkxw35lkIy0rvDUVOFnkGV48z
	X7TBFDVcMbQAtDXQyaLyvredlu1bA96e4Hb7r2kQuPdygN3kFtvJmDEpJOYr3sNHtVUPG3nUnmS
	K4vMUSEorrYKHcSmwe20JbyEw==
X-Gm-Gg: ASbGncsSex9Rln0fJQyRdQ+OaP3IRLVGCWdNFXtCgsCXxV7gmYSU4GOeZcUPVp9d1cV
	nzbcATxxVi3OPNrcZJer6tm7Bnf1djxlTEoN7L/7tnLUdr2Rv5IkoEtsGDsrnSw1FYjD+jyIgub
	RpfeRNrEogESehxanBXa0F0n1KCBMLMNUlWMlOmFNvlYKpgq8TaNKkrJokCs2zR/LyoVqJ8mW/0
	zigJxBKckDFKyE+OBdI6ouScIU08r5iitkF1f7vrSJ+kWQIr31PhkwnEA1u9mxzlwAqmBYYPYbF
	peZMzML0/DbmeDdfoClYNRtQ32fjx8njsd+E9pVHxg3zGZeV/FUNgvsMxL9E+qHeyaKIIR29Xlk
	GsGAxaAxAL8J+KyCZ9qIrJPiwc6dTS/4AQduB2/okkleLEEAeGmZMyX5TqTxGMDbICWuGs1zFA8
	zPafcpRg==
X-Google-Smtp-Source: AGHT+IHpocS5XVm3N3T/ECxmjrwWTkVViixZDDJ7yTNz4UJNgW5Iouevlim7tlw2wvaa7Ospo6Y24Wb9bryI
X-Received: by 2002:a05:6e02:17cb:b0:3e5:4002:e822 with SMTP id e9e14a558f8ab-3e54002eb25mr130392665ab.12.1754908614719;
        Mon, 11 Aug 2025 03:36:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50ae9c04365sm587701173.42.2025.08.11.03.36.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:36:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-33228f0cdc6so21390901fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754908613; x=1755513413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HX8mWJRaQ3qDD4j/yFDo61HcHgz8UAX6Zjz+zZBHvUY=;
        b=iGERkDzzW9PQtuZJTg8b5QpYarqWh5R8FYP2J5kJ6NYrYMiNgUJup0W+5Z6wHb/BRP
         0/XK91UBnipIBGk7Wr+UXYFwAmXN/y2rd69cd1NDXnw1L7mch8L8gHN2SQULxG/uR+MD
         vM79qsT5sQB0C6PAsrCO7YEks22toSz9Ukx1c=
X-Forwarded-Encrypted: i=1; AJvYcCX+FpYGdhFOBHHC1/0tLY3S1hd2dESMhN6Qj13ZUo7Q9XrLcPLmir/iFYbQ8bSGE7JBLwhleYeXCW65aZE=@vger.kernel.org
X-Received: by 2002:a2e:b8d6:0:b0:330:d981:1755 with SMTP id 38308e7fff4ca-333a210d629mr31287181fa.6.1754908612716;
        Mon, 11 Aug 2025 03:36:52 -0700 (PDT)
X-Received: by 2002:a2e:b8d6:0:b0:330:d981:1755 with SMTP id
 38308e7fff4ca-333a210d629mr31287081fa.6.1754908612199; Mon, 11 Aug 2025
 03:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811052035.145021-1-shivani.agarwal@broadcom.com> <7c7aedbf-389d-4e5a-83d0-33c51cda1d8a@web.de>
In-Reply-To: <7c7aedbf-389d-4e5a-83d0-33c51cda1d8a@web.de>
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
Date: Mon, 11 Aug 2025 16:06:40 +0530
X-Gm-Features: Ac12FXwNglXMtrgIIpAb8_5Z4UtmkHGLxNPDlnxZm1tW0Yi4PWiSy2OxteVobxs
Message-ID: <CANTE3ihiPx2GZDcUWcO-YR8h-tNrsCtJ=jH7Kzd08Y8qDxZk9A@mail.gmail.com>
Subject: Re: [PATCH v5.10] scsi: pm80xx: Fix memory leak during rmmod
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Sasha Levin <sashal@kernel.org>, Viswas G <Viswas.G@microchip.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Ajish Koshy <Ajish.Koshy@microchip.com>, 
	Jack Wang <jinpu.wang@ionos.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-scsi@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Tapas Kundu <tapas.kundu@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000080a5c6063c14805a"

--00000000000080a5c6063c14805a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:30=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> =E2=80=A6
> > +++ b/drivers/scsi/pm8001/pm8001_init.c
> =E2=80=A6
> > @@ -1226,6 +1227,16 @@ static void pm8001_pci_remove(struct pci_dev *pd=
ev)
> >                       tasklet_kill(&pm8001_ha->tasklet[j]);
> >  #endif
> >       scsi_host_put(pm8001_ha->shost);
> > +
> > +     for (i =3D 0; i < pm8001_ha->ccb_count; i++) {
> > +             dma_free_coherent(&pm8001_ha->pdev->dev,
> > +                     sizeof(struct pm8001_prd) * PM8001_MAX_DMA_SG,
> > +                     pm8001_ha->ccb_info[i].buf_prd,
> > +                     pm8001_ha->ccb_info[i].ccb_dma_handle);
> > +     }
>
> May curly brackets be omitted here?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-style.rst?h=3Dv6.16#n197

Thanks, Markus. I agree with you and have no objection. However, for
the stable branches, we usually keep the patches unchanged.
I think it would be good to remove these curly braces in the Linux
master branch as well. Should I go ahead and submit a patch for the
master branch too?

Regards,
Shivani

--00000000000080a5c6063c14805a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
iRPJW7xMdyXlghl13B29WFHBvkcVJoRG7X1q9hGiJ6cP+UffhEHqOIAfa+w9JdtfPmRdIei9rDMG
13qTNm0LSI5pyK2hrV1mJ69tfsMsfB7sejsTuTOfw/7DV6KBse6HCG6+EopHpBKz+ZrTMOJo5UxE
en1o7UfNuVpRJRpTSkEXMRntyMcIEyWmGBpUN644f3dX8Wrd6HHYhLRqATO+uwIDAQABo4IB3TCC
AdkwDgYDVR0PAQH/BAQDAgWgMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDATALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEEG
A1UdHwQ6MDgwNqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2Ey
MDIzLmNybDAnBgNVHREEIDAegRxzaGl2YW5pLmFnYXJ3YWxAYnJvYWRjb20uY29tMBMGA1UdJQQM
MAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSm
eEP07C50BiHJ6M3vZhTU/COMnzANBgkqhkiG9w0BAQsFAAOCAgEAGDK7XvmoOTcNaefKnzjIfKKD
wCbRX7fLxL0keAQAmiQNgNd7eDc/Cnlnf29QH0YYVWllIGMIiHpdfJP+W/lbdMxvCDQ/NWmnuBJ1
HgH/cJpD69x6sybVo2zvbeavlHsFLCWpfDfgY9p8j/flVo1SWPcQG+udOqyXwh+nGwHhiuKAiEBy
jBEEs+ngv59U/j1cvJ9pXlaGTC9NOkP1XliIs3nlytpQXJG1weyZzkY4DZf4klN3cHOSQTvF7vjy
aY7hNcp1YrHDxsqoKdQvazng3Y96w/GEAgcaZhITyrH6mCC8+/oJC3HpM0k4K7Z2Vi1m1v3Jq/Kn
lQkI8Dv80Uhgt6bvS+KOVU1vLDk5B7tcy4kSASakBiXbjOIQTjGUFAFM45yN+Tv2vS8o4QbX2nRl
8yzOosbR0aM7SFOnifxUub/2hhQl5W1ZNeoOL1bZUskIQ+VsgxQxNtqMXf7uupJq2sVzutbf3lEh
Z+E/GB50TcPGfgSBH3kP9JH9Wd8oXJ3PN02vpjq/h3ffJEPGIPtqYkaFjI7dzhC/XpW5+A+J232c
qsnzyHW2U8vSWC5M3Mo4f8tGkjBS4qQS/eFgGz6KLcwD1SjhPzgp5NZN2W2jYEVoPmBNAeNnm/tW
lDghRb6zt3dVU5NEcysBUTIydLMkLuoWGzgRJx8fFpe/qziOJKsxggJXMIICUwIBATBiMFIxCzAJ
BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWdu
IEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxdbqmjX1toyzmQTGMwDQYJYIZIAWUDBAIBBQCggccwLwYJ
KoZIhvcNAQkEMSIEIOyZsF/EZr9UY9sn0SgzJ7df5XeBlNevmWV5WucHmHNjMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgxMTEwMzY1M1owXAYJKoZIhvcNAQkP
MU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAL
BgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAAswuCQnRa9zy1/Pu9Pn
L+IfU9Er4FLnLn6+mciixXSbtUNU5zjeU5Ld5uieSbMsEvE8oURRKL/uW01o+Lox2cWEL73iJQt2
UhymzWluj6x0JP3Juw5AqeeNiqatAOTnsDzvPWctguCei0HTKRK9wocmmzA9vPviwKWKSialj4Ws
tIu2zQj+gTqW1y+hVbKWxv7necl5KcKDv4RJIbnuxPPBaDQyEZUDAj7dPVD7ta1b4GSEcg5OXW2v
5pSR8lOq/vZyNKNS4QoO7JjqUNYXQFXXeSoAVM1tewRfinRDcKNsO1r5+OFxfs1aoJnwieqQ1q0o
cGGxlY1tiybWqHZXXoc=
--00000000000080a5c6063c14805a--

