Return-Path: <linux-kernel+bounces-861713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD5BF372A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13FF18C42F1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD3B2E6114;
	Mon, 20 Oct 2025 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="K9nSXTnf"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886D278779
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992065; cv=none; b=feLgb3js9ks0So/5ufyLy7rcEhCzyCabTOoZiWlzWspsswT6QFUMFrRbShFDj4Xkp7FMMwdxwCLv+nhWnfqaUbZFOzfX50+QKNSil2H7pOWV3KDH7ren0F6mXidLvSIah5ap9gY0M/7TTivUcFnAvZ/O8U0YTE6UhzGoAsP1/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992065; c=relaxed/simple;
	bh=23cjeUX/Ppob/MbkB1SPZfdnKjFWFOSdGYzaziChJc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTQdHTcQwqM2IZGSbxmePjuJNK6+/CksNf/EHZ1jj5DBlcx4NGszaiGf0p7SfqYUM7fiLF4yu6lmCJX8sDtDtdqIqZtcgjeRlI7auRYLRjMzXncLf+iQHXYMZW3WIacyhOWEgyXt+jQ0JfWQmglqpexhSRtgD2/2zqLZHgm/RzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K9nSXTnf; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8909f01bd00so531341085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760992063; x=1761596863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZAR9SssPQwBAqxjhFTq7HnrtWlYyCmPDIdAbTnHEWQ=;
        b=K9nSXTnfOe0omCQtf+HmIt05Q6UtZyjG/MMA0o3HOkvzGvpy2lH4bOgorkBYGrhM/S
         4O352RYixEPrc6avh+iIDxfqz6RD1y2CWFTc6LXmzbST7kzxhoUfLWPndKTYyLgZwp+6
         TNtUKwqWIKiNQkoaxtEhHnRT9vmjmqwn8A/K8PCqGC9MBIL4kzsP0bqlT0E4ecuSQkRF
         4kLEDNOWFpdQzAQrvllpJZBTtTrEjyszTV+KqdYIGKPt417jhsDy16lwfeH6qLXS3xs+
         dE1zu9Ki3xsHXL6bDZjZIA49Xr1mx6etohmrvB0co1LLKCDpCwJV1DPx5aXbg8/DrZ09
         FGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760992063; x=1761596863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZAR9SssPQwBAqxjhFTq7HnrtWlYyCmPDIdAbTnHEWQ=;
        b=xSU8HIYHJ1JQX/3auV/BXZOGQmnFMKw2HTbRj7kM9FpCm2YOA+fQXcJ4o5tFC0S3w4
         17x5eEWty/t1zTSbhFQKCfXOj3DcbdoKkVFfO1Jd8+7ZBLTOORv4rKsfpEeQ52BdO3AG
         kYzZ5A0E958F1WQW8n7QHU4502stNsybmJDcLLanJ+ApUriMQFWG3jePYc7TDXAK9LKd
         W2zj9XaSaTNx7dXGDBGF72higWByWe4zKMS1+400nooyYXS1B551HdWeMYsD7k4257Z3
         swEUe6b5pj7Z/2qLn66XNrSgvtqta0ckDWRvC5e+WnjpAOslsRTtsXssjsEavGlAGF9D
         ijSg==
X-Forwarded-Encrypted: i=1; AJvYcCVCnmyxMnGceJlSZ8WQETpFoXwV/LS0Tu5scKFuOGigiiHhwjBfhDeLX7MUIWPqZZ5NSz5egkNJYx5tyJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiSIA8TduJ+jaQk3I66lR5QapjABNixmSyrMoTug4qIBrR+Gib
	kwszY7gsgDEEz5DOgjsEjVd1+YzR7rRTUIbJyeQiMy+Li1g0bvu7dOKjpG87z4q2410=
X-Gm-Gg: ASbGnctWtlZ9+asbt3ibGozvL58vbp50CM3vmpKqu3p07iSecU+lSrzLKbKa9ux3WsZ
	HJAWzLtcb5Q5XCvsZywWQpBvoervT5aRWC3f9oerwDzJjP/IHhCL/nTo/SvS2CRAN1VWgTmqaKx
	I479sKaDPPohXEZxvCZBRAd93tuolmZYtHf6bqYGowlEgm56e1mw43geeXR4OcgWZ5ELgLRUHgb
	mD7GUZ9W47XsvSHrr7gbSObeHATg1gWk0HEv1g61g0T9IP4nU+vflpNnlV3jFpSA0uv/We05rmR
	/ET2bxX6Kv2aYaLXg7lCgi5GxOdH5usu9CcrR0bGS1jRHrt2QASWCM26m+45jqbgNRRhXx4RaTW
	gRtpTjrxqhUwiiCwbR5Ym6nQenL1nOrusgIrUKPwdXKSvzlCBLl93edNon5GLfHaQ/hs1DO3c6g
	6ZRNfAGOOj9iq3W/XaUyotUGtT2zS+mUxSGbXf44c1FL3RM8WzuEyOtbqpRnQ=
X-Google-Smtp-Source: AGHT+IFNSyuzqB2My2z4Xm3I40YNadj+tQNgS0RKzLB/47h6w1YVPgpdgKfsMPIyviG3eSdWQLOPfA==
X-Received: by 2002:a05:622a:d03:b0:4e8:9fac:d6fc with SMTP id d75a77b69052e-4e89face203mr174400271cf.47.1760992062744;
        Mon, 20 Oct 2025 13:27:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba8f0sm621073285a.40.2025.10.20.13.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:27:42 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:27:40 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org
Subject: Re: [RFC PATCH] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
Message-ID: <aPabPH_6FxPgPKM5@gourry-fedora-PF4VCD3F>
References: <20251020170615.1000819-1-gourry@gourry.net>
 <487730c6-423a-4a03-a668-9b9ff92a5cfb@redhat.com>
 <aPZ0OKx_VnQ4H_w1@gourry-fedora-PF4VCD3F>
 <609E7E01-33A6-4931-AC89-1F4B2944FB64@nvidia.com>
 <272c425a-b191-4eef-af6e-2bca1db7a940@redhat.com>
 <aPaQNYsN_YPDOwQG@gourry-fedora-PF4VCD3F>
 <0d92a675-ab24-4b1c-be71-956f09a9e973@redhat.com>
 <aPaUZm0ZfIEW3gUr@gourry-fedora-PF4VCD3F>
 <451b72a3-8052-4dfb-84e7-1e97c3388db0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451b72a3-8052-4dfb-84e7-1e97c3388db0@redhat.com>

On Mon, Oct 20, 2025 at 10:17:42PM +0200, David Hildenbrand wrote:
> Yes, it's completely racy.
> 
> I was primarily concerned about us calling functions that will VM_WARN_ON()
> etc due to the races; not that they would make us accept/jump over a range
> although we shouldn't.
> 
> Of course, regarding the latter, we want to try as good as possible to avoid
> jumping over ranges that we can actually handle.
>

I'll go ahead and add a snapshot_page.

~Gregory

