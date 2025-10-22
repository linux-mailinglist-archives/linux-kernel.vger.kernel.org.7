Return-Path: <linux-kernel+bounces-864351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A9FBFA978
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC993AAAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804E2F8BF7;
	Wed, 22 Oct 2025 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pzij3IWx"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759C2F8BF0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118504; cv=none; b=kRDsjg/HwyA8IfMpFjBy63w3c7oP1zBW32+eYux+SzSn39am32rrfHTcoBMssX04geBXJWpHL1Fa38GpWSsUaDt4AM5oB0BACgE6fP43Mm6kZISt7OSxZYbvPGIrSeZH+LlYdFCieQ0SFWdejTPDC5a1KYi0Rbf7aF6+tgMipOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118504; c=relaxed/simple;
	bh=SlcFPlyQIZqcDfdEv0M940luyabCGCNmZmiXFsHVTQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqBmjmUoaB7sbgkKItQUyGuM1PyvfKogefSKHylW51RBww8O9YTgnW7y4uUPy0rEcqOPVCWYqOZe/a1wBNGzNjptPOCqqTdMJY+7GpcGiN51pCziCK23PcSuBNptSq9rvx7RhM3Hs8gkY25AiuFYYf6KDHZ8VVH6RxpGsaTh4e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pzij3IWx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee130237a8so4191427f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761118501; x=1761723301; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uP02OIrJH+GYWmHdxnfvCH1j0VnGSf6v21IKCVsSCEg=;
        b=Pzij3IWxRhA24XBSi9m5gesmByMHLg3V6qiOGxj+mSDogGAWUFiVGlwa4QCVM6zQmz
         SIAsAl6CplGS9mqhr1cYlL6Ztaw3RqRMBPWEIp+yrcCbZjUo4qv6qiBEXwQr/NxkJU/X
         9EHg8BkYNFiBnsQD0/N42a7UCQrBWCLZ90ZX5DYGMI1+lp5s0Ui7+s9R0A+NOT2vBd+/
         Ka4Wmn6u271QlVnISsZSQ9JtbUBEWlH9mh3GQySk77BNnJK7nN0OCKuye/Svxar8blVX
         O+w6sfhw792w+c8oBIyHyJQ3Blm56pW8aXNkMcTkyeFf33VC7za+bjcnqeJsoJVHWkuT
         6LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761118501; x=1761723301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uP02OIrJH+GYWmHdxnfvCH1j0VnGSf6v21IKCVsSCEg=;
        b=nVAMVPOxPdQGt0pCOoLJNg65Hy2lHSYKaFNpI7ZjBZ/KOVkI2X9QjShDor52ExJFl4
         iAwq3fo5WRsULpKVDpQ9T8B3byLJm6E5PD/qTSGtZtA3UjVFatqTLQnD/iq9iTErqpkv
         EwtN23zfVkrK+v6vuNDaQg349jhajy71/LnLATBZbv7DazvGZnZbhCGH87/4kWJzlzok
         eP3sahSM9geIGIbJwxX2FeMOe73qI/99ixuNi9WNVlvVnv2CcshwSnISWUPjdBre+zYV
         yXjbQqX7WpzOMdru/iMYuAFzlCjMbIpEVZXrzWLv4eUHdGwzmS0+SKORtP458dYDPLGB
         +KGA==
X-Forwarded-Encrypted: i=1; AJvYcCUwOzNCFeynNP5ERYV02xi6O+c6A47x2P4jzrLUWyxr0wu2PALiv3B0pNV6tmWuaRbmYCKH4zt6ms5dMko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWgJjFOw09cdX+L5rfxrKFhodky7Hlu0Kk97DJhMG5J4surmR
	Tn3KZdfAmEJSLk+mXdpSX21XVouuDEV2ctjQXrCUusWFjvmbdnnkYRli9ohCclNqFLA=
X-Gm-Gg: ASbGncsTc6bQjcvX68SpJevPzpJ2yrFVoVweFX3QbH676wgsd2gywmJgbPcgETHsfxc
	172bWYhp6785nbbzBlKA9ks0h723WGNqUweETZ5n8TrpRuNqKPMXWTtRV1uLQy91qQgNg4J6mrB
	hR1JWhnuLe/LI+bJZjahS2nj4F/8KwcGhnlu2mi8gkPKvsdxRVWYKabkm48QUmeVqn4UXhbxMm/
	E1tZr4tZBl8TcIFxjFvoXE5OF5v8+UHK1MTme90y17EieQJermgNXbuwccBIrH+yMGQPERHpcqv
	cM91M69lZOmYz72sAhHQ742B50x+WZ6UL/WNd86EBYyWujkQeR6NfumpmkKhUNJ0iaRnFcBqpsp
	0DIgWkBzC2SLrD0dU9R9kOxGN1OHUCroEbidpYaHmZNwvjwO4HFLwaoAXU2QUuuaSQiw6sPNeQp
	Hp1s3sQQE/HAXxG0qP
X-Google-Smtp-Source: AGHT+IH83IpMhv1bnH3yQPXC59KdR/tClyfPU3iIa804OIH9TrWa56iWXz5kfq2XOFx8/cvVKF4gdA==
X-Received: by 2002:a05:6000:220c:b0:3de:b99d:d43 with SMTP id ffacd0b85a97d-42704da613emr12551093f8f.19.1761118500607;
        Wed, 22 Oct 2025 00:35:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5b3d4csm23271367f8f.19.2025.10.22.00.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:35:00 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:34:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: liubaolin <liubaolin12138@163.com>, anna@kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] NFS: Fix possible NULL pointer dereference in
 nfs_inode_remove_request()
Message-ID: <aPiJIBTsQit5jyUg@stanley.mountain>
References: <20251012083957.532330-1-liubaolin12138@163.com>
 <5f1eb044728420769c5482ea95240717c0748f46.camel@kernel.org>
 <9243fe19-8e38-43e4-8ea4-077fa4512395@163.com>
 <a0accbb0e4ea7ad101dcaecf6ded576fc0c43a56.camel@kernel.org>
 <b928fe1b-77ba-4189-8f75-56106e9fac19@163.com>
 <ee0bb5eec4b43328749735150c5505f02e7a1842.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee0bb5eec4b43328749735150c5505f02e7a1842.camel@kernel.org>

On Tue, Oct 21, 2025 at 11:15:21PM -0400, Trond Myklebust wrote:
> On Wed, 2025-10-22 at 10:44 +0800, liubaolin wrote:
> > > Sorry, I didn’t actually see any case where req->wb_head == NULL. 
> > > I found this through a smatch warning that pointed out a potential
> > > null pointer dereference. 
> > > Instead of removing the NULL folio check, I prefer to keep it to
> > > prevent this potential issue. Checking pointer validity before use
> > > is a good practice. 
> > > From a maintenance perspective, we can’t rule out the possibility
> > > that future changes might introduce a req->wb_head == NULL case, so
> > > I suggest keeping the NULL folio check.
> > 
> 
> I think you need to look at how smatch works in these situations. It is
> not looking at the call chain, but is rather looking at how the
> function is structured.
> Specifically, as I understand it, smatch looks at whether a test for a
> NULL pointer exists, and whether it is placed before or after the
> pointer is dereferenced. So it has nothing to say about whether the
> check is needed; all it says is that *if* the check is needed, then it
> should be placed differently.
> Dan Carpenter, please correct me if my information above is outdated...

Yes.  That's the gist of it.

However Smatch can tell that the check is not needed then the warning
won't be printed.  In this case, Smatch breaks the return values from
nfs_page_to_folio() down like this, and it thinks folio can be NULL.

fs/nfs/write.c | nfs_page_to_folio | 340 |      0-u64max|        INTERNAL | -1 |                  175 | struct folio*(*)(struct nfs_page*) |
fs/nfs/write.c | nfs_page_to_folio | 340 |      0-u64max|     PARAM_LIMIT |  0 |                    $ |         4096-ptr_max |
fs/nfs/write.c | nfs_page_to_folio | 340 |      0-u64max|   PARAM_COMPARE | -1 |                    $ |      == $0->wb_folio |
fs/nfs/write.c | nfs_page_to_folio | 340 |      0-u64max|        STMT_CNT | -1 |                      |                   22 |
fs/nfs/write.c | nfs_page_to_folio | 341 |  4096-ptr_max|        INTERNAL | -1 |                  175 | struct folio*(*)(struct nfs_page*) |
fs/nfs/write.c | nfs_page_to_folio | 341 |  4096-ptr_max|     PARAM_LIMIT |  0 |                    $ |         4096-ptr_max |
fs/nfs/write.c | nfs_page_to_folio | 341 |  4096-ptr_max|     PARAM_LIMIT |  0 |          $->wb_folio |         4096-ptr_max |
fs/nfs/write.c | nfs_page_to_folio | 341 |  4096-ptr_max|   PARAM_COMPARE | -1 |                    $ |      == $0->wb_folio |
fs/nfs/write.c | nfs_page_to_folio | 341 |  4096-ptr_max|        STMT_CNT | -1 |                      |                   22 |
fs/nfs/write.c | nfs_page_to_folio | 342 |             0|        INTERNAL | -1 |                  176 | struct folio*(*)(struct nfs_page*) |
fs/nfs/write.c | nfs_page_to_folio | 342 |             0|     PARAM_LIMIT |  0 |                    $ |         4096-ptr_max |
fs/nfs/write.c | nfs_page_to_folio | 342 |             0|        STMT_CNT | -1 |                      |                   22 |

But Smatch is taking short cuts in its analysis and it doesn't track
bit tests so it's going to be wrong sometimes.

> 
> So in this case, since we've never seen a case where the NULL check is
> violated, and an analysis of the call chain doesn't show up any
> (remaining) cases where that NULL pointer test is needed, my
> recommendation is that we just remove the test going forward.

Removing the check is probably the correct response to these warnings
more often than not.

regards,
dan carpenter


