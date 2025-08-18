Return-Path: <linux-kernel+bounces-774046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F07BB2ADF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9357B18A49A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3CC33EB19;
	Mon, 18 Aug 2025 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AlGKkveX"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3366265609
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533923; cv=none; b=VqCcZyd7R0SP46S2j5tCaVUsQPku7eg8jyneO8ZjemcfBEjWqNSz9bfDNYeLp4aG2t9Stv+neuqqGU5uFLaZwKE7COjLZxl6wB+TKWKIyjOCXaOMaxXnN+CtqLlcajVedoCxrB+o/QdwsEi5lgW7V01a3RB2nmu7sDmXX4rHxyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533923; c=relaxed/simple;
	bh=//aetfv37YKeJVqbXw3YpPmhG6DNYA5e4H+UE5ZUcL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PzoYhqqA3sCNTY/VFGUG9AkiKh/tzCs9Dva8cWaSbXecmxw2lcYfY/LgAUNr1Lti37QnrTa+/GBAO11dEfc/tFn2Pa0KcR4pGQmKN09moQfqy65BNBXsu2lTb4vBhwaHfqR/VKmhTLd3N01hyhNzcyY+Fnu9CNGcIBFV5qQG0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AlGKkveX; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74381ff87fdso2456712a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755533919; x=1756138719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cT+WAuja39VMqOvtGfWBOHLuy+NZyDAiBTg1604nP00=;
        b=AlGKkveX+R98nhjJcwiuRfRbR2KQs2ZOIYNwi/RjlN1GB8CGsYaV1bP2uGsmJIf+cF
         0hCDs+nWJ1DYzcWqALjxXFR2BM+e9tl1Ho4LYeHgJ2F1T02wNCC35JfHHBiETsGi0Aiy
         KzFsjFzTz253YSDRXnFfc7JQdv6RlNjN0quehfa139DY+ztmvcjcYOFR8R1+RAseB4/l
         C71UmLeiy9f4llWYGCJ6Oq0/vziUZJBVeUrm5G23qHn7RL3jFzd59k18u71Ans0nYLJY
         nvOKhNAcMNeOAoPBEqzWz9Kfo7s3U2WO0qfPuvBm7Es/uJb7R1eUfKjyq9isyxbFZPwV
         +1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755533919; x=1756138719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cT+WAuja39VMqOvtGfWBOHLuy+NZyDAiBTg1604nP00=;
        b=nv+oRv0VNeBu+5Ti+W6XXTMWTSUrlbzgZIEdlcsqsjcW8LKR+NFbEzhOWClyIS6hH6
         9Zv0DllrUEBK0qgtmGRmxqmetST5GAuEUdSFny0Y9qYK1jaVZsY6ve5NDe91hB7v8K02
         fKE10xTOQ9SAdNKihxcxuSvHTLupFRua7JqC1MTEIGjuTjtjMDX9xNzC/Ty0cnEqDWuQ
         MPBrB8hwKrpV/UNXBo3wfsYJncKcmzYF9EHPwQgCHzYjaJOdwvpx87O28Pfy/JuRm9/j
         T2dVNKDy/yXZ/HUlvA1KKcMhZu0beCgD50G5Uko8rpm+4tdoXTlOx2hS53MNo226bL5h
         nSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIqrd0LrViZjgEJfmcTdFM+n3/ChoCxtGidMwp78h7yM/SPFTabi9ZvNaq8svx3Q5iqPCRbhmQno0x+Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4tjCIeq3MXseCL4O59YYkS0HZP3oyI1+Go/O5TZ7uL5g8VnU
	kuG/VHSFjG5SWAg2lwW3DoeNfhG5pV4CraOv+NRE4LubGMnioJEgc20VgksZYHGEzSqCQHu4f2X
	UcBi4
X-Gm-Gg: ASbGnctniaL7iOrWCbLPTLZQeOJ2L31lff32S1deD7fFmfwVrUWC9jRghHzI3fUAuDe
	Jhi0K5m2nec4IpjvmNxRRvrU+wLv4GRnJi44XQIFTCL2DfAxrumNYbrJhME04BVLeIkQ1dvCtZ0
	9yVNAxFeZ70VneB+Lnw1WGyQaZRJa6kpGjLmaNanAIkylVFzErQxWrNeW+td7ELJZaMM7yOy/Lf
	bjqf93R6EOb3L+DnRmFJ9SDrANbir12YzEPFc6+F81DotDjRsc5lRRlgWpkn+U/01loIyz9uVzO
	HDy66Jo6XaOyLMQ4IbO49Ql0gIHRE4PSIpZCRkLzvhD8OBodOz0ODTvubqlbwf9VN0MYCxezRdC
	6Kg7mQgPYAOOzP9g9GtfXcFLFRnWMjg==
X-Google-Smtp-Source: AGHT+IFuPGXBI7xR6Jyo6KTbZ4Vmpd5eT1fuogNq810C8ExVtbCRFbryYTNLHnDSuJGq05eb/xsFaw==
X-Received: by 2002:a05:6830:64ca:b0:741:c51c:9e3 with SMTP id 46e09a7af769-7439248d317mr7976713a34.23.1755533918717;
        Mon, 18 Aug 2025 09:18:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c947e387bsm2602740173.37.2025.08.18.09.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 09:18:38 -0700 (PDT)
Message-ID: <7ed32e97-055a-408d-8c14-1c80c64bfb17@kernel.dk>
Date: Mon, 18 Aug 2025 10:18:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] loop: Rename and merge get_size/get_loop_size to
 lo_calculate_size
To: Rajeev Mishra <rajeevm@hpe.com>, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250814191004.60340-1-rajeevm@hpe.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250814191004.60340-1-rajeevm@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 1:10 PM, Rajeev Mishra wrote:
> - Renamed get_size to lo_calculate_size.
> - Merged get_size and get_loop_size logic into lo_calculate_size.
> - Updated all callers to use lo_calculate_size.
> - Added header to lo_calculate_size.

Please write a proper commit message, rather than these itemized
lists. Goes for both patches.

-- 
Jens Axboe


