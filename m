Return-Path: <linux-kernel+bounces-772720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920DBB296C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EF4201981
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A13024469B;
	Mon, 18 Aug 2025 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaeV8iKC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA122165E9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483246; cv=none; b=PvEZFFpcGETzkrxIgx1WgexLW8OMdtux0cp0Zdl6vs3CD2UtRKgCIVl80oRcJiw3OZO3trLHvsoBfQGIhM08t1yrEzkbGNbC0FzCzYyV2sE8HTV6V7iFDqIwKTa6ljVY9eU0SlbTWHLlpbvJHr1pqOpP+6rtoyr+uQQk70tefoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483246; c=relaxed/simple;
	bh=IJc2jypFRnh16B3SmyiGG7GcC4dV7V2WPKeNjWuZ/7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhWBYytCB4N3RtcIZI9HBia30F/Y02fB/kiqD5O5tFl+8uvJQXw5MBu5O63qzc/vS9r3VKVm53dxQlMFJ4FRjIKOqaCK5sjpS4734hDVjMnBegVBBGq6U/s7yRXc0D1vc5N73oQb36xJS9BPPdtu4v5ms4hrFq9HuSOcJedLt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaeV8iKC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755483244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b8XuxuYGVNjlRqBB5h51vG9u+ccEzqMpuG57Y8sa914=;
	b=XaeV8iKCfMJ3l71m9KmuoE+fRecRvCBVE9QQXoliNhhlMJPvWAash8Oy46JbDwQCbSM9MX
	RrKSK5Xee8kscv0lWsM/09x3UQB5Nuhns1Z5fzKwtALwNOt6uHUbfFUyZoeo3YQP+tR9R2
	VrB+hsMQH2h3SaFN80a32YU92armjNE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-zUxGj90XMYyc361uKnXIBg-1; Sun,
 17 Aug 2025 22:14:00 -0400
X-MC-Unique: zUxGj90XMYyc361uKnXIBg-1
X-Mimecast-MFC-AGG-ID: zUxGj90XMYyc361uKnXIBg_1755483239
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E43E180034F;
	Mon, 18 Aug 2025 02:13:59 +0000 (UTC)
Received: from fedora (unknown [10.72.116.112])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DED219560AD;
	Mon, 18 Aug 2025 02:13:53 +0000 (UTC)
Date: Mon, 18 Aug 2025 10:13:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: shuah@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: Re: [PATCH] selftests: ublk: Use ARRAY_SIZE() macro to improve code
Message-ID: <aKKMXOeHEK_LHV8M@fedora>
References: <aKGihYui6/Pcijbk@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKGihYui6/Pcijbk@bhairav-test.ee.iitb.ac.in>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Aug 17, 2025 at 03:06:05PM +0530, Akhilesh Patil wrote:
> Use ARRAY_SIZE() macro while calculating size of an array to improve
> code readability and reduce potential sizing errors.
> Implement this suggestion given by spatch tool by running
> coccinelle script - scripts/coccinelle/misc/array_size.cocci
> Follow ARRAY_SIZE() macro usage pattern in ublk.c introduced by,
> commit ec120093180b9 ("selftests: ublk: fix ublk_find_tgt()")
> wherever appropriate to maintain consistency.
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
> Testing:
> * build checked for testing/selftests/ublk
> * tested by running 
> 	$ ./kublk --help
> Which exercises the impacted code path.

Nice!

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


