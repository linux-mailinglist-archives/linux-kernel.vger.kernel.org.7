Return-Path: <linux-kernel+bounces-819944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 454FCB7CC62
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF06C18984CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912F0276028;
	Wed, 17 Sep 2025 03:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTABMtEw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3426159E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081050; cv=none; b=mrdbytYpK8gmqxqWGShgiDyqblTx5dibIYrOgfE2xNcllQaIL82cRLcbIhm2X8CZvnIXM227U904zowCJuPjxObQgq2Lkr+UqPpz7y/b7Ys7o6Z/Eja+y9vKkG9ECQRPgvCoPmPRxAgCPCD2hw/gMRzVbeiB0iCrIqz9V+9V/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081050; c=relaxed/simple;
	bh=7vLhl8PiXmXVo/k53RZQPlq8TNMi4jCCwMfMVJcYPEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGedNbmt5DGBNX0lbirr/L+Z6NVXo4AHUDU4jWMLwpnJjaSoWoBd/XedKdQ8xmOoQlFYxY5bDcpIqqEDhQaTEWCZKDgEcL15P+k78f1QzA1t+5Oa5nCmpBBPZ8kna3MIUTj8GpZXLTaI1hUZNnDWqvsJNULj6vI9lypwHl8Fjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTABMtEw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758081046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDzqVgAqJ2wx4jnAAJfPreUIVHlLIK6MbeUbg5xoPKg=;
	b=KTABMtEwoRSAdL3cT3fSeGRrLa2PGSvSDp2PoLQafquJBSwiTYpUwfa/v6wMQjg6ohgRir
	rbfQ1UqftyVIhd2KFzc4yDueeSMKBeswBN4THnTMf1+VicF5J8C2CUt7NsdGGVDT3yMJts
	ZWzaAAx2FO7vyMyD2XFTiIoZ9DwTtPE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-Af5xTZ6zMECvhoZixD5BFQ-1; Tue,
 16 Sep 2025 23:50:43 -0400
X-MC-Unique: Af5xTZ6zMECvhoZixD5BFQ-1
X-Mimecast-MFC-AGG-ID: Af5xTZ6zMECvhoZixD5BFQ_1758081042
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D1D1180035C;
	Wed, 17 Sep 2025 03:50:42 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A45A819560B8;
	Wed, 17 Sep 2025 03:50:38 +0000 (UTC)
Date: Wed, 17 Sep 2025 11:50:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests: ublk: kublk: add
 UBLK_F_BUF_REG_OFF_DAEMON to feat_map
Message-ID: <aMowCXGbmJ4Ob1h7@fedora>
References: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
 <20250916-ublk_features-v1-2-52014be9cde5@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-ublk_features-v1-2-52014be9cde5@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Sep 16, 2025 at 04:05:56PM -0600, Uday Shankar wrote:
> When UBLK_F_BUF_REG_OFF_DAEMON was added, we missed updating kublk's
> feat_map, which results in the feature being reported as "unknown." Add
> UBLK_F_BUF_REG_OFF_DAEMON to feat_map to fix this.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/kublk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index 4e5d82f2a14a01d9e56d31126eae2e26ec718b6c..b636d40b4889d88f7d64d0e71c6f09eca17e3989 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -1379,6 +1379,7 @@ static int cmd_dev_get_features(void)
>  		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
>  		FEAT_NAME(UBLK_F_QUIESCE),
>  		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
> +		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


