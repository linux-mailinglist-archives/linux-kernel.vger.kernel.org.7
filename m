Return-Path: <linux-kernel+bounces-784536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8703B33D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7202047AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CB5286D50;
	Mon, 25 Aug 2025 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEALvbMi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993A1D63C7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118742; cv=none; b=n0cmeKeG2+M+4Qfllc7xoxfE1p4G60LcW3e2FrNzLAHTtae1Y3u/EBWULlR/Lp0+7+khw0PU9iLCC42rfPKpe0hH5Fd3wvSnoKFi5Ln1TF4Ly73KwQWxDgMN2j9egCVXQ+gjKY6mO6+YWGVJeWOFw1O3nyVOdyUYIVrb15SlRco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118742; c=relaxed/simple;
	bh=2dJ/hIar2gPkHwoTDnL1EIwlJGA2iXFxDtzG1as+tTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QT9UOhi0YwVmDWoxFCMi6P7iFb5960snyEG35qqf1ZAVOyD/ivOZzrnQn4nqeraF3KzHrBhclFkH3Kf+InL+CvmEFi+Yt1HWei9HMI3UAzpaFP8Aq8L8GEm5O2d8KgaJQlA0uLl3/hVzoYwlT3j/jNsVn75Im8PxkE5kcMLqDAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEALvbMi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756118739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twr3qExVYA+20YD8r44C0vI2bIzqy24zETLnKAnNBxY=;
	b=dEALvbMil7WahvDnN2npUjR0FGlZMd5StfCi53yCeSrgz/5gZq/AvzJSBf7jIVpwN5YzYp
	MuNHi69TxyCZAGZr4R8+9ZnN5dZ+FOsaLY3wQ+ynn5ufsbmTAXHI9vISx2rm0urA6+RMbg
	QO7GfqdtCGf9sssiJAluNFoBlrHs/Kc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-CbSktnDrO-G6DhSlmqOYxg-1; Mon,
 25 Aug 2025 06:45:34 -0400
X-MC-Unique: CbSktnDrO-G6DhSlmqOYxg-1
X-Mimecast-MFC-AGG-ID: CbSktnDrO-G6DhSlmqOYxg_1756118733
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 582221800451;
	Mon, 25 Aug 2025 10:45:33 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0044D1800447;
	Mon, 25 Aug 2025 10:45:31 +0000 (UTC)
Date: Mon, 25 Aug 2025 12:45:29 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	jstultz@google.com
Subject: Re: CLOCK_AUX stepping
Message-ID: <aKw-yTq3jMeku5yG@localhost>
References: <aKwsNNWsHJg8IKzj@localhost>
 <20250825121415-a748d95f-7cfd-4d28-be56-dc0addc27ff1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250825121415-a748d95f-7cfd-4d28-be56-dc0addc27ff1@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Aug 25, 2025 at 12:22:34PM +0200, Thomas Weißschuh wrote:
> For high offsets we are stuck looping in __iter_div_u64().
> As far as I know, doing regular divisions in the timekeeping hot patch are
> problematic on some architectures, so instead of storing the offset as a
> single ktime_t, we might need to switch to 'struct timespec64' and do the
> division on clock adjustments.
> 
> Can you try the following patch for now?

The patch fixes the problem for me. Thanks.

> diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
> index 8ba8b0d8a387..8190e9dc6569 100644
> --- a/kernel/time/vsyscall.c
> +++ b/kernel/time/vsyscall.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/hrtimer.h>
> +#include <linux/math64.h>
>  #include <linux/timekeeper_internal.h>
>  #include <vdso/datapage.h>
>  #include <vdso/helpers.h>
> @@ -143,6 +144,7 @@ void vdso_time_update_aux(struct timekeeper *tk)
>  	struct vdso_timestamp *vdso_ts;
>  	struct vdso_clock *vc;
>  	s32 clock_mode;
> +	u32 nsec32;
>  	u64 nsec;
>  
>  	vc = &vdata->aux_clock_data[tk->id - TIMEKEEPER_AUX_FIRST];
> @@ -163,7 +165,8 @@ void vdso_time_update_aux(struct timekeeper *tk)
>  
>  		nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
>  		nsec += tk->offs_aux;
> -		vdso_ts->sec += __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
> +		vdso_ts->sec += div_u64_rem(nsec, NSEC_PER_SEC, &nsec32);
> +		nsec = nsec32;
>  		nsec = nsec << tk->tkr_mono.shift;
>  		vdso_ts->nsec = nsec;
>  	}
> 
> 
> 
> Thomas
> 

-- 
Miroslav Lichvar


