Return-Path: <linux-kernel+bounces-773691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A53B2A5A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421626848C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7D322DAB;
	Mon, 18 Aug 2025 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLDeRRGl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC59322DA3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523358; cv=none; b=oNCcL9UhSAVjyvqpzPZXT+laduJXuQS7lNqsvTNkY2jB049zi8O/zz7iPUDL5MrCCbdGPIcx2bulGwIFM/oJ99kpdl/mbocnf6hFAJdHpgwz6ylxFY6rTgjJBlOCRmcESld1IwpEV23Pu6+8IRmWcfHioUW2nR9hrmMDj5xpBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523358; c=relaxed/simple;
	bh=IK8Lu8PKuyvkOtnFPoWQ4x0ZseXH1pE6M3QepO6FV/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsK5R2qiauro8xYJj2y9JNHuPCMbBrYXo6+EDvK6SLjv5loO2RIuaNLE4F+pVQB5+6d9IMBgNy/g16CK3nfsFto13aL60DcPWrw5o4JG/hgxKbZqaj+Unz0cVSi+G2uSDADUyWJ3osKBJkyl3YIGU8m2Md75CD6s24ebxu68NqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLDeRRGl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755523356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aSaXi6k74nmfHPtZsqEeM+k3D24NFcpG3SXlqeF0V10=;
	b=YLDeRRGlLhKhtXOLvG1k52iC1GQvQM7dF95qbntTx3v+tuxM50qzcAiaW0/bhaM7kejYKb
	g8Kbr+kcKT05K1oAEvzerbfSGWOjkaJqcAWwk7tj+WlTOLg0Ul8doExyiYywFxox4WPOBR
	EeK9okXz3hHA/mos5G02dqCBPHSeJLc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-qnDVEbPHN5efs5hsg6WzWw-1; Mon,
 18 Aug 2025 09:22:30 -0400
X-MC-Unique: qnDVEbPHN5efs5hsg6WzWw-1
X-Mimecast-MFC-AGG-ID: qnDVEbPHN5efs5hsg6WzWw_1755523348
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E95071955BD9;
	Mon, 18 Aug 2025 13:22:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 173A01800291;
	Mon, 18 Aug 2025 13:22:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 18 Aug 2025 15:21:10 +0200 (CEST)
Date: Mon, 18 Aug 2025 15:21:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Li RongQing <lirongqing@baidu.com>, Yu Kuai <yukuai3@huawei.com>,
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 2/2] blk-throttle: kill the no longer needed overflow
 check in calculate_bytes_allowed()
Message-ID: <20250818132103.GE18626@redhat.com>
References: <20250815164009.GA11676@redhat.com>
 <20250815164102.GA13658@redhat.com>
 <20250817135013.7567dd13@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817135013.7567dd13@pumpkin>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/17, David Laight wrote:
>
> On Fri, 15 Aug 2025 18:41:02 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > Now that mul_u64_u64_div_u64() can't crash there is no need to check for
> > possible overflow in calculate_bytes_allowed().
> >
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > ---
> >  block/blk-throttle.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > index 397b6a410f9e..66339e22cc85 100644
> > --- a/block/blk-throttle.c
> > +++ b/block/blk-throttle.c
> > @@ -601,12 +601,6 @@ static unsigned int calculate_io_allowed(u32 iops_limit,
> >
> >  static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
> >  {
> > -	/*
> > -	 * Can result be wider than 64 bits?
> > -	 * We check against 62, not 64, due to ilog2 truncation.
> > -	 */
> > -	if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
> > -		return U64_MAX;
> >  	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
>
> Not directly related, but the two (u64) casts are pointless and can be removed.

Yeah... I only reverted 2dd710d476f2 ("blk-throttle: check for overflow in
calculate_bytes_allowed")

Oleg.


