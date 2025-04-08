Return-Path: <linux-kernel+bounces-592987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1042A7F3AD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 06:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B4F3A59C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 04:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D76F207A3D;
	Tue,  8 Apr 2025 04:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWYyvwKa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12951F8725
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 04:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744087179; cv=none; b=JuchD/TtZ1ivtRVakvDUb1Yi3mugyQql4VmYqR9V90PEyzgwfod9nL740KQBHpuSejAAlxXYi7qXZtoaajzifCnvrh1Sn4JB5vCkutmPKcqKYiWa4DlDD3oeM7heWChYGBrP0mYZZi7rdePPIC7Q1kIm7Ir1NQ0XnVjDM1LVFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744087179; c=relaxed/simple;
	bh=xYmbRuqYXLiB//nKBw6z390Qy3fTU2uON5B+DR85Lq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCKL/0Ctj3PdABdJWX1xZe+rmfFGDQeYuvQic7IbK1iddg3q7XdgZhgPCaC9ITWZmgaye62o6/N5Kbotu/9w+TLvFE2clKBSIMPInU1EeqOQ5w4iByHqYS1Y1G04uKC0Vg4MGy8rf//IB6tIvEikgbkjGwBufy2ifjMinuOZDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWYyvwKa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744087176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+0Q1kR0CMCFGP3tTyVdwrjZvM2FReb2Dfl3Am4J0jE=;
	b=UWYyvwKax9h9iz64Da6s5dGdmWqyr+I4XTTrqAGIUS8Ih/hnNYXPBMjSPO9HaXwmP4fJvr
	+gopDRdZrTIWoPVmDYMl4Fkn7P7V6ayqzA2ykHt2iB32uIsgk406RMP7gTZ9S7F5GQ05by
	7p65fQKf8S1x7DoKJw8Iy1RetNDE6XA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-kSFC8oDwPmOf0EdxmEQVAQ-1; Tue,
 08 Apr 2025 00:39:32 -0400
X-MC-Unique: kSFC8oDwPmOf0EdxmEQVAQ-1
X-Mimecast-MFC-AGG-ID: kSFC8oDwPmOf0EdxmEQVAQ_1744087169
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB9B41955BC9;
	Tue,  8 Apr 2025 04:39:28 +0000 (UTC)
Received: from localhost (unknown [10.72.112.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72AFA180094A;
	Tue,  8 Apr 2025 04:39:26 +0000 (UTC)
Date: Tue, 8 Apr 2025 12:39:22 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v11 2/9] ima: define and call ima_alloc_kexec_file_buf()
Message-ID: <Z/SoekIdreYI3uBZ@MiWiFi-R3L-srv>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-3-chenste@linux.microsoft.com>
 <a293ed27094f7fa7a36f1641a9e6b17a49e26fa0.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a293ed27094f7fa7a36f1641a9e6b17a49e26fa0.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 04/08/25 at 12:07am, Mimi Zohar wrote:
> On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
> > In the current implementation, the ima_dump_measurement_list() API is 
> > called during the kexec "load" phase, where a buffer is allocated and 
> > the measurement records are copied. Due to this, new events added after
> > kexec load but before kexec execute are not carried over to the new kernel
> > during kexec operation
> 
> Repeating this here is unnecessary.
> > 
> > To allow the buffer allocation and population to be separated into distinct
> > steps, make the function local seq_file "ima_kexec_file" to a file variable.
> 
> This change was already made in [PATCH v11 1/9] ima: rename variable the
> set_file "file" to "ima_kexec_file".  Please remove.
> 
> > 
> > Carrying the IMA measurement list across kexec requires allocating a
> > buffer and copying the measurement records.  Separate allocating the
> > buffer and copying the measurement records into separate functions in
> > order to allocate the buffer at kexec 'load' and copy the measurements
> > at kexec 'execute'.
> > 
> > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > ---
> >  security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++-------
> >  1 file changed, 35 insertions(+), 11 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > index 650beb74346c..b12ac3619b8f 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -15,26 +15,46 @@
> >  #include "ima.h"
> >  
> >  #ifdef CONFIG_IMA_KEXEC
> > +static struct seq_file ima_kexec_file;
> > +
> > +static void ima_free_kexec_file_buf(struct seq_file *sf)
> > +{
> > +	vfree(sf->buf);
> > +	sf->buf = NULL;
> > +	sf->size = 0;
> > +	sf->read_pos = 0;
> > +	sf->count = 0;
> > +}
> > +
> > +static int ima_alloc_kexec_file_buf(size_t segment_size)
> > +{
> > +	ima_free_kexec_file_buf(&ima_kexec_file);
> 
> After moving the vfree() here at this stage in the patch set, the IMA
> measurement list fails to verify when doing two consecutive "kexec -s -l"
> with/without a "kexec -s -u" in between.  Only after "ima: kexec: move IMA log
> copy from kexec load to execute" the IMA measurement list verifies properly with
> the vfree() here.

I also noticed this, patch 7 will remedy this. Put patch 7 just after
this patch or squash it into this patch?

[PATCH v11 7/9] ima: verify if the segment size has changed

> 
> > +
> > +	/* segment size can't change between kexec load and execute */
> > +	ima_kexec_file.buf = vmalloc(segment_size);
> > +	if (!ima_kexec_file.buf)
> > +		return -ENOMEM;
> > +
> > +	ima_kexec_file.size = segment_size;
> > +	ima_kexec_file.read_pos = 0;
> > +	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
> > +
> > +	return 0;
> > +}
> > +
> 


