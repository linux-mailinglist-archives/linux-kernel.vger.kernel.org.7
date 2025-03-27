Return-Path: <linux-kernel+bounces-578255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23692A72D48
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 11:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1ECA162E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 10:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4620E014;
	Thu, 27 Mar 2025 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZhTVkAx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BCC12CDA5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069798; cv=none; b=CmWFGUAwiVQQ90VSmocpDJyzRtySNkOwXa83SzgN//QO6MBjSW+rV+a7nmeekxCBELY0TslicT+vxvKqtJguBKYmaZ7novvxEWfZXXdmvuQC1wRcbRLhpWWupK9yWgOX9D8NFAgPgAavwnBy6+KDqDn1Wtfu1zSa14q5yAjpmoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069798; c=relaxed/simple;
	bh=CmAPsH19acTNxiJ34GcKSbeKXsn1qSM3hxBrxhPstDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiciPO6jnAABLIBKhRi93cAoddAfatdFq3WTVHMwR+S4OnFYm1zSF19wcosaa+xgpspfGPOqLFaE7qCE3T0bm3Sd4CQ1vEtTv0Fwf3jGBxtrVJyh8GOQXq96u+ULf/6AaeardLbPO8jwkQctJhVbexapzXsIHf0ryazgYMeLKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZhTVkAx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743069796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wTTe6v1RbdaUcztapWTUL8QyTrGJ+1Apq/8VVkFKQn4=;
	b=PZhTVkAxMP6KEUkrmtUPWq3Z/7Z0bYwWLe+ZYKw44hQPa1Rrx5NLv+hJgHzjdi73jU9yZQ
	xpciZz8i/BnfRY8fahsGecdxdatwqaQyMJxVTuDVT5RrXh63kVGJDPQZczJCcCbhQF7vwv
	TUQe6VvAPOtmy/u3FZs9rFzp6wAqCn8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-Jpzrb5TlO06mstfEp5mdCg-1; Thu, 27 Mar 2025 06:03:14 -0400
X-MC-Unique: Jpzrb5TlO06mstfEp5mdCg-1
X-Mimecast-MFC-AGG-ID: Jpzrb5TlO06mstfEp5mdCg_1743069793
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac28a2c7c48so5423966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 03:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743069793; x=1743674593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTTe6v1RbdaUcztapWTUL8QyTrGJ+1Apq/8VVkFKQn4=;
        b=rzlW4Io9Q16ptqyIU3EKnIa3DjjAhW8bsmGro9IOd67W6RJSztp4GS3H1xmQhq1LKP
         cACurndyXqqfjmaHmkomzTkgyAoiuT7ejFVChgTcx7LB7bhJUsKfMF4LtmZBCtCwhQQJ
         Zq+9jeu47zVnTN2mgM/o5UUrSlNZ1pz4NZDFVGtjYWnuDWIG1MqODYMnLaj/jATuTiRu
         b0XHQVxeqcoc06a57b4kYQq9lttnY2hAiLrSQzh5wUE4/bmCG89uQM2w7/cFZhZMpG97
         0TLIC1JlJX3pOspXUMX0jVWFZIqx34QekD0po5HweN+Lg7DLtamdWqr59QGAH2Lhnxaq
         Pmsg==
X-Forwarded-Encrypted: i=1; AJvYcCUAhqlWOYHM1WMdDulLrI/YvYijWIgURGxx5YAB+TQczjadMs7AIj+1dzdazs2/qufnecuvI8sAJ2p/y1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVlVM8gdrVd56e3Lu7CVL5SNXcBx7i0sX0Tt3aOI5TfQBH78Xm
	XsvMlx5nYScgIhLRzIZjUCgtJNoar7bp4aehIGwr618CqNgveSPgianmc7GJWGNPWPL2IiqNizY
	MhxyaOXNxGq6e20Fb3i4I7UEH3Q59sXakD+wlvj7Ua0Dl3NJQ4/VwrEzCh8e8YA==
X-Gm-Gg: ASbGncsVg5l9Qto1D4MYABtCIsUZXaWZXMpBB5m3/z+GpduxZKBDV1uQPinn6jUhA6N
	lYWyEfYi52Qper+RzfZGcFQT6x+ywyE0yh4IcRf36JLo/wu+h+UqQcJBD2uHV2t35ILRnW3XSJq
	3Eoqv31QQC16qvLGj5tr3u9/tpxWJKm5OqkpLfwfin3B65YVQ16I4I1RneYfQfF9MOkbL9CoNU2
	oIyj80mDUtmb6GlQJVhjXni8yAkVUl1mX28cJr5sCSMWHm953zY87Z0k73miWw+5aGPjKdbTx5u
	A9JZhBbUaZ2kWaLyKIjma5ZOn7z4E6BiSdy0lmBpWhT/FlkpWfoT1K0hMnStcbKS
X-Received: by 2002:a17:906:7952:b0:ac6:bca0:eb70 with SMTP id a640c23a62f3a-ac6fb1d6bd0mr212453466b.56.1743069793309;
        Thu, 27 Mar 2025 03:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm8OKWNs4u9ViT+uxyhYFue1UOIBeMnyQo1WzfHwB+8yebKYj7pxcxkRwJAxLbxHEcN8yozw==
X-Received: by 2002:a17:906:7952:b0:ac6:bca0:eb70 with SMTP id a640c23a62f3a-ac6fb1d6bd0mr212447466b.56.1743069792573;
        Thu, 27 Mar 2025 03:03:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd4800esm1191676166b.164.2025.03.27.03.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 03:03:12 -0700 (PDT)
Date: Thu, 27 Mar 2025 11:03:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Dov Murik <dovmurik@linux.ibm.com>, 
	Dionna Glaze <dionnaglaze@google.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 3/4] tpm: add SNP SVSM vTPM driver
Message-ID: <x3nkctmpbwkldm5aawfpqrw3b5lej5kxuxam7gb2w6nhgzy7kr@gd3mfnigyg6q>
References: <20250324104653.138663-1-sgarzare@redhat.com>
 <20250324104653.138663-4-sgarzare@redhat.com>
 <Z-RV7T7Bwt3Auopx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z-RV7T7Bwt3Auopx@kernel.org>

On Wed, Mar 26, 2025 at 09:30:53PM +0200, Jarkko Sakkinen wrote:
>On Mon, Mar 24, 2025 at 11:46:48AM +0100, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Add driver for the vTPM defined by the AMD SVSM spec [1].
>>
>> The specification defines a protocol that a SEV-SNP guest OS can use to
>> discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
>> in the guest context, but at a more privileged level (VMPL0).
>>
>> The new tpm-svsm platform driver uses two functions exposed by x86/sev
>> to verify that the device is actually emulated by the platform and to
>> send commands and receive responses.
>>
>> The device cannot be hot-plugged/unplugged as it is emulated by the
>> platform, so we can use module_platform_driver_probe(). The probe
>> function will only check whether in the current runtime configuration,
>> SVSM is present and provides a vTPM.
>>
>> This device does not support interrupts and sends responses to commands
>> synchronously. In order to have .recv() called just after .send() in
>> tpm_try_transmit(), the .status() callback returns 0, and both
>> .req_complete_mask and .req_complete_val are set to 0.
>>
>> [1] "Secure VM Service Module for SEV-SNP Guests"
>>     Publication # 58019 Revision: 1.00
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> v4:
>> - moved "asm" includes after the "linux" includes [Tom]
>> - allocated buffer separately [Tom/Jarkko/Jason]
>> v3:
>> - removed send_recv() ops and followed the ftpm driver implementing .status,
>>   .req_complete_mask, .req_complete_val, etc. [Jarkko]
>> - removed link to the spec because those URLs are unstable [Borislav]
>> ---
>>  drivers/char/tpm/tpm_svsm.c | 155 ++++++++++++++++++++++++++++++++++++
>>  drivers/char/tpm/Kconfig    |  10 +++
>>  drivers/char/tpm/Makefile   |   1 +
>>  3 files changed, 166 insertions(+)
>>  create mode 100644 drivers/char/tpm/tpm_svsm.c
>>
>> diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
>> new file mode 100644
>> index 000000000000..1281ff265927
>> --- /dev/null
>> +++ b/drivers/char/tpm/tpm_svsm.c
>> @@ -0,0 +1,155 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
>> + *
>> + * Driver for the vTPM defined by the AMD SVSM spec [1].
>> + *
>> + * The specification defines a protocol that a SEV-SNP guest OS can use to
>> + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
>> + * in the guest context, but at a more privileged level (usually VMPL0).
>> + *
>> + * [1] "Secure VM Service Module for SEV-SNP Guests"
>> + *     Publication # 58019 Revision: 1.00
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/tpm_svsm.h>
>> +
>> +#include <asm/sev.h>
>> +
>> +#include "tpm.h"
>> +
>> +struct tpm_svsm_priv {
>> +	void *buffer;
>> +	u8 locality;
>> +};
>> +
>> +static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
>> +{
>> +	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
>> +	int ret;
>> +
>> +	ret = svsm_vtpm_cmd_request_fill(priv->buffer, priv->locality, buf, len);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * The SVSM call uses the same buffer for the command and for the
>> +	 * response, so after this call, the buffer will contain the response
>> +	 * that can be used by .recv() op.
>> +	 */
>> +	return snp_svsm_vtpm_send_command(priv->buffer);
>> +}
>> +
>> +static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
>> +{
>> +	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
>> +
>> +	/*
>> +	 * The internal buffer contains the response after we send the command
>> +	 * to SVSM.
>> +	 */
>> +	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
>> +}
>> +
>> +static void tpm_svsm_cancel(struct tpm_chip *chip)
>> +{
>> +	/* not supported */
>> +}
>> +
>> +static u8 tpm_svsm_status(struct tpm_chip *chip)
>> +{
>> +	return 0;
>> +}
>> +
>> +static bool tpm_svsm_req_canceled(struct tpm_chip *chip, u8 status)
>> +{
>> +	return false;
>> +}
>> +
>> +static struct tpm_class_ops tpm_chip_ops = {
>> +	.flags = TPM_OPS_AUTO_STARTUP,
>> +	.recv = tpm_svsm_recv,
>> +	.send = tpm_svsm_send,
>> +	.cancel = tpm_svsm_cancel,
>> +	.status = tpm_svsm_status,
>> +	.req_complete_mask = 0,
>> +	.req_complete_val = 0,
>> +	.req_canceled = tpm_svsm_req_canceled,
>
>If this was bundled with the patch set, this would short a lot:
>
>https://lore.kernel.org/linux-integrity/20250326161838.123606-1-jarkko@kernel.org/T/#u
>
>So maybe for v5? Including this patch does not take send_recv()
>out of consideration, it is just smart thing to do in all cases.
>
>It would be probably easiest to roll out my patch together with
>rest of the patch set.

Yeah, I agree. I'll include it in this series and adapt this patch on 
top of it.

Thanks,
Stefano


