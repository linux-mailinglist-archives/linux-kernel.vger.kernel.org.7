Return-Path: <linux-kernel+bounces-822970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC71FB85348
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FC2563338
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF8A21255A;
	Thu, 18 Sep 2025 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Jv5JSEvt"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7794E30CB2C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204668; cv=none; b=b1VKZLte0GwtOLTPrOnzwTgJD88Vq+r2EMEzui4olhbU5NJAfflYUR2dQ3e+3Bp1cZ9Ec0UhX/3SzS7EQa24vw2kBsU3Dk9jf+FMmz8CwxeAuhUrMTl48G5wFT6S1p37AQZdgpu1z0YkB/ikxbScAB05F0773X0pHQKRZUUPBHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204668; c=relaxed/simple;
	bh=x7jb8JfGQsSR4XtTJ8eBWd6uBi74hSXtB25C9NcBMXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3U0XpvqOg29YkRkUbeprFq3Nny7NGUQqXVpFLkxVvMEgcXjMUr/zU45QcX7WpcNVE3xlPamk9P9VS++nRDkyHPlRO2LFQ6OTXJXtisVRLx93ZoxWHf8VqdkBDYkYG9UhKOnr5QmrfmwHJcGg1WCxAwxT+hnbRL6U4GtMDODrRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Jv5JSEvt; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-812bc4ff723so113117085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758204664; x=1758809464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7jb8JfGQsSR4XtTJ8eBWd6uBi74hSXtB25C9NcBMXU=;
        b=Jv5JSEvt90Fa9tbW7z3hoHOvmlNlKEagQOh6WrcP01HKdI0sZIqM7xCK5+8ZnqbRMD
         fAzcx9rQ+TbZ8zunCIkVM8BqI9D97/uKbeWaMzMpM3+ziHP69ifZzRPsj4iuUBg7FkFh
         ze1I+tVXnLL4I55H5+Yjz8nzSGGS3LFrYI2RtKxnJ0glqLk8cLGwYN80fdqtNI6ZDk1o
         8cwZnd1IjEV+ffSwf7mzQ1S+/ozk4yIz3/zo8TXZKrymfxHAcsr5xrah24eO4mcVNeNc
         Jf6YKv3WS4K0UdFj+UnbL6WOsqayPzmLbQHSpdqdprdFyxEHnjpc6bKaFSocruMTkSTa
         7rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204664; x=1758809464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7jb8JfGQsSR4XtTJ8eBWd6uBi74hSXtB25C9NcBMXU=;
        b=qevqXnHdiybEssdijuaOuBKmGzSIXQcqc8GR3CCUPMQV871Cnhkyf99s72iTohPjB1
         c9nQl9KfJkJKoNZcLe2OAl+FdSTT7rPujOJGby9hdS2ycMB9j38GEd/CeDI+ThNd+JAR
         7YUMA1j6w+zaPWn09H/aL5gLDDbde1q6gWJSILXr2EkST65WlwbMo1orYQqtF1hX+/BW
         LH5gZVswLFGYh2GTWrh5OATSrxF3+hrzFRVo/H7+1jCrZgITohYUh4hYsCUNJRu8N1/P
         DFYS2PO9WKveX9yIfesptE67AlUI3K07qoOW8pfn1QdkhTYicTnRQPow8DarUdUiFYBk
         Jv3w==
X-Forwarded-Encrypted: i=1; AJvYcCVxSSrwtpyPnSk6iAFo+SkPGpyWX0ZpodiJjYJi+XSZvsiVfwr6SqXNaSVqozbzK/AH1X3ZRlcjvk9grRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG05C6VVu6lRGTsaPvq6bz46xEQsTAk4Y8XSXEIOm6PgIu5Eb0
	lrYfoK5gohT3N8ZINhL1lw6prnPPK3ApKhq3GgR/0g412JMeOqe0q0MkjOTgoC3+muo=
X-Gm-Gg: ASbGncuv8rB3/c3EDYF95WHtbujLmr2tZi/7Hb+V9UP0UGVJbrA/q7mSH3zoaKHLbAC
	wx2velNstkZ/FwwMRlkKXpi5SF5hae6P5tBdsLFl9eCKvdKSNH59bNruuX4XqFucg7aBsyHvRL1
	rnoscpVL1bh9D2oINEdMwi0ImbtJetwTLF4QyQimVrBTp0zrLUXAP/MTsLioriqs35si5h9c6P7
	lfxDkm8HCsH/uEvn/8u4gChsfMcT87TbjOWqV5H9kam45NRPhT3pJs14+cdzc0cf9SFaU5fTFe7
	ZQVBg6NItna4Qe6Z7TwniOoKcyNMG+XiEhNQ3NkZmYZzxCHmjpHnxy+Coq7u90aBIfMvstWeh0K
	S85jL5oDDWkF1I2HvTU01zYzVG0uJ3+BL1PujxoGvsiFxs/6vqNtdIhAfBxWqH+miqpxh39dKKi
	Bb60YkrULKZgQ=
X-Google-Smtp-Source: AGHT+IFcG0Z3ZK5/PQ6vJav0eqkeBfwJrYJnuhkwdniJkW36no16Dw8WiAtdmBAplhwPvdJpSRD8qA==
X-Received: by 2002:a05:620a:462c:b0:812:be4:670e with SMTP id af79cd13be357-831109114e7mr656127185a.43.1758204663628;
        Thu, 18 Sep 2025 07:11:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83627d7dd01sm169419185a.27.2025.09.18.07.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:11:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzFLi-00000008vyr-1Vsu;
	Thu, 18 Sep 2025 11:11:02 -0300
Date: Thu, 18 Sep 2025 11:11:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Fix ACS enablement for Root Ports in DT
 platforms
Message-ID: <20250918141102.GO1326709@ziepe.ca>
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>

On Wed, Sep 10, 2025 at 11:09:19PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> This issue was already found and addressed with a quirk for a different device
> from Microsemi with 'commit, aa667c6408d2 ("PCI: Workaround IDT switch ACS
> Source Validation erratum")'. Apparently, this issue seems to be documented in
> the erratum #36 of IDT 89H32H8G3-YC, which is not publicly available.

This is a pretty broken device! I'm not sure this fix is good enough
though.

For instance if you reset a downstream device it should loose its RID
and then the config cycles waiting for reset to complete will trigger SV
and reset will fail?

Maybe a better answer is to say these switches don't support SV and
prevent the kernel from enabling it in the first place?

Jason

