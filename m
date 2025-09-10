Return-Path: <linux-kernel+bounces-810347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5508EB51916
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D313B50F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAAA321441;
	Wed, 10 Sep 2025 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="knSK7WZn"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B722FE10
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513751; cv=none; b=D81rbAudaUjGRu1mMDUlh8ykAOHPyPANWVVXAGlIe7DHgZQ/L1gT+3Q9s942nBI17D0BnQBTbQt1Ey1/TooFwcG0xjUMshTfGNB/CHfT214vHxh3Kbn3Nq1+UyxiBzRi2OMTPkkclDqP+00C/KLfQembbZBB5teKjhUca+gKaBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513751; c=relaxed/simple;
	bh=ESKXExJLIuE1yoebiA/ue+cSaONVpwchtGyuhY5cYRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ6IwSz4PWqOAW4oru9kp/EImLz1YzYWxKIYsA9xvOlDw+pvZt6lxAIFNCJ8aKRPw0iH2jFS2DKtlxzeyhOY/aSJ/yIx9ZgerrSwI9F+A99jK8MNRt4f8HVMYMLELdsFTaD1o13jekbCkx0sHHtBmq9MmKe5hAeJFsG4pZDEM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=knSK7WZn; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8173e8effa1so233409885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757513749; x=1758118549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESKXExJLIuE1yoebiA/ue+cSaONVpwchtGyuhY5cYRs=;
        b=knSK7WZnmqHUrPB7ZCpI/uk0TsUTwchK2mr6AVnfUaCYq/G7iNXb3u15cmZsIl6nPl
         bqS988Y6j+Hl5W1BKi3DIxjFX6D++sfNwbxhd0rbPQ3s8uW+NzDD+biQzTH+lp0R5f68
         d7wCDvoRMWkEYtxSYL1PQ54jO4OOK6oZ0WykCVo7bftFFTF1mzM/KSLeDs8t9+YXb81L
         Qzpe7MsWxxrVyvOfF5rShd21rAvpSCsx4wCPp0q+swtPyIbjyMGSbNDN4hG8BW/Oydmf
         sbCUw8BO3r8w3DvSNzAubz4XXZEIXcNwhFLeGAO/1FxFgLCTHX07kPxP/yHrSoaJ3JM6
         oNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513749; x=1758118549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESKXExJLIuE1yoebiA/ue+cSaONVpwchtGyuhY5cYRs=;
        b=wuX7vmWVZa3ACy6jhl2c+n+WKOYHL+o4DMRjgHFTDjk751VfEu6a7oqDX1hayd86Su
         quZaldp1pXHjnc96eVMRj5iExDpd9/VF46wkM5RvbZLi77VVf29gEqrIPUtX42ND6rKU
         HUut2wRStBniEUjDTdUjQECqfCpk7oLDBHHTJ5UEtlN79uGg17JwysbQFvMdAwKyRabK
         WjtZr67FBOowGM6sgiGQ4AiXWJFFXJBdrqpYMkdf+JnLI1W+foY2raoRWpZZfOUpfOE7
         loEkApoQuttr+cJXxLbNKQ1b7K3oStJnld7abYUmwKlH7ukHbzXDq98vzkQdEq+n3XAe
         n91w==
X-Forwarded-Encrypted: i=1; AJvYcCWKW8ZkVcvxtN73/kuYQEfERskMO69R174voq/Wrh9SQB980NYEEv7zi6C9dPuSbIJbEI9igltHYLcudWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf6UPB75SdnnxHwfwspwr8z2GBTYGP1uL1Wl703Ue0agSdqeSR
	RvRymisOduSP0Jy6igYMOOM5CwLv42ykmy5oEm3HU6DA6/l8njKowFZmWn4IpNe96LM=
X-Gm-Gg: ASbGncunz6Dm2JsHTqLNpkz5/85eYlsU5PJLOxPgwE90ZYFq/uPhQVjOMPcHbytCoYk
	S/kruS2uxD6L01RntD/ZMyf4HtTl3KH/7hPF4ZnfvXqCnGHdlhqA+pWM27SFAkETg/6iet5WbPI
	tmvTlkLfVSJ875VpoAzqvVtHGO3SUb6N0ailCLe3DihE4/mfJG0ifIyyjszKPVowhYf4ZqNPEKf
	4KibALrzO99LuK/fWQR6Wo95wcuWr/b6A8lSN9PQsfFLrMI9yZNB77fyAbfW0OspZl+MKsIUlW+
	jimJcv0PyJoYri9uFHzSeion6VPXzMJ0N+YnYsX4Z26s5LJAwSKbqxorAFb/wcvzIWEne93f0vY
	Tx3zQShCQ/8fnojxDyaT5OzcroV71Jwj3uhGiydgXcIWeKiLTwLwnmTQUDO5npNfD/3HCxnvLBy
	9g5SgmRENZU7mENQ==
X-Google-Smtp-Source: AGHT+IFfyhIETCUrm58is+DJKy2K1cA7/NQr1D0/v2K3gk+WAtxi+xyNq/8bDediao12ZQz9GzGhAQ==
X-Received: by 2002:a05:620a:4515:b0:818:2b52:2315 with SMTP id af79cd13be357-8182b522920mr1251451085a.49.1757513748711;
        Wed, 10 Sep 2025 07:15:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5a359305sm292432785a.31.2025.09.10.07.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:15:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uwLbv-00000003rnA-0eIs;
	Wed, 10 Sep 2025 11:15:47 -0300
Date: Wed, 10 Sep 2025 11:15:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	yangyicong@huawei.com, wangzhou1@hisilicon.com,
	prime.zeng@hisilicon.com, xuwei5@huawei.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 0/2] iommu: Add io_ptdump debug interface for iommu
Message-ID: <20250910141547.GD882933@ziepe.ca>
References: <20250814093005.2040511-1-xiaqinxin@huawei.com>
 <20250902161028.GC184112@ziepe.ca>
 <f2720f17-5e81-4f69-aaf5-791b47973178@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2720f17-5e81-4f69-aaf5-791b47973178@huawei.com>

On Wed, Sep 10, 2025 at 11:20:08AM +0800, Qinxin Xia wrote:
> Ok, I see, my colleague Wang Zhou also released a version of io_ptdump
> a long time ago, which is implemented in smmu debugfs. Will recommends that
> io_ptdump be implemented in a way similar to CPU page table dump. Using
> debugfs to expose the data and using format-specific callbacks to implement
> specific data dumps, I'll talk to him about this as well.

I feel we should have a iommu subsystem debugfs and per-iommu_domain
directories to dump the page tables.

The smmu debugfs can report what iommu_domains each STE/CD is
referencing.

This also needs RCU freeing of page table levels as a locking
strategy.

Jason


