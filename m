Return-Path: <linux-kernel+bounces-738364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A1DB0B786
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062841893BC1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EBA1A08A3;
	Sun, 20 Jul 2025 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xBH2ZkKe"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB75198E9B
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753034614; cv=none; b=eoykyQhjqBw2/iA3LMk7md43/HB4IOxjdY2HtxdDCJGJLJN685OMN+eGgXdh1nYz/5kOJSN+iPVRV/0fFgi/W8sxVlWUzKtPb2g/beEfVwJ1u00PGbzxQaYcGWb6mvXfmq0t9k+hOUqJtVr6wd0hfFV2zbREeFUdvApxXd2+sYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753034614; c=relaxed/simple;
	bh=bhtDgzKsiFjwXyxsdZ/4h48cFPpB3WRr/3arOlv70uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngeG+6gUeqCUWpnUn6AT5mNRvSN0PAUDJnMsXNxVl/zWtrtX3s3bbL0/ZMN4NgPb3hqXK+5xjebarE8gWeoSENI7ZmEbqJc+IkvdOL5KzUzEiNmtEJWTPnZpATB8fNgGJ1jJ/t48QtQYx6UUUooj/QdqTqlu5yjWlWIpNFEfoC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xBH2ZkKe; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-615b9e70b18so1241156eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753034611; x=1753639411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r1fiTpYldSHzYxGLzWC3f8B8z2BwRBsV2K6tEBNsuDs=;
        b=xBH2ZkKe6vZ2SWaBOq16rKNtLXvDe+1ddpP1IF5w2qw/f6fVdPIfnfjrG2rfHkT73/
         O2U/hk+BcXh/p88yINlMSSyAHuzyuVR7exeE7aTPM6Jkl1u1uWasiA6DzLLy5TQtT1Vw
         DlvSH49dPcQmsvSF/MDhf79oNU+lG9GmCUQ9I62QUExzviuTa2SO9qbPxSXjQXpLw84i
         IuT/Ch1poQkzE3rG2r6ZaCNhnANV2AVCCauM+kdyyR0n1OSR10kYlbVj1Om7+W8R3LMd
         tQmBXicF781wCjTHXBqBNQ36i3kEc6KmwCwQGiQAhAX9YJcQSjM9C7Qbw+1vr0SyfIh5
         T+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753034611; x=1753639411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1fiTpYldSHzYxGLzWC3f8B8z2BwRBsV2K6tEBNsuDs=;
        b=Yqcvy8WLEQ49FEQN3ApI5q8LabvFDAkf4CMGVsDlqILzy/f70d+vPE37akCwGi4oca
         s4/d10920eNiDpCe9FqzhOGf0wofV1UIAvgSLcK1a9UA00DtAAD9neXMmd9q9sHQakDI
         kmICu6ln2IHdysnx3pMnYzz6o35e4EzJQyGZsFeb2IaSXv4dI4e4MrWEHF2LxzqyjBQV
         H3gQT9g7iYkIRAHKVdiIkjhowmUneJoikG+1FIMEvhQ63lsLdY5PSLMby6z9d8nZLTZi
         LcxxQY6m10H3wgB/UgO58EJasm/YKI5ahs203gMabojOa0y78i4eZDABrCm80kgxHIls
         k5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVs4wVAx7+GTFa9AovJGVNh9CqDf9XXWjhKWYfdurM9fxD+r7TYHpRbw/HGlxYyQmh3lmQ7AL4VQ1Axo44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTepWLoLEBDAFpOvIoIjcsOoX7AQwIAJKJ48jDCkDjKpWUuRtO
	H88aWpi/dbIcqVZlGtKj7tbgpBEAf8SumzMoRRsfOIAr1cYYXXTSmEAP/iBe8GqxWSM=
X-Gm-Gg: ASbGnctO2ISHt0R4oRs+B2qw9RRGrybiV8KnU3m0sxQixRcq+Dz8lGsPHPoNvlwpq9G
	eGU0gkJT0fE9c9Nm3SBEoPpXGhwpuqjdcv2UhEgaQFbg3Thg3XPWU9NrWSXR34MnNRtcG44sjPM
	gONKtSiLBOQAx4jRP8CSLPO7b2nXjJYlO/FQnGFurlqinV7lesQr9GS0PUi2pzLHmfPDj1TNKi0
	IA8pvOW3DNk9xxO1ZuhjqIdQ8PzOaxjrFNAUA+9ofG7Gfyxyzw+LX0vcJ80q6RnS4wXS8WE6CPd
	bHejQBYETgj/AfJm+3Pr1s3+PF7Hpz8K/izXQxhGJLuUliiXHne/3oBBNZJxfioOT1kqEm6AFnB
	m8OLNx6JAYy0=
X-Google-Smtp-Source: AGHT+IHtyPmRdW+ZxMT8HYDvH7uiKoz3hDXI6p99r4O9UHXEQkAF6dlxkNSdIENOt/+CmTUNtnlwhQ==
X-Received: by 2002:a05:6820:1e84:b0:615:c779:eaad with SMTP id 006d021491bc7-615c77a0d18mr5159784eaf.7.1753034611515;
        Sun, 20 Jul 2025 11:03:31 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e8369d595sm2250474a34.25.2025.07.20.11.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 11:03:30 -0700 (PDT)
Date: Sun, 20 Jul 2025 21:03:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: linux-staging@lists.linux.dev, marvin24@gmx.de,
	gregkh@linuxfoundation.org, ac100@lists.launchpad.net,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: nvec: Fix incorrect null termination of battery
 manufacturer
Message-ID: <45476946-f717-49f5-8d21-34ea146bd624@suswa.mountain>
References: <20250719080755.3954373-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719080755.3954373-1-alok.a.tiwari@oracle.com>

On Sat, Jul 19, 2025 at 01:07:42AM -0700, Alok Tiwari wrote:
> The battery manufacturer string was incorrectly null terminated using
> bat_model instead of bat_manu. This could result in an unintended
> write to the wrong field and potentially incorrect behavior.
> 
> fixe the issue by correctly null terminating the bat_manu string.
> 
> Fixes: 32890b983086 ("Staging: initial version of the nvec driver")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---

Nice.  How did you find this copy and paste bug?  I guess we could write
a static checker rule that if you do a copy followed by setting a NUL
terminator, they have to be the same string buffer.

KTODO: detect copy and paste bugs setting the NUL terminator

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan capenter


