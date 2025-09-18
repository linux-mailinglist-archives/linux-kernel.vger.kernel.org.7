Return-Path: <linux-kernel+bounces-822299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBA9B837B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C961884558
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1142EFDBA;
	Thu, 18 Sep 2025 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWLBBIdj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E72EFDBE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183027; cv=none; b=JG3yqsBKFr08Bbjfezn6KvsdV8Cn+9y32iqLjywRSxeR8q7G703Hip5Z7rpz09AxD6QwDWicI+LKHQEsnh42w+zDfQlGO2ls3e1sRxq/MgbRr4pT4k995pfc8pKgtKKNZVMj/18NzAJFBjH1ZTlJvIKCDiC9WXH6BsETIe1UhRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183027; c=relaxed/simple;
	bh=ivIZEsXoqTF/6RC+0opLvNAFtOiJGTDP4BJSazhqGSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAjH3ZymkqsGkaaSWBoySEQd/odb98bt/l9C5WaBfAAbEGQcKMbO5m2z+2LHOgEFv/uSI5o+DLqFYjHwhjLPNSzbBUaH2yyGmH09+OLJ7oL7Lp6G3lSqjzVG5mIW8hHiwGA6/q3unhCzwIDoVYT5/5NwPYA63oM5SovozMGLjfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWLBBIdj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758183024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AIK6PrdsNp4wCeKnNrX+jPRHc/pTUR7rE/WtO0oG9eQ=;
	b=aWLBBIdjRVBoUXHr13EcgyUSLLdMerMjbRG4Dv2SoXKj8y78QkSEPIXSlysPcHZJygNycW
	KX1aEKGX4OCFYK6Mwy0M6bstOxPv6BsH0qee0TS2WBi4cY86hMrLAIhd+59VAJHvXJWwIZ
	dZnjnCX6m91cjm3U5c/n9P0QqEqY+3Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-jgcr6pt6OIGWaelQcfbQuQ-1; Thu, 18 Sep 2025 04:10:22 -0400
X-MC-Unique: jgcr6pt6OIGWaelQcfbQuQ-1
X-Mimecast-MFC-AGG-ID: jgcr6pt6OIGWaelQcfbQuQ_1758183022
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3eae0de749dso360679f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758183021; x=1758787821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIK6PrdsNp4wCeKnNrX+jPRHc/pTUR7rE/WtO0oG9eQ=;
        b=UZfv6LavyLn9oLHshOGpDKhe2oqNQozC8sP5W5TdnYYa4VkvOFYUhtpCvSqQez83q9
         IJd5dqbzAGe64ttYLC4zOi+KO9HIiHYoPVzwaPLcUv2VFf7HHgRjSkuYevRf0wtsERbJ
         qYwXLzSiQEM2xFhOWpNlF+5eZ4ERA286Ugyjg/buy6G5+Q7ixwElnnDEo2u72dyEw+JA
         is9w66nlj6/SAp5WIXoXsVDUTYRUl8mdWgbQQgG3ZX1ZPtIiP6biKnyOAUpuASHZ3NSB
         VMBM/hh9NHVlURMy7x+xecpKFwEUhnxxUDyDeGQPrGg0iJzsSgjeuPgsYUv/c3oLXJsQ
         2D1w==
X-Forwarded-Encrypted: i=1; AJvYcCXW3D+7uGkz9x4Ct4x7RP2bixmNcl7mot52beEWXh5jZn2zb++WWCDEG7rDcxs9ZWBtDpm8Y3Gs7dYRLg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVX8WlSKTY9OSZ5OXGc/jL92BL4gQE3+xiGRTN4G0JWGqgSfye
	tIq0EozLZtcXT19izH6xarZ8XUbVivbY5sfcJnM75/TR3fpV+yoDrX5xcy0FbvXKjboRVNBEKwQ
	jnxYuI8a/uQvXQdg1yngCfJ1CVGC4lJdh+c+H8FQQ45+HEv5lqrTC3NwcTrhWqDCIdg==
X-Gm-Gg: ASbGncuG1x+IGEfN4dJTLeNXfW8e4+boDLSh7FRVn6pf+lOoHysbmEb3+Kx15Z3rCXd
	O4uxinFwof6CMP9JEGjIhrG2KSbJZMDH/plDn6M8ZVaMf8m4ArJpe7OS2JjvTPR6agcUFEoXERS
	U8FGjki/3nEK+5n6+seFb7E6GR015r7XCZYHWZ1ECBKD1VQw47XkzlZuga1OYQLR085BFgO8DWN
	jymCCUkXWYB9mG0ukIP5sfqEIcOnHZUE52VPWYS/bRN2zU6s1IvAcYlYO5lXKWqxpXbwzvl736I
	NeTsC2iTheZjqakgfS/4zZuTmkOib3RfndmCPWAt4uo1dqrGlwmlxDdbSEoy+Q54969QNo7E1Qf
	vHzFYLmGraVL5
X-Received: by 2002:a05:6000:40c9:b0:3e7:451f:3a6e with SMTP id ffacd0b85a97d-3ecdfa44ce8mr4457769f8f.51.1758183021515;
        Thu, 18 Sep 2025 01:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlQmokUFxowAtKuYqHFe28f5t7HKRGU+H7wCLUK/xtNvxaEAZb80ygLNuVNrDWbmZGJZghMQ==
X-Received: by 2002:a05:6000:40c9:b0:3e7:451f:3a6e with SMTP id ffacd0b85a97d-3ecdfa44ce8mr4457718f8f.51.1758183021037;
        Thu, 18 Sep 2025 01:10:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139123102sm69364125e9.9.2025.09.18.01.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 01:10:20 -0700 (PDT)
Message-ID: <c557acda-ad4e-4f07-a210-99c3de5960e2@redhat.com>
Date: Thu, 18 Sep 2025 10:10:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/5] net: gro: remove unnecessary df checks
To: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org,
 ecree.xilinx@gmail.com, willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250916144841.4884-1-richardbgobert@gmail.com>
 <20250916144841.4884-5-richardbgobert@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250916144841.4884-5-richardbgobert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 4:48 PM, Richard Gobert wrote:
> Currently, packets with fixed IDs will be merged only if their
> don't-fragment bit is set. This restriction is unnecessary since
> packets without the don't-fragment bit will be forwarded as-is even
> if they were merged together. The merged packets will be segmented
> into their original forms before being forwarded, either by GSO or
> by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
> is set, in which case the IDs can become incrementing, which is also fine.
> 
> Note that IP fragmentation is not an issue here, since packets are
> segmented before being further fragmented. Fragmentation happens the
> same way regardless of whether the packets were first merged together.

I agree with Willem, that an explicit assertion somewhere (in
ip_do_fragmentation?!?) could be useful.

Also I'm not sure that "packets are segmented before being further
fragmented" is always true for the OVS forwarding scenario.

/P


