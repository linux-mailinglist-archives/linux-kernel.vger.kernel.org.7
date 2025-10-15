Return-Path: <linux-kernel+bounces-855218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3716BBE0882
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770531A21FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB720305044;
	Wed, 15 Oct 2025 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGRCPYyw"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65171D90DF
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557813; cv=none; b=EqALGKGiuE7/4dgQ3vDkkyrdBpklIfslKfDkiJEVgin6GzryTXl7K+tVbG3c7qyEo3YHR+uFeGxNXsLgkMqFPsZHJ8aFGkZh7Bya7dfl4EXK0eSrFZ9oPpUbU6/Lni3duTee4l8e6RSmcPRdOaD9VsqZC1ec5//8Zi+zbeWg47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557813; c=relaxed/simple;
	bh=qdxdnXO7dfrt8aCwjz8S5Ntf+heP3QOx0qCchHU4vHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtfKvcZPi7S0farwkLAZoAkzdDv9IVtu3YAwZycbrgIuDl0TTtojZyUCYpnonsk7L1E5e629ZjJt9qydd/VUA1nZngGbCLvgrELccIMOW3wlcTWW52uyHIdfd8LI4/K/G8kwi9u2LHrEOZAXK10wriqlXnJnuQCp2du/9vDAaYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGRCPYyw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33255011eafso4743a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760557811; x=1761162611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSXtDozAsQRt+awsPY1YKTWWimZyw22+7Ej5rwMZxAA=;
        b=nGRCPYywnL0MHHI1uteOKBetuVuTWyW91iZe7HuxTYY0yFz1+UJFFq1bhhcMkw+spj
         aIf7XFWRfmkdclIJUzY5NjL6rOStIWg9J91pK+w/uvgltcU0TKOyJrFb1sjwqh3tDm7s
         faGtBj/cLWvdUAGP1XgUfPBl+yCCuIEM517EnS88Ij6+xnBjn3D8hhGqOwjZmAMgfhb+
         Dlx0GyfWUqwG7hha4x7dqV8679W8xVDkWMlIfhdQuBshYisNXsOZ+HGlzoBiad3/pUWN
         +8oDDoN3KyD84NSruPM7A2d6eLnpq+xdCX7ohYPZw6yO+hTRV1vTBdHbsUlEGpETU+ki
         Mmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557811; x=1761162611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSXtDozAsQRt+awsPY1YKTWWimZyw22+7Ej5rwMZxAA=;
        b=JASJIkKq/zx7DhPjw0OGvvzFnq3KSdntkDdh8IMYTTGaLUpJAcOXy4ZYUoScPmuQwK
         ObZkl9SVqp0+pVeq7pfCZztWdthhQxBzH2P3WKjwxkqxkQhlf+1UKu7I/h6FNvrkkoDK
         p3OK6NJg5AFDNUJAQ4zCD+370rPNR1ahDdyzdZGg5mQQgT09/0HJpA+40rzX1QNWLLVf
         YqwyPZ7gAm7FQGAsSSAe6NYALU928poM23Iq52slZxax+c+pZO7QOZYQPwdN3LaB4Rdd
         XqWjny+Dah3BeNRH/kTKr/UX8m5an7bv4ZTRr7x0XDOKY7Kl7g1rZkNEy/VZl4eBuB0U
         Gc5A==
X-Forwarded-Encrypted: i=1; AJvYcCUJiEWxEighixJPK2/raIVeos79P/SQ11rJNzORmADjnlbWbvQAivDowTqyYiJvpAQI6+i7JH9MN3lZ6Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+XsbnSHHSHolJkhs+GAyFihtOJuNHDvcEy78J4O4/c/idoLt
	L/Nc/Kken/Nu4j+BNY5SIkgnJYKnqY8dpcD/U4UqVPmk5GgiatUpQJAL
X-Gm-Gg: ASbGncu5TpoOCrzILczEl2ej9eOuGusPtr4CX2fNoH4DRiqnchy+aMJGjxmj4P06AW5
	MdORcQJgo6IvYrt3As4f2J2/5lfv6cbhMwX9VMDrr/I4ucEznvLlx/jbifExQwN5n+C5PBoljbi
	U/sf1uCkWOHIOOblf94bwELGweDpoCcafpgbeCDF1IYDekNQ08Cgwp03kFN/5qBcDDEVrAgX0UF
	CCLti492jOtGoJnnRx41fdLEdVuLQcv8tIcdd6Vy2X27qEvNAWczezmaokeHPMmE6WvGzH+FE+0
	XaJkYrK4eZxpqcrEbeq/c6mRGAuavFlpX6tXqjJVbhwr4y8Ek8/TlRRn5cFsEz/UMw7K0lK8mB9
	l92YF6GqYkBxXtt/CahuG/qzSh90QEUHE+494HNQbeAwcKzeeZxIsFUvG3HcSOF9FlWHIA73CXE
	F8QQsI
X-Google-Smtp-Source: AGHT+IGyCUeGhHmi0GKV532SbGwCqharBSRZhQLDnQHs6oWMGcINOpBVl4YWDotX3YHZ9W8I+6d1kw==
X-Received: by 2002:a17:90b:4d11:b0:32e:7270:94a4 with SMTP id 98e67ed59e1d1-33b5116a3c5mr41420491a91.14.1760557810742;
        Wed, 15 Oct 2025 12:50:10 -0700 (PDT)
Received: from t14s.localdomain ([2804:29b8:508a:1537:573a:39d:6287:7ddf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b97853829sm3578251a91.5.2025.10.15.12.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:50:10 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id C835B11A8199; Wed, 15 Oct 2025 16:50:07 -0300 (-03)
Date: Wed, 15 Oct 2025 16:50:07 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] sctp: avoid NULL dereference when chunk data buffer
 is missing
Message-ID: <aO_67_pJD71FBLmd@t14s.localdomain>
References: <20251015184510.6547-1-bigalex934@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015184510.6547-1-bigalex934@gmail.com>

On Wed, Oct 15, 2025 at 09:45:10PM +0300, Alexey Simakov wrote:
> chunk->skb pointer is dereferenced in the if-block where it's supposed
> to be NULL only.

The issue is well spotted. More below.

> 
> Use the chunk header instead, which should be available at this point
> in execution.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 90017accff61 ("sctp: Add GSO support")
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> ---
>  net/sctp/inqueue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
> index 5c1652181805..f1830c21953f 100644
> --- a/net/sctp/inqueue.c
> +++ b/net/sctp/inqueue.c
> @@ -173,7 +173,8 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)

With more context here:

               if ((skb_shinfo(chunk->skb)->gso_type & SKB_GSO_SCTP) == SKB_GSO_SCTP) {
                       /* GSO-marked skbs but without frags, handle
                        * them normally
                        */

                       if (skb_shinfo(chunk->skb)->frag_list)
                               chunk->head_skb = chunk->skb;

                       /* skbs with "cover letter" */
                       if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
		           ^^^^^^^^^^^^^^^^^^

chunk->head_skb would also not be guaranteed.

>  				chunk->skb = skb_shinfo(chunk->skb)->frag_list;

But chunk->skb can only be NULL if chunk->head_skb is not, then.

Thing is, we cannot replace chunk->skb here then, because otherwise
when freeing this chunk in sctp_chunk_free below it will not reference
chunk->head_skb and will cause a leak.

With that, the check below should be done just before replacing
chunk->skb right above, inside the if() block. We're sure that
otherwise chunk->skb is non-NULL because of outer if() condition.

Thanks,
Marcelo

>  
>  			if (WARN_ON(!chunk->skb)) {
> -				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
> +				__SCTP_INC_STATS(dev_net(chunk->head_skb->dev),
> +						 SCTP_MIB_IN_PKT_DISCARDS);
>  				sctp_chunk_free(chunk);
>  				goto next_chunk;
>  			}
> -- 
> 2.34.1
> 

