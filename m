Return-Path: <linux-kernel+bounces-822361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C8BB839FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA6D1C054C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFADC301022;
	Thu, 18 Sep 2025 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCkzTVgZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033C3009C1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185747; cv=none; b=SabY+o5fBxfNUKYXU/j3ED51yRiavyPWPsNYEWOaojxyNq99vIvhrGatEKtQgGnzk3eGlxrJv2VvR9/38ZhIIqM9DV5F+cjF/aQyDNGqQb4aVT9v7AW8OpmOLh+C+pdL6TLQHybiTl8unkmyNm9R+1Dsx47NmReCsb6zUe2+DqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185747; c=relaxed/simple;
	bh=1PqtqwA8HTxTGdbY6XU+KfBZ/5blcdrJ1NKOXPhyCXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+AZJSV78bUnfKk5Ms0a9ywEqNNrwHXRGRG7YBZRit4e2GbbxoJu5H1zEWmcisqbnnu02Qej8AB9zL/kfvBjFm9T7bgU5mkdtz8MjDNPsaN7ODH7G5uMgKHJDz8U6xdM1qFU8YmUpb3u/bd/rlxWWGNYWGahBPgGL3g6BrTZBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCkzTVgZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758185744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AfSX/3glV+vNGGCchKq7p2eyLcNnzQWJh7iAfkK8WO0=;
	b=jCkzTVgZoSHpCrv2PwKmChEiKrBYlyxKJyEwkXLkIl3RemMaSwfGaLwNZzyPIKqJL7BX8i
	lhcFhh5EUdkeu7WcGpDumpAXmWlJglKUsko84SsKFzN03/xku1xGQpX8etckikMAoCmIZ5
	g2uJhh3UMULYtZBJBEdgxqkMHZ/L1i0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-OvlPYMuhPOe-6MqkKFVsbg-1; Thu, 18 Sep 2025 04:55:43 -0400
X-MC-Unique: OvlPYMuhPOe-6MqkKFVsbg-1
X-Mimecast-MFC-AGG-ID: OvlPYMuhPOe-6MqkKFVsbg_1758185742
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45dd56f0000so7266165e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185742; x=1758790542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfSX/3glV+vNGGCchKq7p2eyLcNnzQWJh7iAfkK8WO0=;
        b=ZliETH7DHZM4QoBn9R+Aor3Gj7cO9gvA9F42a2CBaoI3P6Ca5I26PlHIcsClrrJOI8
         JNGs93CvsWy0KRbBpMnfXxdq6P59Hm3E3XWOxjK6QoM6kqPDTNNSCE0t2zL/O2tKrU2i
         UlXRbnz2oAKBwcL8NX/e4unU0WUusUmObW0NfL5comZq+0Md84jGc6kqLKtP6KICejT1
         vadkZJypXOrjq9RzDQT/twVSmssA2MBGRjXkAPe5aV5tfrITNfS2bS6dzxvbPnnXX8Np
         BOs28Olp2PQc/jCkiSCDVHqK+NcG4pbrirycotUqC+VjZd/qcdMqPKiVnc3DCKDr8tpw
         /17g==
X-Forwarded-Encrypted: i=1; AJvYcCU6zuAVOPyTircIl5bsR1LDwKvc0mLLxgI4tSTnJqowmdryrqjSvyR74+5dPn3s08puhlDSt+yZA4DQWrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWKW+mvzXbqFUVOysQWLUztyXx0wlBrRF610eryYCHrJ5fR9FO
	ROnkGsEpqiCosH3I/ueqGowpOILFfHd0tL9w2pZW9BBieC6Z83cay80LDuBizE1fe/7a3G2vwfc
	YQn2dDTtYFDLRCZJBlcf3pn9aCleSFQXiMkhd3vLnNI3ePpFVDhSoTt2PrrZcfyialA==
X-Gm-Gg: ASbGncvA8y4UK1jSciQs0EUFnNOPQCUCfGDnhX8Q3szckSK/XaNn4kKE+qP1yLB6XHb
	ijLDgdaV97nlBYYq9zuIaTUImJn0kO2z+TV50LR15hXrDDKLc8QjPXXWvxIL4NbUgQYBb3ULFHh
	aZKPmIeXNXpdJaXLl0NIpNe5Vh/pm2YB82RHigJaETJU2oXn0afvOa4uCqF+nxjezAyrHUcug05
	/XJKcsILKrA+QX4BT1L1WX54GJa7ZRX5eUlpfTY+CTeVA8h2xr6bJilCBKJSP82vbOXDYX/suko
	0W9NQElp5d9sSy5SbWlRy2BdnHbVMzn/LiuXDycoDjI=
X-Received: by 2002:a05:600c:1993:b0:45d:dbf4:8880 with SMTP id 5b1f17b1804b1-46206b1ffe5mr45269545e9.27.1758185741774;
        Thu, 18 Sep 2025 01:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDL6A/B1KiEn8NHf82/BX9qvSi3nK8XhtHIfdcuZ0mICv4WoJhO2X+6N2sP+jKTJkCiwT/9g==
X-Received: by 2002:a05:600c:1993:b0:45d:dbf4:8880 with SMTP id 5b1f17b1804b1-46206b1ffe5mr45269255e9.27.1758185741229;
        Thu, 18 Sep 2025 01:55:41 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.120.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac271sm31225685e9.3.2025.09.18.01.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:55:40 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:55:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
	kyarlagadda@nvidia.com, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Justinien Bouron <jbouron@amazon.com>
Subject: Re: [PATCH] tpm_tis: Fix undefined behavior in
 tpm_tis_spi_transfer_half()
Message-ID: <d24qnjxzidsbi6oidx7fk5i7txinsxj5rthnzx4n2ylbblejtx@26n4ecbdgyqc>
References: <20250917153022.18567-1-gunnarku@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250917153022.18567-1-gunnarku@amazon.com>

On Wed, Sep 17, 2025 at 03:29:56PM +0000, Gunnar Kudrjavets wrote:
>When len is 0, the while loop in tpm_tis_spi_transfer_half() never
>executes, leaving ret uninitialized. This will lead to undefined
>behavior when the function returns.
>
>The issue was introduced when tpm_tis_spi_transfer() was refactored
>to call tpm_tis_spi_transfer_half() or tpm_tis_spi_transfer_full().
>While ret is properly initialized in tpm_tis_spi_transfer_full(), it
>was missed in tpm_tis_spi_transfer_half().
>
>Initialize ret to 0 at the beginning of the function to ensure
>defined behavior in all code paths.
>
>Found by GCC 14.2.0 static analyzer with -fanalyzer.
>
>Fixes: a86a42ac2bd6 ("tpm_tis_spi: Add hardware wait polling")
>Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
>Reviewed-by: Justinien Bouron <jbouron@amazon.com>
>---
> drivers/char/tpm/tpm_tis_spi_main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
>index 61b42c83ced8..1b6d79662ca1 100644
>--- a/drivers/char/tpm/tpm_tis_spi_main.c
>+++ b/drivers/char/tpm/tpm_tis_spi_main.c
>@@ -85,7 +85,7 @@ static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,	u32 addr,
> 	struct spi_transfer spi_xfer[3];
> 	struct spi_message m;
> 	u8 transfer_len;
>-	int ret;
>+	int ret = 0;
>
> 	while (len) {
> 		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);
>

As an alternative, we can move the declaration in the while block where 
`ret` is always initialized, and we can return 0 at the end of the 
function since all the errors have an early return, I mean something 
like this:

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 61b42c83ced8..c78c0a2d0541 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -85,9 +85,10 @@ static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,            u32 addr,
         struct spi_transfer spi_xfer[3];
         struct spi_message m;
         u8 transfer_len;
-       int ret;

         while (len) {
+               int ret;
+
                 transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);

                 spi_message_init(&m);
@@ -135,7 +136,7 @@ static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,           u32 addr,
                 len -= transfer_len;
         }

-       return ret;
+       return 0;
  }

  static int tpm_tis_spi_transfer_full(struct tpm_tis_data *data, u32 addr,

BTW, I don't have a strong opinion on that, your patch also LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


