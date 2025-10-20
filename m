Return-Path: <linux-kernel+bounces-860578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D60BF0728
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96053A16B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3912A2F6585;
	Mon, 20 Oct 2025 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IrQEmkuO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951A52F5A31
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955017; cv=none; b=r+r8DyP52J0BIU0DQ3l8DTZVkJvUB1GVXooWr63aaQLX32WtQoxu0JOKoAFU8E1bxFbKJdqfaNYin4xirfYBJfdeEy04gliSNT40MefZwP5KnoCF/+2N9Ry3MuShiLPLgpedXRooSdpLXHtN/By6q6XcJT2B+UcX0KNd/bL2TBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955017; c=relaxed/simple;
	bh=irwHczt7jTZu429UGLQiqo0bQAQe6oh+iKytPWQdo9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1jRDB5pJ2g6ZVBLRzuHhYNSh8OUVplNIDf/LfWyE8KwI6xDd/V5tRWCbS5lr7YMII/6Qie3KcozPCS5kpX85Y0VQfWMJc+cLXe6GTOUruJ6bg8DvLjjHyrHR+m7r5VYjOUvbgwQd8CY/ajAAq8eXoklpMlWPvnXOqL7NKQIK5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IrQEmkuO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4711810948aso27187355e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760955014; x=1761559814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIWARefYPtKPfqB0xwmbONWz7j5Ht1YLIPXHwUrFpFA=;
        b=IrQEmkuOxi/GwkN7WZzPHCV9sexq3E+L96YDx3FnOsl1H0EsWzxBSoBXHYy4+PcOaw
         bZrx4g24U6Qh6aKxNKiui8iSaSCwilmuB0O/DR9maelpfVLqbrzxpm9evrP5VOZoIzXg
         imtW3zwYyJYVZQaJaYBBMggL67UuWS1ibg1h7EiCsx6/Sll3IdKHx9YcbL8atDRB/WBO
         Z5iNhKJLnL7tkjd29dQXkeITTqHHkVle2IWeq4HE89yZ9Zc/YnHyW8sUlfgod3TIfOeA
         mf1PosV+Jedpeu/Pt2Mkk1FMonZ1oTDKJLz7fqajl5YbGw0356zOjcsJwkBNuAGE9rbW
         wkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955014; x=1761559814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIWARefYPtKPfqB0xwmbONWz7j5Ht1YLIPXHwUrFpFA=;
        b=hBynkAnZn8pw3dS6tPzcMVZiD3PIIT+gy0Y9PG+UYVgvPZLZHjB++zwYDXBUAs1W/V
         2aiF33QOBW2w9wrbeKAt/DXEpfgqUFDzBz2I6IjNQ34Zt8AlGMVevEsEiCfGibLW8WXr
         6Qj1IPXlHbMKDZjjWQxUdnskosCN6JwQL6rjf8AXRAxpOhfm8msllXOG7jH1BlI0GoHz
         qaSnMbSa3KHJGI5vsjFMy8CZBskYzvJhW6F1oyJaqONaiqQIYSVTQjZG7axNeVFyBmm5
         iCX6eunosZEcYW5zoBME5DWpazzMKhgihn24pDksjoSpOTC30+ul3MObYu+teoPgk77G
         D5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXoS+jbF1DIbxsR5qH+sQnRcooB2KehBDq28PqbfGSGJi9AuPWMuFXO5lVmC3MTCSjwAhhUpv7QJfbyYg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMk2sU/eUV+j1sZkncnFJwW9vljD9QhlK3rwUKnlg5KEhELBIn
	tv8lFsjKgPNuuslUWmbcx607Og1SxUGHP8nl+ongwz2ui20mF02W7HWWG6E6sS4kjJg=
X-Gm-Gg: ASbGncu6g7bOTx/HvU3IrppmlasQZaMdfHuAUuDYQ/dnYHY3VVHSyT3czxPULk8RxTF
	6zQAvxEQHIp9kmo4aS6xb1pyn0AQXNsLAqzNDmnFEkF6RHU7EKOY/IwAFqTRuBL/B3ESLtGJDJH
	vpFYAnE2twic2met80tbb65regQAcV4eZiviDwOCAui5RUoUP1/9F/K3Xz9jr0TMd6k+9bo8JIQ
	bGQ8q8Jb1fRIZgipDosRfJtNBomjHOojkv/q9I5wp4fh1KJ5glV08sNOiRyF2YGevtGnn3hYrv+
	syC6ZEyEOxm6ihelYu5c2BzBsDAqPMYSNNXHuFtw6HXanNXPsMwdV0fJ+wSlBontJ5/R1CRfzdT
	pH4C6ZlRcLQQZtTH4O3U4K0re+H3I3yuftlILldSFIy1Z3EM2n/R9LPI7xb4/s1Ss9rGcN16n22
	+eBvxjjT/N/NWIdMU=
X-Google-Smtp-Source: AGHT+IHrrYifEg1gpWKBK0S8ZIgR8Z+8wANqrcE3Fb9jIBMTS+dnOjVa5aHlyOB7K3bTQJksXWDdXA==
X-Received: by 2002:a05:600c:3b8d:b0:46e:4883:27d with SMTP id 5b1f17b1804b1-4711791c8d3mr99523105e9.30.1760955013820;
        Mon, 20 Oct 2025 03:10:13 -0700 (PDT)
Received: from localhost ([41.210.143.179])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5bab52sm14440788f8f.22.2025.10.20.03.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 03:10:13 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:10:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+2860e75836a08b172755@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] netrom: Prevent race conditions between multiple add
 route
Message-ID: <aPYKgFTIroUhJAJA@stanley.mountain>
References: <68f3fa8a.050a0220.91a22.0433.GAE@google.com>
 <20251020081359.2711482-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020081359.2711482-1-lizhi.xu@windriver.com>

On Mon, Oct 20, 2025 at 04:13:59PM +0800, Lizhi Xu wrote:
> The root cause of the problem is that multiple different tasks initiate
> NETROM_NODE commands to add new routes, there is no lock between them to
> protect the same nr_neigh.
> Task0 may add the nr_neigh.refcount value of 1 on Task1 to routes[2].
> When Task3 executes nr_neigh_put(nr_node->routes[2].neighbour), it will

s/Task3/Task1/

> release the neighbour because its refcount value is 1.
> 

The refcount would be 2 and then drop to zero.  Both nr_neigh_put() and
nr_remove_neigh() drop the refcount.

> In this case, the following situation causes a UAF:
> 
> Task0					Task1
> =====					=====
> nr_add_node()
> nr_neigh_get_dev()			nr_add_node()
> 					nr_node->routes[2].neighbour->count--

Does this line really matter in terms of the use after free?

> 					nr_neigh_put(nr_node->routes[2].neighbour);
> 					nr_remove_neigh(nr_node->routes[2].neighbour)
> nr_node->routes[2].neighbour = nr_neigh
> nr_neigh_hold(nr_neigh);


This chart is confusing.  It says that that the nr_neigh_hold() is the use
after free.  But we called nr_remove_neigh(nr_node->routes[2].neighbour)
before we assigned nr_node->routes[2].neighbour = nr_neigh...

The sysbot report says that the free happens on:

	r_neigh_put(nr_node->routes[2].neighbour);

and the use after free happens on the next line:

	if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)

Which does suggest that somewhere the refcount is 1 when it should be
at least 2...  It could be that two threads call nr_neigh_put() at
basically the same time, but that doesn't make sense either because
we're holding the nr_node_lock(nr_node)...

regards,
dan carpenter


