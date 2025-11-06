Return-Path: <linux-kernel+bounces-888044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 456EFC39AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D33E4F7C4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594383093AE;
	Thu,  6 Nov 2025 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="esRVAz9Y"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED16E3090D4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419138; cv=none; b=elt+Bplo+QyBFY3EXK9KN68jka4SMLlXCEqel/XUAcrNLkINqTfFd1W6WRVA7EBUcIe00rgsjMZM+g/HZba2MDq5yiczLi3Z1QAondRjOgUCtH/HmpCNffvW654R26OQKax0Ad4ajJQYTyx9pFt2EDp9qgBd4jA5OhQ0GLD3h2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419138; c=relaxed/simple;
	bh=uZWUHAju2MgIXw9KZYZtVjROBBtGB95ey+E8B9tXjfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqP0Gg/qWpvXx3TsN4MZewmWkTom30W5u80mwzyMCr/vO6W9ZEJGOwCBn6z2MyDDdL60bkcUWYoorKSC1DG8zEVJswQZ2A/toaZ/MN/CcOYJuZhGQfngwB2GIoiGTW9LctT+SPiNgLlZPVoJUDwohNT/f1TJszC1DEYRbrEQ0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=esRVAz9Y; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4298b865f84so337407f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762419135; x=1763023935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYov8Dro2WY5QRaXiqC8LkQqfmaaDXZFDPXwFxciwfo=;
        b=esRVAz9Yygt3hCuqZcxTgYQDNVH6rKsFXX/4Qdu3oBhnLt2qzJ+mSipYUGcLYg96O3
         8uvzXBlsvQCMvhD5Ld7pw5FxjXpmOdgC7TcgAeywG6sE+OloGd7nmuTdzPcUYrRuBmlW
         vtd9IBArDUsG/hN2uL1WoUmzRVETiKq5jfKW3yW4kzHed9AqSpoWQ3R44gZ7PJXVq1ER
         3U7T98Vo5pt4Ify0M8ja8o/LPdROBqF0i3UyHuva97V0lDQAIUEeXYiiNNQ8mz85rXaE
         QSCb494oJZIVwv9z0sGV4fR1SJf5F/OuHxuiJTAcHHpyKKn3NPiGTswpLIC9OfN8+eFf
         ESOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419135; x=1763023935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYov8Dro2WY5QRaXiqC8LkQqfmaaDXZFDPXwFxciwfo=;
        b=vn8m/whtIsmAiNXcxqixLR8GDuxetpgNCMNz7/whgaDn9DXsb7J05UW6NLKUfgTMeW
         hgFtK36YEjGamSoL4h0IVjKFOednHQzZEIlum1VFy0rScnVV00p7+Zw7ZURaNZkjOrI4
         I2tWa1y+FjX6oK2gnhXFBi+finWYLsmGP3kicCH1GU6/tZcTqnqoMk3Jz/9+kQZaIYtn
         wJ0z7BiGzR/1M7wrXSjGLLs1nhF+aXdPtIuJe8djqsRpqrUldCfMAmdxIwCp9p4MkeOU
         qdZYFQTNPYGemJ9KIBju4Z0EkrZN9PRYHsT7W/IaAu9Jh8WW5xqtrpFyzonoMFz8ik3R
         D5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCV8aLWW3/9QRmOTh8wxUGK0oRr7CLeSdTrLkvDpWDrNZ1xBkJUjLWb+3NhzjFVpXSXbh2ITiKttzBVeIEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5XZISKpG3X6Q9thh7iQ4JxeY8s6FXs+7DMzNObia4Y8HCEfm/
	LwljuVc1eZT8JmRuYtyh3cpa0nfw54DVMjsSbyGWOrYGvKpHL//z8Te+qkRXnq4dx0k=
X-Gm-Gg: ASbGnctONsvjnGgjZF4K5m4WvND3aUy08ukQlfiJ2JH4ceW8W5gkmJqVdYDcTV/atIs
	H6qXgKvP05gLt4TP13Oqy1ie+kLU4njIYUunYX9kLfa5fRPl7VQFFTrkg/kJbPtSRgnMVWO0ETF
	i2HSwzBet4gAQhvfT+/+G2M5fGc9/iXdPtmUEerDZDO3TKd22ikOIknmcu7EBkJW6Nkaidgj1Wh
	RTKwCQ54TRKUAY6OOv/8MOVQrHeYlDdYnh8sAaiAAPTCSoPPr60cilxvnC6JqBhiYynXsZUhrv9
	UopanVcMOntE9EtFnuG/j2lBbClLOwlHvbxVpbNLJIcFjBK9o4fp8bhTWQUwm78fqA5QHQeE32M
	1aHXBed5MFd4wZQYFoFpTV3lVOuLTCS/7Zps+I1Sz8dpp5pn8z6TIqIe2zkGjCQ/oYQPInVjSdJ
	jpN6SihQUdu0EAZ3FJiMEGolu8FOBJqa8EO8eu5hUG9zk=
X-Google-Smtp-Source: AGHT+IE4MYS5Wr19GhmhPW/lBh+nmvHM2VktPve27rlVGZM2YL1NCWMjNGClTXGoBm0OuhF858f5xQ==
X-Received: by 2002:a05:6000:22ca:b0:429:d4e1:cbb5 with SMTP id ffacd0b85a97d-429e32c4b31mr4414987f8f.8.1762419135296;
        Thu, 06 Nov 2025 00:52:15 -0800 (PST)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4771cfsm3584100f8f.30.2025.11.06.00.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 00:52:14 -0800 (PST)
Message-ID: <1b7d3311-764f-4e73-94ca-74dd508d1113@suse.com>
Date: Thu, 6 Nov 2025 09:52:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] module: Add helper function for reading
 module_buildid()
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov
 <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-2-pmladek@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251105142319.1139183-2-pmladek@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 3:23 PM, Petr Mladek wrote:
> Add a helper function for reading the optional "build_id" member
> of struct module. It is going to be used also in
> ftrace_mod_address_lookup().
> 
> Use "#ifdef" instead of "#if IS_ENABLED()" to match the declaration
> of the optional field in struct module.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

