Return-Path: <linux-kernel+bounces-802271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D511B45023
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03261C82B36
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61AB270576;
	Fri,  5 Sep 2025 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LKtWmL/9"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAB9261B64
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058211; cv=none; b=HPeaFU5Ez0UKUNPHZltndaiOfcAK30Bx7xJeKzU3YFRJKE0PbXcq5hfWNfDul9OwF+RLc0XiWt96JxVuceS/9cHXpgv3Gx/BUYip2y0c3/dguzmveBQgB2i8fa0U+EBBS+nU5oQdgpVPRe/0o3SfxJrkEancWeY6W30thD6HZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058211; c=relaxed/simple;
	bh=bsdXiRg5jpsxkzgX7jVctkBK26SfSXlpC0q/1gug0lU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IMnPI9viBSn0H/q9zT0jLZ//bwN98XOkzbOaZt7K2K9obeeDPoaATOqWWrsb7/kQGa86WGZOhd1a4oTcmh9qM3bho7Zz7ggLZYO+wBd6euk3Zb0vk63jzU0/xJ2qkf4HpOCRfRsk1Sif8fJOctoPU3LFjIA/7qb/DuNlcUOzZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LKtWmL/9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b89147cfbso19959755e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757058206; x=1757663006; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mcFCT9zW4aA60fZ7BLnEw73ykCEqS3kxh9SMpfaPMuI=;
        b=LKtWmL/9mZjRiFHkXt/BZ5UmcXFskWcCR7l1+sdCxkNbNl272KwAOAmrQz0qqLGgEI
         bH1Lwp+/ikays8wJ27SYslmwB7owquYaVQrz45GLQhsTO+4tARW5CUbBfNr2fV/zPQ7i
         F07cL2yhHR/65RI2bQkvt1nujiufYigAUKG1QOo5K7wVJO8QX4Ut6OPR/XUYXFa+UONh
         0NOL87fJdbZk0mOu8VtdnBh09MQhyipIRK8tY6kdSPLWlTPGz7b/97ZB5EGAfDJrAPGp
         ePQH7HdmN+QQey6Iw9A0KA054dC/fIhvmpagN0En+x8XL033nY2Zh1l+YNm82JXk3tYP
         LLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757058206; x=1757663006;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcFCT9zW4aA60fZ7BLnEw73ykCEqS3kxh9SMpfaPMuI=;
        b=sQF3Juh9EydxyEuuHbr2ytNLSQX4dwTFGYgg9JprWZDhJZqRaE+g3GSRMdSN4jf5vZ
         KjyiN3K0PkS2DIqaaTyIzDiw0+kN21i078qm/bnSDNri6i8rMWiF9MYbhVY/EhXOzbEe
         sBijwMovd7sZ4qCoAeAf058nE/FB+U7oHoUPAgO20yDFAa2jvlmc1HdV71qaAZNDioyl
         erEH5Fw1U7qlGlnKLBEtmvdj8EykJEPZ+Nd0k6umhu6cIlUitAIfSdaQmRfHCZS62G9Z
         /FTfZsr6j7P0POZzv0PL8Ae45N/RRNGbOtZMRpW/27js7iUjPKi2RtsHKuBf/Ws53Gn7
         70dA==
X-Forwarded-Encrypted: i=1; AJvYcCXxjmtUm+unZPURUEOb8mQX+wJL2OyALIiKHoCb9l+eY8Pmz8+U7OyH4qNdZv00+aFTmTdBPYctUsfE8nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycMczxyv3QQG7e0vSEi5sneexulFzOChu2QVwIFy2veJ2BBbm5
	BIQMxLeTP8mz7lkei4j9QR8pq3gY8001X/BwXW4CEDxSD/EBKDFOk6nFr7gFSicICug=
X-Gm-Gg: ASbGnctBuBIXDikVSN8wujHmzub+BbSu1/zuI5UfGWBbNNG/WPBaRj10fYnGHOslWnV
	sLBq8i7jrQNkfbAwPX0O7/tNqtPJGBfPH15/Tl2f+bRQn+qLTJcfMj9UatWr8C/0rnbgNqmp4JC
	y7/UavDL/OqAzdUYb2dwqUebGOStTu6p/i62cZwXhGOUgrxgbnX4nWyBX4mV4Mv2IeMp4LipLhJ
	mJkZ/Dx/ClSbWXWID1ZIWyTvqgrzziterO5N50h1pObmi+WOqOFTF+VjAQf6tHxur0224EwjVos
	BZ+N4oFeiX77id8Ngj/BEkTAn9DfdFIgm/oOWcZemh7bcgARvoYP5N+tkuqiWBIe/6uD2tuPKIG
	368CDPph0mtQczb24spkeTLdbadv/BLDs
X-Google-Smtp-Source: AGHT+IElpZ/nNxUYJfXoPhKCLi6yxVHIT8+Ii77o8BHY6J90x7XkcR0yo3B1qo8+VJT1qApCcEJbSw==
X-Received: by 2002:a05:6000:2f81:b0:3e0:b982:ca3d with SMTP id ffacd0b85a97d-3e0b982cdd7mr4374615f8f.59.1757058205661;
        Fri, 05 Sep 2025 00:43:25 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:f203:7a74:e497:6da7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e23d29bb9esm3900639f8f.4.2025.09.05.00.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 00:43:25 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Niklas Cassel <cassel@kernel.org>,  Damien Le Moal <dlemoal@kernel.org>,
  Marek Vasut <marek.vasut+renesas@mailbox.org>,
  linux-pci@vger.kernel.org,  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,  Frank Li
 <Frank.Li@nxp.com>,  Kishon Vijay Abraham I <kishon@kernel.org>,
  Manivannan Sadhasivam <mani@kernel.org>,  Wang Jiang
 <jiangwang@kylinos.cn>,  linux-kernel@vger.kernel.org,
  linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for
 fixed BARs
In-Reply-To: <62584e30-72ab-49df-bfaa-9730679b2dbe@mailbox.org> (Marek Vasut's
	message of "Thu, 4 Sep 2025 23:29:15 +0200")
References: <20250904023753.494147-1-marek.vasut+renesas@mailbox.org>
	<b3d5773d-c573-4491-b799-90405a8af6a9@kernel.org>
	<aLmGBYOVevP5hH0X@ryzen>
	<62584e30-72ab-49df-bfaa-9730679b2dbe@mailbox.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 05 Sep 2025 09:43:24 +0200
Message-ID: <1jjz2d4a5f.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 04 Sep 2025 at 23:29, Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 9/4/25 2:28 PM, Niklas Cassel wrote:
>
> Hello Niklas,
>
> [...]
>
>> pci_epf_alloc_space() works like this:
>> If the user requests a BAR size that is smaller than the fixed-size BAR,
>> it will allocate space matching the fixed-size.
>> As in most cases, having a BAR larger than needed by an EPF driver is
>> still acceptable.
>> However, if the user requests a size larger than the fixed-size BAR,
>> as in your case, we will return an error, as we cannot fulfill the
>> user's request.
>> I don't see any alternative other than your/Damien's proposal above.
>> Unfortunately, all EPF drivers would probably need this same change.
>
> It seems that pci-epf-ntb and pci-epf-vntb only use BAR0 (BAR_CONFIG) and
> BAR0+BAR1 (BAR_CONFIG and BAR_DB) , so those should be OK on this
> controller. NVMe EPF also seems to use only BAR0 and it specifically
> handles fixed size BAR. It seems everything that is in the tree so far
> managed to sidestep hitting fixed-size BAR4 problems on this hardware,
> except for the test driver.

As it stands, a vNTB device needs 3 BARs minimum (CFG, DB and MW). The
NTB one may get away with with 2 BARs, with DB and MW sharing one.

If you referring to Renesas about that BAR4, I did use it for vNTB.
It is indeed not upstream ... yet [1]

I think it is possible to have vNTB on 2 BARs with some tweaks, putting
CFG and DB on the same one.

[1]: https://lore.kernel.org/r/20250702-ntb-rcar-support-v3-2-4268d9c85eb7@baylibre.com

-- 
Jerome

