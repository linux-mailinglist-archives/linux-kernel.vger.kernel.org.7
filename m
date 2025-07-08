Return-Path: <linux-kernel+bounces-721678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5702AFCC5D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C8D4A4B6B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806857E107;
	Tue,  8 Jul 2025 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jhnn+m+r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DAB1F949
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982170; cv=none; b=qPGDDzqrYNGVou7FytXeCNnH/tM6wV4slll5I1J4tEa02PKm6OTS1qUftNiu0w6YQbCGkgGHd95Md/hbbVT0ysHQiS4nn1unT9jNhZaPzty+X18TSLVzgvIu+DmQJ6RvfeaFyxvaQmCdkh6OfgacRqhUphqp1szH1shmwRdDlLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982170; c=relaxed/simple;
	bh=7IMZwdtT4ONplTSo8XHJ6xX4Q4sptOL8v2V3UkoQjlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GStaOtI1QEBVHhMPfzEH/Vu79J8bKQDiXz7uM/hl6mLQhsihKHzP9kKoXP6MmISoof41/QqLAzq6WDcrC0i+IiTO7DeHrqqrgY/hNQQg/ztJw8+kxPGHR/zOQ3Noa92ZKg5DJoBdRNrlmM55lHdTL8ZNQ2xLs3clSuBv634fJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jhnn+m+r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751982168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P27oZItgQlQTIEu6BrjTyR+ZcNfbW2DcDgBZkxGIz3s=;
	b=Jhnn+m+rB4AJKJI5UIJBdaO+Kri5gGwwhvqJ5SscR9pyX62KCF6cNenWWv5MGvOlZFUQuw
	qM95NGKyklTUgGDj76uRhGKN/2u/8eHkqRFowWVY3IaKDjvraMXxE4hm/qRX/DgV1C30t+
	9N3BdNLj5RUXsww1E18K8I7pCXB57zk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-Bp_YCgP4M8KEueQZ9aq_aQ-1; Tue, 08 Jul 2025 09:42:42 -0400
X-MC-Unique: Bp_YCgP4M8KEueQZ9aq_aQ-1
X-Mimecast-MFC-AGG-ID: Bp_YCgP4M8KEueQZ9aq_aQ_1751982161
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4539b44e7b1so27640295e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 06:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982161; x=1752586961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P27oZItgQlQTIEu6BrjTyR+ZcNfbW2DcDgBZkxGIz3s=;
        b=pHVhSg0zHYjwJrqOO1Jfb7VcGditbJ6fKloV8uZlOQBGq+xjUmi/k9O5YRlllMvl9m
         YTrIO5UDF5vtDL5AnzE7Fy+o2do+wBWOMKMHYu/MO3qr2h8bI/zbpYx7cNdQmuwH8Zcw
         OEitzoxE2lLmikKJP4xTzLHdttl2E+Wlt2D+69NIZXzdNAGszp3TSrmdptvT4nxsHC47
         PxySQeXc9LfeQWGwNWs2xDxZe64rgOQsje41lQH6jXgnwrdba77w7xqnhVGhcJ9Zgojb
         yHGYrJlA4oLU+N+cm6CUBexVcCx59ogkD4PCGQL90eSA6ylNUs8gTc1XuF27/BgB1aiI
         5YrA==
X-Gm-Message-State: AOJu0YwnQgcl+nlleYQYXCeUTMUpolQVOsxaX3kMwdhiprmvcppszMdu
	czV5yRyFBsQ/i+vGCDyyTePiHciJ+NYabzHl1EFhrxcasDSHbrz274hkAxPeHpTT+h/2LLJGtlA
	X18PP9QcXJ2ggKYaGgsAYeuNLNeme6LJIZ5gWpZ3Un42ctwXmOGt1QtlBxkTwkreLpw==
X-Gm-Gg: ASbGncv83YVeYXmleSJMrsJQ4wbvFSob9W5tp4YEVdfA6YeJqUVb81ROCdm8eNQtA0W
	P/XkSAreZN1oyz9oVyQHSo7wm8k3wIK+dc4W5cYJuP9Jpr0V5RzRO8xokzoRNwaRLgTpy23qlvC
	XDuMv2WlXVJwmNwPjWCENAyVilZIvu8Mmsb3oK3eM6gZ/ml2ecqmYP1ob4HFNLLIJS8EJ4PdOT3
	u+S5FV+z4iDtFzctTFkswJLu8QM3bPb7j71St6kfZXaMXOWME/0jTuHf9+MkM3wP2fEzUc15nPw
	DIhwP77ZsNPvqW/jJ+erOi8q6oaGMJ4U6lwy+eVXRn+5ztgKWS1RF23wAbwLzR8k93BDMw==
X-Received: by 2002:a05:600c:154c:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-454b4eacc98mr145947495e9.8.1751982160579;
        Tue, 08 Jul 2025 06:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwFsHBVEro5CvXOCFzVmkJDQs/mNrwHrnzu4qHxJ8LIqAIs4YS5XK8sVi8hyjhO6N8NrfG4w==
X-Received: by 2002:a05:600c:154c:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-454b4eacc98mr145947095e9.8.1751982159842;
        Tue, 08 Jul 2025 06:42:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0b9bsm13204192f8f.30.2025.07.08.06.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:42:39 -0700 (PDT)
Message-ID: <b610c003-5c8b-4fef-8fea-a2b40f8d1377@redhat.com>
Date: Tue, 8 Jul 2025 15:42:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/3] selftests: drv-net: add helper/wrapper
 for bpftrace
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org,
 kernel-team@meta.com
References: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
 <20250702-netpoll_test-v4-1-cec227e85639@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250702-netpoll_test-v4-1-cec227e85639@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 1:21 PM, Breno Leitao wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> bpftrace is very useful for low level driver testing. perf or trace-cmd
> would also do for collecting data from tracepoints, but they require
> much more post-processing.
> 
> Add a wrapper for running bpftrace and sanitizing its output.
> bpftrace has JSON output, which is great, but it prints loose objects
> and in a slightly inconvenient format. We have to read the objects
> line by line, and while at it return them indexed by the map name.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Does not apply cleanly anymore. Please rebase and repost, thanks!

/P


