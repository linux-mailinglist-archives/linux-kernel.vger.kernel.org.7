Return-Path: <linux-kernel+bounces-857478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B05BE6E79
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 875F84FD1CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE01229B0F;
	Fri, 17 Oct 2025 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJzyX/Lg"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3510D10F2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685356; cv=none; b=H+w9uxcMsoOTzoThiLblqxLA7dLJv+SmDGf2XTHEGl6cPEu0dM8AARyHciICuV5ucBucXV6ZQD9nR+hf1GnLDs752+Pg+JXS02x1oxMHzMVOaR3OgMP/uaVx9ogmNbwoeqfKKI5MCX2K44RqtymLciepL3E9IsAUXEOa62+gNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685356; c=relaxed/simple;
	bh=1dL9wTlycAsLzX2y4MTzrrBzSQsmTrPVywYZGm5zJ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYLYRdCSnwNW88Whi4kTI2EuV9sCR/UN0C3EhEDvus17I8i/OyXO+wGpIK9X/aO0bO+zS6Nu9jR9eRUeMsyZa2HuLWv2d6kCIwhVMWrfczb8f99+5tQDH0NwLO8nOsC/KRLLh1oovwbVZIvI+AbObn1M10Ng6N3kkYXW9ykIKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJzyX/Lg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59066761388so2814492e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760685353; x=1761290153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=148Eb17gJ8RxWdKQ2rnESJNbo/VxcgJDRGCnUFv20jM=;
        b=fJzyX/LgmkDUdYEEdotiJst0i7hDjJxIE5IxWhiXN1wq9C/3xiS1hnV034AB1FL/k7
         hri77aTXsOhmQ+FsEFGoa+sonlAo9Sjvq4S3LtVL4lYpRwOGPIba8TQ/XCeMqtAjrvTg
         jSncYyDcRwYZ3OC2cKNB2IOM99zjCyJnwdNL9AtCY+Q+IQEUVXgkBnVM0DdL0kbyABmH
         YIWUQG+4Wn2bpNFnxBdLXhsYy4mibyu80rsLCfM55pc1vAB6lm5qukgtJMhJaZSfKWTI
         Q8/U7UewEYRU7ZkMGMVJCaY7Ke+XBXEzXtx3zGeYvRrCURnaUtqtcPfhtqXkXmd+5y8H
         tjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760685353; x=1761290153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=148Eb17gJ8RxWdKQ2rnESJNbo/VxcgJDRGCnUFv20jM=;
        b=Imy4kPOB6MoAI3HCmy2DIx1U/ZZ8g9+T0fofc0U77s5/ZSh4tBFudjJRjzWckNaUJx
         1Uy03fjz2vWjJMygp+uyBtB84duo+ffIUyu5f2Ym/bMPla/+9XttJW2j8vxzJh9QRlbT
         FRpkz2Gk5BwNKX8ElrcbCnm9i9EfbjjlNXldXOjTyjmSY68AVvntqH64YGBPvUpRa4ul
         IS/FPqzFpwi0JDomn9J2uPacoL+jMTLvkEERzvTNuEWusVZ8QY+WRPv2qPyZKeCRJcVW
         RWd/3o8Un3yK5feARvPdv/cTfjcDciGN0JoKPU9yA4eKUZGTrnBmtXHKuSNIqnvNDkKU
         6jgw==
X-Forwarded-Encrypted: i=1; AJvYcCW4u6RPbcKRaPK90r9VhTBWpgnntIuqd8OUvr4Q5j6tFaKp1nnCGoqay65kMisb3XLsbQa2WLrobx2pXQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6aFztKulAugW8v2VS/QSZuF0XHXV/HxXawSXujEMAS0tXzFU
	UgNyzg4GHv3zxY5YEiixvTuxx2bmX0HOp5Mkc+c4xEmm39KAyxunJI2B
X-Gm-Gg: ASbGnctzpqjNDSs7NxC4vzaFptsiQuCXvA1vCZM/4oz05Kr7/qw8SHeGw1YNWgaqxDS
	GF7hf2d5M+c1wZ+8YRRA6Ew+v6oxVmtA85a7cDF4MInMUnRCQBfOVPrVAkDLcdghXmNt79RK3rg
	sPB3nlbyLvpRWTBkfS7WGS1CPvWfUBlgX3Gi04VcUh+bylZKrTj8XMXDJbJsENHqKosVtTK+kOG
	5GPiRpQf05db7q0BWuqVuM/WOqVuRsKmWetLNhIbgE4q0vdeJcTaseYvIJt85camxO+i70Cg2fY
	lfMrV75JG+BRxa7yEj2LZcO+r0ikFaQrERsWtXalAFL0RlychF67hjLIFictjI6JfElUt0fB17Z
	OytkKSssz06WVFHwVN+RazZISJUFwqEcJaZkOMnbQ/KGwbbB1vvjIdSR+wSjeqCue/Twh0oEWzY
	QyJL4WnqFaXes=
X-Google-Smtp-Source: AGHT+IFRf1ySNbsYYj5o+dwvR7Hy0y8DnWvFwza///P/Rp2kadGpW46H/2fJTcVA47GU9k2AX6PYYA==
X-Received: by 2002:a05:6512:2348:b0:585:1a9b:8b9a with SMTP id 2adb3069b0e04-591d083ec9amr2137907e87.9.1760685352985;
        Fri, 17 Oct 2025 00:15:52 -0700 (PDT)
Received: from home-server ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088563c13sm7648665e87.78.2025.10.17.00.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 00:15:52 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:15:50 +0300
From: Alexey Simakov <bigalex934@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] sctp: avoid NULL dereference when chunk data buffer
 is missing
Message-ID: <20251017071550.q7qg2a5e7xu6yvlr@home-server>
References: <20251015184510.6547-1-bigalex934@gmail.com>
 <aO_67_pJD71FBLmd@t14s.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO_67_pJD71FBLmd@t14s.localdomain>

On Wed, Oct 15, 2025 at 04:50:07PM -0300, Marcelo Ricardo Leitner wrote:
> On Wed, Oct 15, 2025 at 09:45:10PM +0300, Alexey Simakov wrote:
> > chunk->skb pointer is dereferenced in the if-block where it's supposed
> > to be NULL only.
> 
> The issue is well spotted. More below.
> 
> > 
> > Use the chunk header instead, which should be available at this point
> > in execution.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: 90017accff61 ("sctp: Add GSO support")
> > Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> > ---
> >  net/sctp/inqueue.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
> > index 5c1652181805..f1830c21953f 100644
> > --- a/net/sctp/inqueue.c
> > +++ b/net/sctp/inqueue.c
> > @@ -173,7 +173,8 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
> 
> With more context here:
> 
>                if ((skb_shinfo(chunk->skb)->gso_type & SKB_GSO_SCTP) == SKB_GSO_SCTP) {
>                        /* GSO-marked skbs but without frags, handle
>                         * them normally
>                         */
> 
>                        if (skb_shinfo(chunk->skb)->frag_list)
>                                chunk->head_skb = chunk->skb;
> 
>                        /* skbs with "cover letter" */
>                        if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
> 		           ^^^^^^^^^^^^^^^^^^
> 
> chunk->head_skb would also not be guaranteed.
> 
> >  				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
> 
> But chunk->skb can only be NULL if chunk->head_skb is not, then.
> 
> Thing is, we cannot replace chunk->skb here then, because otherwise
> when freeing this chunk in sctp_chunk_free below it will not reference
> chunk->head_skb and will cause a leak.
> 
> With that, the check below should be done just before replacing
> chunk->skb right above, inside the if() block. We're sure that
> otherwise chunk->skb is non-NULL because of outer if() condition.
> 
> Thanks,
> Marcelo
> 
> >  
> >  			if (WARN_ON(!chunk->skb)) {
> > -				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
> > +				__SCTP_INC_STATS(dev_net(chunk->head_skb->dev),
> > +						 SCTP_MIB_IN_PKT_DISCARDS);
> >  				sctp_chunk_free(chunk);
> >  				goto next_chunk;
> >  			}
I'm not sure, that correctly understand the new location of updated check.
There a few assumtions below.
> > -- 
> > 2.34.1
> > 
		/* Is the queue empty?  */
		entry = sctp_list_dequeue(&queue->in_chunk_list);
		if (!entry)
			return NULL;

		chunk = list_entry(entry, struct sctp_chunk, list);

		if (skb_is_gso(chunk->skb) && skb_is_gso_sctp(chunk->skb)) {
			/* GSO-marked skbs but without frags, handle
			 * them normally
			 */
			if (skb_shinfo(chunk->skb)->frag_list)
				chunk->head_skb = chunk->skb;

			/* skbs with "cover letter" */
			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
Adding this check here will not fix problem, since chunk->skb always true here because it dereferencing in
checks above.
				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
Adding here could make sense, chunk->skb changed => do something if it became null.

			if (WARN_ON(!chunk->skb)) {
				__SCTP_INC_STATS(dev_net(chunk->head_skb->dev),
						 SCTP_MIB_IN_PKT_DISCARDS);
				sctp_chunk_free(chunk);
				goto next_chunk;
			}
		}

