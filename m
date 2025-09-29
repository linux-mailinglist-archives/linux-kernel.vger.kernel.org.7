Return-Path: <linux-kernel+bounces-836650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2919BAA3AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A27F19238B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6133EC;
	Mon, 29 Sep 2025 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CzrucTx2"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C11B394F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168115; cv=none; b=DM6IihTXOu+FqDhYrO26eg2UubWrCgpsuhVKH/EbLetjHF1gQdIxoimR1pjpk0PUJqJQCW3QVHr1qY1ucK0p6FsIyP7P7PrZ8a1F/an2e9/kVx5ifRyUwFm0gthpda94W8/UMw2/9Z17hnrdFLJ6PsUL5K6kclx7FBf4Lh1id+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168115; c=relaxed/simple;
	bh=OEd6qzox/41lSLCAphd0FtsEhlSfJUwHBBvP4IfW7Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVuprhlsnITqzJMx1uBlZrJHpuPDPanTzUVwgV8g1FO2eyyB/eQBBvZj47qaKxDErA3Ty2P1CHpck+dQ0Q2AyViralojpFjbysg5COm3tZkyI0crMQTnHVu3lIF6Ru/3Xxv890887MadmTzt115VPq6UhWZ6EzlxdQo8kuxyk9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CzrucTx2; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-816ac9f9507so615985985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759168112; x=1759772912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEd6qzox/41lSLCAphd0FtsEhlSfJUwHBBvP4IfW7Sg=;
        b=CzrucTx2AML3apsay/R6zfQRcgeHyoKyJk9oJ4aakLT6HDyyWWDSl2/cIqfjovU+56
         ynisXgpHx6Y4YSRnlB7XGbR8MYOqUxx43+zb77BW5Tq7ybDA0/CxfI+xDte2E9rnqUCZ
         rcOPV4erdHds1RLMLwZXIeFnKCV05no9LlyyMjNmWNDO+5BEkmu+JSlMh2hBtstW14jY
         fy6Vp5OAqQAtrUs8TFwoAyH7wPwbgOhX3ooaIoZPG8pDhO+TR7CzJiZ61dqsCKt8O1/V
         1Q1ls9okiX2QgPmMi2eA7BFRjJYdVsJ2lj9JSdNXAQ3BI2zwm58cZl/jElBqClShl9T4
         YTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759168112; x=1759772912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEd6qzox/41lSLCAphd0FtsEhlSfJUwHBBvP4IfW7Sg=;
        b=P+WXJgKk9OCAA5ENwUG/sPApU8O4LqpGDGGX4ImJW4dwWDkJh4U0+iS5m4JzUADRgg
         /UrmvXAI7obmKWeoEOqnsONQMteA3FXwei2nWgSW0s5jeRQVuZa219I3WvZXT1nME5ie
         oHbo1dmmWcSER7GPGAkTd9tjANfAveW/Q07ia0NPX30UDue2LsulI3Tj7WZDvaMrc0uD
         q9oVU0DIw6RH5fpdcspvBFV+v0V2q6/yLVvkvRlPAzwa5YbYLWIgGANlOFbFPKN26vhn
         UdWgurGxtRTaJlVfvE5fly5LGdd0M50ChRHYxvKLydPGxrYWRvbmn2PsejTZdnxtigVh
         kXaA==
X-Forwarded-Encrypted: i=1; AJvYcCW0yQnlJH8/IrkJnMYi82uQO16NVh7DG+exX41/m5RyuE+joonzcpEG8rtlKc06l2mOXVYchBVxYcNVqws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9bO3thik9j319N3EWetXVXOpnLDn/cI/Wde4tStKSVs6kYgGj
	mVw8xwSvAKy2BCfsvyt5KwTHPbOsfaEzcDKHN+ds2pI4XIdJsX15nSgGxZ7s+W1i3qo=
X-Gm-Gg: ASbGnctmazdGZzDwYSsLVKaKSr0uoBPzeKM0fAm7uc6RWCg0Idh9DMV2dvWIvhedX9+
	jMBx7q43gYTA2q6eVj9mlxgU0DQaqoXoNPDEd2VHZIozUpzyw9mLcvJkgaiSW5ssLyCXa5XC7Z8
	tbNeZO4o5QismQrjsWRcwImN7D8gBLLEDAtc7AvpdmZZTBTts4kCKqSwz6nFdOAjzproGeLFiyN
	XvL4V7FbWSgqv0gDuVkOYhRFIzjX2m+YBBb+Hi9f32WXk1MlNje8ABOndPYMHqZpdjfUKAmqjEV
	aPZ5lWa7EoxTYEYPu7JFzLassJVpPkKsdo7CxYmSyg6YfqhpjPctoTd5It2UCUOsLBPw+BVj
X-Google-Smtp-Source: AGHT+IH7JgDZfuxGKutkR/096no6VIsmYTbq7k+Xr7PvDap1YLRs3fNqi5olsRhXpNbKfmVCs4Vrog==
X-Received: by 2002:a05:620a:191d:b0:7f3:c6ab:e836 with SMTP id af79cd13be357-86eea4aae1cmr207366085a.18.1759168112279;
        Mon, 29 Sep 2025 10:48:32 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c2a1913d5sm860075385a.31.2025.09.29.10.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 10:48:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3HzD-0000000CNlZ-0253;
	Mon, 29 Sep 2025 14:48:31 -0300
Date: Mon, 29 Sep 2025 14:48:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Message-ID: <20250929174831.GJ2695987@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>

On Tue, Sep 16, 2025 at 12:45:11AM -0700, Chris Li wrote:
> After the list of preserved devices is constructed, the PCI subsystem can
> now forward the liveupdate request to the driver.

This also seems completely backwards for how iommufd should be
working. It doesn't want callbacks triggered on prepare, it wants to
drive everything from its own ioctl.

Let's just do one thing at a time please and make this series about
iommufd to match the other luo series for iommufd.

non-iommufd cases can be proposed in their own series.

Jason

