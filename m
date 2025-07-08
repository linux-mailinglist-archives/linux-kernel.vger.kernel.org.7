Return-Path: <linux-kernel+bounces-721699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB796AFCCD3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598CB1882E9B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63C22DECB1;
	Tue,  8 Jul 2025 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="C0by07T8"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0391B635
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983095; cv=none; b=Pw5pzU8cCtRABVvBC3G9/6DjtVqITBEU9VymH/dfHT0lYYfSuXzzZdl4ISIft5sYdvBGu3UvYHPo/acIPbENPuBPGD1J5GqQ1eQSYyVENKaBasmWVbcFPCb31jtqW/YlAjTY4pFkpARjhjXUo3nIVbU9LrIM7Htqcya9G2jYgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983095; c=relaxed/simple;
	bh=6T/LyVDkqfdGqAPt3IJFUu0IpZrh3nknqSqj9wa5YrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxsvB1A+dPUrBBKasTFMepYv6+sbzzwUkDxe8jwcwRY59SMdl56hMAPSIW6bh8gf1FQVG+dvo6BmyFufhoHYvOkmmkWNR+71d4ZPE3/RSCD8RBYFu+T5FmNHM7xRSsMeSdbIXkKbfvj1MCIDUVrDQ97IDMZh0KTQfVut6+ZUPeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=C0by07T8; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df2dbe85d1so39748205ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751983092; x=1752587892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dWG9le0tAvcM6U+B41yLxhv7xdUTFjQ9nxy+a37va4w=;
        b=C0by07T8OHvvHZdbzBQoTC6YmkLqUQvJCS/MD5/q6zVl+/cWv+9+9dAv5euXo8ASGn
         1SvvAQTfBJzvISPitF5UCY180Y5GfxwmWQlXV2iwU6Tkx3ppS3xH0ACcdsonPQucaYGL
         Itu+0fMDrW5P77/YGWuBQe/Q35MlYzAYvaS765TC9FEyU6gNw6ylV+ZhrHTIj9x57+KB
         paQ33Iize/prEc2xuE8W/Ou/dBz/xhd2HrrCoVxT6fxq1cfarISeUa2m6BOESNlTN3eg
         LRY6/L2g6gTx8i2X0ero8fXF1UrYAZ0RlQw8nKeajWitFh/5hZKBy60tb25h1QkXNNh0
         9FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983092; x=1752587892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWG9le0tAvcM6U+B41yLxhv7xdUTFjQ9nxy+a37va4w=;
        b=TZMccyzVAwLvepsdh+KF18QQaX/SNUCvOsTeiU4VpyGDI8gfQpdRMdXySGeBjyzcvW
         T+M1A5CEvzHDCladctxc/BmRocsfznMmWG6FpLE/qZsdnGFQr1Ldj5+ujaqSTvsIe4ag
         3nbtIOrCRrxL8aKTfkbEZYn3dXe5+fSSBlbh3zMuMIV5OC8roLq/H4bXJIL7pC//yH8+
         tQwaFTjq27vkaZLaTd944q4X5mThPXw75FvW5wO5qGR22Cmly/C+aroHLAxsc5yapSKa
         Yi4Zyu0g3E+G3s982/a0/fKUXRqhN8oDBbUAd7uIt//PXNFxlWIQSm3UJydEc2oGnzjb
         abbQ==
X-Gm-Message-State: AOJu0YzpPgkGOjqsyEFlHqhkSVAwz7gobNs0Z+/zLMO8OxDHopCUsw+L
	lLF4N1hUvJiahletNvuSdGYso5SpXScd+ZqAyfIeJjy5fIB+NUSmVCsmARWhxUXY1Gw=
X-Gm-Gg: ASbGncvHqaxYvHOUIvYQvQy8l44WDrLoKOGMPN7J+k/LrP2tY+PubExth6q4LOmAuvQ
	G4uxEgiA6uFktaYZMtFQ5zzLkwzs0Xo+IIFf+GJTmCF/s5eeafcqPCESJDBJbVPpaDJuhbiXF6J
	vnAI1fkKAw1/2EYF996/MyHrQh347x/h4/uFIF5N//E/Uq9sk+KDON9TN5FhjESjAdBlAQGwGRU
	sop1aqka30+dIVJQ0jDJxKOlPPpRikuubCg9dQnEJJuhmri3yW+KuSIlJjc1j3Stniwj0btp+AS
	mpWkIZr+acHS+zJ9d54rpJ1sIb2HMTaIeyIsnI/QfMbkpLeELVHKYuPGlYnZv65Ds2mD7Q==
X-Google-Smtp-Source: AGHT+IG09TilT5nlfG30pj55LKIE+PZrKro1O6jNo5c4L+OMtBt3Rlep/ZPBo61IfrB6cu2JV/LWjg==
X-Received: by 2002:a05:6e02:258c:b0:3da:71c7:5c7f with SMTP id e9e14a558f8ab-3e1371fcf1bmr157473315ab.15.1751983091851;
        Tue, 08 Jul 2025 06:58:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b599a42csm2212527173.14.2025.07.08.06.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:58:11 -0700 (PDT)
Message-ID: <7f6c2bb3-2b90-4d72-b0f3-dba6a347dc68@kernel.dk>
Date: Tue, 8 Jul 2025 07:58:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the block tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250708191115.68613291@canb.auug.org.au>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250708191115.68613291@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 3:11 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/cdrom/index.rst:7: WARNING: toctree contains reference to nonexisting document 'cdrom/packet-writing' [toc.not_readable]
> 
> Introduced by commit
> 
>   1cea5180f2f8 ("block: remove pktcdvd driver")

Thanks, killed now.

-- 
Jens Axboe


