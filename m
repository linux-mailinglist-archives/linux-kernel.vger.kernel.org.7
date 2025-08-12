Return-Path: <linux-kernel+bounces-765408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B8AB232D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E902A2512
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34E72FD1DA;
	Tue, 12 Aug 2025 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="fouCeRSm"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342DC2F5E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022645; cv=none; b=GQKd5BBpqD9c15OJv5TkrBzgWsd3y1g63/yUH2+xF9hLjE70F2sW/SWnP7H8xoXbb27H6otQE4HSnNR1NGXRwTfexVgKt/b7GCXAR/DQ8Z4yObQEJkl/NKa9XbpLvSmsNOgqf2hqve+I99w4DRVKp4N/+wAmw2m5+oasNM28h6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022645; c=relaxed/simple;
	bh=EMvQd3d1WlKkMgyYl6nmwZf21rQLaUhdMd88yyw2ml8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyY3TD+EvlKpxBz76FbnKmGBB5zyhFqO+yXl3T84ZCkEbrN4gLG1ZC8+XxQ0GHK+E+juYEA0n58nuzjuXvrRPKHU4xehetBr4Y7h2BFZNOsMiPu8UgVW7znrVRq0E3MCAiHcYdSG581+la87wbt7cXlS4Mns9gfnXgfC0kBfKuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=fouCeRSm; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso6325370a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755022642; x=1755627442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMsriY29YvNF5zAGx23oTqCNdYx68Xnkyo51DYe24q0=;
        b=fouCeRSmU+GOlJn8FNDilWLnfH4F6mxza0lezZWMPGB/kPLWaBpYhnh1u5OMBBnyrC
         UvMfkIjQ+sgcCT3ekSgl0l7RgQCTCzLV885GoptsH3ObVJq3jlwR3MUdtVuRYuJw3h4T
         QXFbRSU9OxxnGxM7OT4xpbLvlajZ5rW+n+i6qk2/IbkumwKuoVdfPH5k5JZtrMYsR4N+
         CWkusqUSJ4xmNedT+Tgx2RrOyFT7KHxXi//2pCV+1MaiFtefF1L3Zv2YBsxNWm1PMZXH
         YrwAUUdewgs+cGFE99k9uOMZbs8aonzq2uUiGEf9lc5J5vj0FFC1JBWqsW5ozcS/nhgD
         dHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755022642; x=1755627442;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMsriY29YvNF5zAGx23oTqCNdYx68Xnkyo51DYe24q0=;
        b=M1yb0/bRvo8q8bihGVrQ7kARcviRKuriW3u4paLpmQ2+xN2BGoXb5WksZpk1BACuxc
         hHJgWEREvETH++9BV6D0BOInNxLmWMxaAmIQAIG5rffpV3VEnnp7VpesfKtmfk+UjCTB
         mAApEE28IgYh+D/iheyDq2FRPDcO/GCS4eWZF+GSJq+11xPQyiHjBMw/yAlATUC3Nkv4
         ULaNHB05VXnpVpqmA2BBvXI2ef1trUN2Vp9gaqlB3dXzn1dD5NKebHkV5igCxRuAcqMV
         ZRpIDYuh9YKdmIv4vzsmN1qA8iJ5OLI24EBcfqy05DKNAtgiFx2L9yc/CV45A4lJ3GIF
         ox4g==
X-Forwarded-Encrypted: i=1; AJvYcCXOTc/TmHkRhIFrUU804fD2svfQF00i9U0LS5z+xhMjMyxYmCJ0RNtDYv9VWMAHzorq7mFo11KRy2T3E1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFF1tqo5K4ao97WUhBHRu7A8SuTfOjHLDgTqgZiqRy2uv1JVL
	qWSG3trT8xCytBKrlkZBOW2dnlWOv7yw18Fm4irnU2j09zRGC5P8jX5otx4p7mtB/c4=
X-Gm-Gg: ASbGncvIe6i0GML5eiz9kSjbgPWuVDxkjqSiK0kIsxbr/ETZrSG+utSP13LJ7FJiKZn
	/fqNhi6C0lU4xkuxVG7ZJsgjjBM22/dVHWiQV3N1WiL8jGbb/JKUSpvcmZVBjv1Yjrpupjz9i4v
	luPZr6IiugMIW66zVJPbSXq4ZgSU8FY76Wkm5I+6QOIx+pAViuPiOIPIn0F54hdjLfhExkQtLPm
	0suHx2bVSw6uTaecuNYKKYHTZ/DFhCtuExVGIoq1kyhadrMoS6jHWx21YlOqykDFYTuND599sPh
	QKO7eIuDFW0E3S/gg/5JEnV+oEp9RgDx1IKg0dLFBsUD4uCSxMAtORrhHFOK3JK7PlT7/hG+vHf
	uL8vWQS2gw2xhA6p6sshoKH9D1qKGkxP8jJ7FtckOzCpAOoqXTMQB31G5wxkwIJVimWuQ5R4f
X-Google-Smtp-Source: AGHT+IHNhWzWkwRf4t4T8nX0GvXq0IE7nZzVv4i5678hX4iND6uqFIFh5YX2G/IUawi7Y4lWCYrvwA==
X-Received: by 2002:a17:90b:1a88:b0:31e:ec58:62e2 with SMTP id 98e67ed59e1d1-321d0e6d0famr45436a91.19.1755022642311;
        Tue, 12 Aug 2025 11:17:22 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321611dd694sm17922432a91.1.2025.08.12.11.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:17:21 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:17:19 -0700
From: Joe Damato <joe@dama.to>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@axis.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND net-next v2] net: enetc: Remove error print for
 devm_add_action_or_reset()
Message-ID: <aJuFL__jLySvTNIp@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@axis.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <pnd1ppghh4p.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pnd1ppghh4p.a.out@axis.com>

On Tue, Aug 12, 2025 at 02:13:58PM +0200, Waqar Hameed wrote:
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
> Changes in v2:
> 
> * Split the patch to one seperate patch for each sub-system.
> 
> Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/
> 
>  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index b3dc1afeefd1..38fb81db48c2 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -1016,8 +1016,7 @@ static int enetc4_pf_probe(struct pci_dev *pdev,
>  
>  	err = devm_add_action_or_reset(dev, enetc4_pci_remove, pdev);
>  	if (err)
> -		return dev_err_probe(dev, err,
> -				     "Add enetc4_pci_remove() action failed\n");
> +		return err;

I looked at a couple other drivers that use devm_add_action_or_reset and most
follow the pattern proposed by this change.

Reviewed-by: Joe Damato <joe@dama.to>

