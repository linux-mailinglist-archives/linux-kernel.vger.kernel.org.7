Return-Path: <linux-kernel+bounces-866745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A430C008C7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 211444F993D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4416630AACD;
	Thu, 23 Oct 2025 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wg+2Fk1r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D803074B1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216195; cv=none; b=g7htCzg3lkdHEQhtFAvjg0U9pd8L7BIdH0jIIIUY9Co7O/oxzDGRGqnhjdFIWmKkxo+xcdMrpQo97s55smWbhYWAVJsjyRPWPTm4+PAVzLuVnWX+1MhFuSkSnoFka+Q8q9k6ETDllaCQiOwXFEF7tOp6kKr4fuAfp+Bo1xlC3R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216195; c=relaxed/simple;
	bh=PSq4rzHsTZYmnPW7B8CFsP6cGQe5nHJwDQGMbKTQhlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAb5TWGGQPbyF4UQ7Oeg6YIq6GCB8OFffiUaFcBX7BwaLpifUy3WMs3mo5TD0ZUiYvDVdE0+X+N1TtkGbB7cH2HygaywoIizxSknG6nwy+/LYReiCPborQlnTd/JDf1osXogYv5jVwvlfL3Chie+HmiyJ1fBFUICcuMIrAopCjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wg+2Fk1r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761216193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2itfR4P5vWlnhxtQmgFjh+n2XUI3sGLIeHL7uzBaLr4=;
	b=Wg+2Fk1rKYh4Nd+M/CzDit32eSiJ1J4iqc5JTikhTBMrGq1XhZ94UM7xZ9XtrbozUj/euB
	O0OYfsQbSuPiQhCtfI0XNwVVbdRcXl6+a3/VwooTDm2mPlB/TN6w7CejrLRC1SFiPXe+VD
	RxviOo1BzUTCitWCVfF83WrS2MmTlPM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-rrc4yReVPE22vYmNHi3_TQ-1; Thu, 23 Oct 2025 06:43:09 -0400
X-MC-Unique: rrc4yReVPE22vYmNHi3_TQ-1
X-Mimecast-MFC-AGG-ID: rrc4yReVPE22vYmNHi3_TQ_1761216189
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429893e2905so472219f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216188; x=1761820988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2itfR4P5vWlnhxtQmgFjh+n2XUI3sGLIeHL7uzBaLr4=;
        b=olwjkXKA0nEa9Wm/2pBanudQkqtWfEdhr1gYtCGE7/GEAluj21XgtHGT5hitoTfi+B
         FFaDk5lAMSx7D75q1UdVxw7YPML6HmtTTSnuync2s7YbLOPwn2nYHrZ2BWvMXm+yTT0/
         Ij3ln9b2ySh2Vc9lVFjlyag2vLM2gviOdrBuVbXu26yivXaUJAFrXJBqTRry9/CrmFH0
         CTOrSakfB6BUbDFz0j4LbtihqD8ptI7SZcrevzb3Zw7hndSRFIlvXDg/yJDu+E7aemxF
         61gZcwbCeLhA9FWUGvJRG0yYCHZ1iFLzZVQV0tPwcONS/cqXqnQAVf/ZWLF4oTpeZSvK
         UX0g==
X-Forwarded-Encrypted: i=1; AJvYcCX4ye9XxYcqOOCCOYM1/N1oRc1plh4Lqwbf2LHTB35Kp/PnLj7IogZgQueuj50i0Il1VjxtccHOU9mpnNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Z7m2SE57wXcnNkpyrwW/GXhS18Cy6X+6qSoHmMxfAwyc+v5T
	82FOrl3YxhAEGYQpLJMH9flqypHD5WU+Qiw9uD0EB1uchC3v5oQXGbk+TOtdDi9qeYXhdQJa7bp
	bhRUoVEEILxq/Qqtsuw/UsPnBHth+fEfRUhjr2pPOw9/LjFgKohc8DIUNeTDNKSfEDw==
X-Gm-Gg: ASbGnctqMRUT/2K7nSvRgyg/uCcyNJ1pASChRunNQIh2raLeOY6IROFqoDo5KzZfE29
	IXyJREsVduKYh2eWCPLYBBcwTmKGozcZDC4Kbk+vCd5+ebK8rJVPv2EQWbKhjJEY9F6dogxpGNI
	vUt0LgsL4Sthkvc+YjnVL8UIekpCpVkEylva5zssdC/yeBWuwHEm8WqU7mVHgzncA9fX71SApsW
	x0hOSJklUgaVW06jIfXxGRFrlmpmaFlq6glk+pm1YSLthDir7m+zLbBJK8G/XnPFXRgtr7Wkubt
	4evhy04WCjrxas8/xVwJATHMVPWwJXn28o6eHUcTcoWFfWrGHyC2UDgMZ5jQbELMac9s41oJOF+
	bPi4FOVUk7I8lOVMSOiaoOjk+a/TIu1+sgkVmpFgZn5sAKKk=
X-Received: by 2002:a05:600c:3b83:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47117925171mr243743995e9.34.1761216188616;
        Thu, 23 Oct 2025 03:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeZ82VrSnvpK1c3qyzIXLRxmMNdmjxKL2P/cuqpRB9ovXOV8FGWqUSGpOdh0UCletrBUBh+w==
X-Received: by 2002:a05:600c:3b83:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47117925171mr243743745e9.34.1761216188204;
        Thu, 23 Oct 2025 03:43:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae92067sm31140865e9.4.2025.10.23.03.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:43:07 -0700 (PDT)
Message-ID: <268ee657-903a-4271-9e17-fcf1dc79b92c@redhat.com>
Date: Thu, 23 Oct 2025 12:43:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251020212125.make.115-kees@kernel.org>
 <20251020212639.1223484-1-kees@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020212639.1223484-1-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 11:26 PM, Kees Cook wrote:
> Add flexible sockaddr structure to support addresses longer than the
> traditional 14-byte struct sockaddr::sa_data limitation without
> requiring the full 128-byte sa_data of struct sockaddr_storage. This
> allows the network APIs to pass around a pointer to an object that
> isn't lying to the compiler about how big it is, but must be accompanied
> by its actual size as an additional parameter.
> 
> It's possible we may way to migrate to including the size with the
> struct in the future, e.g.:
> 
> struct sockaddr_unspec {
> 	u16 sa_data_len;
> 	u16 sa_family;
> 	u8  sa_data[] __counted_by(sa_data_len);
> };

Side note: sockaddr_unspec is possibly not the optimal name, as
AF_UNSPEC has a specific meaning/semantic.

Name-wise, I think 'sockaddr_sized' would be better, but I agree with
David the struct may cause unaligned access problems.

/P


