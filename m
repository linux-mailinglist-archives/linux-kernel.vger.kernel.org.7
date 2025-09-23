Return-Path: <linux-kernel+bounces-828494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B40B94B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4376B1749BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A93130FC27;
	Tue, 23 Sep 2025 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwi3bGID"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F28126E717
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611518; cv=none; b=NDlb5QPjlmXQGoYTg658V43SzTOUOGEFnAySyv0iToIC9lrpZWkrL3GVGTEJr5NdOVpkQ6iz18cpK5fD72qdO0nidgWppuxEmd4LRDaSk13AwKcrogNoD8pIuCwpoat64/uW+MEFk125nJgnZFRtqmCsS7p8lLvVCZv/LyP5HSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611518; c=relaxed/simple;
	bh=7iONL8v6z0oTB+q7lJGr39cvG4XyvJ1rttD84Eu2h2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK+o8h3ywIcIEvCg380ZHvVqZEqGGhV+nbtVgz4zJnEl5wgk/lz3F5f3J9pzozqxkom5f47XLEpgNF/tV7dN6hCjPQffpKsFLlDkmP/65CMxRHw0MNJ6vWOja72GF5Nn6h6xhlp6C7wbq63wVgLr/hHWaiHbNQwftk98eqIy9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vwi3bGID; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e21249891so1013705e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758611515; x=1759216315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kF/vwsek+TX0jz1XNJrsBzbivVnVQSsSlm9v5mtUJOI=;
        b=vwi3bGIDGziXrwFv1nkTIk5cUht1UKp+3UKXSHHPehT0CEmJN3hnho7TKLSDVnPS9u
         rOXHf83ZXVdGswYFCjAgNqrfm1xmB/+UwbqbFtPjMIYFITJ5wtC5IwQmsmvfyfxs3rig
         yRaZ+5HLIeSGHiG1w9j2HQpLqo63qWbsbziPS0QJnmrqLonaEI44bfaug+LbVtPfvzpQ
         W5SQ0+g6e5xrISreJtIQFnOpknmVeQT4Gw2vBc8Bwr95AHDj+8N3868EQ1xi1phgBV5t
         kav50VMNIHh+ixhvu/ny+uivSLC3s3zevng5G4LXjUGYQDCCowZpDtyfTlU/S+sGPAbl
         kgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758611515; x=1759216315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF/vwsek+TX0jz1XNJrsBzbivVnVQSsSlm9v5mtUJOI=;
        b=Fr3Sb/KPwyoX9UlzdhXIZBPEVuB/AuzW4t67BjIl9D8aiuR1xqcaas4dAElLRiWY7c
         hvn2HsBEggHJI6ldkrCD1hedy68GitisdEz71pnZZMgYtY3wF/jUiy/ue357FWnbq6q0
         XGQ6drcPjskM+R4X6ffKyuyH24lly5RDqs5Mdx8DIak267On8rPItwGgJWmNKIJZ54tT
         QOiIVzmuC6I0L5pDR5EPpeJc2tpZC80mU2Go/6hbi3Q1m76lMtFNt0iw7zdruXWCiUAM
         /MaA0w/u/C5rXuslYcfhg2zx8eVETyXpxIpSfCiAUGQ+vzBaH79p42saF4v52rbmaj8P
         c0fg==
X-Forwarded-Encrypted: i=1; AJvYcCW8VDWxi4weXQhHS1lh9QWvLseA+pRgPnUmtpgdhSisPO3bH2VmkCTe+KSoellmfiO3CC5MrRAT8HOKxjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYZawjD6kiCixzUsgbE82Q6sQOzn1fGVy2O/gKXPO1pmrDkx2C
	2/1Gr9J+Eovvpgr2QeR6Yg0g3QNkWxUo3girj+SjBCLm2bGiqTUAUKpy4F66SvzowNU=
X-Gm-Gg: ASbGncvXqImuSE5M6DfdXb6Zfz1k4XU8eWpaxq9Y+5ZuPbjOn6l5ZIe4uhpIGsgX0GS
	GqT92gKPzN7Od2ZzKFoXJXC4MYd2CyjPz3PTeCF4yCyuKHVkNDXRp671lDqhG/cFkB1VZ3ClW1x
	X3APkfm08ygcuVimhHlL8uvafnrKPWrUZniO7SYZRibI2ZHC4DMpE2iQI0V6+f6wCTWOe9/nMlR
	zlfTnAxwk9p+8avGRy0okeosmbSvSmA5R5ZQBTCbRwtoqNXTJwiBYITxZiSpkwIG2KFsIUlBSdW
	m8vyJZJup8PmRBTQcNsQYHmWtL8eMDVa+YFjAdcVMqYMTJ0R4yYQjSHTQx+o+Xwx16j7KnF2Hn2
	ZRhvLBqltJgf1UW30+rH+bv8RGRF5
X-Google-Smtp-Source: AGHT+IETXRK4dmUcU1OY//+IY9VX2wp9AdGkgYqyjEDbbOe16hsBsbPJkcHHfAihkfG9eCqRmXw0Xg==
X-Received: by 2002:a05:600c:3ba9:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-46e1f86b296mr11638615e9.17.1758611514684;
        Tue, 23 Sep 2025 00:11:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f527d6cdsm261777615e9.12.2025.09.23.00.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 00:11:53 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:11:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] 6pack: drop redundant locking and refcounting
Message-ID: <aNJINihPJop9s7IR@stanley.mountain>
References: <20250923060706.10232-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923060706.10232-1-dqfext@gmail.com>

On Tue, Sep 23, 2025 at 02:07:06PM +0800, Qingfang Deng wrote:
> The TTY layer already serializes line discipline operations with
> tty->ldisc_sem, so the extra disc_data_lock and refcnt in 6pack
> are unnecessary.
> 
> Removing them simplifies the code and also resolves a lockdep warning
> reported by syzbot. The warning did not indicate a real deadlock, since
> the write-side lock was only taken in process context with hardirqs
> disabled.
> 
> Reported-by: syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

checkpatch says:

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report

Which is relevant here because Google has apparently deleted their
search button and is only displaying the AI button.  "The email address
syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com is an automated
sender used by ..."  Thanks, AI!  I can still press enter to do a Google
search but there are no results with syzbot ID.

I can't find a search button on the syzbot website.

Ah.  Let's check lore.  Hooray!  How did we ever survive before lore?
https://lore.kernel.org/all/000000000000e8231f0601095c8e@google.com/

Please add the Closes tag and resend.  Otherwise it looks good.  Thanks!

This code was copy and pasted from drivers/net/ppp/ppp_synctty.c btw so
that's a similar thing if anyone wants to fix that.

KTODO: remove sp_get/put() from ppp_synctty.c

regards,
dan carpenter



