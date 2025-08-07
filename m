Return-Path: <linux-kernel+bounces-758532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8C5B1D06E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DF972593D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6D23534D;
	Thu,  7 Aug 2025 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="avfqTi3l"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA298226D0F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531114; cv=none; b=YH/GEvHU2sCiH/ASvCg4R7BJr6LwvepIvGEs5nZB4Oa5A1NDZ0YwAZB1TGn9zBntWrdbAE52MfSUEGIOmk6ccFe5OGx7PD3W33CFLiQmKksNRfe/9lZ+t0z7/8y4K77E9Z1s/2lI5mEGYuTxJUJUllRExWdBLrItCflGxC4bFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531114; c=relaxed/simple;
	bh=QWyMyloaFq7cLSNrV9zsyDSIsGUiO4dZm96o/xMpJ1U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdmAPw6NPTphd7qBVBfDpUoLnivOI/GuW0nBOr4/F47tRNcTNjJrXcIvVLqBToMRykJ+qfGkfiGt/ifmWdf4D0Dv4V6VHYjcxVHgZwWRN/XgzRrAduIIKKfzrga6SsCd2UEDXiogMkbv+dZBIC6SbOe5F8EhdcA2X3vfcf/sJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=avfqTi3l; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70884da4b55so6135756d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 18:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531109; x=1755135909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=535Ba2NCPms4/9++qm2Yq8lWENY5QwuViLFiaBWBL/o=;
        b=avfqTi3lvTIOpVl/6sVMLaK7srTIduqAV//XM+yeZW0YptCTxeS71TEAkJHOk0jdh+
         yL7HPKHG9kyqalyIimk9y7L04Be8jQ1Zg0wnfpad092biqfHdxvkG9BHuuS2x/sw0xTN
         Me8G2FoDsMFLNHiObiI05PJ8/n8IW7SzX1lFoNJtmMGP0dNXAez0G2Qw3yQFlFZvHcqf
         pEPGxv/4xtwuakfToznouliaCHoE3wO/ITCAPZY4f9if4Awo5sjeIea2pYBfedbs4JiN
         0kq54Sc432sHBu9L9CupMPiuYqrbVKerR6iLKJTYy6JKfFLo2zrlKrtZ9kivw9B1feue
         u36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531109; x=1755135909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=535Ba2NCPms4/9++qm2Yq8lWENY5QwuViLFiaBWBL/o=;
        b=luilZuaI2cXFf8xA+lD50zgG6e/+mqjDJloylUjAdg5m/owuc5ikLdOrWL9XBoqYWM
         a7FIg48ePbpaq4B3Oj4DgXP9nckp8KfNt7kGmp7zXllyTAPYNOKOmQCEo+AzedXdPlcW
         3sAF2c0HTHNZ49zmoBt0VVTlh5z5h9tIQGm0pVHeT79R+Nirp0p375DzS1hOQ31F4FFk
         Y/zVogUDAC1b1iyGHY99Kllywz9rW/C8ei3yweUAeZdaOrIp7XCFAs+FuRo7Wl8+3BMo
         EPDiFZIYkdwAJeBYgQ/Knj5zyIvhyKWTq6kr5qYqahJtxxiMGA71hHHAjTf8SlG6GRUx
         invA==
X-Forwarded-Encrypted: i=1; AJvYcCWHRjQX6JH10qLt5//yuOiT/x8fXfd+/l4IVkMDuIRtszQxrru21mL9DFf5YG9nWc4fXXqqwVHDXjiADak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyELZHGFMzE5tnanc5TZTXhnZm2NlwzAcm9G+el07kBqFCtwvSA
	bYpGypCs8ZdQUGhR/vZ2q4QI0MDsmn/rjy/MNcfnMleTdBJapZ+yVjblfOewNrq6zg4=
X-Gm-Gg: ASbGncu5eQ6pPKFX9K2yd+UV7wJNdzW2qUy10bUYeX5J/S0gqGHoo3R7RYn39bXDOwx
	DADtPyBACFfDCBhUkaI5IW88sirr1YjowljKuR5ejWvjp1pIQD1b08r/7sbVLTzmHf7BQN3GIAq
	MbA7ouugNYH6WQc7Mb8Q4uiAL2oCAZKBKLGvYM+o2nPVZvr5atObY+w9V/XulSFLyEE9OYyklw9
	crbd/t/GvMQskHRd6GQzmhJxwykCuOGvt4YUN8QAjqOI6esI9hPsWO/2mLgzc/bBPUjwdJX/Haw
	bqe7fL/AzDlEsQr5uFhlffwJb8v6RgEWl1GnC5ssk93x8vW2o5ij70ddDa1bO+UsdvYtGE1ylGA
	kO04hf/6teYHhWLE9yCeWzGQzy5i7ifABHU/HViEZpeNsgQpupOKKPNdZcwiVMrrBRvhbTaaSXO
	c/OMl3/EhLEQsx
X-Google-Smtp-Source: AGHT+IEnMynjbrA/1kdM8QRErdkzAIa+G9lVVTQo0MaHEEKIMvABCbjhv49oP3YEo2mCQBJF30aYNA==
X-Received: by 2002:a05:6214:246f:b0:707:7cee:4fd with SMTP id 6a1803df08f44-7097ae10932mr70070696d6.3.1754531109452;
        Wed, 06 Aug 2025 18:45:09 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:08 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v3 15/30] liveupdate: luo_files: implement file systems callbacks
Date: Thu,  7 Aug 2025 01:44:21 +0000
Message-ID: <20250807014442.3829950-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements the core logic within luo_files.c to invoke the prepare,
reboot, finish, and cancel callbacks for preserved file instances,
replacing the previous stub implementations. It also handles
the persistence and retrieval of the u64 data payload associated with
each file via the LUO FDT.

This completes the core mechanism enabling registered files handlers to actively
manage file state across the live update transition using the LUO framework.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_files.c | 191 +++++++++++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/luo_files.c b/kernel/liveupdate/luo_files.c
index 4b7568d0f0f0..33577c9e9a64 100644
--- a/kernel/liveupdate/luo_files.c
+++ b/kernel/liveupdate/luo_files.c
@@ -326,32 +326,190 @@ static int luo_files_fdt_setup(void)
 	return ret;
 }
 
+static int luo_files_prepare_one(struct luo_file *h)
+{
+	int ret = 0;
+
+	guard(mutex)(&h->mutex);
+	if (h->state == LIVEUPDATE_STATE_NORMAL) {
+		if (h->fh->ops->prepare) {
+			ret = h->fh->ops->prepare(h->fh, h->file,
+						  &h->private_data);
+		}
+		if (!ret)
+			h->state = LIVEUPDATE_STATE_PREPARED;
+	} else {
+		WARN_ON_ONCE(h->state != LIVEUPDATE_STATE_PREPARED &&
+			     h->state != LIVEUPDATE_STATE_FROZEN);
+	}
+
+	return ret;
+}
+
+static int luo_files_freeze_one(struct luo_file *h)
+{
+	int ret = 0;
+
+	guard(mutex)(&h->mutex);
+	if (h->state == LIVEUPDATE_STATE_PREPARED) {
+		if (h->fh->ops->freeze) {
+			ret = h->fh->ops->freeze(h->fh, h->file,
+						 &h->private_data);
+		}
+		if (!ret)
+			h->state = LIVEUPDATE_STATE_FROZEN;
+	} else {
+		WARN_ON_ONCE(h->state != LIVEUPDATE_STATE_FROZEN);
+	}
+
+	return ret;
+}
+
+static void luo_files_finish_one(struct luo_file *h)
+{
+	guard(mutex)(&h->mutex);
+	if (h->state == LIVEUPDATE_STATE_UPDATED) {
+		if (h->fh->ops->finish) {
+			h->fh->ops->finish(h->fh, h->file, h->private_data,
+					   h->reclaimed);
+		}
+		h->state = LIVEUPDATE_STATE_NORMAL;
+	} else {
+		WARN_ON_ONCE(h->state != LIVEUPDATE_STATE_NORMAL);
+	}
+}
+
+static void luo_files_cancel_one(struct luo_file *h)
+{
+	int ret;
+
+	guard(mutex)(&h->mutex);
+	if (h->state == LIVEUPDATE_STATE_NORMAL)
+		return;
+
+	ret = WARN_ON_ONCE(h->state != LIVEUPDATE_STATE_PREPARED &&
+			   h->state != LIVEUPDATE_STATE_FROZEN);
+	if (ret)
+		return;
+
+	if (h->fh->ops->cancel)
+		h->fh->ops->cancel(h->fh, h->file, h->private_data);
+	h->private_data = 0;
+	h->state = LIVEUPDATE_STATE_NORMAL;
+}
+
+static void __luo_files_cancel(struct luo_file *boundary_file)
+{
+	unsigned long token;
+	struct luo_file *h;
+
+	xa_for_each(&luo_files_xa_out, token, h) {
+		if (h == boundary_file)
+			break;
+
+		luo_files_cancel_one(h);
+	}
+	luo_files_fdt_cleanup();
+}
+
+static int luo_files_commit_data_to_fdt(void)
+{
+	int node_offset, ret;
+	unsigned long token;
+	char token_str[19];
+	struct luo_file *h;
+
+	guard(rwsem_read)(&luo_file_fdt_rwsem);
+	xa_for_each(&luo_files_xa_out, token, h) {
+		snprintf(token_str, sizeof(token_str), "%#0llx", (u64)token);
+		node_offset = fdt_subnode_offset(luo_file_fdt_out,
+						 0,
+						 token_str);
+		ret = fdt_setprop(luo_file_fdt_out, node_offset, "data",
+				  &h->private_data, sizeof(h->private_data));
+		if (ret < 0) {
+			pr_err("Failed to set data property for token %s: %s\n",
+			       token_str, fdt_strerror(ret));
+			return -ENOSPC;
+		}
+	}
+
+	return 0;
+}
+
 static int luo_files_prepare(struct liveupdate_subsystem *h, u64 *data)
 {
+	unsigned long token;
+	struct luo_file *luo_file;
 	int ret;
 
 	ret = luo_files_fdt_setup();
 	if (ret)
 		return ret;
 
-	scoped_guard(rwsem_read, &luo_file_fdt_rwsem)
-		*data = __pa(luo_file_fdt_out);
+	xa_for_each(&luo_files_xa_out, token, luo_file) {
+		ret = luo_files_prepare_one(luo_file);
+		if (ret < 0) {
+			pr_err("Prepare failed for file token %#0llx handler '%s' [%d]\n",
+			       (u64)token, luo_file->fh->compatible, ret);
+			__luo_files_cancel(luo_file);
+
+			return ret;
+		}
+	}
+
+	ret = luo_files_commit_data_to_fdt();
+	if (ret) {
+		__luo_files_cancel(NULL);
+	} else {
+		scoped_guard(rwsem_read, &luo_file_fdt_rwsem)
+			*data = __pa(luo_file_fdt_out);
+	}
 
 	return ret;
 }
 
 static int luo_files_freeze(struct liveupdate_subsystem *h, u64 *data)
 {
-	return 0;
+	unsigned long token;
+	struct luo_file *luo_file;
+	int ret;
+
+	xa_for_each(&luo_files_xa_out, token, luo_file) {
+		ret = luo_files_freeze_one(luo_file);
+		if (ret < 0) {
+			pr_err("Freeze callback failed for file token %#0llx handler '%s' [%d]\n",
+			       (u64)token, luo_file->fh->compatible, ret);
+			__luo_files_cancel(luo_file);
+
+			return ret;
+		}
+	}
+
+	ret = luo_files_commit_data_to_fdt();
+	if (ret)
+		__luo_files_cancel(NULL);
+
+	return ret;
 }
 
 static void luo_files_finish(struct liveupdate_subsystem *h, u64 data)
 {
+	unsigned long token;
+	struct luo_file *luo_file;
+
 	luo_files_recreate_luo_files_xa_in();
+	xa_for_each(&luo_files_xa_in, token, luo_file) {
+		luo_files_finish_one(luo_file);
+		mutex_destroy(&luo_file->mutex);
+		kfree(luo_file);
+	}
+	xa_destroy(&luo_files_xa_in);
 }
 
 static void luo_files_cancel(struct liveupdate_subsystem *h, u64 data)
 {
+	__luo_files_cancel(NULL);
 }
 
 static void luo_files_boot(struct liveupdate_subsystem *h, u64 fdt_pa)
@@ -484,6 +642,27 @@ int luo_register_file(u64 token, int fd)
 	return ret;
 }
 
+static void luo_files_fdt_remove_node(u64 token)
+{
+	char token_str[19];
+	int offset, ret;
+
+	guard(rwsem_write)(&luo_file_fdt_rwsem);
+	if (!luo_file_fdt_out)
+		return;
+
+	snprintf(token_str, sizeof(token_str), "%#0llx", token);
+	offset = fdt_subnode_offset(luo_file_fdt_out, 0, token_str);
+	if (offset < 0)
+		return;
+
+	ret = fdt_del_node(luo_file_fdt_out, offset);
+	if (ret < 0) {
+		pr_warn("LUO Files: Failed to delete FDT node for token %s: %s\n",
+			token_str, fdt_strerror(ret));
+	}
+}
+
 static int __luo_unregister_file(u64 token)
 {
 	struct luo_file *luo_file;
@@ -492,6 +671,12 @@ static int __luo_unregister_file(u64 token)
 	if (!luo_file)
 		return -ENOENT;
 
+	if (luo_file->state == LIVEUPDATE_STATE_FROZEN ||
+	    luo_file->state == LIVEUPDATE_STATE_PREPARED) {
+		luo_files_cancel_one(luo_file);
+		luo_files_fdt_remove_node(token);
+	}
+
 	fput(luo_file->file);
 	mutex_destroy(&luo_file->mutex);
 	kfree(luo_file);
-- 
2.50.1.565.gc32cd1483b-goog


