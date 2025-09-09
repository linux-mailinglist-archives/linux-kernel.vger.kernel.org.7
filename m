Return-Path: <linux-kernel+bounces-808143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF0FB4FAC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1404E8654
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640833375BC;
	Tue,  9 Sep 2025 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STRJiY5f"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667073314DD;
	Tue,  9 Sep 2025 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420789; cv=none; b=O74TgSvQ8d7/UKFBRTISb36gu0vGog7gh2AT5wMKpwGxr3TxuNh6y9YiAHPYD7t3hY3yPYNWmCLsBJqUx8mOFqSKlU1gbzb519C2TKHd0zCrGY6rHFP0vQ/2u7wSL1gn/lG6XOsW7+STwVbeBNV9/N5+v2dS0cwg+prTcxcliRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420789; c=relaxed/simple;
	bh=U7TaQrD6Z9fVJPERIe2QUuANZU8/QdaSRLm/2t9oIcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrDe+QQRltMgz5PJVjvjhiSykkEghV67XQA6g7/b1CGMkJslOFYko3a+P8L7MD3MHOxUUgrTI0d4v/Fo2wT+mhSpwDLbINJX80fFIBWDb6gLbPRDEt01bCVB5jRWhBqfiwv7cM16fW+AmsaK8iP0aQgjJZKHUZqIdgs66s8BluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STRJiY5f; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso5781771b3a.0;
        Tue, 09 Sep 2025 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757420788; x=1758025588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+JVT/wxmER+Hohr3wia1VPwKySwieE1n34G+gOen2M=;
        b=STRJiY5fzj7fK9YnAq59/vwyTKi/06VfF7YuOpv6bKAo6T1sWXeNvGjVxlSS/aB23m
         89vDioT7k7uDKGTPknkFrA4hSFpB3CCNUKuPMIYwBMTu0pFSC4xDHsskk05mhXDJY6dl
         PZvJvJ/jOxmrkmi4iHFgjJlzPlVBWHX7NEHn1668YfsivtPI2E7f5/JtkHCxAonP3djT
         wpe3FuLtuPqo0q0oxeoYuXRRXUOgM/CYanT7blAkuoXyWM+znaROxXw1/ykoAcjrz6nh
         AiMT1lYAkkziYcr2fnwWmESYAda8CkKIDkoPQcDJ0Trcm6Nwmueo4FuYZg3Vd6+9fqIh
         c9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757420788; x=1758025588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+JVT/wxmER+Hohr3wia1VPwKySwieE1n34G+gOen2M=;
        b=RMAYOEnAKX9DrNKkfD8rTDKOjLLL7Jvk4unIT4pYClIo3XRuhk/3O1+rjhQr8Z7WLv
         9zNDV1OY6YCkLUzIYgpybyp3/aWySzH5VLCWzW2TuKlVMho1+wz5ERm9waMEoh28PmYe
         SETyH7goWcF9+D9acUY0cNvRx7yLYBBTFv+6PfArYjOt3UxLkQtXFp5yMPShSW89Dt91
         rPrRUB1baeGeAk7mRNneGe6yFUtun0ed05hzOSTW4L3d8jr1OLMTyGxY2nezxAtjbgi9
         zFlnTKcglYFIro/EMewg4pKNWlMyBh1Zdgk8E+Z0Yvg3cSxvZcaWV7SPpgykvDQFM7Wl
         dd0w==
X-Forwarded-Encrypted: i=1; AJvYcCUo2hb0+w5h1HwFj3HjvzckbepAfq972aviW+95dKHByTur02utIMIAN2HB5elkCBvD+KUAisa8H6jC@vger.kernel.org, AJvYcCUsNM3nVoKGxt0mCu9Tnh3BhaWbxhOTTL4s+zv1/ta/eRgcy+pTOljx1ioGUurpdS+1QtOQh09OSYE331Qc@vger.kernel.org, AJvYcCUxUp0TQYjj1VcT9EmBm7HkheYmCaslQl5h4Q1d3FQ3qEBBfGD1bk9J4oOoOE2MWmNxBMmK7n+4imSvxoA=@vger.kernel.org, AJvYcCXSSScrLENW16rm1zUxX/0JSNwAzg9AElGGzywxWbzfaltPNe9OMFP/A5gshiZZCYlMWFgCbuCB5fjI@vger.kernel.org
X-Gm-Message-State: AOJu0YweM+En9+Sg60AYUg3s0oZ9NG9W/KZbDXcSphFf+SFPJcESOYi8
	xia8i7BeNHaI2jOivPNiAqPjpBIbJQWquR1bRMJc06wrkGkEyXeNpgeR
X-Gm-Gg: ASbGncsXgjllOMifHZxW8WWS7XdTeJyR3QeIV2vRsg2mSZAol8P8TQFr3RfZdrxnGZJ
	NvUssRsfJ1Iq0DbnYN+kb9MeeT22fquw+ukE+/wmbYOJ7BQ2LQlNJ6bbxleMIWk3ZR2ZPmbu0NE
	GWG9M7WEulqaNx+NAiGsdJYoq1fmpkSl/VFE2tjOZ4/sERrrkxQRR6QjGv5TxTuWbvyxPEF4z0x
	MWuxZlymxOrXa72O5RCrDIoUO6/1qZMrvF5HkEID74LLQm+K5dgVWREHVEv8fZwuMnFIBHIsXA9
	Yd+HTsvDpbJyskF7LaMmVGeqIWs4IQmm32SuSTznPNGAo0d6F91bBascZ5viJn7IUvvxi1tZXF2
	WmHMUrlo4Rogd735hLoFCmEmtcrY8EvKH/mxBFgy7bNz+msn8auP3LofP
X-Google-Smtp-Source: AGHT+IEo1/k3nA9TlKM57eXi0NSc+v5OQGJ5GpILeZ4cYAMHSrGC90gCokC/g6HdzrNNkDBsXRNhKQ==
X-Received: by 2002:a05:6a20:3c90:b0:251:7f83:11d0 with SMTP id adf61e73a8af0-2533e5732e2mr17831182637.5.1757420787345;
        Tue, 09 Sep 2025 05:26:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4d6cde2f0fsm27980059a12.13.2025.09.09.05.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:26:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 9 Sep 2025 05:26:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/4] hwmon: (sht21) Add devicetree support
Message-ID: <fa158b94-33f3-4fbe-9491-771bf70d8617@roeck-us.net>
References: <20250908-sht2x-v4-0-bc15f68af7de@gmail.com>
 <20250908-sht2x-v4-4-bc15f68af7de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-sht2x-v4-4-bc15f68af7de@gmail.com>

On Mon, Sep 08, 2025 at 10:54:52AM -0500, Kurt Borja wrote:
> Add DT support for sht2x chips.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Applied.

Guenter

