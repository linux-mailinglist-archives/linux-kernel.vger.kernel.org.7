Return-Path: <linux-kernel+bounces-888787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D679C3BE95
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5153A8EFA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDDC345CAC;
	Thu,  6 Nov 2025 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwNuRB+E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYUakjPF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97E345729
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440797; cv=none; b=lDhKgeX5l9cAFuzgdCvk6qx42yvQWKVUqiOY2NbjcmYHNTmqKofcRCXeTErx258Yupn+N0iX0W+DqQv86fECe3VPa3e1Ta9or0FmYNaO504NPV7SXqCTCgtu0mJluUTJ7MHon/kNrQK7ub89Wt4E3BnTswZZ9v6Jvk4VgEVKJVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440797; c=relaxed/simple;
	bh=0Bi4LHwQ3Oz1+CJ2dXX3nYlqYoDS15IyYtJpQGkCX9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XiphximCFHngAkKAVlTlCYBRKEOGEu7jqw65xeTGAW+QggnspebuRO9bYxj4CjTqsbagNV63A5ee+IssQfgjSGOtdUecIkLV59aA1Nq89lyZLgO8mz5XEDNJ7/cqhbZ9kZEmSEz8rsZM0r0dS4q9ZY4YHmTPVhd62Q4TrIdZuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwNuRB+E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYUakjPF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762440794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoyCQ2/Ndn55B6FLT+akNdN3gz83tHokFqTe1vC7y18=;
	b=AwNuRB+EUp0JlXQ4pZkJfHi6OyhRYaIvgPgf901Cq0oGNe1iUBQIw77DmVx4muzjvvaHFe
	tUsQ8e/93fdTmXBpZrcZdGZK/l3Bi3ZEa1oGqd1kM34i+z9XeikQSSD4HUT4wcSfoLFTRE
	Vi00vBuflO45v7e8B6hKslLxxofJD74=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-0uIPxhSQPz2v9wYKNeBkOw-1; Thu, 06 Nov 2025 09:53:13 -0500
X-MC-Unique: 0uIPxhSQPz2v9wYKNeBkOw-1
X-Mimecast-MFC-AGG-ID: 0uIPxhSQPz2v9wYKNeBkOw_1762440792
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so668761f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762440792; x=1763045592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoyCQ2/Ndn55B6FLT+akNdN3gz83tHokFqTe1vC7y18=;
        b=RYUakjPFBI1nQ6ByJIzNvlePbCJqTmoLqWb7LSgbpmqjTaiLZjm2ODi+vkKuZFaxQF
         tcSj9lqHgLHryg3k3gngUnIA6/KoyUKAiHdh9sBIS1OaCHaljiidS4oGDa/3Sy8uPBFT
         xumpfatHv1vLrt0iERFlnOrt0a+GslFR5a+N6owhFDN0pytct6kpwceJci9ruD/bXetd
         CAmCKK+PvwDcTDPhE+h32qUYk9GHJU4eDVsWHjCzKsEC8dEphFc0INFpajZD4bWm78fW
         lmJSBhdOaDtMIycqhYAQE6akAgaoNQvI2OKrKBB95qllMWmK8tYyRMftjzTqBQLL9fTj
         uXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440792; x=1763045592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoyCQ2/Ndn55B6FLT+akNdN3gz83tHokFqTe1vC7y18=;
        b=xSUbHS+IAmhlVM7w8gug1mF4Fb1Gw4Eafmr7zS6qB35GBnH5eQe7GMH2OyyFjulv8B
         G0OEOlAFKOne9IHRUSiExLi2P8/fn/2CSia63rWss0AAe+8W4Fta4ItjrTjr++1AFlj2
         mPUrIFFsTErPzWEMC5pwglM3EwjxkzN0evCvifzrqtUHkvjiU7lNNDgnHA50TIPCb3Rl
         GJ+D5OrrpZKKHAIc8zZ+3ZkKQnJ/ai8ObEp3efY8iR1LNpqG0ToMMLZ9zi05uqKX1Z8p
         Mg6dBY1ddhXBJzMhWpzP8iMd+FNcN7j6gpp32KIKBg/69fc5vRu4uVN9MTRSdQftJAVJ
         YwlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXucJPOSrCub5dZQVMg0y9QWVK4GWcvw2evsu1/sCzoBWj0hOSCLwwGuS/ahiNTenSt32HlTAC5qcSHojQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9F1cy/13JOWixV9sfGkMTvWdhVT2wStfK0wkUH6IGuU8WJYk
	GRO84rRkZnIm8CTX/TFadX9UdLMx7KD9JIi73MxDcY3ObTUhk8XXKb8+ZDDsYyTkW3tDw5kqaHc
	d+UFa+ft4i34V96wfcXbCD/Uato3i8DbjQUWeHdukkbn4jd3hsQQa7VRTCdt8ExD/jQ==
X-Gm-Gg: ASbGncvWuU0ciVoe9Q+BZJJ47xQ1utPjiY8xlpSMDdYr1QmmSAbxL0SGZgSnl1xsR/y
	IKWNAkkjHXtOTBmXELe/ODnqNOOycoIjQRipCA8ZrZCdjJMMULk4WqZDWiF2imGUvgP0cjAGWwv
	UJlGWT849W3YazbutpIgPDmPp9j/NGnZNvsSAPbYBj4wJdWZuuiSr37IR+OuQhacUx7Fu1v0Tcy
	0JJKV9QLZRmnyaiCCdB2xT4qq5fuKgFUfNSiJ9aev346DN0IS9uY4iPOjxTy7AkWn1TpwkgSI3Q
	PWOzMT6/FNOhC1k8zUChPjSknvU56mok9ChtxAe5xo7ypE0K+P3Mf0i7P902NrQ18jzFTBqMqsv
	NAw==
X-Received: by 2002:a5d:5f56:0:b0:429:bac1:c7f5 with SMTP id ffacd0b85a97d-429e330aae1mr6387403f8f.44.1762440792105;
        Thu, 06 Nov 2025 06:53:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK5t7Fq6Zv4jWk7ndZnINKEE6SRIPfe793yxVRVTG7XMWpFYrBjzrI+ymWB1vQzl2d9MBt0g==
X-Received: by 2002:a5d:5f56:0:b0:429:bac1:c7f5 with SMTP id ffacd0b85a97d-429e330aae1mr6387380f8f.44.1762440791658;
        Thu, 06 Nov 2025 06:53:11 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm5566783f8f.17.2025.11.06.06.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:53:11 -0800 (PST)
Message-ID: <8d9c37d0-b238-4778-b18c-473bddd6481c@redhat.com>
Date: Thu, 6 Nov 2025 15:53:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: net: local_termination: Wait for interfaces to
 come up
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
References: <20251104061723.483301-1-alexander.sverdlin@siemens.com>
 <20251105213137.2knkuovcc3jpnhqv@skbuf>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251105213137.2knkuovcc3jpnhqv@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 10:31 PM, Vladimir Oltean wrote:
> Functionally I have nothing against this change.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Two ideas to minimize the delta in a more obviously correct way.
> They can perhaps be implemented together, independently of one another,
> or not at all:
> 
> - setup_wait() could be used directly, as it waits for $NUM_NETIFS, aka
>   $h1 and $h2.
> - There is no case where run_test() does not need a prior setup_wait()
>   call, so it can just as well be placed as the first thing of that
>   function.

I think both suggestions make a lot of sense, @Alexander: please send
and updated version including them. You can retain Vladimir's RB tag.

Thanks,

Paolo


