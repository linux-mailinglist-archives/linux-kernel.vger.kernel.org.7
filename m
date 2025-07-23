Return-Path: <linux-kernel+bounces-742947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFA6B0F89C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754983BF538
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3C20F087;
	Wed, 23 Jul 2025 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NHbXjZbD"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D57207E03
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290055; cv=none; b=eFKPcoeUxSBLLuYI2nDGh/BLb9urnyXO0otDILeUHtAbriMM0UyMLvnIQUjt23br2dRSp9XMXj5Je63fidCILJ2t07umvm/kGEkH12mBqxhAiqMbKKJRpOABX90ns7aGycXtORFW1ZX3eqAoroQ69hYHhGqbbHgX/+qiXyE/oGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290055; c=relaxed/simple;
	bh=iRwGsir/WS19R8zzyQIzHgcHO3Kn/7CJJeeg7cROVuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCf6tnM/BDBFyZNLUF6LlojtRT29Y8SCtefY3EnQBE8z6o/85LKPKMHY1rzrMpEv63fcCgzBj2o+ZyzuIzXUUNdxYeMsF9P/x93tpv11kKtuDdL4TbsQxoivZgzA0nSH5o8IW4gNH6vXleiGTch4BdJt5ZG/r+o9XZwQKadxcXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NHbXjZbD; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7de159778d4so12026985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753290052; x=1753894852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAA4uKDvogNFqPIVx5Z2Wi5tvRUB0/yTR+8w1NV0hk0=;
        b=NHbXjZbDGDUfBfHJbjVCCTEpctn4bQcs9A9Y46VsX/IE4tbyrOuL+fRKl3juS1PxK5
         7OsSkdQLLmV1L1qgMtS0EnhHN7BXL55ahU8iRRYldn2XpKI8x1EigyfWfb2GtXGtiwsp
         /c0Lba8Hh+XWnQmD+II/9kRB52+rpGR+FGUv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753290052; x=1753894852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAA4uKDvogNFqPIVx5Z2Wi5tvRUB0/yTR+8w1NV0hk0=;
        b=Lv2o1MclEBiZPNQFa6g1OAUwjez1/lznmytTImUXnCUXKurhqw+SeWuj89v5dJNl/6
         MbXe5LF2UTDcZuVUSnlqZY/yn/AWMef5s4nLOadPZ5gyv+StpgjD3fv6jQRPnuN0EYfg
         i7lEG+543uvfysYIb+4zjOSyPaRf48SGxMkZaD/A4woVtQ2T5tdWAXeOf2x52ZlQYn2p
         YB82R1fwytLf4QVMgwOnPBeP5Jvt79AVkaNu6SkZJCkHTPEQcJ7eiHd5nXrENQrbvjes
         9zW5a6sqeIIjg9XugcQzGZVcsTamf1WKU/u80kUQJeAdFQsA6i45GZxKO7sHkPuxyLF1
         D/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbB5HsBkPuNODEOPY6Z3MX4jl/YRoIQpmKE97eBE3zY1EkrLmPN3GMgbhPFkng+Kc1mS+GTfV6glBNruw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7g9JAzOu7CZ8jlVJczFkPNCFQ82wCg+J7M91RMhUm0VQPaGyZ
	Mf3bDaWGI30kSNbuUEmkBPUVfyeqczrJSBQtxkGvqNeeZpq80P+iLnbnt8ymMadKTA==
X-Gm-Gg: ASbGncuwGuvAgvPGcGIx0z+91s1WiJtaAQj6akbYGru01YBbg+v4TMg8FuVLfE0bw5B
	qoP3aT1Soznk23w9MN7dnPFqC4meou5+TtMQPoA7o95SWZUPDG3mSTxjbNG68PE1DildjwMKObs
	/NSmxUshI1bBrCrJicDj9/W1am6V91RFAXl8MVFhPhuhnPDXshhxbBAj0WfjkpjviAQOs81ygZv
	JIWkd6kxgN2cPHgqqzg7mFpKFskdp9Y9WdZYxlwWZ4V6zK1t8iEFelSCCbPEfHzhIYFfIw7FUkj
	QrAtx9OmF57Ovj6d1Q0ALSTjvNcZi2gqqd9FCvSyfLeU7WXKFLfw26X5KUszswU8U1Ft6yb6B+b
	vy6qloPdk7ok/2St8dU5LZxfLuDwPaHPMXm5a4MjwB0Tz/JAks2ykZ7Q3Q+H71eExztg=
X-Google-Smtp-Source: AGHT+IHR/pIYFUXjIhcVQC11znP3yVLpRzPulMmcdzaK/tiosFIczetxhU6bAr+Fw0aFbrPOIY4giA==
X-Received: by 2002:a05:620a:4546:b0:7e2:3a27:a120 with SMTP id af79cd13be357-7e62a1a7909mr526750785a.54.1753290047833;
        Wed, 23 Jul 2025 10:00:47 -0700 (PDT)
Received: from [10.69.65.106] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm687374785a.85.2025.07.23.10.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 10:00:47 -0700 (PDT)
Message-ID: <80d282ef-aa14-4bcb-b118-fa8b237c1621@broadcom.com>
Date: Wed, 23 Jul 2025 10:00:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] mailbox: bcm74110: Fix spelling mistake "braodcom"
 -> "broadcom"
To: Colin Ian King <colin.i.king@gmail.com>,
 Jassi Brar <jassisinghbrar@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723095315.3999463-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20250723095315.3999463-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/25 2:53 AM, Colin Ian King wrote:
> There is a spelling mistake in the author's email address. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Justin Chen <justin.chen@broadcom.com>

