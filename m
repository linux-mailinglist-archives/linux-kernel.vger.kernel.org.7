Return-Path: <linux-kernel+bounces-892247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1BFC44B40
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1469E3B089C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2301FE47C;
	Mon, 10 Nov 2025 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThulERKB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j0fSdbcJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF01EEA31
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736633; cv=none; b=ZxD24wxZIF/KB6+KcmzEGoDV6OV1q2sVzpnEAAH4EyxB0xIlpz07gcY5UwByGMc6Cb0Ehzv9O7TzoeFrUce2wYRs4G/C44HOGC/a4GlcbyMD9w/hruTp/y0DXUSwDm2VAn/fTV/Lt9Q48wHaU/wdsYUDRObqbu4CxOvDmOdIGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736633; c=relaxed/simple;
	bh=vC7Qu8mrxzkCPxU8hIL0SO1Mmh3zmsPEukVxDCbCCj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jp81MxxxWtPMpupLuxlFyzKHstkD9YqPbgXszATM9FT+bc7dlGTd4gT2nKrflHf0C9nxOrCsU0ylTAcqEGA8/0vb6VAIiYdzN8g9OLx9Iq5cKmyLeTZWzC+gYG0qoueOYsajfIak3Ih2F+hSkydH/DYXwonJIu+KcRsTUpKdYYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThulERKB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j0fSdbcJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762736630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fp/vQ8A4fCVWTHL4CZ8vIUZDQ6q0Bi6AYYIP+rrLgSM=;
	b=ThulERKBHsKVtZ2HdQrv0FFofQsmYDJPOlU4xOYAxkViFDS5qtIhbNKWiBJ13zlU6i6ajT
	FA6yjK7jgW6biZqB0PbbXl/aS+9S21dMFKYzXS0BBIdTiIUIC6BCoXe7lhHNRbK0ENYj4X
	NpKSFYLYnKEZlx+kk0HhNo8TQPqAeGY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-ySWvK4oOM0WzgvIpFutr7Q-1; Sun, 09 Nov 2025 20:03:47 -0500
X-MC-Unique: ySWvK4oOM0WzgvIpFutr7Q-1
X-Mimecast-MFC-AGG-ID: ySWvK4oOM0WzgvIpFutr7Q_1762736627
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2958a134514so27483555ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 17:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762736626; x=1763341426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fp/vQ8A4fCVWTHL4CZ8vIUZDQ6q0Bi6AYYIP+rrLgSM=;
        b=j0fSdbcJy+LYH2aqZzkLhhM+SsM2ikBgy6gxiCXAUq3CnnDBUGfNQN1C2S6/IL5+DW
         Qw8/Xxn/neSkwtvDq7N7Qhx6FzB7iur6Zm5/wyZe7f4cw2/OxiaUn6/dkhz8OMtXSPCu
         F90bxMDwVJqAhwowDw76BYCfKoC4GDPLe0K0FQCkt7TpJfsWYz3nrNYO9FGrktWvXmmY
         w0yB6j6/swGDGkK/znbalIJw2bk4VNgVlII4HFspanUaJm2uAHiI+09thJFplk5JLBRN
         Pfwz91MhyW/Bfu3d125nr2BATyBOlTiikW/eosenNARAdz7OfWYn8TbRqyghzEsRk6Po
         KZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762736626; x=1763341426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fp/vQ8A4fCVWTHL4CZ8vIUZDQ6q0Bi6AYYIP+rrLgSM=;
        b=YKsYfBDT0gFvV+agYearpVKnZrUWEjOgxN8nkUCgQOkS+COUcphGJ9b5ghWoXQp62h
         l+ADAGlXYg+mHYT0bYm8j/dzyF4u5El3135ufAJ2BWhpU/VRxI82vffL3OrHXP+SM/ky
         ykrqZWiqz8H2fvWKPySOVWKkyAQ/pntrNvfD7JH+qG1Pw1sQo2QHzcth691TfluDjIQO
         qVyiNsgZh7W79QG/H7Ck8WvDBDfKan4tx9ECOq+YTk8ZuGKs87Dvte2lijhXyM0fuCvY
         ole9w2UJfaJcOMlLmrM2rpdiPzi37GLl19ET2sMJQVU8aJi59s42b6vuxxr5d4x6W0nI
         qzpA==
X-Forwarded-Encrypted: i=1; AJvYcCVPK8E67O9liZ+zH9BDA02NKRIYg/u1daxyBvxMHksqkLfvL4PQSZ26hQPKT2qXmIPRj2+gG24Jn0Q621A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwxa6dAM/d0eGh/saDLrsP+KICw3jXNlR1W916lIWRShU1fN6g
	1N5JTmt5BPwci7CLE1JIHGKK6ASwjuyQ0BEldOLP2B/NOzSWGoxDdNKjkhJ1Df3amGzb8rzyr2l
	X2Lw44jkb9lFGdVwXlmJ0R4nlN7wU8K6xo0AIYNNsZohsvtHOgnzoMsQQJtaFjcm2kg==
X-Gm-Gg: ASbGncttpkYdHSGmr9JYnNue8fOlPoJXVtjq37WPdaQ0EqVGUg6VSi1Uf3mG8sPBtd+
	rdhPQ0Tpfb2XFOCfap4WlnVrVm+tM5MVAWw75aP+lKj0UmzDp/DWH1uXA1mM0hSoHBL3jz0cDBH
	Gm0+SemU2nqUnW6vL9b9cEnIlm/SrrX5fmdkSZ8+v+eMrVAAijRl0V2csOLdtGVkMx+4gYeKR6H
	oih9c9hU1hKTl4XMoKbPm3NnZmIYF/fn8O6RcjLeNLQ7/gMlogFL5iV2sJUIOkCiBccc5Z6XB60
	Bwv5f6IxaynX4BLAuLYUU9J6y+3MQMtwLSffoQyQ4ltwM2HZf8nW/simc8oe6ltx0Ej3ZncONVq
	r8O2YhsBFCO2C7exiJECH8spuTTzG2iOQ3qa86NQ=
X-Received: by 2002:a17:902:da4b:b0:295:24d7:3792 with SMTP id d9443c01a7336-297e54030a4mr89617155ad.1.1762736626564;
        Sun, 09 Nov 2025 17:03:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEflOEbjXKgiwLnCEBh3CST680cF3GuQpNEfibt8t7UBtS7/A/XhpJnakWl13KtFWAXgEGWHg==
X-Received: by 2002:a17:902:da4b:b0:295:24d7:3792 with SMTP id d9443c01a7336-297e54030a4mr89616825ad.1.1762736626020;
        Sun, 09 Nov 2025 17:03:46 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e3c5sm126117355ad.43.2025.11.09.17.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 17:03:45 -0800 (PST)
Message-ID: <8a382455-1915-494e-8cde-04407696cfa9@redhat.com>
Date: Mon, 10 Nov 2025 11:03:32 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/33] platform: Define platform_device_put cleanup
 handler
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-8-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-8-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> Define a cleanup helper for use with __free to destroy platform devices
> automatically when the pointer goes out of scope. This is only intended to
> be used in error cases and so should be used with return_ptr() or
> no_free_ptr() directly to avoid the automatic destruction on success.
> 
> A first use of this is introduced in a subsequent commit.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   include/linux/platform_device.h | 1 +
>   1 file changed, 1 insertion(+)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>


