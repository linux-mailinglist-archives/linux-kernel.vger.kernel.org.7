Return-Path: <linux-kernel+bounces-821114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3D2B80769
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15675816A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E948C335950;
	Wed, 17 Sep 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EtVD1/Gh"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1528032E741
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122178; cv=none; b=dkeAW0VWJa7p/XoeYjqiwsQTKUU4+J9s1fXWU5nf+nj24MTkLfClB/vtze8OVzER8Cn6oTpYlYqi/WTaE7Z3vnY066KG5UZHzZo3fANJ++jc2JC6gLOk/DJltfAp8SAYWADziBsZpbEIuXiek3/xTM/U+NVoOrsIhY4cVKPCidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122178; c=relaxed/simple;
	bh=vr6s4p5RDrOlpzEnsFxEhXbnKDJ/Ny2Q/csoaU7WttE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHmGCaDPvWHjac9DFnfSTb/krksZWZwMrs27vWJynTqP3E3wlj870WpKFwIVmcNbCc3ytoVe7wfL+VuRtA3keLS8bFi4nkdHql3x3Z2pRJUh3/FqK19MD1bnVtnKxTwvmRo2apcorolP87OhvKvGUDPrQ7C0Y6DgsdLgthAcgyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EtVD1/Gh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32e64d54508so3574581a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758122174; x=1758726974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5mwCMXZll74MsKobdLnh2paEF22CAKr4juHWA93w7A=;
        b=EtVD1/GhcFT6sbBQmBFmeZL0Ey1kZ7kMalu8h7bV76QBRcuqLgp89o53d9GMibaFcv
         kmKCZU2YedvuLdruws1ghEBbPPzvrG5bimwZbjgnU2nr6jif/QPfGr5VGmwOzS5SICgp
         xU++hc9OHgZ/yTP5wJKeOrZIztk+4ck5XtnuRNATkZcBzSoFfj4BsRuFBnLlGjlCUtbv
         YopncFXRBExfiXWy/g9Y5pMdgpL1xjvRZBNijqIF8wByHQNRRO+WZUeWQuPb/SH3UCZ/
         +mzJXc5SevvLl4N97HirohlvUOvW76C9fYyfwJS9IQxPkqA6ul/7ZnlomtQyDp4dLJjn
         gq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122174; x=1758726974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5mwCMXZll74MsKobdLnh2paEF22CAKr4juHWA93w7A=;
        b=mwxd+A0sCwjS5yYGB4FYbZYc1nKm3tGkI7vuYs57Byeui5NxsTbxxO432i8X92x7Bv
         9jP6oNFSCijzGeyHfIV7BGNSaIAt8JoC/KpjrI+StDGofChJkZclX5/n4V3u5cIqBY6a
         L0FafzD74WSTTiqz2Ey2g4dEzoHlrkYgppH+B0nJgBIXfqn98NvlEPTrwuFsr3QaDc/Q
         vPjEKq8macNS5unqk8naAdVuY6XIH3gzNrrxuVsXAFe2ohvj8kMTNwMpZjw30R1tBjPW
         k2KJxKVG8qvgM7ZVvQ9yE0naGp/AC4sL/JwE17qSkbVH/qlSPJapYVawotDnlqKM4ZRD
         nciA==
X-Forwarded-Encrypted: i=1; AJvYcCWDb+LsIUxVaoe2b5FyKHR2pk3w8Irb94Sa1lSBu4xcAqyC1PHCTf7BbG0RREvjvSkO7mWa9u8QqxbNphk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Tc51zWnqBdeuctmxJuAHaWoGHzfexFEkv7rjuyE5LTQWyEBH
	vm1psN3X1wY7YJ8Po71Ep5R1GvNzaPcfSG1nQy1gzSQ3rZ7tlvu/veR4AFB6BIz5wxY=
X-Gm-Gg: ASbGncv2LF0NyChYrHCVlg/ugkYhiofJs36jo5bohPNbYTUdlZ3/nu7IynE0kc8rU6O
	sbh0Lh84Zk/BH6gObnMI3mWbfzqA7hIiECNrBDwRXGypYm63hkmq2haE84Y1Cl9MFb02qQ2y4Th
	B3HpFclcpvC50OpAZrIT0KxmR4zqjfuTlwJgPBKL7dxVhVkG5yF9t+uuZVdzWJbT3uVltOaFA7L
	48kLYHGw7QbJpCjAfrCZio5e+BpG+Cd8EOuez/fXnejXj4NRZmvc/kvwceCdiIs4a6gF5DnFqnO
	VeYlx25vD8L9p1a/2NKJ6RLaKMbiqDC3JTRY+dPEc94dYgggG/Fy8F79xYRRWmGC6Nc8aHFc
X-Google-Smtp-Source: AGHT+IFT1177fnGaDPrsJvXBzm9YkFBr+A6b67xfQf6j5GBKuYGPXR9WdIUZ96yP+o/Tmx5sDbBqfQ==
X-Received: by 2002:a17:90a:d44b:b0:330:3fb8:3884 with SMTP id 98e67ed59e1d1-3303fb83a3dmr2234532a91.16.1758122173999;
        Wed, 17 Sep 2025 08:16:13 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff1a22fdsm28695a12.0.2025.09.17.08.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:16:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyttE-00000008NhG-2B33;
	Wed, 17 Sep 2025 12:16:12 -0300
Date: Wed, 17 Sep 2025 12:16:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 22/28] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
Message-ID: <20250917151612.GH1326709@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-23-smostafa@google.com>
 <aMQroI4NDu74PDGT@willie-the-truck>
 <20250915163858.GK882933@ziepe.ca>
 <aMl_5j8G3IGulAC6@google.com>
 <20250917123601.GA1326709@ziepe.ca>
 <aMrNTny9jgZJd_Ef@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMrNTny9jgZJd_Ef@willie-the-truck>

On Wed, Sep 17, 2025 at 04:01:34PM +0100, Will Deacon wrote:
> On Wed, Sep 17, 2025 at 09:36:01AM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 16, 2025 at 03:19:02PM +0000, Mostafa Saleh wrote:
> > 
> > > I think the fix for the problem Will mentioned is to just use CMOs
> > > before accessing the host structures, so that should be simple.
> > > If it turns to be more complicated, I am happy to drop the support
> > > for non-coherent devices from this series and we can add it later.
> > 
> > I feel like it is easier/better to fix the driver to use cachable
> > memory than to add CMOs to the pkvm side..
> 
> Hmm, but for non-coherent SMMU hardware (which sadly exists in
> production), I don't think there's a way for firmware to tell the driver
> that it needs to issue CMOs for the page-tables and the CDs but not the
> other in-memory data structures (e.g. STEs). I suppose we could do it in
> some pKVM-specific way, but then that's not really helping anybody else.

Not sure I understand?

I mean to issue CMOs in the smmu driver consistently for everthing,
page table, CD entry, STE, etc. Today it only does it for page table.

Make the driver consistently use cachable memory for everything
instead of having two different ways to deal with incoherent HW.

Jason

