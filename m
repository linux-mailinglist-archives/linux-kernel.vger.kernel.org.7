Return-Path: <linux-kernel+bounces-830693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B115CB9A507
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E648F7A2223
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B263093BF;
	Wed, 24 Sep 2025 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOo+Gpt/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B9CA4E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725023; cv=none; b=mgccoKMGuOkIqywZiOXzhg9D8jT5Wv6Y0Qh15WCBtstnaPbtLC3teptnnNe8zBw+MRR4lJhpufuSimdRrnd3DIx8uFYWS0Djim5AkaHMrBWQxKvei+Yafx5YunHKUGJSojGRR/KUDqhhgJc5xw52ruvtjC3Ze6kfZE8d29zfJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725023; c=relaxed/simple;
	bh=9DMfrgjN4rnqyaeNGDI+SNpIuhRxBA9gdwSamu1Ca1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBkaXmdoVLJiQj5NlD+lqq7c0k1pjVCTBBzp1eZ/HbFbQVYO2JdS906GkJWagHprQmDw/0B9znK26IDsUDuJRWy0J+Qn9ZgNeV4hZiFQ+BkLFY0UvacsP75vknSl6v0D7kcQvMPo5LBDNqNExtub1EcgyFDlDhE2DRf/WNNLU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOo+Gpt/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2680cf68265so51456635ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758725021; x=1759329821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoQIwHnAedYHW2ZwTiTqd0HfpwsJi7a/PfALZCLVmnI=;
        b=KOo+Gpt/Ro6bOAO5JM8VRHLhBTB6kJBuhy2kYGwwoM/gHsTBdte2+MUIbHj2tv0YuT
         Ym0TpHtBS1oWaRO8Xho5sPTQsiSQS/vB851JPOlJ4uNbjxEXkSDTTuxnD5mumDsw3gHS
         s0tdmjy/z/G8zQBvTKkGUUhvK1pZ8l7WNq2gAYNPMfhtvd/bep23wc9vF6T2aJ2+EgNg
         iezq3un2hgZibhc0RDbmM8WZE6rO5jCLdsWUed2K745I3IfAnInp0qAr9wY45wQ6QXiF
         FDs2kgLdOP97Cy8bkM6Owem1Z+tqSWxsm2FRKw2jI06lrhcCNUQU4QmrEQoyk5C800VJ
         9FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725021; x=1759329821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoQIwHnAedYHW2ZwTiTqd0HfpwsJi7a/PfALZCLVmnI=;
        b=m1ufnVugH0Pz8LNF+6JeG2iODHiE9A+tGcr4rSY3VtaIgq3im0DHM+IoajsvAAJhXw
         ukoxg3AqA2nCh/LdMePMADNr7O6bxg2PjSNMASu/t6g3P7SkQ6I+YAlCDIzUuCd8h7af
         G1eC4e3bitYs2prBZ5KlDFr86DiVcKmrhT7KHLFG6xy0pzxb6NkIqspdEXI+BaBXnzuG
         anmmQhJDnWLCEPpucbr2F/KNa3BEyCkjKEc8Pap9tFKARcpziBeV1t3cZLEy9zAu60xI
         +XZsrdkJXwrjwBLX7sUaCyqq5jn0nTrOlru9vkU8MQl2WiWGfFWPnEtbMEQjWu7ZGAqU
         7xwg==
X-Forwarded-Encrypted: i=1; AJvYcCXzsELP61KYxqHiu6cY5XphAYhbVOp6ZfiyHKaEo7vMDsG5tH770xs0p0aUHM/awU10XJE0/LGy8+2dSS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY3uhWkFfVxrw9wC5heTGdkWfczZzDMQH7yOFBHKN1hLRj+lB2
	JwB+Fk10tfJd5Kji7ZeFpngyhi5zu4pj0I3otrE4Wj5Q/w9PEdrUkgAD
X-Gm-Gg: ASbGncvwfKzjxSttSSG8AqSyRFYNf6q9/5DMedgfws45E0fkhEP0xBhrzCPaWyjwaJa
	lbm49KBaZIqQ3SMgRrYD26jbkPU/6XEDm9+KDVzSd08z6Zm0vUztG2IvO0yDs/oCO7lS4TWN+es
	ChfSCkYsupFWgvwu3JNEdkxcKONngpiLBlD0tt9Y5+fybV/8gevUo8DFN9QxdVuTQXo/MGACBh8
	a2w+QzSahvzHdbvIr/MQAPs9gHkv4OkiTzbCMKFH9A44NZaIRCsHg3mFCjPN49OBME8Qt7bDyA5
	Y0IphiO1LeWZ8qTeYfnpCJ/tv/JM5wg8YlObGI7MW5nxWnkfX9V2xeG2DbKI2xvQm2VTRdZXtds
	NX2Alepri2kFtkvYRwkmsiibr9hp7SG9HbQw=
X-Google-Smtp-Source: AGHT+IG1t9g+PyWBTNNv9NJLqG0nvrC6oN7qO1dddwsct7J5ksa0J4Ge5ZLfMucYl6Syn9hATvxiLw==
X-Received: by 2002:a17:903:3bc8:b0:273:7d52:e510 with SMTP id d9443c01a7336-27cc79ca30cmr79439065ad.58.1758725021176;
        Wed, 24 Sep 2025 07:43:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bdbf1c5sm2665309a91.19.2025.09.24.07.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:43:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:43:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Shane Fagan <mail@shanefagan.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add ROG STRIX X670E-E GAMING
 WIFI
Message-ID: <12ab9197-8894-48e5-9d4b-4e516c3ae972@roeck-us.net>
References: <20250914074125.135656-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914074125.135656-1-eugene.shalygin@gmail.com>

On Sun, Sep 14, 2025 at 09:41:14AM +0200, Eugene Shalygin wrote:
> From: Shane Fagan <mail@shanefagan.com>
> 
> Add support for ROG STRIX X670E-E GAMING WIFI
> 
> Signed-off-by: Shane Fagan <mail@shanefagan.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.
Guenter

