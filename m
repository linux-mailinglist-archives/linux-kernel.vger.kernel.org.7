Return-Path: <linux-kernel+bounces-837625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9427EBACC88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0821019262E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719F12F9987;
	Tue, 30 Sep 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kwt7qjpt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB42F7AC3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234296; cv=none; b=QnIjG+sIVG378ge4oExpHYy2sagnOAWisXBBNzAYvYOe9Cgr1GPWZK1nnlopQ/65pqud5nVYdmGCfb+jMMGdFlIbXpJc4YF1mrI1qhbWOWvZKcIRztMFLhnrC9d8/e0DzkOgQZ5/W2rVezK/MF7SVzmsRPFseUanbUsS1jxdbfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234296; c=relaxed/simple;
	bh=KD8kMWmVHWif/IAatoSGDNampJhPM/CNfGdxYnMKEMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyX/aeDLqcElcJDlDtF/x8u0QBqIvhglxTy3C78ZPJEVtg3bBPhP+EdAHvPGBOqKJgbM05OKDahnLaXfx5CRJ3p6rFoys/8fu2dZlKziNKWSVMdmbcoNKLi55rK6GO8Daya5+drogD6vi8DE+3ilg3tsuIoZSpPmYXbQ4dfUOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kwt7qjpt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759234293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYhlOTDpz0Sda3KEKTdInplw8rxwP1Ctg1XIqKxUWtw=;
	b=Kwt7qjpt8yWlXs3YDyIVWVI5LARFFQlb9jMEnCLiBZBuYss8CMK5daDtz0ATnOboZ8+Wdv
	Z302gQgziYsdcuZ4lKIrIO1XZ2gAkJx9GLLgaeHDhmlSP3vd7ipD7UOew+wenKpSvv9FTc
	u3BM5GZ080CSW7qeR35X0CVszbg2/X4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-ASwA-u2WMeeAQ9zqJVlxbA-1; Tue, 30 Sep 2025 08:11:32 -0400
X-MC-Unique: ASwA-u2WMeeAQ9zqJVlxbA-1
X-Mimecast-MFC-AGG-ID: ASwA-u2WMeeAQ9zqJVlxbA_1759234291
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-634b661347bso5599969a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759234291; x=1759839091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYhlOTDpz0Sda3KEKTdInplw8rxwP1Ctg1XIqKxUWtw=;
        b=UPxdD7V2z04JtGgT0dzKRmIFATUWSsi5HEbXWc3ICz8FvJwyquceNJaJXoY1/FLzER
         QJrzdOK1HnMdzAPxvvAFpiAfbBVpaqMlCYwPNkNjIUFC4y+zwxIdLwLJLChiZ/QFqsCK
         +KNb72zsvcVRMOD9HHssc9HSsx54CDi/NmQ0TVY0i+C9g9xOF3n122AJ170xMOgVOt29
         Ab+Y8MDM8DH0J/poYpKfIPZRmpjliV6dFAqXLwoyKiBc+U25n/YYbunWmBGwKuFzlns7
         liRJcvOOFlkWos/c7p/BlENoEnUotLZlcV+FqSrSyvqpMLz2/TF5h7KdN44fs1oQ8ePO
         1WqA==
X-Forwarded-Encrypted: i=1; AJvYcCUw0PyfK/kvTHEDmuuT/KpIf+VS+WrrYsi4BBGEHKwCVqWG75AKRcJK5VBADsPl8pBDXh9WJd2CdYJnBS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVT48kYmaEfXQ6wExodhWoBdqY9w+bYrlJDGOYOmQpg25IRKBg
	pKzHSpxJ6Z6yZ6qPZjkPTNcQm5ARl1k5952WAlOWKUi8VVDsCt7byA1J77FSyuwUThwWvkw20a/
	i6hOYqI+rvLP5Q0JkBM/QqUt4gSzHCkoDi7hU4Opr29n/2hCQKlyKms301FLY+KvwXQ==
X-Gm-Gg: ASbGncuUD91B/AfwEHbSxFrznMcSn44KQ0jSHxTvDCARrdJbEjrJf79RK95UHlihiwX
	lOik+nZU2E9qFB0lHdHGBqOzPTwbELrESfu22jCqjBvDR+ziplWZ4r0TU13OUXZBPblNGdDsrfv
	uDt9gE7jiP53WJ7VywdUqat4muh9fMaOWv5hVyg0mIX0wZ9Ux27N6ILXRSrJsp3VASGX8bdJZhh
	mqpstK3mnR+5ilidk70ljf3hunXu92J8BRgsaIyn7rGj71yxEE6d8AeSjaOnr8a/e5de6cQxgbm
	OZO4NWIsHOrjVVznC796BoZFQOySmzRnzUFjqEY7CScavsnwGydLKdlXsGydvq4F3HtWSgz4jHK
	hM2ndSGr2KNvaWEoHouJsnA==
X-Received: by 2002:a05:6402:3551:b0:636:23c2:e61f with SMTP id 4fb4d7f45d1cf-63623c2f2d5mr11899900a12.26.1759234291458;
        Tue, 30 Sep 2025 05:11:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpBFHlpi6h26vswLogB4lR1OKDkES+l20vuTxXnbWfysRnTRsji62rg1W2cZYzxCghNaMmAA==
X-Received: by 2002:a05:6402:3551:b0:636:23c2:e61f with SMTP id 4fb4d7f45d1cf-63623c2f2d5mr11899850a12.26.1759234290960;
        Tue, 30 Sep 2025 05:11:30 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b02ccbsm9498953a12.45.2025.09.30.05.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:11:30 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:11:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com, 
	ross.philipson@oracle.com, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] tpm: Use -EPERM as fallback error code in
 tpm_ret_to_err
Message-ID: <hjay4b2lomj6k63tbnuk55q6mm4sdj2d7yycw64ybhu372l6bd@uqetr6ipbtg4>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-3-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250929194832.2913286-3-jarkko@kernel.org>

On Mon, Sep 29, 2025 at 10:48:24PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Using -EFAULT as the tpm_ret_to_err() fallback error code causes makes it
>incompatible on how trusted keys transmute TPM return codes.
>
>Change the fallback as -EPERM in order to gain compatibility with trusted
>keys. In addition, map TPM_RC_HASH to -EINVAL in order to be compatible
>with tpm2_seal_trusted() return values.
>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
>v3:
>- Removed fixes tag as it hardly categorizes as a bug fix.
>v2:
>- Split trusted_tpm2 change to a separate patch.
>---
> include/linux/tpm.h | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

LGTM now!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index fc7df87dfb9a..51846317d662 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -453,8 +453,10 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
> 		return 0;
> 	case TPM2_RC_SESSION_MEMORY:
> 		return -ENOMEM;
>+	case TPM2_RC_HASH:
>+		return -EINVAL;
> 	default:
>-		return -EFAULT;
>+		return -EPERM;
> 	}
> }
>
>-- 
>2.39.5
>
>


