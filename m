Return-Path: <linux-kernel+bounces-866769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFD5C0099C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128EC3AE735
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD449309F1D;
	Thu, 23 Oct 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyrqyOl0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2930B512
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217208; cv=none; b=CmPvEuOajHf/pO4wZYBwaxO+pNMSfWmbOZdiq8KVlFdWWWDhdMQdV2tQaePBLIXmzQ2FEUOiKWxoxeJAZA3HTfjKl8Uc2uW2eD92LyChF2wU6USTTUBRavaSNpElsu4ScN5KJyuYcs45SnlCsGOQx/bEZRCt7gJOmYOozhE33HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217208; c=relaxed/simple;
	bh=C1Pp292wr9u8EzQo5FGAynEK1LI49VCDkvagkZiSjy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loQKTIDbrPpMQs5iuxNlM1wOadhIyFc4t3tgu7FPoyVxKUzoEdxrEsAGl2x41elmypeRD9j/IbUl/IOdgZurfeucYtJQeAmeqTUSrp2Q1P0GdbQtZxhCmoYsf0aAh+aC2tbRli4EUEg/vB1ElQGrARN80I68cBLOKmfCFd27T9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZyrqyOl0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761217205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tbe/B1o/HvtDs6xz/RlrYs8WR4yY3Q1mvgAb2M+S7k=;
	b=ZyrqyOl0Kr0JKbwSxyz/EZehlWBl3lJDZvBQZP0Vn9a25U/jpDNKGd28nGKM9eDsDD6JnR
	UCe5PgoGsFwRrrNV37beeZaqHTXi4NK9fdEJZkGJPmCWyHWfMx4eQVhgKXaB27D7gCWUOR
	fmJ4fPZzFxajwIY9MR84jLnSGeSxqU8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-ReEywFUxNT2_jrwbBINB6A-1; Thu, 23 Oct 2025 07:00:03 -0400
X-MC-Unique: ReEywFUxNT2_jrwbBINB6A-1
X-Mimecast-MFC-AGG-ID: ReEywFUxNT2_jrwbBINB6A_1761217203
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471168953bdso5471195e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217202; x=1761822002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tbe/B1o/HvtDs6xz/RlrYs8WR4yY3Q1mvgAb2M+S7k=;
        b=aP+kqLAD1w7Tdx4flaIhP2XnxEmNBZsvA3en5ZaWoTy9+jwXwA3tc5RpGY7xKyoDnK
         v6JiS87mWepjflQNzaX9mDEK+ocPmFabj2l8aA3SUZQDqSoHPKIf7WvhoNeUk+/Hpwoq
         qI37PdW+nS7joAT6ZtB3K3w/1+l+88LsDQEkyTW9xj2gwiySkkbxaMzegL90n2m0gHva
         P0G64LCL0LGmP4flADDwmccBQWBVQ9pvcOwqpIxACrz6qdXi7x5MIUnKhpXNgK9J9gE5
         tTSHiTBu5S/iEHlnP1Z5lI/olU/IeKv+bCoKjtx13kOROHhQ16jj0kAndAqJE1hAzMvS
         +L0A==
X-Forwarded-Encrypted: i=1; AJvYcCVBuCfmWObykgTaIlGr5YfKBFckmoR61PXVBYVwcNcS+wfubhKVhfuITwJpO/kZc0ALPj8OgjXmLn7r1NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOEcaFd84dHPZto0r0Wg/d5jR83guaKrD7EjzuMRJKIgETuXm
	cWrStYifvkWCMwZamufRMjsVn5cuOq3bUKrm/8tKILS9fZ/OVTxDnr35hiSbavZZaBL2B/yo5WG
	jTKlD7y/PvfQZMccHJSCMhAyR07nz/ax510CuVHKMi6sHWfK3VUiB2eXZxNPjz5Vr14eKCKsTjg
	==
X-Gm-Gg: ASbGncuA+8TNNQKKkePQUiMtZgcYc0LkSlrAf/PSljmTnli9IN84PJRY0mCUKlLqD3O
	MdU8C+MZJ/V/Z+iwcZqiGGuWamLAg7Jin0UTO3Wsv6B16Cg8vz64eEPkBPX+yHJpJYCEs7tUuWM
	tJ7di1y/55VFmFSRP8ce2l6N1bx3UTsquRIMfGTpPev/o5rqfDEK8PB6DEORzipXRfqFAIAemfT
	7GnMVaS2GxaNhO8OWLU6qVwKvzPWS8Fbr8W3wgzgAnDw7/aGLLGpqhYaInwWUxYJseJVZLnPC05
	edOhsXQcomwDU6LX2bLBNCEmI7un1RcHfi/oAbRnWCZHAYxvAYe0m/kw59gZHnXx8xkmF1dCTsa
	wiAbMdbzp72odG8K4P6fXYM8cqaCQ28R/q3tT+P/01RdDMD8=
X-Received: by 2002:a05:600c:5803:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-475c6f202e9mr30330315e9.8.1761217202291;
        Thu, 23 Oct 2025 04:00:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWVkcD6BOYZ24anCxqkCdENWyVIeDStBshfMtRIpeohF2t+fEegH7komx/yFzU5BEDs7jhjg==
X-Received: by 2002:a05:600c:5803:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-475c6f202e9mr30330125e9.8.1761217201896;
        Thu, 23 Oct 2025 04:00:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898acc6esm3288915f8f.25.2025.10.23.04.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:00:01 -0700 (PDT)
Message-ID: <980907a1-255d-4aa4-ad49-0fba79fe8edc@redhat.com>
Date: Thu, 23 Oct 2025 12:59:59 +0200
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
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Another side note: please include the 'net-next' subj prefix in next
submissions, otherwise patchwork could be fouled, and the patches will
not be picked by our CI - I guess we need all the possible testing done
here ;)

/P


