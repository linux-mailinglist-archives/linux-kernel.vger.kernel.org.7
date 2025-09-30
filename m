Return-Path: <linux-kernel+bounces-837627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E5EBACC9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39DF321769
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D092F99B5;
	Tue, 30 Sep 2025 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLLq4S3c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4312F83C0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234370; cv=none; b=BQjuZgPIFuoZRfwGcMrueGCpH7lTQl4rlN+BjGyTzv4Ss7bdEydIp03rU1nG5lgMPNwh3fnhWNMJAtR2HJ2V+GqMPtmtGFatDwNgj3VgkfxWAsrotfQUVQ/rmt4zpYWpwAHKtRG/mkDQdOpWmTZaR+PXt0Etx35kW777IQuQFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234370; c=relaxed/simple;
	bh=8hAe6inhz0E/QWnBDuNMlbdqmEfM/Hzecqaiue2MllA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkl6SlV7g6COeES1rptoRCJsdGQNDtZmvwzPPP0Oe2TMZlideAgpkFF4Lkxph7wQuvJM0B/OvjEiMdnhuuBxKFRtPkIqw8MLiniN+0fJzQk+1srOrJMCxKpSlNCac6XJAa1ufpE8inrBJ4vBeYSdvvm/42G6yH8YlhVqRhhNoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLLq4S3c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759234367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWIgSoKL3urKBOhTmtSOXc8Pl4O+FoLwxpjwzaySij8=;
	b=gLLq4S3cqXv887rnRbK08R0KgasRIaTGbwHsSeRgyPbgZ49rEK0SE7Ljr3XSoTlrrlV8mH
	LaUrsaNjg3VRQpaybdJc0djG+5xKaRvWcfaQ5b+CkIQRrXC1kYoEuOx1DH9nkdZl3r1nMC
	oczVtyAM8rPtckvszAVp1fnFcCGBKow=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-vGcGMFVUM76UxGolUd_s4g-1; Tue, 30 Sep 2025 08:12:45 -0400
X-MC-Unique: vGcGMFVUM76UxGolUd_s4g-1
X-Mimecast-MFC-AGG-ID: vGcGMFVUM76UxGolUd_s4g_1759234364
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b3cb0f2b217so346801766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759234364; x=1759839164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWIgSoKL3urKBOhTmtSOXc8Pl4O+FoLwxpjwzaySij8=;
        b=IffDNCnlpjHrO+ANYe0NN26v1ZN6tcEEWTfuqmAhjukFAwXxKTRctJ2bBtbdo7bQYm
         ZVBvdVQ2j4zM8flPfNuB+niMa42gdCR9Wmq5R2C0fXTcZl8mL/oI+eC5HxC8m+2zIEzh
         hocZF6HRM7huUy29HULuqvXpy8E7DWA2u8M8iR6dbk4t7JCRIEjww11+UCuf2z+++DyX
         MD7HY8Sxa4kP7zBlZBPf2yz1wL3yLjqFo5cLXliZjU+UeWMbHKdb9oAhSriVkbQiTRVk
         heDyt/RIpQZDD4SmSRvxNXKHjdj8HwGArnYw7oWDXWYW7XZ27DE8SeeqYkaPA6MUHI7K
         Rr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNT7XfiYLX/UqGNY2HjwGtXw/BMT2PEBIqFInAzYITZowiQVrlY2IxniIRIqf3EEK3MPbLf5mRUmr+ScA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqRuAUcZxInO0QwcrDKEeBeZFYsou6tHoxz+KoEa5yk6X/scgy
	qVEQw4VyLPB4/AvZx8bAzCdkqlMP714TSQWsCjfQs6nrpYKs7B6GnC3Pt14tcGyv2ljbuhQQwaz
	dxf2Kw7tHzpEmRPnHt3sHxgdxZNOlfOOgz5G85JLdpAK/s38Psr4vWm9vRn67sVViug==
X-Gm-Gg: ASbGncshiJx2Ttjz9hKRAx6u0d+mylfg0kxCdVkSKDpONqEnEQKZzWAtJ6KYvTrSApt
	0ILJvxpDU3Ewe3YLHsV9X4ZL7ovD9WyiSLhFsfZkvLg8ugm7CPGDh2BVSAjgzR/3okVlxD3fzJT
	9AWASDYolPRDR28mnQ7GttC/ZrrUzQwEVErmp3pNAhRcR1UrZeKr0VxWTYXB7GAmvoBNJVHy4iE
	sC7rV/oVay6mmgeaiRgXq4dBIvCUXhiK9WoNEEEujOJbSLLk9RjTPK8KhOgfsP4DlVmMsBp02ik
	C19Eu1JkHThFuttD3H679qdjvSuTvlU1FXRdtcBk5J6AYaBnziXqs6TZZBXuNBWtk7YI9UUeigI
	49Yar0DqSVM3+zcNOPV+wxg==
X-Received: by 2002:a17:907:3c8f:b0:b04:36bb:545 with SMTP id a640c23a62f3a-b34bb12fc3dmr2371566966b.48.1759234363911;
        Tue, 30 Sep 2025 05:12:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCMW+GDcVwUnAC/efDdJR1OCcQoMagIWww3faxZxGxD2S8ezNsWbFnZUmUdO9qvxkKur0+NA==
X-Received: by 2002:a17:907:3c8f:b0:b04:36bb:545 with SMTP id a640c23a62f3a-b34bb12fc3dmr2371558866b.48.1759234363046;
        Tue, 30 Sep 2025 05:12:43 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b05779sm9854125a12.49.2025.09.30.05.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:12:42 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:12:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com, 
	ross.philipson@oracle.com, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] KEYS: trusted: Use tpm_ret_to_err() in
 trusted_tpm2
Message-ID: <7icpto3rnm2f4u6zaxl4xy7zvar3q4hhpgelq2gnazszdkwc3m@5dtivkqs5xdg>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-4-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250929194832.2913286-4-jarkko@kernel.org>

On Mon, Sep 29, 2025 at 10:48:25PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Use tpm_ret_to_err() to transmute TPM return codes in trusted_tpm2.
>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
>v3:
>- No changes.
>v2:
>- New patch split out from the fix.
>---
> security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++-----------------
> 1 file changed, 7 insertions(+), 19 deletions(-)

Nice clean up!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>index 024be262702f..e165b117bbca 100644
>--- a/security/keys/trusted-keys/trusted_tpm2.c
>+++ b/security/keys/trusted-keys/trusted_tpm2.c
>@@ -348,25 +348,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> 	}
>
> 	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
>+	if (blob_len < 0)
>+		rc = blob_len;
>
> out:
> 	tpm_buf_destroy(&sized);
> 	tpm_buf_destroy(&buf);
>
>-	if (rc > 0) {
>-		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
>-			rc = -EINVAL;
>-		else
>-			rc = -EPERM;
>-	}
>-	if (blob_len < 0)
>-		rc = blob_len;
>-	else
>+	if (!rc)
> 		payload->blob_len = blob_len;
>
> out_put:
> 	tpm_put_ops(chip);
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>
> /**
>@@ -468,10 +462,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> 		kfree(blob);
> 	tpm_buf_destroy(&buf);
>
>-	if (rc > 0)
>-		rc = -EPERM;
>-
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>
> /**
>@@ -534,8 +525,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> 	tpm_buf_fill_hmac_session(chip, &buf);
> 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
> 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
>-	if (rc > 0)
>-		rc = -EPERM;
>
> 	if (!rc) {
> 		data_len = be16_to_cpup(
>@@ -568,7 +557,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>
> out:
> 	tpm_buf_destroy(&buf);
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>
> /**
>@@ -600,6 +589,5 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
>
> out:
> 	tpm_put_ops(chip);
>-
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>-- 
>2.39.5
>
>


