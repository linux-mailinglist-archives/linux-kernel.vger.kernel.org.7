Return-Path: <linux-kernel+bounces-826915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C19EB8FA39
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CC63B598F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2724027F74C;
	Mon, 22 Sep 2025 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erg93yRl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA927F018
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530810; cv=none; b=T4XD0mw8r+mZBq+dhbx4RVbbCDwwWsHk8nHtHTlOykgnA6+BOzmINoLRtTU+XTrnAvr6QlIIOWyuRywt4vQ88q2DWuE/5rFEl/WWyVVbEU5S61VF4fU3gaQBX9MN4uk5urDwyD7P/k4Dm/Epn/jWAwxUc5CpM1itRzTgWP/Wees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530810; c=relaxed/simple;
	bh=rux0nTQ+9Ps75XEuL7CDS6cf7zTXqlLDg+FoU++9teE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rxjx/EWN8eOmZl5lFW5Rgzvfz3kIdrdZnHdPk7cK2hwkNOvTrrFWXZXqEb7Bnl91Iu/aYeIZweb/5jKY2dgbCT3zrPMoTi+rqQ4+p8xK7Rsml4Q9gbWtwBi8l7ohGegGSEMCNactuqsA10eT6m3EARKi50ZrmddpjREnhF2P3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erg93yRl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758530807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8GHbp8D2RtGBXa6TMzqbqe1udm4TgsD2fx15EVhrsY=;
	b=erg93yRlVbtuZw+s77oia3XtXtTtdbZk/zPQBrYu4qMoXcz5e/m8dVCxONm8uiQXgacDaO
	u8sYiEZ7GdPIXUwleHwlIF5ANpLJWsKyWbiuCXTSAnPW3PNsdNpGISmzHJzjriEwaSQ0nj
	20CX0h6F8ipqCPf3/B3Ib4wLX/dUpYw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-MkcE5Z_FM2Koq_bdaE_yYA-1; Mon, 22 Sep 2025 04:46:45 -0400
X-MC-Unique: MkcE5Z_FM2Koq_bdaE_yYA-1
X-Mimecast-MFC-AGG-ID: MkcE5Z_FM2Koq_bdaE_yYA_1758530805
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f384f10762so717334f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530804; x=1759135604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8GHbp8D2RtGBXa6TMzqbqe1udm4TgsD2fx15EVhrsY=;
        b=P7aQ9x1PBXNXPd/8KZ1vkvp2vAulRo4l5zgnb4wl3ou3He0hQRhY/Kc4GiKFj4FM2C
         L7bHrBaDtNcP2p01QkwCRAhPK6e1bJHfieeW8l6QkNuEfMJ+g/CpymLl1AVcUqhS07+8
         Lgn/J5zIavuAzYgHLSN4VAkkhsnnZ3gnLpURVvtx29XUuiBYSNVGj81bQCTQv9dtffwv
         pHd8FthiCbXEp0r3Zr1qrTuxaU7DE4Z/YMaJ+r/il9d1URM/vrTC15GqGrHC8wzK3Svx
         rwIOMzKCGSW7ZD9U/46DaVD38KIciqki97YoYrpumdExx7nSKv36imZKmMExHqDxm0wQ
         SmIw==
X-Forwarded-Encrypted: i=1; AJvYcCXXomB1IZNV1cyyJaCARTjIS2uuEssK8AuGpx1JCDttCKMFLpNVCvaEZnB3cqCncZovJ5flL0h7SROXzOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCLscZztggBkAsNLilK1pXvXe20I3EP62kLVh/BDZrXloArMW
	J1tQFIuRgTa+nj9ct/6O19q89RTsWYSCSRr6aoDcz/mXXVyZWoQsEcRr1nLMtIIXKUkXB5YtPcH
	eTw3Q2xwBczQFwZ8LQAsHhABm2UQbnyGyP4XBCf0IuqPv6fzUGJXe6TC2epFXP9VxZw==
X-Gm-Gg: ASbGnctShqi05gwlpzeHxBoTFi1tHsLM4/IEMHvOx89FFhrHDAYAOF7sCVZlIi5tuEU
	XmkZjM8UGtNXdDop4rpFnjAx3igka6L+CQ4J+hjDVQ+oX7Jcaij2JHCWfOujR2UtV+Whs6W48k3
	/2bwD+jsMlPIY33gS6LYrL5HnHrPGBh+IaSKC9ZJyiL0G/XoHInmgs4TDcb5ydmSnchia8s5kII
	cfrbQaGebtWs2o/Faa5LKS12mNxyIJzh3dvpc9XIZiFGh0fPVmGgShvz2d8KoOIVEH321tTBE5X
	h6Cajo5a/03UlDO9CCYOCOcc+86M15aPnzzDMl7sCA==
X-Received: by 2002:a5d:63cb:0:b0:3f7:ce62:ce17 with SMTP id ffacd0b85a97d-3f7ce62d110mr3512229f8f.38.1758530804605;
        Mon, 22 Sep 2025 01:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFIdF26ri8nPLU1h2hF0oUN4DiGv6MueO1DVBaFqmOzwLifco/ttVWeCoGXOHOK8CouN8qOA==
X-Received: by 2002:a5d:63cb:0:b0:3f7:ce62:ce17 with SMTP id ffacd0b85a97d-3f7ce62d110mr3512199f8f.38.1758530804128;
        Mon, 22 Sep 2025 01:46:44 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.126.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm7668492f8f.57.2025.09.22.01.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:46:43 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:46:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, 
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v10 4/4] tpm_vpm_proxy: Use stack for TPM_CC_SET_LOCALITY
Message-ID: <swkdunznhlk5atrdfsiud57uzcvkmknnarzfh6esq3xzy74tmk@2qqsv6tvdtlw>
References: <20250921020804.1088824-1-jarkko@kernel.org>
 <20250921020804.1088824-5-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250921020804.1088824-5-jarkko@kernel.org>

On Sun, Sep 21, 2025 at 05:08:04AM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Use stack allocation for TPM_CC_SET_LOCALITY, as it has known fixed size.
>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
> drivers/char/tpm/tpm1-cmd.c       |  2 +-
> drivers/char/tpm/tpm_vtpm_proxy.c | 12 +++++-------
> 2 files changed, 6 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
>index 11c16ad9b2a7..433908cfb4a9 100644
>--- a/drivers/char/tpm/tpm1-cmd.c
>+++ b/drivers/char/tpm/tpm1-cmd.c
>@@ -328,7 +328,7 @@ static int tpm1_startup(struct tpm_chip *chip)
> 	int rc;
>
> 	dev_info(&chip->dev, "TPM_Startup\n");
>-	tpm_buf_init(buf, TPM_BUF_INT_SIZE);
>+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);

This change should be squashed in patch 2, right?

Thanks,
Stefano

> 	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
> 	tpm_buf_append_u16(buf, TPM_ST_CLEAR);
> 	rc = tpm_transmit_cmd(chip, buf, 0, "TPM_Startup");
>diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
>index e5de14379eb2..0f1b1b67ed4e 100644
>--- a/drivers/char/tpm/tpm_vtpm_proxy.c
>+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
>@@ -395,15 +395,13 @@ static bool vtpm_proxy_tpm_req_canceled(struct tpm_chip  *chip, u8 status)
>
> static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
> {
>-	int rc;
>-	const struct tpm_header *header;
> 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
>+	u8 buf_data[TPM_BUF_MIN_SIZE];
>+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
>+	const struct tpm_header *header;
>+	int rc;
>
>-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
>-	if (!buf)
>-		return -ENOMEM;
>-
>-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
>+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
> 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> 		tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_SET_LOCALITY);
> 	else
>-- 
>2.39.5
>


