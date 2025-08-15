Return-Path: <linux-kernel+bounces-771209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A07B2842F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4D716763E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3AE30E836;
	Fri, 15 Aug 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjoPBwcP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490B291C0E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276217; cv=none; b=BGv2Qu8RhIly25c1cgzR5E9I/EiHqDe2OJwM2vr7Jr2I/e3PxrAxEkMAn4Fb2AG77WTcWUT/65u2AlglC6C4aMPhDlHr0ZdooS303XMWGaeTpbEEevt7fG2jLylhUyeUcnMOpQ8ONCWMehAa6k4f8qopmrlpW34eq/Jeke3CYrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276217; c=relaxed/simple;
	bh=d6s5mw9sHkg6YKafG5LiEk6hnuv1ozkrG01/Dh/PMVI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qE4x0XKLe5BojLy1Tqi2ILdkKpI1QnKDWrJW29hmpJXZuFcPAhmIz8PPuWbkDVOSkUuoIc5zV1ok885rp22y9I0stnMWm6gk8r9RiTTGqOu4fYJI/9KU9iECyJAs/2XOtf59ydj3BHulpz7QgtusdYGrQZUKL/uYyd0bXsBsFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjoPBwcP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755276215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=vXJMMAkJx56X/hA3YqllWtkEAeMRZkBT06S+duMW7vc=;
	b=JjoPBwcPB9k/2RqA9l66QXT8D+F/Zjn1TYnSq622WGs/+1Ro3H2pZU/XCfUoi5+d9SpegL
	CWiPXbeAloVWDc0k/C+qwBihGTW7pQmFd/bryo94KqHEkDT4rmWxV2dE6P+k3kkbftev60
	d7lFa4QSa5M59oGZc6S8yo4btMwCiBE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-8swUf-3WPu-f6iGGf-d0mw-1; Fri,
 15 Aug 2025 12:42:27 -0400
X-MC-Unique: 8swUf-3WPu-f6iGGf-d0mw-1
X-Mimecast-MFC-AGG-ID: 8swUf-3WPu-f6iGGf-d0mw_1755276145
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 405901800561;
	Fri, 15 Aug 2025 16:42:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 676C330001B5;
	Fri, 15 Aug 2025 16:42:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 Aug 2025 18:41:08 +0200 (CEST)
Date: Fri, 15 Aug 2025 18:41:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: David Laight <david.laight.linux@gmail.com>,
	Li RongQing <lirongqing@baidu.com>, Yu Kuai <yukuai3@huawei.com>,
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 2/2] blk-throttle: kill the no longer needed overflow
 check in calculate_bytes_allowed()
Message-ID: <20250815164102.GA13658@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815164009.GA11676@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Now that mul_u64_u64_div_u64() can't crash there is no need to check for
possible overflow in calculate_bytes_allowed().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 block/blk-throttle.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 397b6a410f9e..66339e22cc85 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -601,12 +601,6 @@ static unsigned int calculate_io_allowed(u32 iops_limit,
 
 static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 {
-	/*
-	 * Can result be wider than 64 bits?
-	 * We check against 62, not 64, due to ilog2 truncation.
-	 */
-	if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
-		return U64_MAX;
 	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
 }
 
-- 
2.25.1.362.g51ebf55


