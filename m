Return-Path: <linux-kernel+bounces-856963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A1BE58C7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48F1A50476A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F276F2E283E;
	Thu, 16 Oct 2025 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxI0vA5g"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4B2DF3FD
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649196; cv=none; b=VzeOnVGMshsd3FuMPWGykQbUpR7INata8aJABWPu2GdWH2tNZpcEeLV0065e3qFpGq5Q3oKzScYri162Zu4zN9xw+Ate0iYKY8rSm5w+B+4HLB8aWHwSv1HbrNL7XUOdPAwoZqDcl3U6YDPysMswgJf5XnEep0Dg89AFUrcUMm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649196; c=relaxed/simple;
	bh=qNBlNBSdH2eGWHunmbbGqoCYPRw4QiXEAX4o8mPtPpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChUFWjSRuPerJcvJDQSvLlI3bdni3pegxj0gAe9hQDnL7SuCKovdmfnwcz2oo75b9UI5W2iOoo9zIYOJzCPXazDwDOZW+TopHnCPRysLpwHJVvZvnBtQeoDdBuKJ1Mev36Ju8LPhHsMJ8jYoFWxbP86yLxIe5wshUB3T9FYRqr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxI0vA5g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e542196c7so15820555e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760649193; x=1761253993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7dC9s7DUHDfq+JM4myzAQqHd029NncsnmY1lMtLvU4=;
        b=OxI0vA5gV1yiZiNhlPDh5o1GbFsyDLcwhK0yR9l9hjB73LoeVLBf5SZggK2vOmDAYh
         kym2hDXC6roA2s/jFXGu/ZSAmCr3oac4VMPEY3M1L5jIj9uslSbRNJs6317Wx499zykk
         GEnk9kHdcJWcKlFU6ulN6rQQuMQVKsMggBOueLGJrcrBFRz8lEg8onV6EAKuIGv0PKbY
         s2G4RdgJbM+MHdZLYuevUrFXlLb0NLfB7UfZhq5XGauYqS53vdgflBiTWhF+4XPngREm
         FWI6q+DDx40Wguu+nHNoV9L/j2EcLYCfT5kNbUjZYMNjOfX0VHHVM2D2V7Wc7ZOTI/nt
         tIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649193; x=1761253993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7dC9s7DUHDfq+JM4myzAQqHd029NncsnmY1lMtLvU4=;
        b=s/8xxO0WBg4831W5dZXXg1kPgpIacNWD19HjMqg5TL+TW1aaUxQVckyK6Nd8o/HHdF
         N2VaOUfeOFhQUGAulrGKpKQdN6IdjSfTWfAivmeqST9Cu7+c1iyvoT7CzLOxG0mt8z0j
         pgRcW3LDRGno6WbnSjlZWpkOZwmzPzXCu5nav3otpsZD5I5gADNv8aJV9qSCX129eqCf
         SPPkqcEvNW1qX3Ct3vCkt+hey2s6yozAMMwdqfCs9uiTj3gbHZaS/LI78wCuXzNsy+DW
         TG++TNhvlV7KLBWOXHExrD6KP3jqI7qhFY1OwciCFXrtmlAzltazH65+TCRrPi3zevha
         NgPw==
X-Forwarded-Encrypted: i=1; AJvYcCWPC7FLfVd9dSCZQiEk4/J3cTQc2drAYVM7DLD9zTdpL8nzLqAIrYteA2rqeo48aOQyby4Lvoaa+fzpCwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxIp8UoHKi/6Ux9qDbWlCzqkpwPt3dGFRmBacnoKGPJQXQK44
	lF+m31Vc0gSqDh3YZBKTPzhaQe2uEwBdGuSGSBsApPIU3hvVWvkbgZ9p
X-Gm-Gg: ASbGncviEhW//8OGQ21b0AhqZs5utvMp/9pgdz9qlUstDD2/jXEIZExXfbGYWNTkwv8
	9P1icXB6feVamPwNBmTBLWMg/BEmjjOhjDFrIp2pO4PBPWxgJ0fonGQdfL+s2cm9i7hdBnUEo/i
	1o6t0NeObLC8viO5x8c3c/tT6BsyhbCltUgn5BPN5SxHF9iYdw8mFL41/lx+BG6FYoeW61HP/Ss
	q77T8Dx9xn4rTn4MJN9Lc/TMAEJlTotXYJ/HuZv3F2nGWWaj0DXkJepylFOXwemigUzK0ZDQppr
	oGF/qlfGsKyDAfiCNQFJHF5orCOAtEsEeU2BGUJ1aide281B0HG6+H6MGwYLRjqyzWtbkOZumtk
	lQ7UXQamTZjWaDQdkPyQGtcG9n/KFsCyW/iXD7C1uSpuMX6C++A4daK/TF1bmlu3Jx53tKbwBlp
	BBKym7BIw450qbZnI7a/BHdwiXLR7bApX2ROO774ax5eyhRdBc+Ee59Y5iUuoNhKcBulJlZw9cH
	0Ky/w==
X-Google-Smtp-Source: AGHT+IHKPJSTI0DmvT06VL4xwoZPAZid6jDY8psvVG06n9vCvu/0Q/oxZW5QmJcTU6PqNg2HD3zBYg==
X-Received: by 2002:a05:6000:41f7:b0:427:548:6e3b with SMTP id ffacd0b85a97d-42705486e44mr815017f8f.13.1760649192715;
        Thu, 16 Oct 2025 14:13:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:acc:bb60:756b:64e3:20ef:1d08? ([2a01:e0a:acc:bb60:756b:64e3:20ef:1d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf6b4sm37077374f8f.25.2025.10.16.14.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 14:13:12 -0700 (PDT)
Message-ID: <21944b18-ac36-4acd-9d36-cc05579acc0d@gmail.com>
Date: Thu, 16 Oct 2025 23:13:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nova-core: Solve mentions of `CoherentAllocation`
 improvements [COHA]
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org
References: <20251015194936.121586-1-delcastillodelarosadaniel@gmail.com>
 <409f2f03-2bc2-4cb8-9ca7-4e30f82077ff@kernel.org>
Content-Language: en-US
From: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
In-Reply-To: <409f2f03-2bc2-4cb8-9ca7-4e30f82077ff@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Danilo,

On 10/15/25 22:04, Danilo Krummrich wrote:
> Hi Daniel,
> 
> On 10/15/25 9:49 PM, Daniel del Castillo wrote:
>> This patch solves the existing mentions of COHA, a task
>> in the Nova task list about improving the `CoherentAllocation` API.
>> I confirmed by talking to Alexandre Courbot, that the reading/writing
>> methods in `CoherentAllocation` can never be safe, so
>> this patch doesn't actually change `CoherentAllocation`, but rather
>> tries to solve the existing references to [COHA].
> 
> This patch seems to address two different TODOs. Please split up the patch
> accordingly.

Sorry, I thought it was okay as they were part of the same task. Will do.

Thanks for the other comments as well, I'll apply them and send a new
version soon.

Cheers,
Daniel


