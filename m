Return-Path: <linux-kernel+bounces-744539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE635B10E47
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30DD07A4CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC86E2E9723;
	Thu, 24 Jul 2025 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnV/xDzd"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01899255240;
	Thu, 24 Jul 2025 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369502; cv=none; b=kRFhm9i6dAX0Jt7qRAPP833hKEOcXyL09ZYk6Q/1g180yAWQ2OQSUC43n83Yn+V3X8AQSdpD4pav8hpK2EyTyO4pFpELoXcz7g3AW7TPzc1ht4QL5AnlTDwss6sDFHylqPYUe7VwxbxSSWeGkbqSD0btuWPMEx/6siWhVa0Sp6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369502; c=relaxed/simple;
	bh=ktDkf4ooHaeISTi4kJC16b6ncEGl//z4yaOeiADDyeY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oL5QcDf9vsilhJ/9a4+eU9z4TQdab46K3xKSlMa8ZHskBh3yYegAVAYtcWDz2x/4dHAnieDLx4jn0nfI2DEY7wd5+w+tvUetPzPiAAM3prS9naUFwkQbKX9OjjH2VNyIBJ5BpM64kvs9PJ393IG+8JAcJ3Q50ST7cc7AMB1ujR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnV/xDzd; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so1530509a12.0;
        Thu, 24 Jul 2025 08:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753369498; x=1753974298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VJi2cu4pu/Zp2p6DZkzJlLQR50cjtH6rzu4mo7OPz4=;
        b=HnV/xDzdPSjgz6XW7rmiOQOgp7Rx5gugtslpL49IxAA7zeSD6f0ls1TbCZX6JrvBAE
         o4gnMvMuTfpay01qmM5iHzMCGCY8c1/48utdShaEZ62So04joEiK9SW2V2TE1+DdGFG/
         f7jrbjz8lNLVyRSRF0dFFCU5RSUOXRWyykItBaq/jSJiMeXWA6mdZ7K4wuixK7ljfQmj
         1NN7owO0RpG2klSQ0X1mRKcJy5vyL4HB99zCf1yO24p7NsiQ1ZgoIHjBpxsYwXipeGvR
         bQ76sKBHS3LbKNztOQBK2TPpgCOfugrvm69H79AP8XMkUjAU8iXV6n0Lib/E1Gu6x1Og
         /Q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753369498; x=1753974298;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VJi2cu4pu/Zp2p6DZkzJlLQR50cjtH6rzu4mo7OPz4=;
        b=YYW8MuO0vAoo+QmqKVU+vt+P/yJTI2XY4Yv0PUKbLDdluixqZkv4WulA25JMCI4XYk
         kYcm8ZPeBtuexD1FDr/5sIxyjnHHGVTH6lDBGfvC+JxdjFY/QvHYGXlEoKqEvnVVhRaa
         FVg2CJEN/+jeu/2rKTIinvmpMtH/cYURHYXK9OTheaW7+ovbAWQaQBWfpXV/fL30Qh63
         fPN56fhFg46N3rE2WwTmCHpDnLu5fLrHM4iAIxcv3FJFP6n2DNOXNU9oiwCmgMpNxXUa
         IatBqHz+AkFRUCw++LEcXDzYM1zMXdugqsXL5awni1ccHgsG2xh3vZGcvyWXVlvjORic
         x7dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGoRAJiokQTnH8fjoiJRYnm0V5e2rBtqU4QXHFBflF0LfK50yODGmAXlBv3b5OW0h2SlE6AflIv5N7@vger.kernel.org, AJvYcCUidaJR+AZnE6igZbIyQQ8+CrP1E65j1zreHo8o+LEQsAwUCciKOpEPKeIFnFIVjAMz8cxFd2tntnw=@vger.kernel.org, AJvYcCVKKCN+NIBwP70CIR2YxkaQ8hm40NJkrfXX8yoJXQlR45mjL0pAQiI5wBIP6gALVmZMtn0PCm8n28WoEyd9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywosedo83UzqotlcDmhUbycX8ZTgGdXg5Ct/fkfWDC0I4UjClhV
	tAgsxEcVkdkEt78ME0UWQPK8J5Rmj1fRPDWEZU9qW2nXpBZ3aa5BEGvE
X-Gm-Gg: ASbGnctIKB9SvgmqNmFbNq9YylieDl9aOBO/ZjlQuLh+QVrR7e6qlFlYxRrwABGu+Ja
	aMNun7khZbJDVOEvN9+14kLu4ghgroMmxz0foeBIMeJ7wEk7acfXWB+SwuTBnCYwxfVCCcm736n
	1nKvDsf4qtJ47ZStTGmPwPmdnr8e/4+cQ/PRkateGamTGCZXL1EX/2cteK6BycreyROnAS7xiUp
	Jd7WLrTja9mQGo7bC2szRwmvLBGgSr0Yh57yJcpJ744Y2/mnPGbpkqhQtsbNAgCW6JMZBqrmBVY
	v1zXL/xJnpsDa/xKQUtn6wBJMBhDYHofg4/aV1wgd7QT7wYeXQgR+f54sN8/Z4B56/4alY3B+AK
	tmY3ZO7jjo3VJMJL8QpY1UeNcrGAnh7PU4BUMFfL8PFs/aCLoWxmd+8bPBUCbn77g2lFE
X-Google-Smtp-Source: AGHT+IH9cx1cvRD3IQY4uOu1d+OFFXg/UeSuSp7C6i2Hu8/kishvHcv8Nd2SqaZW2O0pJXbOH+sNHw==
X-Received: by 2002:a17:903:46c4:b0:234:d292:be95 with SMTP id d9443c01a7336-23f981b6379mr104279395ad.42.1753369498157;
        Thu, 24 Jul 2025 08:04:58 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc73dsm17772735ad.89.2025.07.24.08.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 08:04:57 -0700 (PDT)
Message-ID: <8a88e6e7-c1f8-4ec7-87d4-c64714085a69@gmail.com>
Date: Fri, 25 Jul 2025 00:04:54 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: hendrik.hamerlinck@hammernet.be
Cc: apw@canonical.com, corbet@lwn.net, dwaipayanray1@gmail.com,
 joe@perches.com, linux-doc@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 lukas.bulwahn@gmail.com, skhan@linuxfoundation.org, workflows@vger.kernel.org
References: <20250724072032.118554-1-hendrik.hamerlinck@hammernet.be>
Subject: Re: [PATCH] checkpatch: validate commit tag ordering
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250724072032.118554-1-hendrik.hamerlinck@hammernet.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On Thu, 24 Jul 2025 09:20:32 +0200, Hendrik Hamerlinck wrote:
> Modified the checkpatch script to ensure that commit tags (e.g.,
> Signed-off-by, Reviewed-by, Acked-by, Tested-by, etc.) appear in the
> correct order according to kernel conventions [1].
> 
> checkpatch.pl will now emit a BAD_TAG_ORDER warning when tags are out of
> the expected sequence. Multiple tags of the same type are allowed, but
> they must also follow the order. 'Link:' tags in the changelog are still
> allowed before the tag sequence begins, but once the sequence has started,
> any 'Link:' tags must follow the ordered commit tags. 
> 
> Link: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#ordering-of-commit-tags # [1]
>

So, you are citing ordering rules specific to the "tip" tree.

I don't think there is any wider consensus with regard to such strict
rules.

I have to say that your change will make a lot of unneeded noise for
most contributors.

If such warnings are only shown when the user opted in to the tip rule,
say, by using a "--tip" flag or something, they might be helpful.

BR, Akira

> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> ---
>  Documentation/dev-tools/checkpatch.rst |  6 ++++
>  scripts/checkpatch.pl                  | 40 ++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
[...]


