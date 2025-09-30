Return-Path: <linux-kernel+bounces-837679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7314BACE74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193511924D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2292FC873;
	Tue, 30 Sep 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvphLpzu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D42DA779
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236304; cv=none; b=K6Nr00ZyTDt6KtlJMjh1kfpjVAQ3FB8jMTUPy3h/ANzh0Ol60c2LdSYMb5WIDAzx5EFamrocL6ZDhzBzS1RAEU1mgxswR2DDi5TF2omiA2631l66iTeI4sOUTqlz6QiNlqc4zsTP6ifVj4qlJ7/e17xyMcgf30w3TdeemVxvnCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236304; c=relaxed/simple;
	bh=plNWFStnmBr3tHuQHipBbeJxTWpo2Yn2Mw/O70BkNRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw0A5JAOs2yuh0rl/spROrj/v+zfOTiTK6UPmoTtTJMxKb08y+Fwk2O1k3KkWIr7+h1HOlHfmlntkzOT5kQabfG0yA0FVqIatjitjRiKU0bRs5YlpqbwmjMQONKfJf+PC4OVVZ408qdWqh3SeBHSZ04HY8QdOlYCizaGCsNXzlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvphLpzu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759236301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDfkkiLno7LKSndyeERgNrn5us3hUZ9m47HxXngB3Bw=;
	b=gvphLpzuAmuPFLACsTZB/Co6koimJJxllukw9mdufjPdAg2qFf9AETU4s6MsV0eY1eUS9c
	8u9SYGqPnJcJLMHwZovfcGD7k1a8BF4iT7Zyugljdsx/LvN4iOaheXKth3+VNxQfcklw82
	MiZ1ZtnOsu8MHfWKJcZTdP+4dbgiEeA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-vtXgKyCxPwi0toOfurP7vA-1; Tue, 30 Sep 2025 08:45:00 -0400
X-MC-Unique: vtXgKyCxPwi0toOfurP7vA-1
X-Mimecast-MFC-AGG-ID: vtXgKyCxPwi0toOfurP7vA_1759236299
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-636260bcc31so2945109a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236299; x=1759841099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDfkkiLno7LKSndyeERgNrn5us3hUZ9m47HxXngB3Bw=;
        b=h3YWCa7SqV0eaSOSq856FHWUvDKScIGLNyGl+4ZD6I594C9ofU6eh2MjxGWTYn6Ckj
         C64Rl6IvK1qhCtw7GKfQETrI6hNRWSP0hmiGMZeRr6cW6CXtj68s0Gryc5exyJ2tvG6W
         fhR3eDkf5dkWcZP8xLO/YsbDJ3iqX471Ubm/UpdPprmtA4KkygowHMAbuESI7jj1tuVi
         U8jlzKvrjxBPdMJcDSjjNgiGnbsz/QI09MOAFWuux+tGUToH8myzuBMlxYAsf1zj42CN
         AdHX2RjYBeY55jFhR2XAJknNo3sFACotKdy3itWbrFdxsjCXaQ+UymkKkVR6MfbUzX4y
         gWcg==
X-Forwarded-Encrypted: i=1; AJvYcCVRR7FL5rYfmlqq0+NVLQdI7adQpfSLDg/of0w9bTuWezZsgB6xFwgfKKDdpsPPOQhVlvB6eIx1EHKLrp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrx3jOGef+Zq9cTfTqIvs+/Pm9EC8oZUsZWpzz5AO9yp2UHt5x
	ze4W/gW4sVgccVap89BKqo/6TvvjwFkuwsklSIxZd5Vk3hIRVO9HRkX7LVPqo7A2Rbx8TDxZk9e
	O9ISiY506eUaTBZMdiG4vNcS8m3km0NIGOb0CyYfj30FgsU9JjY1bPvyIoD7YuP7zzg==
X-Gm-Gg: ASbGncunEVJ2JPhcyAtw/b23uBWw1wI2D34BCZWesJS8vNcWlZRt635sCltcwtoFjyZ
	atQEK67H8QYNld6SPK+3J6ilLy1+xR8XHn7O9crY63DY/13rxk9fzWIdoza7I/bKfkx5dg59qm1
	tT+C/8sHSFJt5CncXW+O0N3zssjjI4C0MmPCRIZ8PlzxigM/Q5m9so5Qa2luSHhWWKj9ZgeDD5G
	Y0To5wrjys//1G4BHetIE5CWNPK3Ec0BwP3A/j6hWdHnT1ehYquI9ZJ0JgVsMna/JQwjgBlL4Ds
	I8//AeIe4U76sBjJgU8+5tXglQHTscxXjoLgsPACLZp1QjmwejKwRAydEhTLKJKdGAdiyaRyv50
	8KPgdt259RdZeM5Fqm/4vMQ==
X-Received: by 2002:aa7:cf8f:0:b0:634:5705:5719 with SMTP id 4fb4d7f45d1cf-6349f9cbc0cmr15654169a12.5.1759236299050;
        Tue, 30 Sep 2025 05:44:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWjX0lAIHN77rTFgsGAB1ZWIvuPTnEmj+YJ9jSx5d90cxaiPJqKI2VaCZxNG01vp+wO4XrHA==
X-Received: by 2002:aa7:cf8f:0:b0:634:5705:5719 with SMTP id 4fb4d7f45d1cf-6349f9cbc0cmr15654146a12.5.1759236298540;
        Tue, 30 Sep 2025 05:44:58 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a362986dsm9595887a12.1.2025.09.30.05.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:44:57 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:44:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com, 
	ross.philipson@oracle.com, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, 
	Stefan Berger <stefanb@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] tpm-buf: Enable managed and stack allocations.
Message-ID: <u7zay2gb3dff4ptbh34qw7ini63ar3246ivd4xnxtdxc6ijktx@lutatpeg7f7z>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-11-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250929194832.2913286-11-jarkko@kernel.org>

On Mon, Sep 29, 2025 at 10:48:32PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Decouple kzalloc from buffer creation, so that  a managed allocation can be
>done trivially:
>
>	struct tpm_buf *buf __free(kfree) buf = kzalloc(TPM_BUFSIZE,
                                                         ^
In the code, we use PAGE_SIZE instead of TPM_BUFSIZE with kzalloc().
Should we do the same in this example? (Perhaps adding the reason, if 
you think it would be useful)

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
>Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
>v3:
>- A new patch from the earlier series with more scoped changes and
>  less abstract commit message.
>---
> drivers/char/tpm/tpm-buf.c                | 122 +++++----
> drivers/char/tpm/tpm-sysfs.c              |  20 +-
> drivers/char/tpm/tpm.h                    |   1 -
> drivers/char/tpm/tpm1-cmd.c               | 147 +++++------
> drivers/char/tpm/tpm2-cmd.c               | 290 ++++++++++------------
> drivers/char/tpm/tpm2-sessions.c          | 121 +++++----
> drivers/char/tpm/tpm2-space.c             |  44 ++--
> drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +--
> include/linux/tpm.h                       |  18 +-
> security/keys/trusted-keys/trusted_tpm1.c |  34 ++-
> security/keys/trusted-keys/trusted_tpm2.c | 176 ++++++-------
> 11 files changed, 482 insertions(+), 521 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
>index c9e6e5d097ca..1cb649938c01 100644
>--- a/drivers/char/tpm/tpm-buf.c
>+++ b/drivers/char/tpm/tpm-buf.c
>@@ -7,82 +7,109 @@
> #include <linux/module.h>
> #include <linux/tpm.h>
>
>-/**
>- * tpm_buf_init() - Allocate and initialize a TPM command
>- * @buf:	A &tpm_buf
>- * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
>- * @ordinal:	A command ordinal
>- *
>- * Return: 0 or -ENOMEM
>- */
>-int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>+static void __tpm_buf_size_invariant(struct tpm_buf *buf, u16 buf_size)
> {
>-	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
>-	if (!buf->data)
>-		return -ENOMEM;
>-
>-	tpm_buf_reset(buf, tag, ordinal);
>-	return 0;
>+	u32 buf_size_2 = (u32)buf->capacity + (u32)sizeof(*buf);
>+
>+	if (!buf->capacity) {
>+		if (buf_size > TPM_BUFSIZE) {
>+			WARN(1, "%s: size overflow: %u\n", __func__, buf_size);
>+			buf->flags |= TPM_BUF_INVALID;
>+		}
>+	} else {
>+		if (buf_size != buf_size_2) {
>+			WARN(1, "%s: size mismatch: %u != %u\n", __func__, buf_size,
>+			     buf_size_2);
>+			buf->flags |= TPM_BUF_INVALID;
>+		}
>+	}
> }
>-EXPORT_SYMBOL_GPL(tpm_buf_init);
>
>-/**
>- * tpm_buf_reset() - Initialize a TPM command
>- * @buf:	A &tpm_buf
>- * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
>- * @ordinal:	A command ordinal
>- */
>-void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>+static void __tpm_buf_reset(struct tpm_buf *buf, u16 buf_size, u16 tag, u32 ordinal)
> {
> 	struct tpm_header *head = (struct tpm_header *)buf->data;
>
>+	__tpm_buf_size_invariant(buf, buf_size);
>+
>+	if (buf->flags & TPM_BUF_INVALID)
>+		return;
>+
> 	WARN_ON(tag != TPM_TAG_RQU_COMMAND && tag != TPM2_ST_NO_SESSIONS &&
> 		tag != TPM2_ST_SESSIONS && tag != 0);
>
> 	buf->flags = 0;
> 	buf->length = sizeof(*head);
>+	buf->capacity = buf_size - sizeof(*buf);
>+	buf->handles = 0;
> 	head->tag = cpu_to_be16(tag);
> 	head->length = cpu_to_be32(sizeof(*head));
> 	head->ordinal = cpu_to_be32(ordinal);
>+}
>+
>+static void __tpm_buf_reset_sized(struct tpm_buf *buf, u16 buf_size)
>+{
>+	__tpm_buf_size_invariant(buf, buf_size);
>+
>+	if (buf->flags & TPM_BUF_INVALID)
>+		return;
>+
>+	buf->flags = TPM_BUF_TPM2B;
>+	buf->length = 2;
>+	buf->capacity = buf_size - sizeof(*buf);
> 	buf->handles = 0;
>+	buf->data[0] = 0;
>+	buf->data[1] = 0;
> }
>-EXPORT_SYMBOL_GPL(tpm_buf_reset);
>
> /**
>- * tpm_buf_init_sized() - Allocate and initialize a sized (TPM2B) buffer
>- * @buf:	A @tpm_buf
>- *
>- * Return: 0 or -ENOMEM
>+ * tpm_buf_init() - Initialize a TPM command
>+ * @buf:	A &tpm_buf
>+ * @buf_size:	Size of the buffer.
>  */
>-int tpm_buf_init_sized(struct tpm_buf *buf)
>+void tpm_buf_init(struct tpm_buf *buf, u16 buf_size)
> {
>-	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
>-	if (!buf->data)
>-		return -ENOMEM;
>+	memset(buf, 0, buf_size);
>+	__tpm_buf_reset(buf, buf_size, TPM_TAG_RQU_COMMAND, 0);
>+}
>+EXPORT_SYMBOL_GPL(tpm_buf_init);
>
>-	tpm_buf_reset_sized(buf);
>-	return 0;
>+/**
>+ * tpm_buf_init_sized() - Initialize a sized buffer
>+ * @buf:	A &tpm_buf
>+ * @buf_size:	Size of the buffer.
>+ */
>+void tpm_buf_init_sized(struct tpm_buf *buf, u16 buf_size)
>+{
>+	memset(buf, 0, buf_size);
>+	__tpm_buf_reset_sized(buf, buf_size);
> }
> EXPORT_SYMBOL_GPL(tpm_buf_init_sized);
>
> /**
>- * tpm_buf_reset_sized() - Initialize a sized buffer
>+ * tpm_buf_reset() - Re-initialize a TPM command
>  * @buf:	A &tpm_buf
>+ * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
>+ * @ordinal:	A command ordinal
>  */
>-void tpm_buf_reset_sized(struct tpm_buf *buf)
>+void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> {
>-	buf->flags = TPM_BUF_TPM2B;
>-	buf->length = 2;
>-	buf->data[0] = 0;
>-	buf->data[1] = 0;
>+	u16 buf_size = buf->capacity + sizeof(*buf);
>+
>+	__tpm_buf_reset(buf, buf_size, tag, ordinal);
> }
>-EXPORT_SYMBOL_GPL(tpm_buf_reset_sized);
>+EXPORT_SYMBOL_GPL(tpm_buf_reset);
>
>-void tpm_buf_destroy(struct tpm_buf *buf)
>+/**
>+ * tpm_buf_reset_sized() - Re-initialize a sized buffer
>+ * @buf:	A &tpm_buf
>+ */
>+void tpm_buf_reset_sized(struct tpm_buf *buf)
> {
>-	free_page((unsigned long)buf->data);
>+	u16 buf_size = buf->capacity + sizeof(*buf);
>+
>+	__tpm_buf_reset_sized(buf, buf_size);
> }
>-EXPORT_SYMBOL_GPL(tpm_buf_destroy);
>+EXPORT_SYMBOL_GPL(tpm_buf_reset_sized);
>
> /**
>  * tpm_buf_length() - Return the number of bytes consumed by the data
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
>@@ -104,10 +134,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
>  */
> void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
> {
>+	u32 total_length = (u32)buf->length + (u32)new_length;
>+
> 	if (buf->flags & TPM_BUF_INVALID)
> 		return;
>
>-	if ((buf->length + new_length) > PAGE_SIZE) {
>+	if (total_length > (u32)buf->capacity) {
> 		WARN(1, "tpm_buf: write overflow\n");
> 		buf->flags |= TPM_BUF_INVALID;
> 		return;

[...]

>diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
>index 636acb66a4f6..6e6a9fb48e63 100644
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

(Sorry if it's a stupid question, but I'm still a bit new with this 
code).

> 	dump_tpm_buf(cmd);
>
>+	/* Convert TPM error to -EPERM. */
> 	if (rc > 0)
>-		/* TPM error */
> 		rc = -EPERM;
>
> 	tpm_put_ops(chip);
>@@ -624,23 +620,23 @@ static int tpm_unseal(struct tpm_buf *tb,
> static int key_seal(struct trusted_key_payload *p,
> 		    struct trusted_key_options *o)
> {
>-	struct tpm_buf tb;
> 	int ret;
>
>-	ret = tpm_buf_init(&tb, 0, 0);
>-	if (ret)
>-		return ret;
>+	struct tpm_buf *tb __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
>+	if (!tb)
>+		return -ENOMEM;
>+
>+	tpm_buf_init(tb, TPM_BUFSIZE);
>
> 	/* include migratable flag at end of sealed key */
> 	p->key[p->key_len] = p->migratable;
>
>-	ret = tpm_seal(&tb, o->keytype, o->keyhandle, o->keyauth,
>+	ret = tpm_seal(tb, o->keytype, o->keyhandle, o->keyauth,
> 		       p->key, p->key_len + 1, p->blob, &p->blob_len,
> 		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
> 	if (ret < 0)
> 		pr_info("srkseal failed (%d)\n", ret);
>
>-	tpm_buf_destroy(&tb);
> 	return ret;
> }
>
>@@ -650,14 +646,15 @@ static int key_seal(struct trusted_key_payload *p,
> static int key_unseal(struct trusted_key_payload *p,
> 		      struct trusted_key_options *o)
> {
>-	struct tpm_buf tb;
> 	int ret;
>
>-	ret = tpm_buf_init(&tb, 0, 0);
>-	if (ret)
>-		return ret;
>+	struct tpm_buf *tb __free(kfree) = kzalloc(PAGE_SIZE, 
>GFP_KERNEL);
>+	if (!tb)
>+		return -ENOMEM;
>+
>+	tpm_buf_init(tb, TPM_BUFSIZE);
>
>-	ret = tpm_unseal(&tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
>+	ret = tpm_unseal(tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
> 			 o->blobauth, p->key, &p->key_len);
> 	if (ret < 0)
> 		pr_info("srkunseal failed (%d)\n", ret);
>@@ -665,7 +662,6 @@ static int key_unseal(struct trusted_key_payload *p,
> 		/* pull migratable flag out of sealed key */
> 		p->migratable = p->key[--p->key_len];
>
>-	tpm_buf_destroy(&tb);
> 	return ret;
> }

The rest LGTM, but it's a huge patch (not your issue at all), so yeah 
not sure :-)

Thanks,
Stefano


