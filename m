Return-Path: <linux-kernel+bounces-812158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D304EB533CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D585F3BD25E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A492322544;
	Thu, 11 Sep 2025 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl6KKGMb"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B571E87B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597438; cv=none; b=t9NvDjk8N93coj9oxidhsC4uN9rxyxcmtWD1KwOdDFsaUZFJ+ed/7v0KsEcSCs2WxfhGC8aZH+Z3+ZR3NG7t5oRX5PWpWv2kF8e2e6EW6R1/QwyQF48js2Orys5mKtyzWqMWr9Tgd/V2a216Tx96auTwbpIfrvyH0EcYhTqXa1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597438; c=relaxed/simple;
	bh=8OuQtt7V8ba3/rLiXSIsouSLa7cHo3GYgs6zin4n8ag=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NscUl/oUW2V3kV80uGdb+MjimIXR+QPLLKU+hKGkoCgIK14CjEuFUpR9uM+ngAyYYeIZ1IVJVK2BnEWdcjB1iYUi+hacUCksgEY2kqrEm8ypg5CkMhIACGAD8k9hxgKvwz1eav2bkJ0YzFnNrd6SUv1qLaALaFSjXj+DWw4/Ogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zl6KKGMb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4dc35711d9so553631a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757597437; x=1758202237; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQlqSojSlf46BQjiH3sjU/ACFvA22QBgGPmMDQkag0Y=;
        b=Zl6KKGMbBSQJ48vrCSrfhLy+j8EJijwzixXO9lZrYWaNSfjzekPxFIu/3s5XqEEFo/
         e4rBFB436TcdfG+o98+Otcs+dyNmAb6IL9UgxQTPVratrBDc0BQG+S7aHHAfkiEFEFWb
         sot2SeLJ/orW2hNsKNfoPlgiwr6QZ5eov4pecqwJfSYzi0+zxTmhmokNRnSU/JoYjoUA
         fJk/hRIM0/ve1yMhVq+SrvNZRAo3vO+oM0GX0CeYMunzAZHf+98fN2AE7J+xPE+yWEVe
         lUPPdaI41hEkgWWIZB/vAoxmbUTiuHNXzkcNrJuUL8mrxRHMwJXPueXxdFG8wH0O6lAz
         znqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597437; x=1758202237;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQlqSojSlf46BQjiH3sjU/ACFvA22QBgGPmMDQkag0Y=;
        b=iroJrcUverRhLEyeFdhaD968YIqLaPtOnZMAnMB9u7Scwd9cjhyFDhG7RmTE9vnVQo
         vhzARkVxzGiLYtE7UYKXWkeWoIdZ12qo5vacEbl/k6/57mASUYBAAXLscIvNTupgVm4w
         dLG4Z0+sk5/ZtsUuvX2zmMlNuMYSqlsj26XqkOT/T1+8uXoNLAo0bP9oA/dX2taQwcU0
         5fEjBv1PKsP9+59hOLWZiOe/SxuoavzNym1nsRutPa/gzlH4wNy7H62pfP4GDU4Nf98w
         fylPzxzNZbv/RsSEYn2UK/we9GZ/Nrg+7FrxDvs2XaNeYgLRLTHQhmVG+5HmcKV9LrKU
         HYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3qNKHvt4XG4s6UpX1vvK+RDL3l1TF8A+pTPw/9WJ526Vzcrg4Fx9pDiyHg+nlmBSUje1eHAJGEpD4syM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ngQF2sDXsTrZkeWRDeWev38cdoBHbKPaFRtSwcd7VDO4tXOl
	0oIzxb1WlUepYnd21Kvl16TLpOMFn0N4vMyNyK7J+bFxwrtgSHiZ+cAv
X-Gm-Gg: ASbGncvgfNLUsFLpBe/WkaFtn4+RCNwlROnBTK1mLvaHt9ZyuKeknIXAnVU944mQAgp
	/w6vy+Y+fUir2SaE4mGegVNg2RXqPeM+nNF1nbjVmDX+SQnv4cTrLYBHpKROQ4YKyMEVskzxdoM
	0+CP3/TqnjJ39ItLZczbGuQR3rPlbA9nsAE3B0c7HNXKvmzXTWge7GxTAPKLepZrYgan2KOcY4v
	KG4nhnvoKQ1ncxa9Fdekn0Cv1gT/ue1GS9YgvfpNTd3cvzz4nLCk+zMpkFBN4LT0fATN1qXd/CP
	1Tm9ZG/evJYC58zTLT+wg4GLwAABiPwQOl7My6ra3QYOPA/GzYkVX60ccnupJsDkBtGXIGtET7k
	MfSVNznJ9m5Di+gJacx8UEnbbX7mmvaaeof4S3lsZX0rn6/H2/CfeI0qpmUMlxixraiJtL9J2iK
	2I5A5iPIzRaaQ7DtwgOeLQBDiLPQtGR5g/0g==
X-Google-Smtp-Source: AGHT+IEvq1Wxj+yFs910EdFrhvXlDsCmNs8TvQolpRuRoaPAKsaZEGIySdytgcl1djatf0VUcxyO9A==
X-Received: by 2002:a17:902:e886:b0:25c:a9a0:ea60 with SMTP id d9443c01a7336-25ca9a0ee09mr9586555ad.42.1757597436331;
        Thu, 11 Sep 2025 06:30:36 -0700 (PDT)
Received: from smtpclient.apple (n058152022194.netvigator.com. [58.152.22.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a772sm19067405ad.70.2025.09.11.06.30.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:30:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] PCI/AER: Fix NULL pointer access by aer_info
From: Vernon Yang <vernon2gm@gmail.com>
In-Reply-To: <20250904182527.67371-1-vernon2gm@gmail.com>
Date: Thu, 11 Sep 2025 21:30:22 +0800
Cc: Vernon Yang <vernon2gm@gmail.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Vernon Yang <yanglincheng@kylinos.cn>
Content-Transfer-Encoding: 7bit
Message-Id: <3CCB9A4F-3DEB-4E68-BF04-7063AC2E9614@gmail.com>
References: <20250904182527.67371-1-vernon2gm@gmail.com>
To: mahesh@linux.ibm.com,
 bhelgaas@google.com,
 oohall@gmail.com
X-Mailer: Apple Mail (2.3826.700.81)

Friendly ping.

> On Sep 5, 2025, at 02:25, Vernon Yang <vernon2gm@gmail.com> wrote:
> 
> From: Vernon Yang <yanglincheng@kylinos.cn>
> 
> The kzalloc(GFP_KERNEL) may return NULL, so all accesses to
> aer_info->xxx will result in kernel panic. Fix it.
> 
> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> ---
> drivers/pci/pcie/aer.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e286c197d716..aeb2534f50dd 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -383,6 +383,10 @@ void pci_aer_init(struct pci_dev *dev)
> return;
> 
> dev->aer_info = kzalloc(sizeof(*dev->aer_info), GFP_KERNEL);
> + if (!dev->aer_info) {
> + dev->aer_cap = 0;
> + return;
> + }
> 
> ratelimit_state_init(&dev->aer_info->correctable_ratelimit,
>     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> -- 
> 2.51.0
> 


