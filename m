Return-Path: <linux-kernel+bounces-788940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 889C3B38E48
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52381189938B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBEF3128D0;
	Wed, 27 Aug 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PgEyB5Hn"
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2230FC0A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332947; cv=none; b=uKYgEwwiLPEga+zCAxI/EI4a+1Y3Py1YyQWYnU0OHEYMjXcU80Tse6ZyDrluNmwtPu5NCIoapG7lN1MucyCyj7EKgpGKxcxogty+8+pp5uc4z0Po/E4RkBWfLXAW3UgSZndRjmhLY0DVurRiyQNFGa5PQI8lAGr0XZZWbvpVoPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332947; c=relaxed/simple;
	bh=lp00p/s4RgIpKujof2bRQ6IkZFeW14QD0wO+5LdnjEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WR7pvoKYMhoBLLqv8tEDCwSy1rBEO3XdRmIS4ilSXArInMdn3HuqOxgy3D+7Rn2q4L+3nr4kT/Ds4By518xt2UzCcjy+Xy9YkWkfD4/4bHLSuw200ecPzQ+0R16XNvQNnCJeW+1FL+ViIvLEKHBD5HKYWn5ztbJEEebfaQmc8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PgEyB5Hn; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-b49d6f8f347so358023a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756332945; x=1756937745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vuYyrnpasZOz5kTNP9WyaU/djuYbOLCNpbGnoStwUnc=;
        b=TqhhJEBvWxV7e9fidAFx2vXC4sMxQPUTbKqlSEv0BOLG9lY38E7dzeoafy8rEYa2Oa
         u8s8NbsVWZPSweuc0o+UHizXE88HxmOykfqSPdekW/yJJvea8Gq4jJf8bStD4SR/cnar
         n7+tsaHlRBB0cacp6YIGiW7D1fT7dyvx7UJgB9zcqDoAfGVmN1udfinpKWRMiCnGExZl
         +mcpsUtRxXaPxsOtetm0TdW84wLljKpqUYXUg5dUGh9DBqAaz5BUhL3qETMT0josh2zQ
         jL9lvKMEr5cKrM1jhvDjpnT/Z8fx0vtowkrJNXO9LVY4laKqVI7w1p/8+ws55Kx7DRqU
         oHjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbaxcL9jOvDrKjFDs0qXrtJ/3e+gwKAtXZF5ENxcpaZCmpn+7jmdDYmcTWLNKratFLDutPRbCE/dtMTIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3tObc6rCUBkkLdzXHJvLg+GhrF2NvcgqvrYV+3UgQA/rIUPD0
	iRSoTaBZlKQhwgo39b4768to4N33b44pHaMtSrtYvCL3LhiYYWqVAZPSUVnwwP6sSkeCHI3dNet
	MbjxiBS6KDqH6DIIyI0C1i+bt9QkY7UOGvV2qG2Y65KGesZ46RlUJ8qjdTBkN694A6M+JgX024U
	eCJqWPNFEM75ztBs84YTLybMuBmvM/SiK99psU0CYHlh7QsHzqgRko4KRF86h2oh2GfT/eUk93b
	LLUEf+jV9NaP1LJxb4=
X-Gm-Gg: ASbGncvyMGNLWKQpoDqRDnP7iKpSuDR715ImxgTeK5TcEEzv04rzr/6dIFU9vkQom0I
	s5fj7oAxxR5LXa551fwAqantmJXBxLowdlSYG29W5mWFVWsRPSxoiNl5V08vLzGmIlCop4585Co
	xYSGjDdhIUoc/TrJ6r9D0frmATJjV75iZnHyB0U8kUsKIpauZNTC9rX9IvxFwGacHniBBuzQHKV
	EGEfFoT6BK77rKIFv2GuBXILKhnFnyFQzDYp1uzrKPvwnCa6QH7u7XZ67x17fmBCnRj3kyZcP/e
	IzhwHC43zpIO0PpgEL/r9DRCUr51XCcvz2GFC3xf3ZReG89CpVkx36pjOjLfJLwY2ONsv18xAjo
	GZ/F4nSTv7xQTrm9ro7snZKoA7rFEEcsHVeXx2uRBB07qy/WEUuoS2DJp+qUELg5Sv+uCDdnDlX
	DMOQ==
X-Google-Smtp-Source: AGHT+IHuwpC4PpMpt0iSo+ZP778QwZZbwxVXf/iqtsBgRgWkPn1upH2E0TBhaal5+T2rk7OxNq1zWsRbAD+Q
X-Received: by 2002:a17:902:ef06:b0:242:9be2:f67a with SMTP id d9443c01a7336-2462ee0bec3mr279086085ad.11.1756332944978;
        Wed, 27 Aug 2025 15:15:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-327ab156839sm26349a91.8.2025.08.27.15.15.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Aug 2025 15:15:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-61cbea81400so698600a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756332943; x=1756937743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vuYyrnpasZOz5kTNP9WyaU/djuYbOLCNpbGnoStwUnc=;
        b=PgEyB5HnuXN78ypif36f6lAKG1XJYl+I4M1ojh5LOvxLDZEI5eyh6u5y+VkRZH6P0I
         XbtqhnS8LU3ZyIDFwLYeKWIujU24thMj+umTh9f9mYXbm8HU/bwVwxmXnq1fkqSHz7wX
         JkBWD5KpCO2b54kflDzJr1rvAlfSLKwVFZ2FE=
X-Forwarded-Encrypted: i=1; AJvYcCVNIPAELBqfFOyqcLvwxAjGDqbJ8mTmEk9ejDykeDLIIpcYcmaMdYKUd5ImzD74MrPZ0F/E/4jEEiBGqs4=@vger.kernel.org
X-Received: by 2002:a17:906:3199:b0:afe:d1a9:e815 with SMTP id a640c23a62f3a-afed1a9ec9fmr159551366b.26.1756332942769;
        Wed, 27 Aug 2025 15:15:42 -0700 (PDT)
X-Received: by 2002:a17:906:3199:b0:afe:d1a9:e815 with SMTP id
 a640c23a62f3a-afed1a9ec9fmr159550466b.26.1756332942368; Wed, 27 Aug 2025
 15:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827135021.5882-1-qianjiaru77@gmail.com>
In-Reply-To: <20250827135021.5882-1-qianjiaru77@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 27 Aug 2025 15:15:30 -0700
X-Gm-Features: Ac12FXxnvL1uw4Lsz8LztijBCF5xMcXB6fjqrCvKER55OidT80HEkVeOLoMl5eY
Message-ID: <CACKFLi=d68RC-1d_i_E1eduVbOpdZFdJYwgj7YBYOwRanZVgKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] RFS Capability Bypass Vulnerability in Linux
 bnxt_en Driver
To: qianjiaru77@gmail.com
Cc: pavan.chebbi@broadcom.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002efc78063d602199"

--0000000000002efc78063d602199
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:50=E2=80=AFAM <qianjiaru77@gmail.com> wrote:

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 207a8bb36..b59ce7f45 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -13610,8 +13610,11 @@ bool bnxt_rfs_capable(struct bnxt *bp, bool new_=
rss_ctx)
>                 return false;
>         }
>
> -       if (!BNXT_NEW_RM(bp))
> -               return true;
> +    // FIXED: Apply consistent validation for all firmware versions
> +    if (!BNXT_NEW_RM(bp)) {
> +        // Basic validation even for old firmware
> +        return (hwr.vnic <=3D max_vnics && hwr.rss_ctx <=3D max_rss_ctxs=
);

This added logic makes no difference.  We already did the same check a
few lines above and would have returned false if the opposite was
true.

--0000000000002efc78063d602199
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEILZWXQWhkbSOTTD+U/RSze47pNrKNtvB
xnnGW+I7vqLrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgy
NzIyMTU0M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAHIje3A/1pcyYZf2dbcNU+tHiSFWMY1eF3YB2nV55le3MFqymIjLRCxaK8ICRMZIgJJt
xeFZt7MxJNKAT2vmOEowVKIdT1EaJjDyKi9W/KRMK7bJ+FJhxPNYMIKSeDiahbvPvRDYu0SCagnP
9SU2/8/rQIbWZNSbnfuf5hP0hmvDpaw6UtStJW2aj7jkulJjCzk2VAvtXTwySbhS6BoesZdbktiL
5dzhnBskt9yGAzF1+QdCE/iYwJRZAQg28eovKZo7ldEaQicyBodfC5PlNelHDJmc+jusQLh0+Io5
4XtUyCmc7g4GxXoxFMmi+D4qyUu8bTBa9lq31iR5VL/s1OE=
--0000000000002efc78063d602199--

