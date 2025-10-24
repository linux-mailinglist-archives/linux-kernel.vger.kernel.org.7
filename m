Return-Path: <linux-kernel+bounces-868105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89829C045EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A7B3B204E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA463238D42;
	Fri, 24 Oct 2025 05:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hNcw4awF"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEAB26AEC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761283272; cv=none; b=tTLwd0ZiXRr3E52Eyy6n1rMyiHw+shNzy2CnjU1qjYvXsEu942Bz/3/WfX0W5LUd3ZdYHZZuH30B81dDTxyWJSV23O1LdLSGiZVfHW3evZROsiDkA+CteOp14FPQeKJ8XfAPmSic6/KN829F29tQttcN+NhnXhbVsGyhUZNGjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761283272; c=relaxed/simple;
	bh=mCslZqaG1EGeGWbV78CjaMni7h12A/yy6mpg+DfH1b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XnaNWmxgF9SZscIpsakivq/dWWkLO14tcZvuSE+1ygzk6BsZcxKezs8l9u/iQIVEAMVCBfVD1Gwk4DL760lhxg64ZgXqgDrTXi1NyYS8okpGTBo1Qb+4h9Kgq5IZY54pkO12+bmv5PjbYwXmg2yzMW2wAjZrG0B/RuvOrPj/ljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hNcw4awF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=XkcekN7NTU4m2D27vewkJxwVK8Ws3wU7k2cIeR+8Qgg=; b=hNcw4awFWRWIz7FuDHVccrWe62
	EG+RQQhhCUbGp530FsyuOGQXqLbIiblzIBZlOb6Lf1XWpG7jExykY1WW7cKESc1SYqxYdXGTWlbz3
	3fhm2ygHYTlaFw7WTaJyg/o3c3VZkgVkXqE5vLd4+MfHX1Op0NXKAxhpgYRf9oWc8pFMBqpy0jOoP
	5twYklJmzg+VrYqtbn2aCka+lpEivXT5oJRw4oJVFyYsHFmpqpTKT7XFBPO1KtqMmAx/2U5Rb3AmJ
	dGMVH7f6BE9FZhiOOiikTINcIFgeF+jn4NAomht9AqyEoKLVp2NjBZG4ZqLifMHLUlyBIIxykKIFQ
	wJfuCIlg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCAEY-00000008Gcu-2nrW;
	Fri, 24 Oct 2025 05:21:02 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: <uapi/linux/tee.h: fix all kernel-doc issues
Date: Thu, 23 Oct 2025 22:21:02 -0700
Message-ID: <20251024052102.635908-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings so that there no other kernel-doc issues
in <uapi/linux/tee.h>:

- add ending ':' to some struct members as needed for kernel-doc
- change struct name in kernel-doc to match the actual struct name (2x)
- add a @params: kernel-doc entry multiple times

Warning: tee.h:265 struct member 'ret_origin' not described
 in 'tee_ioctl_open_session_arg'
Warning: tee.h:265 struct member 'num_params' not described
 in 'tee_ioctl_open_session_arg'
Warning: tee.h:265 struct member 'params' not described
 in 'tee_ioctl_open_session_arg'
Warning: tee.h:351 struct member 'num_params' not described
 in 'tee_iocl_supp_recv_arg'
Warning: tee.h:351 struct member 'params' not described
 in 'tee_iocl_supp_recv_arg'
Warning: tee.h:372 struct member 'num_params' not described
 in 'tee_iocl_supp_send_arg'
Warning: tee.h:372 struct member 'params' not described
 in 'tee_iocl_supp_send_arg'
Warning: tee.h:298: expecting prototype for struct
 tee_ioctl_invoke_func_arg. Prototype was for
 struct tee_ioctl_invoke_arg instead
Warning: tee.h:473: expecting prototype for struct
 tee_ioctl_invoke_func_arg. Prototype was for struct
 tee_ioctl_object_invoke_arg instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: op-tee@lists.trustedfirmware.org
---
 include/uapi/linux/tee.h |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- linux-next-20251022.orig/include/uapi/linux/tee.h
+++ linux-next-20251022/include/uapi/linux/tee.h
@@ -249,8 +249,9 @@ struct tee_ioctl_param {
  * @cancel_id:	[in] Cancellation id, a unique value to identify this request
  * @session:	[out] Session id
  * @ret:	[out] return value
- * @ret_origin	[out] origin of the return value
- * @num_params	[in] number of parameters following this struct
+ * @ret_origin:	[out] origin of the return value
+ * @num_params:	[in] number of &struct tee_ioctl_param entries in @params
+ * @params:	array of ioctl parameters
  */
 struct tee_ioctl_open_session_arg {
 	__u8 uuid[TEE_IOCTL_UUID_LEN];
@@ -276,14 +277,14 @@ struct tee_ioctl_open_session_arg {
 				     struct tee_ioctl_buf_data)
 
 /**
- * struct tee_ioctl_invoke_func_arg - Invokes a function in a Trusted
- * Application
+ * struct tee_ioctl_invoke_arg - Invokes a function in a Trusted Application
  * @func:	[in] Trusted Application function, specific to the TA
  * @session:	[in] Session id
  * @cancel_id:	[in] Cancellation id, a unique value to identify this request
  * @ret:	[out] return value
- * @ret_origin	[out] origin of the return value
- * @num_params	[in] number of parameters following this struct
+ * @ret_origin:	[out] origin of the return value
+ * @num_params:	[in] number of parameters following this struct
+ * @params:	array of ioctl parameters
  */
 struct tee_ioctl_invoke_arg {
 	__u32 func;
@@ -338,7 +339,8 @@ struct tee_ioctl_close_session_arg {
 /**
  * struct tee_iocl_supp_recv_arg - Receive a request for a supplicant function
  * @func:	[in] supplicant function
- * @num_params	[in/out] number of parameters following this struct
+ * @num_params:	[in/out] number of &struct tee_ioctl_param entries in @params
+ * @params:	array of ioctl parameters
  *
  * @num_params is the number of params that tee-supplicant has room to
  * receive when input, @num_params is the number of actual params
@@ -363,7 +365,8 @@ struct tee_iocl_supp_recv_arg {
 /**
  * struct tee_iocl_supp_send_arg - Send a response to a received request
  * @ret:	[out] return value
- * @num_params	[in] number of parameters following this struct
+ * @num_params:	[in] number of &struct tee_ioctl_param entries in @params
+ * @params:	array of ioctl parameters
  */
 struct tee_iocl_supp_send_arg {
 	__u32 ret;
@@ -454,11 +457,13 @@ struct tee_ioctl_shm_register_fd_data {
  */
 
 /**
- * struct tee_ioctl_invoke_func_arg - Invokes an object in a Trusted Application
+ * struct tee_ioctl_object_invoke_arg - Invokes an object in a
+ *   Trusted Application
  * @id:		[in] Object id
  * @op:		[in] Object operation, specific to the object
  * @ret:	[out] return value
  * @num_params:	[in] number of parameters following this struct
+ * @params:	array of ioctl parameters
  */
 struct tee_ioctl_object_invoke_arg {
 	__u64 id;

