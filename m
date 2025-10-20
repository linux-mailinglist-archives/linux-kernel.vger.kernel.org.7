Return-Path: <linux-kernel+bounces-860415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E46ABF0158
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A4884F0E17
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B087A2E8B76;
	Mon, 20 Oct 2025 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1f2XP8D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F142BE03D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951104; cv=none; b=jBxj//U6qqMVyFqZ2abhDijM33HUrZ3C9/WP1AVyH+7AAyA99V1iOP8dgAQrSr6Tf26wpc/3cHFebwpxkdIn7SfcEGnXXeoeyY/580hvlszuxajnZRqyVYQALJMJaaHVbJsX0N6FgI35ewZRPTL+vk0qWl5pMqCocis+wXuTOwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951104; c=relaxed/simple;
	bh=KZuK0NW8g/jyi+GON1sj2/KfHSvjXYfSxqe8K2xhPPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atyNXyhh7CnXiVK9IrfAHeMnbDhLiCe5WLkKik4yFAFU3aQO0Ogz9Gg2H3wu2OpqKwqIO+zYnI7VRgHB3ZNvOjwiMMzVanA2yvKEew1d66vL9eAm4IRvHcgsboAmeV9+w91h8dVUirYA9Yab1/P1Mik8V8A5r6BZrK1sPX3OzWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1f2XP8D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760951101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22yfNbJ+mpY0goN/o5ffj6htndw8FKixezqcENam2+w=;
	b=e1f2XP8DWJKcyXuzJWcka0LIuiIYGiDw861XczIG4W+8Ad/O1gspov4mIymN/rpHqF0fjp
	0MGHAVUW4VIiZv3hfCRyA4jJQEUFcBlKnP+oUu8ahsSrUimSq9siytbehwsYEWWh+ngc0w
	sK82IXk3RSiXdbaANhKgkeCidLh9cVw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-wjA7secINj2q7A_oVtBfLA-1; Mon, 20 Oct 2025 05:04:58 -0400
X-MC-Unique: wjA7secINj2q7A_oVtBfLA-1
X-Mimecast-MFC-AGG-ID: wjA7secINj2q7A_oVtBfLA_1760951098
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b479e43ad46so344427666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951098; x=1761555898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22yfNbJ+mpY0goN/o5ffj6htndw8FKixezqcENam2+w=;
        b=XoWh26/Rj6P1HR0FH9SHgDTaOs0t+Oyu9JeYUTYcChnPnuhGV2zyWQYhT5EzbPT9LI
         7tGy9877j4T+p53fdu5+R0LwjCH1TR1mvNd0uQxXnzl5iSxJIU270IGK2JqpSRBWyjqd
         g0q28pMPma3r7Z6/cOxQndt8gPKflHUFTnHLi1UreNolM1QfRVItSxh0oWs5q1pxFJUl
         mZxEZ2fvNyU5KzthlytCqh/XHoO56td+MlPyjcDPWG+2xc0wRC1ElQ7R2TpKC2Fn5zGL
         i+zctZqfPyCJMT6GDkA/se/sYPiaFyfjmh5Fj90d2aq1YWlJJOzxzLOJnwMEWY8cX/Sl
         5a3A==
X-Forwarded-Encrypted: i=1; AJvYcCUX/BBRptbsXvlGWbsv+5iOUxeTt/xwc/HSGSXd5Sq9I81TBB3sy43pq8Y9t+MkMRJuBTr9RjoiGTrB0H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqzA8MIu4jS9iMW/1g8gRFUsZrwdqIqdPC5jHMh0jS+HFNWZM
	ZlOctscqtH8sNMTLZ7p95I+RXh06VLxOadCVrHeVHpJ0eABaICRc9uNiEwxqbL/y20+kDZN1mto
	kPpeAgMaVnl54aagw+SHHQIj+mIw9g2DrcE0g1gOhSVObEAnKSFO5yq95C8GT0Fhk7A==
X-Gm-Gg: ASbGncutnK8mDADlV1t3FZmCcU2SkeyO99eBOovwZA0Nq4kujvDyXeICd38F5U9+UsT
	uU/oZTndY1WylGNBUL6qIpThqDBQj4H+wPXgqCQJTA0QoJc/SqqIOHlAWVw8In2dFAy6uZICdR0
	UkKiNSbrm9BDv3pSZeJ8boUOhHGB0/XjrWs4/wWXfDahXbkcwdGP4prcvvwsE9El2mxtYxF399d
	QapZ3aW1/oE1hq193movGxn60Z+nzLsacDLQtSNlc7cAsvqAkyz2VAskZHFkPvYIY6dYi5e43Yv
	TwJrV69aE62ItiIU0EpdkUFhCAPQFWNuP8U0boGUh+IwoiwO/B9s+sKLivORu93nYDgdHygzBNU
	mj8pJS3WEdiG1RNDTApKX1DSipF+Z+Qs/z2LCPExphlW2Y6EjK8U=
X-Received: by 2002:a17:906:fe41:b0:b45:a6e6:97b4 with SMTP id a640c23a62f3a-b64764e2fd5mr1384717366b.50.1760951097653;
        Mon, 20 Oct 2025 02:04:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe2BUld3tY9H9mPNFll8sWB6BjRuOwgWEhUFvxf6FyCKHjQQuGnV1QEE2cqA4E1arzNlugSg==
X-Received: by 2002:a17:906:fe41:b0:b45:a6e6:97b4 with SMTP id a640c23a62f3a-b64764e2fd5mr1384713366b.50.1760951097175;
        Mon, 20 Oct 2025 02:04:57 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da1b96sm739516666b.1.2025.10.20.02.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:04:56 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:04:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyring@vger.kernel.org, 
	dpsmith@apertussolutions.com, ross.philipson@oracle.com, Jonathan McDowell <noodles@earth.li>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, 
	Stefan Berger <stefanb@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 10/10] tpm-buf: Enable managed and stack allocations.
Message-ID: <yynqxoqux5whcbsnticikhwmupqh57xfbll5egzkn42kj7gkaf@s4kwxfmto5ia>
References: <20251018111725.3116386-1-jarkko@kernel.org>
 <20251018111725.3116386-11-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251018111725.3116386-11-jarkko@kernel.org>

On Sat, Oct 18, 2025 at 02:17:25PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Decouple kzalloc from buffer creation, so that a managed allocation can be
>done trivially:
>
>	struct tpm_buf *buf __free(kfree) buf = kzalloc(TPM_BUFSIZE,
>							GFP_KERNEL);
>	if (!buf)
>		return -ENOMEM;
>	tpm_buf_init(buf, TPM_BUFSIZE);
>
>Alternatively, stack allocations are also possible:
>
>	u8 buf_data[512];
>	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
>	tpm_buf_init(buf, sizeof(buf_data));
>
>Given that every single tpm_transmit_cmd() call site needs to be changed,
>place command names from TCG 1.2 and 2.0 specifications to the @dest
>parameter, which will e.g., help tracing bugs.

Perhaps my previous message fell through the cracks, but I still have a 
couple of comments (perhaps trivial, sorry in that case) that have not 
been answered about this patch:

>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>---
>v6
>- Update commit message.
>v5:
>- There was a spurious change in tpm2_seal_trusted() error
>  code handling introduce by this patch.
>v4:
>- Since every single tpm_transmit_cmd() call site needs to be
>  changed anyhow, use 'dest' parameter more structured and
>  actually useful way, and pick the string TCG 1.2 and 2.0
>  specifications.
>- tpm1-cmd: Remove useless rc declarations and repliace them
>  with trivial "return tpm_transmit_cmd" statement.
>- Reverted spurious changes in include/linux/tpm.h.
>- Use concisely TPM_BUFSIZE instead of PAGE_SIZE.
>v3:
>- A new patch from the earlier series with more scoped changes and
>  less abstract commit message.
>---
> drivers/char/tpm/tpm-buf.c                | 122 +++++----
> drivers/char/tpm/tpm-sysfs.c              |  21 +-
> drivers/char/tpm/tpm.h                    |   1 -
> drivers/char/tpm/tpm1-cmd.c               | 162 +++++-------
> drivers/char/tpm/tpm2-cmd.c               | 299 ++++++++++------------
> drivers/char/tpm/tpm2-sessions.c          | 122 +++++----
> drivers/char/tpm/tpm2-space.c             |  44 ++--
> drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +--
> include/linux/tpm.h                       |  18 +-
> security/keys/trusted-keys/trusted_tpm1.c |  34 ++-
> security/keys/trusted-keys/trusted_tpm2.c | 175 ++++++-------
> 11 files changed, 484 insertions(+), 544 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
>index 1b9dee0d0681..a3bf3c3d0c48 100644
>--- a/drivers/char/tpm/tpm-buf.c
>+++ b/drivers/char/tpm/tpm-buf.c

[...]

>@@ -92,6 +119,9 @@ EXPORT_SYMBOL_GPL(tpm_buf_destroy);
>  */
> u32 tpm_buf_length(struct tpm_buf *buf)

Should we update the return value to u16?


> {
>+	if (buf->flags & TPM_BUF_INVALID)
>+		return 0;
>+
> 	return buf->length;
> }
> EXPORT_SYMBOL_GPL(tpm_buf_length);

[...]

>diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
>index 636acb66a4f6..3ac204a902de 100644
>--- a/security/keys/trusted-keys/trusted_tpm1.c
>+++ b/security/keys/trusted-keys/trusted_tpm1.c
>@@ -310,9 +310,8 @@ static int TSS_checkhmac2(unsigned char *buffer,
>  * For key specific tpm requests, we will generate and send our
>  * own TPM command packets using the drivers send function.
>  */
>-static int trusted_tpm_send(unsigned char *cmd, size_t buflen)
>+static int trusted_tpm_send(void *cmd, size_t buflen)
> {
>-	struct tpm_buf buf;
> 	int rc;
>
> 	if (!chip)
>@@ -322,15 +321,12 @@ static int trusted_tpm_send(unsigned char *cmd, size_t buflen)
> 	if (rc)
> 		return rc;
>
>-	buf.flags = 0;
>-	buf.length = buflen;
>-	buf.data = cmd;
> 	dump_tpm_buf(cmd);
>-	rc = tpm_transmit_cmd(chip, &buf, 4, "sending data");
>+	rc = tpm_transmit_cmd(chip, cmd, 4, "sending data");

Is it fine here to remove the intermediate tpm_buf ?

IIUC tpm_transmit_cmd() needs a tpm_buf, while here we are passing just
the "data", or in some way it's a nested tpm_buf?

> 	dump_tpm_buf(cmd);
>
>+	/* Convert TPM error to -EPERM. */
> 	if (rc > 0)
>-		/* TPM error */
> 		rc = -EPERM;
>
> 	tpm_put_ops(chip);

Thanks,
Stefano


