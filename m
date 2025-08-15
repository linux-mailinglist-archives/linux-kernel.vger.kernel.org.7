Return-Path: <linux-kernel+bounces-770241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BCAB278DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18E9A25DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37105285C9A;
	Fri, 15 Aug 2025 06:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVtmMeUN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DDA253F00
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238150; cv=none; b=DO3HiVP/yfToRVNdyCoX+RWwqik+WipfUm9IVbZTRtIIKNcAUgqjIXVbm+useTbsq4WN4St/bWe2hPmQxVYVviLvbT0UawrQDe/BR/6ZR3qBgKQ58POpLerkJLXuY7oG2pywPX2gAH34sv0jld7XgdUaH+LiQJ5mFQ+dIBd6w3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238150; c=relaxed/simple;
	bh=mRn+1Pe0OUG5BtFAy3VwFP0Rk0qogNg0sXk/t/7nkvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tC/YCFoTQkQ8tB80Pw0tAaDVxw0NF23fY6//4rAX3aH54ZeSVz1n+q9DhOWBY/waDs+cQButxAmwY5+83aJc38TgoKsTM/lDkGR3HKUwsoCJJ1qbX93iMW5hJWPPbTN6dOtwR+5I5qWlzQMe2nMlvzwUAOAk0DG7tuiBMkf5sFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVtmMeUN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755238146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CeuGtP6oJ3ASX+epXJ2slnSpr56EeHAKpiiitD+NUT8=;
	b=CVtmMeUNujaN46Ju6C+pjVmQEzh++W31msVOhtelg0yCN89Ycqnlsl5cggJSqlwISzAZtP
	AjFpg8Js8mJ6XARBzSv9TlQv5yvXCZ6E1+No5C8/VAYcdN5KeC0zkWkqhVxuwx1HSVsdeA
	pxnn+NOKzSDh4NCmMAJRIOBUwk6G7nM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-47MEAmEaMX-2fN6VqUisUA-1; Fri,
 15 Aug 2025 02:09:03 -0400
X-MC-Unique: 47MEAmEaMX-2fN6VqUisUA-1
X-Mimecast-MFC-AGG-ID: 47MEAmEaMX-2fN6VqUisUA_1755238141
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91B92195422A;
	Fri, 15 Aug 2025 06:09:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.153])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3D6B1955E89;
	Fri, 15 Aug 2025 06:08:56 +0000 (UTC)
Date: Fri, 15 Aug 2025 14:08:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Soham Metha <sohammetha01@gmail.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/6] selftests: ublk: fixed spelling mistake in output
Message-ID: <aJ7O8_3_GEhc6Xq1@fedora>
References: <20250815000859.112169-1-sohammetha01@gmail.com>
 <20250815001803.112924-1-sohammetha01@gmail.com>
 <20250815001803.112924-2-sohammetha01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815001803.112924-2-sohammetha01@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Aug 15, 2025 at 05:48:00AM +0530, Soham Metha wrote:
> found/fixed following typos
> 
> - faile -> failed
> 
> in `tools/testing/selftests/ublk/test_common.sh`
> 
> Signed-off-by: Soham Metha <sohammetha01@gmail.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


