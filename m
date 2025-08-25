Return-Path: <linux-kernel+bounces-785238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EEAB347F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95151B251CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631E12FF670;
	Mon, 25 Aug 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnZ8A/6S"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8E023BD04
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140870; cv=none; b=c6fE90/+b/JIMKzRKsN8rbAF7EvNhNn8beLF88xOaR4YCDcHboE2/W3ae4RvXQuV8g592k8ASIR3agz4bf1znmV8uF+CZfh6awke9tTzSgMlfR1MZOVN3Mb4fZQjejbos0nqc5qICYhRg4GgUxwpJJleugbvL/P73Kwkx0Gp9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140870; c=relaxed/simple;
	bh=roWibsHwVbeQHw9llMaW/c8rw+10Q6KWLUOnXUvLN04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on98seAbnlTC3u8Y7hWlFT5eUREeGZ/0nmO8Mfs6jFPOjg3bM3lDKfh/Id76Xud9UZ2EJsFvoF6svKNfpV6sfCN8GJ62FsiLqvgRmU3qmc6r0Fcaz7djZX2tgNikf5+LB4I1jXdmvoGbiNGiMIcuozbOcE+ipaNzR31BC9BuK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnZ8A/6S; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so4019551b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756140868; x=1756745668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w0+QC12HMYwRbwt2Eebgb4bZovGNA6wZjE5y6HvsVX0=;
        b=LnZ8A/6SvuhQ09QOPyJsC31cLIa9S+QyKHkqXozQ0rzq+djalOm+GA4V1hce0zIg2k
         1RPAVNF99V94A22YgdHOXftJRqkQadASevKFAV/8/1U8CXby4qizzcTxws6vd/aHLZp0
         x9wO5jp2+ckaEdDpvDl5ZIwPYsO1E5y6Rh01qCXrVIlyHa4sDLGdy16iqZJw4/ZnF8Dp
         Pr9aau5s1W7OPwBoFj95tU+KHAS60IQmmC6/W/A5qGqbulhnFGEI5TiKqcc16HFl7BxF
         bRa/6bLUEpD5ZciagqQDD10NBIKIZECZylM9JuZFGs8qoyi8h5c6zTXjxUPDSUm7Gt8n
         zV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756140868; x=1756745668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0+QC12HMYwRbwt2Eebgb4bZovGNA6wZjE5y6HvsVX0=;
        b=nhwUUvSiQuQrowOEqI3ND3xKqmPp4/8rkaYB7sgulmwjlYNypzlvJ+dxYocE6uYORA
         Cvtk91Jx1MoqpNWcPshpDc8fx1eZSQWM0HJ9EJ3tt4y5Ly5G4Cl15okL6fZPcmLkXcUZ
         mVNZi2azoCqJzRAiLYGfQapY1Hk14dOs1slAO1TkvZ1qRB0pEUMyec9OyRmYejhqKksW
         YSjJLGoU7hi8YEI9L2BoHvnsDKVmRQ3WkQ2jBOvac3YwfemXoLt3yBDlnKeDVREiDF/O
         wSsiUL7uncKoArc/qt57fnfpddMI0rSZ6HV/17fz6o5dewXaDRe4rQJtxgtvU7IXeWKG
         EIBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2bbDwcMcy2X7eCy1TRzYzDEAy1m/f38SUIBLkc4uV1qh0QURh/WVC7BvBQOExAHtcwQL8SG07IaxSqho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMOlIu9kOBde1mlhEOlpRAa9yCmH+TFt0p+THenwKPLVnXudca
	NRWKFA1QFNJWqsDiU3DWvvNYafNQrjI/sn2yNaR34OvykQJctiYH9KOT
X-Gm-Gg: ASbGncseyMW1mbGUng8iFO/ZjcNcdHscxMk06oHoLU7rkQLg2HNEDtANoRSf4I4XbVT
	Mx8BOYBOgp97P5iKBaAGM/kM3RiMKFOiL625Ot3ygzZViVdHRp4raWBhJMCHIn1/hjP3ekMRrQA
	4+bsA0zHNKg1M5uiSe4aIzBO5Cmj7+XzujN+lgOuNCw8f7fmTZ4mGMBysLEb/pKVbs+WlwHs/TU
	WstGSgEOP6W9tZQ0vqNHoncqGmvjjEtvGdFrhexBXdNUC32rqRG5bPIUknlOYQIdES2rEVdm5FU
	OcUiqaFE9nv383+YmUqs87ZsDOvd2J+Hkf9FcmOWwdxnw/0RQTY1gUJwAlRt7VOqyOHkV1Nl0GE
	+IbkytHRxhwRyVSKHp1xsc7cgNw3JCll2OgAS747XKCgmeH/S/Q45oTyxvDoL
X-Google-Smtp-Source: AGHT+IFtO7OmgS73c7ShNyzYjxuapqykU6vyiTH+oxzBQwalnc3EUCRcEK9ePGSg0BDx1/oChUyuSg==
X-Received: by 2002:a05:6a20:a10b:b0:243:78a:82c0 with SMTP id adf61e73a8af0-24340da0e0emr20982459637.58.1756140868425;
        Mon, 25 Aug 2025 09:54:28 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e39cb4ebsm3131907b3a.85.2025.08.25.09.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:54:28 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:54:25 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: "Guan-Chun.Wu" <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: btree: fix merge logic to use btree_last() return value
Message-ID: <aKyVQRG9k/CboNRn@visitorckw-System-Product-Name>
References: <20250822085851.566303-1-409411716@gms.tku.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822085851.566303-1-409411716@gms.tku.edu.tw>

Hi Guan-Chun,

On Fri, Aug 22, 2025 at 04:58:51PM +0800, Guan-Chun.Wu wrote:
> Previously btree_merge() called btree_last() only to test existence,
> then performed an extra btree_lookup() to fetch the value. This patch
> changes it to directly use the value returned by btree_last(), avoiding
> redundant lookups and simplifying the merge loop.

The code change itself looks correct.

However, the subject line gives the impression that this patch fixes a
bug, while it actually just simplifies the logic. Could you consider
updating the subject to better reflect the nature of the change?

BTW, it seems that only the qla2xxx SCSI driver uses the btree
library, and that driver doesn't actually call btree_merge(). So in
practice, this function is unused in the kernel. Should we consider
removing it entirely?

> 
> Signed-off-by: Guan-Chun.Wu <409411716@gms.tku.edu.tw>

Is the dot in your real name intentional?

Regards,
Kuan-Wei

> ---
>  lib/btree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/btree.c b/lib/btree.c
> index bb81d3393ac5..9c80c0c7bba8 100644
> --- a/lib/btree.c
> +++ b/lib/btree.c
> @@ -653,9 +653,9 @@ int btree_merge(struct btree_head *target, struct btree_head *victim,
>  	 * walks to remove a single object from the victim.
>  	 */
>  	for (;;) {
> -		if (!btree_last(victim, geo, key))
> +		val = btree_last(victim, geo, key);
> +		if (!val)
>  			break;
> -		val = btree_lookup(victim, geo, key);
>  		err = btree_insert(target, geo, key, val, gfp);
>  		if (err)
>  			return err;
> -- 
> 2.34.1
> 
> 

