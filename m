Return-Path: <linux-kernel+bounces-803805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDABB4659A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858B3561C84
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ED62F069A;
	Fri,  5 Sep 2025 21:34:07 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06F2DAFB1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108047; cv=none; b=gfpumfRiS8lQUGdp3eFEK8dUuyI4d3gOLC/7K21i4zG36WXG2AtWxSXWk3UBdtdjQfhPZ+6CHiL1uftItdLwS+dmIMfGDiVBtGqpFJVQ9vrsigp0zJQ9HaDCVUK55kSFPtAYRH85gZdBLZUT3iOUydCj3hJjWT+AfYwe5Vzv3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108047; c=relaxed/simple;
	bh=OsQ/XCKuRqaR6esTNv31pT1uTGcb2x5eU2Mmmfq90VI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eGxHhTs0Fj824n0WHfH+WRW97L9Lh6bqhQZR6RWa1zoqhMzYRF5Y4UUmXBQ4gUEVlYyXgAK54kDsDzY0yo1ATVX9FiwLvFStvKCS0lzYIJA1jgl+a1nLd4UewnhnOIA7ME9hdphx/valX8IcMTNKmjmPdZpsc5eIV5lrdNMNDLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7742adc1f25so348842b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757108045; x=1757712845;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsQ/XCKuRqaR6esTNv31pT1uTGcb2x5eU2Mmmfq90VI=;
        b=Ek4ssJeOzA8QroInzfm/vC8P45j6L08psi2VfVT/ZR9QQf9WCnmi9aNiPQbFZKoTwp
         g3tbKASzQEnmZf64ayIZhwHRnMfovW8LmuqmZs8s+vSbGO/6N3PbXx7kBtBTtM0+8EOQ
         Q+0Dka8HVg84mP0KiKh7vi2+8vcTxwmWZJAsEPpUG0Xz0qs88UOTjER8omW/CKLIdRrZ
         0xlo+0KfqSHW8Zr1jqIkkbqkwIFysfqJR2r3VaD/pPcUs+7mJFslHYqXKI0DGolKoxrm
         cWO43gNWgwOghiRmScdMxrQJdqRVDTZZBoSEkmMJ+zhPDt9RUowuU9+bCVEw1rgOj3CG
         KZQw==
X-Forwarded-Encrypted: i=1; AJvYcCVsEsDwkwB7wwbpa3hEf/e12dAV4KntEhcH3h546SR2r883djhn/Z0Tq+c8fn/4TfCeFXkkV0ct7VZiOaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxizq2GbUU9WYOFsb8Qj5k86tIB1PIxYsj/WWFedJNKyob0h4uO
	neNtdXO5uHug/FKkCb1T7yThwsoFMM7I/HGYnuzaNz8IVIDu+BaZ31kMMF/5/ReCZkI=
X-Gm-Gg: ASbGncvs3biB+pCFTlAKPO57eMLmFvi44c/Bv1mgmOywqd+7NNW8md7l2hFxoUCBUVn
	KERRt3XZo03AqdfQcz5OFiMKz7hIFEEZVOyHIKw7KeZqzPQC8hvX/RwLkKVm0YxhMVXF1F8+ATR
	6X2/4povylfeaWYbNTjYYf+xsoTLk64r+S2hGKRXLg6EVYeoNdS9qtvqeJUBGISyTd32PHrUAMW
	7MqAwYFGwcAovlFQB4v6wYko5IskemeEPdm63UlNyYHWu3F1RPFf6n73d3t92O5SF1DaEtyofCi
	vCAwM5G58LkAfXebQ981jWAFnmJKWMc/sGii4biPTkRz/HC7MkZ1GzJIIIfmcjfdW2di1VIgNmy
	e1367aTGCBetj4tfOv8V/
X-Google-Smtp-Source: AGHT+IF98k8Va16MpWzLp3ZggTUXIe4e54bFUIoKsXM557PE3M1cHZME6evE4tizbxZ5oXDsMeINTQ==
X-Received: by 2002:a05:6a00:181e:b0:774:1be4:dced with SMTP id d2e1a72fcca58-7742dccafdbmr309740b3a.9.1757108045347;
        Fri, 05 Sep 2025 14:34:05 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1b21sm23273993b3a.69.2025.09.05.14.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:34:04 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, tony@atomide.com
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org, jihed.chaibi.dev@gmail.com
Subject: Re: [PATCH] ARM: dts: ti: omap: am335x-baltos: Fix ti,en-ck32k-xtal
 property in DTS to use correct boolean syntax
In-Reply-To: <20250822222530.113520-1-jihed.chaibi.dev@gmail.com>
References: <20250822222530.113520-1-jihed.chaibi.dev@gmail.com>
Date: Fri, 05 Sep 2025 14:34:04 -0700
Message-ID: <7hplc4a8j7.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jihed Chaibi <jihed.chaibi.dev@gmail.com> writes:

> The ti,en-ck32k-xtal property, defined as a boolean in the Device Tree
> schema, was incorrectly assigned a value (<1>) in the DTS file, causing
> a validation error: "size (4) error for type flag". The driver uses
> of_property_read_bool(), expecting a boolean. Remove the value to fix
> the dtbs_check error.
>
> Fixes: 262178b6b8e5
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

Nit: fixes tag should include short log like:

Fixes: 262178b6b8e5 ("ARM: dts: split am335x-baltos-ir5221 into dts and dtsi files")

I'll fix this up when applying.

Thanks for the fix!

Kevin

