Return-Path: <linux-kernel+bounces-828936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A688B95E35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722C819C2ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627AE323F63;
	Tue, 23 Sep 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flUf7qgp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D7323414
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631989; cv=none; b=Z6KJs3ZYYU4Qyid0piENOHUT99C0wiNTHsOthR5Ug5eyukVPIVUYKFynZ0VCxRAon+T3Z/bIvzM0diTgGjseduYA41bm3pjEeVRRCRDotyWQt6FPd4y+vu6PBVAV7ABAYVMF3WIs2WdOgB7nZzwDdEBDnrlvldEl6cBD9Z7enYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631989; c=relaxed/simple;
	bh=nifdnnN/YFXrBSaLDuXvFzfIaHl2H+EQkr7zlSF4twM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=omMAWbh3QmiewYa4rArU5EPKqJxIB58AbFYFhYvfuKaUi7nSmEkPqDDwsBlNbioBnniVUnM+mOqG8Z47Imi2G//lRR2zt+Wumjea95rK7mloJY49NQejnfnqerowC9RbRd4GPYHw+X5xsND3hsyXXwioIdCQruH5vLU/keUq7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flUf7qgp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758631987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vIUqLFXCJLnNqlkFKFk7iAZM2JcoBEoVoE3P17SZOiY=;
	b=flUf7qgpaJZjOmM9k3fiQc+ZOPUCb3PXa9orxXUvnJdACAsqG15VxBjfryNtSgaWsGqlV/
	aRduJHLDA8uRs6iraUpuV8z0LPf1VKXO4VfivA72FNlKnh/NqNBUhb0G9FlZLmHxVEOFQg
	UjJiJaXsVv3nA94K3DCq2o/rmCA3ViA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-btGlCJciM1ycMpHZbraiNQ-1; Tue,
 23 Sep 2025 08:53:01 -0400
X-MC-Unique: btGlCJciM1ycMpHZbraiNQ-1
X-Mimecast-MFC-AGG-ID: btGlCJciM1ycMpHZbraiNQ_1758631980
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 653701955DDD;
	Tue, 23 Sep 2025 12:53:00 +0000 (UTC)
Received: from [10.45.225.219] (unknown [10.45.225.219])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A86C1955F21;
	Tue, 23 Sep 2025 12:52:58 +0000 (UTC)
Date: Tue, 23 Sep 2025 14:52:52 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Mark Brown <broonie@kernel.org>
cc: Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: Missing signoffs in the device mapper tree
In-Reply-To: <aNKMSd1hhaeWvQ-A@finisterre.sirena.org.uk>
Message-ID: <95d76fa6-d6be-f34c-b5c6-b801e80adaf5@redhat.com>
References: <aNKMSd1hhaeWvQ-A@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On Tue, 23 Sep 2025, Mark Brown wrote:

> Commit
> 
>   9fddffbf6aa35 ("dm-integrity: allocate the recalculate buffer with kmalloc")
> 
> is missing a Signed-off-by from its author.
> 
> Commit
> 
>   9fddffbf6aa35 ("dm-integrity: allocate the recalculate buffer with kmalloc")
> 
> is missing a Signed-off-by from its committer.

OK

I fixed it.

Mikulas


