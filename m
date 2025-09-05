Return-Path: <linux-kernel+bounces-803218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6348EB45C47
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83ED9166BA9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED172F7AB0;
	Fri,  5 Sep 2025 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTLjIUb/"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34C2F7AA6;
	Fri,  5 Sep 2025 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085279; cv=none; b=B8761iQQ7x+C5sIkFCvlgNxTLCexU0gWo+pg8xSWAsns877jMnf2BPvcOkqn7dl23dsUrGY7PcLn4zW/NKf1pwf/moA/dWL61mFOe0BARVXAmq+kbaM9QbRv1WjwMk3D+R+LYI/vn3LtaQO1uNBJkB3ACK9LrAP8kqS1lo51MVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085279; c=relaxed/simple;
	bh=XA8wBjJ1clKn2AfE3UBvhH7QRc+5Kz10+OBRfBzjzqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sM93ybUPbQuU1lvVuxEawb2uMg4acHvvj2J83S/NK33Wf9SRnRu8L+XiUyy3NGbmrrotCapzx7P+/BRO/i5pN2ZzOv5Pe5xQyAqyzslujokxWYO2ygtdw1MkhUqEtQw+03r9uOrB7f1RwiTNnttmwcCItueCRTQFVS0ZLjtesnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTLjIUb/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32b863ed6b6so1863802a91.2;
        Fri, 05 Sep 2025 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757085277; x=1757690077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1N+eyXSBtNGbNQzcIgXIkN+yDxQkVZqMTNgo5fVD0zg=;
        b=JTLjIUb/mzSB2HrTGQv5MzsVIW8YZDkJd0C2dfF9qafi183Gm9Y/ZcO2MaA1TB5v+X
         A49qhFBMpUm2LBujzI8RNrXelc8LcqiyejLXlzHpLIcFlsT98Fdf7yxQA/AxQqsrJ8C0
         vnepzDCkNPXu0EPzgc2WL+wEg3V/gKw07l8Qm+1W0QvoDgMb09FdP3+iLryHxSW2btpi
         dPgzWDJAjd6PxXVDB+mRH3aY6MVMy5+eIsUfhByZfySmI663QX3s3W4bDDXu2nrDu1l4
         qwcT+isRQVjoPbfyVuqR2OnKr6Vfm/M/VQuh57V0UXC34jnP0bKZp1tNxukUwqsu3Wa6
         96HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085277; x=1757690077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1N+eyXSBtNGbNQzcIgXIkN+yDxQkVZqMTNgo5fVD0zg=;
        b=HRpnybTGAqyeHN/nwmuqkizYLWB9T1toLGyUNMkjqOk60j5tsztNY+7o2IvkjTkMPy
         wP20IaBF7QZheHlLTiGof5t8S8gtN4HBaERR9sRpYbUAVp8vZL+XXxTTUCxAFmfERZzz
         Q+Ow92jTSAlTs0UXGI28zAYVTPItH0chjZD8r/MQ9HAWBv5tSaE203dHiKH1eSR0yWlR
         diXv/1gFP43Htij8AQqmw9sE6z98eK+fcHPGbBvfMDhyG99s1jmE2jRU1QXKqvCpbq0f
         icbQsMS+rSjX5hzF4RjRz51bRMeBMdKpWqXNnWZE2PYeKIGyBdxoY7sCGk3o5+6UoICH
         pa3g==
X-Forwarded-Encrypted: i=1; AJvYcCWCWBDZm0DjOeAC3/Qvxdq3P1nSFUm3dH1JiWFnUSxRgRINYcP1K1jNSrG6VvD7SJxWusZFfcDM4+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtjH6l8jWqJTL76jBvPnolOiQEAuXoDHbNq+8zgO5Q5ouT7ytc
	4/P418NMhECYA4GOiao3SgxZpFgFofbnfsICj5C6o7mmfClD1RnZc0WvMpilbg==
X-Gm-Gg: ASbGncsh80WHnL1dwYYjQwoyZZP89yZuddzWwH7BnoOT22358i+H9j1jbdk9PvhFFGe
	XEfPAODmpgHeiK8mBDVOZb16jiNqfzQhHWjeEzoQPuhDvHYcuEq0U8kI9hbDNPvtPR6dRuLTDAU
	PFU7EpvsInz/fKayT/iCh3yLWeZupmD3vPpA61wKx1BCZV6KtwCxopS/gF+pVB9/lnc2rEUi92o
	wiVrUIOxN8MQ+rkeWWJTQKnld7ycYS3lVUpdzEAuAjPK/2rhSLkx4Szi4BpI/Ef0BM0/glaAXTq
	FVmiVKw3KMjWP63MsgE1FWILVLixU9uV4G6jG0ew3B77m+ShHNi3dN6YnAH0letYVvOr7YfPKCB
	LFnoXW7+zpE5c+mXrv/wzRODyuVfFv0SfowGuGIJidmgUtMVUwHrm5ZQam0lkcKHiBubMYwZ4aL
	KPx4vBAAVgOhR7sQ==
X-Google-Smtp-Source: AGHT+IGlNub15Hj2oihHbRRmbKvTMHH1iltde6GuBhtp7o3SA0nX0r5XLQD48SC0zSJOJymMpbfCqA==
X-Received: by 2002:a17:90b:518e:b0:32b:5f76:9e29 with SMTP id 98e67ed59e1d1-32b5f76a03amr12235507a91.32.1757085276883;
        Fri, 05 Sep 2025 08:14:36 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b948d5471sm2404144a91.3.2025.09.05.08.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:14:36 -0700 (PDT)
Message-ID: <cd17b8f5-b5f2-4d9a-87af-04ecb2a235ba@gmail.com>
Date: Sat, 6 Sep 2025 00:14:34 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: ja_JP: SubmittingPatches: document the 'Fixes:'
 tag (+example)
To: Akiyoshi Kurita <weibu@redadmin.org>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20250905032729.2284883-1-weibu@redadmin.org>
 <20250905111403.2338934-1-weibu@redadmin.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250905111403.2338934-1-weibu@redadmin.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On Fri,  5 Sep 2025 20:14:03 +0900, Akiyoshi Kurita wrote:
> Sync the ja_JP translation with parts of:
>   - 8401aa1f5997 ("Documentation/SubmittingPatches: describe the Fixes: tag")
>   - 5b5bbb8cc51be ("docs: process: Add an example for creating a fixes tag")

Consistent SHA-1 hash length would look nicer.

> 
> Link: https://lore.kernel.org/all/20250905032729.2284883-1-weibu@redadmin.org/

This link to v1 needs to be under the "---" below.

Wait, do you mean this patch is supposed to be applied on top of v1?

> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> 
> ---
> v2:
>   - Add explanatory paragraphs from 8401aa1f5997 (purpose + stable note)
>   - Keep example and pretty-format from 5b5bbb8cc51be
>  Documentation/translations/ja_JP/SubmittingPatches | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

I think I need to be more clear on what I am expecting.
I'll send a follow-up comment early next week.

Have a nice weekend!

Thanks,
Akira


