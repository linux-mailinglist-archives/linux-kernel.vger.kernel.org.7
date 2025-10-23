Return-Path: <linux-kernel+bounces-867326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C422C02449
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0DB3A6009
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7966925784F;
	Thu, 23 Oct 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="D1gM4F8i"
Received: from smtp86.iad3b.emailsrvr.com (smtp86.iad3b.emailsrvr.com [146.20.161.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B93594F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235023; cv=none; b=f0hMjfVqd31cZgmyB3RQxIkUzIcCWskAa7++r71J/Mp/B2U6hrSp9eM2KvYEPfww6mzRUproGRpR6cng2rue17CvqaOtDsNAMa7OzxcohDKzmJ/sVfL2lVHTNZAepKG8pN2nveo4Ul9vY2EczUWgkZowlexGQTGkzHpQlORIlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235023; c=relaxed/simple;
	bh=FmPZiT98w2k7d+SqTmblsmMypwu/9ii4PANd60nJCE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aW/8gTtiEw8EwoRkItNI/CZFxetDmNj9Fn6poadUX7WsdIRxuYwAiTCsPbd0iw+vYN58mmUGEomsdC2PF24YIzqWUc6kOPlLWylhNulX48EsTmqHJNbPl4zGX11QiEbRQUewN3ELKJKnMZ/ZNifm7+N+ToVKNPZzSq/Jf3FkLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=D1gM4F8i; arc=none smtp.client-ip=146.20.161.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761226290;
	bh=FmPZiT98w2k7d+SqTmblsmMypwu/9ii4PANd60nJCE8=;
	h=From:To:Subject:Date:From;
	b=D1gM4F8iHs7nCkW2mMQT7ewuZNbmJgfFa/8ImazO+PjJbiAzIWnmZoQ6ulbde0j96
	 38YvHZCkoaEWmdTBRx9iAaUF34iVkxBj2JwgzG3+6wWa8wovRKE1pVLY1Wzpk1yxwP
	 w7VYBUY9vq4FGmvxvGy5J4OAgoKkdImC/B2IzqfU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp11.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id AA74E4042D;
	Thu, 23 Oct 2025 09:31:29 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 2/2] comedi: Use reference count for asynchronous command functions
Date: Thu, 23 Oct 2025 14:28:19 +0100
Message-ID: <20251023133001.8439-3-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023133001.8439-1-abbotti@mev.co.uk>
References: <20251023133001.8439-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 06accbc7-f6e3-458a-bef4-026d948b4d7a-3-1

For interrupts from badly behaved hardware (as emulated by Syzbot), it
is possible for the Comedi core functions that manage the progress of
asynchronous data acquisition to be called from driver ISRs while no
asynchronous command has been set up, which can cause problems such as
invalid pointer dereferencing or dividing by zero.

Change those functions in the Comedi core to use this pattern: if
`comedi_get_is_subdevice_running(s)` returns `true` then call a safe
version of the function with the same name prefixed with an underscore,
followed by a call to `comedi_put_is_subdevice_running(s)`, otherwise
take some default action.

`comedi_get_is_subdevice_running(s)` returning `true` ensures that the
details of the asynchronous command will not be destroyed before the
matching call to `comedi_put_is_subdevice_running(s)`.

Replace calls to those functions from elsewhere in the Comedi core with
calls to the safe versions of the functions.

The modified functions are: `comedi_buf_read_alloc()`,
`comedi_buf_read_free()`, `comedi_buf_read_n_available()`,
`comedi_buf_read_samples()`, `comedi_buf_write_alloc()`,
`comedi_buf_write_free()`, `comedi_buf_write_samples()`,
`comedi_bytes_per_scan()`, `comedi_event()`, `comedi_handle_events()`,
`comedi_inc_scan_progress()`, `comedi_nsamples_left()`,
`comedi_nscans_left()`.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/comedi_buf.c      | 274 ++++++++++++++++++++-----------
 drivers/comedi/comedi_fops.c     |  56 ++++---
 drivers/comedi/comedi_internal.h |  12 ++
 drivers/comedi/drivers.c         | 133 +++++++++++----
 4 files changed, 323 insertions(+), 152 deletions(-)

diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 002c0e76baff..37074225d590 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -273,19 +273,8 @@ unsigned int comedi_buf_write_n_available(struct comedi_subdevice *s)
 	return free_end - async->buf_write_count;
 }
 
-/**
- * comedi_buf_write_alloc() - Reserve buffer space for writing
- * @s: COMEDI subdevice.
- * @nbytes: Maximum space to reserve in bytes.
- *
- * Reserve up to @nbytes bytes of space to be written in the COMEDI acquisition
- * data buffer associated with the subdevice.  The amount reserved is limited
- * by the space available.
- *
- * Return: The amount of space reserved in bytes.
- */
-unsigned int comedi_buf_write_alloc(struct comedi_subdevice *s,
-				    unsigned int nbytes)
+unsigned int _comedi_buf_write_alloc(struct comedi_subdevice *s,
+				     unsigned int nbytes)
 {
 	struct comedi_async *async = s->async;
 	unsigned int unalloc = comedi_buf_write_n_unalloc(s);
@@ -303,6 +292,29 @@ unsigned int comedi_buf_write_alloc(struct comedi_subdevice *s,
 
 	return nbytes;
 }
+
+/**
+ * comedi_buf_write_alloc() - Reserve buffer space for writing
+ * @s: COMEDI subdevice.
+ * @nbytes: Maximum space to reserve in bytes.
+ *
+ * Reserve up to @nbytes bytes of space to be written in the COMEDI acquisition
+ * data buffer associated with the subdevice.  The amount reserved is limited
+ * by the space available.
+ *
+ * Return: The amount of space reserved in bytes.
+ */
+unsigned int comedi_buf_write_alloc(struct comedi_subdevice *s,
+				    unsigned int nbytes)
+{
+	if (comedi_get_is_subdevice_running(s)) {
+		nbytes = _comedi_buf_write_alloc(s, nbytes);
+		comedi_put_is_subdevice_running(s);
+	} else {
+		nbytes = 0;
+	}
+	return nbytes;
+}
 EXPORT_SYMBOL_GPL(comedi_buf_write_alloc);
 
 /*
@@ -362,6 +374,24 @@ unsigned int comedi_buf_write_n_allocated(struct comedi_subdevice *s)
 	return async->buf_write_alloc_count - async->buf_write_count;
 }
 
+unsigned int _comedi_buf_write_free(struct comedi_subdevice *s,
+				    unsigned int nbytes)
+{
+	struct comedi_async *async = s->async;
+	unsigned int allocated = comedi_buf_write_n_allocated(s);
+
+	if (nbytes > allocated)
+		nbytes = allocated;
+
+	async->buf_write_count += nbytes;
+	async->buf_write_ptr += nbytes;
+	comedi_buf_munge(s, async->buf_write_count - async->munge_count);
+	if (async->buf_write_ptr >= async->prealloc_bufsz)
+		async->buf_write_ptr %= async->prealloc_bufsz;
+
+	return nbytes;
+}
+
 /**
  * comedi_buf_write_free() - Free buffer space after it is written
  * @s: COMEDI subdevice.
@@ -379,22 +409,35 @@ unsigned int comedi_buf_write_n_allocated(struct comedi_subdevice *s)
  */
 unsigned int comedi_buf_write_free(struct comedi_subdevice *s,
 				   unsigned int nbytes)
+{
+	if (comedi_get_is_subdevice_running(s)) {
+		nbytes = _comedi_buf_write_free(s, nbytes);
+		comedi_put_is_subdevice_running(s);
+	} else {
+		nbytes = 0;
+	}
+	return nbytes;
+}
+EXPORT_SYMBOL_GPL(comedi_buf_write_free);
+
+unsigned int _comedi_buf_read_n_available(struct comedi_subdevice *s)
 {
 	struct comedi_async *async = s->async;
-	unsigned int allocated = comedi_buf_write_n_allocated(s);
+	unsigned int num_bytes;
 
-	if (nbytes > allocated)
-		nbytes = allocated;
+	if (!async)
+		return 0;
 
-	async->buf_write_count += nbytes;
-	async->buf_write_ptr += nbytes;
-	comedi_buf_munge(s, async->buf_write_count - async->munge_count);
-	if (async->buf_write_ptr >= async->prealloc_bufsz)
-		async->buf_write_ptr %= async->prealloc_bufsz;
+	num_bytes = async->munge_count - async->buf_read_count;
 
-	return nbytes;
+	/*
+	 * ensure the async buffer 'counts' are read before we
+	 * attempt to read data from the buffer
+	 */
+	smp_rmb();
+
+	return num_bytes;
 }
-EXPORT_SYMBOL_GPL(comedi_buf_write_free);
 
 /**
  * comedi_buf_read_n_available() - Determine amount of readable buffer space
@@ -409,23 +452,38 @@ EXPORT_SYMBOL_GPL(comedi_buf_write_free);
  */
 unsigned int comedi_buf_read_n_available(struct comedi_subdevice *s)
 {
-	struct comedi_async *async = s->async;
 	unsigned int num_bytes;
 
-	if (!async)
-		return 0;
+	if (comedi_get_is_subdevice_running(s)) {
+		num_bytes = _comedi_buf_read_n_available(s);
+		comedi_put_is_subdevice_running(s);
+	} else {
+		num_bytes = 0;
+	}
+	return num_bytes;
+}
+EXPORT_SYMBOL_GPL(comedi_buf_read_n_available);
 
-	num_bytes = async->munge_count - async->buf_read_count;
+unsigned int _comedi_buf_read_alloc(struct comedi_subdevice *s,
+				    unsigned int nbytes)
+{
+	struct comedi_async *async = s->async;
+	unsigned int available;
+
+	available = async->munge_count - async->buf_read_alloc_count;
+	if (nbytes > available)
+		nbytes = available;
+
+	async->buf_read_alloc_count += nbytes;
 
 	/*
 	 * ensure the async buffer 'counts' are read before we
-	 * attempt to read data from the buffer
+	 * attempt to read data from the read-alloc'ed buffer space
 	 */
 	smp_rmb();
 
-	return num_bytes;
+	return nbytes;
 }
-EXPORT_SYMBOL_GPL(comedi_buf_read_n_available);
 
 /**
  * comedi_buf_read_alloc() - Reserve buffer space for reading
@@ -445,21 +503,12 @@ EXPORT_SYMBOL_GPL(comedi_buf_read_n_available);
 unsigned int comedi_buf_read_alloc(struct comedi_subdevice *s,
 				   unsigned int nbytes)
 {
-	struct comedi_async *async = s->async;
-	unsigned int available;
-
-	available = async->munge_count - async->buf_read_alloc_count;
-	if (nbytes > available)
-		nbytes = available;
-
-	async->buf_read_alloc_count += nbytes;
-
-	/*
-	 * ensure the async buffer 'counts' are read before we
-	 * attempt to read data from the read-alloc'ed buffer space
-	 */
-	smp_rmb();
-
+	if (comedi_get_is_subdevice_running(s)) {
+		nbytes = _comedi_buf_read_alloc(s, nbytes);
+		comedi_put_is_subdevice_running(s);
+	} else {
+		nbytes = 0;
+	}
 	return nbytes;
 }
 EXPORT_SYMBOL_GPL(comedi_buf_read_alloc);
@@ -469,21 +518,8 @@ static unsigned int comedi_buf_read_n_allocated(struct comedi_async *async)
 	return async->buf_read_alloc_count - async->buf_read_count;
 }
 
-/**
- * comedi_buf_read_free() - Free buffer space after it has been read
- * @s: COMEDI subdevice.
- * @nbytes: Maximum space to free in bytes.
- *
- * Free up to @nbytes bytes of buffer space previously reserved for reading in
- * the COMEDI acquisition data buffer associated with the subdevice.  The
- * amount of space freed is limited to the amount that was reserved.
- *
- * The freed space becomes available for allocation by the writer.
- *
- * Return: The amount of space freed in bytes.
- */
-unsigned int comedi_buf_read_free(struct comedi_subdevice *s,
-				  unsigned int nbytes)
+unsigned int _comedi_buf_read_free(struct comedi_subdevice *s,
+				   unsigned int nbytes)
 {
 	struct comedi_async *async = s->async;
 	unsigned int allocated;
@@ -503,6 +539,31 @@ unsigned int comedi_buf_read_free(struct comedi_subdevice *s,
 	async->buf_read_ptr %= async->prealloc_bufsz;
 	return nbytes;
 }
+
+/**
+ * comedi_buf_read_free() - Free buffer space after it has been read
+ * @s: COMEDI subdevice.
+ * @nbytes: Maximum space to free in bytes.
+ *
+ * Free up to @nbytes bytes of buffer space previously reserved for reading in
+ * the COMEDI acquisition data buffer associated with the subdevice.  The
+ * amount of space freed is limited to the amount that was reserved.
+ *
+ * The freed space becomes available for allocation by the writer.
+ *
+ * Return: The amount of space freed in bytes.
+ */
+unsigned int comedi_buf_read_free(struct comedi_subdevice *s,
+				  unsigned int nbytes)
+{
+	if (comedi_get_is_subdevice_running(s)) {
+		nbytes = _comedi_buf_read_free(s, nbytes);
+		comedi_put_is_subdevice_running(s);
+	} else {
+		nbytes = 0;
+	}
+	return nbytes;
+}
 EXPORT_SYMBOL_GPL(comedi_buf_read_free);
 
 static void comedi_buf_memcpy_to(struct comedi_subdevice *s,
@@ -558,6 +619,38 @@ static void comedi_buf_memcpy_from(struct comedi_subdevice *s,
 	}
 }
 
+static unsigned int _comedi_buf_write_samples(struct comedi_subdevice *s,
+					      const void *data,
+					      unsigned int nsamples)
+{
+	unsigned int max_samples;
+	unsigned int nbytes;
+
+	/*
+	 * Make sure there is enough room in the buffer for all the samples.
+	 * If not, clamp the nsamples to the number that will fit, flag the
+	 * buffer overrun and add the samples that fit.
+	 */
+	max_samples = comedi_bytes_to_samples(s, comedi_buf_write_n_unalloc(s));
+	if (nsamples > max_samples) {
+		dev_warn(s->device->class_dev, "buffer overrun\n");
+		s->async->events |= COMEDI_CB_OVERFLOW;
+		nsamples = max_samples;
+	}
+
+	if (nsamples == 0)
+		return 0;
+
+	nbytes = comedi_samples_to_bytes(s, nsamples);
+	nbytes = _comedi_buf_write_alloc(s, nbytes);
+	comedi_buf_memcpy_to(s, data, nbytes);
+	_comedi_buf_write_free(s, nbytes);
+	_comedi_inc_scan_progress(s, nbytes);
+	s->async->events |= COMEDI_CB_BLOCK;
+
+	return nbytes;
+}
+
 /**
  * comedi_buf_write_samples() - Write sample data to COMEDI buffer
  * @s: COMEDI subdevice.
@@ -577,35 +670,43 @@ static void comedi_buf_memcpy_from(struct comedi_subdevice *s,
  */
 unsigned int comedi_buf_write_samples(struct comedi_subdevice *s,
 				      const void *data, unsigned int nsamples)
+{
+	unsigned int nbytes;
+
+	if (comedi_get_is_subdevice_running(s)) {
+		nbytes = _comedi_buf_write_samples(s, data, nsamples);
+		comedi_put_is_subdevice_running(s);
+	} else {
+		nbytes = 0;
+	}
+	return nbytes;
+}
+EXPORT_SYMBOL_GPL(comedi_buf_write_samples);
+
+static unsigned int _comedi_buf_read_samples(struct comedi_subdevice *s,
+					    void *data, unsigned int nsamples)
 {
 	unsigned int max_samples;
 	unsigned int nbytes;
 
-	/*
-	 * Make sure there is enough room in the buffer for all the samples.
-	 * If not, clamp the nsamples to the number that will fit, flag the
-	 * buffer overrun and add the samples that fit.
-	 */
-	max_samples = comedi_bytes_to_samples(s, comedi_buf_write_n_unalloc(s));
-	if (nsamples > max_samples) {
-		dev_warn(s->device->class_dev, "buffer overrun\n");
-		s->async->events |= COMEDI_CB_OVERFLOW;
+	/* clamp nsamples to the number of full samples available */
+	max_samples = comedi_bytes_to_samples(s,
+					      _comedi_buf_read_n_available(s));
+	if (nsamples > max_samples)
 		nsamples = max_samples;
-	}
 
 	if (nsamples == 0)
 		return 0;
 
-	nbytes = comedi_buf_write_alloc(s,
+	nbytes = _comedi_buf_read_alloc(s,
 					comedi_samples_to_bytes(s, nsamples));
-	comedi_buf_memcpy_to(s, data, nbytes);
-	comedi_buf_write_free(s, nbytes);
-	comedi_inc_scan_progress(s, nbytes);
+	comedi_buf_memcpy_from(s, data, nbytes);
+	_comedi_buf_read_free(s, nbytes);
+	_comedi_inc_scan_progress(s, nbytes);
 	s->async->events |= COMEDI_CB_BLOCK;
 
 	return nbytes;
 }
-EXPORT_SYMBOL_GPL(comedi_buf_write_samples);
 
 /**
  * comedi_buf_read_samples() - Read sample data from COMEDI buffer
@@ -624,25 +725,14 @@ EXPORT_SYMBOL_GPL(comedi_buf_write_samples);
 unsigned int comedi_buf_read_samples(struct comedi_subdevice *s,
 				     void *data, unsigned int nsamples)
 {
-	unsigned int max_samples;
 	unsigned int nbytes;
 
-	/* clamp nsamples to the number of full samples available */
-	max_samples = comedi_bytes_to_samples(s,
-					      comedi_buf_read_n_available(s));
-	if (nsamples > max_samples)
-		nsamples = max_samples;
-
-	if (nsamples == 0)
-		return 0;
-
-	nbytes = comedi_buf_read_alloc(s,
-				       comedi_samples_to_bytes(s, nsamples));
-	comedi_buf_memcpy_from(s, data, nbytes);
-	comedi_buf_read_free(s, nbytes);
-	comedi_inc_scan_progress(s, nbytes);
-	s->async->events |= COMEDI_CB_BLOCK;
-
+	if (comedi_get_is_subdevice_running(s)) {
+		nbytes = _comedi_buf_read_samples(s, data, nsamples);
+		comedi_put_is_subdevice_running(s);
+	} else {
+		nbytes = 0;
+	}
 	return nbytes;
 }
 EXPORT_SYMBOL_GPL(comedi_buf_read_samples);
diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 595723e24c74..95663b8f89b6 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1206,15 +1206,15 @@ static int do_bufinfo_ioctl(struct comedi_device *dev,
 	if (!(async->cmd.flags & CMDF_WRITE)) {
 		/* command was set up in "read" direction */
 		if (bi.bytes_read) {
-			comedi_buf_read_alloc(s, bi.bytes_read);
-			bi.bytes_read = comedi_buf_read_free(s, bi.bytes_read);
+			_comedi_buf_read_alloc(s, bi.bytes_read);
+			bi.bytes_read = _comedi_buf_read_free(s, bi.bytes_read);
 		}
 		/*
 		 * If nothing left to read, and command has stopped, and
 		 * {"read" position not updated or command stopped normally},
 		 * then become non-busy.
 		 */
-		if (comedi_buf_read_n_available(s) == 0 &&
+		if (_comedi_buf_read_n_available(s) == 0 &&
 		    !comedi_is_runflags_running(runflags) &&
 		    (bi.bytes_read == 0 ||
 		     !comedi_is_runflags_in_error(runflags))) {
@@ -1231,9 +1231,9 @@ static int do_bufinfo_ioctl(struct comedi_device *dev,
 			if (comedi_is_runflags_in_error(runflags))
 				retval = -EPIPE;
 		} else if (bi.bytes_written) {
-			comedi_buf_write_alloc(s, bi.bytes_written);
+			_comedi_buf_write_alloc(s, bi.bytes_written);
 			bi.bytes_written =
-			    comedi_buf_write_free(s, bi.bytes_written);
+			    _comedi_buf_write_free(s, bi.bytes_written);
 		}
 		bi.bytes_read = 0;
 	}
@@ -2574,7 +2574,7 @@ static __poll_t comedi_poll(struct file *file, poll_table *wait)
 		poll_wait(file, &s->async->wait_head, wait);
 		if (s->busy != file || !comedi_is_subdevice_running(s) ||
 		    (s->async->cmd.flags & CMDF_WRITE) ||
-		    comedi_buf_read_n_available(s) > 0)
+		    _comedi_buf_read_n_available(s) > 0)
 			mask |= EPOLLIN | EPOLLRDNORM;
 	}
 
@@ -2707,7 +2707,7 @@ static ssize_t comedi_write(struct file *file, const char __user *buf,
 			break;
 
 		/* Allocate all free buffer space. */
-		comedi_buf_write_alloc(s, async->prealloc_bufsz);
+		_comedi_buf_write_alloc(s, async->prealloc_bufsz);
 		m = comedi_buf_write_n_allocated(s);
 		n = min_t(size_t, m, nbytes);
 
@@ -2735,7 +2735,7 @@ static ssize_t comedi_write(struct file *file, const char __user *buf,
 			n -= m;
 			retval = -EFAULT;
 		}
-		comedi_buf_write_free(s, n);
+		_comedi_buf_write_free(s, n);
 
 		count += n;
 		nbytes -= n;
@@ -2821,7 +2821,7 @@ static ssize_t comedi_read(struct file *file, char __user *buf, size_t nbytes,
 	while (count == 0 && !retval) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		m = comedi_buf_read_n_available(s);
+		m = _comedi_buf_read_n_available(s);
 		n = min_t(size_t, m, nbytes);
 
 		if (n == 0) {
@@ -2861,8 +2861,8 @@ static ssize_t comedi_read(struct file *file, char __user *buf, size_t nbytes,
 			retval = -EFAULT;
 		}
 
-		comedi_buf_read_alloc(s, n);
-		comedi_buf_read_free(s, n);
+		_comedi_buf_read_alloc(s, n);
+		_comedi_buf_read_free(s, n);
 
 		count += n;
 		nbytes -= n;
@@ -2896,7 +2896,7 @@ static ssize_t comedi_read(struct file *file, char __user *buf, size_t nbytes,
 		    s == new_s && new_s->async == async && s->busy == file &&
 		    !(async->cmd.flags & CMDF_WRITE) &&
 		    !comedi_is_subdevice_running(s) &&
-		    comedi_buf_read_n_available(s) == 0)
+		    _comedi_buf_read_n_available(s) == 0)
 			do_become_nonbusy(dev, s);
 		mutex_unlock(&dev->mutex);
 	}
@@ -3361,18 +3361,7 @@ static const struct file_operations comedi_fops = {
 	.llseek = noop_llseek,
 };
 
-/**
- * comedi_event() - Handle events for asynchronous COMEDI command
- * @dev: COMEDI device.
- * @s: COMEDI subdevice.
- * Context: in_interrupt() (usually), @s->spin_lock spin-lock not held.
- *
- * If an asynchronous COMEDI command is active on the subdevice, process
- * any %COMEDI_CB_... event flags that have been set, usually by an
- * interrupt handler.  These may change the run state of the asynchronous
- * command, wake a task, and/or send a %SIGIO signal.
- */
-void comedi_event(struct comedi_device *dev, struct comedi_subdevice *s)
+void _comedi_event(struct comedi_device *dev, struct comedi_subdevice *s)
 {
 	struct comedi_async *async = s->async;
 	unsigned int events;
@@ -3408,6 +3397,25 @@ void comedi_event(struct comedi_device *dev, struct comedi_subdevice *s)
 	if (si_code)
 		kill_fasync(&dev->async_queue, SIGIO, si_code);
 }
+
+/**
+ * comedi_event() - Handle events for asynchronous COMEDI command
+ * @dev: COMEDI device.
+ * @s: COMEDI subdevice.
+ * Context: in_interrupt() (usually), @s->spin_lock spin-lock not held.
+ *
+ * If an asynchronous COMEDI command is active on the subdevice, process
+ * any %COMEDI_CB_... event flags that have been set, usually by an
+ * interrupt handler.  These may change the run state of the asynchronous
+ * command, wake a task, and/or send a %SIGIO signal.
+ */
+void comedi_event(struct comedi_device *dev, struct comedi_subdevice *s)
+{
+	if (comedi_get_is_subdevice_running(s)) {
+		comedi_event(dev, s);
+		comedi_put_is_subdevice_running(s);
+	}
+}
 EXPORT_SYMBOL_GPL(comedi_event);
 
 /* Note: the ->mutex is pre-locked on successful return */
diff --git a/drivers/comedi/comedi_internal.h b/drivers/comedi/comedi_internal.h
index cf10ba016ebc..41a3b09f8f05 100644
--- a/drivers/comedi/comedi_internal.h
+++ b/drivers/comedi/comedi_internal.h
@@ -36,6 +36,18 @@ struct comedi_buf_map *
 comedi_buf_map_from_subdev_get(struct comedi_subdevice *s);
 unsigned int comedi_buf_write_n_available(struct comedi_subdevice *s);
 unsigned int comedi_buf_write_n_allocated(struct comedi_subdevice *s);
+unsigned int _comedi_buf_write_alloc(struct comedi_subdevice *s,
+				     unsigned int nbytes);
+unsigned int _comedi_buf_write_free(struct comedi_subdevice *s,
+				    unsigned int nbytes);
+unsigned int _comedi_buf_read_n_available(struct comedi_subdevice *s);
+unsigned int _comedi_buf_read_alloc(struct comedi_subdevice *s,
+				    unsigned int nbytes);
+unsigned int _comedi_buf_read_free(struct comedi_subdevice *s,
+				   unsigned int nbytes);
+void _comedi_inc_scan_progress(struct comedi_subdevice *s,
+			       unsigned int num_bytes);
+void _comedi_event(struct comedi_device *dev, struct comedi_subdevice *s);
 void comedi_device_cancel_all(struct comedi_device *dev);
 bool comedi_can_auto_free_spriv(struct comedi_subdevice *s);
 
diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index fd6e6cbe47ad..69cd2a253c66 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -441,6 +441,13 @@ unsigned int comedi_bytes_per_scan_cmd(struct comedi_subdevice *s,
 }
 EXPORT_SYMBOL_GPL(comedi_bytes_per_scan_cmd);
 
+static unsigned int _comedi_bytes_per_scan(struct comedi_subdevice *s)
+{
+	struct comedi_cmd *cmd = &s->async->cmd;
+
+	return comedi_bytes_per_scan_cmd(s, cmd);
+}
+
 /**
  * comedi_bytes_per_scan() - Get length of asynchronous command "scan" in bytes
  * @s: COMEDI subdevice.
@@ -458,9 +465,16 @@ EXPORT_SYMBOL_GPL(comedi_bytes_per_scan_cmd);
  */
 unsigned int comedi_bytes_per_scan(struct comedi_subdevice *s)
 {
-	struct comedi_cmd *cmd = &s->async->cmd;
+	unsigned int num_bytes;
 
-	return comedi_bytes_per_scan_cmd(s, cmd);
+	if (comedi_get_is_subdevice_running(s)) {
+		num_bytes = _comedi_bytes_per_scan(s);
+		comedi_put_is_subdevice_running(s);
+	} else {
+		/* Use nomimal, single sample scan length. */
+		num_bytes = comedi_samples_to_bytes(s, 1);
+	}
+	return num_bytes;
 }
 EXPORT_SYMBOL_GPL(comedi_bytes_per_scan);
 
@@ -482,6 +496,17 @@ static unsigned int __comedi_nscans_left(struct comedi_subdevice *s,
 	return nscans;
 }
 
+static unsigned int _comedi_nscans_left(struct comedi_subdevice *s,
+					unsigned int nscans)
+{
+	if (nscans == 0) {
+		unsigned int nbytes = _comedi_buf_read_n_available(s);
+
+		nscans = nbytes / _comedi_bytes_per_scan(s);
+	}
+	return __comedi_nscans_left(s, nscans);
+}
+
 /**
  * comedi_nscans_left() - Return the number of scans left in the command
  * @s: COMEDI subdevice.
@@ -499,25 +524,18 @@ static unsigned int __comedi_nscans_left(struct comedi_subdevice *s,
 unsigned int comedi_nscans_left(struct comedi_subdevice *s,
 				unsigned int nscans)
 {
-	if (nscans == 0) {
-		unsigned int nbytes = comedi_buf_read_n_available(s);
-
-		nscans = nbytes / comedi_bytes_per_scan(s);
+	if (comedi_get_is_subdevice_running(s)) {
+		nscans = _comedi_nscans_left(s, nscans);
+		comedi_put_is_subdevice_running(s);
+	} else {
+		nscans = 0;
 	}
-	return __comedi_nscans_left(s, nscans);
+	return nscans;
 }
 EXPORT_SYMBOL_GPL(comedi_nscans_left);
 
-/**
- * comedi_nsamples_left() - Return the number of samples left in the command
- * @s: COMEDI subdevice.
- * @nsamples: The expected number of samples.
- *
- * Returns the number of samples remaining to complete the command, or the
- * specified expected number of samples (@nsamples), whichever is fewer.
- */
-unsigned int comedi_nsamples_left(struct comedi_subdevice *s,
-				  unsigned int nsamples)
+static unsigned int _comedi_nsamples_left(struct comedi_subdevice *s,
+					  unsigned int nsamples)
 {
 	struct comedi_async *async = s->async;
 	struct comedi_cmd *cmd = &async->cmd;
@@ -538,24 +556,34 @@ unsigned int comedi_nsamples_left(struct comedi_subdevice *s,
 		return samples_left;
 	return nsamples;
 }
-EXPORT_SYMBOL_GPL(comedi_nsamples_left);
 
 /**
- * comedi_inc_scan_progress() - Update scan progress in asynchronous command
+ * comedi_nsamples_left() - Return the number of samples left in the command
  * @s: COMEDI subdevice.
- * @num_bytes: Amount of data in bytes to increment scan progress.
+ * @nsamples: The expected number of samples.
  *
- * Increments the scan progress by the number of bytes specified by @num_bytes.
- * If the scan progress reaches or exceeds the scan length in bytes, reduce
- * it modulo the scan length in bytes and set the "end of scan" asynchronous
- * event flag (%COMEDI_CB_EOS) to be processed later.
+ * Returns the number of samples remaining to complete the command, or the
+ * specified expected number of samples (@nsamples), whichever is fewer.
  */
-void comedi_inc_scan_progress(struct comedi_subdevice *s,
-			      unsigned int num_bytes)
+unsigned int comedi_nsamples_left(struct comedi_subdevice *s,
+				  unsigned int nsamples)
+{
+	if (comedi_get_is_subdevice_running(s)) {
+		nsamples = _comedi_nsamples_left(s, nsamples);
+		comedi_put_is_subdevice_running(s);
+	} else {
+		nsamples = 0;
+	}
+	return nsamples;
+}
+EXPORT_SYMBOL_GPL(comedi_nsamples_left);
+
+void _comedi_inc_scan_progress(struct comedi_subdevice *s,
+			       unsigned int num_bytes)
 {
 	struct comedi_async *async = s->async;
 	struct comedi_cmd *cmd = &async->cmd;
-	unsigned int scan_length = comedi_bytes_per_scan(s);
+	unsigned int scan_length = _comedi_bytes_per_scan(s);
 
 	/* track the 'cur_chan' for non-SDF_PACKED subdevices */
 	if (!(s->subdev_flags & SDF_PACKED)) {
@@ -576,8 +604,43 @@ void comedi_inc_scan_progress(struct comedi_subdevice *s,
 		async->events |= COMEDI_CB_EOS;
 	}
 }
+
+/**
+ * comedi_inc_scan_progress() - Update scan progress in asynchronous command
+ * @s: COMEDI subdevice.
+ * @num_bytes: Amount of data in bytes to increment scan progress.
+ *
+ * Increments the scan progress by the number of bytes specified by @num_bytes.
+ * If the scan progress reaches or exceeds the scan length in bytes, reduce
+ * it modulo the scan length in bytes and set the "end of scan" asynchronous
+ * event flag (%COMEDI_CB_EOS) to be processed later.
+ */
+void comedi_inc_scan_progress(struct comedi_subdevice *s,
+			      unsigned int num_bytes)
+{
+	if (comedi_get_is_subdevice_running(s)) {
+		_comedi_inc_scan_progress(s, num_bytes);
+		comedi_put_is_subdevice_running(s);
+	}
+}
 EXPORT_SYMBOL_GPL(comedi_inc_scan_progress);
 
+static unsigned int _comedi_handle_events(struct comedi_device *dev,
+					  struct comedi_subdevice *s)
+{
+	unsigned int events = s->async->events;
+
+	if (events == 0)
+		return events;
+
+	if ((events & COMEDI_CB_CANCEL_MASK) && s->cancel)
+		s->cancel(dev, s);
+
+	_comedi_event(dev, s);
+
+	return events;
+}
+
 /**
  * comedi_handle_events() - Handle events and possibly stop acquisition
  * @dev: COMEDI device.
@@ -597,16 +660,14 @@ EXPORT_SYMBOL_GPL(comedi_inc_scan_progress);
 unsigned int comedi_handle_events(struct comedi_device *dev,
 				  struct comedi_subdevice *s)
 {
-	unsigned int events = s->async->events;
-
-	if (events == 0)
-		return events;
-
-	if ((events & COMEDI_CB_CANCEL_MASK) && s->cancel)
-		s->cancel(dev, s);
-
-	comedi_event(dev, s);
+	unsigned int events;
 
+	if (comedi_get_is_subdevice_running(s)) {
+		events = _comedi_handle_events(dev, s);
+		comedi_put_is_subdevice_running(s);
+	} else {
+		events = 0;
+	}
 	return events;
 }
 EXPORT_SYMBOL_GPL(comedi_handle_events);
-- 
2.51.0


