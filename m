Return-Path: <linux-kernel+bounces-624123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EA3A9FEFE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 03:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884BE1A86C72
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 01:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E92B1953A9;
	Tue, 29 Apr 2025 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHPbbd4G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47D13D893
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745889776; cv=none; b=OuH5Ygj1aPGM5Ijg/heIV4AFwJkmsMrX6ZajUmgI5tet6zXMH6YQzy+lom1UnpM3Uzr86USgiNts8DcK7vddgqZ4RAtCpbG9SleEUJCUiK97aMI+Yh3Gx2qxONtDoeUKiQhxIHWFoHmmSKTD2wJm5JMC4Ny6afUwsuLq//YBB4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745889776; c=relaxed/simple;
	bh=lDdvpoV6qxHTWi1ZaNBNMrxyOcf/jUN7/pAntxJBUTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElJtkBN1MqG10b0rp/u0EFQdE1u90srv7LSOjRif2pC+/SkuqP6kPZjeYXKSJvN3W9+uxdeWQsbup2jwM75VB00xYCOXg+IMk/TvTb/BSqLVp6tRACjbNcIpRhgeGfqNp3IToyvWA6X+P2eRo1rzVxfw9+XdYxnTdaHJYaz/Ri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHPbbd4G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745889773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R1De2Y8u2PUpjPCXzMy0cWwGfWJHKir9txxa56K9soM=;
	b=ZHPbbd4GJjoLjeHryi4iYdkIospAhsOGAgzkyVUw3N6fv+xS5ITbZcx4kzzy5gnaCKj71Z
	Q+a0JVX3ckEFwv/CPbnQCZqDIG8rqB2P3OJ4tOnuPSWt6dLjiI2XgADkk1mSeLyWLjSkVa
	rSl3OvHtMo0+VL/wcAmCavXau3QSL2U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-97_8gxpSOaChXuV_Eijc-g-1; Mon,
 28 Apr 2025 21:22:50 -0400
X-MC-Unique: 97_8gxpSOaChXuV_Eijc-g-1
X-Mimecast-MFC-AGG-ID: 97_8gxpSOaChXuV_Eijc-g_1745889769
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBEB81956094;
	Tue, 29 Apr 2025 01:22:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 690A519560A3;
	Tue, 29 Apr 2025 01:22:46 +0000 (UTC)
Date: Tue, 29 Apr 2025 09:22:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: ublk: kublk: fix include path
Message-ID: <aBAp4VUNx20r_fiB@fedora>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <20250428-ublk_selftests-v1-3-5795f7b00cda@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-ublk_selftests-v1-3-5795f7b00cda@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Apr 28, 2025 at 05:10:22PM -0600, Uday Shankar wrote:
> Building kublk currently fails (with a "could not find linux/ublk_cmd.h"
> error message) if kernel headers are not installed in a system-global
> location (i.e. somewhere in the compiler's default include search path).
> This failure is unnecessary, as make kselftest installs kernel headers
> in the build tree - kublk's build just isn't looking for them properly.
> There is an include path in kublk's CFLAGS which is probably intended to
> find the kernel headers installed in the build tree; fix it so that it
> can actually find them.
> 
> This introduces some macro redefinition issues between glibc-provided
> headers and kernel headers; fix those by eliminating one include in
> kublk.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

kernel selftest is supposed to run under the kernel tree without installing
headers system wide, nice!

Reviewed-by: Ming Lei <ming.lei@redhat.com>



Thanks,
Ming


