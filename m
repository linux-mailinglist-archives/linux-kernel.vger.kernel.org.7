Return-Path: <linux-kernel+bounces-887157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39431C376A1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21ABD4EDA86
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A3320A00;
	Wed,  5 Nov 2025 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dReMjxuq"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7FC2C08DA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369447; cv=none; b=mniKIRYEQSSEK0WlmcxgiMSbFgGtJU7PQOVlslMf3En/vcZJEOdHR3BR+bNI3w5ZMA+1hMir2O3Zk5GLIT66O5vCeEywDEs2OE9UaGPgdXwla6E5oWBQp2ybPMyP/MTf5iRdcsBWtR4n3in2VuT3vmvXDYewhRDfwuudB5gZ/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369447; c=relaxed/simple;
	bh=u9rmZpBvMezDctwJo0rwiGqkxhnz+tnImP6t7UnhM5g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=shvQYNBq72qwfKgwNydN6u3mJGHEk4DrCqwAZHxkBEWjtoq2CXULJdsT8w5yv7k1r0kCne3tpqFJheH//jft7Jvig46ITK2+5Re7GWyD6PHTRGhg0glsBDEuy0HNqR6qj8c+z26lb7ZBfcBPrleOEAS8y65dHgUtEVacbmgV5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dReMjxuq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aad4823079so242866b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369443; x=1762974243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0oPPPAsw+FYjV2RdYT3vlBD7M9XMtEjJDNDkXAtf5Q=;
        b=dReMjxuqwi2fKal28sgt4yZ5cC4zL1DPMlulHWT1eJKO5fbctVYwPV4GJFFKY/jR0L
         C1OQgrxUrVqnJtu74VOhbYkPU5GlhfOn+gZWcNhtUxD1Dg08LumPBht6HfGAjqK50ZIx
         r527T0BRTwuW37fWJ7GNTs8JQ1mMmdecf5+9TKp9CcFgifLCiig0NaX0JUmyPbO4p97f
         TS6J/a1uW4r6O1dw4KjqgvMlcIRjHalsP8VoAWlJVFUbGISE5MS3M4iGy9JajM8vELyO
         Goy3cS936KKc0TvgvutPx2EKPaS7fcE0zKaAXTzNYB8MaMwdHMq57GUqysmnaPvAiIcb
         Uy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369443; x=1762974243;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0oPPPAsw+FYjV2RdYT3vlBD7M9XMtEjJDNDkXAtf5Q=;
        b=KZEbBT/Ll4wwS/bVF5CSPxQdpuhtjpHSC1bIsl0ZCLUNNVNESmaWGFNlNRe/9ZelWA
         CP6TISanzTuY3xBT0+pFpmIrgHoUIs+ntclbqStbZ6v9tCgScR4EPo25nplyaUTo9NHk
         bOWiP1iFfMhLJXYe3ZX/2tUOj3n1L0bH/q0FtWEdlsybXlH2SRMfKhsjfG9MeO9KRfW5
         ivMRB4xdAyrIBYGH/Zmu8pNuL9K5WTGVaDddpYY0TXQfOZNBGXEPNqbDtvwqTR7CPfsp
         Pkz2F8bl6OgxqMHXtGgRp5hHDbtl1WLS+2/+OyMU94Sban3RQhTjXcr+aCOQVxL11fEf
         ReTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9KyteQSw8zyIbUxziM6AXSac8Lax5R1NLv5LxtqKvw6inJcWu7ZfJTcl+LIywn+VhE++WvDX7xxHVf6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35+e9sXx0tM4goMQWgK5C3mPdLlMgD2wP2FFEPsHts7keELLe
	PcBF1pugiJH/pdq9zyq3bJYXYvn7HfprBx3d2S3gfg2+JBmeFzqoOpjT
X-Gm-Gg: ASbGncuMkE0T5TWxGh/eenXSy4T8ualudzAuAnYEr1jp4rJdQMistVYKJFSXuOcVrOH
	YeibPqfKx01PVJ+KEgzNAWKI2IDVrpLWI6OxLq1rvLzlptVP3mHMAI++8Z1p1qXtk1gcZbcnlRt
	d9hRCU9p79QrAlM9AXA9JPNRNccsZaW+9REjRg28unTdjrXw5i4YCunDh0lnnKX4OqrUHsprhSS
	bJLWpjdo8l3u3FTJstZXYqXCMc9XOqw823sIrSbOfVxUWIGhSsHoydvVj215Yp7FdWC7OofAUYf
	Nkg2dTDs7fcC/Me+HQe2NCzivbKX7JPIO6dCtxrl2iUAqTfcKsyDsXbigfmvf7oLqoMgUfPRl18
	Snf/dNkj5xLnXUsJh2FrQhBSsM2dvWBPD8cSu2Tjem7AVhe1cvRY3UNJcbevqUMCQ/TY1TTQ/os
	45M2G1RA==
X-Google-Smtp-Source: AGHT+IG91YOfQpBrlRmdeV/ensq1qmlbYvELGbxX5vxy1W6uNgK21OwZ8LoBoKG6gX9FbcpgxH+iug==
X-Received: by 2002:a05:6a21:6d88:b0:34f:7454:b98e with SMTP id adf61e73a8af0-34f839e0358mr5682519637.4.1762369443501;
        Wed, 05 Nov 2025 11:04:03 -0800 (PST)
Received: from [192.168.1.13] ([110.226.177.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7f7569cbsm171826b3a.4.2025.11.05.11.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:04:03 -0800 (PST)
Message-ID: <ecb7b4e7-5006-4642-8807-01b764cd4b2b@gmail.com>
Date: Thu, 6 Nov 2025 00:33:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.dentz@gmail.com, marcel@holtmann.org, ssranevjti@gmail.com,
 syzkaller-bugs@googlegroups.com
References: <690b6df3.050a0220.2e3c35.000a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_unregister_user
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <690b6df3.050a0220.2e3c35.000a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
https://lore.kernel.org/all/20251105142251.101852-1-ssranevjti@gmail.com/T/


