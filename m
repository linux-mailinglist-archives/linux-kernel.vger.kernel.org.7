Return-Path: <linux-kernel+bounces-846944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D013BC97AF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D73DC35317B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CFF2EA73D;
	Thu,  9 Oct 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjrV6+yZ"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E612E9726
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019678; cv=none; b=RUIxRzyC2bdx8RfkQN5TbkH6vtT6Snvud7Xx27anUziAu0Xap8mYvFmDxNUp9CdDVUTBdUrMxQD3PVpq54NqLGg5J9SIFjRWxeYz/HXzMsMucwFVdd4Xve9eSn3Z/g0UntQdCSJDZF0IJhUpuJiZtv8x2HJKj/jZHbQydo98xx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019678; c=relaxed/simple;
	bh=hnQ43mlshaBsbrJ9WaCsfGbLahodDXpvt7Tbh9YbALw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WswX4PaP00oIVpRD8j2iHVFRYzN6CCdWXxBp3ImqfJ9+hbfbAJ0EVBXAqPaL/5ufwXIBy4sRwSHrllCRBthEPQcvySoao7Q7HNcA+Y/zmhC0ImtXM/VE4VGtoY5kTjkgGfzK16w8eZkXXvu4wUWGZsXaktBtK5NRmT7XpCstTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjrV6+yZ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-780fe73e339so5183127b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760019676; x=1760624476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnQ43mlshaBsbrJ9WaCsfGbLahodDXpvt7Tbh9YbALw=;
        b=mjrV6+yZhrWbga7FoeFg9w2MGW+rJzOnqhXIPT0fm7q5FpGS7K8cYSlrOpm/Ewf7lH
         KNCFRLRYbRUvwPJgwM0+EOWBEeNbvgW4ABpAyH+2MSZTkZzT+eWXynBnCy9Ka7R9juy4
         dxBkUHrDR65mj66xWU6CXLRqBILr3A4KAPs9eonf2weWiVh0qMvEWsS2JjN2f1iviHHY
         5bbqzRlJggEYc/BMsq5M5fw0IeDJ1m6/dFKpDq4gxZ6iT3WqZQ6+PkJOocaoOft3S/uN
         PBw1z2ZOX8hVndHrW9cwSVSpfiJnZN7ZSksCNoMScoxYIJCS39DPHk1LLClKEYnt5TX5
         lD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760019676; x=1760624476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnQ43mlshaBsbrJ9WaCsfGbLahodDXpvt7Tbh9YbALw=;
        b=lg1Dl2+/Ge4mgSN/8qajH/FMbl4NZP4y0qoZHSeRtCLZuv6Fc5kvEpQIo+FZPjBaTa
         wjVH4j62I8ggwW7Al1TlDrohxdNznilfv0jdwGnnbnNNmlG/RliiLrHduMMLldV5glC7
         cZgMbBFwIq6+wG4hThLwP2QRvFnUyNgupFJaFctlbrork7h3n6Wf61jEbNi/Z1ncgDBh
         Plgx00LLYUEKRajpgUqmTn08SHLhYGXWW13vIqNiWL2xQkv3JfiSbpq0LPvYSANvAFUn
         E4Yf/282yi9KrDwosyohPyf1U/Rufk6HHnk3wJIyMxLDeEh5ZiWVYKPNBq2mNXoLTCku
         6dZw==
X-Forwarded-Encrypted: i=1; AJvYcCVStGd5BZlCjiovPPlWtL2rqU3LGWVhCfG91SSBbuq2ZoSLoRfe7C/R3kqLzIHUlP5AFSOKJzIol9fEaYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxwplIdFvEtv5w4wzaKlkFBTItmr3X1uxYPY5dU2Tp9B2lRBP
	UvsiOJlVGfHnzCyTQh71kvvBUWr2OnE6GHU+Xhc1T0+fZlpVlNT2vwYV
X-Gm-Gg: ASbGnctAqLTLYQvaAuxICoLPjZF6u0fRTBcpOQuqnucwTk6WY3dUUwM6HZUHN64/TVq
	9VyG5uEFiUhQf1E0Cqsws9WFrbdLPMTqHm0yQwOpBC6U2NqF6K+yi8a7QsxqWrDRceW1GYuCcLR
	aBDyyd2htW75Z1XZTQkyu1f6HpOUvlQ8JAs0s+c6NWKUYaTDp6tVSI4CeExedvYL8XRyRQq7Nev
	H418oWQsCJ21kiFEDo4Jo8zMRbQTC6h7C1u1xxhk+ylEW87e/P9A0sOpZfLJxr0QJJ8/EyLJo9Q
	+gyqwNTQSOfvMny1AD7lzqp+ewMNpUZppDYmpOWfkjoHQvu3NMugdmek2M39TBK3pzbohtVf/gy
	WtZPVpG4/AYHGnrU6QuNVansvEc85CC4gsyI5kGKY8sa1pKicptnKuxKrxiJ4bd9fJO9oguJ2B3
	48YSZUmEoUmTUmCsiy/lcNPh0V/oGV7pD3
X-Google-Smtp-Source: AGHT+IGzX6tbZi0SUPeUfevUi8dyQ6CO14lnhiXYQ9QISYSYIOi8LIwUJKcnCAIMieqG5lf7wh/wgw==
X-Received: by 2002:a05:690c:1e:b0:71e:7a40:7efb with SMTP id 00721157ae682-780d21c1a8fmr154320987b3.11.1760019675301;
        Thu, 09 Oct 2025 07:21:15 -0700 (PDT)
Received: from ?IPV6:2603:3020:2605:c100:7869:56ea:c12e:3c81? ([2603:3020:2605:c100:7869:56ea:c12e:3c81])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-781016bba20sm1629907b3.24.2025.10.09.07.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 07:21:14 -0700 (PDT)
Message-ID: <dc942235-bf65-4841-bc1c-b3c66b39498a@gmail.com>
Date: Thu, 9 Oct 2025 10:21:14 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix: ext4: add sanity check for inode inline write range
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>
References: <20251007234221.28643-2-eraykrdg1@gmail.com>
 <20251008123418.GK386127@mit.edu>
 <CAHxJ8O_HF9cy5mg-W77M02E=WHrMsSOTmyxZYogUut3jJgEyFQ@mail.gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <CAHxJ8O_HF9cy5mg-W77M02E=WHrMsSOTmyxZYogUut3jJgEyFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/8/25 09:40, Ahmet Eray Karadag wrote:
> I’ll review things more carefully before sending any follow-ups.

Hey,

I wanted to make some suggestions for you to do before sending a patch.
I recommend using tools like ftrace and the old classic printf
statements to verify that the code is doing what you are saying that the
code is doing.

If you are having trouble with the less intrusive tools, you can use
kgdb to verify your own code does what is expected, but do not use it as
a final verification because it is too intrusive and changes overall
kernel behavior.

Let me know if you are having any problems or need help with something.

Thanks,
David Hunter

