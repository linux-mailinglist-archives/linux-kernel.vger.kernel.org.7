Return-Path: <linux-kernel+bounces-735154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73859B08B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF1F3AC6C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116B0262FC2;
	Thu, 17 Jul 2025 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uk7DvW0W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A8F29ACE5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752750644; cv=none; b=djKqTVLX/l+vJqWGM8PV0Ls7HETWJU1PXJAuijcOZnnLu1DUah/DutkifDErNU+xewzjbIxrkBJjhiSo6PnFmq0P+N5HhMkfr2TVFGIewNcA7hZysFD2zwWdMKQxM4u6yB1sv5XNDf9FSnDwHi81BcyJUsXJzOdjqxzWHC21D3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752750644; c=relaxed/simple;
	bh=o9DguUFd9ulRr/nGZ83LjaBmOxL8fPbmtWacXgwjtWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIO9nUA3an5TKQ51sioX1LkyK4d/jxDiTNzPucD2fIIhqpsbkD0vAsFo8Z6Py1ap6YO3nTr8h9T5utqPrSaZeN92Nd5T5vDuOIaA+OKdb93KFZexRqYrVvbAzK39OAtulfW5238M+e9bfIYnEir1cwks3ejYXKvJImfFaSaH3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uk7DvW0W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752750639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcuwFP2i4FlUn9FFKBy/90wO5gqfwimly/CV8vM4gi8=;
	b=Uk7DvW0WXRbnzgQjcf15O3dOvVLd64kHLhr1+Sxs3MuOzKwrLtVN5EOeQutqlhXpp7Himv
	psUZVI4aqh6fFO4sshAq+qNufi9lJrW55exaklnQMh9XpXRYARi0Zb1NKwerJtHRbLPTz7
	ThsXK3n9fZOh6Aw0XNCAV3kbD1RVaqs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-aOydxhigMM-C-LD7YaFGWg-1; Thu, 17 Jul 2025 07:10:37 -0400
X-MC-Unique: aOydxhigMM-C-LD7YaFGWg-1
X-Mimecast-MFC-AGG-ID: aOydxhigMM-C-LD7YaFGWg_1752750633
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-454dee17a91so6935605e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752750629; x=1753355429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcuwFP2i4FlUn9FFKBy/90wO5gqfwimly/CV8vM4gi8=;
        b=Q03qKeKl2fDdWlu7Kw3VQKTxKNvAaoO174YYZ6n8qvQ9sd3a+PQn8UzXR07hpH04LH
         dTAPCoWoHJtuJifuHCa6nLH/Di0vtgoYAHQRegkhsHJUd58fs034nHA1eSRE/LBsri/5
         6T55jrzGKXaxAnhtRy99mAC0qapvMEEi9el2i9UBTjmSi5KrGC4nLHLpr7xXwSmZv3wS
         AuYJaixhBJMvA1yoksees1/URYDY4Z95BNl0G5JDVSYcoqeTJ+tKfqiVPMgbp9GhZyfZ
         dcO0swJh4FghYa8FuFDuT7dYQTl55fCY2nbR2cFii4NObs/dwuZ4ZaiR0d0ZjFZH3Xj8
         GO2A==
X-Forwarded-Encrypted: i=1; AJvYcCVB3Fifi02kiz9R+d8d1y9HBYnuoM9c0gd65xp0mL6cgTikroF/8N+rwLN5DOyXqZMr7Smxzc856JqzgcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1FIe8SArR0dz14B/Mjcyk34IK0tZSvM7jTCHAzWorrlXUMnG+
	HMyjf/2gGfBL/91ZokzTfuiSWN1t+bldDb8U/VeZq5IyEZZMyF0RM+3qVXPF/FpS/lushZ1NuPa
	lnOBjLXpO1H8Kd8270UACS5Snj3ckjfNZ/c2vJqm+iq6WS0Fo3FfaoLZuvSgSt1qGbw==
X-Gm-Gg: ASbGncsNA4ztb5Lf/KeHGSglm6rh7kW/ZSNDowWsP2n5iXB1ZVEfLF7HlfjrCBS7EUm
	/OHJNho+1qpLeMP2MT803IKJR/KbZzRThfEi6CNwXecC/61WP0RSSvzSZfwhuisnlI1zcbIFcR0
	Ps2kc0ijud4c7wYXWze80L0WNs9nZZaaEvSASG82r5j0MjVNPEaUmGyCOJhY6Zjv3hOAJaabIiX
	IWJat92sLfX5yjIyT+SSVhkZY39IBXutYbmZLXT8ZGrhn/hRQYLle5xfhr9x/TQgaZQ8cAazvjU
	XzvZrI3/zbCLLkUswyrcQQiods6En9DDgcbDzDdBy2Du95vPPEK1XKyXZpTIZKNHBYmoLowSh3N
	AL8SJnBzb5Yc=
X-Received: by 2002:a05:600c:3b11:b0:456:1dd9:943 with SMTP id 5b1f17b1804b1-4562e364923mr61991225e9.3.1752750628843;
        Thu, 17 Jul 2025 04:10:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxXKe1dFz2jXXAF/w6N+sF1RD95sU2Z+R0uSK0mMsz4eDz0ygxowQ/EwGBBRV415p8rq+tCA==
X-Received: by 2002:a05:600c:3b11:b0:456:1dd9:943 with SMTP id 5b1f17b1804b1-4562e364923mr61990895e9.3.1752750628413;
        Thu, 17 Jul 2025 04:10:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45627898725sm53301605e9.1.2025.07.17.04.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:10:27 -0700 (PDT)
Message-ID: <0f6e9770-1c79-418e-9135-df692f495a91@redhat.com>
Date: Thu, 17 Jul 2025 13:10:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: skmsg: fix NULL pointer dereference in
 sk_msg_recvmsg()
To: Pranav Tyagi <pranav.tyagi03@gmail.com>, john.fastabend@gmail.com,
 jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, ast@kernel.org, cong.wang@bytedance.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com
References: <20250715081158.7651-1-pranav.tyagi03@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250715081158.7651-1-pranav.tyagi03@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 10:11 AM, Pranav Tyagi wrote:
> A NULL page from sg_page() in sk_msg_recvmsg() can reach
> __kmap_local_page_prot() and crash the kernel. Add a check for the page
> before calling copy_page_to_iter() and fail early with -EFAULT to
> prevent the crash.

Interesting. I thought the sge in this case are build from the kernel, I
did not expect a null page to be possible. Can you describe in the
commit message how such bad sges are created?

> 
> Reported-by: syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b18872ea9631b5dcef3b
> Fixes: 2bc793e3272a ("skmsg: Extract __tcp_bpf_recvmsg() and tcp_bpf_wait_data()")
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>

Does not apply to net. Please rebase and resend, adding the target tree
in the subj prefix and specifying a revision number.

Thanks,

Paolo


