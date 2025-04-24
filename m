Return-Path: <linux-kernel+bounces-618638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97793A9B12D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 16:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1C03B6FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE6F18859B;
	Thu, 24 Apr 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+laFChW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D7146D53
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505453; cv=none; b=Pe0RJFFvy6iV8lRcE8vhuiZzuVB6zBDC4nv+gGSaUpIQeXAqm9dWMqvScdB4QLy8zldNXmsL9YWPM/gSo+cP8zlO1oL1UwipeFJfn9eus/0hXW4lXymPvxxC1UhPtzc04FO709hCdj7/xkNY2s0DSvtGCYRM1XooUPgI5NIUXok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505453; c=relaxed/simple;
	bh=MF8yM0hDLJMunXliqAKRJc3PoReh69CIks5Rz58mYHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwb+mbmgeTvkfOPs0hFU5MBYQoYu9hyZUBQiOC/X0BW6q0pFhFPpePIpLVl6AT62pZ48B6UOBA7HOEwn+iskutD380L9jMoL6G6mNMcaIxiM+zCKAYzFeDAdaHPQxzPf86IURk6yNiCAiClNBAtDjIiVzlkN6SOSTfaXGJ37ipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+laFChW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745505451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYUUd0z6A0+ZkWdTi7S3yGhP4LTb46IOeiMEmdUvozc=;
	b=C+laFChWg4wrBN/8AjNMKbjOMKhx7ZVUdx4+pciMfUc+K5NG3zD+Vz6ix6+3xljA5P0EhW
	XFg+mO11wiBGt2njtBTLIr3D6aa4KjtST7pWd1Wrmw+DqGcJvQgqYeaCLTX2dHrxWlFTns
	mndCGuia1vjFMX3b5WuRKbcN5ISvdm0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-pZpKcBiLNymKpzeyzdU94w-1; Thu,
 24 Apr 2025 10:37:26 -0400
X-MC-Unique: pZpKcBiLNymKpzeyzdU94w-1
X-Mimecast-MFC-AGG-ID: pZpKcBiLNymKpzeyzdU94w_1745505444
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2090718004A7;
	Thu, 24 Apr 2025 14:37:23 +0000 (UTC)
Received: from localhost (unknown [10.72.112.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAFAC18002AD;
	Thu, 24 Apr 2025 14:37:20 +0000 (UTC)
Date: Thu, 24 Apr 2025 22:37:16 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v13 0/9] ima: kexec: measure events between kexec load
 and execute
Message-ID: <aApMnEl1Xzarmimn@fedora>
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421222516.9830-1-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Steven,

Could you test below code and post a formal patch to not copy
measurement list buffer to kdump kernel? Below log is just for your
reference, please feel free to modify or rephrase. 

===
Kdump kernel doesn't need IMA to do integrity measurement.
Hence the measurement list in 1st kernel doesn't need to be copied to
kdump kenrel.

Here skip allocating buffer for measurement list copying if loading
kdump kernel. Then there won't be the later handling related to
ima_kexec_buffer.
===

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 38cb2500f4c3..7362f68f2d8b 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -146,6 +146,9 @@ void ima_add_kexec_buffer(struct kimage *image)
 	void *kexec_buffer = NULL;
 	int ret;
 
+	if (image->type == KEXEC_TYPE_CRASH)
+		return;
+
 	/*
 	 * Reserve extra memory for measurements added during kexec.
 	 */


