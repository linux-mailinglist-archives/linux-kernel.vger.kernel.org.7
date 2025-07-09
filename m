Return-Path: <linux-kernel+bounces-724097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E52AFEE8A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600C6642637
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7AA292B24;
	Wed,  9 Jul 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLPE6IEp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8FF1F3BA4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077053; cv=none; b=CwAHM4PHQuc64PxEOLNqbhNq1OfZZa7J6Tk7+E1kmbbkSJbmlQH5AEZDWbqJXI70W2l1zUPBqz04rVd0Cbx3iBxa9ItVWiq7iOC07E4NzTcSvnbA9btqzFfBeJSgrzxY9tfxbMSaaBD7Km6FafOJXFPlVGeyEeNp4NvnS9J3gSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077053; c=relaxed/simple;
	bh=i3ZcrxUeGN+REuzZS1FQahN/BXcB/ZZRuCI1JLJJIJQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=B3aeeBiDeAqfiNjOFMbxcVNw9/OK5qSXiQF1tPLJEijQzgwFBibxk5crg430znra71/r8qJyr0t5trIM8O2F5BKYDGA40g53FFnu3xzuoY8eiDhUjILJMN0tnwsKYsNTvW3pmw5MZkrJnUBvjHuEPpvFXNi7Ln71crPqdxY1iAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLPE6IEp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752077051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3ZcrxUeGN+REuzZS1FQahN/BXcB/ZZRuCI1JLJJIJQ=;
	b=DLPE6IEpJhZzTH6xqj/a8+9QqVn9bWVTz8wdC6cYt/ojorFnm4BZJzp0DeEtvPAIFoVQBi
	xOaCJilCC3mm/+fhuflaX0J8u3ji3bIfZHKfIXT0Szpilk1BCe1PtVgXt67DXwFqVOkuTb
	N1BGFS6m9G/6tL/D8n6rFdbMfL74SLk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-HYXudR29PqKtraIOeLv7Wg-1; Wed,
 09 Jul 2025 12:04:06 -0400
X-MC-Unique: HYXudR29PqKtraIOeLv7Wg-1
X-Mimecast-MFC-AGG-ID: HYXudR29PqKtraIOeLv7Wg_1752077044
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D16261955EC3;
	Wed,  9 Jul 2025 16:04:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 327E719560AB;
	Wed,  9 Jul 2025 16:03:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250703024418.2809353-1-wozizhi@huaweicloud.com>
References: <20250703024418.2809353-1-wozizhi@huaweicloud.com>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    brauner@kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, wozizhi@huawei.com,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH] cachefiles: Fix the incorrect return value in __cachefiles_write()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2731906.1752077037.1@warthog.procyon.org.uk>
Date: Wed, 09 Jul 2025 17:03:57 +0100
Message-ID: <2731907.1752077037@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I think this should only affect erofs, right?

David


