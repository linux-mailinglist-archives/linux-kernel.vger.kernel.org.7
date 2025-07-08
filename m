Return-Path: <linux-kernel+bounces-721371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E22AFC84B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6842E1BC226E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0015269B1C;
	Tue,  8 Jul 2025 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FK3CfVjW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18442222C7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970324; cv=none; b=nPuMhgZ1FT9/er60AZ75NV4ny5oE1urtNGa0H8MBDEuU1H7EZWmh0ua7oXRkYwh2Dsp7TAMQnHdk9KUZjkvWsL75V7LXMtfc5vmIyFjFvmwlRzOVxIPKVOI6UIJlnSjZkx5ZR4J58KZmXj2HTLdGXaccRgjaSsPNB6NawBdquXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970324; c=relaxed/simple;
	bh=adxrwvHH9jGA3rnCawcVdF/L4S3UTXsY1TjDr0W1ZqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/eGYsJBKzjFTdFfRfCGuqQT9vl2atR17Ys2lGKAbzl3b7ozjRJ9I8XhwrpKQlFYFH1OGJkHr26Fv06P2KO2LW/8kYqNp0p6WaXeiqiSqNmbrvlK7lqS9bY3zF6SaE8KqsDgXqnivNzS+Q/wCDxIDB1FerolbrRiycXr+gaX1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FK3CfVjW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751970321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqVqXPKx/cgWhIOEtnql2P3i8N6AT9IoowaK1wcPp6w=;
	b=FK3CfVjWuIsU6lpRXuqkgrk9RH0vpfu8sD7w79Lffkpo7w+p+oXoMQOnJOAeqDE1VWvSue
	8buNfNkhkw6Pqy391/Uh8a6lYCWS5MhGjPuwhKpYLP90G6zv5Wq+3LzEaFFgtMhNX8v6eA
	4/u+Z4S1W7TEJ40KZy4aV9Geg+CPEv0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-3qkajHaYP0eP_EFym3SV_g-1; Tue,
 08 Jul 2025 06:25:17 -0400
X-MC-Unique: 3qkajHaYP0eP_EFym3SV_g-1
X-Mimecast-MFC-AGG-ID: 3qkajHaYP0eP_EFym3SV_g_1751970316
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26F7A18002ED;
	Tue,  8 Jul 2025 10:25:16 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C94F7180045B;
	Tue,  8 Jul 2025 10:25:13 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, djeffery@redhat.com, loberman@redhat.com
Subject: Re: [PATCH 1/2] workqueue: Add a helper to identify current workqueue
Date: Tue, 08 Jul 2025 06:25:11 -0400
Message-ID: <8732DDAB-026F-49F8-9B10-8D25C4732CA9@redhat.com>
In-Reply-To: <aGygp-3mtsLxtGT3@slm.duckdns.org>
References: <cover.1751913604.git.bcodding@redhat.com>
 <baad3adf8ea80b65d83dd196ab715992a0f1b768.1751913604.git.bcodding@redhat.com>
 <aGygp-3mtsLxtGT3@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 8 Jul 2025, at 0:37, Tejun Heo wrote:

> On Mon, Jul 07, 2025 at 02:46:03PM -0400, Benjamin Coddington wrote:
>> Introduce a new helper current_workqueue() which returns the current task's
>> workqueue pointer or NULL if not a workqueue worker.
>>
>> This will allow the NFS client to recognize the case where writeback occurs
>> within the nfsiod workqueue or is being submitted directly.  NFS would like
>> to change the GFP_ flags for memory allocation to avoid stalls or cycles in
>> memory pools based on which context writeback is occurring.  In a following
>> patch, this helper detects the case rather than checking the PF_WQ_WORKER
>> flag which can be passed along from another workqueue worker.
>
> There's already current_work(). Wouldn't that be enough for identifying
> whether the current work item?

NFS submits different work items to the same workqueue, so comparing the
workqueue instead of the work items made more sense.

After discussion on patch 2 yesterday, I think we're going to try to fix
this in NFS using a different approach that won't need this helper now.

Thanks for the look Tejun.
Ben


