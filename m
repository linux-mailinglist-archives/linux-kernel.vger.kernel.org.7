Return-Path: <linux-kernel+bounces-754780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C1EB19CAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28158177CD7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FA122D4C0;
	Mon,  4 Aug 2025 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="hUioNLTX"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865AA235354
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754292639; cv=none; b=t9/dBZY2viv+20haF+9OT5UQnpK0NmKUgEkm4E1xkwrN8VUT1ftZH6r3Z9SbfImONpP9jol6VMziiTgC8r/6s7PaEtMKmtqLMykzCm+oCxvh7yvl39axJr4bDR0v6rMhBYiFbBCSMn2aFplClyIyJ/scLp2rdP/uIBCIV7S4J5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754292639; c=relaxed/simple;
	bh=ZfF8KXnZqTsQpG9TeCfG/W/L8FiAW6ilMlUScXzXyC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Azh/GSTAYA42D+Hn0rxmRHzrUntKko09fDRDtHEX+Hr38UmTuBVNmXP1zgr+MlXPeds/jclp3xmT0rK2Iorh/z9vel/Mejk/PSH09JgopNfxt7nhjMFNA0OAuXwIEuL8IF6d5M/Lbz5qUVX9DZLDiO+56DJ+dMHhfqFWR0QOoqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=hUioNLTX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-458b2d9dba5so14107785e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 00:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1754292635; x=1754897435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYEoYYxDw1+do/dWl1i2qeNhKyKoyKkuuBdx/RYptEM=;
        b=hUioNLTXuogphQzWHHl65J7/Qm8gaUTnXMUDOjpPGEq8NpDNSc091NtO01BDhMkwm3
         8fIZiFZXC4MWHYtR4fg0eyO6J9sDElNeLHJUULyp8iYid5YwSvmYPs/w+PIELEC+3rw4
         WC3tGVXAGSeXjwKLYXA4kelQNUk7jOVeMllHB6YeOhetiIWQPxsNNR3rRXSYq5joI1b/
         rpiTOxQMwO3E4Ff2z4sViocZZ7ALYnw+v10UUogJV23tyCpTI/jkxjHSkAAvHZekVyUF
         bqbLH/UjLD67JJpUktq3AAGkkQlxLsdaohJxEBKl8hjQGFp6HhW01XGmaxVBel9ywLbz
         dV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754292635; x=1754897435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYEoYYxDw1+do/dWl1i2qeNhKyKoyKkuuBdx/RYptEM=;
        b=JuWuZJKsmVzFOVNRhWkbdWo+ybhy4E6qnyIt2BwYmU1U4DjiI0kXzTLpc5sgAA4e/D
         0kROcPquWMJjCu+DpC8783V82gpYeu1oMthSSjinRlD15Bg2Fa4kqMPSkHAdw16ZCSOL
         aP+1Pvqt5v0gVDx/njYOqE5/mlABB8CHbmyhi1jxCXdIzpsg3ICqRnVEJeuF1QbNs3r8
         n/odKBjT7zZCM8N8QlDxsaQa2Ggnxrrp/1QAmsbvsNSgHqxo4OekpCl/6b3MlUuVsgJt
         D7tbuJnrYpX+Q4jqB/WQI8obI9spNOA2PV4yu3jUPbkre21M2u/qR6VzD6ztHGos8I9a
         e52w==
X-Forwarded-Encrypted: i=1; AJvYcCWK2F6X4OzlvAdg7tbt7k4pg3siAeqxddxOzlUxVaq8pgv1bLxP1GSNCXrTvUlYmx7sj7qDh7EUMFypwwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjmkVfP7nViWaEQxHCf4T9soWOlA8h1kZYUF6nwWJwovAfzZ/Z
	zHon34Uk3mqbbfTtMgd5qHiWuPs4Bs96OTfBuUU+Ozmc07e/iSok1jFhVSWgXLoKmBo=
X-Gm-Gg: ASbGnctoAhoOQ3bYzEmqD7z2jzjKMVj64zsCMQAFLmT/Wdv9rJIqknW9fIEQJxD90Yq
	ChnY6LHSuTXY99Cznkn2zqSVPEIFBAvFwDyH5BqXuS42d0FBCFE0MWSW2hX6DajcZlo0i6ZStf0
	RE5pB8IdCMGEYRfJ/OEEr+XUl05D7kWI5rabOqouBHnsCrhRrZcz03KYA7v24aujzKmG70dXdVj
	9YzovVlIswR9LmDWYJCluyk3mz/ActBsgW0v24yH1p3zbCikZpbDw9rYQaUnKagHcs7CbJQXJwV
	9OaChySf76eMxmhSZJrr6ffy4dhN/rxfEoRCbbceJfYQnf4JLU+N3PoQizUHzxpqzKOLSpSPtOG
	G751OsyTic+mwiuN94D6MXdVb+sOcpaPDzk2NfeSfQ4RYrKZ86vfMXHg=
X-Google-Smtp-Source: AGHT+IEmWBuNi3LA07Xk8K9TgjMG4h792OkgcNY8un3jy16qvwG56ZKmK+6DiUdn+hjsybokaIqwwQ==
X-Received: by 2002:a05:600c:35c6:b0:459:d709:e5cf with SMTP id 5b1f17b1804b1-459d709e8b1mr26603715e9.3.1754292634673;
        Mon, 04 Aug 2025 00:30:34 -0700 (PDT)
Received: from [10.115.255.165] ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4818c1sm14361820f8f.65.2025.08.04.00.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 00:30:34 -0700 (PDT)
Message-ID: <8114ae51-a238-40d3-9ecd-70e23abae28b@sigma-star.at>
Date: Mon, 4 Aug 2025 09:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-6.16/fs/jffs2/readinode.c:189: loop can never finish
To: Zhihao Cheng <chengzhihao1@huawei.com>,
 David Binderman <dcb314@hotmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "richard@nod.at"
 <richard@nod.at>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <AS8PR02MB10217F68E5D37ECD491495E669C23A@AS8PR02MB10217.eurprd02.prod.outlook.com>
 <df923d94-92ee-f824-01e2-21e6ed3d593c@huawei.com>
Content-Language: en-US
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
In-Reply-To: <df923d94-92ee-f824-01e2-21e6ed3d593c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/4/25 9:10 AM, Zhihao Cheng wrote:
> 
> The 'next != NULL' is also a condition for the loop, this snippet of code finds a leaf node in 'tn_root'.

Yes, this is a classic tree traversal. Assuming the tree isn't
broken, the loop eventually terminates when it runs of a leaf.

The real issue with this code is that this is the *only* exit
condition of the loop. The traversal loop always branches until
it hits a leaf and the function then returns NULL. I'm pretty
sure this might not be the intended behavior.

Greetings,

David


